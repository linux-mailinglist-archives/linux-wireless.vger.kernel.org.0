Return-Path: <linux-wireless+bounces-30812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7CBD1E59F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 12:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A2253011EE8
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 11:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11E6378D86;
	Wed, 14 Jan 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="onst81H3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YspuHcXS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF8736A027
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389556; cv=none; b=F+TbbBoiNiGuWS9Py2hLRs4pIx2Am5KgbjdX9rcDDpXctdw0DXou8Y00wDAOygQbl/CEUBYr4/CUtTGWitQBO/7v+CDZ+qPs4HFCUn/6cCMIE1fpS6MXZJ1loJ6aZD4bXZK1jDlZxuyuoNiQTgFAgZbiNrvYXnd8EbgpEZPS/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389556; c=relaxed/simple;
	bh=yeqwOf/Pcbc6K53Z1nHV/lzm0psERnQvmerLhhET1Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=deNKTC4vi91tXO3t0vimjgC7pyeP9iCJWxsm86DtsM/gtejmnRENyC2wCn1eF170fuSHW0PKS1xrDfKrui1SwRHGtmfymeEKbvtiPpR2/4A7L7esO51WqRX/OvihMztq357Hy8QVQJWv58byYqd9892zuRri0wxCYHSvUwFJ1QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=onst81H3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YspuHcXS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E9jxqL3296453
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3rHwnKfUbYa
	dWKaX37lSvXY/hR/kYpZ2vwYwhcET168=; b=onst81H3OJLweyvv2RHPEZZ4eS6
	bO1O8ZBsfLRWF92+fRMZ/rY1uKqBcH85oNhz2lY7UsDxX5WoDKARLRa2eEE4NA1A
	rrkQjnYxgxJPlFhxoWPh2ng/EBWJrxoI9P8i4Ts779Hf7VdwaE1+uAWAeNuHU/Gv
	osQU4R27x2RUR03GESYI7yrlLZYTzg9GNuLDQdT9vczcn289hCPNZ0CZdBQRb7fM
	RZH56r3hfewCRCP+SnO7EPykDUcB7ctkTmYIvEog4DH8ITQYSqKSO0Dp58qvi7g1
	eG56din4voC38txS8N54nH0xHSp01JJU0Z+9qDruKrgLXtxu08eGlV68bqw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp8t2rcrw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c551e6fe4b4so3075029a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 03:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768389553; x=1768994353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rHwnKfUbYadWKaX37lSvXY/hR/kYpZ2vwYwhcET168=;
        b=YspuHcXS+OhfDQvgufVO7oceOEV9i+SYjH0p3ACgocxGhnEoJ6kTh13jiXoLhxnQVt
         pMCNk/ytvpunp+XOSRJwQZux0rrx98XgGr51JzZCl18/etmK5Ai8FXebmzpd2DCCm1zd
         1KdI6ZgWK+j7/9gRsjkcwLWYhCMK8awKii8l8vkE2+VGMziroATFBpHlbcAWyaljGUPS
         EPjf3mtAseFKcmfA6GmM0ayTBqX1QcTawR1glR4LcUGv79SaX+4q2yEardYBEHGLfUpo
         Sm4ydM0KzaVJzvkfecRO97Yht/q1CQdJUeqLO/uFCkn8KxUmZ6ueCfUJ6OavBAexE+u2
         cDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389553; x=1768994353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3rHwnKfUbYadWKaX37lSvXY/hR/kYpZ2vwYwhcET168=;
        b=Lmxt+oreso1W4eOGR2lh93AJ5T9sh0d0OnvribJ6tsIf8sGcFtDPZ/gdp1NKxX04vu
         BWlcS0UEmpTGAjtH4odSmqhrvd3V9la89WwDqUjH/O+dH/85CBKRuBS87HkKisX7D0jM
         gi3dyYhtqSegAf4zYM2ZQj6bWKFqADZH1AVmKNTvvFXUMtENPXJrdNWNEdNWw0UaFjfg
         qawEgV74E0VgGcSqwL4LzLy04gHtopSajaV11eWvqy+DRSjTVN/q+GYYOn0d5Uz6Ay8o
         nR094oUskPMrIWw/ZtRJdWGOISuFBkjDMrBqiae2IojXL5QiuJXWth0JG7S26VO0fXrh
         18jQ==
X-Gm-Message-State: AOJu0Yynx+Dogro+u7Rd/WWBRlw/EP89VA0/AWlY0rCuRIQXkc7FCPcM
	zSIyOchoCntpYdqmqNp2zBIpj15WwjEFfN+S7qO9LBhkjFX/xpw3HKy72NcqN+ZnmHsGEcodp8D
	DQ93IJY08MvWH+DOE0XAlSDXPAHWwxsmoWAItOJ6afVD2nm0Nwd4P0yBe0FEBJsDu9ge6cQ==
