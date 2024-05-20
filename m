Return-Path: <linux-wireless+bounces-7844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04258C9DF3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 15:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E6DB24957
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 13:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6016B135A6C;
	Mon, 20 May 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lQaJak3b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91261446D1
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716210865; cv=none; b=MMVINb/aByIQvFGOQnU4RHfHqS0leS3roBXlZZKfprAlYcDrhuK+DcdUhMpfeAwxp95y2DHDGwxPMgdl+5ROb6HTZPqXCk3y6e7juXtQLDAXj0P1IqDGZgfQklhIacMmL9vbo8qS2l6igjbDWzz/PMadtdm2rYrYBjF4OMSYdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716210865; c=relaxed/simple;
	bh=Gb1j/YqQqhInZ0wbEPYwZsPVOu7W5PWWvGBWbHuzaYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oZuf0B0e5jyQn/RF2fDFDNDibfMVUPVuKG2Eq5UjB4mi+9AkLrtsEJu0rSn5Butp5clPV4wFMr8Zf5OJfkHm32YEbub4smmud+859arTpun/ZauMIjJEX8/lNUFephzL7sSxqH7XRBPEyUW/1GhrbRtEYVzjpH/BSimRWZld/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lQaJak3b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KBAV9B030497;
	Mon, 20 May 2024 13:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=sFTvdSEF62ILwFKghcAW
	8A/Dtt3FTVNkaQBNYPG8hmk=; b=lQaJak3bzlhLmFICvZbpdH5itYJq0PH2e1Oe
	0NizlPbZ6QQSYRfKQdp+c/b/alQq+7mhZBKFS4Iaoex+TA28QUyRtwtjryTzc0KB
	li0uJUK0RZFpHiaD0yMxywrDRWtsAOxp5iqRNdEhMnyM8EWJq4hfNu9IEwSah7Ge
	IjUvnAegj1cCMeTgAwuZiM4CESRNsRzDH41Asj6DuA1LmFckaAQtJwlS2c85aE4A
	nB3NWmvqnBvGUrxF1dfs9Qp2QJqT0EgnM7RlPbozZ80yBbjkmc+LoGvOwip+erzD
	SBa27npl0mXE9sieptsbGYMjoyd9T7jvSMDBkJq+B6eO+xx6zA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pq5bate-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 13:14:17 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44KDEDdT021023;
	Mon, 20 May 2024 13:14:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3y6ndk8krp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 13:14:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44KDECNs021017;
	Mon, 20 May 2024 13:14:12 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 44KDECJl021015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 13:14:12 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id 2764041124; Mon, 20 May 2024 18:44:11 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH] wifi: ath12k: Send QMI host capability after device group is ready
Date: Mon, 20 May 2024 18:44:09 +0530
Message-Id: <20240520131409.676931-1-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: WlodcaRK6xW8CjbzczfNKQFefxAhFrVY
X-Proofpoint-ORIG-GUID: WlodcaRK6xW8CjbzczfNKQFefxAhFrVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_05,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200108

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

QMI host capability has the information regarding MLO parameters such as
device_id, MLO capability, group id and the information of each devices
involved in the group and sent immediately on QMI server arrive event.
Currently, only one device is involved in the group and hence, single
device information is sent as part of MLO capability of host.

But, in future when multi device group abstraction is introduced, host
should send all the device information involved in the group as part
of QMI MLO host capability rather than single device. Hence, sending
QMI host capability immediately on server arrive of a device might not
be ideal for multi device group abstraction as the details of other
devices in the group would not be available.

Hence, once QMI server arrive event is received, request for QMI phy
capabilities of device, and defer the host capability send for that device.
After QMI phy capability is received for all the devices in the group
trigger the host capability event for the deferred devices in the group.

