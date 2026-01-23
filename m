Return-Path: <linux-wireless+bounces-31095-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L8oEMzRcmnKpgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31095-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:41:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EFC6F326
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7E433012C83
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 01:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5839128727B;
	Fri, 23 Jan 2026 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ck9HDY+Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6D2DB782
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132481; cv=none; b=s+ZUwdwN+2A7HtnN/QlSdGmXp4ZpCfeuv7P5GPz4bUmBFLXALoZ51+1L9ITqlAYCqPq0pHpNrkZc5jsvE2sGvGIJreufHEvaRoZIRumqu9V7DiOkh8oHJwnew/Lyi+cSVPZA1YDn1/NkLElAdd+5uKKhGmJI1Z0GSYgynBgl/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132481; c=relaxed/simple;
	bh=l+WtY5uM3kyGQD8tZFSEEMgIXlTVUxV1vu7Vam0xP7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZSb+QJCY92lIAi6TYntQLZnmn/BMvnIM6lyy6PzJVVpaEc1Ye8m8VqpxiI7BWwZII9Cp1ZPi3Ae0HWZe/pYQYCIgj97v82vg/XybKo0TbfQmqZZmBo0YgOZ0EWvHO/umhlkoPBgWbDObCz+ZXV7u5H+lPLbWTtd0YTnHhUY7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ck9HDY+Z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60N1eoyfF2206781, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769132450; bh=C1lbiP8JnzivfdyWExoK/HG5h6KNmqw0Jx6t3EXP820=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ck9HDY+ZDRjVufjuJGFnfHxyOBpRJjnBjWLDD7cBGx6nVW23+StGiI3CpwglpqaJk
	 fx/9W2F6Pkq5Jr00pt79D8iqSBPpgpuQLjpt/32Tm0J//1tt/WKmK12Xn2MeKITMFX
	 3aORGihZt9FRiBwyZQy8PNIp68f+jTShHsW6x/Trz/7yK8iIQi4PE+DRtMYlzeDAS2
	 tNrlPjN/sXiQK8Bu5td0589Dyn0cKvMxfD2ufOBItGysFRcNHIupdANANm7vwzC2pQ
	 dvUiDuZDcW8iy9Vh/ZIygdTywEa+x89a9yMpXLOY2nqoOrkmG1Rw81RS6gUZVX13zW
	 IcZXv49l/QfbQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60N1eoyfF2206781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:40:50 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 23 Jan 2026 09:40:50 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 09:40:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/11] wifi: rtw89: rfk: add firmware command to do CIM3K
Date: Fri, 23 Jan 2026 09:39:49 +0800
Message-ID: <20260123013957.16418-4-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31095-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9EFC6F326
X-Rspamd-Action: no action

CIM is short for counter intermodulation products 3rd-order. Due to
non-linearity in transmit path, need a calibration to yield performance
for RF system.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 41 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h  | 15 +++++++++
 drivers/net/wireless/realtek/rtw89/phy.c | 17 ++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h |  4 +++
 4 files changed, 77 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index fed74ad6b4bd..4035ec8defa8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7657,6 +7657,47 @@ int rtw89_fw_h2c_rf_txiqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	return ret;
 }
 
+int rtw89_fw_h2c_rf_cim3k(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  const struct rtw89_chan *chan)
+{
+	struct rtw89_h2c_rf_cim3k *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c RF CIM3K\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_rf_cim3k *)skb->data;
+
+	h2c->len = len;
+	h2c->phy = phy_idx;
+	h2c->kpath = RF_AB;
+	h2c->cur_band = chan->band_type;
+	h2c->cur_bw = chan->band_width;
+	h2c->cur_ch = chan->channel;
+	h2c->cim3k_dbg_en = rtw89_debug_is_enabled(rtwdev, RTW89_DBG_RFK);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_RFK,
+			      H2C_FUNC_RFK_CIM3K_OFFOAD, 0, 0, len);
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
index c3ad473a06f2..2f04138148b7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4719,6 +4719,7 @@ enum rtw89_rfk_offload_h2c_func {
 	H2C_FUNC_RFK_PRE_NOTIFY = 0x8,
 	H2C_FUNC_RFK_TAS_OFFLOAD = 0x9,
 	H2C_FUNC_RFK_TXIQK_OFFOAD = 0xc,
+	H2C_FUNC_RFK_CIM3K_OFFOAD = 0xe,
 };
 
 struct rtw89_fw_h2c_rf_get_mccch {
@@ -4948,6 +4949,18 @@ struct rtw89_h2c_rf_txiqk {
 	u8 txiqk_dbg_en;
 } __packed;
 
+struct rtw89_h2c_rf_cim3k {
+	u8 len;
+	u8 phy;
+	u8 su_cim3k_enable[2];
+	u8 ru_cim3k_enable[2];
+	u8 kpath;
+	u8 cur_band;
+	u8 cur_bw;
+	u8 cur_ch;
+	u8 cim3k_dbg_en;
+} __packed;
+
 enum rtw89_rf_log_type {
 	RTW89_RF_RUN_LOG = 0,
 	RTW89_RF_RPT_LOG = 1,
@@ -5270,6 +5283,8 @@ int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 int rtw89_fw_h2c_rf_tas_trigger(struct rtw89_dev *rtwdev, bool enable);
 int rtw89_fw_h2c_rf_txiqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			  const struct rtw89_chan *chan);
+int rtw89_fw_h2c_rf_cim3k(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  const struct rtw89_chan *chan);
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
 			      bool rack, bool dack);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 215864d1e1c7..5f6854b7550d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4149,6 +4149,23 @@ int rtw89_phy_rfk_txiqk_and_wait(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_rfk_txiqk_and_wait);
 
+int rtw89_phy_rfk_cim3k_and_wait(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx phy_idx,
+				 const struct rtw89_chan *chan,
+				 unsigned int ms)
+{
+	int ret;
+
+	rtw89_phy_rfk_report_prep(rtwdev);
+
+	ret = rtw89_fw_h2c_rf_cim3k(rtwdev, phy_idx, chan);
+	if (ret)
+		return ret;
+
+	return rtw89_phy_rfk_report_wait(rtwdev, "CIM3k", ms);
+}
+EXPORT_SYMBOL(rtw89_phy_rfk_cim3k_and_wait);
+
 static u32 phy_tssi_get_cck_group(u8 ch)
 {
 	switch (ch) {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 89e3bc588494..5e04bdcef4e9 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -1036,6 +1036,10 @@ int rtw89_phy_rfk_txiqk_and_wait(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy_idx,
 				 const struct rtw89_chan *chan,
 				 unsigned int ms);
+int rtw89_phy_rfk_cim3k_and_wait(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx phy_idx,
+				 const struct rtw89_chan *chan,
+				 unsigned int ms);
 void rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(struct rtw89_dev *rtwdev,
 					       enum rtw89_phy_idx phy,
 					       const struct rtw89_chan *chan,
-- 
2.25.1


