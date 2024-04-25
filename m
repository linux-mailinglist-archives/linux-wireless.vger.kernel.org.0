Return-Path: <linux-wireless+bounces-6813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB59F8B1A82
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 07:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF1A1C21A63
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 05:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755F842070;
	Thu, 25 Apr 2024 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ECAT7scH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42940877
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024698; cv=none; b=rKBiPoHvoh1Y5ISyOQlHnL0EetLDGe7w4KzmnijVJZ7p4KVc9Vkmxzs2LCFah+0DFlXNu17GcRaX7cKJSyAcU/DlBlOaSFmZYPdFKN9Q6MKpiY6Czl6lgcZcMjdiIIkx/NAvCXWanmsqdYP7M0G9c687XCK1Ow5FED1nOD+Dez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024698; c=relaxed/simple;
	bh=yBfKD9SNyDaxGtES4BiSC9O18Jl+R+y7jiSQSpKDzHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E0H7YBrtAqbSmLPeOrw1FieujKQe9fuJXBEYgGYxETfzmmFn2uTvLYcwQaS++AlHjKDpIY4Hecp1Cy/ts3jNHYo5mbnSojE3CsvxJvJ2P7uThRAbm/RwnHYniuNeUq+wad7BScpchXC9ZvWipOqhfzxsI5ldyX1WabDCMlk60s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ECAT7scH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P3Up2B008769;
	Thu, 25 Apr 2024 05:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=UktyfCp
	haR4HUOWnPVxHXNPVJAUa0WvgTr3x11D6abE=; b=ECAT7scH/r7wdWZlNMGvRL3
	z/pJ8108JWv78y9Q9ndyYv3WhTU1ICmdu/jPAwU1r9j1JC0XSbUvwwpPxMhcsGf0
	hpqAdcWGSZenStc2yAIgFRF6/oACIS2bne2SKgS6kdXISpOBcUaMCSwzSnyGVp41
	ApQ2JjoELfCC00uq7ml46WiearHdmgpubDAQ9pH0bA7T4tu0TeCZbGZlGk5MWS3U
	VsEdoECd6ZphEqtpRE6oniXSOudZgyvl1zHvcCGaY0JbE2puRiVoPGC9WTVseVJ2
	vkzC6Otdde1ketdggAiLqGRlN0fZ80x88LPANnVIy6jwf6PHOyZYRHt5ieKPcPA=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenmrcv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 05:58:12 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43P5w7nr031708;
	Thu, 25 Apr 2024 05:58:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xm6smbfpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 05:58:09 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43P5w4b1031130;
	Thu, 25 Apr 2024 05:58:09 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 43P5w9OV031730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 05:58:09 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id 3B7A041154; Thu, 25 Apr 2024 11:28:08 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH v2 7/8] wifi: ath12k: refactor core start based on hardware group
Date: Thu, 25 Apr 2024 11:27:58 +0530
Message-Id: <20240425055759.1181165-8-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425055759.1181165-1-quic_hprem@quicinc.com>
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LBm8Xs_OJeuAeBBSvodfLxCHmaw52qiY
X-Proofpoint-ORIG-GUID: LBm8Xs_OJeuAeBBSvodfLxCHmaw52qiY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=923 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250041

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, mac allocate/register and core_pdev_create are initiated
immediately when QMI firmware ready event is received for a particular
device.

With hardware device group abstraction, QMI firmware ready event can be
received simultaneously for different devices in the group and so, it
should not be registered immediately rather it has to be deferred until
all devices in the group has received QMI firmware ready.

To handle this, refactor the code of core start to move the following
apis inside a wrapper ath12k_core_hw_group_start()
        * ath12k_mac_allocate()
        * ath12k_core_pdev_create()
        * ath12k_core_rfkill_config()
        * ath12k_mac_register()
        * ath12k_hif_irq_enable()

similarly, move the corresponding destroy/unregister/disable apis
inside wrapper ath12k_core_hw_group_stop()

Add the device flags to indicate pdev created and IRQ enabled which would
be helpful for device clean up during failure cases.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Co-developed-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 217 +++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/core.h |  32 ++++
 2 files changed, 198 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index bae0d36ddb24..903d51a303d4 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -566,6 +566,9 @@ u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab)
 
 static void ath12k_core_stop(struct ath12k_base *ab)
 {
+	clear_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags);
+	ath12k_dec_num_core_started(ab);
+
 	ath12k_acpi_stop(ab);
 
 	ath12k_dp_rx_pdev_reo_cleanup(ab);
