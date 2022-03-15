Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7F04D9966
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 11:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347535AbiCOKuS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 06:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348648AbiCOKtm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 06:49:42 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D406369FC
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647341262; x=1678877262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4pdRjqqAdK6Gq4JFTKaznUNw1oFlisnbZpSDzmMzMQI=;
  b=IDxKYIWW1S4Z/gqZFjj+oWEkSEfoakZFy49SJP7gGHC1Xh0Zvb0uoYNj
   An30LURUeAhio7nFkal+u+ajzpzdUSi86pUPznh5YbSNtOGOTysDH2QLv
   2/kU6WHkfCkg1sg/sE5uD3KAV7oeyp3KpWTjq6TR01Foumc9Jbrh4U2ww
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 03:47:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 03:47:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Mar 2022 03:47:41 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 15 Mar 2022 03:47:40 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v6 2/2] ath11k: add read variant from SMBIOS for download board data
Date:   Tue, 15 Mar 2022 06:47:21 -0400
Message-ID: <20220315104721.26649-3-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220315104721.26649-1-quic_wgong@quicinc.com>
References: <20220315104721.26649-1-quic_wgong@quicinc.com>
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

This is to read variant from SMBIOS such as read from DT, the variant
string will be used to one part of string which used to search board
data from board-2.bin.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 68 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h | 20 +++++++-
 drivers/net/wireless/ath/ath11k/qmi.c  |  4 ++
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 7711bdb36170..6a2cbd07525d 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -9,6 +9,7 @@
 #include <linux/remoteproc.h>
 #include <linux/firmware.h>
 #include <linux/of.h>
+
 #include "core.h"
 #include "dp_tx.h"
 #include "dp_rx.h"
@@ -509,6 +510,73 @@ int ath11k_core_resume(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_core_resume);
 
+static void ath11k_core_check_bdfext(const struct dmi_header *hdr, void *data)
+{
+	struct ath11k_base *ab = data;
+	const char *magic = ATH11K_SMBIOS_BDF_EXT_MAGIC;
+	struct ath11k_smbios_bdf *smbios = (struct ath11k_smbios_bdf *)hdr;
+	int i;
+	size_t len;
+
+	if (ab->qmi.target.bdf_ext[0] != '\0')
+		return;
+
+	if (hdr->type != ATH11K_SMBIOS_BDF_EXT_TYPE)
+		return;
+
+	if (hdr->length != ATH11K_SMBIOS_BDF_EXT_LENGTH) {
+		ath11k_dbg(ab, ATH11K_DBG_BOOT,
+			   "wrong smbios bdf ext type length (%d).\n",
+			   hdr->length);
+		return;
+	}
+
+	if (!smbios->bdf_enabled) {
+		ath11k_dbg(ab, ATH11K_DBG_BOOT, "bdf variant name not found.\n");
+		return;
+	}
+
+	/* Only one string exists (per spec) */
+	if (memcmp(smbios->bdf_ext, magic, strlen(magic)) != 0) {
+		ath11k_dbg(ab, ATH11K_DBG_BOOT,
+			   "bdf variant magic does not match.\n");
+		return;
+	}
+
+	len = min_t(size_t,
+		    strlen(smbios->bdf_ext), sizeof(ab->qmi.target.bdf_ext));
+	for (i = 0; i < len; i++) {
+		if (!isascii(smbios->bdf_ext[i]) || !isprint(smbios->bdf_ext[i])) {
+			ath11k_dbg(ab, ATH11K_DBG_BOOT,
+				   "bdf variant name contains non ascii chars.\n");
+			return;
+		}
+	}
+
+	/* Copy extension name without magic prefix */
+	if (strscpy(ab->qmi.target.bdf_ext, smbios->bdf_ext + strlen(magic),
+		    sizeof(ab->qmi.target.bdf_ext)) < 0) {
+		ath11k_dbg(ab, ATH11K_DBG_BOOT,
+			   "bdf variant string is longer than the buffer can accommodate\n");
+		return;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT,
+		   "found and validated bdf variant smbios_type 0x%x bdf %s\n",
+		   ATH11K_SMBIOS_BDF_EXT_TYPE, ab->qmi.target.bdf_ext);
+}
+
+int ath11k_core_check_smbios(struct ath11k_base *ab)
+{
+	ab->qmi.target.bdf_ext[0] = '\0';
+	dmi_walk(ath11k_core_check_bdfext, ab);
+
+	if (ab->qmi.target.bdf_ext[0] == '\0')
+		return -ENODATA;
+
+	return 0;
+}
+
 int ath11k_core_check_dt(struct ath11k_base *ab)
 {
 	size_t max_len = sizeof(ab->qmi.target.bdf_ext);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index c0228e91a596..891507dbccc7 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -10,6 +10,8 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/bitfield.h>
+#include <linux/dmi.h>
+#include <linux/ctype.h>
 #include "qmi.h"
 #include "htc.h"
 #include "wmi.h"
@@ -36,6 +38,15 @@
 #define ATH11K_INVALID_HW_MAC_ID	0xFF
 #define ATH11K_CONNECTION_LOSS_HZ	(3 * HZ)
 
+/* SMBIOS type containing Board Data File Name Extension */
+#define ATH11K_SMBIOS_BDF_EXT_TYPE 0xF8
+
+/* SMBIOS type structure length (excluding strings-set) */
+#define ATH11K_SMBIOS_BDF_EXT_LENGTH 0x9
+
+/* The magic used by QCA spec */
+#define ATH11K_SMBIOS_BDF_EXT_MAGIC "BDF_"
+
 extern unsigned int ath11k_frame_mode;
 
 #define ATH11K_MON_TIMER_INTERVAL  10
@@ -147,6 +158,13 @@ struct ath11k_ext_irq_grp {
 	struct net_device napi_ndev;
 };
 
+struct ath11k_smbios_bdf {
+	struct dmi_header hdr;
+	u32 padding;
+	u8 bdf_enabled;
+	u8 bdf_ext[1];
+};
+
 #define HEHANDLE_CAP_PHYINFO_SIZE       3
 #define HECAP_PHYINFO_SIZE              9
 #define HECAP_MACINFO_SIZE              5
@@ -996,7 +1014,7 @@ int ath11k_core_fetch_board_data_api_1(struct ath11k_base *ab,
 				       const char *name);
 void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
 int ath11k_core_check_dt(struct ath11k_base *ath11k);
-
+int ath11k_core_check_smbios(struct ath11k_base *ab);
 void ath11k_core_halt(struct ath11k *ar);
 int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 04e966830c18..14d7dfa788cd 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2082,6 +2082,10 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 		    ab->qmi.target.fw_build_timestamp,
 		    ab->qmi.target.fw_build_id);
 
+	r = ath11k_core_check_smbios(ab);
+	if (r)
+		ath11k_dbg(ab, ATH11K_DBG_QMI, "SMBIOS bdf variant name not set.\n");
+
 	r = ath11k_core_check_dt(ab);
 	if (r)
 		ath11k_dbg(ab, ATH11K_DBG_QMI, "DT bdf variant name not set.\n");
-- 
2.31.1

