Return-Path: <linux-wireless+bounces-31090-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD82MgzScmnKpgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31090-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:42:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BF56F38F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49597300F6D7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 01:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856E366049;
	Fri, 23 Jan 2026 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nb7B1M/y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4CD2D7D3A
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132448; cv=none; b=pqOlcSiaD7OKTvekmxo4pIdlWWz//rtoKZAbkEY/Fh3LB5PupGqQy47XpRzR6EaEKkbMqhvt4FQPBEBAopabooIqfb/MnB9K8ZSHd6NeakE/cxBZMuYTGPS09xDKZdJYfUmSujdztym8UX1VfB32qIRtCmvDKGTjTYGcZ+3G7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132448; c=relaxed/simple;
	bh=VkVf5i2HpC/IsjwkEZHzimgHlzh1dj9syIx08YIRh8Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpWt1JRGaSQVOisXnTxBnlaN3d+iTDXsDTN4Sh5Exw7P5X+7CrTOIFGsTWj7qUTzJzVffch7Nf2wxYmq5Du/LQ5zJGSgtyqCypIowJ4r874ywHj4ZNBYpRnPLOXA6WQVZbgPcbEGvJTWwz0CjPUgJ9QBYnj8qYFt7TYoyOHurag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nb7B1M/y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60N1ee6cB2206677, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769132440; bh=iZeTqJX1tPXU6M0M9eJeGe50l6BO88mw5O7ie44QrdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nb7B1M/y0lQ1Yt3zBqEtWkyTBc7RVEsJl/vPT6dFebUg2aAfV08OQabN5nkI49YCt
	 VtfmYyyFk1AqX9sk386VGmdtfrju1ZfGHiPLkChrTLlA338eZ7hc40wtjkzaZHaCw6
	 JrIh3gYJTbs8EcQvf+++hDHzIfVqoe/gi4NLbW+q72X79uGJVNFwPxhU1BBSahP3V6
	 Scco2N3Glsw0Fpk1O69yCahzbTdHkNAZyargDa3meLHS5DeRjbMwg4/gdMTEPjriRk
	 +EjACzOHFq8PXJ4CyHfY995759ba71M3BRhx8+qUwTv47/eUatZip9MvRWOuXXolmm
	 g+f4Bvjpc6kiA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60N1ee6cB2206677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:40:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 23 Jan 2026 09:40:40 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 23 Jan 2026 09:40:39 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 09:40:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/11] wifi: rtw89: rfk: add firmware command to do TX IQK
Date: Fri, 23 Jan 2026 09:39:47 +0800
Message-ID: <20260123013957.16418-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260123013957.16418-1-pkshih@realtek.com>
References: <20260123013957.16418-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31090-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:email,realtek.com:dkim,realtek.com:mid];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 05BF56F38F
X-Rspamd-Action: no action

TX IQK is a RF calibration, which driver call this H2C command to trigger
the calibration.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 43 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h  | 15 +++++++++
 drivers/net/wireless/realtek/rtw89/phy.c | 17 ++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h |  4 +++
 4 files changed, 79 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 5f98ca592a3e..fed74ad6b4bd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7614,6 +7614,49 @@ int rtw89_fw_h2c_rf_tas_trigger(struct rtw89_dev *rtwdev, bool enable)
 	return ret;
 }
 
+int rtw89_fw_h2c_rf_txiqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  const struct rtw89_chan *chan)
+{
+	struct rtw89_h2c_rf_txiqk *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c RF TXIQK\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_rf_txiqk *)skb->data;
+
+	h2c->len = len;
+	h2c->phy = phy_idx;
+	h2c->txiqk_enable = true;
+	h2c->is_wb_txiqk = true;
+	h2c->kpath = RF_AB;
+	h2c->cur_band = chan->band_type;
+	h2c->cur_bw = chan->band_width;
+	h2c->cur_ch = chan->channel;
+	h2c->txiqk_dbg_en = rtw89_debug_is_enabled(rtwdev, RTW89_DBG_RFK);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_RFK,
+			      H2C_FUNC_RFK_TXIQK_OFFOAD, 0, 0, len);
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
+
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
 			      bool rack, bool dack)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 521702f97d50..31402667e155 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4718,6 +4718,7 @@ enum rtw89_rfk_offload_h2c_func {
 	H2C_FUNC_RFK_RXDCK_OFFLOAD = 0x6,
 	H2C_FUNC_RFK_PRE_NOTIFY = 0x8,
 	H2C_FUNC_RFK_TAS_OFFLOAD = 0x9,
+	H2C_FUNC_RFK_TXIQK_OFFOAD = 0xc,
 };
 
 struct rtw89_fw_h2c_rf_get_mccch {
@@ -4935,6 +4936,18 @@ struct rtw89_h2c_rf_rxdck {
 	u8 is_chl_k;
 } __packed;
 
+struct rtw89_h2c_rf_txiqk {
+	u8 len;
+	u8 phy;
+	u8 txiqk_enable;
+	u8 is_wb_txiqk;
+	u8 kpath;
+	u8 cur_band;
+	u8 cur_bw;
+	u8 cur_ch;
+	u8 txiqk_dbg_en;
+} __packed;
+
 enum rtw89_rf_log_type {
 	RTW89_RF_RUN_LOG = 0,
 	RTW89_RF_RPT_LOG = 1,
@@ -5235,6 +5248,8 @@ int rtw89_fw_h2c_rf_dack(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			  const struct rtw89_chan *chan, bool is_chl_k);
 int rtw89_fw_h2c_rf_tas_trigger(struct rtw89_dev *rtwdev, bool enable);
+int rtw89_fw_h2c_rf_txiqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  const struct rtw89_chan *chan);
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
 			      bool rack, bool dack);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f3ef5673cb6a..fd2e9a472518 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4119,6 +4119,23 @@ int rtw89_phy_rfk_rxdck_and_wait(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_rfk_rxdck_and_wait);
 
+int rtw89_phy_rfk_txiqk_and_wait(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx phy_idx,
+				 const struct rtw89_chan *chan,
+				 unsigned int ms)
+{
+	int ret;
+
+	rtw89_phy_rfk_report_prep(rtwdev);
+
+	ret = rtw89_fw_h2c_rf_txiqk(rtwdev, phy_idx, chan);
+	if (ret)
+		return ret;
+
+	return rtw89_phy_rfk_report_wait(rtwdev, "TX_IQK", ms);
+}
+EXPORT_SYMBOL(rtw89_phy_rfk_txiqk_and_wait);
+
 static u32 phy_tssi_get_cck_group(u8 ch)
 {
 	switch (ch) {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 0c5224780e84..9a15dbf1c318 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -1031,6 +1031,10 @@ int rtw89_phy_rfk_rxdck_and_wait(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy_idx,
 				 const struct rtw89_chan *chan,
 				 bool is_chl_k, unsigned int ms);
+int rtw89_phy_rfk_txiqk_and_wait(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx phy_idx,
+				 const struct rtw89_chan *chan,
+				 unsigned int ms);
 void rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(struct rtw89_dev *rtwdev,
 					       enum rtw89_phy_idx phy,
 					       const struct rtw89_chan *chan,
-- 
2.25.1