@@ -692,11 +695,15 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
 		return ret;
 	}
 
+	set_bit(ATH12K_FLAG_PDEV_CREATED, &ab->dev_flags);
+
 	return 0;
 }
 
 static void ath12k_core_pdev_destroy(struct ath12k_base *ab)
 {
+	clear_bit(ATH12K_FLAG_PDEV_CREATED, &ab->dev_flags);
+
 	ath12k_dp_pdev_free(ab);
 }
 
@@ -705,6 +712,8 @@ static int ath12k_core_start(struct ath12k_base *ab,
 {
 	int ret;
 
+	lockdep_assert_held(&ab->core_lock);
+
 	ret = ath12k_wmi_attach(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to attach wmi: %d\n", ret);
@@ -798,6 +807,11 @@ static int ath12k_core_start(struct ath12k_base *ab,
 		/* ACPI is optional so continue in case of an error */
 		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", ret);
 
+	/* Indicate the core start in the appropriate group */
+	ath12k_inc_num_core_started(ab);
+
+	set_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags);
+
 	return 0;
 
 err_reo_cleanup:
@@ -809,6 +823,109 @@ static int ath12k_core_start(struct ath12k_base *ab,
 	return ret;
 }
 
+static void ath12k_core_device_cleanup(struct ath12k_base *ab)
+{
+	mutex_lock(&ab->core_lock);
+
+	if (test_and_clear_bit(ATH12K_FLAG_CORE_HIF_IRQ_ENABLED, &ab->dev_flags))
+		ath12k_hif_irq_disable(ab);
+
+	if (test_bit(ATH12K_FLAG_PDEV_CREATED, &ab->dev_flags))
+		ath12k_core_pdev_destroy(ab);
+
+	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)) {
+		ath12k_mac_unregister(ab);
+		ath12k_mac_destroy(ab);
+	}
+
+	mutex_unlock(&ab->core_lock);
+}
+
+static void ath12k_core_hw_group_stop(struct ath12k_hw_group *ag)
+{
+	struct ath12k_base *ab;
+	int i;
+
+	lockdep_assert_held(&ag->mutex_lock);
+
+	for (i = ag->num_devices - 1; i >= 0; i--) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+		ath12k_core_device_cleanup(ab);
+	}
+}
+
+static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
+{
+	struct ath12k_base *ab;
+	int ret, i;
+	bool is_registered;
+
+	lockdep_assert_held(&ag->mutex_lock);
+
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		mutex_lock(&ab->core_lock);
+
+		/* Check if already registered or not, since same flow
+		 * execute for HW restart case.
+		 */
+		is_registered = test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
+
+		if (is_registered)
+			goto core_pdev_create;
+
+		ret = ath12k_mac_allocate(ab);
+		if (ret) {
+			ath12k_err(ab, "failed to create new hw device with mac80211 :%d\n",
+				   ret);
+			mutex_unlock(&ab->core_lock);
+			return ret;
+		}
+
+		ret = ath12k_mac_register(ab);
+		if (ret) {
+			ath12k_err(ab, "failed to register radio with mac80211: %d\n",
+				   ret);
+			mutex_unlock(&ab->core_lock);
+			goto err;
+		}
+
+core_pdev_create:
+		ret = ath12k_core_pdev_create(ab);
+		if (ret) {
+			ath12k_err(ab, "failed to create pdev core %d\n", ret);
+			mutex_unlock(&ab->core_lock);
+			goto err;
+		}
+
+		ret = ath12k_core_rfkill_config(ab);
+		if (ret && ret != -EOPNOTSUPP) {
+			mutex_unlock(&ab->core_lock);
+			goto err;
+		}
+
+		ath12k_hif_irq_enable(ab);
+
+		set_bit(ATH12K_FLAG_CORE_HIF_IRQ_ENABLED, &ab->dev_flags);
+
+		mutex_unlock(&ab->core_lock);
+	}
+
+	set_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags);
+
+	return 0;
+
+err:
+	ath12k_core_hw_group_stop(ag);
+
+	return ret;
+}
+
 static int ath12k_core_start_firmware(struct ath12k_base *ab,
 				      enum ath12k_firmware_mode mode)
 {
@@ -826,9 +943,18 @@ static int ath12k_core_start_firmware(struct ath12k_base *ab,
 	return ret;
 }
 
+static inline
+bool ath12k_core_hw_group_start_ready(struct ath12k_hw_group *ag)
+{
+	lockdep_assert_held(&ag->mutex_lock);
+
+	return (ag->num_started == ag->num_devices);
+}
+
 int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 {
-	int ret;
+	struct ath12k_hw_group *ag;
+	int ret, i;
 
 	ret = ath12k_core_start_firmware(ab, ATH12K_FIRMWARE_MODE_NORMAL);
 	if (ret) {
@@ -848,59 +974,50 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 		goto err_firmware_stop;
 	}
 
+	ag = ath12k_ab_to_ag(ab);
+
+	mutex_lock(&ag->mutex_lock);
 	mutex_lock(&ab->core_lock);
 	ret = ath12k_core_start(ab, ATH12K_FIRMWARE_MODE_NORMAL);
 	if (ret) {
 		ath12k_err(ab, "failed to start core: %d\n", ret);
 		goto err_dp_free;
 	}
+	mutex_unlock(&ab->core_lock);
 
-	ret = ath12k_mac_allocate(ab);
-	if (ret) {
-		ath12k_err(ab, "failed to create new hw device with mac80211 :%d\n",
-			   ret);
-		goto err_core_stop;
-	}
-
-	ret = ath12k_mac_register(ab);
-	if (ret) {
-		ath12k_err(ab, "failed register the radio with mac80211: %d\n", ret);
-		goto err_mac_destroy;
+	if (ath12k_core_hw_group_start_ready(ag)) {
+		ret = ath12k_core_hw_group_start(ag);
+		if (ret) {
+			ath12k_warn(ab, "unable to start hw group\n");
+			goto err_core_stop;
+		}
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "group %d started\n", ag->id);
 	}
+	mutex_unlock(&ag->mutex_lock);
 
-	ret = ath12k_core_pdev_create(ab);
-	if (ret) {
-		ath12k_err(ab, "failed to create pdev core: %d\n", ret);
-		goto err_mac_unregister;
-	}
+	return 0;
 
-	ath12k_hif_irq_enable(ab);
+err_core_stop:
+	for (i = ag->num_devices - 1; i >= 0; i--) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
 
-	ret = ath12k_core_rfkill_config(ab);
-	if (ret && ret != -EOPNOTSUPP) {
-		ath12k_err(ab, "failed to config rfkill: %d\n", ret);
-		goto err_core_pdev_destroy;
+		mutex_lock(&ab->core_lock);
+		if (test_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags))
+			ath12k_core_stop(ab);
+		mutex_unlock(&ab->core_lock);
 	}
+	goto exit;
 
-	mutex_unlock(&ab->core_lock);
-
-	return 0;
-
-err_core_pdev_destroy:
-	ath12k_hif_irq_disable(ab);
-	ath12k_core_pdev_destroy(ab);
-err_mac_unregister:
-	ath12k_mac_unregister(ab);
-err_mac_destroy:
-	ath12k_mac_destroy(ab);
-err_core_stop:
-	ath12k_core_stop(ab);
 err_dp_free:
 	ath12k_dp_free(ab);
 	mutex_unlock(&ab->core_lock);
 err_firmware_stop:
 	ath12k_qmi_firmware_stop(ab);
 
+exit:
+	mutex_unlock(&ag->mutex_lock);
 	return ret;
 }
 
