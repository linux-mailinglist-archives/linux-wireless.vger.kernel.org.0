Return-Path: <linux-wireless+bounces-12917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8078F97B105
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 16:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE182B20F0F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9571EB35;
	Tue, 17 Sep 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DuKuiezz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249203C08A
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726581794; cv=none; b=pt8+2Koe1Am+7u2h8f0hAl1qi9fJc16cz0QaWk2qkv9/wrvPmFLStak0ng9mdrdcJVQyr7o1/Qx1fMrbkNVIy5Jfa9fbolTCAw5SxFJ6khw/l9ygY+zuFdnV2Xw3gV1QqLqLArwbHZKIYbsmNezTzhMCwMml4wXXpCwTnAN+pOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726581794; c=relaxed/simple;
	bh=w2qiki+KS17IZGgUQhn465vtUfT4Z8xWJXIBo0aIqJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XYcvVTsX4lnurduvvs2+Yh63WPCSWvcYA8/CAEdN6gIq3wIJiGOfS80xkNVRfpPnGrxOXQK9GfWkMUxT+kXPWz5fdCSC3rwIYxTlJ0Ql7qVfKkVGifgxnRpbp3WAOj+/262ujE2foPPYY5cO1SY6IxV74PYXq0RUep6qrHJt0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DuKuiezz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H6O4SW001584;
	Tue, 17 Sep 2024 14:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eCPdUtE+GaOhqtMY+ZqvQL
	DuS45UG8EiZaXEOQv4NRw=; b=DuKuiezzIQCsf/p+NmKZna09UGz0NJYO71w1za
	LtEhSrfE1sNXm5z4rqgelcv6ErukRc/e97LPWmSpVMs2rmeGLhl9I+sXnhFTlLmF
	P2EOLYOLy8e/bg3pxZJxLVDtLoGcWPzFqDjuZU5enLYI/KFWH7RwCaMG6vwH8+Vc
	0gEaiGNwepKyE7q3fEo406q3ViBOjninun/3/wHWW7DmM510Zcc2VTYTtLUDcvUW
	LbPXUubnKiYxCcLgK2Bb9hCTyZw5861BUBX1Rg3DiTitDHhwL0s7hZlyb0qNKPLx
	vxhbcv3kV8x1/ZEgIIAlEMeYljLgjHQJdNJTfr1elb+o8/iA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4hexxhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 14:03:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48HE2rtu027776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 14:02:53 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Sep 2024 07:02:51 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <johannes@sipsolutions.net>, <nbd@nbd.name>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v4] wifi: cfg80211: check radio iface combination for multi radio per wiphy
Date: Tue, 17 Sep 2024 19:32:39 +0530
Message-ID: <20240917140239.886083-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: XorN4w9BwzCBsGxQ8ujosMTl2MusrLQd
X-Proofpoint-GUID: XorN4w9BwzCBsGxQ8ujosMTl2MusrLQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170100

Currently, wiphy_verify_combinations() fails for the multi-radio per wiphy
due to the condition check on new global interface combination that DFS
only works on one channel. In a multi-radio scenario, new global interface
combination encompasses the capabilities of all radio combinations, so it
supports more than one channel with DFS. For multi-radio per wiphy,
interface combination verification needs to be performed for radio specific
interface combinations. This is necessary as the new global interface
combination combines the capabilities of all radio combinations.

Fixes: a01b1e9f9955 ("wifi: mac80211: add support for DFS with multiple radios")
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 v4:
  - Added comments about new global iface combination
  - Updated the commit message
 v3:
  - Add validation check for global combination where all radios combined
 v2:
  - Rebased to ToT

 net/wireless/core.c | 64 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 661adfc77644..4c8d8f167409 100644
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
@@ -625,9 +629,13 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 		if (WARN_ON(!c->num_different_channels))
 			return -EINVAL;
 
-		/* DFS only works on one channel. */
-		if (WARN_ON(c->radar_detect_widths &&
-			    (c->num_different_channels > 1)))
+		/* DFS only works on one channel. Avoid this check
+		 * for multi-radio global combination, since it hold
+		 * the capabilities of all radio combinations.
+		 */
+		if (!combined_radio &&
+		    WARN_ON(c->radar_detect_widths &&
+			    c->num_different_channels > 1))
 			return -EINVAL;
 
 		if (WARN_ON(!c->n_limits))
@@ -648,13 +656,21 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 			if (WARN_ON(wiphy->software_iftypes & types))
 				return -EINVAL;
 
-			/* Only a single P2P_DEVICE can be allowed */
-			if (WARN_ON(types & BIT(NL80211_IFTYPE_P2P_DEVICE) &&
+			/* Only a single P2P_DEVICE can be allowed, avoid this
+			 * check for multi-radio global combination, since it
+			 * hold the capabilities of all radio combinations.
+			 */
+			if (!combined_radio &&
+			    WARN_ON(types & BIT(NL80211_IFTYPE_P2P_DEVICE) &&
 				    c->limits[j].max > 1))
 				return -EINVAL;
 
-			/* Only a single NAN can be allowed */
-			if (WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
+			/* Only a single NAN can be allowed, avoid this
+			 * check for multi-radio global combination, since it
+			 * hold the capabilities of all radio combinations.
+			 */
+			if (!combined_radio &&
+			    WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
 				    c->limits[j].max > 1))
 				return -EINVAL;
 
@@ -693,6 +709,34 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
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


