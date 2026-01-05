Return-Path: <linux-wireless+bounces-30343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C21CF2342
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 08:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 230EB300E44D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 07:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E7E2D948D;
	Mon,  5 Jan 2026 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oDThOCD+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f7SxkuXN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A912D877F
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597912; cv=none; b=C6xNnVIS/8wsziy/DxttUFuJEFPA4m5Fhxmh6OWlAy0RlyMkaJIqKHUZhP9TpbCuQ5+WQXZ9pwVdydQh2DjKSSuVARfQK4V89mFbOlM25KnaWn1HQrQ6t6Z7zGmACH+yX9UvMtwX/PArPNfgoKdGttJ/tdwdHXCxiF9qTg8JjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597912; c=relaxed/simple;
	bh=mNyZzJloFaJSNeZ6eYsKcRkRNBmm2uUqrq0k/DZNUbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBdDS9pz7V6o44XRDM5dJAN+qRc4I9EUj2mTzFjmUxsW+fcvhi9dRFfryj8G5EqAtLxBVE9HlLdo9ojQsCC9jNrQKXqb1IhSJWUmSeLF2odkgd/gyeS+Nj5J3EGvWiMYvKc4sU+H6ZWmMCWBtaUNIHUA8edgFgAYrlJ1rstqGbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oDThOCD+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f7SxkuXN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604NtMAk3559956
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 07:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9l+K+Qokd53
	hIciEfn/q9MT2BxzEs2c6/jjQ/2nF1fI=; b=oDThOCD+X3s6qvSypv9kyvpa39N
	+fyGGYoV3Qf+REvnS9vmB4UvkfECVe3uHJGGGBHo8SXaNGb3zTry5hQ4F5xOrFdH
	mIox02WzywPt51lcCUztE7a0pHDzx9qNzJoLllhACOcP52J2T/yMUhc2HXxy+RAR
	TiO0FDm4GhkeqN9a2HsNZWtUqEn5CQwegwkz6dKxJ6i00731ol770gToV/QTOIzz
	0f0TgBzMVRYHhozL6tBZPVRWJMyuOdRQGWGeNSafV0JJigaweYGAoROJmq+1QR2J
	bnV1q89o1tAwgabq1MMd433leYPjky0x2birnzqW+pRxD1d8pcKRwUY0iaA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4beywdka3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 07:25:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0f47c0e60so367795355ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 23:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767597907; x=1768202707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9l+K+Qokd53hIciEfn/q9MT2BxzEs2c6/jjQ/2nF1fI=;
        b=f7SxkuXNMGFfza8YHczLRlDJ6pOx6w7kgdENuzPV1qTtogHyZwuhunUMwzjFFYz/1y
         4tvStRdNzhzet4U+9xr7ofACi1kNllwaHw8a3nwnmX1KRQtM8SDmiALv42KZ0ISjjqm8
         /O/w/mYRH4G8PwA0MGGD0o38zQHtCPBgpxX2BedTRJRN1ARkjiaCO9ZdSTCXw/yxJGFJ
         9HyBLXo4ldH+PP1hBbHIqPo2mLphtzq6JlO8BF/CSpNsScKI+OkpRhtgyuYKAJtozGUa
         GN1EWwQz433wYEAQWmHhd7R9jbT974ClnN1kvgp+Fh12R5gxtH+3wAgpGeYLcaKsfFR7
         XwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597907; x=1768202707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9l+K+Qokd53hIciEfn/q9MT2BxzEs2c6/jjQ/2nF1fI=;
        b=g5ujbp7YMbjWOhEFDNwT3UA/LoWQdvy6B2lpsodOdUb7RK7HbjgIQ4XOpWt34/FDz/
         +4RwMUwZZwxme+rir4vz3qdg7tyFNyuG8AK6dlovH+mMhJYJ1D8MJV9AEe72m/U+NJjM
         Kj4mQv3rSuQAMLifn9H8i2HtkXxEC5q+94NIffDV/GUfczz7Q/L2I3yuXtDS9IzgUgX7
         hZSR7Kl5wV03tqqd+IQ4gO4jyYX/qy8ivjFKWd8NLHEm5uBoykfnoSvmLCf7jZSEDt6Z
         k8duXyrTtRMe8W8R31DrIu6lXVDYUvTaUg5xS3HIyqKtuKhNQBB+hw1h4cCljCSOnpsn
         ph9A==
