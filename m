Return-Path: <linux-wireless+bounces-28269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ECEC09D31
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 19:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80F83580F7E
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EAE329C5A;
	Sat, 25 Oct 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa+pZ3Qz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AFE329C45;
	Sat, 25 Oct 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409769; cv=none; b=YdxWpb+GK2qddQSrnOpxhlN1vFUfX4o0kDDyWKUY+R0oqzQbotNWaf3bn3GRUO/6Ce9+f0kJR6334FyD47ysDwuPgweXXgxG6EraPRQfZyvDaumOAcyYTi0oPSE/pQ2Y2d47WSe2hDzqjMKQYdEM4BUZtrcPrJIFdKgXUI+HUyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409769; c=relaxed/simple;
	bh=0+BJRNm6FUXKSQUw/J/BOoKZfZsQt3lj8ysUEga8zH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCH5vJ77aBRZXHAuDi6AkMkCiJSm/5L+wH9PL/WCsYB+kydaCwUsRP+SjTe8SEwq2ONpKH4Lz1R1869pnp6WI79qtVtoMLestLPvDwhcXDbmhFWUQnBOgXwbZQ6tWlcGge9+1ethIteE1eAvEVum4oM4pJrK5F/v9Z8IwlPFC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa+pZ3Qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D27C113D0;
	Sat, 25 Oct 2025 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409768;
	bh=0+BJRNm6FUXKSQUw/J/BOoKZfZsQt3lj8ysUEga8zH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fa+pZ3QzDnXWBxUEhilmvwyl3cmzwFWhn78L+LYmDIA1BL0RROtYm3XqERssMyzff
	 +kRQ22x3diJGTDBAGwdEaS6Kf6PDMEtCgnLieXfwRCd+2W4fYDBNvkNPZOLYzoSKkY
	 dZ75/Mofcu27HYqhjs/wc0uPX3hoLRg/X5NZA7rtPn7GFBplbWrU8HEz1bble7v91F
	 KDlJa7kSOMzL/qpVOVNYsLXHtUHoGpgaMfPmGzL1ZUaxkN/QnVjgD2l58Ywx8HJTF/
	 g6C1JxZ2+5xP3VRBywxpM1fbQIt16MJuS17GiUnI+JDAexmmTj29ZhhOs7w1Lc6rng
	 a5wOEe6/H4IMA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kuan-Chung Chen <damon.chen@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] wifi: rtw89: 8851b: rfk: update IQK TIA setting
Date: Sat, 25 Oct 2025 12:01:28 -0400
Message-ID: <20251025160905.3857885-457-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kuan-Chung Chen <damon.chen@realtek.com>

[ Upstream commit b521685da35ebf091e51f9ea9ad2896a4ddb6e98 ]

With the new TIA setting of RX IQK, unstable RX throughput can
be avoided, especially in medium-high attenuation environments.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250811123744.15361-5-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

Summary
- This is a targeted RF calibration/tuning fix for rtw89 8851B that
  avoids unstable RX throughput under medium-high attenuation, i.e., a
  user-visible bug/performance regression. It is small, self-contained
  to one file, and affects only the 8851B device in RX IQK flows.

What the change does
- Expands 5 GHz RXK group coverage from 2 to 4 and calibrates all
  groups:
  - Changes `#define RTW8851B_RXK_GROUP_IDX_NR` from 2 to 4
    (drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c:20).
  - Extends 5G-specific arrays to 4 entries to match, e.g.:
    - `a_idxrxgain` → `{0x10C, 0x112, 0x28c, 0x292}`
      (drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c:117)
    - `a_idxattc2` → all 0xf
      (drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c:118)
    - `a_idxrxagc` → `{0x4, 0x5, 0x6, 0x7}`
      (drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c:119)
  - Removes the helper that restricted selection to groups 0 and 2,
    ensuring all four 5 GHz groups are calibrated and better matched to
    varying attenuation scenarios (previously at
    drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c:142).
- Programs TIA-related settings during RX IQK:
  - In `_rxk_5g_group_sel()`, before the per-group loop, writes a
    sequence to the RF LUT (RR_LUTWE/WA/WD0) and sets/clears RR_RXA2 bit
    0x20 to enable the new TIA behavior during calibration; restores
    everything after the loop (the loop originally starts at
    drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c:913).
  - Mirrors the same pattern in `_iqk_5g_nbrxk()`, applying TIA
    programming and restoration around the group-2 run (function starts
    at drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c:977).
- Improves failure handling by clearing RXCFIR bits on failure, aligning
  8851B behavior with other rtw89 chips:
  - Adds `rtw89_phy_write32_mask(rtwdev, R_IQK_RES..., B_IQK_RES_RXCFIR,
    0x0)` on failure in 5G RXK paths, similar to existing patterns in
    8852 series (see e.g., rtw8852b_rfk.c uses `R_IQK_RES` and
    `B_IQK_RES_RXCFIR`).
