Return-Path: <linux-wireless+bounces-20882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA10A7289C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 03:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAA016CEB6
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 02:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DBE54670;
	Thu, 27 Mar 2025 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UakgWQ/j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F613AA53
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 02:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743041169; cv=none; b=p4Qez8xHJW7zMtMlvG53haZSiptBTfzf9jZXpVsSIqPsOwnjMpRrZiv7YnpG8x6gHWDYA1zgkJ7Rs23BunIpKL9Lw9zAm1JMWvF0VocMfv1W4fJUMyIE37Z4f5t9CAWjFroWt9oLx8nh7MyPlLjOGmohpR1PmTmSUzb0gVgLlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743041169; c=relaxed/simple;
	bh=B+e1X96QimjkcYR2W/xvQp9/c44vRVk4cD6kfYdkRFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+/AE5XfT5sGz5l+1lrjnMG6VHMsev+xDz5O/jEiOxZ017jLGqnTumzYG6Q7m8pUBhxUC9s/0vp/vXAcdnNZwWjtibB5aTsCl50MrnfJvf2+G302vQOThttGci6Rfc2Gzl2UA+o96ApWR+6iAHr8S6ZXyIGgLi5NI1fSNjX8ld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UakgWQ/j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QF7OlY012762;
	Thu, 27 Mar 2025 02:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vB6Axxhx1+54aDKPBBVaprYnUQYbIffjdLBT0MYhbWA=; b=UakgWQ/jiSSm0zUY
	pQtpq6Mamw7i9xKqKikzVHrBx4ii3NhFQDHv0cCUkuFaqESa6Z9qZ8i69pNDl0yd
	7P4pr4g9eeOhcNiS1nMMnpd30+waBCksT6CIYHUsVBqxMdI5OcEj2xaHcHfUnmS6
	I+anr0fXuhNOV/A4Q9+nzFbsPUisDjOAHGZny0uRCMhjlHbgy2eH8wnkz5NB64ZH
	QK6KBpVgeUsiFDT7hPNRjLHe/jjr0snTuGRP5TmllFy04ahL7UghTNIKti3tbkKo
	n2NGXjgL+ZiWa6NyOpBEGA5eZu4PNlXeXuALsQL5GZZGYvgc5w1cOr2Q0Xmvjemz
	GXlqcw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyr9mrhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:06:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52R263Kr005501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:06:03 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Mar 2025 19:06:02 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>, <quic_kangyang@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath-next v14 4/4] wifi: ath12k: store and send country code to firmware after recovery
Date: Thu, 27 Mar 2025 10:05:27 +0800
Message-ID: <20250327020527.1527-5-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250327020527.1527-1-quic_kangyang@quicinc.com>
References: <20250327020527.1527-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XVMdE6-1LQWfoxNHsC5o7797dJjnhSil
X-Authority-Analysis: v=2.4 cv=UblRSLSN c=1 sm=1 tr=0 ts=67e4b28c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=d7ZbDmEs_mvt8H_whs4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: XVMdE6-1LQWfoxNHsC5o7797dJjnhSil
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270013

From: Wen Gong <quic_wgong@quicinc.com>

Currently ath12k does not send the country code to firmware after device
recovery. As a result the country code will be the default one which
is reported from firmware. Country code is important, so ath12k also
need to restore it to the value which was used before recovery.

This is only needed for platforms which support the current_cc_support
hardware parameter.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 1 +
 drivers/net/wireless/ath/ath12k/core.h | 1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 8 ++++++++
 drivers/net/wireless/ath/ath12k/reg.c  | 1 +
 4 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index fa0d40fe3e4d..06e3ee16eb0e 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1416,6 +1416,7 @@ static void ath12k_update_11d(struct work_struct *work)
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
 
+		memcpy(&ar->alpha2, &arg.alpha2, 2);
 		ret = ath12k_wmi_send_set_current_country_cmd(ar, &arg);
 		if (ret)
 			ath12k_warn(ar->ab,
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 62cde7132555..5f98b98b38cf 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -752,6 +752,7 @@ struct ath12k {
 	u32 vdev_id_11d_scan;
 	struct completion completed_11d_scan;
 	enum ath12k_11d_state state_11d;
+	u8 alpha2[REG_ALPHA2_LEN];
 	bool regdom_set_by_user;
 
 	struct completion fw_stats_complete;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 401e434ccf70..d522972b24bf 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10438,6 +10438,14 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 		ath12k_warn(ar->ab, "pdev %d successfully recovered\n",
 			    ar->pdev->pdev_id);
 
+		if (ar->ab->hw_params->current_cc_support &&
+		    ar->alpha2[0] != 0 && ar->alpha2[1] != 0) {
+			struct wmi_set_current_country_arg arg = {};
+
+			memcpy(&arg.alpha2, ar->alpha2, 2);
+			ath12k_wmi_send_set_current_country_cmd(ar, &arg);
+		}
+
 		if (ab->is_reset) {
 			recovery_count = atomic_inc_return(&ab->recovery_count);
 
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index e6f0f563d370..893650f76fb2 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -85,6 +85,7 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	for_each_ar(ah, ar, i) {
 		if (ar->ab->hw_params->current_cc_support) {
 			memcpy(&current_arg.alpha2, request->alpha2, 2);
+			memcpy(&ar->alpha2, &current_arg.alpha2, 2);
 			ret = ath12k_wmi_send_set_current_country_cmd(ar, &current_arg);
 			if (ret)
 				ath12k_warn(ar->ab,
-- 
2.34.1


