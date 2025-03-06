Return-Path: <linux-wireless+bounces-19844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EF9A542B7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 07:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59442189271A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 06:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C91A23BC;
	Thu,  6 Mar 2025 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j+repSnf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF719F495
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242177; cv=none; b=WuVwzUkg5JXym1uNahqF4qyeW1uL5MwVtp0D3SgIubQJROKXwUgux7LhKLqI9C0GK9FM3Tm3+ySjDEyz+lK71uqlJvXTT1bCCiFLsS9eBPW1LPeu9p0QHWI9ZSASdphLKSDFoRhYxw2XG+u0kO5h7eKFnJmtAg3WzyK10fOVU5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242177; c=relaxed/simple;
	bh=c5SmEMan/FfnpMDTLt3JLqmmC/N8P69os032UEgThqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUp8YjrFMT0CwbIIHvSd/HRuCzGm+nKdDYhVObZWX3VILC56OzVfSXhE6RUhMRO40BjElhnE8mj8XJH6VqgkD940J7pBrLqHDGX5U0DNTJxhhY7uRcNGmpeApEx/zQvL6JvCIouEuaK0gVHVyPQ7DxK7n6fDuD+bIQ/tCkmJC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j+repSnf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525Ls2bt012458;
	Thu, 6 Mar 2025 06:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jsQYahd56p8iD7rT66MO+DkRt9uZksoQbbXlVQ/seuM=; b=j+repSnfihJgV5r5
	554QI9op43uiCl851221EMUcG1MR0N2DXOjK/LVYH+F+hC0MjRVznCMGRgigmr6J
	bT1FtVLTvhB43CTkPprgKKKCn4hsSxetEpXVL7t8Aqkc3Sh2OgnhSmGFV+jQsSQr
	1P0t8qEx6ARifMQwuh9ouwC0gabo4xfHp+PTaWPOyPx0Y5fqep3FOzWs7MI+mHYT
	3RmsW4sXVgTDDNGt944DbOt91UpTTkC6t7oDwAdKV0BL44RN4mtxWiTKaTVSJ1gA
	DDQQ+ysGRqq5MH73U1j98CcVecFpE+yM0Kkiu5aLdVNyq/syZV2ShIvBsue7NRcQ
	msdqAA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6wqtjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 06:22:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5266MMQG027475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Mar 2025 06:22:22 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Mar 2025 22:22:20 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Ramasamy
 Kaliappan" <quic_rkaliapp@quicinc.com>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH wireless-next v4 2/4] wifi: mac80211: update ML STA with EML capabilities
Date: Thu, 6 Mar 2025 11:51:55 +0530
Message-ID: <20250306062157.1185769-3-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306062157.1185769-1-quic_ramess@quicinc.com>
References: <20250306062157.1185769-1-quic_ramess@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EZcyQOmC c=1 sm=1 tr=0 ts=67c93f33 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=1LoY2HbNQILQZSRJ-oMA:9 a=xSf7fofPWiONnamsZ4Lw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QCeixElw_uHbsGs-Cj7fwL2eWnRxf_WJ
X-Proofpoint-ORIG-GUID: QCeixElw_uHbsGs-Cj7fwL2eWnRxf_WJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060046

From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>

When an AP and Non-AP MLD operates in EMLSR mode, EML capabilities
advertised during Association contains information such as EMLSR
transition delay, padding delay and transition timeout values.

Save the EML capabilities information that is received during station
addition and capabilities update in ieee80211_sta so that drivers can use
it for triggering EMLSR operation.

Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 include/net/mac80211.h | 2 ++
 net/mac80211/cfg.c     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c498f685d01f..99c3224a081a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2488,6 +2488,7 @@ struct ieee80211_link_sta {
  * @max_amsdu_subframes: indicates the maximal number of MSDUs in a single
  *	A-MSDU. Taken from the Extended Capabilities element. 0 means
  *	unlimited.
+ * @eml_cap: EML capabilities of this MLO station
  * @cur: currently valid data as aggregated from the active links
  *	For non MLO STA it will point to the deflink data. For MLO STA
  *	ieee80211_sta_recalc_aggregates() must be called to update it.
@@ -2522,6 +2523,7 @@ struct ieee80211_sta {
 	bool mlo;
 	bool spp_amsdu;
 	u8 max_amsdu_subframes;
+	u16 eml_cap;
 
 	struct ieee80211_sta_aggregates *cur;
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 09708a060bb7..e73f54a36aed 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2066,6 +2066,9 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (params->listen_interval >= 0)
 		sta->listen_interval = params->listen_interval;
 
+	if (params->eml_cap_present)
+		sta->sta.eml_cap = params->eml_cap;
+
 	ret = sta_link_apply_parameters(local, sta, STA_LINK_MODE_STA_MODIFY,
 					&params->link_sta_params);
 	if (ret)
-- 
2.34.1


