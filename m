Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A651F3CAE
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 15:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgFINdp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 09:33:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50390 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbgFINdl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 09:33:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591709620; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=bi0kcoFCDpSOwpX8akilhJLHWYc+3OJnwXkPt4qNrrM=; b=HGQCH5ln1V11+5LRyVuSj6TEmsUHNBEB63OQ9oFewCIYZaVyUDNnpV4XS7R/zv8J1iNYGnpg
 Ry413oJFFLat2cRi06kCt4gNx0W/F1v721QHOe2C7cu3VLteq/otc+5F3l6fGyQL2Oql3trN
 rwlz9cG5fEg47q5C+I11HnzUkFs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5edf8fa8e144dd5115a5a152 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 13:33:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8A6BBC43387; Tue,  9 Jun 2020 13:33:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A887EC43395;
        Tue,  9 Jun 2020 13:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A887EC43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v2 4/8] ath11k: add IPQ6018 support
Date:   Tue,  9 Jun 2020 19:02:57 +0530
Message-Id: <1591709581-18039-5-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591709581-18039-1-git-send-email-akolli@codeaurora.org>
References: <1591709581-18039-1-git-send-email-akolli@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IPQ6018 has one 5G and one 2G radio with 2x2,
shares ipq8074 configurations.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |  3 ++
 drivers/net/wireless/ath/ath11k/core.c | 55 +++++++++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hw.h   |  6 ++++
 4 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 30092841ac46..dca014ea7ddf 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -20,6 +20,9 @@ static const struct of_device_id ath11k_ahb_of_match[] = {
 	{ .compatible = "qcom,ipq8074-wifi",
 	  .data = (void *)ATH11K_HW_IPQ8074,
 	},
+	{ .compatible = "qcom,ipq6018-wifi",
+	  .data = (void *)ATH11K_HW_IPQ6018,
+	},
 	{ }
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 02501cc154fe..abe9edb56309 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -17,12 +17,24 @@ unsigned int ath11k_debug_mask;
 module_param_named(debug_mask, ath11k_debug_mask, uint, 0644);
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
-static const struct ath11k_hw_params ath11k_hw_params = {
-	.name = "ipq8074",
-	.fw = {
-		.dir = IPQ8074_FW_DIR,
-		.board_size = IPQ8074_MAX_BOARD_DATA_SZ,
-		.cal_size =  IPQ8074_MAX_CAL_DATA_SZ,
+static const struct ath11k_hw_params ath11k_hw_params_list[] = {
+	{
+		.dev_id = ATH11K_HW_IPQ8074,
+		.name = "ipq8074",
+		.fw = {
+			.dir = IPQ8074_FW_DIR,
+			.board_size = IPQ8074_MAX_BOARD_DATA_SZ,
+			.cal_size =  IPQ8074_MAX_CAL_DATA_SZ,
+		},
+	},
+	{
+		.dev_id = ATH11K_HW_IPQ6018,
+		.name = "ipq6018",
+		.fw = {
+			.dir = IPQ6018_FW_DIR,
+			.board_size = IPQ6018_MAX_BOARD_DATA_SZ,
+			.cal_size =  IPQ6018_MAX_CAL_DATA_SZ,
+		},
 	},
 };
 
@@ -707,6 +719,30 @@ static void ath11k_core_restart(struct work_struct *work)
 	complete(&ab->driver_recovery);
 }
 
+static int ath11k_init_hw_params(struct ath11k_base *ab)
+{
+	const struct ath11k_hw_params *hw_params = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ath11k_hw_params_list); i++) {
+		hw_params = &ath11k_hw_params_list[i];
+
+		if (hw_params->dev_id == ab->hw_rev)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(ath11k_hw_params_list)) {
+		ath11k_err(ab, "Unsupported hardware version: 0x%x\n", ab->hw_rev);
+		return -EINVAL;
+	}
+
+	ab->hw_params = *hw_params;
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "Hardware name %s\n", ab->hw_params.name);
+
+	return 0;
+}
+
 int ath11k_core_init(struct ath11k_base *ab)
 {
 	struct device *dev = ab->dev;
@@ -725,7 +761,12 @@ int ath11k_core_init(struct ath11k_base *ab)
 		return -EINVAL;
 	}
 	ab->tgt_rproc = prproc;
-	ab->hw_params = ath11k_hw_params;
+
+	ret = ath11k_init_hw_params(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to get hw params %d\n", ret);
+		return ret;
+	}
 
 	ret = ath11k_core_soc_create(ab);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index e04f0e711779..ecf327537ad3 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -88,6 +88,7 @@ struct ath11k_skb_rxcb {
 
 enum ath11k_hw_rev {
 	ATH11K_HW_IPQ8074,
+	ATH11K_HW_IPQ6018,
 };
 
 enum ath11k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index f7f070af233c..e66f0e0138c4 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -73,6 +73,11 @@
 #define IPQ8074_MAX_BOARD_DATA_SZ	(256 * 1024)
 #define IPQ8074_MAX_CAL_DATA_SZ		IPQ8074_MAX_BOARD_DATA_SZ
 
+/* IPQ6018 definitions */
+#define IPQ6018_FW_DIR			ATH11K_FW_DIR "/IPQ6018/hw1.0"
+#define IPQ6018_MAX_BOARD_DATA_SZ	(256 * 1024)
+#define IPQ6018_MAX_CAL_DATA_SZ		IPQ6018_MAX_BOARD_DATA_SZ
+
 #define ATH11K_BOARD_MAGIC		"QCA-ATH11K-BOARD"
 #define ATH11K_BOARD_API2_FILE		"board-2.bin"
 #define ATH11K_DEFAULT_BOARD_FILE	"board.bin"
@@ -106,6 +111,7 @@ enum ath11k_bus {
 
 struct ath11k_hw_params {
 	const char *name;
+	u16 dev_id;
 	struct {
 		const char *dir;
 		size_t board_size;
-- 
2.7.4

