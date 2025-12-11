Return-Path: <linux-wireless+bounces-29658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5144BCB5E85
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 439363002CF3
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ABE3101A0;
	Thu, 11 Dec 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C8+aTyUT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ImrE1mPJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF463101BF
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456888; cv=none; b=TBG/Dsbk3h9V3+c3izR7I3KeMe4s0dz4YZonWv5w6yc5hqmO7yoa8FUsTWkEDeJ10mqBBGL5a1R+sGAmfZ4APKM1DTiKc2iC8icIdzGxn4wDojInJEAjLmouqZAV60BjtnqHrYv5j3FqSCY//ByCkEIgXN4pvbHPlLlkBULcAsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456888; c=relaxed/simple;
	bh=rZgyxPmCJ3qZA260ckwXKbXUdwXCkRetv0KFjIruRhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loshohsAk2ePs+eg9/vwIX58VEWOALn/ATlCcOfQMhQ5iIZ1cF8+MwN/Xvpqmeedpp/7eNV6AgtzcHEeSPBBedN/d+K0oAsJo9auuFi4Q+TS1x1kN/5bsqBW/+V6YoWQNb4vDPQK62UWSRURBcyI9YgkxAqP4WBCWqTs3StMmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C8+aTyUT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ImrE1mPJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAXwUY1775361
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G5Wv4RHE/QqcA9yHpQx5RNTPbi/3xqkIyFNUyIagQ1s=; b=C8+aTyUTr4rurhNb
	rWwsk8DiDRh734/aPKYoncjl55xpOeP1ZVXL5L8lQCiFiHwTmerJ8Vl7DlJa2yZ9
	9Z4lYBKGIDqm0LNRBNV0tef+ZucaKDwNtYjN5HqLP6kezinSRacmKt4snNwCY/Yz
	wGqJAyAQNckQlbTYqj23xKf15eAVvbj0ZUa0vIqMq1MZPl9ZhJpPtCc/LBPppnx/
	wzYPV0WCs3vU8Tz17mOWAQ25bfiYjCkBVmc6mgvIlJ97mlXTR+NxoA/E6PyNLnVk
	3UI8OR7qvk4jBIQvIw/ntX/fMC/8E6HdrEXbzUZORbprOLZjkWrygssxOuLje0Bq
	ho1U0w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayt708uyp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b80de683efso14899b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456884; x=1766061684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5Wv4RHE/QqcA9yHpQx5RNTPbi/3xqkIyFNUyIagQ1s=;
        b=ImrE1mPJtEdHWC+TOZKsshdAffjq8F0wmCBKn0DOQ2QqhOD7oR8QrfnicMkDOf5gCS
         S6jJsF2etWX/18HndxgyTIVYaD3D5CqGrPfNQndha8gJEZ/q5ASs8kGhJXz/lf31YMjn
         ktIQkM6GijmRR8IwZmtpRQI3w3sU+ZMK2thrY2OBYxXmUhUzF3huw1+aTUTuiqvAdsPA
         BCvJq2jIyPJhqiaVX3Hrz7G07/gbd0d43nwkRfj6G/PFaxQd8d3NaV1YPSO67XBHbbcd
         69F4ybCGsDcz6pJtfAQCROIx2ox9HxHqVzLx8acE7ZpivJ4R9cdU5moQS8VTWl1T06JM
         ZU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456884; x=1766061684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G5Wv4RHE/QqcA9yHpQx5RNTPbi/3xqkIyFNUyIagQ1s=;
        b=dl9h61nTnemr4b3iSwiCSXdSKZ0pzi1ZvGcY4uqyu9JPiGFjCgjOWEXAuyglc4Flk1
         8jVM+VYpq1hDjaYodbe2u6nHN3BvMLpZnc6HYx+bUdmSfy+f1iFYfMyK2aGTU9YbvprO
         slC56JGEpPyZEmYBN4Bcg6uDj4kcd8rLvkA+rJo3o5VivUtyd58Zmji8/wb6sn16ObTK
         pcWVkAkWXhRsTKqftNzJAxg+KqvTK2MjL0w4T+3/r2q+XFoL3zkabUgG0RbxDRd7ZqBE
         CSJI4pwre+W6eZJVDEiQaSiIkTr6vjfCopL8hAa+pkDgI59tkwHESiBCrX/IZmaT7voS
         lSew==
X-Gm-Message-State: AOJu0YySw487CYkYuWzuFZ637N1AkSGUCmUbyg7MJVLfBLkXWeC1Kpw+
	ivQQA+DkhKCgm6D6jhonf1A9g0wXYibH/KKuSqvfDO1LkEXFTEhHsPxuZYrwHEsvwZ7xjk8X8xT
	QjM58TDejPtdUIrc/Q95lawCEm2ijDMMFXzzdZ+ZVL0p36OgSSsIXGB3ciEN3ngqWw6NMrQ==
