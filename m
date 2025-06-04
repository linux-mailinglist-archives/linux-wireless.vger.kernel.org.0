Return-Path: <linux-wireless+bounces-23614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEBFACD273
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C4D3A3710
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EF8253F11;
	Wed,  4 Jun 2025 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/3o+sjc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06A1E2823;
	Wed,  4 Jun 2025 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998673; cv=none; b=KZi6wvd3i67P2eoNR8W6LcammjD2yJ7glDLHJOOWR/yIS9I6vsgkI3AvuU0/tHlxJs/fr73oTmNeanugD2QNsPX+f2uwYo/x9ymjb8lPkoiVW2wtznmtpQme5MnEEDqT/bzHl09iHN942y5j8THWVN/t5z9uj0Mg3lZJ+AfZlwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998673; c=relaxed/simple;
	bh=sAkDTrbcSQ5C49HkQUjvFvCM5ZEojeM5emPYumo7s30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LK5csnHT9+akEAoXn2YolRP5YC5RFhLffiaxgeeVV683mlnQIFjeI8YAdbJKuImsqaj0F0RAEvNAhyS6zMWg8hvSba8slXNLfc8m9Q3VivtFOIlFHQdms2/1hkUjj6ORIXqpDszmsLD2rX/xT3/utHJlqrUxf87lqTwiigY/fOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/3o+sjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621D3C4CEF1;
	Wed,  4 Jun 2025 00:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998673;
	bh=sAkDTrbcSQ5C49HkQUjvFvCM5ZEojeM5emPYumo7s30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/3o+sjclxjCD4d2ZWSVM+ZDzKMZJijgQ76Cf91DpQAARq2m4oOZdWAwH1OAKtmIR
	 418OgLQqRHGFJV580SkKaZHHIM39RgO3Pl3j17cAiRw7obT1YDa42VLJNfLKBcZLcp
	 GVHrqbKhibwTjkjTWI/hF7oPIzue444tHXjH0EOdy/gogZ9Fc4/ppvVDgMKgqjUbIk
	 PMFJtJGjGaCKC2pMkel1wLxWwK/wpthEEDGLE4KspZ5KJ0zVqzVILXM6Mo3qEJ+Snh
	 CpzlNr9f7AiXZZYlUquR35+XGC+/w8NVd3cBLLW17yTOyB0y04E6RxdUOu0ALrxBS8
	 hORLyByjcDnOA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 070/108] wifi: mac80211_hwsim: Prevent tsf from setting if beacon is disabled
Date: Tue,  3 Jun 2025 20:54:53 -0400
Message-Id: <20250604005531.4178547-70-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005531.4178547-1-sashal@kernel.org>
References: <20250604005531.4178547-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit c575f5374be7a5c4be4acb9fe6be3a4669d94674 ]

Setting tsf is meaningless if beacon is disabled, so check that beacon
is enabled before setting tsf.

Reported-by: syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=064815c6cd721082a52a
Tested-by: syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Link: https://patch.msgid.link/tencent_3609AC2EFAAED68CA5A7E3C6D212D1C67806@qq.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Perfect! Now I can see the exact issue. The function uses `do_div(delta,
bcn_int)` where `bcn_int` comes from `data->link_data[0].beacon_int`.
When beacons are disabled, this value could be 0, leading to a division
by zero error. **YES** This commit should be backported to stable kernel
trees. Here's my extensive analysis: ## Analysis of the Commit ### The
Bug The commit fixes a **division by zero vulnerability** in the
`mac80211_hwsim_set_tsf()` function. The issue occurs when: 1. **Beacons
are disabled** (`enable_beacon = false`) 2. **Beacon interval becomes
0** (as seen in line 2569: `link_data->beacon_int = 0;`) 3. **TSF is
still being set**, leading to `do_div(delta, bcn_int)` operations where
`bcn_int = 0` ### Code Analysis The problematic code was: ```c u32
bcn_int = data->link_data[0].beacon_int; // Could be 0 when beacons
disabled u64 delta = abs(tsf - now); // ... data->bcn_delta =
do_div(delta, bcn_int); // Division by zero! ``` The fix adds a safety
check: ```c conf = link_conf_dereference_protected(vif,
data->link_data[0].link_id); if (conf && !conf->enable_beacon) return;
// Exit early when beacons are disabled ``` ### Why This Should Be
Backported 1. **Critical Bug Fix**: This fixes a **division by zero
kernel bug** that could cause kernel panics or crashes. 2. **Security
Issue**: The commit references a **syzbot report**
(`syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com`), indicating
this is a reproducible security issue found by automated fuzzing. 3.
**Small and Contained**: The fix is minimal - just 5 lines of code that
add a safety check. It follows the stable tree rule of being a small,
targeted fix. 4. **No Architectural Changes**: This doesn't introduce
new features or make architectural changes. It simply prevents an
invalid operation from occurring. 5. **Low Regression Risk**: The fix is
defensive programming - it only prevents the function from executing
when beacons are disabled, which makes logical sense since TSF
adjustment is meaningless without beacons. 6. **Driver-Specific**: This
affects the `mac80211_hwsim` virtual driver, which is commonly used for
testing and virtualization, making the fix important for testing
infrastructure. 7. **Logical Fix**: The commit message clearly states
"Setting tsf is meaningless if beacon is disabled" - this is a logical
improvement that prevents undefined behavior. ### Backport Suitability -
✅ **Bug fix**: Yes, fixes division by zero - ✅ **Small change**: Only 5
lines added - ✅ **Contained**: Limited to one function in one driver - ✅
**Low risk**: Defensive check, cannot cause regressions - ✅ **Security
relevant**: Prevents kernel crashes - ✅ **Clear benefit**: Prevents
undefined behavior This is exactly the type of commit that stable trees
are designed for - a small, targeted fix for a real bug that affects
system stability.

 drivers/net/wireless/virtual/mac80211_hwsim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index a68530344d205..52d480fa7227a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1229,6 +1229,11 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 	/* MLD not supported here */
 	u32 bcn_int = data->link_data[0].beacon_int;
 	u64 delta = abs(tsf - now);
+	struct ieee80211_bss_conf *conf;
+
+	conf = link_conf_dereference_protected(vif, data->link_data[0].link_id);
+	if (conf && !conf->enable_beacon)
+		return;
 
 	/* adjust after beaconing with new timestamp at old TBTT */
 	if (tsf > now) {
-- 
2.39.5


