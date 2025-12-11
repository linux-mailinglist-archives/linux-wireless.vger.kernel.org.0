Return-Path: <linux-wireless+bounces-29656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C8ACB5E91
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D0E5304067C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA0D30FF39;
	Thu, 11 Dec 2025 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PIO9BMnG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M0uCRBnA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DCF30FF37
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456883; cv=none; b=prEtsCsYE7OEJZ3w66T3b0Y1o4bmos6mhr2+x9BIPX9xaZNRNFVVJbUJykAlN5nqGn1yG3R6ndUMnXsRChhHotXxeFmT83+KIEsPc2g7MqwYJHUQ4K63V5MaD/5rTAwjM5tEgR49vH+JaoWFAnsofMANVt2ZzWaGexjESwgvgc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456883; c=relaxed/simple;
	bh=FPqqg1w2Ss/OTdmgugTC7DkxJEGCnJFs2UCfpUelWmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSawJVGAukYr0ZPswvOzEqiBaj768ETNB9Q+UL2Cn8w5MwZdNHjlHiwkvMJK/4lSOKMT28aSf0IF/zXR/A6wxUwe8Huw0Kyr+kEC7bzWCyflgvxZ721N53+N0G5k8QV1x6LWG1XklLIOxvQ9Z9q6WYQcvCa6T/xO60uaaxn2nKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PIO9BMnG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M0uCRBnA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAXwUX1775361
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Px2e48C8iW39eYr4GuJNxpxfMMBtS0/4HT52dkaAsQ=; b=PIO9BMnGrKAYVqA/
	UxRFUTlVAYuSRlXYMoBbFTjMhUpyE+ERdiNjfwAe8RqVymZ3Id3yyPiukf0Kpbi3
	HUN+oX1xIpRBpEwlIuyCcgO4PC8SXSrEFFSDMLsYuEzypGFU6pd+GSTRrruSIjSg
	7n17KZOWmXMF1nGSb4qFKkmRPhq0tl1la7M5dd2CbXFCF88qTww8fbja3eUdTULc
	IbO5TOPOIPRv7QBjM33fOOgm0Er5IOcRrnc2q3xacr3K7+gxjfByyAg8VrO/JXLL
	DU4weVtGEA8lifGi+CiChq9qY9bA2JCjUXrZjono0nKjbJ9CLILK6UkeLLYA+JXQ
	g9ZZtg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayt708uy6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297fbfb4e53so721235ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456879; x=1766061679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Px2e48C8iW39eYr4GuJNxpxfMMBtS0/4HT52dkaAsQ=;
        b=M0uCRBnAlKtQQ7x9DJ3Kmshkj/QaMRJZKOwlVkCvRhRwSCHIpHkFYzMvt/SCleeoPX
         8mjHy8kg7et3Q/u0xQTd49pvROTpah98YU1EPs8YgsRQJm6SZg0JP+uuGnkj7ozUvnrb
         8gN+vCwCRRDrkeQjnpMsE/wQPF9jMcHslXDMKoOLgL+BXzU1clyx3Dv+8wA2BMxJZpAL
         UlFSJ7J/TM3Kz02Ag+ZmqilOk8zm0YBqrUThiSiV1p8JWQt4O5ZedQ7twAFkxmjteiMn
         pTGo4sIbJHiaEUx4cz+Y+9VpIQHA0B0HISMtiDTiu18nl1Hd+ujSUNeQN6ZKCwqSj2tw
         5OkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456879; x=1766061679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Px2e48C8iW39eYr4GuJNxpxfMMBtS0/4HT52dkaAsQ=;
        b=ZkpUBFy6lwQ1IxNZlo8ipTYxOdPH0Mah8QfBW21bss3CiQGPvg+MP54CXtE4OIS18P
         vHs1nNmRKYMjZQHy+3wi67YVkY7ds9KpFVFasBUVnNEqFNvBCArizf5BzCL/szY8jOMK
         896hSb8xmmpBDsaiPYBNk1vLSbi2am9JJ+7Sv1DzC991wkaWRtjZctjva3qGW1WCb++8
         7ubLPr+1awVlY1ykmKwdfZHJF04N+82l2ZJ2ugXTwuoPKaizr6h5BkaTg0jVed52Aumu
         4+xPIjVhHE4A8TT8LPW42i30nutnhe4kpMMMh9uIPwpxP/sgNWGzsZBeA2ktNSQtRoy1
         Qykw==
X-Gm-Message-State: AOJu0YxYofkkBgPvuA634r5vd93DnObNOGvFbgF9UO5ZHbefv8dtvf6c
	6bMVwjM37SOTtD3/yemyf7nQneUpiMVJ76E12S7brKtreURPluKktZbQ3K31iK5HXszC8azf3Um
	WxHWFaiR3QcNChtqjQL8xBtW7hxYtMgJLjQf6fTG1p6hPezZaLv4pGJ4Iw/IpwBA06qHC4w==
