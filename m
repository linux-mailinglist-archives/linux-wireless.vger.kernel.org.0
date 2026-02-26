Return-Path: <linux-wireless+bounces-32200-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDL/FGHun2nYewQAu9opvQ
	(envelope-from <linux-wireless+bounces-32200-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 07:55:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D1E1A17D2
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 07:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 366A53066828
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2567D38BF92;
	Thu, 26 Feb 2026 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cNOMUNzA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gZD9uHfc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C53438BF8C
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088922; cv=none; b=ZMwoP734GhEttdXZfBYmmTI60gil+oPHq9d77GRfvqxq4H8alwMwMN/G6UefwDfpI+A/Zn1dTvVz5gYQDEzL2kBj6d6Lf6Mwn222lDwesu5Gu9XX5CTIj+YOGFAU+4Z0k9LKwp7VuELz0FHYndnshn5RD0VQyBQbRTX8UwfPuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088922; c=relaxed/simple;
	bh=nYLUPjQsUeHRXlv9mqgkugWR7ewpD5xIvamPrGw0hO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCFbh/PdsY6iJa5FI4XFrp+MlpcrhrcDU2RjFCZXD7JLUfNgNGhJsWHb7e1qJzmW4ZQ/K+9fc5eKq8GKECn2nEqJpsu+R4rZMDs8VsExfACTxF94PJTSs8tpCotBkv8CmBQdBmYZw/U1lZPqBbCMegb/k9aj3cDQz5wKD0qtNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cNOMUNzA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gZD9uHfc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4VAnQ350383
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v/w8WYOKrZSWjh2BiqV2N6C2kB4wMP4bR1sTRH7W8Vs=; b=cNOMUNzAnRMadvqh
	QjyYirfHK/9BABkK48tIqMMT/BiopIrGrXNEzEL/ogjzTLPjOBQjdavx3zmxMa76
	8mLJBSB1PS/UOIlxDXwcg43u26ZKpN8fNHPQ17/j7dtt7Qv7V/O5xGCompeOynAs
	Hd6l/7eVgLrRAFa3KCj0yYUVOjBaHpOZ8mJmbMZOylwnyJuBqOw2yOen0txdFsOx
	+yJDHAEesBxXsggPQoWsCMdONyYe91msE+WeqI1Y7OOq0I93zMIuu/CtdroilyMS
	d7S//1IHXD11fbbtC40zwczFiGtuylHpKEqFl/k1Rbl60mtn6X4eQv4gvkUhfWTc
	CleI8Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54pa554-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:55:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad5fec175so20281695ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 22:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772088918; x=1772693718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/w8WYOKrZSWjh2BiqV2N6C2kB4wMP4bR1sTRH7W8Vs=;
        b=gZD9uHfchlejQpI26hx8IqGxuMplJ9m4oIf8ZXiSU2prclDRmvAT13ZNTBXQLHyBVR
         jAzqzCYSgEvt/W/1V88jDKmuKrjvJLQ5/puJPWd8Knlxsm0+atdZyjiPepa0FOIzkyNp
         2kbj2et5i0H15AOBxjF8nvRIXzS+xsH1tx3YVuImWGl5C20qUc3JZBowBFvixTGMhJ4+
         +WT+BzKT/nXzzAcnh1ZWeAv1rfn0EzE/wuOLK/GQweagEj4bkKPiKwz6b8MAXk1kJ8pP
         Hdm84weQG63K0NrMzhi89tiVwi5vBvg6YV3SpEAM8AO3s7iuZ9KiJVile/ctHtGsPBrp
         3BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772088918; x=1772693718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/w8WYOKrZSWjh2BiqV2N6C2kB4wMP4bR1sTRH7W8Vs=;
        b=C9PniAEsvbpr0PAQ0+MO0fYEhzhT1upNr2+rVjjXeCzRslE5YBNcWf78QUiD6Be3T7
         fL3CA7TQzY0ZFATRS9lSMgK9z2a6k9un48s4cw/KAQ+qmqvBbb2pgeTkvzMTR/eYkJjX
         47NB6YkYU1ChNK2itl5M9QvETfYFATZHl7LVI42U+fQZfmsPFALHrn28t7gYF3sZH9Ew
         CFxvfj+dqovrQpw+rNBmX7ZAl6v4CkL+zQc2Ljf4SgvATHm0x0/Htyw42zpzM4Rgsids
         BWD9L5Qt31ST2CuyKMy2iicvftLdi9Ao9MGECFLOQVR7TwEcP6/GFACQb8uMiyUSV+BG
         fcAQ==
X-Gm-Message-State: AOJu0YyneCfOW3CqBtMWGJXhcdh09Nd1sTYuJbsc43xJAR1Zaimp64wT
	Tw4jBqxHHUc3BIyz0caJhKq+80pyeXPIay1WIzclXLgdUOxs+aBgw9EjgQYs5Dz5EatGXCQz4eu
	ybCdSkFuESTO0A7sRlHQZvlTTnfVQdrQRiteabP55L2XmFsAhnspAwjFZgrghOzGZqc66Blh9Cn
	j7aw==
X-Gm-Gg: ATEYQzz/98ebe3k34Js/huyOyLfj6ix8hc6EyzWcr4Kst/aTitodrRT4okyKReKp3kX
	doMSiymBi0rIpsJfYvKGpjvnOLMAddNA4PUE7xCreaooPVhDhC9ncC9grXsc6FdIeAY+n2oWqRW
	8cXk36NxrV1h0AbXFiZvO81qkEGuCUNRXzn7XTI3D1cH1h++7u1mEVxGz66SbiGxWrB1LtgmufF
	bee9LnyJxBFqua0WaWQNqnBLtYkmgTp5d0e3G0/eOaPe0E1j8zSp3zg7cWkNx4FZLgTzt7RZ4Za
	XedGJlDxYZgutUwOqgaw1x6cZ0jc9A/OSeLLTd6EC8lj2GPJf95c2gDW9zdvOKWC+SWfo+5y0BW
	1UXy36R82c+v5ILzaFvxzmMDMZkQHwS3jBWFPCOm/MtqA/Q9GzD6NvQ==
X-Received: by 2002:a17:902:f78f:b0:2a9:2a0b:4ef5 with SMTP id d9443c01a7336-2ae022b017bmr14823185ad.7.1772088918284;
        Wed, 25 Feb 2026 22:55:18 -0800 (PST)
X-Received: by 2002:a17:902:f78f:b0:2a9:2a0b:4ef5 with SMTP id d9443c01a7336-2ae022b017bmr14822985ad.7.1772088917802;
        Wed, 25 Feb 2026 22:55:17 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35900700e69sm4791066a91.0.2026.02.25.22.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 22:55:17 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next 1/3] wifi: cfg80211: add support for IEEE 802.1X Authentication Protocol
