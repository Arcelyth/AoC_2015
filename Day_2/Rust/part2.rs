use std::fs::File;
use std::io::{BufRead, BufReader, Error};
use std::collections::HashSet;

fn main() -> Result<(), Error>{
    let path = "../input";
    let file = File::open(path)?;
    let reader = BufReader::new(file);
    let mut sum: i64 = 0;
    for line in reader.lines() {
        let mut nums: Vec<i64> = line?.split('x').collect::<Vec<_>>().iter()
            .map(|x| x.parse::<i64>().unwrap()).collect();
        nums.sort();
        let big = nums.iter().fold(nums[0], |cur , &x| if (x > cur) {x } else { cur});
        sum += nums.iter().fold(1, |acc, &x | x * acc) + 2 * ( nums[0] + nums[1]);
    }
    println!("{}", sum);
    Ok(())
}
