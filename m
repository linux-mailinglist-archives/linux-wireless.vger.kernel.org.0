Return-Path: <linux-wireless+bounces-2984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC656846658
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 04:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0C4B227E3
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 03:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14B0DF4C;
	Fri,  2 Feb 2024 03:07:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A5CA70
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843256; cv=none; b=SX4C8wCIMYus5AGjdd9CfViHZ1rS+NeAOAC+gOqNYxDsZDCgh2spcbpO+cvlp6rskPziGU9KwDPxQLB7WGftKDSn76UKf85/0FCxW8VH+fG/udOYIJGsAUtzWBR4VWyxsDPG9Fb93XabBlxer5giE+R5D1S1Vya0gZyYX9xBwV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843256; c=relaxed/simple;
	bh=wXv5uMOX45nFD7Ree14neaks36I8B6klsxPdOEv9Jrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyfhmWFNzlvLqJBZMU0ZOZXw5YKXHblQWe0eWkyT2tmAa5BpGqiec5k33qVHFg27WQVxM+ggxXHk+x5OuK2ge+EV+z1EG5bR8496YOD6rm5pBoSw888BlbDvd7xH+dznhfmsYHZGu7YbOAVdhS8MinPYsM5boBUnOP5yT+UIn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41237TfG41863083, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41237TfG41863083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 11:07:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 2 Feb 2024 11:07:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Feb
 2024 11:07:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 03/11] wifi: rtw89: rfk: add H2C command to trigger IQK
Date: Fri, 2 Feb 2024 11:06:34 +0800
Message-ID: <20240202030642.108385-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202030642.108385-1-pkshih@realtek.com>
References: <20240202030642.108385-1-pkshih@realtek.com>
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

IQ signal calibration is a basic and important calibration to yield good RF
performance. Do this calibration on AP channel if we are going to connect.
During scanning phase, it transmits with low data rate, so without IQK
RF performance is still acceptable.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 35 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h |  7 +++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 5bd3d08a5d25..d2c166ee5c89 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4593,6 +4593,41 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_h2c_rf_iqk *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c RF IQK\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_rf_iqk *)skb->data;
+
+	h2c->phy_idx = cpu_to_le32(phy_idx);
+	h2c->dbcc = cpu_to_le32(rtwdev->dbcc_en);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_RFK,
+			      H2C_FUNC_RFK_IQK_OFFLOAD, 0, 0, len);
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
index d9316b66ab76..e9c7f9532b0b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3935,6 +3935,7 @@ enum rtw89_mcc_h2c_func {
 #define H2C_CL_OUTSRC_RF_FW_RFK		0xb
 
 enum rtw89_rfk_offload_h2c_func {
+	H2C_FUNC_RFK_IQK_OFFLOAD = 0x1,
 	H2C_FUNC_RFK_PRE_NOTIFY = 0x8,
 };
 
@@ -3982,6 +3983,11 @@ struct rtw89_fw_h2c_rfk_pre_info {
 	} __packed mlo;
 } __packed;
 
+struct rtw89_h2c_rf_iqk {
+	__le32 phy_idx;
+	__le32 dbcc;
+} __packed;
+
 enum rtw89_rf_log_type {
 	RTW89_RF_RUN_LOG = 0,
 	RTW89_RF_RPT_LOG = 1,
@@ -4169,6 +4175,7 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx);
+int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
 			      bool rack, bool dack);
-- 
2.25.1