Add changes to defer the QMI host capability event until the device
group is ready and then resume the QMI exchange for all the device with
host capabilities.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
Depends-On: [PATCH v4 0/8] wifi: ath12k: Introduce device group abstraction
Link: https://lore.kernel.org/ath12k/20240507045702.2858954-1-quic_hprem@quicinc.com/
---
 drivers/net/wireless/ath/ath12k/core.c | 22 ++++++
 drivers/net/wireless/ath/ath12k/qmi.c  | 92 ++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/qmi.h  | 17 +++++
 3 files changed, 126 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 88b14343d91f..e316c98e3ee6 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -943,6 +943,25 @@ bool ath12k_core_hw_group_start_ready(struct ath12k_hw_group *ag)
 	return (ag->num_started == ag->num_devices);
 }
 
+static void ath12k_core_trigger_partner(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+	struct ath12k_base *partner_ab;
+	int i;
+	bool found = false;
+
+	for (i = 0; i < ag->num_devices; i++) {
+		partner_ab = ag->ab[i];
+		if (!partner_ab)
+			continue;
+
+		if (found)
+			ath12k_qmi_trigger_host_cap(partner_ab);
+
+		found = (partner_ab == ab) ? true : false;
+	}
+}
+
 int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 {
 	struct ath12k_hw_group *ag;
@@ -984,7 +1003,10 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 			goto err_core_stop;
 		}
 		ath12k_dbg(ab, ATH12K_DBG_BOOT, "group %d started\n", ag->id);
+	} else {
+		ath12k_core_trigger_partner(ab);
 	}
+
 	mutex_unlock(&ag->mutex_lock);
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index cbe77507c9ec..4e7bf1590e5a 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3081,9 +3081,65 @@ ath12k_qmi_driver_event_post(struct ath12k_qmi *qmi,
 	return 0;
 }
 
+void ath12k_qmi_trigger_host_cap(struct ath12k_base *ab)
+{
+	struct ath12k_qmi *qmi = &ab->qmi;
+
+	spin_lock(&qmi->event_lock);
+
+	if (ath12k_qmi_get_event_block(qmi))
+		ath12k_qmi_set_event_block(qmi, false);
+
+	spin_unlock(&qmi->event_lock);
+
+	ath12k_dbg(ab, ATH12K_DBG_QMI, "Trigger host cap for device id %d\n",
+		   ab->device_id);
+
+	ath12k_qmi_driver_event_post(qmi, ATH12K_QMI_EVENT_HOST_CAP, NULL);
+}
+
+static bool ath12k_qmi_hw_group_host_cap_ready(struct ath12k_hw_group *ag)
+{
+	struct ath12k_base *ab;
+	int i;
+
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+
+		if (!(ab && ab->qmi.num_radios != U8_MAX))
+			return false;
+	}
+	return true;
+}
+
+static struct ath12k_base *
+ath12k_qmi_hw_group_find_blocked_chip(struct ath12k_hw_group *ag)
+{
+	struct ath12k_base *ab;
+	int i;
+
+	lockdep_assert_held(&ag->mutex_lock);
+
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		spin_lock(&ab->qmi.event_lock);
+		if (ath12k_qmi_get_event_block(&ab->qmi)) {
+			spin_unlock(&ab->qmi.event_lock);
+			return ab;
+		}
+		spin_unlock(&ab->qmi.event_lock);
+	}
+
+	return NULL;
+}
+
 static int ath12k_qmi_event_server_arrive(struct ath12k_qmi *qmi)
 {
-	struct ath12k_base *ab = qmi->ab;
+	struct ath12k_base *ab = qmi->ab, *block_ab;
+	struct ath12k_hw_group *ag = ab->ag;
 	int ret;
 
 	ath12k_qmi_phy_cap_send(ab);
@@ -3094,11 +3150,17 @@ static int ath12k_qmi_event_server_arrive(struct ath12k_qmi *qmi)
 		return ret;
 	}
 
-	ret = ath12k_qmi_host_cap_send(ab);
-	if (ret < 0) {
-		ath12k_warn(ab, "qmi failed to send host cap QMI:%d\n", ret);
-		return ret;
+	spin_lock(&qmi->event_lock);
+	ath12k_qmi_set_event_block(qmi, true);
+	spin_unlock(&qmi->event_lock);
+
+	mutex_lock(&ag->mutex_lock);
+	if (ath12k_qmi_hw_group_host_cap_ready(ag)) {
+		block_ab = ath12k_qmi_hw_group_find_blocked_chip(ag);
+		if (block_ab)
+			ath12k_qmi_trigger_host_cap(block_ab);
 	}
+	mutex_unlock(&ag->mutex_lock);
 
 	return ret;
 }