X-Gm-Gg: AY/fxX5b4T8R+Dlkm74vIE8i75bTuXLiwoBfBcnWl55fprY6sLRw8x+s1uDnl8999H/
	JOhDNf9xIQL1VDRHwfMfwzkw3uwxFg6+gc4RgdH1X0CZWUB/c1XfuHuHhztJyu0/DgjWfHAGdZ+
	9xHHN+EDulhL8qgp8FL2ek6Zdnf1MiiDm8BY09rU1BsNgnKfIMDIqmS+fvy6bhkEKwWKlmZEMuz
	0hhDX9tn9PdYI0M1akenv+nL2XgbLAV5xviMkiLOffel1M40JZT1u9i4ImQ+HtLsI2//fUT3PIR
	Pcfe0XG6WJWdiM0PAEtqIecFLNnpfJQWwQiIMBfSt2lg4QKJeaAB7yf0O1Zu/0z3g9E6J8OwuFw
	6auFX2mmMVHNXa86hJmDr3Jk+crRUzlKpqgFXyp+OoA==
X-Received: by 2002:a05:6a21:339d:b0:366:14af:9bb8 with SMTP id adf61e73a8af0-38befc0a648mr1815720637.66.1768389553066;
        Wed, 14 Jan 2026 03:19:13 -0800 (PST)
X-Received: by 2002:a05:6a21:339d:b0:366:14af:9bb8 with SMTP id adf61e73a8af0-38befc0a648mr1815692637.66.1768389552517;
        Wed, 14 Jan 2026 03:19:12 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm22402512a12.32.2026.01.14.03.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:19:11 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v4 1/9] wifi: cfg80211: add support for EPPKE Authentication Protocol
Date: Wed, 14 Jan 2026 16:48:52 +0530
Message-Id: <20260114111900.2196941-2-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
References: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YPaSCBGx c=1 sm=1 tr=0 ts=69677bb2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=K9bSqJOrJGfH4NCufdQA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfX0N46WZKMcqql
 1EqHe62d+ECVdwH0Gk6Ax38NyHb5eQ7hDGWDfl9aXpLsflxmTrYjDzZIYxSzHPF85u1Zg3XTHN+
 MKCWqpT4RuvZa5ChrfAdO9PDwhyt9mFzvgXQPJVt9ca5v1RD+3z8Mf3LcLAj9t4b4F/9yZoEjon
 oCAOvCrMPPmKgawMJidAWOhYU8PxGvDYrtzeZFxFW6qlIN/hq5OMHIorlfSTftj+udg1h949mCJ
 yp4MX09c3NRpwrKwL3yR7QajUJ5VEYOqs8H2ff/KOiwSqlpTLSMhEchVo3HIQVr/8HFXDjy1Tv2
 hLFs2sBVfRigiKusclHmrot10ECOfEhrLXIv1rbpFOdKsPnhIphAV95+II53DkXGUyoYzG9gTCQ
 jvOQ66IiOvVsrj7IFdZqb9LfCTbSMDxmltN9ARCmi8DrX5ABKT73qkPJtfgIU1bGgljK22HxgmE
 BHDeisEFvZ6LvEoUyGw==
X-Proofpoint-GUID: dus9E5oRTIQYRTDqyeOvwTDh2Q1EkSbJ
X-Proofpoint-ORIG-GUID: dus9E5oRTIQYRTDqyeOvwTDh2Q1EkSbJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140093

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
index 964e1c779cdd..351d4d176f87 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5429,6 +5429,7 @@ enum nl80211_bss_status {
  * @NL80211_AUTHTYPE_FILS_SK: Fast Initial Link Setup shared key
  * @NL80211_AUTHTYPE_FILS_SK_PFS: Fast Initial Link Setup shared key with PFS
  * @NL80211_AUTHTYPE_FILS_PK: Fast Initial Link Setup public key
+ * @NL80211_AUTHTYPE_EPPKE: Enhanced Privacy Protection Key Exchange
  * @__NL80211_AUTHTYPE_NUM: internal
  * @NL80211_AUTHTYPE_MAX: maximum valid auth algorithm
  * @NL80211_AUTHTYPE_AUTOMATIC: determine automatically (if necessary by
@@ -5444,6 +5445,7 @@ enum nl80211_auth_type {
 	NL80211_AUTHTYPE_FILS_SK,
 	NL80211_AUTHTYPE_FILS_SK_PFS,
 	NL80211_AUTHTYPE_FILS_PK,
+	NL80211_AUTHTYPE_EPPKE,
 
 	/* keep last */
 	__NL80211_AUTHTYPE_NUM,
@@ -6748,6 +6750,10 @@ enum nl80211_feature_flags {
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
@@ -6824,6 +6830,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_DFS_CONCURRENT,
 	NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT,
 	NL80211_EXT_FEATURE_BEACON_RATE_EHT,
+	NL80211_EXT_FEATURE_EPPKE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 225580507a4b..8f3a27b7d4fd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6473,6 +6473,10 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
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
@@ -6490,6 +6494,10 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
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
@@ -11956,7 +11964,8 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 	if ((auth_type == NL80211_AUTHTYPE_SAE ||
 	     auth_type == NL80211_AUTHTYPE_FILS_SK ||
 	     auth_type == NL80211_AUTHTYPE_FILS_SK_PFS ||
-	     auth_type == NL80211_AUTHTYPE_FILS_PK) &&
+	     auth_type == NL80211_AUTHTYPE_FILS_PK ||
+	     auth_type == NL80211_AUTHTYPE_EPPKE) &&
 	    !info->attrs[NL80211_ATTR_AUTH_DATA])
 		return -EINVAL;
 
@@ -11964,7 +11973,8 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
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


