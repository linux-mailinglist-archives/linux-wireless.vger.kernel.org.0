Return-Path: <linux-wireless+bounces-30402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8E5CF914A
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 16:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F185130A133C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA8D33F39B;
	Tue,  6 Jan 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IvRUVPkC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PzcDaDaO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14882345740
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713119; cv=none; b=UHlDL7MZL19t6aBH7guCzjR7bx+Lj2sZwntmHMbTjRMoTC2/5EdNFqblyGsvnEnFU6fh3w46xwc6XvDiaMOcyO1IyMHs4trtnxo3GIYa7vVR3PsOnwmrb4DnUzKlOZeirmvQ+NsUPwA0ssr9sa40VkHkFWhGndpr8PO3RdOpDPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713119; c=relaxed/simple;
	bh=mNyZzJloFaJSNeZ6eYsKcRkRNBmm2uUqrq0k/DZNUbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuR095O8tNxjTU3vo4riBbT/lz9ocFnYs4eHhxxAmIZUvGeJXwZCn5iN9mYSY9QnyPG8iV1XRiGQ7LvJFQQegsiOoFc8vNeQMioNJBikamTcW/Tty/ux6rTALDb5tfEiJuiKUZCKXDOi0bOGodin2S35aYQxCgyLRGQabyiOQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IvRUVPkC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PzcDaDaO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606AggrV1462508
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 15:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9l+K+Qokd53
	hIciEfn/q9MT2BxzEs2c6/jjQ/2nF1fI=; b=IvRUVPkCiXmTuTcF3XH9AZ+T7MT
	rTJwpygkHpu/BwN49I6If+cTH+s+3wHtZS/fDd8j4HPLrXKlQhx7HSe028RnJnlX
	XuJP6acZNfrjhVNZuk6PfP2ZYleUSNT9JKDArxM2W/btesjtJLJJ4X/fwGGNiZa3
	qN8meXcW7qjB3xKJUCiXWGJr9KnrVuDNXfZ2hiM3dhis6SAcYkYAwNB6kCI82zp5
	lE7trMuu4tMMSOIH870R1VOcXSABRDfR7d62+rMGObH4Jhd/NvAij6TLt4TxNPor
	5JSgFipY0VUuhJzPljegO8pv2JItajvXetC3hNeX1WDz0iLeHgZV53DZYIA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh0vm0rf1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 15:25:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0f0c7a06eso19660005ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 07:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767713116; x=1768317916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9l+K+Qokd53hIciEfn/q9MT2BxzEs2c6/jjQ/2nF1fI=;
        b=PzcDaDaObooBRTi32zx8M3XQLQz7XnrUvsw3goaY43ZxGD+kGr6Dxr14sZhHj5RbnN
         7tY9uqfWs4fB9JaMbWAY+XJrSgAGzYe6RpsujIMhdeneUbHmHe5nok1t9Q6n5ihgggnk
         O8wG6zpZ8zs2nPwjoz8pB3t28715CuMABlqHanq/26jFEIpidsgYVHBRSZ686MUMOKX9
         YoFEhegfc6XJsTF1l1PrDtakYNlB/2xA1wuajqZnGyEPDNN0JSEH4cOyYkOlqUu4B42F
         gOb8DJhy+nubeC6wGachNFHB/VQOjMDlb/WhJr1uo71frpL4gIYBtslrhvXKfKXFsSeb
         4PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713116; x=1768317916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9l+K+Qokd53hIciEfn/q9MT2BxzEs2c6/jjQ/2nF1fI=;
        b=ZaKDuRlfhkYpakTAgeA0+tUurFE18vXWGWDdz/mghGHJ+CdgQbqxMFt6JQWrQ7rIM4
         qzA/lnj1wc+MSlI1nuR9DCuxChn4+z6Vz5ahkOmcsQT8KajwcEgbqotfQ/gg8/KnJsS8
         JPs1pVaxxFSgoBeabsC0iRkxNuL06SUJx6juv4DQhBNMakEEmrdom8FG56KmFZe2/YCI
         X4ZlFCBcOYSqV8nrjvqIUUjaFuy8Ys7zwD/2zjIVNUrtYojVYtglkzXHKc0tOjuY3YC3
         MDnZZU0EJ72kSzhkZwvvcqmENLOKwy7c8i/LRl001QMKVlYzHSl8DnOH1Fv9SoKKOoXR
         ZA+w==
X-Gm-Message-State: AOJu0YzTwmRZ1GzuWNYTwNRiFdS+ZM6Q0lhnUEz3LXo/Z94yU085uuCO
	DuKqRLpi8cumUvbcRR1LE9JYa9Et5srMiT+bnG8qg95LfjHL6ZbQr2LWrLQ6pPoc5dmdQMMNbQp
	S7Fi4rU6gYUu3U3cGQU6ljEU83BUhfG8EHPgoSwazBvdQzCaVoJhmI2tW9EI8e1yPg0PtaA==
