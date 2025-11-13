Return-Path: <linux-wireless+bounces-28892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B52C557EF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 03:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83D964E2015
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 02:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AE6253B73;
	Thu, 13 Nov 2025 02:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aHQbhGMN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF51246333
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002677; cv=none; b=Lb15uY9bL5GbPT3iLIGECUttFpNhZDduNTMGTJH8WO0EMlJ+V8nH8lBXKnpR8KWenWG6Lj3kPP5KW7YQVIz8Lpvqu839aH7z0vlqowCmTvlZSD1i5zJnfMo+T+9IN+FucaEfhdPddvqUwJlD5k7wxTFKsO1QBaEug2/ztKN3cvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002677; c=relaxed/simple;
	bh=PBXysRXallwyIDg5TPwBbaHTXXcvriPMyadioFiDkPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JE3Yk3LEPte6uMvuBJr7Rsj6Ra0CzGBQzYqt9rlUJCMBTV+55ACv02Xdn2WTu4/+sMDUbB9rZZmyLWG0UIZw0BpckQWv2Y40LKViL3Ymlo8xSZMf8fB3Hvz7XUyRC1U3av5tHrsFj8zkJBsR8LbTeT6ZSm8EMTvg8i6UHr9woU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aHQbhGMN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD2vrHT32839539, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763002673; bh=pqQGmcfDuG15whF0rgnWZXoTXXMvmD5V7TifG9MUDoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aHQbhGMN80l5oJ3tSSXNXx1j6euvDERCwqjYdXLo5I/+uDhw8YMU7vk2C8Zgv+ASM
	 vHKve3Spqq6eRdgbpcBLwyEgIiqagj93iQJQbQgOzxu71F2yZdK7VG1cck/654lm7f
	 LgtTtsCchIQP+9qnd/DNumzdC5JsXwHbEiviOefJa4cexSZu71DBd/EdNnXMmT7MHY
	 2mP4DKQRZzU3qYNir1clHxZLXTLCc1BHlfaSP1WKMLZPns+BhSIxRcAPy68yq2uBMx
	 P3M8n1VT9dk/faY5d/xWpNmuiDXCyOM31Tjv2f5/WiTc9qXSWwB6IVISOk845PRVTb
	 Di+2DTNbuSVzA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD2vrHT32839539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 10:57:53 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 10:57:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH rtw-next 11/14] wifi: rtw89: fill addr cam H2C command by struct
Date: Thu, 13 Nov 2025 10:56:17 +0800
Message-ID: <20251113025620.31086-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113025620.31086-1-pkshih@realtek.com>
References: <20251113025620.31086-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The addr cam is used to tell firmware the MAC address and BSSID associated
to connected stations. Use struct instead of macros with pointer arithmetic
to fill the data.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c | 150 ++++----
 drivers/net/wireless/realtek/rtw89/cam.h | 431 +++++------------------
 drivers/net/wireless/realtek/rtw89/fw.c  |  17 +-
 3 files changed, 173 insertions(+), 425 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 385a238fe5cc..8233d91024e8 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -760,7 +760,8 @@ int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
-				  struct rtw89_sta_link *rtwsta_link, u8 *cmd)
+				  struct rtw89_sta_link *rtwsta_link,
+				  struct rtw89_h2c_addr_cam *h2c)
 {
 	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif_link,
 									 rtwsta_link);
@@ -780,20 +781,19 @@ int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 
 	rcu_read_unlock();
 
