Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168FD4D2DE5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Mar 2022 12:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiCILZp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Mar 2022 06:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiCILZn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Mar 2022 06:25:43 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E8F155C3F
        for <linux-wireless@vger.kernel.org>; Wed,  9 Mar 2022 03:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646825085; x=1678361085;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ehH+Lo/z/nbOf/9EJEdMK+qE8kvy+kJoylFy5ryoBg4=;
  b=UTOWHYgIxJRDoDrEAXq+hs64PSMorlgjfuUufjt6tCjTOifJQd/nj6Xc
   7a9/AcBvCkBBWxQIIsMqqrALIk/LjogZ42/Ccvpnb2F50m7uiX4YRGTdE
   hZWIH4ckDtZxmGeIQjgcAeyNUUp9xOdrRmVFViTnnyW3vRMALmrpRWRj2
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 09 Mar 2022 03:24:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 03:24:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 03:24:43 -0800
Received: from haric-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 03:24:41 -0800
From:   <quic_haric@quicinc.com>
To:     <quic_kvalo@quicinc.com>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Hari Chandrakanthan" <quic_haric@quicinc.com>
Subject: [PATCH v1] ath11k: change fw build id format in driver init log
Date:   Wed, 9 Mar 2022 16:54:25 +0530
Message-ID: <1646825065-7736-1-git-send-email-quic_haric@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
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

From: Hari Chandrakanthan <quic_haric@quicinc.com>

Currently fw build id is printed during init as follows.

fw_version 0x250684a5 fw_build_timestamp 2021-07-13 10:57
fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

The string "QC_IMAGE_VERSION_STRING=" is removed from the log
to improve readability.

With this patch the fw build id is printed during init as follows.
fw_version 0x250684a5 fw_build_timestamp 2021-07-13 10:57
fw_build_id WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index b717813..a35cdaf 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -14,6 +14,8 @@
 #define SLEEP_CLOCK_SELECT_INTERNAL_BIT	0x02
 #define HOST_CSTATE_BIT			0x04
 
+#define FW_BUILD_ID_MASK "QC_IMAGE_VERSION_STRING="
+
 bool ath11k_cold_boot_cal = 1;
 EXPORT_SYMBOL(ath11k_cold_boot_cal);
 module_param_named(cold_boot_cal, ath11k_cold_boot_cal, bool, 0644);
@@ -1917,6 +1919,8 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 	struct qmi_txn txn;
 	int ret = 0;
 	int r;
+	char *fw_build_id;
+	int fw_build_id_mask_len;
 
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
@@ -1982,6 +1986,11 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 		ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi cal data supported from eeprom\n");
 	}
 
+	fw_build_id = ab->qmi.target.fw_build_id;
+	fw_build_id_mask_len = strlen(FW_BUILD_ID_MASK);
+	if (!strncmp(fw_build_id, FW_BUILD_ID_MASK, fw_build_id_mask_len))
+		fw_build_id = fw_build_id + fw_build_id_mask_len;
+
 	ath11k_info(ab, "chip_id 0x%x chip_family 0x%x board_id 0x%x soc_id 0x%x\n",
 		    ab->qmi.target.chip_id, ab->qmi.target.chip_family,
 		    ab->qmi.target.board_id, ab->qmi.target.soc_id);
@@ -1989,7 +1998,7 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 	ath11k_info(ab, "fw_version 0x%x fw_build_timestamp %s fw_build_id %s",
 		    ab->qmi.target.fw_version,
 		    ab->qmi.target.fw_build_timestamp,
-		    ab->qmi.target.fw_build_id);
+		    fw_build_id);
 
 	r = ath11k_core_check_dt(ab);
 	if (r)
-- 
2.7.4