X-Gm-Gg: AY/fxX5SNMRSLutey+3HBgD3SgwG8lWqwFqbiMWSnB7DDOdqxrJ/hs0ZIBPo4cLS93n
	P78NxDDVuWNhEz83tW7i6rrJZ3KK2fMcIC1eZfIr63a2P43YKO4Ljef0F6J83rEHOur3K15/lka
	UCCRir3ic3cQjdi7SciM3+wbeu2o+ygr7l1S8Mpdb5tUA1+bXpB9YX2jdGWYPoaMjgF3CbweBQe
	xIkgNEMNzLDfcm2m7NT1DId+jRmdtO1J18VgwmcBWV0lWE16e2huhfvUFrW6NRG3UhttWa9g86p
	Knp4iExfCHByDlRWphcPyIYSCW/XfjtqlfqDsdCZPYDmCOy6Dd9ZbEFh3CxuSMtB7AEeAkqQZs5
	lS3ZFVjM9kk1tsxHv/LAp1QnAW8STdJAiGbg9lndqfw==
X-Received: by 2002:a17:902:74c7:b0:29f:2944:9774 with SMTP id d9443c01a7336-2a3e2cefdf6mr19853195ad.33.1767713116351;
        Tue, 06 Jan 2026 07:25:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAcRBqB5AsIfzuVvz1Y0gcLgAjhLJ8thpmLOEGADiSw07T7joEJ7jDfX6BMRVKFejwaS37SA==
X-Received: by 2002:a17:902:74c7:b0:29f:2944:9774 with SMTP id d9443c01a7336-2a3e2cefdf6mr19853065ad.33.1767713115778;
        Tue, 06 Jan 2026 07:25:15 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2ea0sm26343595ad.62.2026.01.06.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:25:15 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 1/9] wifi: cfg80211: add support for EPPKE Authentication Protocol
Date: Tue,  6 Jan 2026 20:54:55 +0530
Message-Id: <20260106152503.223216-2-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Pa3yRyhd c=1 sm=1 tr=0 ts=695d295d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=K9bSqJOrJGfH4NCufdQA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: VdWWE08_rQ1pgT4pZSt-dpHhx8JT0ws4
X-Proofpoint-ORIG-GUID: VdWWE08_rQ1pgT4pZSt-dpHhx8JT0ws4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzNCBTYWx0ZWRfX8iwGAzskSgv6
 tW8n9Bl21+ptY1gtwabonPVRHt92WIjjIjJ/fxaEVzBOcZM1qJhqqVtCx3DucNtUHn/ClbI1hcb
 GSmz1SDN1Xf0DrHEiQqThrAm0YUbRWd3O4lXEX1OMRLVn3sMvujz9hNE5y0xe5vjLmsFpRCyy2S
 dUOTUUjRs0Ta1Mh5Zqu4dnKeJB4eT7ciXFDUDwlRPnHTnTE1bTFjRxd70LbZHobzjGBw1W4FRmP
 DM9POeUoQKevzmBWaaxjdjJhcdLJDVyHJ/AerbIIx84ha/WIbwxPaKAD3upP3JAFK3lTrzUZbks
 r/0eNf9+Y1ohvyh3xpP1tB1ZBxStMYHED4Wi1uBA4hSWY3WGep/cI+UVhG9Adqx/sscNqgZqc3b
 X6XCyyATX479FvU5OwbfB1W6pI72om+ME9jKS7fB/GVE77BW0tpgnaS4q+vx6PMWhanp9KNkfib
 5MOXpkjnqMEbdT/nLdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060134

From: Ainy Kumari <ainy.kumari@oss.qualcomm.com>

Add an extended feature flag NL80211_EXT_FEATURE_EPPKE to allow a
driver to indicate support for the Enhanced Privacy Protection Key
Exchange (EPPKE) authentication protocol in non-AP STA mode, as
defined in "IEEE P802.11bi/D3.0, 12.16.9".

In case of SME in userspace, the Authentication frame body is prepared
in userspace while the driver finalizes the Authentication frame once
it receives the required fields and elements. The driver indicates
support for EPPKE using the extended feature flag so that userspace
can initiate EPPKE authentication.

When the feature flag is set, process EPPKE Authentication frames from
userspace in non-AP STA mode. If the flag is not set, reject EPPKE
Authentication frames.

Define a new authentication type NL80211_AUTHTYPE_EPPKE for EPPKE.