X-Gm-Gg: AY/fxX4wR8/iLwo6OyZsgxd1UdJD1eD82gag9rpm4rvEBhRLhspKARDEQylG8FKt9bf
	TAmne2ChtnZcgLbOYNj+ORnGWJlNI1retG15vpE8hkOiSDu642Rym3/NGAuRJysu/HJaonTiBmw
	EzwLHxKBGIdo2djCeM+Jin6rrEH3qGvsoGKGxM1H3zSm2y1iWTbEGewNwgo6sM5QPLTbKbyrsoB
	Prw0RS8KWQdbZiuWq997vey/oZr9eI0GPukZvp14ElrNKjqVmM7QkgNoTAJqGKXgoEQ5kY6x8pC
	OS343R8oP4CPVduy24TN24TVJq0j1PK/k9sFMhcc0ikHcQLf1Wxo52o62vmMPTTDx8Yg3UEYqDx
	Ek8nsrosh6dGcTp8UsxNfOscirFyTrgVYur3lnjRnSg==
X-Received: by 2002:a05:6a21:6d90:b0:341:5935:e212 with SMTP id adf61e73a8af0-366e0de820dmr6221480637.18.1765456883900;
        Thu, 11 Dec 2025 04:41:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAetZiRJ4rEuVunrz5xAXlRutOFi3247KnZfkvJwL24NsZxQ1THw7frQ5SWqIM5bdb7s0hPw==
X-Received: by 2002:a05:6a21:6d90:b0:341:5935:e212 with SMTP id adf61e73a8af0-366e0de820dmr6221464637.18.1765456883430;
        Thu, 11 Dec 2025 04:41:23 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:23 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 04/14] wifi: cfg80211: add support for key configuration before association
Date: Thu, 11 Dec 2025 18:10:41 +0530
Message-Id: <20251211124051.3094878-5-kavita.kavita@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfX7LgYSfkmkh7x
 qHBWm1FHMEQvvxWTKh2HpRglkv2AV96iQJm6XZ++qusUwP2i5yBqdvePX3uf9Veus8gt2TK6y1W
 moJ/tkMzTCiRg9Kb8JTtqiy5udsm8GXvLBCAb+OYk0P8igT0Q+4TJ9oHcG48L2w6LztyJnLfFBh
 CagX8pXF8Lbaa5GIwHv+P9qB3dyt03w4R4qvpa7OPYOSkxNKviF8W+M3Dp+Na+84T/s3GqsTYzB
 g0SYMgs8ZCA21gq30Q9Mv9aHqFWknubYkWdR5pkLiSQP9x53aQhW+gV69FVryyE6k/eENl2uRd/
 3xIXlBAwu8vYQNU9VbSgYDyLlpiL/pkxo07oE0dUBNwCaxdURUN+wVgdbgRtxbjnnyFBFL539NQ
 ipvSaijUlsD/FCTubh0f/dxNN6jdTQ==
X-Authority-Analysis: v=2.4 cv=WYIBqkhX c=1 sm=1 tr=0 ts=693abbf4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=n5ImBpZBjOo8wqhaqK0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: mDLCXAeDdnB3HaB_oDhTAfLjAHwDXEb_
X-Proofpoint-ORIG-GUID: mDLCXAeDdnB3HaB_oDhTAfLjAHwDXEb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

Currently, cfg80211 does not allow key installation, removal, or
modification prior to association in non‑AP STA mode. However,
Enhanced Privacy Protection Key Exchange (EPPKE) requires encryption
keys to be managed before association.

Introduce a new netlink attribute NL80211_ATTR_KEY_PREASSOC for
NL80211_CMD_NEW_KEY, NL80211_CMD_DEL_KEY, and NL80211_CMD_SET_KEY to
indicate that key installation, removal, or modification is permitted
before association in non‑AP STA mode.