- Fine-tunes RX clock table for 960M by adjusting `ck960_8851b` last
  value from 0x93 to 0x92, a small, contained calibration tweak
  (baseline array is at
  drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c:199).
- Drops an unnecessary initialization write in `_iqk_init()` (removing a
  `R_IQKINF` clear), which is benign and reduces redundant writes.

Why it’s a good stable backport
- Fixes a real-world user problem: The commit explicitly addresses
  unstable RX throughput in certain environments (medium-high
  attenuation), which is a functional/performance correctness issue, not
  a feature.
- Contained scope and minimal risk:
  - Single file change (rtw8851b_rfk.c), 8851B-only paths, and affects
    RX IQK calibrations.
  - No architectural or API/ABI changes; only calibration logic and RF
    register programming sequences.
- Dependencies are already present in stable:
  - 6.17 contains the preceding updates this depends on (e.g., IQK v0x14
    and DPK v0x11 are already in place, as seen from the constants in
    drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c:22 and :15).
  - All macros/registers used exist in stable branches (RR_LUTWE/WA/WD0,
    RR_MOD_MASK, RR_RXA2, R_IQK_RES, B_IQK_RES_RXCFIR).
- Consistent with existing practices in rtw89:
  - The addition of RXCFIR reset on failure mirrors patterns already
    used by other chips (e.g., rtw8852b), reducing risk and improving
    robustness.

Risk assessment
- Changes touch calibration-only flows (`_rxk_5g_group_sel`,
  `_iqk_5g_nbrxk`), with state saved/restored around TIA writes,
  limiting side effects.
- The broader constants and macros are stable and used elsewhere in the
  driver.
- No cross-subsystem impact; limited to rtw89/8851B RFK.

Conclusion
- This is a targeted, low-risk fix that addresses a user-visible
  throughput stability issue without introducing features or
  architectural changes. It applies cleanly on stable trees that already
  have the 8851B support and related RFK updates. Backporting is
  recommended.

 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 85 ++++++++++++-------
 1 file changed, 54 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 7a319a6c838af..a7867b0e083ac 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -17,7 +17,7 @@
 #define DPK_RF_REG_NUM_8851B 4
 #define DPK_KSET_NUM 4
 #define RTW8851B_RXK_GROUP_NR 4
-#define RTW8851B_RXK_GROUP_IDX_NR 2
+#define RTW8851B_RXK_GROUP_IDX_NR 4
 #define RTW8851B_TXK_GROUP_NR 1
 #define RTW8851B_IQK_VER 0x14
 #define RTW8851B_IQK_SS 1
@@ -114,9 +114,9 @@ static const u32 _tssi_de_mcs_10m[RF_PATH_NUM_8851B] = {0x5830};
 static const u32 g_idxrxgain[RTW8851B_RXK_GROUP_NR] = {0x10e, 0x116, 0x28e, 0x296};
 static const u32 g_idxattc2[RTW8851B_RXK_GROUP_NR] = {0x0, 0xf, 0x0, 0xf};
 static const u32 g_idxrxagc[RTW8851B_RXK_GROUP_NR] = {0x0, 0x1, 0x2, 0x3};
-static const u32 a_idxrxgain[RTW8851B_RXK_GROUP_IDX_NR] = {0x10C, 0x28c};
-static const u32 a_idxattc2[RTW8851B_RXK_GROUP_IDX_NR] = {0xf, 0xf};
-static const u32 a_idxrxagc[RTW8851B_RXK_GROUP_IDX_NR] = {0x4, 0x6};
+static const u32 a_idxrxgain[RTW8851B_RXK_GROUP_IDX_NR] = {0x10C, 0x112, 0x28c, 0x292};
+static const u32 a_idxattc2[RTW8851B_RXK_GROUP_IDX_NR] = {0xf, 0xf, 0xf, 0xf};
+static const u32 a_idxrxagc[RTW8851B_RXK_GROUP_IDX_NR] = {0x4, 0x5, 0x6, 0x7};
 static const u32 a_power_range[RTW8851B_TXK_GROUP_NR] = {0x0};
 static const u32 a_track_range[RTW8851B_TXK_GROUP_NR] = {0x6};
 static const u32 a_gain_bb[RTW8851B_TXK_GROUP_NR] = {0x0a};
@@ -139,17 +139,6 @@ static const u32 dpk_rf_reg[DPK_RF_REG_NUM_8851B] = {0xde, 0x8f, 0x5, 0x10005};
 
 static void _set_ch(struct rtw89_dev *rtwdev, u32 val);
 
-static u8 _rxk_5ghz_group_from_idx(u8 idx)
-{
-	/* There are four RXK groups (RTW8851B_RXK_GROUP_NR), but only group 0
-	 * and 2 are used in 5 GHz band, so reduce elements to 2.
-	 */
-	if (idx < RTW8851B_RXK_GROUP_IDX_NR)
-		return idx * 2;
-
-	return 0;
-}
-
 static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	return RF_A;
