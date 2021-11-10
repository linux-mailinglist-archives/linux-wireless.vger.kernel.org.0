Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8744C47D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 16:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhKJPjD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 10:39:03 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:61986 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhKJPjC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 10:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636558575; x=1668094575;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=6pqHHAwHwHiiVqjFTIQqX0idFJTAseI5HjTjevH/U7o=;
  b=oW/7BK9s2JPyn0QTQ7c4TkczKAZDC+O0KhN/+JPEX5jN72oOupbC1rWK
   Gy+Nt4r3uKaGsbbtqP2UvSOqfm9bDPUTWxO2cmj9fgSSSM8cAV38O0QgF
   S3Cv/fMxCuuFLVDS09VTSuyMdTV/WaLX7qbCM9woywEw8A/2nYvH7ZeKK
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 Nov 2021 07:36:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 07:36:14 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 07:36:14 -0800
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 07:36:11 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH] ath11k: fix error routine when fallback of add interface fails
Date:   Wed, 10 Nov 2021 21:05:57 +0530
Message-ID: <1636558557-2874-1-git-send-email-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When there is an error in add interface process from
ath11k_mac_set_kickout(), the code attempts to handle a
fallback for add_interface. When this fallback succeeds, the
driver returns zero rather than error code. This leads to
success for the non created VAP. In cleanup, driver gets
remove interface callback for the non created VAP and
proceeds to self peer delete request which leads to FW assert.
Since it was already deleted on the fallback of add interface,
return the actual error code instead of fallback return code.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00729-QCAHKSWPL_SILICONZ-3 v2

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 5d860fe..25f5248 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5523,7 +5523,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	u32 param_id, param_value;
 	u16 nss;
 	int i;
-	int ret;
+	int ret, fbret;
 	int bit;
 
 	vif->driver_flags |= IEEE80211_VIF_SUPPORTS_UAPSD;
@@ -5725,17 +5725,17 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		reinit_completion(&ar->peer_delete_done);
 
-		ret = ath11k_wmi_send_peer_delete_cmd(ar, vif->addr,
-						      arvif->vdev_id);
-		if (ret) {
+		fbret = ath11k_wmi_send_peer_delete_cmd(ar, vif->addr,
+							arvif->vdev_id);
+		if (fbret) {
 			ath11k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
 				    arvif->vdev_id, vif->addr);
 			goto err;
 		}
 
-		ret = ath11k_wait_for_peer_delete_done(ar, arvif->vdev_id,
-						       vif->addr);
-		if (ret)
+		fbret = ath11k_wait_for_peer_delete_done(ar, arvif->vdev_id,
+							 vif->addr);
+		if (fbret)
 			goto err;
 
 		ar->num_peers--;
-- 
2.7.4

