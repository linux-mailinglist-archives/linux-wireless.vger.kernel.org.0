Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B5A792520
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 18:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjIEQBd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 12:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354350AbjIEK5B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 06:57:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA2F199
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 03:56:57 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385AIXCJ018441;
        Tue, 5 Sep 2023 10:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=+PiwhJHPxLVQYK8aBv67jk8ZBMQmgjfOHtHEhSfTDIc=;
 b=B/QUijK3Xi2eT4sz7pJkiK7aDzO6xxsI8qNsy+DIiy+QFvS19hxd7n7W41b/N6iFFsVH
 6l6mzYcfuUJfN9IhIhjtPRfqJyMOJze9auS7V/xMu6+BBUSBEm9jL/dsivTXypg+vSG1
 wozRPsp+WXDIF1A5QWkw5eD6dQGHhLYsEYAeJ+SW8Pp1gJvVvMDGK0af/61RyaO3qxL8
 ShdiqiC0w5hdKInSbKAkvYvkqtd53D6M8QGuaNJbpj5Yjl30O/iESB8dpRtosaO3TNs4
 HX5/VATgx+fAZQXCTnYuBj6lnnYshZPUfw8g6sbLke2PzAHqSWJhtJ3VQVyU3IC3hYx6 ZA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swmxwsbjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 10:56:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 385AuqmU011351
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 10:56:52 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 5 Sep 2023 03:56:50 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath12k: add read variant from SMBIOS for download board data
Date:   Tue, 5 Sep 2023 06:56:37 -0400
Message-ID: <20230905105637.10230-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z9Qzvjm29gPUTrkbtLMyHUUmdvdl1ykB
X-Proofpoint-ORIG-GUID: z9Qzvjm29gPUTrkbtLMyHUUmdvdl1ykB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_08,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is to read variant from SMBIOS such as read from DT, the variant
string will be used to one part of string which used to search board
data from board-2.bin.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 69 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/core.h | 20 +++++++-
 drivers/net/wireless/ath/ath12k/qmi.c  |  5 ++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3df8059d5512..6350e2cf71ee 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -377,6 +377,75 @@ static void ath12k_core_stop(struct ath12k_base *ab)
 	/* De-Init of components as needed */
 }
 
+static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
+{
+	struct ath12k_base *ab = data;
+	const char *magic = ATH12K_SMBIOS_BDF_EXT_MAGIC;
+	struct ath12k_smbios_bdf *smbios = (struct ath12k_smbios_bdf *)hdr;
+	ssize_t copied;
+	size_t len;
+	int i;
+
+	if (ab->qmi.target.bdf_ext[0] != '\0')
+		return;
+
+	if (hdr->type != ATH12K_SMBIOS_BDF_EXT_TYPE)
+		return;
+
+	if (hdr->length != ATH12K_SMBIOS_BDF_EXT_LENGTH) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT,
+			   "wrong smbios bdf ext type length (%d).\n",
+			   hdr->length);
+		return;
+	}
+
+	if (!smbios->bdf_enabled) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "bdf variant name not found.\n");
+		return;
+	}
+
+	/* Only one string exists (per spec) */
+	if (memcmp(smbios->bdf_ext, magic, strlen(magic)) != 0) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT,
+			   "bdf variant magic does not match.\n");
+		return;
+	}
+
+	len = min_t(size_t,
+		    strlen(smbios->bdf_ext), sizeof(ab->qmi.target.bdf_ext));
+	for (i = 0; i < len; i++) {
+		if (!isascii(smbios->bdf_ext[i]) || !isprint(smbios->bdf_ext[i])) {
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "bdf variant name contains non ascii chars.\n");
+			return;
+		}
+	}
+
+	/* Copy extension name without magic prefix */
+	copied = strscpy(ab->qmi.target.bdf_ext, smbios->bdf_ext + strlen(magic),
+			 sizeof(ab->qmi.target.bdf_ext));
+	if (copied < 0) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT,
+			   "bdf variant string is longer than the buffer can accommodate\n");
+		return;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT,
+		   "found and validated bdf variant smbios_type 0x%x bdf %s\n",
+		   ATH12K_SMBIOS_BDF_EXT_TYPE, ab->qmi.target.bdf_ext);
+}
+
+int ath12k_core_check_smbios(struct ath12k_base *ab)
+{
+	ab->qmi.target.bdf_ext[0] = '\0';
+	dmi_walk(ath12k_core_check_bdfext, ab);
+
+	if (ab->qmi.target.bdf_ext[0] == '\0')
+		return -ENODATA;
+
+	return 0;
+}
+
 static int ath12k_core_soc_create(struct ath12k_base *ab)
 {
 	int ret;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4389ff40b49d..6c1468f64401 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -11,6 +11,8 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/bitfield.h>
+#include <linux/dmi.h>
+#include <linux/ctype.h>
 #include "qmi.h"
 #include "htc.h"
 #include "wmi.h"
@@ -32,6 +34,15 @@
 /* Pending management packets threshold for dropping probe responses */
 #define ATH12K_PRB_RSP_DROP_THRESHOLD ((ATH12K_TX_MGMT_TARGET_MAX_SUPPORT_WMI * 3) / 4)
 
+/* SMBIOS type containing Board Data File Name Extension */
+#define ATH12K_SMBIOS_BDF_EXT_TYPE 0xF8
+
+/* SMBIOS type structure length (excluding strings-set) */
+#define ATH12K_SMBIOS_BDF_EXT_LENGTH 0x9
+
+/* The magic used by QCA spec */
+#define ATH12K_SMBIOS_BDF_EXT_MAGIC "BDF_"
+
 #define ATH12K_INVALID_HW_MAC_ID	0xFF
 #define	ATH12K_RX_RATE_TABLE_NUM	320
 #define	ATH12K_RX_RATE_TABLE_11AX_NUM	576
@@ -129,6 +140,13 @@ struct ath12k_ext_irq_grp {
 	struct net_device napi_ndev;
 };
 
+struct ath12k_smbios_bdf {
+	struct dmi_header hdr;
+	u32 padding;
+	u8 bdf_enabled;
+	u8 bdf_ext[];
+} __packed;
+
 #define HEHANDLE_CAP_PHYINFO_SIZE       3
 #define HECAP_PHYINFO_SIZE              9
 #define HECAP_MACINFO_SIZE              5
@@ -789,7 +807,7 @@ int ath12k_core_fetch_bdf(struct ath12k_base *ath12k,
 			  struct ath12k_board_data *bd);
 void ath12k_core_free_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd);
 int ath12k_core_check_dt(struct ath12k_base *ath12k);
-
+int ath12k_core_check_smbios(struct ath12k_base *ab);
 void ath12k_core_halt(struct ath12k *ar);
 int ath12k_core_resume(struct ath12k_base *ab);
 int ath12k_core_suspend(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index b2db0436bdde..fd1bf53c2502 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2213,6 +2213,7 @@ static int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 	struct qmi_txn txn = {};
 	unsigned int board_id = ATH12K_BOARD_ID_DEFAULT;
 	int ret = 0;
+	int r;
 	int i;
 
 	memset(&req, 0, sizeof(req));
@@ -2297,6 +2298,10 @@ static int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 		    ab->qmi.target.fw_build_timestamp,
 		    ab->qmi.target.fw_build_id);
 
+	r = ath12k_core_check_smbios(ab);
+	if (r)
+		ath12k_dbg(ab, ATH12K_DBG_QMI, "SMBIOS bdf variant name not set.\n");
+
 out:
 	return ret;
 }

base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1

