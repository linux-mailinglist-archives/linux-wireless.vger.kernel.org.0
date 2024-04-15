Return-Path: <linux-wireless+bounces-6347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A7A8A5C3F
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 22:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D5D285CF7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 20:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60C071B50;
	Mon, 15 Apr 2024 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQAq1xY0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAFE155A24
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212948; cv=none; b=XbRVGyVQznj3P8X2gTDW7uDgfiJ5TfZiI0VxujB3fLSLqJQgNIkHMacBG487ozIwCj/WsSUD6B7wF0F2M9UAFkX5mljMzOheM9xBkQv8mR0WnoXV46trMe/5gGBrgdK1KD4hoGVLkyrYd4IZAXOn6auYBMt5Et/17R4t8BXkXTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212948; c=relaxed/simple;
	bh=ogXCpToLdaLvGvsmEh5I+4US4MBlutvFLw7/+/BIiLw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jWU+G6X0LEucubpCb7tpIY5kNcVy4LoarePrlQhX8O98WiWRwJBEyHHXBgx1xDIPQHSwqn5QBYDMnqzad5uqIT5u0C/xHz+U01DPKtYiF1tFg6ws4hiSDnX9PTbbz0sGkXSn6pSl2g7hYdxAXYi/Wvt5um3G9bQd+E1dmoAtaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQAq1xY0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d4d80d00so4518880e87.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713212943; x=1713817743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jFTJ5mtanjoKE6+DWOkJJTr6CQ+iLlUB5BuP9APgfa8=;
        b=VQAq1xY0U69MjM//tUDnkBglg3150UH0hUg1DVaH9tAzMOn8T1Tk2rJC9GM/TEH1TV
         Y7EbKFifbCIPSQoB02EIt1gvryrane8NuHZbvpvaB3YTK4b37hBNyADQmRUBOK6gJpTw
         AK7WZ/5jpt1D6viukve582+wpkaNWArB4/sVQe3Bv2DRslFJWm9V1q8HGwYBXjliP5DP
         3ub8rrNlDvYCCu1CrR5dnfy9r/wfPP7mhNHL9ghJxt9e9gQPs2BYGXzJtSpHI7knZBIE
         Svv+5X/tKLGjZwOwNwCZj2Ih+Kn4mzla6KtiOsWE7t3gLT6t4Yqpz2BP3nvqi5uFf3ey
         jyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713212943; x=1713817743;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFTJ5mtanjoKE6+DWOkJJTr6CQ+iLlUB5BuP9APgfa8=;
        b=aZP3x2n/eAE9rCh21ayIHySUqqrCaakpIZ7jOZJbpaKirHBvnFvwfpcjCHYLYAOyyV
         JAnC+onL/WwBiFV4e1Idj33UlefbdEcjzmsf9xIIJZVgpVVOj+tWWDnMtnoItVFApLnq
         TWIzo1NZswiZvcD2GTHXMluAXbJQ1MkiRjmaqxJfdMciOic3r9QrQDfE2plpXmJxStyq
         ib3y2QbLiz9bE2ajG3qQC2Y6kFp4i2U5WW4zjnzivcDSPZD0vQiUXASLNS1DDXK1ovM7
         apYdEy4WSFGdwrmO/YvnJbaIi6JgcpGRJbN/u2RnsC0zQrC1zg46X6iWQnzFf8xuYmuV
         hAYQ==
X-Gm-Message-State: AOJu0YwUp7mPdJmzXxqoLPzWyN7yMIu9UWGlHIoxdzozAObfxgpmR+0B
	w+DXS+O5RRSwTilr/YV+UAfVlOrkljIJ4Cfuc4jTq1vALEOIkxTVwa6Z0rmM
X-Google-Smtp-Source: AGHT+IEKtyqNmzN4WHgYM1tTMac6iORqtpqtcEAFf4Gt+j182NtEbv5oTkeA2RAwxC9YFYzvUiICPw==
X-Received: by 2002:a19:5f54:0:b0:518:a9bf:73ec with SMTP id a20-20020a195f54000000b00518a9bf73ecmr5146216lfj.35.1713212942734;
        Mon, 15 Apr 2024 13:29:02 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id gt42-20020a1709072daa00b00a5534758ef7sm630519ejc.148.2024.04.15.13.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 13:29:02 -0700 (PDT)
Message-ID: <4e47c56c-4b7f-4ae6-84b9-05f0cac97dac@gmail.com>
Date: Mon, 15 Apr 2024 23:29:01 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 5/6] wifi: rtlwifi: Clean up rtl8192d-common a bit
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
Content-Language: en-US
In-Reply-To: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Improve readability:
 * add empty lines
 * use abs_diff in rtl92d_dm_txpower_tracking_callback_thermalmeter
 * roll up repeated statements into a for loop in
   rtl92d_dm_txpower_tracking_callback_thermalmeter
 * shorten lines by replacing many instances of "rtlpriv->dm" with "dm"
   pointer in rtl92d_dm_txpower_tracking_callback_thermalmeter
 * sort some declarations by length
 * refactor _rtl92d_get_txpower_writeval_by_regulatory a little

Delete unused structs tag_dynamic_init_gain_operation_type_definition
and swat.

Simplify rtl92d_fill_h2c_cmd a little and delete a pointless wrapper
function.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v5:
 - Patch is new in v5.
---
 .../realtek/rtlwifi/rtl8192d/dm_common.c      | 368 +++++++++---------
 .../realtek/rtlwifi/rtl8192d/dm_common.h      |  21 -
 .../realtek/rtlwifi/rtl8192d/fw_common.c      | 121 +++---
 .../realtek/rtlwifi/rtl8192d/hw_common.c      |  64 +--
 .../realtek/rtlwifi/rtl8192d/phy_common.c     |  19 +-
 .../realtek/rtlwifi/rtl8192d/rf_common.c      | 136 +++----
 .../realtek/rtlwifi/rtl8192d/trx_common.c     |  11 +-
 7 files changed, 343 insertions(+), 397 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
index d376e4584454..20373ce998bf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
@@ -9,8 +9,6 @@
 #include "phy_common.h"
 #include "dm_common.h"
 
-#define UNDEC_SM_PWDB	entry_min_undec_sm_pwdb
-
 static const u32 ofdmswing_table[OFDM_TABLE_SIZE_92D] = {
 	0x7f8001fe,		/* 0, +6.0dB */
 	0x788001e2,		/* 1, +5.5dB */
@@ -137,16 +135,18 @@ static void rtl92d_dm_rxgain_tracking_thermalmeter(struct ieee80211_hw *hw)
 		0x05, 0x04, 0x04, 0x03, 0x02
 	};
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	int i, idx;
 	u32 u4tmp;
-	int i;
 
-	u4tmp = (index_mapping[(rtlpriv->efuse.eeprom_thermalmeter -
-				rtlpriv->dm.thermalvalue_rxgain)]) << 12;
+	idx = rtlpriv->efuse.eeprom_thermalmeter - rtlpriv->dm.thermalvalue_rxgain;
+	u4tmp = index_mapping[idx] << 12;
+
 	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		"===> Rx Gain %x\n", u4tmp);
