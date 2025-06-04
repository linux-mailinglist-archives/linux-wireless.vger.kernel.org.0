Return-Path: <linux-wireless+bounces-23658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7288ACD41F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A587F3A67FA
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D4022759B;
	Wed,  4 Jun 2025 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZYCFs+R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C2221FBC;
	Wed,  4 Jun 2025 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999104; cv=none; b=oPcYsW6rOcGHY4CG9xXnIH0hv1n79nRpGX0Oc/qNlUgJYolXIMwm0knjPKg/A1BsSQ4c9pbnzwoH93MZL4/wiINGpfVW4V2oWWTedJ1VlNH0cAXpCljW9flb90mSOvHM4heRyr2Kl3v8/85s90wIKmt61oV8QH6dWywFXyB6cQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999104; c=relaxed/simple;
	bh=dZ2m8Z8qzM+mpPNbq/Gp9ZTsCMcMOyaSkm6tUe8xzJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shBN8O1AOsv96BgxLQKzQxrmLXQKRzTYNpFZxQOBDHrZMolsEMjfzb8E3kLaipYRGBLBoa5b1YpXwB++TKfEcVxlgq54wNOINNrty2L7xdcjt/xyupCkH8Moyst3NF5WIDpPdVlduACJhsEnKkw6Z/xNqNAVqnurAxiLTTR3/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZYCFs+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F43C4CEED;
	Wed,  4 Jun 2025 01:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999103;
	bh=dZ2m8Z8qzM+mpPNbq/Gp9ZTsCMcMOyaSkm6tUe8xzJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZYCFs+RNQdk95Vh3bqrTLS9KIEiYmhzuRzpKAVbnr6kMOFNGH9vtiNrUJSy0ME9M
	 889Hs/8l2wkrWLZeM/1/JlKlQsbR5G7O6dir/izjozfmMOyncHzmb2nI0yLJffVQhl
	 Lf/tGa+JsYz1as4fGaVBrHmrCdhRJAtpzl+tJxTYkyNJg4frfWNGuBv5MKXyzhY8bl
	 qsFn7izDKY3T1mP/khw4ZwTpBrWfqFXtxGNZdTE8REEtZNnAxBFEiLKGFw3XukVdFb
	 s8EZoYgF+Jj/dTg7rh48OUSlkDt/A1g4JaYQAmb8TmVqfEEUhRP8fXa/7TwDATWZYq
	 7NI2RFfvFSgUg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 34/46] wifi: mac80211_hwsim: Prevent tsf from setting if beacon is disabled
Date: Tue,  3 Jun 2025 21:03:52 -0400
Message-Id: <20250604010404.5109-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010404.5109-1-sashal@kernel.org>
References: <20250604010404.5109-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.140
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

 drivers/net/wireless/mac80211_hwsim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index abcd165a62cfe..80a2a668cfb9e 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1091,6 +1091,11 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
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


