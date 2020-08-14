Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074DC244545
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 09:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgHNHKw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 03:10:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57192 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgHNHKw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 03:10:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597389051; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=/5+E+tFh01VFfvNQ3vQuSvQSYBMOJnEk15q0YCssIF8=; b=tilmGAuy+bmX9ALXfKIBfpEHT3wZWQHEG3muSTnKMCAH69WWiMDKWNxgPrtH37Zgrk21/GHN
 pZ0kYolYSS3Ehv5oeKhSdKuCo+WqSKPiEdLc6sX69WTEaAl0AXLV4FgAHWZDeZLh38dt2790
 FxZrrPn1oibwzk37mc6puTm3yMQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f3638f0c85a1092b060751f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 07:10:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D219CC433C6; Fri, 14 Aug 2020 07:10:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF8ABC433CA;
        Fri, 14 Aug 2020 07:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF8ABC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 03/11] ath11k: fill appropriate QMI service instance id for QCA6390
Date:   Fri, 14 Aug 2020 10:10:22 +0300
Message-Id: <1597389030-13887-4-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
References: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govind Singh <govinds@codeaurora.org>

QMI service instance id is used for qmi service lookup, IPQ8074 and QCA6390
uses different instance id for service lookup.  Fill appropriate QMI service
instance id for respective targets.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 1 +
 drivers/net/wireless/ath/ath11k/pci.c | 1 +
 drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.h | 3 +++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 06e599cbfbf9..2e0d90c022bb 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -581,6 +581,7 @@ static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
 	cfg->tgt_ce = target_ce_config_wlan;
 	cfg->svc_to_ce_map_len = ARRAY_SIZE(target_service_to_ce_map_wlan);
 	cfg->svc_to_ce_map = target_service_to_ce_map_wlan;
+	ab->qmi.service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074;
 }
 
 static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index dd3122b47d35..47ee5689a5e2 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -393,6 +393,7 @@ static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
 
 	cfg->svc_to_ce_map = target_service_to_ce_map_wlan;
 	cfg->svc_to_ce_map_len = ARRAY_SIZE(target_service_to_ce_map_wlan);
+	ab->qmi.service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390;
 }
 
 static void ath11k_pci_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index b182d6181057..acf7a3f2fe77 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2610,7 +2610,7 @@ int ath11k_qmi_init_service(struct ath11k_base *ab)
 
 	ret = qmi_add_lookup(&ab->qmi.handle, ATH11K_QMI_WLFW_SERVICE_ID_V01,
 			     ATH11K_QMI_WLFW_SERVICE_VERS_V01,
-			     ATH11K_QMI_WLFW_SERVICE_INS_ID_V01);
+			     ab->qmi.service_ins_id);
 	if (ret < 0) {
 		ath11k_warn(ab, "failed to add qmi lookup\n");
 		return ret;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index cd484a4d0216..d55ce6cf7222 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -18,6 +18,8 @@
 #define ATH11K_QMI_WLFW_SERVICE_ID_V01		0x45
 #define ATH11K_QMI_WLFW_SERVICE_VERS_V01	0x01
 #define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01	0x02
+#define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390	0x01
+#define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074	0x02
 #define ATH11K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01	32
 #define ATH11K_QMI_RESP_LEN_MAX			8192
 #define ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01	32
@@ -122,6 +124,7 @@ struct ath11k_qmi {
 	u8 cal_done;
 	struct target_info target;
 	struct m3_mem_region m3_mem;
+	unsigned int service_ins_id;
 };
 
 #define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		189
-- 
2.7.4

