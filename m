Return-Path: <linux-wireless+bounces-23785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB08FACFB13
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 04:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B17F3A92B5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 02:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE2E1CEAD6;
	Fri,  6 Jun 2025 02:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cmzhCpRd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C41DC985
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 02:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175413; cv=none; b=sna2c/ItD8in9ixazjTXUSj+kJTgDqT++2K8w25VTpG+iRaPNqz+YyTrxMV/QpG9irQ1CQDh4RRF0V+yxeZynHwT/KLSeC+jEq+MAOq8+O0+GjZXz50XRDPqS7Pxc8+27iOnDSPO/UYH8tcqJxmI18rtiEFcCOGiIwxWznkN3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175413; c=relaxed/simple;
	bh=MD2ekveY1cypAOft54mt0Y3HRoCKmqYsJsOqWXXpfyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyWM0cw9abTi4TFaKOmqPKXSWAAnixgbdidl+yWGdTjG/k91dKj8XzmyA/XN44jVE/pgECG9aww/H+3f1KJ847QktFSzs1p0EIUa3kMSER+MA3me5i5amqnzpXApw+NZgrN+t2g/4a347yZCDAcNHP9Dh3A5COjhs06yuSc6Rkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cmzhCpRd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55623T2f82620772, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749175409; bh=kktZIK+V2IG6fJVsSVOihQ0F4lme1w/jSX6Ijzz3A80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cmzhCpRdsObe26v4OOQopJiT1/7i9aBdNB5XhRPQ2+RiSpA1Ra58GvytJcn1jeDkT
	 eJZXNqI9oQQmMmJKSvQSL4x6upxgPdJ5kkjSpVWTMpONbT/g6M9nnEVtwVjRs37XbY
	 xpFbvfN1JO1Ty3N+Dt+Ol0uylG2jES4GMqC4sKbbqLM5WKKsBBwkQ7Uq6EqUskFqat
	 k3it3EGnjOUcBAJOgXvFoC6mIzA52hDxQo2Z+MhgT96hSd4KgYj+N7bXwUkcuU9iUv
	 V0VUFrAWmxFZtU30kzilCvZ+1bBr1c8vBn3jAfaD3lF0soErNw4fLivbjK+yXI2tyr
	 Fo9jIfYNNZzTw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55623T2f82620772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 10:03:29 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Jun 2025 10:03:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Jun
 2025 10:03:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 3/6] wifi: rtw89: rfk: support IQK firmware command v1
Date: Fri, 6 Jun 2025 10:02:59 +0800
Message-ID: <20250606020302.16873-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250606020302.16873-1-pkshih@realtek.com>
References: <20250606020302.16873-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Add new IQK firmware command format v1 (with suffix), and rename original
command format to v0 for older firmware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 30 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h   | 13 +++++++++-
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1c8f3b9b7c4c..c570f0180923 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4513,6 +4513,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V0,
 	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V1,
 	RTW89_FW_FEATURE_RFK_RXDCK_V0,
+	RTW89_FW_FEATURE_RFK_IQK_V0,
 	RTW89_FW_FEATURE_NO_WOW_CPU_IO_RX,
 	RTW89_FW_FEATURE_NOTIFY_AP_INFO,
 	RTW89_FW_FEATURE_CH_INFO_BE_V0,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 1d37ea7f1391..0547eb11d378 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -845,6 +845,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 21, 0, SCAN_OFFLOAD_BE_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 12, 0, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 22, 0, WOW_REASON_V1),
+	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 28, 0, RFK_IQK_V0),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 31, 0, RFK_PRE_NOTIFY_V0),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 31, 0, LPS_CH_INFO),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 42, 0, RFK_RXDCK_V0),
@@ -6080,22 +6081,47 @@ int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			const struct rtw89_chan *chan)
 {
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_h2c_rf_iqk_v0 *h2c_v0;
 	struct rtw89_h2c_rf_iqk *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
+	u8 ver = U8_MAX;
 	int ret;
 
+	if (RTW89_CHK_FW_FEATURE(RFK_IQK_V0, &rtwdev->fw)) {
+		len = sizeof(*h2c_v0);
+		ver = 0;
+	}
+
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c RF IQK\n");
 		return -ENOMEM;
 	}
 	skb_put(skb, len);
+
+	if (ver == 0) {
+		h2c_v0 = (struct rtw89_h2c_rf_iqk_v0 *)skb->data;
+
+		h2c_v0->phy_idx = cpu_to_le32(phy_idx);
+		h2c_v0->dbcc = cpu_to_le32(rtwdev->dbcc_en);
+
+		goto done;
+	}
+
 	h2c = (struct rtw89_h2c_rf_iqk *)skb->data;
 
-	h2c->phy_idx = cpu_to_le32(phy_idx);
-	h2c->dbcc = cpu_to_le32(rtwdev->dbcc_en);
+	h2c->len = sizeof(*h2c);
+	h2c->ktype = 0;
+	h2c->phy = phy_idx;
+	h2c->kpath = rtw89_phy_get_kpath(rtwdev, phy_idx);
+	h2c->band = chan->band_type;
+	h2c->bw = chan->band_width;
+	h2c->ch = chan->channel;
+	h2c->cv = hal->cv;
 
+done:
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_RFK,
 			      H2C_FUNC_RFK_IQK_OFFLOAD, 0, 0, len);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2fc2d1d61e29..d4815bcce91b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4438,11 +4438,22 @@ struct rtw89_h2c_rf_tssi {
 	u8 rfe_type;
 } __packed;
 
-struct rtw89_h2c_rf_iqk {
+struct rtw89_h2c_rf_iqk_v0 {
 	__le32 phy_idx;
 	__le32 dbcc;
 } __packed;
 
+struct rtw89_h2c_rf_iqk {
+	u8 len;
+	u8 ktype;
+	u8 phy;
+	u8 kpath;
+	u8 band;
+	u8 bw;
+	u8 ch;
+	u8 cv;
+} __packed;
+
 struct rtw89_h2c_rf_dpk {
 	u8 len;
 	u8 phy;
-- 
2.25.1


