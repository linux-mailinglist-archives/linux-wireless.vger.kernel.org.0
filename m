Return-Path: <linux-wireless+bounces-20592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B619BA69E50
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B200983740
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 02:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506661EB19B;
	Thu, 20 Mar 2025 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VZhNMfQG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E681EC01C
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437825; cv=none; b=Fv2MMrwnyYGbOUvLVdbbcjWLmfa2LP5f7fmHbzi8O6odBA6DUNffbDwBfLeW9M12/aVBt9MNJ+g/m886GC76NKAXpGfSSJKegXcg4NnvfEgi7NKprpUdpjtTcME+SiQEOCrGY5Qxjnz9hnyKqePnXv/gb+U15fY+A0qOeH1/agI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437825; c=relaxed/simple;
	bh=m6c/kL/6izR/rrKPLcLUSuRIX4fVBvg4zLduStidoac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1qpoxeQ5P6d0YLAGNJwQVpKFtFJZuF2fQ4+d4fL/NUjN5v38+FwBzdzFhIEPvvoCnNogsSIrd2qLdrFiVym5BbdAVWwe1Qb2rNtp41iNpjyG3Xc9Y+wAPxMBsUlWzY11g88jTrkimQWMan36mYASFLOQdnkL70daaMomBALjjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VZhNMfQG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JDNboM020465;
	Thu, 20 Mar 2025 02:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xSOfDDSXNZ4RyKURRzQgednBF2kjnLsNaKDdYDTsIeM=; b=VZhNMfQGO8JVguBV
	aBGPjHMC/3EAonKI/aUDZVE5UAV2zdMN+OqUAchLJNvK5spjqnU16fOT1bjqwaVf
	R3pix9OH+wDzlXhe637PncgArYTXXcckmcBGnNanunIn7u7wqbvFiPgMRec7eXzn
	ZvcaDzNfcB9b2KtjgWmGwRN5PZpgIrdNdJjbO7sv6Zcp5FHCNzyGPHeNINYTvJrF
	wKt1Ff9CQj0TclqflVHIfK+w9gWUQoJ/iVAYZeYA7I4dA2XNQ6F5QzUbgqZfdFRy
	pl1eI1uCecldrnevIPe7sYqiWHUOkQnDSMVfkSDQ4Pylk+pAvDbS+RIMVokel5nC
	m4CPOg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdmwvngk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 02:30:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52K2UJvG011242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 02:30:19 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Mar 2025 19:30:17 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH ath-next 3/5] wifi: ath11k: refactor ath11k_core_suspend/_resume()
Date: Thu, 20 Mar 2025 10:30:01 +0800
Message-ID: <20250320023003.65028-4-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320023003.65028-1-quic_bqiang@quicinc.com>
References: <20250320023003.65028-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sU_c7hwMUYpkl452asiuH0iBz9NlW3re
X-Authority-Analysis: v=2.4 cv=ReKQC0tv c=1 sm=1 tr=0 ts=67db7dbc cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=bGu3PSnQW4_eZa6IxEIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sU_c7hwMUYpkl452asiuH0iBz9NlW3re
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_01,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=835 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200014

Due to [1] we currently put WLAN target into WoWLAN mode regardless of
machine models. In upcoming patches we will support another mode, and
finally which mode is chosen depends on the exact machine model.

To prepare for such change, refactor the actual WoWLAN stuff in
ath11k_core_suspend() into a new helper ath11k_core_suspend_wow(), this
increase the code readability when the new suspend mode is added in
upcoming patches.

Same change applies to ath11k_core_resume();

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219196

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 28 +++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index d3241a0df407..0396eb557e3b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1041,14 +1041,10 @@ static int ath11k_core_continue_suspend_resume(struct ath11k_base *ab)
 	return 1;
 }
 
-int ath11k_core_suspend(struct ath11k_base *ab)
+static int ath11k_core_suspend_wow(struct ath11k_base *ab)
 {
 	int ret;
 
-	ret = ath11k_core_continue_suspend_resume(ab);
-	if (ret <= 0)
-		return ret;
-
 	ret = ath11k_dp_rx_pktlog_stop(ab, true);
 	if (ret) {
 		ath11k_warn(ab, "failed to stop dp rx (and timer) pktlog during suspend: %d\n",
@@ -1092,9 +1088,8 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 
 	return 0;
 }
-EXPORT_SYMBOL(ath11k_core_suspend);
 
-int ath11k_core_resume(struct ath11k_base *ab)
+int ath11k_core_suspend(struct ath11k_base *ab)
 {
 	int ret;
 
@@ -1102,6 +1097,14 @@ int ath11k_core_resume(struct ath11k_base *ab)
 	if (ret <= 0)
 		return ret;
 
+	return ath11k_core_suspend_wow(ab);
+}
+EXPORT_SYMBOL(ath11k_core_suspend);
+
+static int ath11k_core_resume_wow(struct ath11k_base *ab)
+{
+	int ret;
+
 	ret = ath11k_hif_resume(ab);
 	if (ret) {
 		ath11k_warn(ab, "failed to resume hif during resume: %d\n", ret);
@@ -1126,6 +1129,17 @@ int ath11k_core_resume(struct ath11k_base *ab)
 
 	return 0;
 }
+
+int ath11k_core_resume(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_core_continue_suspend_resume(ab);
+	if (ret <= 0)
+		return ret;
+
+	return ath11k_core_resume_wow(ab);
+}
 EXPORT_SYMBOL(ath11k_core_resume);
 
 static void ath11k_core_check_cc_code_bdfext(const struct dmi_header *hdr, void *data)
-- 
2.25.1