+
 	for (i = RF90_PATH_A; i < rtlpriv->phy.num_total_rfpath; i++)
 		rtl_set_rfreg(hw, i, 0x3C, RFREG_OFFSET_MASK,
-			      (rtlpriv->phy.reg_rf3c[i] & (~(0xF000))) | u4tmp);
+			      (rtlpriv->phy.reg_rf3c[i] & ~0xF000) | u4tmp);
 }
 
 static void rtl92d_bandtype_2_4G(struct ieee80211_hw *hw, long *temp_cckg,
@@ -163,6 +163,7 @@ static void rtl92d_bandtype_2_4G(struct ieee80211_hw *hw, long *temp_cckg,
 	temp_cck = rtl_get_bbreg(hw, RCCK0_TXFILTER2,
 				 MASKDWORD) & MASKCCK;
 	rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
+
 	for (i = 0; i < CCK_TABLE_LENGTH; i++) {
 		if (rtlpriv->dm.cck_inch14)
 			cckswing = &cckswing_table_ch14[i][2];
@@ -199,6 +200,7 @@ static void rtl92d_bandtype_5G(struct rtl_hal *rtlhal, u8 *ofdm_index,
 			*internal_pa = rtlefuse->internal_pa_5g[1];
 		else
 			*internal_pa = rtlefuse->internal_pa_5g[i];
+
 		if (*internal_pa) {
 			if (rtlhal->interfaceindex == 1 || i == rf)
 				offset = 4;
@@ -213,8 +215,10 @@ static void rtl92d_bandtype_5G(struct rtl_hal *rtlhal, u8 *ofdm_index,
 			else
 				offset = 0;
 		}
+
 		if (thermalvalue > rtlefuse->eeprom_thermalmeter)
 			offset++;
+
 		if (*internal_pa) {
 			if (delta > INDEX_MAPPING_NUM - 1)
 				index = index_mapping_pa[offset]
@@ -229,6 +233,7 @@ static void rtl92d_bandtype_5G(struct rtl_hal *rtlhal, u8 *ofdm_index,
 			else
 				index = index_mapping[offset][delta];
 		}
+
 		if (thermalvalue > rtlefuse->eeprom_thermalmeter) {
 			if (*internal_pa && thermalvalue > 0x12) {
 				ofdm_index[i] = rtlpriv->dm.ofdm_index[i] -
@@ -247,62 +252,67 @@ rtl92d_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw *hw)
 {
 	static const u8 index_mapping[5][INDEX_MAPPING_NUM] = {
 		/* 5G, path A/MAC 0, decrease power  */
-		{0, 1, 3, 6, 8, 9,	11, 13, 14, 16, 17, 18, 18},
+		{0, 1, 3, 6, 8, 9, 11, 13, 14, 16, 17, 18, 18},
 		/* 5G, path A/MAC 0, increase power  */
-		{0, 2, 4, 5, 7, 10,	12, 14, 16, 18, 18, 18, 18},
+		{0, 2, 4, 5, 7, 10, 12, 14, 16, 18, 18, 18, 18},
 		/* 5G, path B/MAC 1, decrease power */
-		{0, 2, 3, 6, 8, 9,	11, 13, 14, 16, 17, 18, 18},
+		{0, 2, 3, 6, 8, 9, 11, 13, 14, 16, 17, 18, 18},
 		/* 5G, path B/MAC 1, increase power */
-		{0, 2, 4, 5, 7, 10,	13, 16, 16, 18, 18, 18, 18},
+		{0, 2, 4, 5, 7, 10, 13, 16, 16, 18, 18, 18, 18},
 		/* 2.4G, for decreas power */
-		{0, 1, 2, 3, 4, 5,	6, 7, 7, 8, 9, 10, 10},
+		{0, 1, 2, 3, 4, 5, 6, 7, 7, 8, 9, 10, 10},
 	};
 	static const u8 index_mapping_internal_pa[8][INDEX_MAPPING_NUM] = {
 		/* 5G, path A/MAC 0, ch36-64, decrease power  */
-		{0, 1, 2, 4, 6, 7,	9, 11, 12, 14, 15, 16, 16},
+		{0, 1, 2, 4, 6, 7, 9, 11, 12, 14, 15, 16, 16},
 		/* 5G, path A/MAC 0, ch36-64, increase power  */
-		{0, 2, 4, 5, 7, 10,	12, 14, 16, 18, 18, 18, 18},
+		{0, 2, 4, 5, 7, 10, 12, 14, 16, 18, 18, 18, 18},
 		/* 5G, path A/MAC 0, ch100-165, decrease power  */
-		{0, 1, 2, 3, 5, 6,	8, 10, 11, 13, 14, 15, 15},
+		{0, 1, 2, 3, 5, 6, 8, 10, 11, 13, 14, 15, 15},
 		/* 5G, path A/MAC 0, ch100-165, increase power  */
-		{0, 2, 4, 5, 7, 10,	12, 14, 16, 18, 18, 18, 18},
+		{0, 2, 4, 5, 7, 10, 12, 14, 16, 18, 18, 18, 18},
 		/* 5G, path B/MAC 1, ch36-64, decrease power */
-		{0, 1, 2, 4, 6, 7,	9, 11, 12, 14, 15, 16, 16},
+		{0, 1, 2, 4, 6, 7, 9, 11, 12, 14, 15, 16, 16},
 		/* 5G, path B/MAC 1, ch36-64, increase power */
-		{0, 2, 4, 5, 7, 10,	13, 16, 16, 18, 18, 18, 18},
+		{0, 2, 4, 5, 7, 10, 13, 16, 16, 18, 18, 18, 18},
 		/* 5G, path B/MAC 1, ch100-165, decrease power */
-		{0, 1, 2, 3, 5, 6,	8, 9, 10, 12, 13, 14, 14},
+		{0, 1, 2, 3, 5, 6, 8, 9, 10, 12, 13, 14, 14},
 		/* 5G, path B/MAC 1, ch100-165, increase power */
-		{0, 2, 4, 5, 7, 10,	13, 16, 16, 18, 18, 18, 18},
+		{0, 2, 4, 5, 7, 10, 13, 16, 16, 18, 18, 18, 18},
 	};
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtlpriv);
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct rtl_dm *dm = &rtlpriv->dm;
 	u8 thermalvalue, delta, delta_lck, delta_iqk, delta_rxgain;
+	u8 ofdm_min_index = 6, ofdm_min_index_internal_pa = 3, rf;
+	long ele_a = 0, ele_d, temp_cck, val_x, value32;
+	bool is2t = IS_92D_SINGLEPHY(rtlhal->version);
 	u8 offset, thermalvalue_avg_count = 0;
+	u8 ofdm_index_old[2] = {0, 0};
 	u32 thermalvalue_avg = 0;
 	bool internal_pa = false;
-	long ele_a = 0, ele_d, temp_cck, val_x, value32;
 	long val_y, ele_c = 0;
+	s8 cck_index_old = 0;
+	u8 indexforchannel;
 	u8 ofdm_index[2];
 	s8 cck_index = 0;
-	u8 ofdm_index_old[2] = {0, 0};
-	s8 cck_index_old = 0;
-	u8 index;
+	u8 index, swing;
 	int i;
-	bool is2t = IS_92D_SINGLEPHY(rtlhal->version);
-	u8 ofdm_min_index = 6, ofdm_min_index_internal_pa = 3, rf;
-	u8 indexforchannel =
-	    rtl92d_get_rightchnlplace_for_iqk(rtlphy->current_channel);
 
-	rtlpriv->dm.txpower_trackinginit = true;
+	indexforchannel = rtl92d_get_rightchnlplace_for_iqk(rtlphy->current_channel);
+
+	dm->txpower_trackinginit = true;
+
 	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "\n");
+
 	thermalvalue = (u8)rtl_get_rfreg(hw, RF90_PATH_A, RF_T_METER, 0xf800);
+
 	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
 		thermalvalue,
-		rtlpriv->dm.thermalvalue, rtlefuse->eeprom_thermalmeter);
+		dm->thermalvalue, rtlefuse->eeprom_thermalmeter);
 
 	if (!thermalvalue)
 		goto exit;
@@ -312,10 +322,11 @@ rtl92d_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw *hw)
 	else
 		rf = 1;
 
-	if (rtlpriv->dm.thermalvalue && !rtlhal->reloadtxpowerindex)
+	if (dm->thermalvalue && !rtlhal->reloadtxpowerindex)
 		goto old_index_done;
 
-	ele_d = rtl_get_bbreg(hw, ROFDM0_XATXIQIMBALANCE,  MASKDWORD) & MASKOFDM_D;
+	ele_d = rtl_get_bbreg(hw, ROFDM0_XATXIQIMBALANCE, MASKDWORD) & MASKOFDM_D;
+
 	for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {
 		if (ele_d == (ofdmswing_table[i] & MASKOFDM_D)) {
 			ofdm_index_old[0] = (u8)i;
@@ -327,13 +338,15 @@ rtl92d_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw *hw)
 			break;
 		}
 	}
+
 	if (is2t) {
-		ele_d = rtl_get_bbreg(hw, ROFDM0_XBTXIQIMBALANCE,
-				      MASKDWORD) & MASKOFDM_D;
+		ele_d = rtl_get_bbreg(hw, ROFDM0_XBTXIQIMBALANCE, MASKDWORD);
+		ele_d &= MASKOFDM_D;
+
 		for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {
-			if (ele_d ==
-			    (ofdmswing_table[i] & MASKOFDM_D)) {
+			if (ele_d == (ofdmswing_table[i] & MASKOFDM_D)) {
 				ofdm_index_old[1] = (u8)i;
+
 				rtl_dbg(rtlpriv, COMP_POWER_TRACKING,
 					DBG_LOUD,
 					"Initial pathB ele_d reg 0x%x = 0x%lx, ofdm_index = 0x%x\n",
@@ -343,6 +356,7 @@ rtl92d_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw *hw)
 			}
 		}
 	}
+
 	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 		rtl92d_bandtype_2_4G(hw, &temp_cck, &cck_index_old);
 	} else {
@@ -350,115 +364,113 @@ rtl92d_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw *hw)
 		cck_index_old = 12;
 	}
 
-	if (!rtlpriv->dm.thermalvalue) {
-		rtlpriv->dm.thermalvalue = rtlefuse->eeprom_thermalmeter;
-		rtlpriv->dm.thermalvalue_lck = thermalvalue;
-		rtlpriv->dm.thermalvalue_iqk = thermalvalue;
-		rtlpriv->dm.thermalvalue_rxgain = rtlefuse->eeprom_thermalmeter;
+	if (!dm->thermalvalue) {
+		dm->thermalvalue = rtlefuse->eeprom_thermalmeter;
+		dm->thermalvalue_lck = thermalvalue;
+		dm->thermalvalue_iqk = thermalvalue;
+		dm->thermalvalue_rxgain = rtlefuse->eeprom_thermalmeter;
+
 		for (i = 0; i < rf; i++)
-			rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];
-		rtlpriv->dm.cck_index = cck_index_old;
+			dm->ofdm_index[i] = ofdm_index_old[i];
+
+		dm->cck_index = cck_index_old;
 	}
+
 	if (rtlhal->reloadtxpowerindex) {
 		for (i = 0; i < rf; i++)
-			rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];
-		rtlpriv->dm.cck_index = cck_index_old;
+			dm->ofdm_index[i] = ofdm_index_old[i];
+
+		dm->cck_index = cck_index_old;
+
 		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			"reload ofdm index for band switch\n");
 	}
