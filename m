Return-Path: <linux-wireless+bounces-12477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEF796BAB3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 13:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57A3B23523
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8B1D0176;
	Wed,  4 Sep 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dno+YtYG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4A1D0497
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449393; cv=none; b=sktXcs5WqMbvza3k7NculV4cEQgz/OlyoCy3oIMh9g039ib+24UVyPrMRpj+J2UnoFgEs4T1xkSNvyTLThzGFkODqvzNyTbq73pzjZVuWAutDC31n1qHeHH2lBzstnorFvORawEEo0N551WNxs4YBltNjivo5Paw0D/4Sn4VvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449393; c=relaxed/simple;
	bh=+6jfCzPXV7VV1jM/skWwyH9DdIdeQf2TxcSuQ0a5ijI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gaKek9SyIgAPb2ZikS8hsPbdmfUUgYtXKVQZnn75KD4DzvBQZP4cwufz/3ke7snOUMwP9I4xm3fLVKAbNF42E1aiuB0m100EysK8diZlUXctIL2IFnvAoVI4otjHh7LKXT1KZKwjo+YmR4IXQAuPT/eo7bRgCqES4VWA5SPeAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dno+YtYG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849ueLf006327;
	Wed, 4 Sep 2024 11:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0oG3SqxALcrbyyh0I8WhJ+
	h1ba2PcfDInKkn1bKw1Rg=; b=Dno+YtYGBbJPuTNlTnvqI183d62nPnmW9xbWTH
	LOCJ2sOOxVUR9hX5qDNJVtIR5nEbTqevwy4/TJdAoTxr2f/0Okfrg+JoIl0NQqKd
	phHRI59UevRLz7alNaR1qvXuIGCPnMS1YoDcbH/0s8PHQZfaUK0SnAzhPCxNf72b
	rqkZKJ4QfiiuBnZ0Rh8qqGqZhdXkYDsGBlxsuEE8iZHkpVTakJ83m63nZ3iCZb46
	tHALcJisT6gZyjP3KNHhHTGq5pQ96MKwe572C5KH9A9YxKd2Gi87/7hua0GJyq5W
	715UKghV+WjP38OSDPw2JOibFvilOg+6JXAsxYYO9XCpkIWg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41enbwg8fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 11:29:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484BTkKp003636
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 11:29:46 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 04:29:44 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3] wifi: cfg80211: check radio iface combination for multi radio per wiphy
Date: Wed, 4 Sep 2024 16:59:28 +0530
Message-ID: <20240904112928.2924508-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: nzRdTQUzBxY9nLi00-dd0AyLtjqrXrb_
X-Proofpoint-GUID: nzRdTQUzBxY9nLi00-dd0AyLtjqrXrb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_09,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=919 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040087

Currently, wiphy_verify_combinations() fails for the multi-radio per wiphy
due to the condition check on global interface combination that DFS only
works on one channel. In a multi-radio scenario, global interface
combination encompasses the capabilities of all radio combinations, so it
supports more than one channel with DFS. For multi-radio per wiphy,
interface combination verification needs to be performed for radio specific
interface combinations. This is necessary as the global interface
combination combines the capabilities of all radio combinations.

Fixes: a01b1e9f9955 ("wifi: mac80211: add support for DFS with multiple radios")
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 v3:
  - Add validation check for global combination where all radios combined
 v2:
  - Rebased to ToT

 net/wireless/core.c | 49 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4d5d351bd0b5..45b00b0322dc 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -603,16 +603,20 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 }
 EXPORT_SYMBOL(wiphy_new_nm);
 
-static int wiphy_verify_combinations(struct wiphy *wiphy)
+static
+int wiphy_verify_iface_combinations(struct wiphy *wiphy,
+				    const struct ieee80211_iface_combination *iface_comb,
+				    int n_iface_comb,
+				    bool combined_radio)
 {
 	const struct ieee80211_iface_combination *c;
 	int i, j;
 
-	for (i = 0; i < wiphy->n_iface_combinations; i++) {
+	for (i = 0; i < n_iface_comb; i++) {
 		u32 cnt = 0;
 		u16 all_iftypes = 0;
 
-		c = &wiphy->iface_combinations[i];
+		c = &iface_comb[i];
 
 		/*
 		 * Combinations with just one interface aren't real,
@@ -626,8 +630,9 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 			return -EINVAL;
 
 		/* DFS only works on one channel. */
-		if (WARN_ON(c->radar_detect_widths &&
-			    (c->num_different_channels > 1)))
+		if (!combined_radio &&
+		    WARN_ON(c->radar_detect_widths &&
+			    c->num_different_channels > 1))
 			return -EINVAL;
 
 		if (WARN_ON(!c->n_limits))
@@ -649,12 +654,14 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 				return -EINVAL;
 
 			/* Only a single P2P_DEVICE can be allowed */
-			if (WARN_ON(types & BIT(NL80211_IFTYPE_P2P_DEVICE) &&
+			if (!combined_radio &&
+			    WARN_ON(types & BIT(NL80211_IFTYPE_P2P_DEVICE) &&
 				    c->limits[j].max > 1))
 				return -EINVAL;
 
 			/* Only a single NAN can be allowed */
-			if (WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
+			if (!combined_radio &&
+			    WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
 				    c->limits[j].max > 1))
 				return -EINVAL;
 
@@ -693,6 +700,34 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 	return 0;
 }
 
+static int wiphy_verify_combinations(struct wiphy *wiphy)
+{
+	int i, ret;
+	bool combined_radio = false;
+
+	if (wiphy->n_radio) {
+		for (i = 0; i < wiphy->n_radio; i++) {
+			const struct wiphy_radio *radio = &wiphy->radio[i];
+
+			ret = wiphy_verify_iface_combinations(wiphy,
+							      radio->iface_combinations,
+							      radio->n_iface_combinations,
+							      false);
+			if (ret)
+				return ret;
+		}
+
+		combined_radio = true;
+	}
+
+	ret = wiphy_verify_iface_combinations(wiphy,
+					      wiphy->iface_combinations,
+					      wiphy->n_iface_combinations,
+					      combined_radio);
+
+	return ret;
+}
+
 int wiphy_register(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
-- 
2.34.1