Implement support in cfg80211 to manage keys before association when
both the NL80211_ATTR_KEY_PREASSOC attribute and the
NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION feature flag are set.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h | 10 ++++++++++
 net/wireless/nl80211.c       | 30 ++++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 5c33486c6380..f78f6e7c4ab7 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2973,6 +2973,14 @@ enum nl80211_commands {
  *	primary channel is 2 MHz wide, and the control channel designates
  *	the 1 MHz primary subchannel within that 2 MHz primary.
  *
+ * @NL80211_ATTR_KEY_PREASSOC: flag attribute used with %NL80211_CMD_NEW_KEY,
+ *	%NL80211_CMD_DEL_KEY and %NL80211_CMD_SET_KEY indicating that the key
+ *	configuration commands should be allowed before the non-AP STA is
+ *	associated. This is used in cases when the authentication method
+ *	requires key installation/removal/modification before association
+ *	(e.g., EPPKE). If set, transmit key data to the driver for installation/
+ *	removal/modification before the non-AP STA is associated.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3541,6 +3549,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_S1G_PRIMARY_2MHZ,
 
+	NL80211_ATTR_KEY_PREASSOC,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d7151fc5cf0e..f297639b916f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -932,6 +932,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
 	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
 	[NL80211_ATTR_S1G_PRIMARY_2MHZ] = { .type = NLA_FLAG },
+	[NL80211_ATTR_KEY_PREASSOC] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -1659,7 +1660,8 @@ nl80211_parse_connkeys(struct cfg80211_registered_device *rdev,
 	return ERR_PTR(err);
 }
 
-static int nl80211_key_allowed(struct wireless_dev *wdev)
+static int nl80211_key_allowed(struct wireless_dev *wdev,
+			       bool preassoc)
 {
 	lockdep_assert_wiphy(wdev->wiphy);
 
@@ -1675,7 +1677,10 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 		return -ENOLINK;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-		if (wdev->connected)
+		if (wdev->connected ||
+		    (preassoc &&
+		     wiphy_ext_feature_isset(wdev->wiphy,
+					     NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION)))
 			return 0;
 		return -ENOLINK;
 	case NL80211_IFTYPE_NAN:
@@ -4995,6 +5000,7 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	int link_id = nl80211_link_id_or_invalid(info->attrs);
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	bool preassoc;
 
 	err = nl80211_parse_key(info, &key);
 	if (err)
@@ -5010,11 +5016,13 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 	    !(key.p.mode == NL80211_KEY_SET_TX))
 		return -EINVAL;
 
+	preassoc = nla_get_flag(info->attrs[NL80211_ATTR_KEY_PREASSOC]);
+
 	if (key.def) {
 		if (!rdev->ops->set_default_key)
 			return -EOPNOTSUPP;
 
-		err = nl80211_key_allowed(wdev);
+		err = nl80211_key_allowed(wdev, preassoc);
 		if (err)
 			return err;
 
@@ -5039,7 +5047,7 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 		if (!rdev->ops->set_default_mgmt_key)
 			return -EOPNOTSUPP;
 
-		err = nl80211_key_allowed(wdev);
+		err = nl80211_key_allowed(wdev, preassoc);
 		if (err)
 			return err;
 
@@ -5062,7 +5070,7 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 		if (!rdev->ops->set_default_beacon_key)
 			return -EOPNOTSUPP;
 
-		err = nl80211_key_allowed(wdev);
+		err = nl80211_key_allowed(wdev, preassoc);
 		if (err)
 			return err;
 
@@ -5103,6 +5111,7 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 	const u8 *mac_addr = NULL;
 	int link_id = nl80211_link_id_or_invalid(info->attrs);
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	bool preassoc;
 
 	err = nl80211_parse_key(info, &key);
 	if (err)
@@ -5144,7 +5153,9 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	err = nl80211_key_allowed(wdev);
+	preassoc = nla_get_flag(info->attrs[NL80211_ATTR_KEY_PREASSOC]);
+
+	err = nl80211_key_allowed(wdev, preassoc);
 	if (err)
 		GENL_SET_ERR_MSG(info, "key not allowed");
 
@@ -5172,6 +5183,7 @@ static int nl80211_del_key(struct sk_buff *skb, struct genl_info *info)
 	struct key_parse key;
 	int link_id = nl80211_link_id_or_invalid(info->attrs);
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	bool preassoc;
 
 	err = nl80211_parse_key(info, &key);
 	if (err)
@@ -5199,7 +5211,9 @@ static int nl80211_del_key(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->del_key)
 		return -EOPNOTSUPP;
 
-	err = nl80211_key_allowed(wdev);
+	preassoc = nla_get_flag(info->attrs[NL80211_ATTR_KEY_PREASSOC]);
+
+	err = nl80211_key_allowed(wdev, preassoc);
 
 	if (key.type == NL80211_KEYTYPE_GROUP && mac_addr &&
 	    !(rdev->wiphy.flags & WIPHY_FLAG_IBSS_RSN))
@@ -16781,7 +16795,7 @@ static int nl80211_set_qos_map(struct sk_buff *skb,
 		memcpy(qos_map->up, pos, IEEE80211_QOS_MAP_LEN_MIN);
 	}
 
-	ret = nl80211_key_allowed(dev->ieee80211_ptr);
+	ret = nl80211_key_allowed(dev->ieee80211_ptr, false);
 	if (!ret)
 		ret = rdev_set_qos_map(rdev, dev, qos_map);
 
-- 
2.34.1