+
 old_index_done:
 	for (i = 0; i < rf; i++)
-		ofdm_index[i] = rtlpriv->dm.ofdm_index[i];
+		ofdm_index[i] = dm->ofdm_index[i];
+
+	dm->thermalvalue_avg[dm->thermalvalue_avg_index] = thermalvalue;
+	dm->thermalvalue_avg_index++;
+
+	if (dm->thermalvalue_avg_index == AVG_THERMAL_NUM)
+		dm->thermalvalue_avg_index = 0;
 
-	rtlpriv->dm.thermalvalue_avg
-		    [rtlpriv->dm.thermalvalue_avg_index] = thermalvalue;
-	rtlpriv->dm.thermalvalue_avg_index++;
-	if (rtlpriv->dm.thermalvalue_avg_index == AVG_THERMAL_NUM)
-		rtlpriv->dm.thermalvalue_avg_index = 0;
 	for (i = 0; i < AVG_THERMAL_NUM; i++) {
-		if (rtlpriv->dm.thermalvalue_avg[i]) {
-			thermalvalue_avg += rtlpriv->dm.thermalvalue_avg[i];
+		if (dm->thermalvalue_avg[i]) {
+			thermalvalue_avg += dm->thermalvalue_avg[i];
 			thermalvalue_avg_count++;
 		}
 	}
+
 	if (thermalvalue_avg_count)
 		thermalvalue = (u8)(thermalvalue_avg / thermalvalue_avg_count);
+
 	if (rtlhal->reloadtxpowerindex) {
-		delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
-		    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
-		    (rtlefuse->eeprom_thermalmeter - thermalvalue);
+		delta = abs_diff(thermalvalue, rtlefuse->eeprom_thermalmeter);
 		rtlhal->reloadtxpowerindex = false;
-		rtlpriv->dm.done_txpower = false;
-	} else if (rtlpriv->dm.done_txpower) {
-		delta = (thermalvalue > rtlpriv->dm.thermalvalue) ?
-		    (thermalvalue - rtlpriv->dm.thermalvalue) :
-		    (rtlpriv->dm.thermalvalue - thermalvalue);
+		dm->done_txpower = false;
+	} else if (dm->done_txpower) {
+		delta = abs_diff(thermalvalue, dm->thermalvalue);
 	} else {
-		delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
-		    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
-		    (rtlefuse->eeprom_thermalmeter - thermalvalue);
+		delta = abs_diff(thermalvalue, rtlefuse->eeprom_thermalmeter);
 	}
-	delta_lck = (thermalvalue > rtlpriv->dm.thermalvalue_lck) ?
-	    (thermalvalue - rtlpriv->dm.thermalvalue_lck) :
-	    (rtlpriv->dm.thermalvalue_lck - thermalvalue);
-	delta_iqk = (thermalvalue > rtlpriv->dm.thermalvalue_iqk) ?
-	    (thermalvalue - rtlpriv->dm.thermalvalue_iqk) :
-	    (rtlpriv->dm.thermalvalue_iqk - thermalvalue);
-	delta_rxgain =
-		(thermalvalue > rtlpriv->dm.thermalvalue_rxgain) ?
-		(thermalvalue - rtlpriv->dm.thermalvalue_rxgain) :
-		(rtlpriv->dm.thermalvalue_rxgain - thermalvalue);
+
+	delta_lck = abs_diff(thermalvalue, dm->thermalvalue_lck);
+	delta_iqk = abs_diff(thermalvalue, dm->thermalvalue_iqk);
+	delta_rxgain = abs_diff(thermalvalue, dm->thermalvalue_rxgain);
+
 	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
-		thermalvalue, rtlpriv->dm.thermalvalue,
-		rtlefuse->eeprom_thermalmeter, delta, delta_lck,
-		delta_iqk);
+		thermalvalue, dm->thermalvalue, rtlefuse->eeprom_thermalmeter,
+		delta, delta_lck, delta_iqk);
+
 	if (delta_lck > rtlefuse->delta_lck && rtlefuse->delta_lck != 0) {
-		rtlpriv->dm.thermalvalue_lck = thermalvalue;
+		dm->thermalvalue_lck = thermalvalue;
 		rtlpriv->cfg->ops->phy_lc_calibrate(hw, is2t);
 	}
 
-	if (delta == 0 || !rtlpriv->dm.txpower_track_control)
+	if (delta == 0 || !dm->txpower_track_control)
 		goto check_delta;
 
-	rtlpriv->dm.done_txpower = true;
-	delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
-	    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
-	    (rtlefuse->eeprom_thermalmeter - thermalvalue);
+	dm->done_txpower = true;
+	delta = abs_diff(thermalvalue, rtlefuse->eeprom_thermalmeter);
+
 	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 		offset = 4;
 		if (delta > INDEX_MAPPING_NUM - 1)
 			index = index_mapping[offset][INDEX_MAPPING_NUM - 1];
 		else
 			index = index_mapping[offset][delta];
-		if (thermalvalue > rtlpriv->dm.thermalvalue) {
+
+		if (thermalvalue > dm->thermalvalue) {
 			for (i = 0; i < rf; i++)
 				ofdm_index[i] -= delta;
+
 			cck_index -= delta;
 		} else {
 			for (i = 0; i < rf; i++)
 				ofdm_index[i] += index;
+
 			cck_index += index;
 		}
 	} else if (rtlhal->current_bandtype == BAND_ON_5G) {
-		rtl92d_bandtype_5G(rtlhal, ofdm_index,
-				   &internal_pa, thermalvalue,
-				   delta, rf, rtlefuse, rtlpriv,
+		rtl92d_bandtype_5G(rtlhal, ofdm_index, &internal_pa,
+				   thermalvalue, delta, rf, rtlefuse, rtlpriv,
 				   rtlphy, index_mapping,
 				   index_mapping_internal_pa);
 	}
+
 	if (is2t) {
 		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			"temp OFDM_A_index=0x%x, OFDM_B_index = 0x%x,cck_index=0x%x\n",
-			rtlpriv->dm.ofdm_index[0],
-			rtlpriv->dm.ofdm_index[1],
-			rtlpriv->dm.cck_index);
+			"temp OFDM_A_index=0x%x, OFDM_B_index = 0x%x, cck_index=0x%x\n",
+			dm->ofdm_index[0], dm->ofdm_index[1], dm->cck_index);
 	} else {
 		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			"temp OFDM_A_index=0x%x,cck_index = 0x%x\n",
-			rtlpriv->dm.ofdm_index[0],
-			rtlpriv->dm.cck_index);
+			"temp OFDM_A_index=0x%x, cck_index = 0x%x\n",
+			dm->ofdm_index[0], dm->cck_index);
 	}
+
 	for (i = 0; i < rf; i++) {
 		if (ofdm_index[i] > OFDM_TABLE_SIZE_92D - 1) {
 			ofdm_index[i] = OFDM_TABLE_SIZE_92D - 1;
@@ -470,25 +482,28 @@ rtl92d_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw *hw)
 			ofdm_index[i] = ofdm_min_index;
 		}
 	}
+
 	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 		if (cck_index > CCK_TABLE_SIZE - 1)
 			cck_index = CCK_TABLE_SIZE - 1;
 		else if (cck_index < 0)
 			cck_index = 0;
 	}
+
 	if (is2t) {
 		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			"new OFDM_A_index=0x%x, OFDM_B_index = 0x%x, cck_index=0x%x\n",
-			ofdm_index[0], ofdm_index[1],
-			cck_index);
+			ofdm_index[0], ofdm_index[1], cck_index);
 	} else {
 		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			"new OFDM_A_index=0x%x,cck_index = 0x%x\n",
+			"new OFDM_A_index=0x%x, cck_index = 0x%x\n",
 			ofdm_index[0], cck_index);
 	}
