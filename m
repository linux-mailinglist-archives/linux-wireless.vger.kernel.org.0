Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174ED28F324
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Oct 2020 15:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgJONYh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Oct 2020 09:24:37 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:55296 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbgJONYg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Oct 2020 09:24:36 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 09:24:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1602767727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2sz7J8Yz3LTYLtzqhL2ZRuuO2JIiW1/h3IzHsmJHRs=;
        b=rFl/pcbGxYczCta0C0b9dTE8Adql2682JHNZ2CrKD8Qrjp44TyPFr0h5iA3KfA/G6tppF5
        MZCOoYstq6Oc5lOFO0Sgc2voxQha7wM87xMcHmeVW8dTj/ONMGeymhZG0Vv9NXNYOU4ZBp
        TMiARsh1BDpWUsdBZ/T8Chp98FDeVqg=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, devicetree@vger.kernel.org,
        Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/2] ath11k: search DT for qcom,ath11k-calibration-variant
Date:   Thu, 15 Oct 2020 15:15:01 +0200
Message-Id: <20201015131501.1939685-2-sven@narfation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015131501.1939685-1-sven@narfation.org>
References: <20201015131501.1939685-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Board Data File (BDF) is loaded upon driver boot-up procedure. The right
board data file is identified on IPQ6018 using bus, qmi-chip-id and
qmi-board-id.

The problem, however, can occur when the (default) board data file cannot
fulfill with the vendor requirements and it is necessary to use a different
board data file.

This problem was already solved on ath10k by adding a ",variant=.*" at the
end of the board name. The same functionality must also be provided for
ath11k.

The device tree requires an additional string to define the variant name

    wifi@c000000 {
        status = "okay";
        qcom,ath11k-calibration-variant = "Cigtech-WF-188";
    };

This would create the boarddata identifier for the board-2.bin search

 *  bus=ahb,qmi-chip-id=0,qmi-board-id=18,variant=Cigtech-WF-188

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 35 ++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/qmi.c  |  5 ++++
 drivers/net/wireless/ath/ath11k/qmi.h  |  2 ++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index ebd6886a8c18..c3af41226379 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/remoteproc.h>
 #include <linux/firmware.h>
+#include <linux/of.h>
 #include "core.h"
 #include "dp_tx.h"
 #include "dp_rx.h"
@@ -141,14 +142,44 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	},
 };
 
+int ath11k_core_check_dt(struct ath11k_base *ab)
+{
+	size_t max_len = sizeof(ab->qmi.target.bdf_ext);
+	const char *variant = NULL;
+	struct device_node *node;
+
+	node = ab->dev->of_node;
+	if (!node)
+		return -ENOENT;
+
+	of_property_read_string(node, "qcom,ath11k-calibration-variant",
+				&variant);
+	if (!variant)
+		return -ENODATA;
+
+	if (strscpy(ab->qmi.target.bdf_ext, variant, max_len) < 0)
+		ath11k_dbg(ab, ATH11K_DBG_BOOT,
+			   "bdf variant string is longer than the buffer can accommodate (variant: %s)\n",
+			    variant);
+
+	return 0;
+}
+
 static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 					 size_t name_len)
 {
+	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
+	char variant[9 + ATH11K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
+
+	if (ab->qmi.target.bdf_ext[0] != '\0')
+		scnprintf(variant, sizeof(variant), ",variant=%s",
+			  ab->qmi.target.bdf_ext);
+
 	scnprintf(name, name_len,
-		  "bus=%s,qmi-chip-id=%d,qmi-board-id=%d",
+		  "bus=%s,qmi-chip-id=%d,qmi-board-id=%d%s",
 		  ath11k_bus_str(ab->hif.bus),
 		  ab->qmi.target.chip_id,
-		  ab->qmi.target.board_id);
+		  ab->qmi.target.board_id, variant);
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot using board name '%s'\n", name);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 18b97420f0d8..18c961c9fd30 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -883,6 +883,7 @@ void ath11k_core_free(struct ath11k_base *ath11k);
 int ath11k_core_fetch_bdf(struct ath11k_base *ath11k,
 			  struct ath11k_board_data *bd);
 void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
+int ath11k_core_check_dt(struct ath11k_base *ath11k);
 
 void ath11k_core_halt(struct ath11k *ar);
 
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index c2b165158225..9fb4dea149bf 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1793,6 +1793,7 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 	struct qmi_wlanfw_cap_resp_msg_v01 resp;
 	struct qmi_txn txn = {};
 	int ret = 0;
+	int r;
 
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
@@ -1858,6 +1859,10 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 		    ab->qmi.target.fw_build_timestamp,
 		    ab->qmi.target.fw_build_id);
 
+	r = ath11k_core_check_dt(ab);
+	if (r)
+		ath11k_dbg(ab, ATH11K_DBG_QMI, "DT bdf variant name not set.\n");
+
 out:
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index b0a818f0401b..7b170bc9a913 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -24,6 +24,7 @@
 #define ATH11K_QMI_RESP_LEN_MAX			8192
 #define ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01	32
 #define ATH11K_QMI_CALDB_SIZE			0x480000
+#define ATH11K_QMI_BDF_EXT_STR_LENGTH		0x20
 
 #define QMI_WLFW_REQUEST_MEM_IND_V01		0x0035
 #define QMI_WLFW_FW_MEM_READY_IND_V01		0x0037
@@ -101,6 +102,7 @@ struct target_info {
 	u32 fw_version;
 	char fw_build_timestamp[ATH11K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01 + 1];
 	char fw_build_id[ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01 + 1];
+	char bdf_ext[ATH11K_QMI_BDF_EXT_STR_LENGTH];
 };
 
 struct m3_mem_region {
-- 
2.28.0

