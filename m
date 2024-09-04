Return-Path: <linux-wireless+bounces-12449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C75C96AEE6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 05:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7CA1C21355
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 03:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874DE43ABD;
	Wed,  4 Sep 2024 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SFnkLdHI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303D4A15
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725419389; cv=none; b=OLufq+Df2ae83imWn/1IDP17n7Q3I9/iyd3coIuz8l/A+3ZtQjb+h1wwhPcwxsMFLKJVliEYs0MhqzInymuNWpTGRkDUfVOLzPWgjo76zDHWk/OnkbN5njPRANTg8nLWKKEv72VgGXKyQf7HlF0aYPpiznKkXoGkYATWykyUJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725419389; c=relaxed/simple;
	bh=Bpo5D8yhuLErGxWhefw7Sc0AT7QkNNnQFUukAcP5Vpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kxnx6sxo7uH/dPVF6gQ3uis3+P092rauyamQncnzyH+U3mcpr5cWlOxHTUP7D13NucyzX19xENt+3OPLAqyC/Joset5dD1SMejEWqEcExJiTB0siWw6oAYg6fT1qepclIxGB+ucG8hwFKfZP9BGDLhQyBpTqBBGff22fePTcqV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SFnkLdHI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LhYcd004948;
	Wed, 4 Sep 2024 03:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qd6COx69rMLSUclMxr1gfz7ZXh3Ifr6P/JR/0vr7sm0=; b=SFnkLdHIQHtzBc14
	9fWOcfABEi/6zt9pzbsYG1n7S0OVQjMwmAqbibgQalvVohk1rBpLRdLVmNBt4mQy
	yqy37utnXuSDaMsLR2AH/cizCCLoLWms/yrWVq3rT8fT3mZzHC9SyKRg4I45x1DN
	d6A684+SfjQi4+S8dAwVMmmyg7akU6fwBMkzIsAZQlGnr8rOlxqDaFEJ9pYUEZqH
	brupjt6Q3djgdwPmAWmZJa6LKIm1Bl2UB8AfYvGbWTJ9YFEp7WmHJyp6gDkiQxP4
	gqmv6/9/aZ5GlKfFG6jMCPVT67UTGi/n1WhgfA0b/0tzLNY62lG7b1JDgUC9540q
	haUe8g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41drqe3msm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 03:09:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48439fQo030156
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 03:09:41 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Sep 2024 20:09:39 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 3/3] wifi: cfg80211: avoid overriding direct/MBSSID BSS with per-STA profile BSS
Date: Wed, 4 Sep 2024 08:39:17 +0530
Message-ID: <20240904030917.3602369-4-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904030917.3602369-1-quic_vjakkam@quicinc.com>
References: <20240904030917.3602369-1-quic_vjakkam@quicinc.com>
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
X-Proofpoint-GUID: N3ZKrQmPcJSjmxPa8zCZAVltD7elxxxp
X-Proofpoint-ORIG-GUID: N3ZKrQmPcJSjmxPa8zCZAVltD7elxxxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 spamscore=0 mlxlogscore=714 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409040021

Avoid overriding BSS information generated from MBSSID or direct source
with BSS information generated from per-STA profile source to avoid
losing actual signal strength and information elements such as RNR and
Basic ML elements.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/scan.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index f280e0371d6d..eab12dc67a51 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2905,6 +2905,9 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 	struct element *reporter_rnr = NULL;
 	struct ieee80211_multi_link_elem *ml_elem;
 	struct cfg80211_mle *mle;
+	const struct element *ssid_elem;
+	const u8 *ssid = NULL;
+	size_t ssid_len = 0;
 	u16 control;
 	u8 ml_common_len;
 	u8 *new_ie = NULL;
@@ -2959,6 +2962,13 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 						 bss_change_count,
 						 gfp);
 
+	ssid_elem = cfg80211_find_elem(WLAN_EID_SSID, tx_data->ie,
+				       tx_data->ielen);
+	if (ssid_elem) {
+		ssid = ssid_elem->data;
+		ssid_len = ssid_elem->datalen;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(mle->sta_prof) && mle->sta_prof[i]; i++) {
 		const struct ieee80211_neighbor_ap_info *ap_info;
 		enum nl80211_band band;
@@ -3040,6 +3050,23 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 		freq = ieee80211_channel_to_freq_khz(ap_info->channel, band);
 		data.channel = ieee80211_get_channel_khz(wiphy, freq);
 
+		/* Skip if BSS entry generated from MBSSID or DIRECT source
+		 * frame data available already.
+		 */
+		bss = cfg80211_get_bss(wiphy, data.channel, data.bssid, ssid,
+				       ssid_len, IEEE80211_BSS_TYPE_ANY,
+				       IEEE80211_PRIVACY_ANY);
+		if (bss) {
+			struct cfg80211_internal_bss *ibss = bss_from_pub(bss);
+
+			if (data.capability == bss->capability &&
+			    ibss->bss_source != BSS_SOURCE_STA_PROFILE) {
+				cfg80211_put_bss(wiphy, bss);
+				continue;
+			}
+			cfg80211_put_bss(wiphy, bss);
+		}
+
 		if (use_for == NL80211_BSS_USE_FOR_MLD_LINK &&
 		    !(wiphy->flags & WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY)) {
 			use_for = 0;
-- 
2.34.1


