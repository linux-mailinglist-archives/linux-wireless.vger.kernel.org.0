Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C22A46CE61
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 08:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbhLHHfR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 02:35:17 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:33131 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233900AbhLHHfR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 02:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638948705; x=1670484705;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=gHTSXC/AolTIbMQUfTIn6LHsqBZW/QKXSLOEiTj31cM=;
  b=AoF1VTwNa2WfZO3fSM4MFTtmk3SMDNreLkvR0XIxtG7Etls3fBhQC9mu
   TL2ZpAXFpOJ/2X0P1TWG5XUbw+yCK79EOvzLUfCWHjmJSmXspR2WAFXgS
   bw5Rmz47gmThxfh93qoQbOlrfPFntMm0Wn5sjZKLre3EmiTKgQrY8FhiC
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Dec 2021 23:31:45 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 23:31:46 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 23:31:45 -0800
Received: from cjhuang2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 23:31:43 -0800
From:   Carl Huang <quic_cjhuang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3] ath11k: set DTIM policy to stick mode for station interface
Date:   Wed, 8 Dec 2021 15:31:34 +0800
Message-ID: <1638948694-15582-1-git-send-email-quic_cjhuang@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set DTIM policy to DTIM stick mode, so station follows AP DTIM
interval rather than listen interval which is set in peer assoc cmd.
DTIM stick mode is more preferred per firmware team request.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
---
v3:
  - fixed the Signed-off email address to quicinc.com

v2:
  - rebased on top of 4f4f8aee394b73abf5e5f98c63187fdbf1d627f0

 drivers/net/wireless/ath/ath11k/mac.c | 7 +++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ffedd22dd1c0..f8a072020198 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2681,6 +2681,13 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	if (ret)
 		ath11k_warn(ar->ab, "failed to set vdev %i OBSS PD parameters: %d\n",
 			    arvif->vdev_id, ret);
+
+	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+					    WMI_VDEV_PARAM_DTIM_POLICY,
+					    WMI_DTIM_POLICY_STICK);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to set vdev %d dtim policy: %d\n",
+			    arvif->vdev_id, ret);
 }
 
 static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 35f5432357f5..7941838f5efc 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2169,6 +2169,13 @@ enum wmi_nss_ratio {
 	WMI_NSS_RATIO_2_NSS = 0x3,
 };
 
+enum wmi_dtim_policy {
+	WMI_DTIM_POLICY_IGNORE = 1,
+	WMI_DTIM_POLICY_NORMAL = 2,
+	WMI_DTIM_POLICY_STICK  = 3,
+	WMI_DTIM_POLICY_AUTO   = 4,
+};
+
 struct wmi_host_pdev_band_to_mac {
 	u32 pdev_id;
 	u32 start_freq;

base-commit: 4f4f8aee394b73abf5e5f98c63187fdbf1d627f0
-- 
2.32.0

