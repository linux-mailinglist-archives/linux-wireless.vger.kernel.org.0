Return-Path: <linux-wireless+bounces-7952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6565A8CBE9F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 11:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF608B217C7
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBC081ABF;
	Wed, 22 May 2024 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ou55Pxxo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE62823A3
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371727; cv=none; b=u1j+Px3jOV+wGdQwray0yLsLLNFPkKJiNw6VN+iiEfVJjG381ruarVep6r+p3BNbl54EY6bKfiEFPB2MXBvBZnA7FMF+e/yPqpFHFypGU8MsxvhOiexMmwLz6kNmWNynApZSFFRQ8xejBqrdHti6GjRATiUnHf8dOM2EA+rXv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371727; c=relaxed/simple;
	bh=iTTc66FWLMqVwJW+q8zVu23doqvPQTimTRjP+4kH/aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nsLUgz/mKEZij4c2+RarZ20nx8Dt5/XiBfInh2gUflSSoI9hb1n4tGDinWDZGjRWyDyEM8Gx79SB4reHYunPAoeGqWUlcTCsWRo+praasjUs6ngthDOkumUvA1ReRG/XZ5FTEz4A+o+BJGPvEs9ThaFra03PRtX3qlEADKisSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ou55Pxxo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M3EfkC014675;
	Wed, 22 May 2024 09:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=LiMh8jq
	tnyd+d3WnOanZklSMOcOdMMCgbrR+cLLXulw=; b=ou55PxxoObS9QAJqXohIuSB
	rA8NGHbvME2VXwZgxPymZilOoNiSG4ahbRvI2UWW0cuSJV96fKpWonw7NSfTvFwt
	0m5eamjnIPwZl6OBtv489+THEm5ATaJdSEZAYef8lxzjSnFNmqqPNunjFk92O2HL
	/ePWGlzQuVdr0bfH/7o7ARq5EYtkHIi+D1WKUQiYOvQN4YvQC1xedRVF7TG6UcFe
	KlTyMdPvxi/IQClqD50sxBxMRTS4qxw2s9f+wJJWMpsGnZvZduKQNFEJc8UNhPWq
	givXd99SM3CYcSBBbGhVntX1zqItUUZKXhubNToH0Dd60otfYVgKslGyke8UpEA=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqc8cqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 09:55:22 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44M9tIVv025012;
	Wed, 22 May 2024 09:55:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3y6ndkfpvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 09:55:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44M9stct024345;
	Wed, 22 May 2024 09:55:18 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 44M9tIB9025007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 09:55:18 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id 655B241148; Wed, 22 May 2024 15:25:17 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v5 7/8] wifi: ath12k: refactor core start based on hardware group
Date: Wed, 22 May 2024 15:24:38 +0530
Message-Id: <20240522095439.2596989-8-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522095439.2596989-1-quic_hprem@quicinc.com>
References: <20240522095439.2596989-1-quic_hprem@quicinc.com>
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
X-Proofpoint-ORIG-GUID: _ZkuUDZU88lQAow9N8Qst8G5zioyLQlD
X-Proofpoint-GUID: _ZkuUDZU88lQAow9N8Qst8G5zioyLQlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_05,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220070

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
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 216 +++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/core.h |  32 ++++
 2 files changed, 197 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index ebe31cbb6435..6897d222d972 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -563,6 +563,9 @@ u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab)
 
 static void ath12k_core_stop(struct ath12k_base *ab)
 {
+	clear_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags);
+	ath12k_dec_num_core_started(ab);
+
 	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
 		ath12k_qmi_firmware_stop(ab);
 
@@ -689,11 +692,15 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
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
 
@@ -702,6 +709,8 @@ static int ath12k_core_start(struct ath12k_base *ab,
 {
 	int ret;
 
+	lockdep_assert_held(&ab->core_lock);
+
 	ret = ath12k_wmi_attach(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to attach wmi: %d\n", ret);
@@ -795,6 +804,11 @@ static int ath12k_core_start(struct ath12k_base *ab,
 		/* ACPI is optional so continue in case of an error */
 		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", ret);
 
+	/* Indicate the core start in the appropriate group */
+	ath12k_inc_num_core_started(ab);
+
+	set_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags);
+
 	return 0;
 
 err_reo_cleanup:
@@ -806,6 +820,109 @@ static int ath12k_core_start(struct ath12k_base *ab,
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
@@ -823,9 +940,18 @@ static int ath12k_core_start_firmware(struct ath12k_base *ab,
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
@@ -845,59 +971,50 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
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
 
@@ -1149,6 +1266,10 @@ static void ath12k_core_reset(struct work_struct *work)
 
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset starting\n");
 
+	mutex_lock(&ab->ag->mutex_lock);
+	ath12k_dec_num_core_started(ab);
+	mutex_unlock(&ab->ag->mutex_lock);
+
 	ab->is_reset = true;
 	atomic_set(&ab->recovery_start_count, 0);
 	reinit_completion(&ab->recovery_start);
@@ -1258,7 +1379,7 @@ static struct ath12k_hw_group *ath12k_core_assign_hw_group(struct ath12k_base *a
 
 void ath12k_core_unassign_hw_group(struct ath12k_base *ab)
 {
-	struct ath12k_hw_group *ag = ab->ag;
+	struct ath12k_hw_group *ag = ath12k_ab_to_ag(ab);
 	u8 device_id = ab->device_id;
 	int num_probed;
 
@@ -1292,19 +1413,6 @@ void ath12k_core_unassign_hw_group(struct ath12k_base *ab)
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
@@ -1332,14 +1440,20 @@ static void ath12k_core_hw_group_cleanup(struct ath12k_hw_group *ag)
 		return;
 
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
+		if (test_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags))
+			ath12k_core_stop(ab);
+		mutex_unlock(&ab->core_lock);
 	}
+
 	mutex_unlock(&ag->mutex_lock);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index a6b8c100ebc8..d955deb08fd4 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -200,6 +200,10 @@ enum ath12k_scan_state {
 	ATH12K_SCAN_ABORTING,
 };
 
+enum ath12k_hw_group_flags {
+	ATH12K_GROUP_FLAG_REGISTERED,
+};
+
 enum ath12k_dev_flags {
 	ATH12K_CAC_RUNNING,
 	ATH12K_FLAG_CRASH_FLUSH,
@@ -214,6 +218,9 @@ enum ath12k_dev_flags {
 	ATH12K_FLAG_EXT_IRQ_ENABLED,
 	ATH12K_FLAG_QMI_FW_READY_COMPLETE,
 	ATH12K_FLAG_HW_GROUP_ATTACHED,
+	ATH12K_FLAG_PDEV_CREATED,
+	ATH12K_FLAG_CORE_STARTED,
+	ATH12K_FLAG_CORE_HIF_IRQ_ENABLED,
 };
 
 struct ath12k_tx_conf {
@@ -736,6 +743,8 @@ struct ath12k_hw_group {
 	u8 id;
 	u8 num_devices;
 	u8 num_probed;
+	u8 num_started;
+	unsigned long flags;
 	struct ath12k_base *ab[ATH12K_MAX_SOCS];
 	/* To synchronize group create, assign, start, stop */
 	struct mutex mutex_lock;
@@ -1087,4 +1096,27 @@ static inline int ath12k_get_num_hw(struct ath12k_base *ab)
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


