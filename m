Return-Path: <linux-wireless+bounces-6596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D68ABA56
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 10:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A084B2205C
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE015E8B;
	Sat, 20 Apr 2024 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XtAwsVvK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810AC14A8C
	for <linux-wireless@vger.kernel.org>; Sat, 20 Apr 2024 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713602295; cv=none; b=jW2iZNW5g511xWA7q48rXnTSHFI/Lk0Z2DcsZv27TzEHQulOEhJ0vyvndZJHKfTSwhiww2N1DzhnPgp1AykMULXjKr4CBWdugeTGCKQ/+oaPfjb3fM49KAXBR6T/luJsQGYFCZ5AqJgXfp9ygAgfE9QWaSC5DbYFvikdChaz2jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713602295; c=relaxed/simple;
	bh=cSz3/hB3koj16kbl8qwD/XMW1nKdqgH+xDyp+2BZc7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EP5KHRyL05Na5LihtV9gCu6kDWgJLwlhN3JvEWze9/qMPpgDwZWpeiX/J7XbDHRT3AmSJxmyCvYLWNC/3OFNvBkMmMSnP+SlfnN245VpSOcjM6MJV572jffBVoiVM6QG1jrStfRrZFUSuTctHC5QPSaC9jf48aIC6uMG/UQ5BC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XtAwsVvK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43K7GAvC014360;
	Sat, 20 Apr 2024 08:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=ZYqAYEy
	CU9X9So9Zm+o6c0oikxCJNIlG+uAjMo3ehtc=; b=XtAwsVvKgt77GFlehoRQoBK
	36enzmfXCD6eWbWcLxPNyBl3URM/NTk/Pkjs2HSYJfEqxGv6V6M/cieMuv9O7k++
	Pa0zXvFjjihO+EfkVrjU2SbBNh6LwhuiDIO0rBRQiAfOsbFqMz3SxVfnJPW8xVH0
	i/d4CwKdjmOcXCKy5y9lzPwUPg93Fo2KvsDNJ4iOl4k2jgu9EjLMolglY2HZaxw7
	vHeK7okZ92hn+XqkpZYw97dG7DDQsJ6uMao0Y+EZQA0mCznW5T51IQf/irRRG1Ct
	HMbxZ5+HvplnPYll9MkgHwQNPWDO+J2OQpQl26ejs8iL2417RlAGhBDnGShkBmg=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm6fkgbxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 08:38:12 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43K8Zq9i028245;
	Sat, 20 Apr 2024 08:38:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xm6sk95kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 08:38:08 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43K8ZoUP028209;
	Sat, 20 Apr 2024 08:38:08 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 43K8c8gj030909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 08:38:08 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id 8125541171; Sat, 20 Apr 2024 14:08:07 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH 4/8] wifi: ath12k: Introduce QMI firmware ready flag
Date: Sat, 20 Apr 2024 14:07:46 +0530
Message-Id: <20240420083750.1545670-5-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420083750.1545670-1-quic_hprem@quicinc.com>
References: <20240420083750.1545670-1-quic_hprem@quicinc.com>
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
X-Proofpoint-GUID: QYjvLFVgZ-U3ELoA5J1AJUVutdnMNxut
X-Proofpoint-ORIG-GUID: QYjvLFVgZ-U3ELoA5J1AJUVutdnMNxut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_07,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=749
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200062

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
 drivers/net/wireless/ath/ath12k/qmi.c  | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index c06bbb083ab3..3961a45a3458 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -208,6 +208,7 @@ enum ath12k_dev_flags {
 	ATH12K_FLAG_HTC_SUSPEND_COMPLETE,
 	ATH12K_FLAG_CE_IRQ_ENABLED,
 	ATH12K_FLAG_EXT_IRQ_ENABLED,
+	ATH12K_FLAG_QMI_FW_READY_COMPLETE,
 };
 
 enum ath12k_monitor_flags {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index db8ba5fec2ae..0e34dfadf1b9 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2968,6 +2968,8 @@ void ath12k_qmi_firmware_stop(struct ath12k_base *ab)
 {
 	int ret;
 
+	clear_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE, &ab->dev_flags);
+
 	ret = ath12k_qmi_wlanfw_mode_send(ab, ATH12K_FIRMWARE_MODE_OFF);
 	if (ret < 0) {
 		ath12k_warn(ab, "qmi failed to send wlan mode off\n");
@@ -3262,7 +3264,8 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 			break;
 		case ATH12K_QMI_EVENT_FW_READY:
 			clear_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags);
-			if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)) {
+			if (test_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE,
+				     &ab->dev_flags)) {
 				ath12k_hal_dump_srng_stats(ab);
 				queue_work(ab->workqueue, &ab->restart_work);
 				break;
@@ -3271,8 +3274,12 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
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


