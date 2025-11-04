Return-Path: <linux-wireless+bounces-28524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C591C302F9
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 10:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D087C1891DCC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 09:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490AE309F0E;
	Tue,  4 Nov 2025 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ufqC0KnB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67F029B8FE
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247460; cv=none; b=jgfNIWwZssojgL8m2ueNewctzMfBgeOhpMjOZceEovr2RtT8Yb+jP6V1oZwb388aB3Z8ydBZL06J7gtG0M81rke3DwRb+jEgurwq/Mo8wASahVJ/jz+BhwYlNcE3cRRCrMzJojtNNoRrYhtQdRIQddPk9woBzMWFKS6Llnyetwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247460; c=relaxed/simple;
	bh=nPOYAdUuoq9CqiBgvk7heU7uTK9oJ4vRtCUpkroyatQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXnPxskBsNj7v0eelSqXc3RpSF749/wXaEYTFeUEnI8y8suG/auk9gGl62u3yE9KE1Ig3cUH7dzYcXzwrBntuYzZ3kPL9O2kAj7a3WzFLucHgBtpR09fOqBl7AKOObtb5ZxGPlF6ZZ+fH+SakScqqXsVPSUfRVVDClbAEtYujbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ufqC0KnB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A49AtAwA3073295, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762247455; bh=hfjzEzu4wqdPBV5OpWUXO4ebGpORRfvK/dhO3oXReOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=ufqC0KnBgyl0nW6y3qDQ4ToYncopKnIKqwdAWFRi/IP5aJ/NdH1X9Ssp0C58/7Nix
	 5vbL1y3uhM8WnPEErzHj313pfSIYPPMvTiO+v2IvCFYlbmSHEtGBWbbEwUqTaf/rVk
	 v1JQCS7FHB6Fza7gSuHJlIyOKMVLp36CCmfa7PU68DB9tnKgMSdTb3HhiE0b/dK3Rj
	 MYZK6bp8MqV6MKD/+kC/JOrMFgERvMoGdPNFslglqJd03UChEnrz4c2jFMP5hZdxD5
	 uRZ7eyInf7ZtwwT9hCX/uk/CfXDulqJk3vOO36yOHhYVZjezIc07GlJIGiwvQKcCsj
	 ddxWonHfgAsoQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A49AtAwA3073295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 17:10:55 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 17:10:54 +0800
Received: from [127.0.1.1] (172.21.146.58) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 4 Nov 2025 17:10:54 +0800
From: <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 2/8] wifi: rtw89: fw: parse firmware element of DIAG_MAC
Date: Tue, 4 Nov 2025 17:14:07 +0800
Message-ID: <1762247653-26864-3-git-send-email-pkshih@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
References: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ping-Ke Shih <pkshih@realtek.com>

The firmware element ID 28 is a set of rules to diagnose if MAC get
abnormal. The latter patch will use these rules via debugfs to know
the status.

The element contains rules with their textual messages shown as below:

   +------------------------------------+
   |                                    |
   |                +-----------+       |
   |                | rule_size |-------|----------+
   +----------------+-----------+-------+ --       |
   |             rule[0]                |   \      |
   |             rule[1]                |   |  <---+
   |                :                   |   /
   +------------------------------------+ --
   | msg[0]      msg[1]                 |  each msg has variable length
   |        msg[2]    msg[3] ...        |  (with address align 2)
   | ...                                |
   +------------------------------------+

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index fd0e1a68ecc4..01bfc5b473f5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4707,6 +4707,7 @@ struct rtw89_fw_elm_info {
 	struct rtw89_phy_rfk_log_fmt *rfk_log_fmt;
 	const struct rtw89_regd_data *regd;
 	const struct rtw89_fw_element_hdr *afe;
+	const struct rtw89_fw_element_hdr *diag_mac;
 };
 
 enum rtw89_fw_mss_dev_type {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index cb431c8a65ac..38b9654b7eec 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1298,6 +1298,18 @@ int rtw89_build_afe_pwr_seq_from_elm(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static
+int rtw89_recognize_diag_mac_from_elm(struct rtw89_dev *rtwdev,
+				      const struct rtw89_fw_element_hdr *elm,
+				      const union rtw89_fw_element_arg arg)
+{
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+
+	elm_info->diag_mac = elm;
+
+	return 0;
+}
+
 static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_BBMCU0] = {__rtw89_fw_recognize_from_elm,
 					{ .fw_type = RTW89_FW_BBMCU0 }, NULL},
@@ -1386,6 +1398,9 @@ static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_AFE_PWR_SEQ] = {
 		rtw89_build_afe_pwr_seq_from_elm, {}, "AFE",
 	},
+	[RTW89_FW_ELEMENT_ID_DIAG_MAC] = {
+		rtw89_recognize_diag_mac_from_elm, {}, NULL,
+	},
 };
 
 int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ddebf7972068..d184856f6c76 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3985,6 +3985,7 @@ enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_5GHZ = 25,
 	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_6GHZ = 26,
 	RTW89_FW_ELEMENT_ID_AFE_PWR_SEQ = 27,
+	RTW89_FW_ELEMENT_ID_DIAG_MAC = 28,
 
 	RTW89_FW_ELEMENT_ID_NUM,
 };
@@ -4162,6 +4163,11 @@ struct rtw89_fw_element_hdr {
 				__le32 val;
 			} __packed infos[];
 		} __packed afe;
+		struct {
+			__le32 rule_size;
+			u8 rsvd[4];
+			u8 rules_and_msgs[];
+		} __packed diag_mac;
 		struct __rtw89_fw_txpwr_element txpwr;
 		struct __rtw89_fw_regd_element regd;
 	} __packed u;
-- 
2.25.1


