Return-Path: <linux-wireless+bounces-29554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64458CAA7D4
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Dec 2025 15:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B92430BFD70
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF682FE574;
	Sat,  6 Dec 2025 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM2h0uiJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C1218EB1;
	Sat,  6 Dec 2025 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765029789; cv=none; b=D9x7F0oSLHw9U82L2SjPlascyiwSaKf9Nqv7ZhxUlRJwTI2rvapy0weyV5QQ2n5bkPdJALr+cuzew7dSE+7Ukf8U9JA7Vrr3MmWjJCHdP//J5Uza+Xqd7OUhnpYJtISr/JE70XgGJbEcrvXiQcpsgMO6BLFExuiYKvOHcO0IJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765029789; c=relaxed/simple;
	bh=30B2IC5tghGWMMCtTTZEzIXfgSO6xlHFtZfDadBtLYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXUkKNfiX1SwEIrNdjl7p0CFxGYPNgu/Z/ixgrx2+5CLcUPJJKCCe69eIkdFa9eYI/T73nzuRWPYpDDy/tHefG3Ga1Prd9ofq6hA12t2oZhfh2ohFzhvaEiU17IxLrrALGdfB8Q+rUplDbJEBP2Gg2keTWEH5ralj57g8ybl+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM2h0uiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A098DC116D0;
	Sat,  6 Dec 2025 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765029788;
	bh=30B2IC5tghGWMMCtTTZEzIXfgSO6xlHFtZfDadBtLYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YM2h0uiJtuW/pu+WxOXtXdQKhQWHGtJvIWQkAbekvRmQq5vezOTvJwCCfEO4bzkZQ
	 l07271RxAomMESCk4orgWCoXyucYk+H2h04Q0zbZAY65PEgwWZxlU/ozasnmQm6ZYf
	 3Qok2EOn7w8SlOPdDHsvOiVgCibiISiCpu/HREzDM0EpRaYlvXOuW8sgQkmyLWpUDK
	 bP3b06QLFZ/3zgS5npqqoOpjrovNcs3wmrSkhK572no45mE2P+7419GpAhPixl8i+J
	 kFXR4SR+PtgE/yviof5GmC4xUd/iaD2Lm+5jaHqRgu/lTVg2UrKzgrrkl6lZw/2eSR
	 keppT8pmiuXlA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	Jes.Sorensen@gmail.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] wifi: rtl8xxxu: Fix HT40 channel config for RTL8192CU, RTL8723AU
Date: Sat,  6 Dec 2025 09:02:13 -0500
Message-ID: <20251206140252.645973-8-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206140252.645973-1-sashal@kernel.org>
References: <20251206140252.645973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Transfer-Encoding: 8bit

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 5511ba3de434892e5ef3594d6eabbd12b1629356 ]

Flip the response rate subchannel. It was backwards, causing low
speeds when using 40 MHz channel width. "iw dev ... station dump"
showed a low RX rate, 11M or less.

Also fix the channel width field of RF6052_REG_MODE_AG.

Tested only with RTL8192CU, but these settings are identical for
RTL8723AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/1f46571d-855b-43e1-8bfc-abacceb96043@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## COMPREHENSIVE ANALYSIS

### 1. COMMIT MESSAGE ANALYSIS

**Subject:** "wifi: rtl8xxxu: Fix HT40 channel config for RTL8192CU,
RTL8723AU"

- Contains "Fix" keyword indicating a bug fix
- Describes specific affected hardware: RTL8192CU, RTL8723AU USB WiFi
  adapters
- Explains user-visible symptom: "low speeds when using 40 MHz channel
  width"
- Provides diagnostic evidence: "`iw dev ... station dump` showed a low
  RX rate, 11M or less"
- **No** "Cc: stable@vger.kernel.org" tag
- **No** "Fixes:" tag pointing to the original buggy commit
- **Has** "Reviewed-by: Ping-Ke Shih" (Realtek's kernel maintainer)
- **Has** "Tested only with RTL8192CU" - real-world testing performed

### 2. CODE CHANGE ANALYSIS

**Two distinct bugs are fixed:**

**Bug #1: RSR (Response Rate Set) subchannel configuration (lines
1255-1258):**
```c
// BEFORE (buggy):
if (sec_ch_above)
    rsr |= RSR_RSC_UPPER_SUB_CHANNEL;
else
    rsr |= RSR_RSC_LOWER_SUB_CHANNEL;

// AFTER (fixed):
if (!sec_ch_above)
    rsr |= RSR_RSC_UPPER_SUB_CHANNEL;
else
    rsr |= RSR_RSC_LOWER_SUB_CHANNEL;
```
The logic was inverted - when secondary channel is above, LOWER should
be set, not UPPER. Comparison with RTL8188E driver (8188e.c:462-465)
confirms the fix matches the correct pattern.