+
 	ele_d = (ofdmswing_table[ofdm_index[0]] & 0xFFC00000) >> 22;
 	val_x = rtlphy->iqk_matrix[indexforchannel].value[0][0];
 	val_y = rtlphy->iqk_matrix[indexforchannel].value[0][1];
+
 	if (val_x != 0) {
 		if ((val_x & 0x00000200) != 0)
 			val_x = val_x | 0xFFFFFC00;
@@ -507,21 +522,16 @@ rtl92d_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw *hw)
 			      MASKDWORD, value32);
 
 		value32 = (ele_c & 0x000003C0) >> 6;
-		rtl_set_bbreg(hw, ROFDM0_XCTXAFE, MASKH4BITS,
-			      value32);
+		rtl_set_bbreg(hw, ROFDM0_XCTXAFE, MASKH4BITS, value32);
 
 		value32 = ((val_x * ele_d) >> 7) & 0x01;
-		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(24),
-			      value32);
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(24), value32);
 
 	} else {
-		rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE,
-			      MASKDWORD,
-			      ofdmswing_table[(u8)ofdm_index[0]]);
-		rtl_set_bbreg(hw, ROFDM0_XCTXAFE, MASKH4BITS,
-			      0x00);
-		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
-			      BIT(24), 0x00);
+		rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE, MASKDWORD,
+			      ofdmswing_table[ofdm_index[0]]);
+		rtl_set_bbreg(hw, ROFDM0_XCTXAFE, MASKH4BITS, 0x00);
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(24), 0x00);
 	}
 
 	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
@@ -530,109 +540,79 @@ rtl92d_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw *hw)
 		val_x, val_y, ele_a, ele_c, ele_d,
 		val_x, val_y);
 
-	if (cck_index >= CCK_TABLE_SIZE)
-		cck_index = CCK_TABLE_SIZE - 1;
-	if (cck_index < 0)
-		cck_index = 0;
 	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 		/* Adjust CCK according to IQK result */
-		if (!rtlpriv->dm.cck_inch14) {
-			rtl_write_byte(rtlpriv, 0xa22,
-				       cckswing_table_ch1ch13[cck_index][0]);
-			rtl_write_byte(rtlpriv, 0xa23,
-				       cckswing_table_ch1ch13[cck_index][1]);
-			rtl_write_byte(rtlpriv, 0xa24,
-				       cckswing_table_ch1ch13[cck_index][2]);
-			rtl_write_byte(rtlpriv, 0xa25,
-				       cckswing_table_ch1ch13[cck_index][3]);
-			rtl_write_byte(rtlpriv, 0xa26,
-				       cckswing_table_ch1ch13[cck_index][4]);
-			rtl_write_byte(rtlpriv, 0xa27,
-				       cckswing_table_ch1ch13[cck_index][5]);
-			rtl_write_byte(rtlpriv, 0xa28,
-				       cckswing_table_ch1ch13[cck_index][6]);
-			rtl_write_byte(rtlpriv, 0xa29,
-				       cckswing_table_ch1ch13[cck_index][7]);
-		} else {
-			rtl_write_byte(rtlpriv, 0xa22,
-				       cckswing_table_ch14[cck_index][0]);
-			rtl_write_byte(rtlpriv, 0xa23,
-				       cckswing_table_ch14[cck_index][1]);
-			rtl_write_byte(rtlpriv, 0xa24,
-				       cckswing_table_ch14[cck_index][2]);
-			rtl_write_byte(rtlpriv, 0xa25,
-				       cckswing_table_ch14[cck_index][3]);
-			rtl_write_byte(rtlpriv, 0xa26,
-				       cckswing_table_ch14[cck_index][4]);
-			rtl_write_byte(rtlpriv, 0xa27,
-				       cckswing_table_ch14[cck_index][5]);
-			rtl_write_byte(rtlpriv, 0xa28,
-				       cckswing_table_ch14[cck_index][6]);
-			rtl_write_byte(rtlpriv, 0xa29,
-				       cckswing_table_ch14[cck_index][7]);
+		for (i = 0; i < 8; i++) {
+			if (dm->cck_inch14)
+				swing = cckswing_table_ch14[cck_index][i];
+			else
+				swing = cckswing_table_ch1ch13[cck_index][i];
+
+			rtl_write_byte(rtlpriv, 0xa22 + i, swing);
 		}
 	}
+
 	if (is2t) {
 		ele_d = (ofdmswing_table[ofdm_index[1]] & 0xFFC00000) >> 22;
 		val_x = rtlphy->iqk_matrix[indexforchannel].value[0][4];
 		val_y = rtlphy->iqk_matrix[indexforchannel].value[0][5];
+
 		if (val_x != 0) {
 			if ((val_x & 0x00000200) != 0)
 				/* consider minus */
 				val_x = val_x | 0xFFFFFC00;
 			ele_a = ((val_x * ele_d) >> 8) & 0x000003FF;
+
 			/* new element C = element D x Y */
 			if ((val_y & 0x00000200) != 0)
 				val_y = val_y | 0xFFFFFC00;
 			ele_c = ((val_y * ele_d) >> 8) & 0x00003FF;
+
 			/* write new elements A, C, D to regC88
 			 * and regC9C, element B is always 0
 			 */
 			value32 = (ele_d << 22) | ((ele_c & 0x3F) << 16) | ele_a;
-			rtl_set_bbreg(hw,
-				      ROFDM0_XBTXIQIMBALANCE,
+			rtl_set_bbreg(hw, ROFDM0_XBTXIQIMBALANCE,
 				      MASKDWORD, value32);
+
 			value32 = (ele_c & 0x000003C0) >> 6;
-			rtl_set_bbreg(hw, ROFDM0_XDTXAFE,
-				      MASKH4BITS, value32);
+			rtl_set_bbreg(hw, ROFDM0_XDTXAFE, MASKH4BITS, value32);
+
 			value32 = ((val_x * ele_d) >> 7) & 0x01;
-			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
-				      BIT(28), value32);
+			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(28), value32);
 		} else {
-			rtl_set_bbreg(hw,
-				      ROFDM0_XBTXIQIMBALANCE,
-				      MASKDWORD,
-				      ofdmswing_table[ofdm_index[1]]);
-			rtl_set_bbreg(hw, ROFDM0_XDTXAFE,
-				      MASKH4BITS, 0x00);
-			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
-				      BIT(28), 0x00);
+			rtl_set_bbreg(hw, ROFDM0_XBTXIQIMBALANCE,
+				      MASKDWORD, ofdmswing_table[ofdm_index[1]]);
+			rtl_set_bbreg(hw, ROFDM0_XDTXAFE, MASKH4BITS, 0x00);
+			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(28), 0x00);
 		}
+
 		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			"TxPwrTracking path B: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xeb4 = 0x%lx 0xebc = 0x%lx\n",
-			val_x, val_y, ele_a, ele_c,
-			ele_d, val_x, val_y);
+			val_x, val_y, ele_a, ele_c, ele_d, val_x, val_y);
 	}
+
 	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		"TxPwrTracking 0xc80 = 0x%x, 0xc94 = 0x%x RF 0x24 = 0x%x\n",
 		rtl_get_bbreg(hw, 0xc80, MASKDWORD),
 		rtl_get_bbreg(hw, 0xc94, MASKDWORD),
-		rtl_get_rfreg(hw, RF90_PATH_A, 0x24,
-			      RFREG_OFFSET_MASK));
+		rtl_get_rfreg(hw, RF90_PATH_A, 0x24, RFREG_OFFSET_MASK));
 
 check_delta:
 	if (delta_iqk > rtlefuse->delta_iqk && rtlefuse->delta_iqk != 0) {
 		rtl92d_phy_reset_iqk_result(hw);
-		rtlpriv->dm.thermalvalue_iqk = thermalvalue;
+		dm->thermalvalue_iqk = thermalvalue;
 		rtlpriv->cfg->ops->phy_iq_calibrate(hw);
 	}
+
 	if (delta_rxgain > 0 && rtlhal->current_bandtype == BAND_ON_5G &&
 	    thermalvalue <= rtlefuse->eeprom_thermalmeter) {
-		rtlpriv->dm.thermalvalue_rxgain = thermalvalue;
+		dm->thermalvalue_rxgain = thermalvalue;
 		rtl92d_dm_rxgain_tracking_thermalmeter(hw);
 	}
-	if (rtlpriv->dm.txpower_track_control)
-		rtlpriv->dm.thermalvalue = thermalvalue;
+
+	if (dm->txpower_track_control)
+		dm->thermalvalue = thermalvalue;
 
 exit:
 	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "<===\n");
