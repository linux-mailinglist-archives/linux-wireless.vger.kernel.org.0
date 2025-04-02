Return-Path: <linux-wireless+bounces-21049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABC5A7868E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 04:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A904D16E6DF
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A721A17B502;
	Wed,  2 Apr 2025 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cJw8UI80"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376A15CD46;
	Wed,  2 Apr 2025 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743562003; cv=none; b=WvNcXrYuzhlBlubC4diZwcvEMm2LZLc7J/HQ0cHyy+rnDFWrXErZ+v0k6576uYtBcyqOCLG4OLQmpMt+GG16OnvKdTzyo3wyTXnrPJqOc6YzN9B/Ksxv4qssfwdpsGGoUmj6G+k120XsFjosY+DJeG6jQIpyxM9gryLXClPijhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743562003; c=relaxed/simple;
	bh=HA5KLHDY5Lr/Vv1+o8MJ4zvK7Pn9HpeW2j+f7C2Mwkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=s9g5hZ2Mf2obVErZ1qA9eCTh5ZU2RBzlOKIdx7b9bfbNfJWQxGlQvUzJRKmjiBwfmjwxaM0k1nmdAdOGW0ce9t8VuGrXp68JJCz09iH/7hi4WeKZ56ZALwtoLkyMzv64MlsDsIHb0YG/N0nVHKCihfu5r9IXNsLbJCIv72Cj8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cJw8UI80; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5322TBgK031698;
	Wed, 2 Apr 2025 02:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rKwnGB66cY9ljn6Zy1n2ni2lO2UgmOF3W/LGDpjcJ5s=; b=cJw8UI80yWOQM07w
	iqesD5ERuoGn9gw2e8LPnKoR0XUBIceG+PWKO1Nnt5csY11yAduYi5kBBfDizJvb
	BPqatw06yyB8WkCBnh1MEKHrvp/WXQOZJPr1wkc2twyNBmZo0LF+mDXuv85SzC7W
	j3ecDZBsM3Iy3iIrjPGA4uE8yJ4VBsKcK3qurStEZ2HJhorxUXzplanBFGTNWx74
	UIK8ob5jn38c/ZEOJMXvKWcWKMN8GYQ70wgsrKsFDATRbVi99/8ZL9lWP+f5I7QP
	IWAueMNyCAPudHuLELRYp1Qlr+6mPdAsNVPmkzKZ3bVKlSiMYoT5NjMDLDXkcIss
	nfzDNQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45qxa7vxcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 02:46:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5322kKjk014594
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 02:46:20 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Apr 2025
 19:46:18 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 2 Apr 2025 10:45:43 +0800
Subject: [PATCH ath-next 4/9] wifi: ath12k: identify assoc link vif in
 station mode
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250402-ath12k-wcn7850-mlo-support-v1-4-bad47cf00704@quicinc.com>
References: <20250402-ath12k-wcn7850-mlo-support-v1-0-bad47cf00704@quicinc.com>
In-Reply-To: <20250402-ath12k-wcn7850-mlo-support-v1-0-bad47cf00704@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EpGiFz526WOMuywiTAsL4quOduEX47To
X-Proofpoint-GUID: EpGiFz526WOMuywiTAsL4quOduEX47To
X-Authority-Analysis: v=2.4 cv=J9Oq7BnS c=1 sm=1 tr=0 ts=67eca4fd cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=6jSpk0C-6dksNK5Wy0gA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020017

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
index a279c05d172fe579d529bd3354dd28941a74ddde..c448c72e9f05f8d87db51bb0b97ab3e5414d2920 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -306,6 +306,9 @@ struct ath12k_link_vif {
 	struct ath12k_rekey_data rekey_data;
 
 	u8 current_cntdown_counter;
+
+	/* only used in station mode */
+	bool is_sta_assoc_link;
 };
 
 struct ath12k_vif {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f2fddf213afb9cd8681d3d94a7863c8a25be2bb6..2239d5a25ffef13e5e58653355148acb32b20af8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3461,6 +3461,8 @@ static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
 		 */
 		if (!ahvif->links_map && link_id != ATH12K_DEFAULT_SCAN_LINK) {
 			arvif = &ahvif->deflink;
+			if (vif->type == NL80211_IFTYPE_STATION)
+				arvif->is_sta_assoc_link = true;
 		} else {
 			arvif = (struct ath12k_link_vif *)
 			kzalloc(sizeof(struct ath12k_link_vif), GFP_KERNEL);
@@ -5835,6 +5837,17 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
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
@@ -8968,6 +8981,9 @@ ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
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


