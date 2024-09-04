Return-Path: <linux-wireless+bounces-12448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A245596AEE5
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 05:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D03228645B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 03:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC14317B;
	Wed,  4 Sep 2024 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZSYt13Ad"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED14A15
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725419386; cv=none; b=j/sK/UHlHruaslciVHNe5lCkcniR2P1FBvwy1Fm9o7I/vW5yn/+mubWTCLhtsNHfSauYTXHzpFOUHLXsxZ9wKEDkNVQGTTL2fPwlAZcLCcqZ8Sg3N1rC6Uur+n8JTvqwFdZXWK4fDRKEEHNpH8dhwPnKU6mjH1hePvCO+b5lDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725419386; c=relaxed/simple;
	bh=tLcINo1KPGcFLv6SnWBACwWKl480mQ5Hr6BLft03E8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7OOId7mAh0h5ZjO6z0MWKZ5aA3prWfraV4yapmzykWb8hEmKE54FSUKgzY/wAnESYxopuOZm7aqLKc26AAMPKZFlCuUvM1HJ2lAJppJNWCEx+VUo28/5PDDTiYLIZyapMJxUYguyZ4BWCf9VUdMu0LLo4FsnbLEXDumvj31heI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZSYt13Ad; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LabEu013131;
	Wed, 4 Sep 2024 03:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oDM3xnrMoyVJa9F912W2DjnglyjxMPXZzVh2mK//z+M=; b=ZSYt13Ad+Yo5KZrs
	2RaPIR6f/pBf4SX5IOX7TpVS+3lm2pVE0w9UfKEkvp7GMQo8kzMm8TqCWSsL+Jag
	UAUe9TM9oOwBCYb6Yzwb4d4Aa5QwpwKYRFnq7Pnnim3wYZbLzxxJgi/tMMqfdriP
	oUsTTQVa3RXVARoUBkw4OQ4tcWWeGLkgL1+Uxm8tPsl+25FSyPOkVC/DY9VnvckZ
	Jjqq1+EM4n/Cjnqr2jRKQtwDWCpfHlXnLFW9kU0ITMWbwf0+EE0mj4a1OsL3P6sV
	4B/OkTrnYnzsGP676STDZCyCVJptCp8Ch116sxgEpBTNQoqkv7d6eKxe5pa5M4U0
	raIczw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41btrxsc03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 03:09:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48439deF006076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 03:09:39 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Sep 2024 20:09:37 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 2/3] wifi: cfg80211: skip indicating signal for per-STA profile BSSs
Date: Wed, 4 Sep 2024 08:39:16 +0530
Message-ID: <20240904030917.3602369-3-quic_vjakkam@quicinc.com>
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
X-Proofpoint-GUID: tPVOaBrLf5CVJdG1_7PfEbNC4GEL8RNV
X-Proofpoint-ORIG-GUID: tPVOaBrLf5CVJdG1_7PfEbNC4GEL8RNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409040021

Currently signal of the BSS entry generated from the per-STA profile
indicated as zero, but userspace may consider it as high signal
strength since 0 dBm is a valid RSSI value.

To avoid this don't report the signal to userspace when the BSS entry
created from a per-STA profile.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/core.h    |  2 ++
 net/wireless/nl80211.c | 26 +++++++++++++++-----------
 net/wireless/scan.c    |  2 ++
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index eace1800f5de..3b3e3cd7027a 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -197,6 +197,8 @@ struct cfg80211_internal_bss {
 	 */
 	u8 parent_bssid[ETH_ALEN] __aligned(2);
 
+	enum bss_source_type bss_source;
+
 	/* must be last because of priv member */
 	struct cfg80211_bss pub;
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b368e23847dd..3a11a1a74a54 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10507,17 +10507,21 @@ static int nl80211_send_bss(struct sk_buff *msg, struct netlink_callback *cb,
 				NL80211_BSS_CHAIN_SIGNAL))
 		goto nla_put_failure;
 
-	switch (rdev->wiphy.signal_type) {
-	case CFG80211_SIGNAL_TYPE_MBM:
-		if (nla_put_u32(msg, NL80211_BSS_SIGNAL_MBM, res->signal))
-			goto nla_put_failure;
-		break;
-	case CFG80211_SIGNAL_TYPE_UNSPEC:
-		if (nla_put_u8(msg, NL80211_BSS_SIGNAL_UNSPEC, res->signal))
-			goto nla_put_failure;
-		break;
-	default:
-		break;
+	if (intbss->bss_source != BSS_SOURCE_STA_PROFILE) {
+		switch (rdev->wiphy.signal_type) {
+		case CFG80211_SIGNAL_TYPE_MBM:
+			if (nla_put_u32(msg, NL80211_BSS_SIGNAL_MBM,
+					res->signal))
+				goto nla_put_failure;
+			break;
+		case CFG80211_SIGNAL_TYPE_UNSPEC:
+			if (nla_put_u8(msg, NL80211_BSS_SIGNAL_UNSPEC,
+				       res->signal))
+				goto nla_put_failure;
+			break;
+		default:
+			break;
+		}
 	}
 
 	switch (wdev->iftype) {
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 38541eba386c..f280e0371d6d 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1910,6 +1910,7 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 	known->pub.bssid_index = new->pub.bssid_index;
 	known->pub.use_for &= new->pub.use_for;
 	known->pub.cannot_use_reasons = new->pub.cannot_use_reasons;
+	known->bss_source = new->bss_source;
 
 	return true;
 }
@@ -2264,6 +2265,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	       IEEE80211_MAX_CHAINS);
 	tmp.pub.use_for = data->use_for;
 	tmp.pub.cannot_use_reasons = data->cannot_use_reasons;
+	tmp.bss_source = data->bss_source;
 
 	switch (data->bss_source) {
 	case BSS_SOURCE_MBSSID:
-- 
2.34.1


