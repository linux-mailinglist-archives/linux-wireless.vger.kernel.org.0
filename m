Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E50C7C927A
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 05:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjJND1X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 23:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJND1V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 23:27:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68368C0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 20:27:19 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39E3RGlr002150;
        Sat, 14 Oct 2023 03:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6fKpL2G2olmKs/C9CRxIxQ1pVCXZPwGDxKQomyD+XEI=;
 b=l/vWREXdgPSMbmHBirxFjDkJXCrMBkbQlrREYEAogu1o3Y8ju7PyMf5u4u3CsOwv//ZE
 Ub46kat48jyPA/jUznrooym8AAiDCmNjpDmUkCw1HxFaV6lWSXDeH26BQavwCo63AifS
 DqnOGVjVoL8nm21sGl73sPSWmT/52/h6wmCgEjUgjwEKvlXeS0ztO2AO9f1ZhNdDNFwS
 3IyPJmmSbfDkg0SPuYdKTzkogaCy77viPcTUxBkwmSRS9KNo5WrLSJX9eqgSir0IngHR
 VFoyNRlMpOkrFB4YRZJPcMQzRYXlW+eReDXPOe36h2NnN8Jk107cwWuGqYa0kDqLfSRN 9g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt1k374y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Oct 2023 03:27:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39E3RFeU012704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Oct 2023 03:27:15 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 13 Oct 2023 20:27:13 -0700
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 2/2] wifi: ath11k: rename the sc naming convention to ab
Date:   Sat, 14 Oct 2023 08:56:50 +0530
Message-ID: <20231014032650.32605-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231014032650.32605-1-quic_periyasa@quicinc.com>
References: <20231014032650.32605-1-quic_periyasa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xufwJ-XWBKmnDQWsCxxlCJ9NiFz3ZbnZ
X-Proofpoint-GUID: xufwJ-XWBKmnDQWsCxxlCJ9NiFz3ZbnZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=577 phishscore=0
 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310140029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In PCI, thermal and HAL interface layer module, the identifier
sc is used to represent an instance of ath11k_base structure.
However, within ath11k, the convention is to use "ab" to
represent an SoC "base" struct. So change the all instances
of sc to ab.