-	FWCMD_SET_ADDR_BSSID_IDX(cmd, bssid_cam->bssid_cam_idx);
-	FWCMD_SET_ADDR_BSSID_OFFSET(cmd, bssid_cam->offset);
-	FWCMD_SET_ADDR_BSSID_LEN(cmd, bssid_cam->len);
-	FWCMD_SET_ADDR_BSSID_VALID(cmd, bssid_cam->valid);
-	FWCMD_SET_ADDR_BSSID_MASK(cmd, bss_mask);
-	FWCMD_SET_ADDR_BSSID_BB_SEL(cmd, bssid_cam->phy_idx);
-	FWCMD_SET_ADDR_BSSID_BSS_COLOR(cmd, bss_color);
-
-	FWCMD_SET_ADDR_BSSID_BSSID0(cmd, bssid_cam->bssid[0]);
-	FWCMD_SET_ADDR_BSSID_BSSID1(cmd, bssid_cam->bssid[1]);
-	FWCMD_SET_ADDR_BSSID_BSSID2(cmd, bssid_cam->bssid[2]);
-	FWCMD_SET_ADDR_BSSID_BSSID3(cmd, bssid_cam->bssid[3]);
-	FWCMD_SET_ADDR_BSSID_BSSID4(cmd, bssid_cam->bssid[4]);
-	FWCMD_SET_ADDR_BSSID_BSSID5(cmd, bssid_cam->bssid[5]);
+	h2c->w12 = le32_encode_bits(bssid_cam->bssid_cam_idx, ADDR_CAM_W12_BSSID_IDX) |
+		   le32_encode_bits(bssid_cam->offset, ADDR_CAM_W12_BSSID_OFFSET) |
+		   le32_encode_bits(bssid_cam->len, ADDR_CAM_W12_BSSID_LEN);
+	h2c->w13 = le32_encode_bits(bssid_cam->valid, ADDR_CAM_W13_BSSID_VALID) |
+		   le32_encode_bits(bss_mask, ADDR_CAM_W13_BSSID_MASK) |
+		   le32_encode_bits(bssid_cam->phy_idx, ADDR_CAM_W13_BSSID_BB_SEL) |
+		   le32_encode_bits(bss_color, ADDR_CAM_W13_BSSID_BSS_COLOR) |
+		   le32_encode_bits(bssid_cam->bssid[0], ADDR_CAM_W13_BSSID_BSSID0) |
+		   le32_encode_bits(bssid_cam->bssid[1], ADDR_CAM_W13_BSSID_BSSID1);
+	h2c->w14 = le32_encode_bits(bssid_cam->bssid[2], ADDR_CAM_W14_BSSID_BSSID2) |
+		   le32_encode_bits(bssid_cam->bssid[3], ADDR_CAM_W14_BSSID_BSSID3) |
+		   le32_encode_bits(bssid_cam->bssid[4], ADDR_CAM_W14_BSSID_BSSID4) |
+		   le32_encode_bits(bssid_cam->bssid[5], ADDR_CAM_W14_BSSID_BSSID5);
 
 	return 0;
 }
@@ -813,7 +813,7 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta_link *rtwsta_link,
 				  const u8 *scan_mac_addr,