Date: Thu, 26 Feb 2026 12:24:40 +0530
Message-Id: <20260226065442.4182232-2-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
References: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MCBTYWx0ZWRfX+bvVjO1fpPWl
 Dbbd+4BF7TJR1Z03cGuKVD8bLDGq4mq1DAsF9/a05ZJozoxCzbnRvW53rIvtsM45qRsW9IwfILo
 Sd6e6g3g9+MVdprXd9UTi8r37hB82u2RBsC672MfAjzMwzFClM5HuyYgeYrdiJKp9pQdW4eK2WU
 8fXfrp8fyThfd4/CusuUzuO7HXy4t+68hp54yz1mUZYpQNUzxTNJq5jkBce002JOyVbJbMI1azt
 Srm0YkOcvQHrlG5vchu8kWqXde72pTgP1ZgVIvx45yxy9FOUgXOTLQyJmcm2JxJ9eCdeSH0MXEw
 pspiv61R/a8rjZpnfw0zQ7iAc9JzN1ND7pFfJrSwRbrLK8tSV7N2PDfUMN5MSAjTz3mkvOkguvQ
 O/nn7g9C7zrjQlg7uWGDQz5GEyb8DwCasVzSX5ysArFdL/lSeXx2qNHaOix2tE0bsV+H51cKj22
 tTSPTf9D2rBdejBDGsg==
X-Proofpoint-GUID: NOktrzEoRWazBREt1dJau9kV8MYjo1Ye
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699fee57 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Gjt06254oa6de200CNMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: NOktrzEoRWazBREt1dJau9kV8MYjo1Ye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260060
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32200-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A1D1E1A17D2
X-Rspamd-Action: no action

Add an extended feature flag NL80211_EXT_FEATURE_IEEE8021X_AUTH to
allow a driver to indicate support for the IEEE 802.1X authentication
protocol in non-AP STA mode, as defined in
"IEEE P802.11bi/D4.0, 12.16.5".

In case of SME in userspace, the Authentication frame body is prepared
in userspace while the driver finalizes the Authentication frame once
it receives the required fields and elements. The driver indicates
support for IEEE 802.1X authentication using the extended feature flag
so that userspace can initiate IEEE 802.1X authentication.

When the feature flag is set, process IEEE 802.1X Authentication frames
from userspace in non-AP STA mode. If the flag is not set, reject
IEEE 802.1X Authentication frames.