@@ -675,25 +655,29 @@ EXPORT_SYMBOL_GPL(rtl92d_dm_check_txpower_tracking_thermal_meter);
 
 void rtl92d_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 {
-	u32 ret_value;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct false_alarm_statistics *falsealm_cnt = &rtlpriv->falsealm_cnt;
 	unsigned long flag = 0;
+	u32 ret_value;
 
 	/* hold ofdm counter */
 	rtl_set_bbreg(hw, ROFDM0_LSTF, BIT(31), 1); /* hold page C counter */
-	rtl_set_bbreg(hw, ROFDM1_LSTF, BIT(31), 1); /*hold page D counter */
+	rtl_set_bbreg(hw, ROFDM1_LSTF, BIT(31), 1); /* hold page D counter */
 
 	ret_value = rtl_get_bbreg(hw, ROFDM0_FRAMESYNC, MASKDWORD);
-	falsealm_cnt->cnt_fast_fsync_fail = (ret_value & 0xffff);
-	falsealm_cnt->cnt_sb_search_fail = ((ret_value & 0xffff0000) >> 16);
+	falsealm_cnt->cnt_fast_fsync_fail = ret_value & 0xffff;
+	falsealm_cnt->cnt_sb_search_fail = (ret_value & 0xffff0000) >> 16;
+
 	ret_value = rtl_get_bbreg(hw, ROFDM_PHYCOUNTER1, MASKDWORD);
-	falsealm_cnt->cnt_parity_fail = ((ret_value & 0xffff0000) >> 16);
+	falsealm_cnt->cnt_parity_fail = (ret_value & 0xffff0000) >> 16;
+
 	ret_value = rtl_get_bbreg(hw, ROFDM_PHYCOUNTER2, MASKDWORD);
-	falsealm_cnt->cnt_rate_illegal = (ret_value & 0xffff);
-	falsealm_cnt->cnt_crc8_fail = ((ret_value & 0xffff0000) >> 16);
+	falsealm_cnt->cnt_rate_illegal = ret_value & 0xffff;
+	falsealm_cnt->cnt_crc8_fail = (ret_value & 0xffff0000) >> 16;
+
 	ret_value = rtl_get_bbreg(hw, ROFDM_PHYCOUNTER3, MASKDWORD);
-	falsealm_cnt->cnt_mcs_fail = (ret_value & 0xffff);
+	falsealm_cnt->cnt_mcs_fail = ret_value & 0xffff;
+
 	falsealm_cnt->cnt_ofdm_fail = falsealm_cnt->cnt_parity_fail +
 				      falsealm_cnt->cnt_rate_illegal +
 				      falsealm_cnt->cnt_crc8_fail +
@@ -702,7 +686,6 @@ void rtl92d_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 				      falsealm_cnt->cnt_sb_search_fail;
 
 	if (rtlpriv->rtlhal.current_bandtype != BAND_ON_5G) {
-		/* hold cck counter */
 		rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
 		ret_value = rtl_get_bbreg(hw, RCCK0_FACOUNTERLOWER, MASKBYTE0);
 		falsealm_cnt->cnt_cck_fail = ret_value;
@@ -713,22 +696,17 @@ void rtl92d_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 		falsealm_cnt->cnt_cck_fail = 0;
 	}
 
-	/* reset false alarm counter registers */
-	falsealm_cnt->cnt_all = falsealm_cnt->cnt_fast_fsync_fail +
-				falsealm_cnt->cnt_sb_search_fail +
-				falsealm_cnt->cnt_parity_fail +
-				falsealm_cnt->cnt_rate_illegal +
-				falsealm_cnt->cnt_crc8_fail +
-				falsealm_cnt->cnt_mcs_fail +
+	falsealm_cnt->cnt_all = falsealm_cnt->cnt_ofdm_fail +
 				falsealm_cnt->cnt_cck_fail;
 
+	/* reset false alarm counter registers */
 	rtl_set_bbreg(hw, ROFDM1_LSTF, 0x08000000, 1);
-	/* update ofdm counter */
 	rtl_set_bbreg(hw, ROFDM1_LSTF, 0x08000000, 0);
-	/* update page C counter */
-	rtl_set_bbreg(hw, ROFDM0_LSTF, BIT(31), 0);
-	/* update page D counter */
-	rtl_set_bbreg(hw, ROFDM1_LSTF, BIT(31), 0);
+
+	/* update ofdm counter */
+	rtl_set_bbreg(hw, ROFDM0_LSTF, BIT(31), 0); /* update page C counter */
+	rtl_set_bbreg(hw, ROFDM1_LSTF, BIT(31), 0); /* update page D counter */
+
 	if (rtlpriv->rtlhal.current_bandtype != BAND_ON_5G) {
 		/* reset cck counter */
 		rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
@@ -737,16 +715,19 @@ void rtl92d_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 		rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, 0x0000c000, 2);
 		rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
 	}
+
 	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
 		"Cnt_Fast_Fsync_fail = %x, Cnt_SB_Search_fail = %x\n",
 		falsealm_cnt->cnt_fast_fsync_fail,
 		falsealm_cnt->cnt_sb_search_fail);
+
 	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
 		"Cnt_Parity_Fail = %x, Cnt_Rate_Illegal = %x, Cnt_Crc8_fail = %x, Cnt_Mcs_fail = %x\n",
 		falsealm_cnt->cnt_parity_fail,
 		falsealm_cnt->cnt_rate_illegal,
 		falsealm_cnt->cnt_crc8_fail,
 		falsealm_cnt->cnt_mcs_fail);
+
 	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
 		"Cnt_Ofdm_fail = %x, Cnt_Cck_fail = %x, Cnt_all = %x\n",
 		falsealm_cnt->cnt_ofdm_fail,
@@ -763,7 +744,7 @@ void rtl92d_dm_find_minimum_rssi(struct ieee80211_hw *hw)
 
 	/* Determine the minimum RSSI  */
 	if (mac->link_state < MAC80211_LINKED &&
-	    rtlpriv->dm.UNDEC_SM_PWDB == 0) {
+	    rtlpriv->dm.entry_min_undec_sm_pwdb == 0) {
 		de_digtable->min_undec_pwdb_for_dm = 0;
 		rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
 			"Not connected to any\n");
@@ -772,19 +753,20 @@ void rtl92d_dm_find_minimum_rssi(struct ieee80211_hw *hw)
 		if (mac->opmode == NL80211_IFTYPE_AP ||
 		    mac->opmode == NL80211_IFTYPE_ADHOC) {
 			de_digtable->min_undec_pwdb_for_dm =
-			    rtlpriv->dm.UNDEC_SM_PWDB;
+				rtlpriv->dm.entry_min_undec_sm_pwdb;
 			rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
 				"AP Client PWDB = 0x%lx\n",
-				 rtlpriv->dm.UNDEC_SM_PWDB);
+				 rtlpriv->dm.entry_min_undec_sm_pwdb);
 		} else {
 			de_digtable->min_undec_pwdb_for_dm =
-			    rtlpriv->dm.undec_sm_pwdb;
+				rtlpriv->dm.undec_sm_pwdb;
 			rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
 				"STA Default Port PWDB = 0x%x\n",
 				de_digtable->min_undec_pwdb_for_dm);
 		}
 	} else {
-		de_digtable->min_undec_pwdb_for_dm = rtlpriv->dm.UNDEC_SM_PWDB;
+		de_digtable->min_undec_pwdb_for_dm =
+			rtlpriv->dm.entry_min_undec_sm_pwdb;
 		rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
 			"AP Ext Port or disconnect PWDB = 0x%x\n",
 			de_digtable->min_undec_pwdb_for_dm);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.h
index 9dc0df5bb068..a146fc975421 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.h
@@ -48,27 +48,6 @@
 #define TX_POWER_NEAR_FIELD_THRESH_LVL1		67
 #define INDEX_MAPPING_NUM			13
 