Signed-off-by: Ainy Kumari <ainy.kumari@oss.qualcomm.com>
Co-developed-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/linux/ieee80211.h    |  1 +
 include/uapi/linux/nl80211.h |  7 +++++++
 net/wireless/nl80211.c       | 14 ++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 96439de55f07..fbde215c25aa 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1351,6 +1351,7 @@ struct ieee80211_tdls_data {
 #define WLAN_AUTH_FILS_SK 4
 #define WLAN_AUTH_FILS_SK_PFS 5
 #define WLAN_AUTH_FILS_PK 6
+#define WLAN_AUTH_EPPKE 9
 #define WLAN_AUTH_LEAP 128
 
 #define WLAN_AUTH_CHALLENGE_LEN 128
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8134f10e4e6c..371249a2f0b0 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5425,6 +5425,7 @@ enum nl80211_bss_status {
  * @NL80211_AUTHTYPE_FILS_SK: Fast Initial Link Setup shared key
  * @NL80211_AUTHTYPE_FILS_SK_PFS: Fast Initial Link Setup shared key with PFS
  * @NL80211_AUTHTYPE_FILS_PK: Fast Initial Link Setup public key
+ * @NL80211_AUTHTYPE_EPPKE: Enhanced Privacy Protection Key Exchange
  * @__NL80211_AUTHTYPE_NUM: internal
  * @NL80211_AUTHTYPE_MAX: maximum valid auth algorithm
  * @NL80211_AUTHTYPE_AUTOMATIC: determine automatically (if necessary by
@@ -5440,6 +5441,7 @@ enum nl80211_auth_type {
 	NL80211_AUTHTYPE_FILS_SK,
 	NL80211_AUTHTYPE_FILS_SK_PFS,
 	NL80211_AUTHTYPE_FILS_PK,
+	NL80211_AUTHTYPE_EPPKE,
 
 	/* keep last */
 	__NL80211_AUTHTYPE_NUM,
@@ -6744,6 +6746,10 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_BEACON_RATE_EHT: Driver supports beacon rate
  *	configuration (AP/mesh) with EHT rates.
  *
+ * @NL80211_EXT_FEATURE_EPPKE: Driver supports Enhanced Privacy Protection
+ *	Key Exchange (EPPKE) with user space SME (NL80211_CMD_AUTHENTICATE)
+ *	in non-AP STA mode.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6820,6 +6826,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_DFS_CONCURRENT,
 	NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT,
 	NL80211_EXT_FEATURE_BEACON_RATE_EHT,
+	NL80211_EXT_FEATURE_EPPKE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c961cd42a832..2ac31a1d4ce0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6470,6 +6470,10 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
 		     auth_type == NL80211_AUTHTYPE_FILS_SK_PFS ||
 		     auth_type == NL80211_AUTHTYPE_FILS_PK))
 			return false;
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_EPPKE) &&
+		    auth_type == NL80211_AUTHTYPE_EPPKE)
+			return false;
 		return true;
 	case NL80211_CMD_CONNECT:
 		if (!(rdev->wiphy.features & NL80211_FEATURE_SAE) &&
@@ -6487,6 +6491,10 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
 			    NL80211_EXT_FEATURE_FILS_SK_OFFLOAD) &&
 		    auth_type == NL80211_AUTHTYPE_FILS_SK)
 			return false;
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_EPPKE) &&
+		    auth_type == NL80211_AUTHTYPE_EPPKE)
+			return false;
 		return true;
 	case NL80211_CMD_START_AP:
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
@@ -11953,7 +11961,8 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 	if ((auth_type == NL80211_AUTHTYPE_SAE ||
 	     auth_type == NL80211_AUTHTYPE_FILS_SK ||
 	     auth_type == NL80211_AUTHTYPE_FILS_SK_PFS ||
-	     auth_type == NL80211_AUTHTYPE_FILS_PK) &&
+	     auth_type == NL80211_AUTHTYPE_FILS_PK ||
+	     auth_type == NL80211_AUTHTYPE_EPPKE) &&
 	    !info->attrs[NL80211_ATTR_AUTH_DATA])
 		return -EINVAL;
 
@@ -11961,7 +11970,8 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 		if (auth_type != NL80211_AUTHTYPE_SAE &&
 		    auth_type != NL80211_AUTHTYPE_FILS_SK &&
 		    auth_type != NL80211_AUTHTYPE_FILS_SK_PFS &&
-		    auth_type != NL80211_AUTHTYPE_FILS_PK)
+		    auth_type != NL80211_AUTHTYPE_FILS_PK &&
+		    auth_type != NL80211_AUTHTYPE_EPPKE)
 			return -EINVAL;
 		req.auth_data = nla_data(info->attrs[NL80211_ATTR_AUTH_DATA]);
 		req.auth_data_len = nla_len(info->attrs[NL80211_ATTR_AUTH_DATA]);
-- 
2.34.1