Define a new authentication type NL80211_AUTHTYPE_IEEE8021X for
IEEE 802.1X authentication.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/linux/ieee80211.h    |  1 +
 include/uapi/linux/nl80211.h |  9 +++++++++
 net/wireless/nl80211.c       | 14 ++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 0aa2fb8f88de..1bf806f85372 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1358,6 +1358,7 @@ struct ieee80211_tdls_data {
 #define WLAN_AUTH_FILS_SK 4
 #define WLAN_AUTH_FILS_SK_PFS 5
 #define WLAN_AUTH_FILS_PK 6
+#define WLAN_AUTH_IEEE8021X 8
 #define WLAN_AUTH_EPPKE 9
 #define WLAN_AUTH_LEAP 128
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b63f71850906..6802e6884800 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5466,6 +5466,8 @@ enum nl80211_bss_status {
  * @NL80211_AUTHTYPE_FILS_SK_PFS: Fast Initial Link Setup shared key with PFS
  * @NL80211_AUTHTYPE_FILS_PK: Fast Initial Link Setup public key
  * @NL80211_AUTHTYPE_EPPKE: Enhanced Privacy Protection Key Exchange
+ * @NL80211_AUTHTYPE_IEEE8021X: IEEE 802.1X authentication utilizing
+ *	Authentication frames
  * @__NL80211_AUTHTYPE_NUM: internal
  * @NL80211_AUTHTYPE_MAX: maximum valid auth algorithm
  * @NL80211_AUTHTYPE_AUTOMATIC: determine automatically (if necessary by
@@ -5482,6 +5484,7 @@ enum nl80211_auth_type {
 	NL80211_AUTHTYPE_FILS_SK_PFS,
 	NL80211_AUTHTYPE_FILS_PK,
 	NL80211_AUTHTYPE_EPPKE,
+	NL80211_AUTHTYPE_IEEE8021X,
 
 	/* keep last */
 	__NL80211_AUTHTYPE_NUM,
@@ -6795,6 +6798,11 @@ enum nl80211_feature_flags {
  *	frames in both non‑AP STA and AP mode as specified in
  *	"IEEE P802.11bi/D3.0, 12.16.6".
  *
+ * @NL80211_EXT_FEATURE_IEEE8021X_AUTH: Driver supports IEEE 802.1X
+ *	authentication utilizing Authentication frames with user space SME
+ *	(NL80211_CMD_AUTHENTICATE) in non-AP STA mode, as specified in
+ *	"IEEE P802.11bi/D4.0, 12.16.5".
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6873,6 +6881,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_BEACON_RATE_EHT,
 	NL80211_EXT_FEATURE_EPPKE,
 	NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION,
+	NL80211_EXT_FEATURE_IEEE8021X_AUTH,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6e58b238a1f8..3258ef2e3631 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6542,6 +6542,10 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
 					     NL80211_EXT_FEATURE_EPPKE) &&
 		    auth_type == NL80211_AUTHTYPE_EPPKE)
 			return false;
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_IEEE8021X_AUTH) &&
+		    auth_type == NL80211_AUTHTYPE_IEEE8021X)
+			return false;
 		return true;
 	case NL80211_CMD_CONNECT:
 		if (!(rdev->wiphy.features & NL80211_FEATURE_SAE) &&
@@ -6563,6 +6567,10 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
 					     NL80211_EXT_FEATURE_EPPKE) &&
 		    auth_type == NL80211_AUTHTYPE_EPPKE)
 			return false;
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_IEEE8021X_AUTH) &&
+		    auth_type == NL80211_AUTHTYPE_IEEE8021X)
+			return false;
 		return true;
 	case NL80211_CMD_START_AP:
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
@@ -12077,7 +12085,8 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 	     auth_type == NL80211_AUTHTYPE_FILS_SK ||
 	     auth_type == NL80211_AUTHTYPE_FILS_SK_PFS ||
 	     auth_type == NL80211_AUTHTYPE_FILS_PK ||
-	     auth_type == NL80211_AUTHTYPE_EPPKE) &&
+	     auth_type == NL80211_AUTHTYPE_EPPKE ||
+	     auth_type == NL80211_AUTHTYPE_IEEE8021X) &&
 	    !info->attrs[NL80211_ATTR_AUTH_DATA])
 		return -EINVAL;
 
@@ -12086,7 +12095,8 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 		    auth_type != NL80211_AUTHTYPE_FILS_SK &&
 		    auth_type != NL80211_AUTHTYPE_FILS_SK_PFS &&
 		    auth_type != NL80211_AUTHTYPE_FILS_PK &&
-		    auth_type != NL80211_AUTHTYPE_EPPKE)
+		    auth_type != NL80211_AUTHTYPE_EPPKE &&
+		    auth_type != NL80211_AUTHTYPE_IEEE8021X)
 			return -EINVAL;
 		req.auth_data = nla_data(info->attrs[NL80211_ATTR_AUTH_DATA]);
 		req.auth_data_len = nla_len(info->attrs[NL80211_ATTR_AUTH_DATA]);
-- 
2.34.1