@@ -3282,6 +3344,21 @@ static const struct qmi_ops ath12k_qmi_ops = {
 	.del_server = ath12k_qmi_ops_del_server,
 };
 
+static int ath12k_qmi_event_host_cap(struct ath12k_qmi *qmi)
+{
+	struct ath12k_base *ab = qmi->ab;
+	int ret;
+
+	ret = ath12k_qmi_host_cap_send(ab);
+	if (ret < 0) {
+		ath12k_warn(ab, "failed to send qmi host cap for device id %d: %d\n",
+			    ab->device_id, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
 static void ath12k_qmi_driver_event_work(struct work_struct *work)
 {
 	struct ath12k_qmi *qmi = container_of(work, struct ath12k_qmi,
@@ -3338,6 +3415,11 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 					&ab->dev_flags);
 
 			break;
+		case ATH12K_QMI_EVENT_HOST_CAP:
+			ret = ath12k_qmi_event_host_cap(qmi);
+			if (ret < 0)
+				set_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags);
+			break;
 		default:
 			ath12k_warn(ab, "invalid event type: %d", event->type);
 			break;
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 0dfcbd8cb59b..48fa06d5a30c 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -68,6 +68,7 @@ enum ath12k_qmi_event_type {
 	ATH12K_QMI_EVENT_FORCE_FW_ASSERT,
 	ATH12K_QMI_EVENT_POWER_UP,
 	ATH12K_QMI_EVENT_POWER_DOWN,
+	ATH12K_QMI_EVENT_HOST_CAP,
 	ATH12K_QMI_EVENT_MAX,
 };
 
@@ -142,6 +143,7 @@ struct ath12k_qmi {
 	u32 target_mem_mode;
 	bool target_mem_delayed;
 	u8 cal_done;
+	bool block_event;       /* protect by event spinlock */
 	u8 num_radios;
 	struct target_info target;
 	struct m3_mem_region m3_mem;
@@ -600,5 +602,20 @@ void ath12k_qmi_firmware_stop(struct ath12k_base *ab);
 void ath12k_qmi_deinit_service(struct ath12k_base *ab);
 int ath12k_qmi_init_service(struct ath12k_base *ab);
 void ath12k_qmi_free_resource(struct ath12k_base *ab);
+void ath12k_qmi_trigger_host_cap(struct ath12k_base *ab);
+
+static inline void ath12k_qmi_set_event_block(struct ath12k_qmi *qmi, bool block)
+{
+	lockdep_assert_held(&qmi->event_lock);
+
+	qmi->block_event = block;
+}
+
+static inline bool ath12k_qmi_get_event_block(struct ath12k_qmi *qmi)
+{
+	lockdep_assert_held(&qmi->event_lock);
+
+	return qmi->block_event;
+}
 
 #endif

base-commit: 0fc6e73fc428f17965ef134a8c10fc383ad19d58
prerequisite-patch-id: edec2473d32609e4a0379f6c453cc5872e14f72d
prerequisite-patch-id: 6bde6a3a3e8a1bcdbf07aacdb6d46b2ff8e4515d
prerequisite-patch-id: 26459ac80933dede57330d872944e7e44b99abf2
prerequisite-patch-id: a40bd619a2e783ae9503ad68b0f4a855b3078cf2
prerequisite-patch-id: 82fe7af803884e718257a29c5b94831f736f123b
prerequisite-patch-id: f42af58e87b862ca40ec0ec16326d129f4e786af
prerequisite-patch-id: 467cc116c0faa4439b7cdfd293ec95365198ff0f
prerequisite-patch-id: 0d8c5da758c08aa04e626e5c6a8c14fe634e3067
-- 
2.17.1