-				  u8 *cmd)
+				  struct rtw89_h2c_addr_cam *h2c)
 {
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_addr_cam_entry *addr_cam =
@@ -845,69 +845,65 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 	sma_hash = rtw89_cam_addr_hash(sma_start, sma);
 	tma_hash = rtw89_cam_addr_hash(tma_start, tma);
 
-	FWCMD_SET_ADDR_IDX(cmd, addr_cam->addr_cam_idx);
-	FWCMD_SET_ADDR_OFFSET(cmd, addr_cam->offset);
-	FWCMD_SET_ADDR_LEN(cmd, addr_cam->len);
-
-	FWCMD_SET_ADDR_VALID(cmd, addr_cam->valid);
-	FWCMD_SET_ADDR_NET_TYPE(cmd, rtwvif_link->net_type);
-	FWCMD_SET_ADDR_BCN_HIT_COND(cmd, rtwvif_link->bcn_hit_cond);
-	FWCMD_SET_ADDR_HIT_RULE(cmd, rtwvif_link->hit_rule);
-	FWCMD_SET_ADDR_BB_SEL(cmd, rtwvif_link->phy_idx);
-	FWCMD_SET_ADDR_ADDR_MASK(cmd, addr_cam->addr_mask);
-	FWCMD_SET_ADDR_MASK_SEL(cmd, addr_cam->mask_sel);
-	FWCMD_SET_ADDR_SMA_HASH(cmd, sma_hash);
-	FWCMD_SET_ADDR_TMA_HASH(cmd, tma_hash);
-
-	FWCMD_SET_ADDR_BSSID_CAM_IDX(cmd, addr_cam->bssid_cam_idx);
-
-	FWCMD_SET_ADDR_SMA0(cmd, sma[0]);
-	FWCMD_SET_ADDR_SMA1(cmd, sma[1]);
-	FWCMD_SET_ADDR_SMA2(cmd, sma[2]);
-	FWCMD_SET_ADDR_SMA3(cmd, sma[3]);
-	FWCMD_SET_ADDR_SMA4(cmd, sma[4]);
-	FWCMD_SET_ADDR_SMA5(cmd, sma[5]);
-
-	FWCMD_SET_ADDR_TMA0(cmd, tma[0]);
-	FWCMD_SET_ADDR_TMA1(cmd, tma[1]);
-	FWCMD_SET_ADDR_TMA2(cmd, tma[2]);
-	FWCMD_SET_ADDR_TMA3(cmd, tma[3]);
-	FWCMD_SET_ADDR_TMA4(cmd, tma[4]);
-	FWCMD_SET_ADDR_TMA5(cmd, tma[5]);
-
-	FWCMD_SET_ADDR_PORT_INT(cmd, rtwvif_link->port);
-	FWCMD_SET_ADDR_TSF_SYNC(cmd, rtwvif_link->port);
-	FWCMD_SET_ADDR_TF_TRS(cmd, rtwvif_link->trigger);
-	FWCMD_SET_ADDR_LSIG_TXOP(cmd, rtwvif_link->lsig_txop);
-	FWCMD_SET_ADDR_TGT_IND(cmd, rtwvif_link->tgt_ind);
-	FWCMD_SET_ADDR_FRM_TGT_IND(cmd, rtwvif_link->frm_tgt_ind);
-	FWCMD_SET_ADDR_MACID(cmd, rtwsta_link ? rtwsta_link->mac_id :
-						rtwvif_link->mac_id);
+	h2c->w1 = le32_encode_bits(addr_cam->addr_cam_idx, ADDR_CAM_W1_IDX) |
+		  le32_encode_bits(addr_cam->offset, ADDR_CAM_W1_OFFSET) |
+		  le32_encode_bits(addr_cam->len, ADDR_CAM_W1_LEN);
+	h2c->w2 = le32_encode_bits(addr_cam->valid, ADDR_CAM_W2_VALID) |
+		  le32_encode_bits(rtwvif_link->net_type, ADDR_CAM_W2_NET_TYPE) |
+		  le32_encode_bits(rtwvif_link->bcn_hit_cond, ADDR_CAM_W2_BCN_HIT_COND) |
+		  le32_encode_bits(rtwvif_link->hit_rule, ADDR_CAM_W2_HIT_RULE) |
+		  le32_encode_bits(rtwvif_link->phy_idx, ADDR_CAM_W2_BB_SEL) |
+		  le32_encode_bits(addr_cam->addr_mask, ADDR_CAM_W2_ADDR_MASK) |
+		  le32_encode_bits(addr_cam->mask_sel, ADDR_CAM_W2_MASK_SEL) |
+		  le32_encode_bits(sma_hash, ADDR_CAM_W2_SMA_HASH) |
+		  le32_encode_bits(tma_hash, ADDR_CAM_W2_TMA_HASH);
+	h2c->w3 = le32_encode_bits(addr_cam->bssid_cam_idx, ADDR_CAM_W3_BSSID_CAM_IDX);
+	h2c->w4 = le32_encode_bits(sma[0], ADDR_CAM_W4_SMA0) |
+		  le32_encode_bits(sma[1], ADDR_CAM_W4_SMA1) |
+		  le32_encode_bits(sma[2], ADDR_CAM_W4_SMA2) |
+		  le32_encode_bits(sma[3], ADDR_CAM_W4_SMA3);
+	h2c->w5 = le32_encode_bits(sma[4], ADDR_CAM_W5_SMA4) |
+		  le32_encode_bits(sma[5], ADDR_CAM_W5_SMA5) |
+		  le32_encode_bits(tma[0], ADDR_CAM_W5_TMA0) |
+		  le32_encode_bits(tma[1], ADDR_CAM_W5_TMA1);
+	h2c->w6 = le32_encode_bits(tma[2], ADDR_CAM_W6_TMA2) |
+		  le32_encode_bits(tma[3], ADDR_CAM_W6_TMA3) |
+		  le32_encode_bits(tma[4], ADDR_CAM_W6_TMA4) |
+		  le32_encode_bits(tma[5], ADDR_CAM_W6_TMA5);
+	h2c->w8 = le32_encode_bits(rtwvif_link->port, ADDR_CAM_W8_PORT_INT) |
+		  le32_encode_bits(rtwvif_link->port, ADDR_CAM_W8_TSF_SYNC) |
+		  le32_encode_bits(rtwvif_link->trigger, ADDR_CAM_W8_TF_TRS) |
+		  le32_encode_bits(rtwvif_link->lsig_txop, ADDR_CAM_W8_LSIG_TXOP) |
+		  le32_encode_bits(rtwvif_link->tgt_ind, ADDR_CAM_W8_TGT_IND) |
+		  le32_encode_bits(rtwvif_link->frm_tgt_ind, ADDR_CAM_W8_FRM_TGT_IND) |
+		  le32_encode_bits(rtwsta_link ? rtwsta_link->mac_id :
+						 rtwvif_link->mac_id, ADDR_CAM_W8_MACID);
+
 	if (rtwvif_link->net_type == RTW89_NET_TYPE_INFRA)
-		FWCMD_SET_ADDR_AID12(cmd, vif->cfg.aid & 0xfff);
+		h2c->w9 = le32_encode_bits(vif->cfg.aid & 0xfff, ADDR_CAM_W9_AID12);
 	else if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
-		FWCMD_SET_ADDR_AID12(cmd, sta ? sta->aid & 0xfff : 0);
-	FWCMD_SET_ADDR_WOL_PATTERN(cmd, rtwvif_link->wowlan_pattern);
-	FWCMD_SET_ADDR_WOL_UC(cmd, rtwvif_link->wowlan_uc);
-	FWCMD_SET_ADDR_WOL_MAGIC(cmd, rtwvif_link->wowlan_magic);
-	FWCMD_SET_ADDR_WAPI(cmd, addr_cam->wapi);
-	FWCMD_SET_ADDR_SEC_ENT_MODE(cmd, addr_cam->sec_ent_mode);
-	FWCMD_SET_ADDR_SEC_ENT0_KEYID(cmd, addr_cam->sec_ent_keyid[0]);
-	FWCMD_SET_ADDR_SEC_ENT1_KEYID(cmd, addr_cam->sec_ent_keyid[1]);
-	FWCMD_SET_ADDR_SEC_ENT2_KEYID(cmd, addr_cam->sec_ent_keyid[2]);
-	FWCMD_SET_ADDR_SEC_ENT3_KEYID(cmd, addr_cam->sec_ent_keyid[3]);
-	FWCMD_SET_ADDR_SEC_ENT4_KEYID(cmd, addr_cam->sec_ent_keyid[4]);
-	FWCMD_SET_ADDR_SEC_ENT5_KEYID(cmd, addr_cam->sec_ent_keyid[5]);
-	FWCMD_SET_ADDR_SEC_ENT6_KEYID(cmd, addr_cam->sec_ent_keyid[6]);
-
-	FWCMD_SET_ADDR_SEC_ENT_VALID(cmd, addr_cam->sec_cam_map[0] & 0xff);
-	FWCMD_SET_ADDR_SEC_ENT0(cmd, addr_cam->sec_ent[0]);
-	FWCMD_SET_ADDR_SEC_ENT1(cmd, addr_cam->sec_ent[1]);
-	FWCMD_SET_ADDR_SEC_ENT2(cmd, addr_cam->sec_ent[2]);
-	FWCMD_SET_ADDR_SEC_ENT3(cmd, addr_cam->sec_ent[3]);
-	FWCMD_SET_ADDR_SEC_ENT4(cmd, addr_cam->sec_ent[4]);
-	FWCMD_SET_ADDR_SEC_ENT5(cmd, addr_cam->sec_ent[5]);
-	FWCMD_SET_ADDR_SEC_ENT6(cmd, addr_cam->sec_ent[6]);
+		h2c->w9 = le32_encode_bits(sta ? sta->aid & 0xfff : 0, ADDR_CAM_W9_AID12);
+
+	h2c->w9 |= le32_encode_bits(rtwvif_link->wowlan_pattern, ADDR_CAM_W9_WOL_PATTERN) |
+		   le32_encode_bits(rtwvif_link->wowlan_uc, ADDR_CAM_W9_WOL_UC) |
+		   le32_encode_bits(rtwvif_link->wowlan_magic, ADDR_CAM_W9_WOL_MAGIC) |
+		   le32_encode_bits(addr_cam->wapi, ADDR_CAM_W9_WAPI) |
+		   le32_encode_bits(addr_cam->sec_ent_mode, ADDR_CAM_W9_SEC_ENT_MODE) |
+		   le32_encode_bits(addr_cam->sec_ent_keyid[0], ADDR_CAM_W9_SEC_ENT0_KEYID) |
+		   le32_encode_bits(addr_cam->sec_ent_keyid[1], ADDR_CAM_W9_SEC_ENT1_KEYID) |
+		   le32_encode_bits(addr_cam->sec_ent_keyid[2], ADDR_CAM_W9_SEC_ENT2_KEYID) |
+		   le32_encode_bits(addr_cam->sec_ent_keyid[3], ADDR_CAM_W9_SEC_ENT3_KEYID) |
+		   le32_encode_bits(addr_cam->sec_ent_keyid[4], ADDR_CAM_W9_SEC_ENT4_KEYID) |
+		   le32_encode_bits(addr_cam->sec_ent_keyid[5], ADDR_CAM_W9_SEC_ENT5_KEYID) |
+		   le32_encode_bits(addr_cam->sec_ent_keyid[6], ADDR_CAM_W9_SEC_ENT6_KEYID);
+	h2c->w10 = le32_encode_bits(addr_cam->sec_cam_map[0] & 0xff, ADDR_CAM_W10_SEC_ENT_VALID) |
+		   le32_encode_bits(addr_cam->sec_ent[0], ADDR_CAM_W10_SEC_ENT0) |
+		   le32_encode_bits(addr_cam->sec_ent[1], ADDR_CAM_W10_SEC_ENT1) |
+		   le32_encode_bits(addr_cam->sec_ent[2], ADDR_CAM_W10_SEC_ENT2);
+	h2c->w11 = le32_encode_bits(addr_cam->sec_ent[3], ADDR_CAM_W11_SEC_ENT3) |
+		   le32_encode_bits(addr_cam->sec_ent[4], ADDR_CAM_W11_SEC_ENT4) |
+		   le32_encode_bits(addr_cam->sec_ent[5], ADDR_CAM_W11_SEC_ENT5) |
+		   le32_encode_bits(addr_cam->sec_ent[6], ADDR_CAM_W11_SEC_ENT6);
 
 	rcu_read_unlock();
 }
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 8fd2d776408e..2bc8fbf79c0b 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -12,345 +12,92 @@
 #define RTW89_BSSID_MATCH_ALL GENMASK(5, 0)
 #define RTW89_BSSID_MATCH_5_BYTES GENMASK(4, 0)
 
