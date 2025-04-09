Return-Path: <linux-wireless+bounces-21292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6532A81AF3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 04:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09144C0B47
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 02:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D7C1C5F09;
	Wed,  9 Apr 2025 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PG6r5j2y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD501C173C;
	Wed,  9 Apr 2025 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165648; cv=none; b=g/JXAH+v4OPbdRpbln2dLea1fRTr9tgV9qXoNJYVn6fTP6/N6AGqQ7IQIjLhUX0Ab38u1ZGYxdlvudzwJOd0+1yj+PWWbqLR4UOjYVT8HBHo8uqgXbaC41uAe3Za/mlApTRqM7cynhrLqyz0QQHVvW+sUH8y0K2+fcuqWZoLKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165648; c=relaxed/simple;
	bh=EiPoEyYLSRvFVuGlHUArwxqDC12DiMXcnvGq3uhK3tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KoiVIsVz2EtUrXfpWcFvR9JGKjy+/5aXM2STZQBM/rhy/ff7qQyhMMSIipINilQ/Ozmz4u/ZioMDJ4de3y5YbQlFJC1yBhs5YB7MLqYk41/glS8+/5vOBFVVXOPBMxqXlAuWuz53bReQM6kPWB6RDJESjDPaHnOvZOdoCztAzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PG6r5j2y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYmcR004647;
	Wed, 9 Apr 2025 02:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bB2aSvWCwCUN9vgJUDy6ZwUZK9U5Lbj14Khhe8dU87o=; b=PG6r5j2yzMGlZFDA
	VPyWegJ64BjIdFnbVVd8JYNdQ7vcOpuyuA/pbA3zSgU1BwBmvJ6lRVCQx0Pa0cNV
	Z8WLkHP5CumhQr7ewr3k11l7N5F9uAGXcHVS1xHnFCdtGEBkZm+gWK4myYoZCMJF
	OKJjZdq2NCxnchRo6FspzPm/Ejl7xxmMvNtamAVvVCYFasiq1E1MyrFUQGcUXUf5
	9aToXFhmGUp7a5PUC3iCj9n+eopr6Dvk2lNg42iocHk0wBawxib/sjaJksMZizjU
	wVHc8ob3zz0u+HHUJQQXcyXR3W/9bGfOWmIwNtFWsoOoXrRp3PfRQo/gqapLBhHG
	ltB1KA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtb1vbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 02:27:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5392RJlK000951
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 02:27:19 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 19:27:16 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 9 Apr 2025 10:26:37 +0800
Subject: [PATCH ath-next v2 4/9] wifi: ath12k: identify assoc link vif in
 station mode
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250409-ath12k-wcn7850-mlo-support-v2-4-3801132ca2c3@quicinc.com>
References: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
In-Reply-To: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CtXKD4sVlFP7OvFxwcNrH6XWc90k6U7J
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f5db07 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=6jSpk0C-6dksNK5Wy0gA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: CtXKD4sVlFP7OvFxwcNrH6XWc90k6U7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090002

In MLO scenario, for station mode interface, WCN7850 firmware requests
the assoc link vdev to get started before any other link vdevs starts.
Firmware internally checks assoc_link field of
wmi_vdev_start_mlo_params.flags when the first vdev starts. And if the
check fails firmware crashes.

Current connection flow guarantees the assoc link vdev gets started
first (at assoc stage only one link vdev is created/started, i.e. the
assoc link vdev), however the assoc_link flag is never set, resulting
in WCN7850 firmware crash.

Note ath12k_link_sta structure already has is_assoc_link flag, and it
is properly set for assoc link. However we can not use it because it
won't be available before peer gets created, which is too late for vdev
starts.

So add a new flag 'is_sta_assoc_link' in ath12k_link_vif structure and
set it when deflink vdev is created. This is valid because we always
use deflink as the assoc link. This flag is passed to firmware vdev
starts to avoid firmware crash. Also verify the link vif/sta pair has
the same settings when creating link sta.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  3 +++
 drivers/net/wireless/ath/ath12k/mac.c  | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index fa8c3f9ab7a92f17f83b3378bc00aa884bc6bdcf..39a7784e36d90130f9c5f170adaef279ad071a92 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -312,6 +312,9 @@ struct ath12k_link_vif {
 	struct ath12k_rekey_data rekey_data;
 
 	u8 current_cntdown_counter;
+
+	/* only used in station mode */
+	bool is_sta_assoc_link;
 };
 
 struct ath12k_vif {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2b6bdc3d2b11a8a5f5733352826c724c671fd49a..316df6e36c6bac00eef4d98a03c1335f5c0cca4a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3474,6 +3474,8 @@ static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
 		 */
 		if (!ahvif->links_map && link_id != ATH12K_DEFAULT_SCAN_LINK) {
 			arvif = &ahvif->deflink;
+			if (vif->type == NL80211_IFTYPE_STATION)
+				arvif->is_sta_assoc_link = true;
 		} else {
 			arvif = (struct ath12k_link_vif *)
 			kzalloc(sizeof(struct ath12k_link_vif), GFP_KERNEL);
@@ -5865,6 +5867,17 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		 * link sta
 		 */
 		if (sta->mlo) {
+			/* For station mode, arvif->is_sta_assoc_link has been set when
+			 * vdev starts. Make sure the arvif/arsta pair have same setting
+			 */
+			if (vif->type == NL80211_IFTYPE_STATION &&
+			    !arsta->arvif->is_sta_assoc_link) {
+				ath12k_hw_warn(ah, "failed to verify assoc link setting with link id %u\n",
+					       link_id);
+				ret = -EINVAL;
+				goto exit;
+			}
+
 			arsta->is_assoc_link = true;
 			ahsta->assoc_link_id = link_id;
 		}
@@ -9119,6 +9132,9 @@ ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
 	 * link vdevs which are advertised as partners below
 	 */
 	ml_arg->link_add = true;
+
+	ml_arg->assoc_link = arvif->is_sta_assoc_link;
+
 	partner_info = ml_arg->partner_info;
 
 	links = ahvif->links_map;

-- 
2.25.1