Compile tested only.

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hif.h     | 54 +++++++++++------------
 drivers/net/wireless/ath/ath11k/pcic.c    |  6 +--
 drivers/net/wireless/ath/ath11k/thermal.c | 22 ++++-----
 drivers/net/wireless/ath/ath11k/thermal.h |  8 ++--
 4 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index 659b80d2abd4..d68ed4214dec 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -9,18 +9,18 @@
 #include "core.h"
 
 struct ath11k_hif_ops {
-	u32 (*read32)(struct ath11k_base *sc, u32 address);
-	void (*write32)(struct ath11k_base *sc, u32 address, u32 data);
+	u32 (*read32)(struct ath11k_base *ab, u32 address);
+	void (*write32)(struct ath11k_base *ab, u32 address, u32 data);
 	int (*read)(struct ath11k_base *ab, void *buf, u32 start, u32 end);
-	void (*irq_enable)(struct ath11k_base *sc);
-	void (*irq_disable)(struct ath11k_base *sc);
-	int (*start)(struct ath11k_base *sc);
-	void (*stop)(struct ath11k_base *sc);
-	int (*power_up)(struct ath11k_base *sc);
-	void (*power_down)(struct ath11k_base *sc);
+	void (*irq_enable)(struct ath11k_base *ab);
+	void (*irq_disable)(struct ath11k_base *ab);
+	int (*start)(struct ath11k_base *ab);
+	void (*stop)(struct ath11k_base *ab);
+	int (*power_up)(struct ath11k_base *ab);
+	void (*power_down)(struct ath11k_base *ab);
 	int (*suspend)(struct ath11k_base *ab);
 	int (*resume)(struct ath11k_base *ab);
-	int (*map_service_to_pipe)(struct ath11k_base *sc, u16 service_id,
+	int (*map_service_to_pipe)(struct ath11k_base *ab, u16 service_id,
 				   u8 *ul_pipe, u8 *dl_pipe);
 	int (*get_user_msi_vector)(struct ath11k_base *ab, char *user_name,
 				   int *num_vectors, u32 *user_base_data,
@@ -44,34 +44,34 @@ static inline void ath11k_hif_ce_irq_disable(struct ath11k_base *ab)
 		ab->hif.ops->ce_irq_disable(ab);
 }
 
-static inline int ath11k_hif_start(struct ath11k_base *sc)
+static inline int ath11k_hif_start(struct ath11k_base *ab)
 {
-	return sc->hif.ops->start(sc);
+	return ab->hif.ops->start(ab);
 }
 
-static inline void ath11k_hif_stop(struct ath11k_base *sc)
+static inline void ath11k_hif_stop(struct ath11k_base *ab)
 {
-	sc->hif.ops->stop(sc);
+	ab->hif.ops->stop(ab);
 }
 
-static inline void ath11k_hif_irq_enable(struct ath11k_base *sc)
+static inline void ath11k_hif_irq_enable(struct ath11k_base *ab)
 {
-	sc->hif.ops->irq_enable(sc);
+	ab->hif.ops->irq_enable(ab);
 }
 
-static inline void ath11k_hif_irq_disable(struct ath11k_base *sc)
+static inline void ath11k_hif_irq_disable(struct ath11k_base *ab)
 {
-	sc->hif.ops->irq_disable(sc);
+	ab->hif.ops->irq_disable(ab);
 }
 
-static inline int ath11k_hif_power_up(struct ath11k_base *sc)
+static inline int ath11k_hif_power_up(struct ath11k_base *ab)
 {
-	return sc->hif.ops->power_up(sc);
+	return ab->hif.ops->power_up(ab);
 }
 
-static inline void ath11k_hif_power_down(struct ath11k_base *sc)
+static inline void ath11k_hif_power_down(struct ath11k_base *ab)
 {
-	sc->hif.ops->power_down(sc);
+	ab->hif.ops->power_down(ab);
 }
 
 static inline int ath11k_hif_suspend(struct ath11k_base *ab)
@@ -90,14 +90,14 @@ static inline int ath11k_hif_resume(struct ath11k_base *ab)
 	return 0;
 }
 
-static inline u32 ath11k_hif_read32(struct ath11k_base *sc, u32 address)
+static inline u32 ath11k_hif_read32(struct ath11k_base *ab, u32 address)
 {
-	return sc->hif.ops->read32(sc, address);
+	return ab->hif.ops->read32(ab, address);
 }
 
-static inline void ath11k_hif_write32(struct ath11k_base *sc, u32 address, u32 data)
+static inline void ath11k_hif_write32(struct ath11k_base *ab, u32 address, u32 data)
 {
-	sc->hif.ops->write32(sc, address, data);
+	ab->hif.ops->write32(ab, address, data);
 }
 
 static inline int ath11k_hif_read(struct ath11k_base *ab, void *buf,
@@ -109,10 +109,10 @@ static inline int ath11k_hif_read(struct ath11k_base *ab, void *buf,
 	return ab->hif.ops->read(ab, buf, start, end);
 }
 
-static inline int ath11k_hif_map_service_to_pipe(struct ath11k_base *sc, u16 service_id,
+static inline int ath11k_hif_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 						 u8 *ul_pipe, u8 *dl_pipe)
 {
-	return sc->hif.ops->map_service_to_pipe(sc, service_id, ul_pipe, dl_pipe);
+	return ab->hif.ops->map_service_to_pipe(ab, service_id, ul_pipe, dl_pipe);
 }
 
 static inline int ath11k_get_user_msi_vector(struct ath11k_base *ab, char *user_name,
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index c63083633b37..16d1e332193f 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -422,14 +422,14 @@ static void ath11k_pcic_ext_grp_disable(struct ath11k_ext_irq_grp *irq_grp)
 		disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
 }
 
-static void __ath11k_pcic_ext_irq_disable(struct ath11k_base *sc)
+static void __ath11k_pcic_ext_irq_disable(struct ath11k_base *ab)
 {
 	int i;
 
-	clear_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &sc->dev_flags);
+	clear_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
 
 	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
-		struct ath11k_ext_irq_grp *irq_grp = &sc->ext_irq_grp[i];
+		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
 		ath11k_pcic_ext_grp_disable(irq_grp);
 
diff --git a/drivers/net/wireless/ath/ath11k/thermal.c b/drivers/net/wireless/ath/ath11k/thermal.c
index 23ed01bd44f9..c9b012f97ba5 100644
--- a/drivers/net/wireless/ath/ath11k/thermal.c
+++ b/drivers/net/wireless/ath/ath11k/thermal.c
@@ -125,7 +125,7 @@ ATTRIBUTE_GROUPS(ath11k_hwmon);
 
 int ath11k_thermal_set_throttling(struct ath11k *ar, u32 throttle_state)
 {
-	struct ath11k_base *sc = ar->ab;
+	struct ath11k_base *ab = ar->ab;
 	struct thermal_mitigation_params param;
 	int ret = 0;
 
@@ -147,14 +147,14 @@ int ath11k_thermal_set_throttling(struct ath11k *ar, u32 throttle_state)
 
 	ret = ath11k_wmi_send_thermal_mitigation_param_cmd(ar, &param);
 	if (ret) {
-		ath11k_warn(sc, "failed to send thermal mitigation duty cycle %u ret %d\n",
+		ath11k_warn(ab, "failed to send thermal mitigation duty cycle %u ret %d\n",
 			    throttle_state, ret);
 	}
 
 	return ret;
 }
 
-int ath11k_thermal_register(struct ath11k_base *sc)
+int ath11k_thermal_register(struct ath11k_base *ab)
 {
 	struct thermal_cooling_device *cdev;
 	struct device *hwmon_dev;
@@ -162,8 +162,8 @@ int ath11k_thermal_register(struct ath11k_base *sc)
 	struct ath11k_pdev *pdev;
 	int i, ret;
 
-	for (i = 0; i < sc->num_radios; i++) {
-		pdev = &sc->pdevs[i];
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
 		if (!ar)
 			continue;
@@ -172,7 +172,7 @@ int ath11k_thermal_register(struct ath11k_base *sc)
 						       &ath11k_thermal_ops);
 
 		if (IS_ERR(cdev)) {
-			ath11k_err(sc, "failed to setup thermal device result: %ld\n",
+			ath11k_err(ab, "failed to setup thermal device result: %ld\n",
 				   PTR_ERR(cdev));
 			ret = -EINVAL;
 			goto err_thermal_destroy;
@@ -183,7 +183,7 @@ int ath11k_thermal_register(struct ath11k_base *sc)
 		ret = sysfs_create_link(&ar->hw->wiphy->dev.kobj, &cdev->device.kobj,
 					"cooling_device");
 		if (ret) {
-			ath11k_err(sc, "failed to create cooling device symlink\n");
+			ath11k_err(ab, "failed to create cooling device symlink\n");
 			goto err_thermal_destroy;
 		}
 
@@ -204,18 +204,18 @@ int ath11k_thermal_register(struct ath11k_base *sc)
 	return 0;
 
 err_thermal_destroy:
-	ath11k_thermal_unregister(sc);
+	ath11k_thermal_unregister(ab);
 	return ret;
 }
 
-void ath11k_thermal_unregister(struct ath11k_base *sc)
+void ath11k_thermal_unregister(struct ath11k_base *ab)
 {
 	struct ath11k *ar;
 	struct ath11k_pdev *pdev;
 	int i;
 
-	for (i = 0; i < sc->num_radios; i++) {
-		pdev = &sc->pdevs[i];
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
 		if (!ar)
 			continue;
diff --git a/drivers/net/wireless/ath/ath11k/thermal.h b/drivers/net/wireless/ath/ath11k/thermal.h
index 3e39675ef7f5..83cb67686733 100644
--- a/drivers/net/wireless/ath/ath11k/thermal.h
+++ b/drivers/net/wireless/ath/ath11k/thermal.h
@@ -26,17 +26,17 @@ struct ath11k_thermal {
 };
 
 #if IS_REACHABLE(CONFIG_THERMAL)
-int ath11k_thermal_register(struct ath11k_base *sc);
-void ath11k_thermal_unregister(struct ath11k_base *sc);
+int ath11k_thermal_register(struct ath11k_base *ab);
+void ath11k_thermal_unregister(struct ath11k_base *ab);
 int ath11k_thermal_set_throttling(struct ath11k *ar, u32 throttle_state);
 void ath11k_thermal_event_temperature(struct ath11k *ar, int temperature);
 #else
-static inline int ath11k_thermal_register(struct ath11k_base *sc)
+static inline int ath11k_thermal_register(struct ath11k_base *ab)
 {
 	return 0;
 }
 
-static inline void ath11k_thermal_unregister(struct ath11k_base *sc)
+static inline void ath11k_thermal_unregister(struct ath11k_base *ab)
 {
 }
 
-- 
2.17.1

