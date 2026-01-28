struct Player
    hp::Int
    armor::Int
    mana::Int
end

struct Boss 
    hp::Int
    damage::Int
end

ans = 100000 

function turn(p::Player, b::Boss, effects::Dict{String, Int}, is_player_turn::Bool, cost::Int)
    global ans

    if cost >= ans
        return
    end

    new_p_hp, new_p_mana, new_p_armor = p.hp, p.mana, 0
    new_b_hp = b.hp
    next_effects = copy(effects)

    for (name, duration) in effects 
        if duration > 0
            if name == "Shield"
                new_p_armor = 7
            elseif name == "Poison"
                new_b_hp -= 3
            elseif name == "Recharge"
                new_p_mana += 101
            end
            next_effects[name] -= 1
            if next_effects[name] == 0
                delete!(next_effects, name)
            end
        end
    end
    if new_b_hp <= 0
        ans = min(ans, cost)
        return
    end

    if is_player_turn
        spells = [("Magic Missile", 53), ("Drain", 73), ("Shield", 113), ("Poison", 173), ("Recharge", 229)]
        
        can_cast = false
        for (name, price) in spells
            if new_p_mana >= price && !haskey(next_effects, name)
                can_cast = true
                
                tmp_p_hp, tmp_p_mana = new_p_hp, new_p_mana - price
                tmp_b_hp = new_b_hp
                tmp_effects = copy(next_effects)

                if name == "Magic Missile"
                    tmp_b_hp -= 4
                elseif name == "Drain"
                    tmp_b_hp -= 2
                    tmp_p_hp += 2
                elseif name == "Shield"
                    tmp_effects["Shield"] = 6
                elseif name == "Poison"
                    tmp_effects["Poison"] = 6
                elseif name == "Recharge"
                    tmp_effects["Recharge"] = 5
                end

                if tmp_b_hp <= 0
                    ans = min(ans, cost + price)
                else
                    turn(Player(tmp_p_hp, new_p_armor, tmp_p_mana), Boss(tmp_b_hp, b.damage), tmp_effects, false, cost + price)
                end
            end
        end
    else
        actual_damage = max(1, b.damage - new_p_armor)
        if new_p_hp - actual_damage > 0
            turn(Player(new_p_hp - actual_damage, new_p_armor, new_p_mana), Boss(new_b_hp, b.damage), next_effects, true, cost)
        end
    end
end

turn(Player(50, 0, 500), Boss(58, 9), Dict{String, Int}(), true, 0)
println("Least mana to win: ", ans)