@@ -1152,6 +1269,10 @@ static void ath12k_core_reset(struct work_struct *work)
 
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset starting\n");
 
+	mutex_lock(&ab->ag->mutex_lock);
+	ath12k_dec_num_core_started(ab);
+	mutex_unlock(&ab->ag->mutex_lock);
+
 	ab->is_reset = true;
 	atomic_set(&ab->recovery_start_count, 0);
 	reinit_completion(&ab->recovery_start);
@@ -1261,7 +1382,7 @@ static struct ath12k_hw_group *ath12k_core_assign_hw_group(struct ath12k_base *a
 
 void ath12k_core_unassign_hw_group(struct ath12k_base *ab)
 {
-	struct ath12k_hw_group *ag = ab->ag;
+	struct ath12k_hw_group *ag = ath12k_ab_to_ag(ab);
 	u8 device_id = ab->device_id;
 	int num_probed;
 
@@ -1295,19 +1416,6 @@ void ath12k_core_unassign_hw_group(struct ath12k_base *ab)
 		ath12k_core_hw_group_free(ag);
 }
 
-static void ath12k_core_device_cleanup(struct ath12k_base *ab)
-{
-	mutex_lock(&ab->core_lock);
-
-	ath12k_hif_irq_disable(ab);
-	ath12k_core_pdev_destroy(ab);
-	ath12k_mac_unregister(ab);
-	ath12k_mac_destroy(ab);
-	ath12k_core_stop(ab);
-
-	mutex_unlock(&ab->core_lock);
-}
-
 static void ath12k_core_hw_group_destroy(struct ath12k_hw_group *ag)
 {
 	struct ath12k_base *ab;
@@ -1318,13 +1426,20 @@ static void ath12k_core_hw_group_destroy(struct ath12k_hw_group *ag)
 
 	mutex_lock(&ag->mutex_lock);
 
+	if (test_and_clear_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags))
+		ath12k_core_hw_group_stop(ag);
+
 	for (i = 0; i < ag->num_devices; i++) {
 		ab = ag->ab[i];
 		if (!ab)
 			continue;
 
-		if (test_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE, &ab->dev_flags))
-			ath12k_core_device_cleanup(ab);
+		mutex_lock(&ab->core_lock);
+
+		if (test_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags))
+			ath12k_core_stop(ab);
+
+		mutex_unlock(&ab->core_lock);
 
 		if (test_and_clear_bit(ATH12K_FLAG_HW_GROUP_ATTACHED, &ab->dev_flags))
 			ath12k_core_soc_destroy(ab);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 0bb05bf32eb4..a5bf4346ba88 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -202,6 +202,10 @@ enum ath12k_scan_state {
 	ATH12K_SCAN_ABORTING,
 };
 