-struct swat {
-	u8 failure_cnt;
-	u8 try_flag;
-	u8 stop_trying;
-	long pre_rssi;
-	long trying_threshold;
-	u8 cur_antenna;
-	u8 pre_antenna;
-};
-
-enum tag_dynamic_init_gain_operation_type_definition {
-	DIG_TYPE_THRESH_HIGH = 0,
-	DIG_TYPE_THRESH_LOW = 1,
-	DIG_TYPE_BACKOFF = 2,
-	DIG_TYPE_RX_GAIN_MIN = 3,
-	DIG_TYPE_RX_GAIN_MAX = 4,
-	DIG_TYPE_ENABLE = 5,
-	DIG_TYPE_DISABLE = 6,
-	DIG_OP_TYPE_MAX
-};
-
 enum dm_1r_cca {
 	CCA_1R = 0,
 	CCA_2R = 1,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
index 73cfa9ad78ae..020d5a9cef7e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
@@ -11,8 +11,7 @@
 
 bool rtl92d_is_fw_downloaded(struct rtl_priv *rtlpriv)
 {
-	return (rtl_read_dword(rtlpriv, REG_MCUFWDL) & MCUFWDL_RDY) ?
-		true : false;
+	return !!(rtl_read_dword(rtlpriv, REG_MCUFWDL) & MCUFWDL_RDY);
 }
 EXPORT_SYMBOL_GPL(rtl92d_is_fw_downloaded);
 
@@ -50,17 +49,22 @@ void rtl92d_write_fw(struct ieee80211_hw *hw,
 	u32 page, offset;
 
 	rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
+
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192DE)
 		rtl_fill_dummy(bufferptr, &size);
+
 	pagenums = size / FW_8192D_PAGE_SIZE;
 	remainsize = size % FW_8192D_PAGE_SIZE;
+
 	if (pagenums > 8)
 		pr_err("Page numbers should not greater then 8\n");
+
 	for (page = 0; page < pagenums; page++) {
 		offset = page * FW_8192D_PAGE_SIZE;
 		rtl_fw_page_write(hw, page, (bufferptr + offset),
 				  FW_8192D_PAGE_SIZE);
 	}
+
 	if (remainsize) {
 		offset = pagenums * FW_8192D_PAGE_SIZE;
 		page = pagenums;
@@ -79,14 +83,17 @@ int rtl92d_fw_free_to_go(struct ieee80211_hw *hw)
 		value32 = rtl_read_dword(rtlpriv, REG_MCUFWDL);
 	} while ((counter++ < FW_8192D_POLLING_TIMEOUT_COUNT) &&
 		 (!(value32 & FWDL_CHKSUM_RPT)));
+
 	if (counter >= FW_8192D_POLLING_TIMEOUT_COUNT) {
 		pr_err("chksum report fail! REG_MCUFWDL:0x%08x\n",
 		       value32);
 		return -EIO;
 	}
+
 	value32 = rtl_read_dword(rtlpriv, REG_MCUFWDL);
 	value32 |= MCUFWDL_RDY;
 	rtl_write_dword(rtlpriv, REG_MCUFWDL, value32);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rtl92d_fw_free_to_go);
@@ -99,7 +106,9 @@ void rtl92d_firmware_selfreset(struct ieee80211_hw *hw)
 
 	/* Set (REG_HMETFR + 3) to  0x20 is reset 8051 */
 	rtl_write_byte(rtlpriv, REG_HMETFR + 3, 0x20);
+
 	u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
+
 	while (u1b_tmp & BIT(2)) {
 		delay--;
 		if (delay == 0)
@@ -174,23 +183,22 @@ static bool _rtl92d_check_fw_read_last_h2c(struct ieee80211_hw *hw, u8 boxnum)
 	return result;
 }
 
-static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
-				     u8 element_id, u32 cmd_len, u8 *cmdbuffer)
+void rtl92d_fill_h2c_cmd(struct ieee80211_hw *hw,
+			 u8 element_id, u32 cmd_len, u8 *cmdbuffer)
 {
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	u8 boxnum;
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 boxcontent[4], boxextcontent[2];
 	u16 box_reg = 0, box_extreg = 0;
-	u8 u1b_tmp;
-	bool isfw_read = false;
-	u8 buf_index = 0;
+	u8 wait_writeh2c_limmit = 100;
 	bool bwrite_success = false;
 	u8 wait_h2c_limmit = 100;
-	u8 wait_writeh2c_limmit = 100;
-	u8 boxcontent[4], boxextcontent[2];
 	u32 h2c_waitcounter = 0;
+	bool isfw_read = false;
 	unsigned long flag;
+	u8 u1b_tmp;
+	u8 boxnum;
 	u8 idx;
 
 	if (ppsc->rfpwr_state == ERFOFF || ppsc->inactive_pwrstate == ERFOFF) {
@@ -198,7 +206,9 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
 			"Return as RF is off!!!\n");
 		return;
 	}
+
 	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "come in\n");
+
 	while (true) {
 		spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
 		if (rtlhal->h2c_setinprogress) {
@@ -228,35 +238,25 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
 			break;
 		}
 	}
+
 	while (!bwrite_success) {
 		wait_writeh2c_limmit--;
 		if (wait_writeh2c_limmit == 0) {
 			pr_err("Write H2C fail because no trigger for FW INT!\n");
 			break;
 		}
+
 		boxnum = rtlhal->last_hmeboxnum;
 		switch (boxnum) {
-		case 0:
-			box_reg = REG_HMEBOX_0;
-			box_extreg = REG_HMEBOX_EXT_0;
-			break;
-		case 1:
-			box_reg = REG_HMEBOX_1;
-			box_extreg = REG_HMEBOX_EXT_1;
-			break;
-		case 2:
-			box_reg = REG_HMEBOX_2;
-			box_extreg = REG_HMEBOX_EXT_2;
-			break;
-		case 3:
-			box_reg = REG_HMEBOX_3;
-			box_extreg = REG_HMEBOX_EXT_3;
+		case 0 ... 3:
+			box_reg = REG_HMEBOX_0 + boxnum * 4;
+			box_extreg = REG_HMEBOX_EXT_0 + boxnum * 2;
 			break;
 		default:
-			pr_err("switch case %#x not processed\n",
-			       boxnum);
+			pr_err("switch case %#x not processed\n", boxnum);
 			break;
 		}
+
 		isfw_read = _rtl92d_check_fw_read_last_h2c(hw, boxnum);
 		while (!isfw_read) {
 			wait_h2c_limmit--;
@@ -266,78 +266,63 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
 					boxnum);
 				break;
 			}
+
 			udelay(10);
+
 			isfw_read = _rtl92d_check_fw_read_last_h2c(hw, boxnum);
 			u1b_tmp = rtl_read_byte(rtlpriv, 0x1BF);
 			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
 				"Waiting for FW read clear HMEBox(%d)!!! 0x1BF = %2x\n",
 				boxnum, u1b_tmp);
 		}
+
 		if (!isfw_read) {
 			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
 				"Write H2C register BOX[%d] fail!!!!! Fw do not read.\n",
 				boxnum);
 			break;
 		}
+
 		memset(boxcontent, 0, sizeof(boxcontent));
 		memset(boxextcontent, 0, sizeof(boxextcontent));
 		boxcontent[0] = element_id;
+
 		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
 			"Write element_id box_reg(%4x) = %2x\n",
 			box_reg, element_id);
+
 		switch (cmd_len) {
-		case 1:
-			boxcontent[0] &= ~(BIT(7));
-			memcpy(boxcontent + 1, cmdbuffer + buf_index, 1);
-			for (idx = 0; idx < 4; idx++)
-				rtl_write_byte(rtlpriv, box_reg + idx,
-					       boxcontent[idx]);
-			break;
-		case 2:
-			boxcontent[0] &= ~(BIT(7));
-			memcpy(boxcontent + 1, cmdbuffer + buf_index, 2);
-			for (idx = 0; idx < 4; idx++)
-				rtl_write_byte(rtlpriv, box_reg + idx,
-					       boxcontent[idx]);
-			break;
-		case 3:
-			boxcontent[0] &= ~(BIT(7));
-			memcpy(boxcontent + 1, cmdbuffer + buf_index, 3);
-			for (idx = 0; idx < 4; idx++)
-				rtl_write_byte(rtlpriv, box_reg + idx,
-					       boxcontent[idx]);
-			break;
-		case 4:
-			boxcontent[0] |= (BIT(7));
-			memcpy(boxextcontent, cmdbuffer + buf_index, 2);
-			memcpy(boxcontent + 1, cmdbuffer + buf_index + 2, 2);
-			for (idx = 0; idx < 2; idx++)
-				rtl_write_byte(rtlpriv, box_extreg + idx,
-					       boxextcontent[idx]);
+		case 1 ... 3:
+			boxcontent[0] &= ~BIT(7);
+			memcpy(boxcontent + 1, cmdbuffer, cmd_len);
+
 			for (idx = 0; idx < 4; idx++)
 				rtl_write_byte(rtlpriv, box_reg + idx,
 					       boxcontent[idx]);
 			break;
-		case 5:
-			boxcontent[0] |= (BIT(7));
-			memcpy(boxextcontent, cmdbuffer + buf_index, 2);
-			memcpy(boxcontent + 1, cmdbuffer + buf_index + 2, 3);
+		case 4 ... 5:
+			boxcontent[0] |= BIT(7);
+			memcpy(boxextcontent, cmdbuffer, 2);
+			memcpy(boxcontent + 1, cmdbuffer + 2, cmd_len - 2);
+
 			for (idx = 0; idx < 2; idx++)
 				rtl_write_byte(rtlpriv, box_extreg + idx,
 					       boxextcontent[idx]);
+
 			for (idx = 0; idx < 4; idx++)
 				rtl_write_byte(rtlpriv, box_reg + idx,
 					       boxcontent[idx]);
 			break;
 		default:
-			pr_err("switch case %#x not processed\n",
-			       cmd_len);
+			pr_err("switch case %#x not processed\n", cmd_len);
 			break;
 		}
