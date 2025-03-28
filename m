Return-Path: <linux-wireless+bounces-20908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52716A74360
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36966189E34F
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAD721018A;
	Fri, 28 Mar 2025 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zto0yqBt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D49A4174A;
	Fri, 28 Mar 2025 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743139982; cv=none; b=S/ofMqOUoWFjwbCf7uUhVul8gshH75JBQ9LiumX0uelZXIt+147Ckm46Nowqu0C6bruZQ/irCYusHyM09rcf0CXZv2Tm/D5TjOaNFhwFsyNVAmMrmN+scNUIprmYrfGD1CwO3rpHcO5AsVbNqswYoIgv7/wyYI0oxH9u3KAHCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743139982; c=relaxed/simple;
	bh=PQP3v65mBuTwhVRw/CkMBp8moieKo9VnWG9AO+w/SqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=h5lDi/ehSjAvA1nUBHZ8F7EnFaWzngKn6lxfJJw9cGEeojOyXRCGlPD6TlBLAlur+H5QDoro/NhAzT6LkYNz13LhNB0MhaBuYoZf24jUpavuVhWAS84cbBOG//bn2fvogrmjZ4Sy4ry34xfUdhEKP9powGA252imHMOMAm4SuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zto0yqBt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S4faGk003117;
	Fri, 28 Mar 2025 05:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gKMzme0GlQVQ6rHYnJYimnT59uzw+e+CVQ7SKnqHCU8=; b=Zto0yqBtpWOknvSr
	MoJCbZ5wQ5vbK+uhMTgafBptG6SQhNYoJUcRQQmc1ypSg8okBFcmxmrpmABnbsOL
	SQ7i1kZa6oMlIQX7mvX8T+jEFEkLxZDJEg8KDu4Y/G147pcQri9pBIUq/t/+lt/V
	rBHqfSTtpMOAvx4kZ4QkfaJJ2Rs3r1tncV0sV2hKpbWNR5z8H/cNjMlY2oRjUS5j
	oAImkCKyRyqOh3c8KMLsbpVQrQ7/H6H/U1vYLYLh/8Y8vZ/dPZAfFB2lL9K3i6f6
	hVuEoPWv7aO7o+jFpK3Qqq79/7qbzO95DM+ttobA4YOF+wBy/68hofRe/YfYYDc7
	tG7ydA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45m0xe0f5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 05:32:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52S5WZ2x016356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 05:32:35 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 22:32:33 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 28 Mar 2025 13:32:25 +0800
Subject: [PATCH ath-next v3 2/6] wifi: ath11k: introduce
 ath11k_core_continue_suspend_resume()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250328-ath11k-bring-hibernation-back-v3-2-23405ae23431@quicinc.com>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
In-Reply-To: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Takashi Iwai
	<tiwai@suse.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0zq1mtFZD_9lnLff6mUvTF9oJHzt8BHv
X-Proofpoint-GUID: 0zq1mtFZD_9lnLff6mUvTF9oJHzt8BHv
X-Authority-Analysis: v=2.4 cv=Q43S452a c=1 sm=1 tr=0 ts=67e63474 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=QX4gbG5DAAAA:8 a=COk6AnOGAAAA:8 a=XLp1zxdMKvP_wVYWocMA:9
 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=670 malwarescore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280036

Currently ath11k_core_suspend() and ath11k_core_resume() have the same
check before going on. In upcoming patches the check is needed by some
newly added functions as well.

To avoid duplicate code, introduce a new helper
ath11k_core_continue_suspend_resume() which does such check internally.
Callers can decide whether to go on based on its return value.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 53 +++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index f3a29f5d2381b53be895a2687bc7ccc81ec1afbf..39922383f28ce0aa3e23281da050a8cffd3397ea 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -953,13 +953,6 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 	{}
 };
 
-static inline struct ath11k_pdev *ath11k_core_get_single_pdev(struct ath11k_base *ab)
-{
-	WARN_ON(!ab->hw_params.single_pdev_only);
-
-	return &ab->pdevs[0];
-}
-
 void ath11k_fw_stats_pdevs_free(struct list_head *head)
 {
 	struct ath11k_fw_stats_pdev *i, *tmp;
@@ -1018,23 +1011,37 @@ bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab)
 		return ab->hw_params.coldboot_cal_mm;
 }
 
-int ath11k_core_suspend(struct ath11k_base *ab)
+/* Check if we need to continue with suspend/resume operation.
+ * Return:
+ *	a negative value: error happens and don't continue.
+ *	0:  no error but don't continue.
+ *	positive value: no error and do continue.
+ */
+static int ath11k_core_continue_suspend_resume(struct ath11k_base *ab)
 {
-	int ret;
-	struct ath11k_pdev *pdev;
 	struct ath11k *ar;
 
 	if (!ab->hw_params.supports_suspend)
 		return -EOPNOTSUPP;
 
 	/* so far single_pdev_only chips have supports_suspend as true
-	 * and only the first pdev is valid.
+	 * so pass 0 as a dummy pdev_id here.
 	 */
-	pdev = ath11k_core_get_single_pdev(ab);
-	ar = pdev->ar;
+	ar = ab->pdevs[0].ar;
 	if (!ar || ar->state != ATH11K_STATE_OFF)
 		return 0;
 
+	return 1;
+}
+
+int ath11k_core_suspend(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_core_continue_suspend_resume(ab);
+	if (ret <= 0)
+		return ret;
+
 	ret = ath11k_dp_rx_pktlog_stop(ab, true);
 	if (ret) {
 		ath11k_warn(ab, "failed to stop dp rx (and timer) pktlog during suspend: %d\n",
@@ -1042,7 +1049,10 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 		return ret;
 	}
 
-	ret = ath11k_mac_wait_tx_complete(ar);
+	/* So far only single_pdev_only devices can reach here,
+	 * so it is valid to handle the first, and the only, pdev.
+	 */
+	ret = ath11k_mac_wait_tx_complete(ab->pdevs[0].ar);
 	if (ret) {
 		ath11k_warn(ab, "failed to wait tx complete: %d\n", ret);
 		return ret;
@@ -1080,19 +1090,10 @@ EXPORT_SYMBOL(ath11k_core_suspend);
 int ath11k_core_resume(struct ath11k_base *ab)
 {
 	int ret;
-	struct ath11k_pdev *pdev;
-	struct ath11k *ar;
 
-	if (!ab->hw_params.supports_suspend)
-		return -EOPNOTSUPP;
-
-	/* so far signle_pdev_only chips have supports_suspend as true
-	 * and only the first pdev is valid.
-	 */
-	pdev = ath11k_core_get_single_pdev(ab);
-	ar = pdev->ar;
-	if (!ar || ar->state != ATH11K_STATE_OFF)
-		return 0;
+	ret = ath11k_core_continue_suspend_resume(ab);
+	if (ret <= 0)
+		return ret;
 
 	ret = ath11k_hif_resume(ab);
 	if (ret) {

-- 
2.34.1


