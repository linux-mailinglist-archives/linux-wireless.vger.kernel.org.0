Return-Path: <linux-wireless+bounces-7265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31478BDA6F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 06:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46BEB254AD
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 04:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7978B60;
	Tue,  7 May 2024 04:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GxRCHoMS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24147319F
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 04:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057861; cv=none; b=p6r0XM8npKT3madu5G7TjiYxGa+nx1uV2mhRzEFRQro7TrQlvL3PjhEUUi63gST7AJn3hTdR0yVJOl4T98V5rKdHF8f9AUfIpt2BCZArUA7UcXiWpQcGsX5fyDj5in0Q1nN1F9HW0az8xv5sCDickijqwueR3GR9nCz57gP/lTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057861; c=relaxed/simple;
	bh=Wt3npiWDE+gKd+wNvz2QXwy05Oub8/JP6IEzSUWkqAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTthhGKjFP5Lz9T7n0p8bdc3yesPowkMDbkQqqSGNWi5KoqtGuNGZGz11tG4r3WcaKgkf8XwCh+CgEwpUfew9wQ3Pvao2yxSyHj6IkJh5VorZePr8EmZGprEBBQ+UoIxVhEwWRKV10IgRfv2DTXb45OgZndM2TytyDg4y6k2W6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GxRCHoMS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4473NL7B012224;
	Tue, 7 May 2024 04:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=IoIiHlt
	AK92Yj6c06oX+3YkBas+7zL9fmP20FIBSM9g=; b=GxRCHoMSvWQU7EK1qhS6OWW
	x+fzG87jMZ9tt4vQxsNtsyfbhvp8D8S56fjTIUOT48ycpR9ib9Fkn5TtQx9RPuN+
	JYP9QHJoWKeHovcrKJlLEjqWkVRfH48LFa8vkLv0pLiOvAnL8pf8KFagPhPbJB7j
	YbgBGZwJRxKUWBjyczCv8FkF1Vew87LuUH+oXpyom96iISTL7nRs/DBwLL+EJ7Ta
	u0gmXCD4le85gxEB5Y0skSTimsHHovVtO/ii0aZ8NE5qd4l1mEWtJ88j6Px2ucGQ
	8pE0nKXPQYqk0xZVXqQjUKZ7q1a24VlhyUYeFwzft2NO2/uiJlgdSpIPTirIHbw=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xy1vw9a47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 04:57:35 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4474vWqA004107;
	Tue, 7 May 2024 04:57:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xwe3kn516-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 04:57:32 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4474vSNo003652;
	Tue, 7 May 2024 04:57:31 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4474vVXG004102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 04:57:31 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id A78A74114D; Tue,  7 May 2024 10:27:30 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH v4 4/8] wifi: ath12k: Introduce QMI firmware ready flag
Date: Tue,  7 May 2024 10:26:58 +0530
Message-Id: <20240507045702.2858954-5-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507045702.2858954-1-quic_hprem@quicinc.com>
References: <20240507045702.2858954-1-quic_hprem@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Ral9lY2UNAGbo7D8ir7Bjs0U4l6M-z8a
X-Proofpoint-GUID: Ral9lY2UNAGbo7D8ir7Bjs0U4l6M-z8a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_02,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=817 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405070033

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

When hardware device group abstraction is introduced, QMI firmware
ready event of different devices in a group can be received simultaneously.

To indicate firmware ready event is completed for a particular device in a
group set a flag (ATH12K_FLAG_QMI_FW_READY_COMPLETE). This would be
helpful when hardware recovery is introduced for hardware device group
abstraction.

Add changes to set/unset ATH12K_FLAG_QMI_FW_READY_COMPLETE flag for a
device.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/qmi.c  | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 49ff408d6db1..4736d1afa0c7 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -210,6 +210,7 @@ enum ath12k_dev_flags {
 	ATH12K_FLAG_HTC_SUSPEND_COMPLETE,
 	ATH12K_FLAG_CE_IRQ_ENABLED,
 	ATH12K_FLAG_EXT_IRQ_ENABLED,
+	ATH12K_FLAG_QMI_FW_READY_COMPLETE,
 };
 
 enum ath12k_monitor_flags {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 3bb730326a02..19a03cf8c391 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3023,6 +3023,8 @@ void ath12k_qmi_firmware_stop(struct ath12k_base *ab)
 {
 	int ret;
 
+	clear_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE, &ab->dev_flags);
+
 	ret = ath12k_qmi_wlanfw_mode_send(ab, ATH12K_FIRMWARE_MODE_OFF);
 	if (ret < 0) {
 		ath12k_warn(ab, "qmi failed to send wlan mode off\n");
@@ -3320,7 +3322,7 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 			break;
 		case ATH12K_QMI_EVENT_FW_READY:
 			clear_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags);
-			if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)) {
+			if (test_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE, &ab->dev_flags)) {
 				if (ab->is_reset)
 					ath12k_hal_dump_srng_stats(ab);
 				queue_work(ab->workqueue, &ab->restart_work);
@@ -3330,8 +3332,12 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 			clear_bit(ATH12K_FLAG_CRASH_FLUSH,
 				  &ab->dev_flags);
 			clear_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags);
-			ath12k_core_qmi_firmware_ready(ab);
-			set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
+			ret = ath12k_core_qmi_firmware_ready(ab);
+			if (!ret) {
+				set_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE,
+					&ab->dev_flags);
+				set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
+			}
 
 			break;
 		default:
-- 
2.34.1


