Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2B4933FD
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 05:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiASEOL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jan 2022 23:14:11 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:37450 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235242AbiASEOK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jan 2022 23:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642565650; x=1674101650;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dQYzAZrTB3T+uXzmQ+4HkULaY3Ii7RG1dql0LlDJCF0=;
  b=OI6tQMT296pPXGqSuwJPyMaDZ0+fokQZorKyzeaQlBn46vKFA96QxslH
   rNiO3fTPloQPzWgRvSVx61EKP4AN7KU6Oyey9lbGkdh1AyplpfbpzubpL
   rl+xaOLKc90XvFsdhj9YJIcuLWyNP0U9QvB2TbrmsJV5ptoLYDh3fwy/0
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Jan 2022 20:14:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 20:14:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 18 Jan 2022 20:14:09 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 18 Jan 2022 20:14:08 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: avoid firmware crash when reg set for QCA6390/WCN6855
Date:   Tue, 18 Jan 2022 23:13:55 -0500
Message-ID: <20220119041355.32014-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the NL80211_REGDOM_SET_BY_USER hint from cfg80211, it set the new
alpha2 code to ath11k, then ath11k send WMI_SET_INIT_COUNTRY_CMDID to
firmware for all chips currently. When test with WCN6855/QCA6390 chips,
this WMI CMD leads firmware crash.

For AP based chips(ipq8074/qcn9074), WMI_SET_INIT_COUNTRY_CMDID is used
to send to firmware, for STATION based chips(WCN6855/QCA6390), it need to
use another WMI CMD WMI_SET_CURRENT_COUNTRY_CMDID.

Add flag current_cc_support in hardware parameters, it is used to
distinguish AP/STA platform. After that, the firmware will work
normal and the regulatory feature works well for QCA6390/WCN6855.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  6 ++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/reg.c  | 25 +++++++++++++++++--------
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 1ad77bd721b9..7c508e9baa6d 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -98,6 +98,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.wakeup_mhi = false,
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
+		.current_cc_support = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -162,6 +163,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.wakeup_mhi = false,
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
+		.current_cc_support = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -225,6 +227,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.wakeup_mhi = true,
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
+		.current_cc_support = true,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -288,6 +291,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.wakeup_mhi = false,
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
+		.current_cc_support = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -351,6 +355,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.wakeup_mhi = true,
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
+		.current_cc_support = true,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -413,6 +418,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.wakeup_mhi = true,
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
+		.current_cc_support = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index e06d392be2fb..c10e1a01fb02 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -192,6 +192,7 @@ struct ath11k_hw_params {
 	bool wakeup_mhi;
 	bool supports_rssi_stats;
 	bool fw_wmi_diag_event;
+	bool current_cc_support;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index d6575feca5a2..81e11cde31d7 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -48,6 +48,7 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct wmi_init_country_params init_country_param;
+	struct wmi_set_current_country_params set_current_param = {};
 	struct ath11k *ar = hw->priv;
 	int ret;
 
@@ -76,18 +77,26 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 		return;
 	}
 
-	/* Set the country code to the firmware and wait for
+	/* Set the country code to the firmware and will receive
 	 * the WMI_REG_CHAN_LIST_CC EVENT for updating the
 	 * reg info
 	 */
-	init_country_param.flags = ALPHA_IS_SET;
-	memcpy(&init_country_param.cc_info.alpha2, request->alpha2, 2);
-	init_country_param.cc_info.alpha2[2] = 0;
+	if (ar->ab->hw_params.current_cc_support) {
+		memcpy(&set_current_param.alpha2, request->alpha2, 2);
+		ret = ath11k_wmi_send_set_current_country_cmd(ar, &set_current_param);
+		if (ret)
+			ath11k_warn(ar->ab,
+				    "failed set current country code: %d\n", ret);
+	} else {
+		init_country_param.flags = ALPHA_IS_SET;
+		memcpy(&init_country_param.cc_info.alpha2, request->alpha2, 2);
+		init_country_param.cc_info.alpha2[2] = 0;
 
-	ret = ath11k_wmi_send_init_country_cmd(ar, init_country_param);
-	if (ret)
-		ath11k_warn(ar->ab,
-			    "INIT Country code set to fw failed : %d\n", ret);
+		ret = ath11k_wmi_send_init_country_cmd(ar, init_country_param);
+		if (ret)
+			ath11k_warn(ar->ab,
+				    "INIT Country code set to fw failed : %d\n", ret);
+	}
 
 	ath11k_mac_11d_scan_stop(ar);
 	ar->regdom_set_by_user = true;

base-commit: 7ed59172e3753f2a4d7a39515f1c937ea9edb968
-- 
2.31.1