+
 		bwrite_success = true;
 		rtlhal->last_hmeboxnum = boxnum + 1;
 		if (rtlhal->last_hmeboxnum == 4)
 			rtlhal->last_hmeboxnum = 0;
+
 		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
 			"pHalData->last_hmeboxnum  = %d\n",
 			rtlhal->last_hmeboxnum);
@@ -347,16 +332,6 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
 	spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock, flag);
 	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "go out\n");
 }
-
-void rtl92d_fill_h2c_cmd(struct ieee80211_hw *hw,
-			 u8 element_id, u32 cmd_len, u8 *cmdbuffer)
-{
-	u32 tmp_cmdbuf[2];
-
-	memset(tmp_cmdbuf, 0, 8);
-	memcpy(tmp_cmdbuf, cmdbuffer, cmd_len);
-	_rtl92d_fill_h2c_command(hw, element_id, cmd_len, (u8 *)&tmp_cmdbuf);
-}
 EXPORT_SYMBOL_GPL(rtl92d_fill_h2c_cmd);
 
 void rtl92d_set_fw_joinbss_report_cmd(struct ieee80211_hw *hw, u8 mstatus)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
index e70e83252e16..3c320a11a332 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
@@ -761,22 +761,24 @@ EXPORT_SYMBOL_GPL(rtl92de_read_eeprom_info);
 static void rtl92de_update_hal_rate_table(struct ieee80211_hw *hw,
 					  struct ieee80211_sta *sta)
 {
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
-	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	u32 ratr_value;
-	u8 ratr_index = 0;
-	u8 nmode = mac->ht_enable;
+	enum wireless_mode wirelessmode;
 	u8 mimo_ps = IEEE80211_SMPS_OFF;
-	u16 shortgi_rate;
-	u32 tmp_ratr_value;
 	u8 curtxbw_40mhz = mac->bw_40;
-	u8 curshortgi_40mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40) ?
-							1 : 0;
-	u8 curshortgi_20mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20) ?
-							1 : 0;
-	enum wireless_mode wirelessmode = mac->mode;
+	u8 nmode = mac->ht_enable;
+	u8 curshortgi_40mhz;
+	u8 curshortgi_20mhz;
+	u32 tmp_ratr_value;
+	u8 ratr_index = 0;
+	u16 shortgi_rate;
+	u32 ratr_value;
+
+	curshortgi_40mhz = !!(sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40);
+	curshortgi_20mhz = !!(sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20);
+	wirelessmode = mac->mode;
 
 	if (rtlhal->current_bandtype == BAND_ON_5G)
 		ratr_value = sta->deflink.supp_rates[1] << 4;
@@ -844,27 +846,30 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 					 struct ieee80211_sta *sta,
 					 u8 rssi_level, bool update_bw)
 {
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
-	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_sta_info *sta_entry = NULL;
+	enum wireless_mode wirelessmode;
+	bool shortgi = false;
+	u8 curshortgi_40mhz;
+	u8 curshortgi_20mhz;
+	u8 curtxbw_40mhz;
 	u32 ratr_bitmap;
 	u8 ratr_index;
-	u8 curtxbw_40mhz = (sta->deflink.bandwidth >= IEEE80211_STA_RX_BW_40) ? 1 : 0;
-	u8 curshortgi_40mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40) ?
-							1 : 0;
-	u8 curshortgi_20mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20) ?
-							1 : 0;
-	enum wireless_mode wirelessmode = 0;
-	bool shortgi = false;
 	u32 value[2];
 	u8 macid = 0;
-	u8 mimo_ps = IEEE80211_SMPS_OFF;
+	u8 mimo_ps;
+
+	curtxbw_40mhz = sta->deflink.bandwidth >= IEEE80211_STA_RX_BW_40;
+	curshortgi_40mhz = !!(sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40);
+	curshortgi_20mhz = !!(sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20);
 
 	sta_entry = (struct rtl_sta_info *)sta->drv_priv;
 	mimo_ps = sta_entry->mimo_ps;
 	wirelessmode = sta_entry->wireless_mode;
+
 	if (mac->opmode == NL80211_IFTYPE_STATION)
 		curtxbw_40mhz = mac->bw_40;
 	else if (mac->opmode == NL80211_IFTYPE_AP ||
@@ -877,6 +882,7 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 		ratr_bitmap = sta->deflink.supp_rates[0];
 	ratr_bitmap |= (sta->deflink.ht_cap.mcs.rx_mask[1] << 20 |
 			sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
+
 	switch (wirelessmode) {
 	case WIRELESS_MODE_B:
 		ratr_index = RATR_INX_WIRELESS_B;
@@ -905,6 +911,7 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 			ratr_index = RATR_INX_WIRELESS_NGB;
 		else
 			ratr_index = RATR_INX_WIRELESS_NG;
+
 		if (mimo_ps == IEEE80211_SMPS_STATIC) {
 			if (rssi_level == 1)
 				ratr_bitmap &= 0x00070000;
@@ -948,6 +955,7 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 				}
 			}
 		}
+
 		if ((curtxbw_40mhz && curshortgi_40mhz) ||
 		    (!curtxbw_40mhz && curshortgi_20mhz)) {
 			if (macid == 0)
@@ -1065,12 +1073,6 @@ void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
 		     u8 *p_macaddr, bool is_group, u8 enc_algo,
 		     bool is_wepkey, bool clear_all)
 {
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	const u8 *macaddr = p_macaddr;
-	u32 entry_id;
-	bool is_pairwise = false;
 	static const u8 cam_const_addr[4][6] = {
 		{0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
 		{0x00, 0x00, 0x00, 0x00, 0x00, 0x01},
@@ -1080,6 +1082,12 @@ void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
 	static const u8 cam_const_broad[] = {
 		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
 	};
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	const u8 *macaddr = p_macaddr;
+	bool is_pairwise = false;
+	u32 entry_id;
 
 	if (clear_all) {
 		u8 idx;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
index 87c458b27f4f..346e7a34b069 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
@@ -41,8 +41,7 @@ static u32 _rtl92d_phy_rf_serial_read(struct ieee80211_hw *hw,
 		      tmplong & (~BLSSIREADEDGE));
 	udelay(10);
 	rtl_set_bbreg(hw, pphyreg->rfhssi_para2, MASKDWORD, tmplong2);
-	udelay(50);
-	udelay(50);
+	udelay(100);
 	rtl_set_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2, MASKDWORD,
 		      tmplong | BLSSIREADEDGE);
 	udelay(10);
@@ -319,23 +318,21 @@ void rtl92d_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 
 	rtlphy->default_initialgain[0] =
-	    (u8)rtl_get_bbreg(hw, ROFDM0_XAAGCCORE1, MASKBYTE0);
+	    rtl_get_bbreg(hw, ROFDM0_XAAGCCORE1, MASKBYTE0);
 	rtlphy->default_initialgain[1] =
-	    (u8)rtl_get_bbreg(hw, ROFDM0_XBAGCCORE1, MASKBYTE0);
+	    rtl_get_bbreg(hw, ROFDM0_XBAGCCORE1, MASKBYTE0);
 	rtlphy->default_initialgain[2] =
-	    (u8)rtl_get_bbreg(hw, ROFDM0_XCAGCCORE1, MASKBYTE0);
+	    rtl_get_bbreg(hw, ROFDM0_XCAGCCORE1, MASKBYTE0);
 	rtlphy->default_initialgain[3] =
-	    (u8)rtl_get_bbreg(hw, ROFDM0_XDAGCCORE1, MASKBYTE0);
+	    rtl_get_bbreg(hw, ROFDM0_XDAGCCORE1, MASKBYTE0);
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
 		"Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x\n",
 		rtlphy->default_initialgain[0],
 		rtlphy->default_initialgain[1],
 		rtlphy->default_initialgain[2],
 		rtlphy->default_initialgain[3]);
-	rtlphy->framesync = (u8)rtl_get_bbreg(hw, ROFDM0_RXDETECTOR3,
-					      MASKBYTE0);
-	rtlphy->framesync_c34 = rtl_get_bbreg(hw, ROFDM0_RXDETECTOR2,
-					      MASKDWORD);
+	rtlphy->framesync = rtl_get_bbreg(hw, ROFDM0_RXDETECTOR3, MASKBYTE0);
+	rtlphy->framesync_c34 = rtl_get_bbreg(hw, ROFDM0_RXDETECTOR2, MASKDWORD);
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
 		"Default framesync (0x%x) = 0x%x\n",
 		ROFDM0_RXDETECTOR3, rtlphy->framesync);
@@ -349,7 +346,7 @@ static void _rtl92d_get_txpower_index(struct ieee80211_hw *hw, u8 channel,
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	u8 index = (channel - 1);
+	u8 index = channel - 1;
 
 	/* 1. CCK */
 	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c
index 8af166183688..90ed6e32375b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c
@@ -157,6 +157,31 @@ static void _rtl92d_phy_get_power_base(struct ieee80211_hw *hw,
 	}
 }
 
+static void _rtl92d_get_pwr_diff_limit(struct ieee80211_hw *hw, u8 channel,
+				       u8 index, u8 rf, u8 pwr_diff_limit[4])
+{
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u32 mcs_offset;
+	u8 limit;
+	int i;
+
+	mcs_offset = rtlphy->mcs_offset[0][index + (rf ? 8 : 0)];
+
+	for (i = 0; i < 4; i++) {
+		pwr_diff_limit[i] = (mcs_offset >> (i * 8)) & 0x7f;
+
+		if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40)
+			limit = rtlefuse->pwrgroup_ht40[rf][channel - 1];
+		else
+			limit = rtlefuse->pwrgroup_ht20[rf][channel - 1];
+
+		if (pwr_diff_limit[i] > limit)
+			pwr_diff_limit[i] = limit;
+	}
+}
+
 static void _rtl92d_get_txpower_writeval_by_regulatory(struct ieee80211_hw *hw,
 						       u8 channel, u8 index,
 						       u32 *powerbase0,
@@ -166,107 +191,86 @@ static void _rtl92d_get_txpower_writeval_by_regulatory(struct ieee80211_hw *hw,
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
-	u8 i, chnlgroup = 0, pwr_diff_limit[4];
 	u32 writeval = 0, customer_limit, rf;
+	u8 chnlgroup = 0, pwr_diff_limit[4];
 
 	for (rf = 0; rf < 2; rf++) {
 		switch (rtlefuse->eeprom_regulatory) {
 		case 0:
-			chnlgroup = 0;
-			writeval = rtlphy->mcs_offset
-					[chnlgroup][index +
-					(rf ? 8 : 0)] + ((index < 2) ?
-					powerbase0[rf] :
-					powerbase1[rf]);
+			writeval = rtlphy->mcs_offset[0][index + (rf ? 8 : 0)];
+
 			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-				"RTK better performance, writeval(%c) = 0x%x\n",
-				rf == 0 ? 'A' : 'B', writeval);
+				"RTK better performance\n");
 			break;
 		case 1:
 			if (rtlphy->pwrgroup_cnt == 1)
 				chnlgroup = 0;
-			if (rtlphy->pwrgroup_cnt >= MAX_PG_GROUP) {
-				chnlgroup = rtl92d_phy_get_chnlgroup_bypg(channel - 1);
-				if (rtlphy->current_chan_bw ==
-				    HT_CHANNEL_WIDTH_20)
-					chnlgroup++;
-				else
-					chnlgroup += 4;
-				writeval = rtlphy->mcs_offset
-						[chnlgroup][index +
-						(rf ? 8 : 0)] + ((index < 2) ?
-						powerbase0[rf] :
-						powerbase1[rf]);
-				RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-					"Realtek regulatory, 20MHz, writeval(%c) = 0x%x\n",
-					rf == 0 ? 'A' : 'B', writeval);
-			}
+
+			if (rtlphy->pwrgroup_cnt < MAX_PG_GROUP)
+				break;
+
+			chnlgroup = rtl92d_phy_get_chnlgroup_bypg(channel - 1);
+			if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20)
+				chnlgroup++;
+			else
+				chnlgroup += 4;
+
+			writeval = rtlphy->mcs_offset
+					[chnlgroup][index + (rf ? 8 : 0)];
+
+			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+				"Realtek regulatory, 20MHz\n");
 			break;
 		case 2:
