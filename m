Return-Path: <linux-wireless+bounces-25435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83FFB04F88
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9C94A009D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 03:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CDC2D1913;
	Tue, 15 Jul 2025 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KVcKW9EC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837EF28D836
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551621; cv=none; b=PVneAOGhZ83bHXhxSRCcGVyoCoq3CFE69tcLaL7AS3slsDHFK/uYraIOwWD0GQs6zo1zTyGNEDt3Ryx1cCrVFwgsDTx17OsPOLKkSKYjgkIyiDL1hLd7GgTcYVxQBfcUMtFudQ0jzj+kl8Axg4DvGRy74SRR3mvQ7uNEx7xTkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551621; c=relaxed/simple;
	bh=DzAFJOdgfmdlZt7L8lULTS6StAJ4fqTSPFHeYej1QVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4/ZA8t9ozgzlmUocKDhSJnG+9vhFIxF9uagNcB4qTn0lA2TOdw7wdPOtY2uHPiumY147PBnkDtD+9qLHlX8UUTFNCK2mCiCLzLrLpA+nKY9zE1pjLA068VuljkDGJJ6DvK1Z5+4Kwwa3IVcl2Y+wWKeQYoT4WwenWt8BAsszVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KVcKW9EC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F3rYetD3971955, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752551614; bh=/ffmOmJsFNp+u2NwM0F6Kki97YbCOCqqOQO6eROTTtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KVcKW9ECUUDmTnwpM+NBoRPfTnPYClv4H78Z3tYvxPvvt8tqxSgbthAArApoU3B9x
	 pQbDDg4IBAa5f/KzR7G45PF6ydynz2KAcsH7PeryPeHhNXaD8KulU1Nze7gajemMNL
	 g7zDqiYqS8L5yjfodrr4Fu/eLfRyGQE1WkBme5ql+obEvZtsdvImpkPxmzC1rcS/13
	 SqN3R3zTqAO7eaRab1vAhNM5TEHRXwiDSgmXQM7f2uyoS4P9+XdcPH5Sj6l96/z5F7
	 N6+O/jmPAI6PLJ7u7xY34aXe/VkSLRmrcBJiMLo8E2mbyfs4sCzfVFbacRjmMOdMQD
	 bP2iItludv9bA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F3rYetD3971955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 11:53:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 11:53:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Jul
 2025 11:53:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 3/5] wifi: rtw89: dynamically update EHT preamble puncturing
Date: Tue, 15 Jul 2025 11:52:57 +0800
Message-ID: <20250715035259.45061-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250715035259.45061-1-pkshih@realtek.com>
References: <20250715035259.45061-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Kuan-Chung Chen <damon.chen@realtek.com>

When the 'Disabled Subchannel Bitmap' within the EHT Operation
element is changed, mac80211 parse and pass it to the driver.
The driver is then updated with this puncturing bitmap to
optimize bandwidth usage and prevent interference from
degrading performance across the entire channel.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 47 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  3 ++
 drivers/net/wireless/realtek/rtw89/fw.c       | 43 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 16 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 10 files changed, 115 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index ed0d89ac3495..f7d1c5d3b92e 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -129,6 +129,48 @@ void rtw89_chan_create(struct rtw89_chan *chan, u8 center_chan, u8 primary_chan,
 						    bandwidth);
 }
 
+static void _rtw89_chan_update_punctured(struct rtw89_dev *rtwdev,
+					 struct rtw89_vif_link *rtwvif_link,
+					 const struct cfg80211_chan_def *chandef)
+{
+	struct ieee80211_bss_conf *bss_conf;
+
+	if (rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION &&
+	    rtwvif_link->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT)
+		return;
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	if (!bss_conf->eht_support) {
+		rcu_read_unlock();
+		return;
+	}
+
+	rcu_read_unlock();
+
+	rtw89_chip_h2c_punctured_cmac_tbl(rtwdev, rtwvif_link, chandef->punctured);
+}
+
+static void rtw89_chan_update_punctured(struct rtw89_dev *rtwdev,
+					enum rtw89_chanctx_idx idx,
+					const struct cfg80211_chan_def *chandef)
+{
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+			if (!rtwvif_link->chanctx_assigned ||
+			    rtwvif_link->chanctx_idx != idx)
+				continue;
+
+			_rtw89_chan_update_punctured(rtwdev, rtwvif_link, chandef);
+		}
+	}
+}
+
 bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
 			      enum rtw89_chanctx_idx idx,
 			      const struct rtw89_chan *new)
