Return-Path: <linux-wireless+bounces-5434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD3E88F8B6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE9D1C29784
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22812524BD;
	Thu, 28 Mar 2024 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DGTa5dxm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A5524AD
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611006; cv=none; b=k0M9fHUnPq300xUiP5Ml/g3bLlmAjYFQGWCZKmb2YA2Ul3xcbNCQe/x+hpruhppi96zp7ukrQzkPy5usKsP2srkVHoC43i0MUZbSGaUy3pp95eSbdQq6qYi84Wif3BlSYjSoJeo0xsgy3OAXuxgDILGOKLJ003lq2OePYy5RpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611006; c=relaxed/simple;
	bh=wgLANPldKFWvjWWSx8MEt+dxjQf79YYovr/AVlx5E54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSSyG78C/yFTzEiG8Z7EkGBQh6kNSqrwrWryieLzj15Soi/XUShf08v4T5P/cn33lgjr1vpyadqmVqr3NE9AIUwEqvYfhZbClzeWp5uFN1XYYuMNwPdj2Cpgcg06f6/XTnSHpZReqwv1l6nXpLa04BRJIKxc5CpA5mdUUjpqzdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DGTa5dxm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S5Rmas031006;
	Thu, 28 Mar 2024 07:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=DxCSHKc0iSM7IkMD1RtvUkbD5Fho5ZLQQsfV5vV2cjU=; b=DG
	Ta5dxmNXDfXPP29jxEbMxIFLXN7bV9xNd7FMXVrNXhNZsTZVSbsbhfiyPrjExCoE
	tXXIL9BWhIpbwhJ5/SQxJlnrfxxUt8e2UWktikC48Jw27Lkxjbey3MtrYx/DONfW
	XK6zTuMbB49Q2cogJqyVBiIbwkH/89G5ZhWOnGOd+XniIc608D87dxt0XuLAMk7b
	hRf/ujD4EcJPw2gMJhcOcyUPBmAAMzf5uhIWJHBz8GY82zYZRwwKZ6D+aVBQzwkx
	xJOu12L893Pd24RcdySNwpTxVEbfSHu28WpE6tJG3bG07t7repa5JGZGXFXlNWea
	dRL6F2Pqo2lzSMgRQCEQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u20jcxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:29:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7To87003640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:29:50 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:29:48 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 03/13] wifi: cfg80211: Refactor the interface combination limit check
Date: Thu, 28 Mar 2024 12:59:06 +0530
Message-ID: <20240328072916.1164195-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Xn_imFvkmRJfKzvmRH7H_p4a_ZcTO1xl
X-Proofpoint-GUID: Xn_imFvkmRJfKzvmRH7H_p4a_ZcTO1xl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=970 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280048

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

Move the interface combination limit check validation into a helper
function. This will make the iface combination limit validation
functionality more scalable for supporting multiple physical hardware
interface combination.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 net/wireless/core.c | 114 +++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 49 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 119937d0f2e0..2b810855a805 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -600,10 +600,69 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 }
 EXPORT_SYMBOL(wiphy_new_nm);
 
+static int
+wiphy_verify_comb_limit(struct wiphy *wiphy,
+			const struct ieee80211_iface_limit *limits,
+			u8 n_limits, u32 bcn_int_min_gcd, u32 *iface_cnt,
+			u16 *all_iftypes)
+{
+	int i;
+
+	for (i = 0; i < n_limits; i++) {
+		u16 types = limits[i].types;
+
+		/* Don't advertise an unsupported type
+		 * in a combination.
+		 */
+		if (WARN_ON((wiphy->interface_modes & types) != types))
+			return -EINVAL;
+
+		if (WARN_ON(!limits[i].max))
+			return -EINVAL;
+
+		/* interface types shouldn't overlap */
+		if (WARN_ON(types & *all_iftypes))
+			return -EINVAL;
+
+		*all_iftypes |= types;
+
+		/* Shouldn't list software iftypes in combinations! */
+		if (WARN_ON(wiphy->software_iftypes & types))
+			return -EINVAL;
+
+		/* Only a single P2P_DEVICE can be allowed */
+		if (WARN_ON(types & BIT(NL80211_IFTYPE_P2P_DEVICE) &&
+			    limits[i].max > 1))
+			return -EINVAL;
+
+		/* Only a single NAN can be allowed */
+		if (WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
+			    limits[i].max > 1))
+			return -EINVAL;
+
+		/* This isn't well-defined right now. If you have an
+		 * IBSS interface, then its beacon interval may change
+		 * by joining other networks, and nothing prevents it
+		 * from doing that.
+		 * So technically we probably shouldn't even allow AP
+		 * and IBSS in the same interface, but it seems that
+		 * some drivers support that, possibly only with fixed
+		 * beacon intervals for IBSS.
+		 */
+		if (WARN_ON(types & BIT(NL80211_IFTYPE_ADHOC) &&
+			    bcn_int_min_gcd))
+			return -EINVAL;
+
+		*iface_cnt += limits[i].max;
+	}
+
+	return 0;
+}
+
 static int wiphy_verify_combinations(struct wiphy *wiphy)
 {
 	const struct ieee80211_iface_combination *c;
-	int i, j;
+	int i, ret;
 
 	for (i = 0; i < wiphy->n_iface_combinations; i++) {
 		u32 cnt = 0;
@@ -630,54 +689,11 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 		if (WARN_ON(!c->n_limits))
 			return -EINVAL;
 
-		for (j = 0; j < c->n_limits; j++) {
-			u16 types = c->limits[j].types;
-
-			/* interface types shouldn't overlap */
-			if (WARN_ON(types & all_iftypes))
-				return -EINVAL;
-			all_iftypes |= types;
-
-			if (WARN_ON(!c->limits[j].max))
-				return -EINVAL;
-
-			/* Shouldn't list software iftypes in combinations! */
-			if (WARN_ON(wiphy->software_iftypes & types))
-				return -EINVAL;
-
-			/* Only a single P2P_DEVICE can be allowed */
-			if (WARN_ON(types & BIT(NL80211_IFTYPE_P2P_DEVICE) &&
-				    c->limits[j].max > 1))
-				return -EINVAL;
-
-			/* Only a single NAN can be allowed */
-			if (WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
-				    c->limits[j].max > 1))
-				return -EINVAL;
-
-			/*
-			 * This isn't well-defined right now. If you have an
-			 * IBSS interface, then its beacon interval may change
-			 * by joining other networks, and nothing prevents it
-			 * from doing that.
-			 * So technically we probably shouldn't even allow AP
-			 * and IBSS in the same interface, but it seems that
-			 * some drivers support that, possibly only with fixed
-			 * beacon intervals for IBSS.
-			 */
-			if (WARN_ON(types & BIT(NL80211_IFTYPE_ADHOC) &&
-				    c->beacon_int_min_gcd)) {
-				return -EINVAL;
-			}
-
-			cnt += c->limits[j].max;
-			/*
-			 * Don't advertise an unsupported type
-			 * in a combination.
-			 */
-			if (WARN_ON((wiphy->interface_modes & types) != types))
-				return -EINVAL;
-		}
+		ret = wiphy_verify_comb_limit(wiphy, c->limits, c->n_limits,
+					      c->beacon_int_min_gcd,
+					      &cnt, &all_iftypes);
+		if (ret)
+			return ret;
 
 		if (WARN_ON(all_iftypes & BIT(NL80211_IFTYPE_WDS)))
 			return -EINVAL;
-- 
2.34.1