X-Gm-Gg: AY/fxX4kZu1T/GrFHv9sD9x2PSNq1e4wIZH8wDIucARZqKg9fB0OV422CrDLP0igfMn
	J5MNUiBd6lcvQ7ve/0vDNa2gAR2yeHFELfRRDbWEkd0IhWgeRFORo7N4MYRpmHsmfebJPEkOA5g
	NxzAmXfH1PrUdn8/pFc3CdQMtI1p/DRefyCBGWUpJmAtcs84mVxP2iWFmLl0p5aSMRqQcQ8CcTx
	jaZJdeHhh5yVfLOkcDvGbROwvPPCErocqK1njOrTxw7SNDKzGjjmA3o/3TvLWgrjgewnlTIXgDa
	ERdBfJYilt9T+RfdCWnFQUcT+d6swfr2yV80fnEH3Men64Oqag8MNlRwO/p2H19G5f7aAsef/Vj
	WCJclh8+Glso2+CLiVbse8B11CBBsewyyMmOAPvbxhg==
X-Received: by 2002:a05:6300:506:10b0:366:14b2:313 with SMTP id adf61e73a8af0-366e34c5fa2mr4553314637.70.1765456879217;
        Thu, 11 Dec 2025 04:41:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJDl57ETSnfyV8PqNOaO/pqU9jNjAc6UWgdeZV3TB/q/AJcidd6fhDPXnbhBDJGqz55E4u+w==
X-Received: by 2002:a05:6300:506:10b0:366:14b2:313 with SMTP id adf61e73a8af0-366e34c5fa2mr4553284637.70.1765456878382;
        Thu, 11 Dec 2025 04:41:18 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:18 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 02/14] wifi: cfg80211: add support for EPPKE Authentication Protocol
Date: Thu, 11 Dec 2025 18:10:39 +0530
Message-Id: <20251211124051.3094878-3-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfXzbXr/EdvfaDl
 tRfT0u2dtujUPIUmWbKLAE0Hcwn99xV/iDfiNhYwkGyY+gKiuWBgziBMmdYKl0Pyrarfu114lZP
 IU+DcTwYNHIzNM66BRCBlKAz9myP+22h4IC2PBREpIZKrobdUSHBT6yYFqXQPsCHXcQucZYx3iS
 fqHQAhmU2SpvfobOv0cZnFIJLNY/96p8FmbyL9+HXnpNE0tKSPj4InsG0cPybAUDdieWlmbYQyp
 mBoiYsTGKVeJu8y6j5zcptmy84Kuropg5UYrJx8PnQFdFTVmS9pMzgPyyZNx4nyvNUHMbw4z87r
 ZDb8hqSFytkNrWggHExvCdwNQUQ1glrMMOUyx/AamKmvcgV8AkoIoUS7nUDgvsMcy746X0fnKsm
 +hmKP7iulSPPq0BV6kw4uVBd+cKf2g==
X-Authority-Analysis: v=2.4 cv=WYIBqkhX c=1 sm=1 tr=0 ts=693abbf0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zcJngYgtL91L9PFnZ2QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: X3c1vYHjWaj_pQgBZBSkTlkPNmyrtMEB
X-Proofpoint-ORIG-GUID: X3c1vYHjWaj_pQgBZBSkTlkPNmyrtMEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

From: Ainy Kumari <ainy.kumari@oss.qualcomm.com>

Add an extended feature flag NL80211_EXT_FEATURE_EPPKE to allow a
driver to indicate support for the Enhanced Privacy Protection Key
Exchange (EPPKE) authentication protocol in non‑AP STA mode, as
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
Add support to validate the EPPKE base AKM suite in RSNE and reject
EPPKE Authentication frames if the base AKM suite is not present.