@@ -3245,6 +3287,9 @@ void rtw89_chanctx_ops_change(struct rtw89_dev *rtwdev,
 		rtw89_config_entity_chandef(rtwdev, idx, &ctx->def);
 		rtw89_set_channel(rtwdev);
 	}
+
+	if (changed & IEEE80211_CHANCTX_CHANGE_PUNCTURING)
+		rtw89_chan_update_punctured(rtwdev, idx, &ctx->def);
 }
 
 int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
@@ -3388,5 +3433,7 @@ int rtw89_chanctx_ops_reassign_vif(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
+	_rtw89_chan_update_punctured(rtwdev, rtwvif_link, &new_ctx->def);
+
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 59ec81adac7e..a99a0dc710d8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3779,6 +3779,9 @@ struct rtw89_chip_ops {
 				  struct rtw89_sta_link *rtwsta_link);
 	int (*h2c_txtime_cmac_tbl)(struct rtw89_dev *rtwdev,
 				   struct rtw89_sta_link *rtwsta_link);
+	int (*h2c_punctured_cmac_tbl)(struct rtw89_dev *rtwdev,
+				      struct rtw89_vif_link *rtwvif_link,
+				      u16 punctured);
 	int (*h2c_default_dmac_tbl)(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link,
 				    struct rtw89_sta_link *rtwsta_link);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 73a4ec988d16..8230115c29b4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3745,6 +3745,49 @@ int rtw89_fw_h2c_txtime_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_txtime_cmac_tbl_g7);
 
+int rtw89_fw_h2c_punctured_cmac_tbl_g7(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif_link *rtwvif_link,
+				       u16 punctured)
+{
+	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for punctured cmac g7\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cctlinfo_ud_g7 *)skb->data;
+
+	h2c->c0 = le32_encode_bits(rtwvif_link->mac_id, CCTLINFO_G7_C0_MACID) |
+		  le32_encode_bits(1, CCTLINFO_G7_C0_OP);
+
+	h2c->w4 = le32_encode_bits(~punctured, CCTLINFO_G7_W4_ACT_SUBCH_CBW);
+	h2c->m4 = cpu_to_le32(CCTLINFO_G7_W4_ACT_SUBCH_CBW);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_CCTLINFO_UD_G7, 0, 1,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+EXPORT_SYMBOL(rtw89_fw_h2c_punctured_cmac_tbl_g7);
+
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 98be7e72c685..b64edc9e8abe 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4736,6 +4736,9 @@ int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_txtime_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				    struct rtw89_sta_link *rtwsta_link);
+int rtw89_fw_h2c_punctured_cmac_tbl_g7(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif_link *rtwvif_link,
+				       u16 punctured);
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
@@ -5038,6 +5041,19 @@ int rtw89_chip_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 	return chip->ops->h2c_txtime_cmac_tbl(rtwdev, rtwsta_link);
 }
 
+static inline
+int rtw89_chip_h2c_punctured_cmac_tbl(struct rtw89_dev *rtwdev,
+				      struct rtw89_vif_link *rtwvif_link,
+				      u16 punctured)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (!chip->ops->h2c_punctured_cmac_tbl)
+		return 0;
+
+	return chip->ops->h2c_punctured_cmac_tbl(rtwdev, rtwvif_link, punctured);
+}
+
 static inline
 int rtw89_chip_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			  bool valid, struct ieee80211_ampdu_params *params)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 96edaf8e9ec4..393df2b0dcae 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2546,6 +2546,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl,
+	.h2c_punctured_cmac_tbl	= NULL,
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 0496deb7278f..3bbe2a808844 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2151,6 +2151,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl,
+	.h2c_punctured_cmac_tbl	= NULL,
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 389dfac26028..7ede07f7b1eb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -851,6 +851,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl,
+	.h2c_punctured_cmac_tbl	= NULL,
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 06a06c190553..9427823aca2f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -717,6 +717,7 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl,
+	.h2c_punctured_cmac_tbl	= NULL,
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 6e27f1ff94dc..88cf8ea13e7c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2971,6 +2971,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl,
+	.h2c_punctured_cmac_tbl	= NULL,
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index e23655f3e4c1..36c641e3bc13 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2826,6 +2826,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl_g7,
 	.h2c_ampdu_cmac_tbl	= rtw89_fw_h2c_ampdu_cmac_tbl_g7,
 	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl_g7,
+	.h2c_punctured_cmac_tbl	= rtw89_fw_h2c_punctured_cmac_tbl_g7,
 	.h2c_default_dmac_tbl	= rtw89_fw_h2c_default_dmac_tbl_v2,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon_be,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam_v1,
-- 
2.25.1