**Bug #2: RF6052_REG_MODE_AG bandwidth configuration (lines
1322-1328):**
```c
// BEFORE (buggy):
if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_40)
    val32 &= ~MODE_AG_CHANNEL_20MHZ;
else
    val32 |= MODE_AG_CHANNEL_20MHZ;

// AFTER (fixed):
val32 &= ~MODE_AG_BW_MASK;  // Clear both bits 10 and 11
if (hw->conf.chandef.width != NL80211_CHAN_WIDTH_40)
    val32 |= MODE_AG_CHANNEL_20MHZ;
```
Two issues: (1) Only cleared bit 10, not the full bandwidth mask (bits
10-11), and (2) the logic flow was awkward - proper pattern is to clear
mask first, then set appropriate bit only when needed.

The gen2 driver (`rtl8xxxu_gen2_config_channel` at line 1446) already
uses `MODE_AG_BW_MASK` correctly, confirming this is the right approach.

### 3. CLASSIFICATION

- **Bug Type:** Logic error causing severe performance degradation
- **NOT a feature:** No new functionality added
- **NOT a quirk/workaround:** This is fixing incorrect code logic
- **Hardware affected:** RTL8192CU, RTL8723AU (older but still commonly
  used USB WiFi adapters)

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed:** ~8 lines modified
- **Files touched:** 1 file (core.c)
- **Complexity:** LOW - simple logic inversions and proper mask usage
- **Scope:** Confined to `rtl8xxxu_gen1_config_channel()` function, only
  affects 40MHz mode
- **Risk of regression:** LOW - brings gen1 config in line with gen2 and
  8188e implementations
- **Dependencies:** `MODE_AG_BW_MASK` exists since 2016 (commit
  c3f9506f2374), present in all stable kernels

### 5. USER IMPACT

- **Affected users:** Anyone using RTL8192CU or RTL8723AU USB WiFi
  adapters with 40MHz channels
- **Severity:** MODERATE-HIGH - WiFi functional but severely degraded
  speeds (capped at 11M vs expected 40MHz HT speeds which could be
  150-300Mbps)
- **Impact scope:** These are common, inexpensive USB WiFi adapters;
  many users in production environments
- **Visibility:** Users would notice unusably slow WiFi and might
  mistakenly blame their router or network

### 6. STABILITY INDICATORS

- Reviewed by Realtek's Linux kernel maintainer (Ping-Ke Shih)
- Tested on actual hardware (RTL8192CU)
- Consistent with how other chip variants in the same driver family
  handle this
- Small, surgical changes with clear correctness rationale

### 7. DEPENDENCY CHECK

- `MODE_AG_BW_MASK` macro is defined in regs.h since 2016
- No other commits needed for this fix to work
- The affected function `rtl8xxxu_gen1_config_channel()` exists in all
  stable kernels that have the rtl8xxxu driver

### VERDICT

**Positive factors:**
- Fixes a real, user-visible performance bug (severely degraded WiFi
  speeds)
- Small, contained changes (8 lines)
- Low regression risk - aligns with established patterns in related code
- Reviewed and tested
- No dependencies on other commits
- Affects real hardware that users own

**Negative factors:**
- No explicit "Cc: stable@" tag from maintainer
- No "Fixes:" tag to trace original bug introduction

**Risk vs Benefit:**
- Benefit: Restores proper HT40 performance for RTL8192CU/RTL8723AU
  users
- Risk: Very low - logic corrections that match other implementations in
  the same driver

This is a clear bug fix for user-visible performance degradation. The
changes are minimal, well-understood, properly reviewed, and consistent
with how other chip variants in the same driver family handle channel
configuration. The lack of explicit stable tags appears to be an
oversight rather than an intentional exclusion. Users with these common
USB WiFi adapters would benefit significantly from this fix.

**YES**

 drivers/net/wireless/realtek/rtl8xxxu/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 3ded5952729fc..d2d3bbac2861f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -1252,7 +1252,7 @@ void rtl8xxxu_gen1_config_channel(struct ieee80211_hw *hw)
 		opmode &= ~BW_OPMODE_20MHZ;
 		rtl8xxxu_write8(priv, REG_BW_OPMODE, opmode);
 		rsr &= ~RSR_RSC_BANDWIDTH_40M;
-		if (sec_ch_above)
+		if (!sec_ch_above)
 			rsr |= RSR_RSC_UPPER_SUB_CHANNEL;
 		else
 			rsr |= RSR_RSC_LOWER_SUB_CHANNEL;
@@ -1321,9 +1321,8 @@ void rtl8xxxu_gen1_config_channel(struct ieee80211_hw *hw)
 
 	for (i = RF_A; i < priv->rf_paths; i++) {
 		val32 = rtl8xxxu_read_rfreg(priv, i, RF6052_REG_MODE_AG);
-		if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_40)
-			val32 &= ~MODE_AG_CHANNEL_20MHZ;
-		else
+		val32 &= ~MODE_AG_BW_MASK;
+		if (hw->conf.chandef.width != NL80211_CHAN_WIDTH_40)
 			val32 |= MODE_AG_CHANNEL_20MHZ;
 		rtl8xxxu_write_rfreg(priv, i, RF6052_REG_MODE_AG, val32);
 	}
-- 
2.51.0


