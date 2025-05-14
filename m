Return-Path: <linux-wireless+bounces-22934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5638AB69FB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 13:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7EA1B6219E
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8A127587A;
	Wed, 14 May 2025 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iCqyRzqC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C42750F4;
	Wed, 14 May 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222128; cv=none; b=Fw+HBeIA9O7rnqt+krMbecwcLyNM4clrQ9UGuxRhIeoSppM2IK47Rqq59G0OGwhubbpA0XKM07nQxHqeb36sdxBLYlOZ6BHiDHFLZATLaU+SEqpE7WT+shbhfYxQsMek4lbp5mGTQFJWh57TKurSeNgOTFdq4zVlCcrsr97PtQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222128; c=relaxed/simple;
	bh=8wp0bxq0wYhL/0wa85k8/6SplZc48f56kgECh3Z3K/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MBAkFBzPGl9lniIGdCigAtX6dYPhGVE8nH14Tz0vIdQTKD/N2HFO8/fQ66wLbA8jKlD4j8+LSA6IAYNwZj+4sqMu1EiHNGtcG1E+Ncnuy8jhGQIxHxGb0IXeR2UD5rzmDHiiXJuVC0DYKHLfTaXE8d+NGy+EOuHdae6YJH3Gfyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iCqyRzqC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuvPn030378;
	Wed, 14 May 2025 11:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D8gzABo6YAy9R4A6tu7ooAeNOe0z3ihM3VJmlXXjoQI=; b=iCqyRzqClk1eduwB
	yyBKvDVT4WqhXS2MHXCL2waTiWtOyS1nEjk6/Ot2TkVkLeN/mg+0+udABi4NRzBu
	T4gczV9XA4Jun/lzUG6ZwZ+d1CCpc+zMu05Cwpa89eFZ7onGQ4jU0tDxUYgru0AZ
	gJ3r5+Rcom0JNZkqJSEu5HDkmcCeKo6YTfekHjkYCEiLN2cgl4egvqHCqAMaoiRk
	Gtl6JsG2XovTLHHAexxBIFXt/P9Gpyuf7gSrY9PTTB6MWjO3sZ7KUiM89Ip533g6
	mJdAme8E7+ZYZHb0SyciGgxQNorisWTtaAlt0yvVH8QDjM8fmiqkoNkwi8/DeFZk
	BB2+Lg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcntfu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:28:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EBSfCb015807
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:28:41 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 04:28:39 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Wed, 14 May 2025 16:58:22 +0530
Subject: [PATCH wireless-next 1/3] wifi: cfg80211: Add utility API to get
 radio index from channel
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250514-mlo-dfs-acs-v1-1-74e42a5583c6@quicinc.com>
References: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
In-Reply-To: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: viLX4-4o0ctbjNya2tWhcTJOgP4RVltt
X-Authority-Analysis: v=2.4 cv=D8dHKuRj c=1 sm=1 tr=0 ts=68247e69 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=QnIzrQ3vd9YidwGbO6EA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEwMSBTYWx0ZWRfX4Y6OjK3EXvnl
 MB+m/WkkkhKhQc+AFc9jhm7tRgF56wG+7JbhfII11PRJbyM+lUEMYqBpt/a9rRrnYmkWr/IGOCk
 0ixm4EXJZdZjCS5gbfAnSo85yP2OVDIGC0bx3uW14VsHjpEnAprQ8WkJ8hloGblXuNE76EEsKae
 DpaWuiVV6v1cPjJXllzKMY7xS/muDinN+Fmau5LJHJjJ/2XaPlN0IxThnyG5UfoX/AeYonB+VY7
 uYCddL6fHbuk+ahgn159Fx1t9hJIYjdCsLB0oeyNiChjRGPKA7HD1SEUq1/FxmeHXoakwdh5xiN
 VoLEj0hK+qsRlD0i3uiN6IPDeEbOMdD1M5xj9x0mzpxO77oTXlzo5RDUMLBBi9qkn5ykNMh+xcT
 wPyCKUxOlBDgG3yTUPCxi4TMSpby/eF5rUymCkF1RSAOy45eb3vbsYNP+Cn7E9Ttk5YnkWg8
X-Proofpoint-GUID: viLX4-4o0ctbjNya2tWhcTJOgP4RVltt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505140101

From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

Add utility API cfg80211_get_radio_idx_by_chan() to retrieve the radio
index corresponding to a given channel in a multi-radio wiphy.

This utility function can be used when we want to check the radio-specific
data for a channel in a multi-radio wiphy. For example, it can help
determine the radio index required to handle a scan request. This index
can then be used to decide whether the scan can proceed without
interfering with ongoing DFS operations on another radio.

Signed-off-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 include/net/cfg80211.h | 11 +++++++++++
 net/wireless/util.c    | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99df36592517b46d58223be9bee7e5..7719a90ab4d75045983ac8a63360fd90472cbb7d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9372,6 +9372,17 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 			       void (*iter)(const struct ieee80211_iface_combination *c,
 					    void *data),
 			       void *data);
+/**
+ * cfg80211_get_radio_idx_by_chan - get the radio index by the channel
+ *
+ * @wiphy: the wiphy
+ * @chan: channel for which the supported radio index is required
+ *
+ * Return: radio index on success or a negative error code
+ */
+int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
+				   const struct ieee80211_channel *chan);
+
 
 /**
  * cfg80211_stop_iface - trigger interface disconnection
diff --git a/net/wireless/util.c b/net/wireless/util.c
index ed868c0f7ca8ed7a9e85e70c10a738f592eac1d6..8ba1d0b268fc350064b2b8adcfeae121c3dcab70 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2516,6 +2516,30 @@ int cfg80211_check_combinations(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_check_combinations);
 
+int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
+				   const struct ieee80211_channel *chan)
+{
+	const struct wiphy_radio *radio;
+	int i, j;
+	u32 freq;
+
+	if (!chan)
+		return -EINVAL;
+
+	freq = ieee80211_channel_to_khz(chan);
+	for (i = 0; i < wiphy->n_radio; i++) {
+		radio = &wiphy->radio[i];
+		for (j = 0; j < radio->n_freq_range; j++) {
+			if (freq >= radio->freq_range[j].start_freq &&
+			    freq <= radio->freq_range[j].end_freq)
+				return i;
+		}
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL(cfg80211_get_radio_idx_by_chan);
+
 int ieee80211_get_ratemask(struct ieee80211_supported_band *sband,
 			   const u8 *rates, unsigned int n_rates,
 			   u32 *mask)

-- 
2.34.1


