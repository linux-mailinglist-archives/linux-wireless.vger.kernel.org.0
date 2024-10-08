Return-Path: <linux-wireless+bounces-13680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3077C993E2F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 07:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA50D1F21F64
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 05:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29EF13AA3E;
	Tue,  8 Oct 2024 05:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YjR6B5im"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5725779
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 05:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728363992; cv=none; b=YwFtz9y9+FHhXS05kxSYYSdiJfLnzwQ2HMrLP3JyPNGWGA+htmrfZ1ir4JW8Q9KVcuMt1uF0weHPRFNXSuOw5F4f1bz0LYf0tzUah+ZpXMjRNlB0c2/GDPSKuSQd2QteBIK0P9mnEPBvYMxd5sckLtSvkOvMbpOZaJ1vyBUUSgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728363992; c=relaxed/simple;
	bh=KfdIoxGhJgRHdPSlQyAgkGYHMuyFPGbwMWHJaUPR5Pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VE3UmkcbXFzfdUyUGjwPJ1nSZD3Jg8dXz7xspt0aMGHCv8TFXYDGcTruJHO0Av9NZSbMqu5JJdHfHb02uNXR1izCwwvvRB3VFKHHNeBOnHEHtW3ZSeDZoodhCSYoFRRJ4XFa7kTx90oKCIO0922cTNuNwlHxUMWXflSogCpkRfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YjR6B5im; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FQiqm027163;
	Tue, 8 Oct 2024 05:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	njglCsC1/bQYL/xu1n/chnctptnyq73iUuzQcbOXd/U=; b=YjR6B5imJxBYHM/M
	SJPyWesMGHnwYtNct45CrTagFnRrt320L4yauk0kD06nYdcGKQ2bRtPFziM2vkum
	7J2upQBYGCi9p3Oh7f0Q4mLBa6jECgDhaMVwecMKQf5oKvhIkM9/bSVqTh4TuSBM
	c1RhdOzUJtZyi371WEshtcG1z4Fc20m/PdIumylMyKJC8RpRtShidSpqtiMssh2h
	OXz/aO9OJilncLfi7Es3xCwGnPT4RcPmOdRpl2koMB8TKWJQ+xBlfrfIoVsJuI2S
	2n8+lSvQKBi4MLpEMn+OAYX24T6OELwG2ojl1SPY7pgGOZ8UPiD1mI2EamipATt9
	7keYgw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xq9x742-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 05:06:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49856OlA014199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 05:06:25 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Oct 2024 22:06:23 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 1/2] update nl80211.h
Date: Tue, 8 Oct 2024 10:36:06 +0530
Message-ID: <20241008050607.1113396-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008050607.1113396-1-quic_adisi@quicinc.com>
References: <20241008050607.1113396-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: jhHG-5xtT3kVShXgAJlYyy27Hdbr_I_C
X-Proofpoint-GUID: jhHG-5xtT3kVShXgAJlYyy27Hdbr_I_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=734
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080031

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 nl80211.h | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/nl80211.h b/nl80211.h
index 6ae3997061b6..f97f5adc8d51 100644
--- a/nl80211.h
+++ b/nl80211.h
@@ -2052,6 +2052,10 @@ enum nl80211_commands {
  * @NL80211_ATTR_INTERFACE_COMBINATIONS: Nested attribute listing the supported
  *	interface combinations. In each nested item, it contains attributes
  *	defined in &enum nl80211_if_combination_attrs.
+ *	If the wiphy uses multiple radios (@NL80211_ATTR_WIPHY_RADIOS is set),
+ *	this attribute contains the interface combinations of the first radio.
+ *	See @NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS for the global wiphy
+ *	combinations for the sum of all radios.
  * @NL80211_ATTR_SOFTWARE_IFTYPES: Nested attribute (just like
  *	%NL80211_ATTR_SUPPORTED_IFTYPES) containing the interface types that
  *	are managed in software: interfaces of these types aren't subject to
@@ -2856,6 +2860,14 @@ enum nl80211_commands {
  *	%NL80211_CMD_ASSOCIATE indicating the SPP A-MSDUs
  *	are used on this connection
  *
+ * @NL80211_ATTR_WIPHY_RADIOS: Nested attribute describing physical radios
+ *	belonging to this wiphy. See &enum nl80211_wiphy_radio_attrs.
+ *
+ * @NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS: Nested attribute listing the
+ *	supported interface combinations for all radios combined. In each
+ *	nested item, it contains attributes defined in
+ *	&enum nl80211_if_combination_attrs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3401,6 +3413,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_SPP_AMSDU,
 
+	NL80211_ATTR_WIPHY_RADIOS,
+	NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -8005,4 +8020,54 @@ enum nl80211_ap_settings_flags {
 	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
 };
 
+/**
+ * enum nl80211_wiphy_radio_attrs - wiphy radio attributes
+ *
+ * @__NL80211_WIPHY_RADIO_ATTR_INVALID: Invalid
+ *
+ * @NL80211_WIPHY_RADIO_ATTR_INDEX: Index of this radio (u32)
+ * @NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE: Frequency range supported by this
+ *	radio. Attribute may be present multiple times.
+ * @NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION: Supported interface
+ *	combination for this radio. Attribute may be present multiple times
+ *	and contains attributes defined in &enum nl80211_if_combination_attrs.
+ *
+ * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
+ * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
+ */
+enum nl80211_wiphy_radio_attrs {
+	__NL80211_WIPHY_RADIO_ATTR_INVALID,
+
+	NL80211_WIPHY_RADIO_ATTR_INDEX,
+	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE,
+	NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION,
+
+	/* keep last */
+	__NL80211_WIPHY_RADIO_ATTR_LAST,
+	NL80211_WIPHY_RADIO_ATTR_MAX = __NL80211_WIPHY_RADIO_ATTR_LAST - 1,
+};
+
+/**
+ * enum nl80211_wiphy_radio_freq_range - wiphy radio frequency range
+ *
+ * @__NL80211_WIPHY_RADIO_FREQ_ATTR_INVALID: Invalid
+ *
+ * @NL80211_WIPHY_RADIO_FREQ_ATTR_START: Frequency range start (u32).
+ *	The unit is kHz.
+ * @NL80211_WIPHY_RADIO_FREQ_ATTR_END: Frequency range end (u32).
+ *	The unit is kHz.
+ *
+ * @__NL80211_WIPHY_RADIO_FREQ_ATTR_LAST: Internal
+ * @NL80211_WIPHY_RADIO_FREQ_ATTR_MAX: Highest attribute
+ */
+enum nl80211_wiphy_radio_freq_range {
+	__NL80211_WIPHY_RADIO_FREQ_ATTR_INVALID,
+
+	NL80211_WIPHY_RADIO_FREQ_ATTR_START,
+	NL80211_WIPHY_RADIO_FREQ_ATTR_END,
+
+	__NL80211_WIPHY_RADIO_FREQ_ATTR_LAST,
+	NL80211_WIPHY_RADIO_FREQ_ATTR_MAX = __NL80211_WIPHY_RADIO_FREQ_ATTR_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
-- 
2.34.1