-static inline void FWCMD_SET_ADDR_IDX(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(7, 0));
-}
-
-static inline void FWCMD_SET_ADDR_OFFSET(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(15, 8));
-}
-
-static inline void FWCMD_SET_ADDR_LEN(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(23, 16));
-}
-
-static inline void FWCMD_SET_ADDR_VALID(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, BIT(0));
-}
-
-static inline void FWCMD_SET_ADDR_NET_TYPE(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(2, 1));
-}
-
-static inline void FWCMD_SET_ADDR_BCN_HIT_COND(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(4, 3));
-}
-
-static inline void FWCMD_SET_ADDR_HIT_RULE(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(6, 5));
-}
-
-static inline void FWCMD_SET_ADDR_BB_SEL(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, BIT(7));
-}
-
-static inline void FWCMD_SET_ADDR_ADDR_MASK(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(13, 8));
-}
-
-static inline void FWCMD_SET_ADDR_MASK_SEL(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(15, 14));
-}
-
-static inline void FWCMD_SET_ADDR_SMA_HASH(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(23, 16));
-}
-
-static inline void FWCMD_SET_ADDR_TMA_HASH(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(31, 24));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_CAM_IDX(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 3, value, GENMASK(5, 0));
-}
-
-static inline void FWCMD_SET_ADDR_SMA0(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(7, 0));
-}
-
-static inline void FWCMD_SET_ADDR_SMA1(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(15, 8));
-}
-
-static inline void FWCMD_SET_ADDR_SMA2(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(23, 16));
-}
-
-static inline void FWCMD_SET_ADDR_SMA3(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(31, 24));
-}
-
-static inline void FWCMD_SET_ADDR_SMA4(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(7, 0));
-}
-
-static inline void FWCMD_SET_ADDR_SMA5(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(15, 8));
-}
-
-static inline void FWCMD_SET_ADDR_TMA0(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(23, 16));
-}
-
-static inline void FWCMD_SET_ADDR_TMA1(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(31, 24));
-}
-
-static inline void FWCMD_SET_ADDR_TMA2(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(7, 0));
-}
-
-static inline void FWCMD_SET_ADDR_TMA3(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(15, 8));
-}
-
-static inline void FWCMD_SET_ADDR_TMA4(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(23, 16));
-}
-
-static inline void FWCMD_SET_ADDR_TMA5(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(31, 24));
-}
-
-static inline void FWCMD_SET_ADDR_MACID(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(7, 0));
-}
-
-static inline void FWCMD_SET_ADDR_PORT_INT(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(10, 8));
-}
-
-static inline void FWCMD_SET_ADDR_TSF_SYNC(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(13, 11));
-}
-
-static inline void FWCMD_SET_ADDR_TF_TRS(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, BIT(14));
-}
-
-static inline void FWCMD_SET_ADDR_LSIG_TXOP(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, BIT(15));
-}
-
-static inline void FWCMD_SET_ADDR_TGT_IND(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(26, 24));
-}
-
-static inline void FWCMD_SET_ADDR_FRM_TGT_IND(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(29, 27));
-}
-
-static inline void FWCMD_SET_ADDR_AID12(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(11, 0));
-}
-
-static inline void FWCMD_SET_ADDR_AID12_0(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(7, 0));
-}
-
-static inline void FWCMD_SET_ADDR_AID12_1(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(11, 8));
-}
-
-static inline void FWCMD_SET_ADDR_WOL_PATTERN(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(12));
-}
-
-static inline void FWCMD_SET_ADDR_WOL_UC(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(13));
-}
-
-static inline void FWCMD_SET_ADDR_WOL_MAGIC(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(14));
-}
-
-static inline void FWCMD_SET_ADDR_WAPI(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(15));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT_MODE(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(17, 16));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT0_KEYID(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(19, 18));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT1_KEYID(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(21, 20));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT2_KEYID(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(23, 22));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT3_KEYID(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(25, 24));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT4_KEYID(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(27, 26));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT5_KEYID(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(29, 28));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT6_KEYID(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(31, 30));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT_VALID(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(7, 0));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT0(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(15, 8));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT1(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(23, 16));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT2(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(31, 24));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT3(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(7, 0));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT4(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(15, 8));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT5(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(23, 16));
-}
-
-static inline void FWCMD_SET_ADDR_SEC_ENT6(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(31, 24));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_IDX(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 12, value, GENMASK(7, 0));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_OFFSET(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 12, value, GENMASK(15, 8));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_LEN(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 12, value, GENMASK(23, 16));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_VALID(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 13, value, BIT(0));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_BB_SEL(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 13, value, BIT(1));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_MASK(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(7, 2));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_BSS_COLOR(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(13, 8));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_BSSID0(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(23, 16));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_BSSID1(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(31, 24));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_BSSID2(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(7, 0));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_BSSID3(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(15, 8));
-}
-
-static inline void FWCMD_SET_ADDR_BSSID_BSSID4(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(23, 16));
-}
+struct rtw89_h2c_addr_cam {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	__le32 w8;
+	__le32 w9;
+	__le32 w10;
+	__le32 w11;
+	__le32 w12;
+	__le32 w13;
+	__le32 w14;
+} __packed;
 
