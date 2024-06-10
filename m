Return-Path: <linux-wireless+bounces-8748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9F5901D4D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 10:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C95B1C2112B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC34971753;
	Mon, 10 Jun 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hz/PpEcC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207456F2FA
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009554; cv=none; b=D0Exfy7Pjy+xCZ11z6E8jF+SCJH79SQ+QF9zi0mKPJ2wM+tbUinWTduNb0jhM5yb9DuVPZ5u8+R1w3TzPOx6UOE+xfeub43usYXG/CG/WCCz+NstlyMQOck+cix5f/1Z8LIJ/JHPeWv4E7uV1vMEeSW0sOuxI0tVpPUAuCoTRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009554; c=relaxed/simple;
	bh=bv82AK/TSwhf0dZo8VIDFGtc/80T1hRuP/nK89sGS1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLeKjJDd9R2UQMLI1g1TZp90rivzMFpOlBwVoNTzCWb4VIbAzRSSpy8YAt2On2MVl2gZ7C9xTnJ8zBgOVUPxWNJohH4DS0SWEWv/tCPe4tydIj/80o5SDUPmygvb8C8PmXRi8jxHbMZChjDIx5daTpNX3E4icFBxnYxj31Fsf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hz/PpEcC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A0WKUT023208;
	Mon, 10 Jun 2024 08:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BpRzBf3DVLlS1zeEpZwpWni7
	y4VPIeIi4vsDdkJyb8U=; b=hz/PpEcC5TNxeHDHOlNBk65arV3LhqYMHVguEaY3
	xhxpqC6rvLIl+4Rjpr2wSvmlY/c5RR9y53xXXsSk1A9C2Dn2oiKF3XVW9d9OBOpm
	wiWmfKUJN637TMH3dLFG/WlpjtM89Fo8DiOd7m0zbZISL9YV3PVyDz76d0q4UPRc
	faxVkPUcLe9rYyVYGkKc28fvglB2N1Vorgu/Iavi8TgvndxHjb9KorxWbP1NNcjL
	JDTIgCu1yDSrYzF9exZ7RAhmETE4ks7gjA7OAbIuW67vghg3Iddd/v9aDwBzoxYd
	M1xbQj/tMAQ2oTMQuKZt7etzXmtEQ1du/fehoDueqPR7LQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfcv2yd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 08:52:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45A8qRQu029453
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 08:52:27 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Jun 2024 01:52:24 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH 2/4] wifi: cfg80211: skip indicating signal for per-STA profile BSSs
Date: Mon, 10 Jun 2024 14:22:02 +0530
Message-ID: <1718009524-5579-3-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZIvkvj7hYQbeXRgcAn-6kFwco2BdgBBx
X-Proofpoint-GUID: ZIvkvj7hYQbeXRgcAn-6kFwco2BdgBBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100067

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
index a48df7cf..4281f85 100644
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
index 8ff5f79..c0a8b35 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10373,17 +10373,21 @@ static int nl80211_send_bss(struct sk_buff *msg, struct netlink_callback *cb,
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
index 1fad019..2850718 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1866,6 +1866,7 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 	known->pub.bssid_index = new->pub.bssid_index;
 	known->pub.use_for &= new->pub.use_for;
 	known->pub.cannot_use_reasons = new->pub.cannot_use_reasons;
+	known->bss_source = new->bss_source;
 
 	return true;
 }
@@ -2206,6 +2207,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	       IEEE80211_MAX_CHAINS);
 	tmp.pub.use_for = data->use_for;
 	tmp.pub.cannot_use_reasons = data->cannot_use_reasons;
+	tmp.bss_source = data->bss_source;
 
 	switch (data->bss_source) {
 	case BSS_SOURCE_MBSSID:
-- 
2.7.4


