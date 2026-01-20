program part1
    implicit none 
    integer :: i, ios, unit, ans, ntokens, j
    integer, parameter :: n = 1000
    character(len=1024) :: line
    character(len=20) :: tokens(20)
    logical :: is_valid
    integer :: val

    unit = 1
    open(unit, file="../input", status="old", action="read", iostat=ios)
    ans = 0
    if (ios /= 0) then
        print *, "Error: Unable to open file 'data.txt'."
        stop
    end if

    do i = 1, n
        read(unit, '(A)', iostat=ios) line
        if (ios < 0) then
            exit
        else if (ios > 0) then
            print *, "Error: Something went wrong reading the file."
            exit
        end if
        is_valid = .true.
        call split_by_space(line, tokens, ntokens)

        do j = 1, ntokens 
            select case (trim(tokens(j)))
                
            case ("children", "cats", "samoyeds", "pomeranians", "akitas", &
                  "vizslas", "goldfish", "trees", "cars", "perfumes")
                  
                read(tokens(j+1), *) val
                select case (trim(tokens(j)))
                case ("cats")
                    if (val <= 7) is_valid = .false. 
                case ("trees")
                    if (val <= 3) is_valid = .false. 
                case ("pomeranians")
                    if (val >= 3) is_valid = .false. 
                case ("goldfish")
                    if (val >= 5) is_valid = .false. 
                case ("children")
                    if (val /= 3) is_valid = .false.
                case ("samoyeds")
                    if (val /= 2) is_valid = .false.
                case ("akitas")
                    if (val /= 0) is_valid = .false.
                case ("vizslas")
                    if (val /= 0) is_valid = .false.
                case ("cars")
                    if (val /= 2) is_valid = .false.
                case ("perfumes")
                    if (val /= 1) is_valid = .false.
                end select
                if (.not. is_valid) exit
            end select
        end do 
        if (is_valid) then
            print *, "Found Sue ID: ", trim(tokens(2))
            exit 
        end if
    end do
contains
    subroutine split_by_space(str, arr, n)
        character(len=*), intent(in)  :: str
        character(len=*), intent(out) :: arr(:)
        integer, intent(out)          :: n

        integer :: i, start, lenstr
        logical :: in_token

        n = 0
        lenstr = len_trim(str)
        in_token = .false.

        do i = 1, lenstr
            if (is_alnum(str(i:i))) then
                if (.not. in_token) then
                    start = i
                    in_token = .true.
                end if
            else
                if (in_token) then
                    n = n + 1
                    arr(n) = str(start:i-1)
                    in_token = .false.
                end if
            end if
        end do

        if (in_token) then
            n = n + 1
            arr(n) = str(start:lenstr)
        end if
    end subroutine

    logical function is_alnum(c)
        character, intent(in) :: c
        integer :: x

        x = iachar(c)
        is_alnum = (x >= iachar('0') .and. x <= iachar('9')) .or. &
                   (x >= iachar('A') .and. x <= iachar('Z')) .or. &
                   (x >= iachar('a') .and. x <= iachar('z'))
    end function
end program part1