-static inline void FWCMD_SET_ADDR_BSSID_BSSID5(void *cmd, u32 value)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(31, 24));
-}
+#define ADDR_CAM_W1_IDX GENMASK(7, 0)
+#define ADDR_CAM_W1_OFFSET GENMASK(15, 8)
+#define ADDR_CAM_W1_LEN GENMASK(23, 16)
+#define ADDR_CAM_W2_VALID BIT(0)
+#define ADDR_CAM_W2_NET_TYPE GENMASK(2, 1)
+#define ADDR_CAM_W2_BCN_HIT_COND GENMASK(4, 3)
+#define ADDR_CAM_W2_HIT_RULE GENMASK(6, 5)
+#define ADDR_CAM_W2_BB_SEL BIT(7)
+#define ADDR_CAM_W2_ADDR_MASK GENMASK(13, 8)
+#define ADDR_CAM_W2_MASK_SEL GENMASK(15, 14)
+#define ADDR_CAM_W2_SMA_HASH GENMASK(23, 16)
+#define ADDR_CAM_W2_TMA_HASH GENMASK(31, 24)
+#define ADDR_CAM_W3_BSSID_CAM_IDX GENMASK(5, 0)
+#define ADDR_CAM_W4_SMA0 GENMASK(7, 0)
+#define ADDR_CAM_W4_SMA1 GENMASK(15, 8)
+#define ADDR_CAM_W4_SMA2 GENMASK(23, 16)
+#define ADDR_CAM_W4_SMA3 GENMASK(31, 24)
+#define ADDR_CAM_W5_SMA4 GENMASK(7, 0)
+#define ADDR_CAM_W5_SMA5 GENMASK(15, 8)
+#define ADDR_CAM_W5_TMA0 GENMASK(23, 16)
+#define ADDR_CAM_W5_TMA1 GENMASK(31, 24)
+#define ADDR_CAM_W6_TMA2 GENMASK(7, 0)
+#define ADDR_CAM_W6_TMA3 GENMASK(15, 8)
+#define ADDR_CAM_W6_TMA4 GENMASK(23, 16)
+#define ADDR_CAM_W6_TMA5 GENMASK(31, 24)
+#define ADDR_CAM_W8_MACID GENMASK(7, 0)
+#define ADDR_CAM_W8_PORT_INT GENMASK(10, 8)
+#define ADDR_CAM_W8_TSF_SYNC GENMASK(13, 11)
+#define ADDR_CAM_W8_TF_TRS BIT(14)
+#define ADDR_CAM_W8_LSIG_TXOP BIT(15)
+#define ADDR_CAM_W8_TGT_IND GENMASK(26, 24)
+#define ADDR_CAM_W8_FRM_TGT_IND GENMASK(29, 27)
+#define ADDR_CAM_W9_AID12 GENMASK(11, 0)
+#define ADDR_CAM_W9_AID12_0 GENMASK(7, 0)
+#define ADDR_CAM_W9_AID12_1 GENMASK(11, 8)
+#define ADDR_CAM_W9_WOL_PATTERN BIT(12)
+#define ADDR_CAM_W9_WOL_UC BIT(13)
+#define ADDR_CAM_W9_WOL_MAGIC BIT(14)
+#define ADDR_CAM_W9_WAPI BIT(15)
+#define ADDR_CAM_W9_SEC_ENT_MODE GENMASK(17, 16)
+#define ADDR_CAM_W9_SEC_ENT0_KEYID GENMASK(19, 18)
+#define ADDR_CAM_W9_SEC_ENT1_KEYID GENMASK(21, 20)
+#define ADDR_CAM_W9_SEC_ENT2_KEYID GENMASK(23, 22)
+#define ADDR_CAM_W9_SEC_ENT3_KEYID GENMASK(25, 24)
+#define ADDR_CAM_W9_SEC_ENT4_KEYID GENMASK(27, 26)
+#define ADDR_CAM_W9_SEC_ENT5_KEYID GENMASK(29, 28)
+#define ADDR_CAM_W9_SEC_ENT6_KEYID GENMASK(31, 30)
+#define ADDR_CAM_W10_SEC_ENT_VALID GENMASK(7, 0)
+#define ADDR_CAM_W10_SEC_ENT0 GENMASK(15, 8)
+#define ADDR_CAM_W10_SEC_ENT1 GENMASK(23, 16)
+#define ADDR_CAM_W10_SEC_ENT2 GENMASK(31, 24)
+#define ADDR_CAM_W11_SEC_ENT3 GENMASK(7, 0)
+#define ADDR_CAM_W11_SEC_ENT4 GENMASK(15, 8)
+#define ADDR_CAM_W11_SEC_ENT5 GENMASK(23, 16)
+#define ADDR_CAM_W11_SEC_ENT6 GENMASK(31, 24)
+#define ADDR_CAM_W12_BSSID_IDX GENMASK(7, 0)
+#define ADDR_CAM_W12_BSSID_OFFSET GENMASK(15, 8)
+#define ADDR_CAM_W12_BSSID_LEN GENMASK(23, 16)
+#define ADDR_CAM_W13_BSSID_VALID BIT(0)
+#define ADDR_CAM_W13_BSSID_BB_SEL BIT(1)
+#define ADDR_CAM_W13_BSSID_MASK GENMASK(7, 2)
+#define ADDR_CAM_W13_BSSID_BSS_COLOR GENMASK(13, 8)
+#define ADDR_CAM_W13_BSSID_BSSID0 GENMASK(23, 16)
+#define ADDR_CAM_W13_BSSID_BSSID1 GENMASK(31, 24)
+#define ADDR_CAM_W14_BSSID_BSSID2 GENMASK(7, 0)
+#define ADDR_CAM_W14_BSSID_BSSID3 GENMASK(15, 8)
+#define ADDR_CAM_W14_BSSID_BSSID4 GENMASK(23, 16)
+#define ADDR_CAM_W14_BSSID_BSSID5 GENMASK(31, 24)
 
 struct rtw89_h2c_dctlinfo_ud_v1 {
 	__le32 c0;
@@ -552,9 +299,10 @@ int rtw89_cam_init_bssid_cam(struct rtw89_dev *rtwdev,
 void rtw89_cam_deinit_bssid_cam(struct rtw89_dev *rtwdev,
 				struct rtw89_bssid_cam_entry *bssid_cam);
 void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif_link *vif,
+				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta_link *rtwsta_link,
-				  const u8 *scan_mac_addr, u8 *cmd);
+				  const u8 *scan_mac_addr,
+				  struct rtw89_h2c_addr_cam *h2c);
 void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif_link *rtwvif_link,
 					 struct rtw89_sta_link *rtwsta_link,
