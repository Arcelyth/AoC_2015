import std.stdio;
import std.regex;
import std.conv : to;

struct Role {
    int hp;
    int damage;
    int armor;
}

struct Item {
    int cost;
    int damage;
    int armor;
}

void main() {
    auto player = Role(100, 0, 0);
    auto boss = Role(109, 8, 2);
    
    auto pattern = regex(r"(\w+ .*)\s+(\d+)\s+(\d+)\s+(\d+)");
    
    Item[string] weapons, armors, rings;

    int ans = 0;
    void loadItems(ref Item[string] container, string path) {
        auto f = File(path, "r");
        foreach (line; f.byLine) {
            auto m = line.matchFirst(pattern);
            if (m) {
                container[m[1].idup] = Item(m[2].to!int, m[3].to!int, m[4].to!int);
            }
        }
    }
    armors["None"] = Item(0, 0, 0);
    rings["None"] = Item(0, 0, 0);

    try {
        loadItems(weapons, "../weapons");
        loadItems(armors, "../armors");
        loadItems(rings, "../rings");
        
    } catch (Exception e) {
        stderr.writeln("Failed to read file: ", e.msg);
    }

    foreach (w; weapons) {
        foreach (a; armors) {
            foreach (i, r1; rings) {
                foreach (j, r2; rings) {
                    if (i == j) continue;
                    if (j < i) continue; 

                    int totalCost = w.cost + a.cost + r1.cost + r2.cost;
                    player.damage = w.damage + a.damage + r1.damage + r2.damage;
                    player.armor = w.armor + a.armor + r1.armor + r2.armor;

                    if (!fight(player, boss)) {
                        ans = ans >= totalCost ? ans : totalCost;
                    }
                }
            }
        }
    }
    writeln("cost: ", ans);
}


bool fight(Role player, Role boss) {
    for (;;){
        int dmg = player.damage - boss.armor;
        int real_dmg = dmg <= 0 ? 1 :  dmg;
        boss.hp -= real_dmg;
        if (boss.hp <= 0)
            return true;

        player.hp -= boss.damage - player.armor;
        if (player.hp <= 0)
            return false;
    }
}