X-Gm-Message-State: AOJu0YzkHuXsQD2xn6bhsoofzdEolZMWUSRIlwb6hZ5NALNi1Sap/eCb
	eJzt7Ss9vJqcxmq5WnDXqN9IQGHEBN/V0sXzRY7qc/6s3VtuWVwR/1cLKQVHDkUvJHxje2fvuuR
	0tOTtnA+D5Jtx2VvwSlO00Ausy/mz0LDhCLQ5WUsdPeUWP4ltTL0wsOgYgzDXT73FI0TOWQ==
X-Gm-Gg: AY/fxX41sPWFkJmA9iEFQu7qxH3LGtqdl9uREejV7l4ZQynBUCl+Be9TPK+E+x3Y7Cp
	6GB7O2BbGbPHsUiUfbhnO+yEsvI3Aez0Db3at/O0w77L7eKwyJSxl1cFVXsU4KpJRbLIc/41QWV
	Jqn/gO7D/zIuV/JEPK4c1p9zHc0jKnw/CC6ub/85nBtpHsOrqCoYx69k0XsY7r6L9a2KHmRKrfU
	pJsphobHJD+6aGefbfN3IiT9WXzJ9mdPC8PAGIrpe4Rm2XAmeFesUZKclHvvFg6o+HG8kfZFWmO
	3I52AwtsN8IYzONErX9jxkBDIqZ7PdYieC7R1EJxCNYGcOApBs5EPP8/tOEHzD4/BNujr40Lbc9
	T/4XclOkoOn2q+Xtt3tJYrYiQQZAx+sDAoBWBYIW6yg==
X-Received: by 2002:a17:903:244b:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-2a2f2a4f6f8mr496573715ad.42.1767597906963;
        Sun, 04 Jan 2026 23:25:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi6a4rLA1zV5Digz2rEcpzlj3JNqU6J24huq/uoUTkbcI0ziaTtmE45/nwKcWVtFYwUq2BsA==
X-Received: by 2002:a17:903:244b:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-2a2f2a4f6f8mr496573325ad.42.1767597906407;
        Sun, 04 Jan 2026 23:25:06 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm445201205ad.34.2026.01.04.23.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:25:06 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 1/9] wifi: cfg80211: add support for EPPKE Authentication Protocol
Date: Mon,  5 Jan 2026 12:54:07 +0530
Message-Id: <20260105072415.3472165-2-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
References: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sc76t/Ru c=1 sm=1 tr=0 ts=695b6753 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=K9bSqJOrJGfH4NCufdQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA2NSBTYWx0ZWRfX18gQtqQ4tToH
 mSML/G65AqNwcOpAU7kwaTfoR4lJLFW16biSb12bsWmBVffkvNUbvbVADrfkb0i1XlFIUgI/M/+
 gPSupk5a+FYSQdGOIDUy68nB2BhYfP0n+dCxvpS+6v1hTaCK9b1nN0zs0upG+CaS/jatqlBnWMl
 V8qcLsaCnj+M/PB+F/Mp3Em56yzBLpBDe2lIbX7yZO78+xEjV4WVXJzogjD8A2TvAPbeYDIYLDo
 OZCEPH8s0xzYwHuF1Ou+Ll9o0/ANTIfUjRtSul4a4cIcp4Tsqsd5CTnbA3Mcevosww4Rz/haC78
 DMb08AZBzMnNGGWn/AllDN4nPdbafW64Y63F8TqgAiUq7nDE86rnx0oVr24glIW7eFjuOz4TIwE
 JZ1S5p1zC84cV45THECT9Gl0PR0+fHEz+Pc/Y0XZ44jk22VUEnPIhGsUxDurS5UoF++AgLVnq7w
 gQJ94dYoNvTyw4QZV2A==
X-Proofpoint-GUID: aLBHOTrf3X6c_wUm-xQXhDBIAZjio23m
X-Proofpoint-ORIG-GUID: aLBHOTrf3X6c_wUm-xQXhDBIAZjio23m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050065

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