@@ -565,7 +313,8 @@ void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
 					 struct rtw89_h2c_dctlinfo_ud_v2 *h2c);
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
-				  struct rtw89_sta_link *rtwsta_link, u8 *cmd);
+				  struct rtw89_sta_link *rtwsta_link,
+				  struct rtw89_h2c_addr_cam *h2c);
 int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0dc5aa5ed218..9f132a469629 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2132,28 +2132,31 @@ void rtw89_fw_log_dump(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 
 }
 
-#define H2C_CAM_LEN 60
 int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		     struct rtw89_sta_link *rtwsta_link, const u8 *scan_mac_addr)
 {
+	struct rtw89_h2c_addr_cam *h2c;
+	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	int ret;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_CAM_LEN);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_CAM_LEN);
-	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif_link, rtwsta_link, scan_mac_addr,
-				     skb->data);
-	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif_link, rtwsta_link, skb->data);
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_addr_cam *)skb->data;
+
+	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif_link, rtwsta_link,
+				     scan_mac_addr, h2c);
+	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif_link, rtwsta_link, h2c);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
 			      H2C_CL_MAC_ADDR_CAM_UPDATE,
 			      H2C_FUNC_MAC_ADDR_CAM_UPD, 0, 1,
-			      H2C_CAM_LEN);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
-- 
2.25.1