-			writeval = ((index < 2) ? powerbase0[rf] :
-				   powerbase1[rf]);
-			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-				"Better regulatory, writeval(%c) = 0x%x\n",
-				rf == 0 ? 'A' : 'B', writeval);
+			writeval = 0;
+
+			RTPRINT(rtlpriv, FPHY, PHY_TXPWR, "Better regulatory\n");
 			break;
 		case 3:
-			chnlgroup = 0;
 			if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
 				RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
 					"customer's limit, 40MHz rf(%c) = 0x%x\n",
 					rf == 0 ? 'A' : 'B',
-					rtlefuse->pwrgroup_ht40[rf]
-					[channel - 1]);
+					rtlefuse->pwrgroup_ht40[rf][channel - 1]);
 			} else {
 				RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
 					"customer's limit, 20MHz rf(%c) = 0x%x\n",
 					rf == 0 ? 'A' : 'B',
-					rtlefuse->pwrgroup_ht20[rf]
-					[channel - 1]);
-			}
-			for (i = 0; i < 4; i++) {
-				pwr_diff_limit[i] = (u8)((rtlphy->mcs_offset
-					[chnlgroup][index + (rf ? 8 : 0)] &
-					(0x7f << (i * 8))) >> (i * 8));
-				if (rtlphy->current_chan_bw ==
-				    HT_CHANNEL_WIDTH_20_40) {
-					if (pwr_diff_limit[i] >
-					    rtlefuse->pwrgroup_ht40[rf]
-					   [channel - 1])
-						pwr_diff_limit[i] =
-							rtlefuse->pwrgroup_ht40
-							[rf][channel - 1];
-				} else {
-					if (pwr_diff_limit[i] >
-					    rtlefuse->pwrgroup_ht20[rf][channel - 1])
-						pwr_diff_limit[i] =
-						   rtlefuse->pwrgroup_ht20[rf]
-						   [channel - 1];
-				}
+					rtlefuse->pwrgroup_ht20[rf][channel - 1]);
 			}
+
+			_rtl92d_get_pwr_diff_limit(hw, channel, index, rf,
+						   pwr_diff_limit);
+
 			customer_limit = (pwr_diff_limit[3] << 24) |
 					 (pwr_diff_limit[2] << 16) |
 					 (pwr_diff_limit[1] << 8) |
 					 (pwr_diff_limit[0]);
+
 			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
 				"Customer's limit rf(%c) = 0x%x\n",
 				rf == 0 ? 'A' : 'B', customer_limit);
-			writeval = customer_limit + ((index < 2) ?
-				   powerbase0[rf] : powerbase1[rf]);
-			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-				"Customer, writeval rf(%c)= 0x%x\n",
-				rf == 0 ? 'A' : 'B', writeval);
+
+			writeval = customer_limit;
+
+			RTPRINT(rtlpriv, FPHY, PHY_TXPWR, "Customer\n");
 			break;
 		default:
-			chnlgroup = 0;
-			writeval = rtlphy->mcs_offset[chnlgroup][index +
-				   (rf ? 8 : 0)] + ((index < 2) ?
-				   powerbase0[rf] : powerbase1[rf]);
+			writeval = rtlphy->mcs_offset[0][index + (rf ? 8 : 0)];
+
 			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-				"RTK better performance, writeval rf(%c) = 0x%x\n",
-				rf == 0 ? 'A' : 'B', writeval);
+				"RTK better performance\n");
 			break;
 		}
+
+		if (index < 2)
+			writeval += powerbase0[rf];
+		else
+			writeval += powerbase1[rf];
+
+		RTPRINT(rtlpriv, FPHY, PHY_TXPWR, "writeval rf(%c)= 0x%x\n",
+			rf == 0 ? 'A' : 'B', writeval);
+
 		*(p_outwriteval + rf) = writeval;
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
index 5b8f404373ea..72d2b7426d82 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
@@ -349,14 +349,16 @@ static void _rtl92de_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 					       __le32 *pdesc,
 					       struct rx_fwinfo_92d *p_drvinfo)
 {
-	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	struct ieee80211_hdr *hdr;
+	bool packet_matchbssid;
+	bool packet_beacon;
+	bool packet_toself;
+	u16 type, cfc;
 	u8 *tmp_buf;
 	u8 *praddr;
-	u16 type, cfc;
 	__le16 fc;
-	bool packet_matchbssid, packet_toself, packet_beacon = false;
 
 	tmp_buf = skb->data + pstats->rx_drvinfo_size + pstats->rx_bufshift;
 	hdr = (struct ieee80211_hdr *)tmp_buf;
@@ -372,8 +374,7 @@ static void _rtl92de_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 	     (!pstats->hwerror) && (!pstats->crc) && (!pstats->icv));
 	packet_toself = packet_matchbssid &&
 			ether_addr_equal(praddr, rtlefuse->dev_addr);
-	if (ieee80211_is_beacon(fc))
-		packet_beacon = true;
+	packet_beacon = ieee80211_is_beacon(fc);
 	_rtl92de_query_rxphystatus(hw, pstats, pdesc, p_drvinfo,
 				   packet_matchbssid, packet_toself,
 				   packet_beacon);
-- 
2.44.0


