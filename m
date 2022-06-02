Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BEB53B980
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jun 2022 15:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiFBNOM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jun 2022 09:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiFBNOL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jun 2022 09:14:11 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFCFD94
        for <linux-wireless@vger.kernel.org>; Thu,  2 Jun 2022 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654175648; x=1685711648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vJcXBskslpghKa6iRYrdfqEqjidM0JWM2EfBfNovq7s=;
  b=cv+qXb76qWLynxRbptyzT04UobgMdTpLRcbXiVFyprtoXYl7eO7yfP38
   mII3gKuAziN1ofnHYZCuYqV/dTmAwtwcerprpEUxkgRDdpDoAW+xa6jpY
   6ei8XhaobS33URCm/MzBXZWK8cRnr+prJs+sc/y0ajLfTEVLbmujUWJfn
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Jun 2022 06:14:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 06:14:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 06:14:08 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 06:14:06 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH] ath11k: Fix warnings reported by checkpatch
Date:   Thu, 2 Jun 2022 18:43:50 +0530
Message-ID: <20220602131350.29486-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix warnings reported by checkpatch tool. Below are the errors fixed,

drivers/net/wireless/ath/ath11k/hal_rx.c:760: 'recevied' may be misspelled - perhaps 'received?
drivers/net/wireless/ath/ath11k/qmi.c:2232: Prefer strscpy over strlcpy
drivers/net/wireless/ath/ath11k/qmi.c:2238: Prefer strscpy over strlcpy
drivers/net/wireless/ath/ath11k/qmi.c:2662: Prefer strscpy over strlcpy
drivers/net/wireless/ath/ath11k/mac.c:7836: 'atleast' may be misspelled - perhaps 'at least'?
drivers/net/wireless/ath/ath11k/wmi.c:6566: 'succeded' may be misspelled - perhaps 'succeeded'?

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal_rx.c | 2 +-
 drivers/net/wireless/ath/ath11k/mac.c    | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.c    | 6 +++---
 drivers/net/wireless/ath/ath11k/wmi.c    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 4bb1fbaed0c9..7f39c6fb7408 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -757,7 +757,7 @@ void ath11k_hal_reo_qdesc_setup(void *vaddr, int tid, u32 ba_window_size,
 
 	/* TODO: HW queue descriptors are currently allocated for max BA
 	 * window size for all QOS TIDs so that same descriptor can be used
-	 * later when ADDBA request is recevied. This should be changed to
+	 * later when ADDBA request is received. This should be changed to
 	 * allocate HW queue descriptors based on BA window size being
 	 * negotiated (0 for non BA cases), and reallocate when BA window
 	 * size changes and also send WMI message to FW to change the REO
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f11956163822..ea1b6c6feee3 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7833,7 +7833,7 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	he_ltf = mask->control[band].he_ltf;
 
 	/* mac80211 doesn't support sending a fixed HT/VHT MCS alone, rather it
-	 * requires passing atleast one of used basic rates along with them.
+	 * requires passing at least one of used basic rates along with them.
 	 * Fixed rate setting across different preambles(legacy, HT, VHT) is
 	 * not supported by the FW. Hence use of FIXED_RATE vdev param is not
 	 * suitable for setting single HT/VHT rates.
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 61ead37a944a..00136601cb7d 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2229,13 +2229,13 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 
 	if (resp.fw_version_info_valid) {
 		ab->qmi.target.fw_version = resp.fw_version_info.fw_version;
-		strlcpy(ab->qmi.target.fw_build_timestamp,
+		strscpy(ab->qmi.target.fw_build_timestamp,
 			resp.fw_version_info.fw_build_timestamp,
 			sizeof(ab->qmi.target.fw_build_timestamp));
 	}
 
 	if (resp.fw_build_id_valid)
-		strlcpy(ab->qmi.target.fw_build_id, resp.fw_build_id,
+		strscpy(ab->qmi.target.fw_build_id, resp.fw_build_id,
 			sizeof(ab->qmi.target.fw_build_id));
 
 	if (resp.eeprom_read_timeout_valid) {
@@ -2659,7 +2659,7 @@ static int ath11k_qmi_wlanfw_wlan_cfg_send(struct ath11k_base *ab)
 	memset(&resp, 0, sizeof(resp));
 
 	req->host_version_valid = 1;
-	strlcpy(req->host_version, ATH11K_HOST_VERSION_STRING,
+	strscpy(req->host_version, ATH11K_HOST_VERSION_STRING,
 		sizeof(req->host_version));
 
 	req->tgt_cfg_valid = 1;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 84d1c7054013..f69918b9452a 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6563,7 +6563,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *sk
 
 fallback:
 	/* Fallback to older reg (by sending previous country setting
-	 * again if fw has succeded and we failed to process here.
+	 * again if fw has succeeded and we failed to process here.
 	 * The Regdomain should be uniform across driver and fw. Since the
 	 * FW has processed the command and sent a success status, we expect
 	 * this function to succeed as well. If it doesn't, CTRY needs to be
-- 
2.35.1