+enum ath12k_hw_group_flags {
+	ATH12K_GROUP_FLAG_REGISTERED,
+};
+
 enum ath12k_dev_flags {
 	ATH12K_CAC_RUNNING,
 	ATH12K_FLAG_CRASH_FLUSH,
@@ -216,6 +220,9 @@ enum ath12k_dev_flags {
 	ATH12K_FLAG_EXT_IRQ_ENABLED,
 	ATH12K_FLAG_QMI_FW_READY_COMPLETE,
 	ATH12K_FLAG_HW_GROUP_ATTACHED,
+	ATH12K_FLAG_PDEV_CREATED,
+	ATH12K_FLAG_CORE_STARTED,
+	ATH12K_FLAG_CORE_HIF_IRQ_ENABLED,
 };
 
 enum ath12k_monitor_flags {
@@ -743,6 +750,8 @@ struct ath12k_hw_group {
 	u8 id;
 	u8 num_devices;
 	u8 num_probed;
+	u8 num_started;
+	unsigned long flags;
 	struct ath12k_base *ab[ATH12K_MAX_SOCS];
 	/* To synchronize group create, assign, start, stop */
 	struct mutex mutex_lock;
@@ -1094,4 +1103,27 @@ static inline int ath12k_get_num_hw(struct ath12k_base *ab)
 {
 	return ab->num_hw;
 }
+
+static inline
+struct ath12k_hw_group *ath12k_ab_to_ag(struct ath12k_base *ab)
+{
+	return ab->ag;
+}
+
+static inline
+void ath12k_inc_num_core_started(struct ath12k_base *ab)
+{
+	lockdep_assert_held(&ab->ag->mutex_lock);
+
+	ab->ag->num_started++;
+}
+
+static inline
+void ath12k_dec_num_core_started(struct ath12k_base *ab)
+{
+	lockdep_assert_held(&ab->ag->mutex_lock);
+
+	ab->ag->num_started--;
+}
+
 #endif /* _CORE_H_ */
-- 
2.34.1