@@ -196,7 +185,7 @@ static void _txck_force(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 static void _rxck_force(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 			bool force, enum adc_ck ck)
 {
-	static const u32 ck960_8851b[] = {0x8, 0x2, 0x2, 0x4, 0xf, 0xa, 0x93};
+	static const u32 ck960_8851b[] = {0x8, 0x2, 0x2, 0x4, 0xf, 0xa, 0x92};
 	static const u32 ck1920_8851b[] = {0x9, 0x0, 0x0, 0x3, 0xf, 0xa, 0x49};
 	const u32 *data;
 
@@ -905,18 +894,27 @@ static bool _rxk_5g_group_sel(struct rtw89_dev *rtwdev,
 	bool kfail = false;
 	bool notready;
 	u32 rf_0;
-	u8 idx;
+	u32 val;
 	u8 gp;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
 
-	for (idx = 0; idx < RTW8851B_RXK_GROUP_IDX_NR; idx++) {
-		gp = _rxk_5ghz_group_from_idx(idx);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x1000);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x4);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x17);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x5);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x27);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x0);
 
+	val = rtw89_read_rf(rtwdev, RF_PATH_A, RR_RXA2, 0x20);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_MASK, 0xc);
+
+	for (gp = 0; gp < RTW8851B_RXK_GROUP_IDX_NR; gp++) {
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, gp = %x\n", path, gp);
 
-		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_RGM, a_idxrxgain[idx]);
-		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[idx]);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_RGM, a_idxrxgain[gp]);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[gp]);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, 0x20, 0x1);
 
 		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x0);
@@ -926,7 +924,7 @@ static bool _rxk_5g_group_sel(struct rtw89_dev *rtwdev,
 		fsleep(100);
 		rf_0 = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
 		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF2, B_IQK_DIF2_RXPI, rf_0);
-		rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[idx]);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[gp]);
 		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
 		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXAGC);
 
@@ -959,6 +957,7 @@ static bool _rxk_5g_group_sel(struct rtw89_dev *rtwdev,
 		_iqk_sram(rtwdev, path);
 
 	if (kfail) {
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RES, B_IQK_RES_RXCFIR, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8), MASKDWORD,
 				       iqk_info->nb_rxcfir[path] | 0x2);
 		iqk_info->is_wb_txiqk[path] = false;
@@ -968,6 +967,14 @@ static bool _rxk_5g_group_sel(struct rtw89_dev *rtwdev,
 		iqk_info->is_wb_txiqk[path] = true;
 	}
 
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, 0x20, val);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x1000);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x4);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x37);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x5);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x27);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x0);
+
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]S%x, kfail = 0x%x, 0x8%x3c = 0x%x\n", path, kfail,
 		    1 << path, iqk_info->nb_rxcfir[path]);
@@ -980,17 +987,26 @@ static bool _iqk_5g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	bool kfail = false;
 	bool notready;
-	u8 idx = 0x1;
+	u8 gp = 2;
 	u32 rf_0;
-	u8 gp;
-
-	gp = _rxk_5ghz_group_from_idx(idx);
+	u32 val;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, gp = %x\n", path, gp);
 
-	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_RGM, a_idxrxgain[idx]);
-	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[idx]);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x1000);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x4);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x17);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x5);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x27);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x0);
+
+	val = rtw89_read_rf(rtwdev, RF_PATH_A, RR_RXA2, 0x20);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_MASK, 0xc);
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_RGM, a_idxrxgain[gp]);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[gp]);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, 0x20, 0x1);
 
 	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
 	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x0);
@@ -1000,7 +1016,7 @@ static bool _iqk_5g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	fsleep(100);
 	rf_0 = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
 	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF2, B_IQK_DIF2_RXPI, rf_0);
-	rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[idx]);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[gp]);
 	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
 	notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXAGC);
 
@@ -1026,6 +1042,7 @@ static bool _iqk_5g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
 
 	if (kfail) {
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RES + (path << 8), 0xf, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
 				       MASKDWORD, 0x40000002);
 		iqk_info->is_wb_rxiqk[path] = false;
@@ -1033,6 +1050,14 @@ static bool _iqk_5g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 		iqk_info->is_wb_rxiqk[path] = false;
 	}
 
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, 0x20, val);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x1000);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x4);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x37);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x5);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x27);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x0);
+
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]S%x, kfail = 0x%x, 0x8%x3c = 0x%x\n", path, kfail,
 		    1 << path, iqk_info->nb_rxcfir[path]);
@@ -1664,8 +1689,6 @@ static void _iqk_init(struct rtw89_dev *rtwdev)
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u8 idx, path;
 
-	rtw89_phy_write32_mask(rtwdev, R_IQKINF, MASKDWORD, 0x0);
-
 	if (iqk_info->is_iqk_init)
 		return;
 
-- 
2.51.0