Signed-off-by: Ainy Kumari <ainy.kumari@oss.qualcomm.com>
Co-developed-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/linux/ieee80211.h    |   1 +
 include/net/cfg80211.h       |  55 +++++++++++++++
 include/uapi/linux/nl80211.h |   7 ++
 net/wireless/core.h          |   2 +
 net/wireless/nl80211.c       |  59 +++++++++++++++-
 net/wireless/util.c          | 126 +++++++++++++++++++++++++++++++++++
 6 files changed, 248 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 9d36695e1468..b3bf98a317b2 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1351,6 +1351,7 @@ struct ieee80211_tdls_data {
 #define WLAN_AUTH_FILS_SK 4
 #define WLAN_AUTH_FILS_SK_PFS 5
 #define WLAN_AUTH_FILS_PK 6
+#define WLAN_AUTH_EPPKE 9
 #define WLAN_AUTH_LEAP 128
 
 #define WLAN_AUTH_CHALLENGE_LEN 128
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 899f267b7cf9..38d201d4e676 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10376,4 +10376,59 @@ cfg80211_s1g_get_primary_sibling(struct wiphy *wiphy,
 	return ieee80211_get_channel_khz(wiphy, sibling_1mhz_khz);
 }
 
+/**
+ * struct rsne - RSN element (RSNE)
+ * @version: RSN version field (must be 1 for valid RSNE).
+ * @group_data_cipher_suite: group data cipher suite selector.
+ * @pairwise_cipher_suite_count: number of pairwise cipher suites.
+ * @pairwise_cipher_suite_list: list of pairwise cipher suite selectors.
+ * @akm_suite_count: number of AKM suites.
+ * @akm_suite_list: list of AKM suite selectors.
+ * @capabilities: RSN capabilities bitfield.
+ * @pmkid_count: (optional) number of PMKIDs.
+ * @pmkid_list: (optional) list of PMKIDs.
+ * @group_mgmt_cipher_suite: (optional) group management cipher suite selector.
+ *
+ * Represents the RSN element defined in "IEEE Std 802.11-2020, 9.4.2.24"
+ * so that cfg80211/mac80211 can parse and access its fields.
+ */
+struct rsne {
+	u16 version;
+	u32 group_data_cipher_suite;
+	u16 pairwise_cipher_suite_count;
+	const u8 *pairwise_cipher_suite_list;
+
+	u16 akm_suite_count;
+	const u8 *akm_suite_list;
+
+	u16 capabilities;
+
+	u16 pmkid_count;
+	const u8 *pmkid_list;
+
+	u32 group_mgmt_cipher_suite;
+};
+
+/**
+ * cfg80211_parse_rsne - Parse an RSN element (RSNE)
+ * @rsne: pointer to RSNE buffer.
+ * @elem: pointer to struct rsne to fill.
+ *
+ * Parse the RSN element as defined in "IEEE Std 802.11-2020, 9.4.2.24".
+ *
+ * Return: 0 on success, -EINVAL on failure.
+ */
+int cfg80211_parse_rsne(const u8 *rsne, struct rsne *elem);
+
+/**
+ * cfg80211_rsne_get_akm_list - Parse RSNE and return AKM suite list
+ * @rsne: pointer to RSNE buffer.
+ * @count: pointer to store number of AKM suites.
+ *
+ * Parse the RSN element and return a pointer to the AKM suite list.
+ *
+ * Return: pointer to list, or NULL if parsing fails or inputs are invalid.
+ */
+const u8 *cfg80211_rsne_get_akm_list(const u8 *rsne, u16 *count);
+
 #endif /* __NET_CFG80211_H */
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
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 63dcf315dba7..134c8841a24d 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -579,6 +579,8 @@ int cfg80211_assoc_ml_reconf(struct cfg80211_registered_device *rdev,
 			     struct net_device *dev,
 			     struct cfg80211_ml_reconf_req *req);
 
+bool cfg80211_is_sae_akmp(u32 akm_suite);
+
 /**
  * struct cfg80211_colocated_ap - colocated AP information
  *
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c961cd42a832..d7151fc5cf0e 100644
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
 
@@ -11961,12 +11970,58 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 		if (auth_type != NL80211_AUTHTYPE_SAE &&
 		    auth_type != NL80211_AUTHTYPE_FILS_SK &&
 		    auth_type != NL80211_AUTHTYPE_FILS_SK_PFS &&
-		    auth_type != NL80211_AUTHTYPE_FILS_PK)
+		    auth_type != NL80211_AUTHTYPE_FILS_PK &&
+		    auth_type != NL80211_AUTHTYPE_EPPKE)
 			return -EINVAL;
 		req.auth_data = nla_data(info->attrs[NL80211_ATTR_AUTH_DATA]);
 		req.auth_data_len = nla_len(info->attrs[NL80211_ATTR_AUTH_DATA]);
 	}
 
+	if (auth_type == NL80211_AUTHTYPE_EPPKE) {
+		u16 auth_trans;
+		__le16 *pos;
+
+		/*
+		 * Validate auth_data length for Authentication
+		 * Transaction Sequence Number and Status Code.
+		 */
+		if (req.auth_data_len <= 4)
+			return -EINVAL;
+
+		pos = (__le16 *)req.auth_data;
+		auth_trans = le16_to_cpu(*pos);
+
+		if (auth_trans == 1) {
+			const u8 *rsne, *akm_list;
+			u16 akm_count;
+			u32 akm_suite;
+
+			rsne = cfg80211_find_ie(WLAN_EID_RSN,
+						req.auth_data + 4,
+						req.auth_data_len - 4);
+
+			akm_list = cfg80211_rsne_get_akm_list(rsne, &akm_count);
+
+			/*
+			 * Validate AKMP from RSNE for EPPKE Authentication:
+			 * EPPKE uses PASN with SAE AKMPs as Base AKMP as
+			 * mentioned in "IEEE P802.11bi/D3.0, 12.16.9".
+			 * Valid AKMPs: SAE (00-0F-AC:8), FT-SAE (00-0F-AC:9),
+			 * SAE-EXT (00-0F-AC:24), FT-SAE-EXT (00-0F-AC:25).
+			 *
+			 * If RSNE has none or multiple Base AKMPs, reject the
+			 * Authentication frame as mentioned in
+			 * "IEEE Std 802.11‑2024, 12.13.3.2".
+			 */
+			if (akm_count != 1 || !akm_list)
+				return -EINVAL;
+
+			akm_suite = get_unaligned_be32(akm_list);
+			if (!cfg80211_is_sae_akmp(akm_suite))
+				return -EINVAL;
+		}
+	}
+
 	local_state_change = !!info->attrs[NL80211_ATTR_LOCAL_STATE_CHANGE];
 
 	/*
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 27e8a2f52f04..cc09769fa25f 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2984,3 +2984,129 @@ bool cfg80211_wdev_channel_allowed(struct wireless_dev *wdev,
 	return false;
 }
 EXPORT_SYMBOL(cfg80211_wdev_channel_allowed);
+
+int cfg80211_parse_rsne(const u8 *rsne, struct rsne *elem)
+{
+	u16 len, cnt, field_len;
+
+	if (!rsne)
+		return -EINVAL;
+
+	memset(elem, 0, sizeof(*elem));
+
+	/* Version present? */
+	if (rsne[1] < 2)
+		return -EINVAL;
+
+	elem->version = get_unaligned_le16(rsne + 2);
+	if (elem->version != 1)
+		return -EINVAL;
+
+	len = rsne[1] - 2;
+	rsne += 4;
+
+	/* Group Data Cipher Suite present? */
+	if (len >= 4) {
+		elem->group_data_cipher_suite = get_unaligned_be32(rsne);
+		rsne += 4;
+		len -= 4;
+	} else if (len > 0) {
+		return -EINVAL;
+	}
+
+	/* Pairwise Cipher Suite Count present? */
+	if (len >= 2) {
+		cnt = get_unaligned_le16(rsne);
+		field_len = 2 + cnt * 4;
+
+		if (len < field_len)
+			return -EINVAL;
+
+		elem->pairwise_cipher_suite_count = cnt;
+		elem->pairwise_cipher_suite_list = rsne + 2;
+
+		rsne += field_len;
+		len -= field_len;
+	} else if (len == 1) {
+		return -EINVAL;
+	}
+
+	/* AKM Suite Count present? */
+	if (len >= 2) {
+		cnt = get_unaligned_le16(rsne);
+		field_len = 2 + cnt * 4;
+
+		if (len < field_len)
+			return -EINVAL;
+
+		elem->akm_suite_count = cnt;
+		elem->akm_suite_list = rsne + 2;
+
+		rsne += field_len;
+		len  -= field_len;
+	} else if (len == 1) {
+		return -EINVAL;
+	}
+
+	/* RSN Capabilities present? */
+	if (len >= 2) {
+		elem->capabilities = get_unaligned_le16(rsne);
+		rsne += 2;
+		len -= 2;
+	}
+
+	/* PMKID Count present? */
+	if (len >= 2) {
+		cnt = get_unaligned_le16(rsne);
+		field_len = 2 + cnt * 16;
+
+		if (len < field_len)
+			return -EINVAL;
+
+		elem->pmkid_count = cnt;
+		elem->pmkid_list = rsne + 2;
+
+		rsne += field_len;
+		len -= field_len;
+	}
+
+	/* Group Management Cipher Suite present? */
+	if (len >= 4) {
+		elem->group_mgmt_cipher_suite = get_unaligned_be32(rsne);
+		rsne += 4;
+		len -= 4;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cfg80211_parse_rsne);
+
+const u8 *cfg80211_rsne_get_akm_list(const u8 *rsne, u16 *count)
+{
+	struct rsne elem;
+	int ret;
+
+	if (!rsne || !count)
+		return NULL;
+
+	ret = cfg80211_parse_rsne(rsne, &elem);
+	if (ret)
+		return NULL;
+
+	*count = elem.akm_suite_count;
+
+	return elem.akm_suite_list;
+}
+
+bool cfg80211_is_sae_akmp(u32 akm_suite)
+{
+	switch (akm_suite) {
+	case WLAN_AKM_SUITE_SAE:
+	case WLAN_AKM_SUITE_FT_OVER_SAE:
+	case WLAN_AKM_SUITE_SAE_EXT_KEY:
+	case WLAN_AKM_SUITE_FT_SAE_EXT_KEY:
+		return true;
+	default:
+		return false;
+	}
+}
-- 
2.34.1


