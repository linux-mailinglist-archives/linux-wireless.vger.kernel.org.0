Return-Path: <linux-wireless+bounces-29665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B0ACB5EA0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A18A0304D55D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4393101CE;
	Thu, 11 Dec 2025 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nt2i/Uu1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TRp3lArG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4803F30FF39
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456908; cv=none; b=iD3lvdIigecY+VghGU09P/tmoR62m2td+qSaJTYjYmhFz8C0HbAhOsn0+PUt4LU1GwcDJtwyDsf+zHCkQcOxjPGELvlN9yyEwK+C5+0FWFloHMbs2JzArcCG+ETQCfnT7fAGNzMtq6n0a0GUitjuX8BeujG6/Qk2BxoKplBnhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456908; c=relaxed/simple;
	bh=rFp+kq1AgTmzYD7+aPTYjnhWA2b8DfNr+Sthp9Lv21I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P2KOB0aEPSTIaFWoKrARLyzvBLR2F/XzAxyZ6c1b4sGcEatlRwzWQ0DNgogOjUJf0WDVX+zEoHZOqXBcsKock/ofYOqXbBlg6SyLI4iQkw3H5zES05+QGZhdCZqmjQGURv2yKMi62QvWM2YPha1HvevWRD89mfLvd981PotU7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nt2i/Uu1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TRp3lArG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAXoMW932655
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UcRQTqMqxyv
	6HJprWEheWquxVsAHkuy4EC/PxztXF9w=; b=nt2i/Uu1ozTNLvr82umxwilOM5z
	galiL6gYtbLbvb/CH2tlRFHeWn34tCS3j8U9HsEK5MmK5u5b32XawRv6MoNAqPKy
	Nbvr81ZFA/8I/Hf08AZHgnJcPGXl0rsT/i2zGWU3Z+5JqqOt9l1iqjWwShWabyad
	8zNNGBwXoRBRiJnfvCLzXWXIS+F0Br7UPtmB44fRcIdumiTOCnP+sCPrCu04S36q
	LmtSTVPhOVFlSZEMJMyD9JxbeUv1oOBG0cqvowQB6ibm0fvNc78JIIv17ECNxsyb
	3QtgKtH2qF7pGmN+TKyWIbeUNBVHTfWAHIyHhGYZC/21JfbwTiJKp9TTK3A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aym581x1s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:42 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b89c1ce9cfso11185b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456902; x=1766061702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcRQTqMqxyv6HJprWEheWquxVsAHkuy4EC/PxztXF9w=;
        b=TRp3lArGzZ5ki9i15znCyo6ePCUfaXHCYjd/gpv+Fssrk3lruUgwUMC/LZHKXZjc2b
         QyA2SvqQBXx1PsV9WBage+7YhbajXbIX9C6XgfwxP5H/NVXXsrz2yQ6zgJNijeyDLOF1
         Cc6cfFTiR+pi2Yehm9fxmSyqS1CMF206A3KHqrw9a4I6iMzfjm12qE+hroWHoOZfBJ1K
         HqACnOVjGqnZaHXprer7P5ifpi41RshZzfIeFRNyElmMU7/u7ZE/GeKh+0YlmQMrEuab
         LVq6zDhW7fKLhsGz+GsMlmas4g7VdaLjIN2wyrCZYQ+YGcCuv69ggd03bLzdJ80k898/
         HXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456902; x=1766061702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UcRQTqMqxyv6HJprWEheWquxVsAHkuy4EC/PxztXF9w=;
        b=A4/BVB4gr7lvnqmH7btbOQH5M6dUUEf0/Nn6IHC4tGMSjQ9QX+2gASHpD2uSUCLEFV
         PSTcIO1isbHpwB7beKNHFPoY05Wc4s93+PqGkRgkT96wZ3WG1j1Z8sSwaPODxS5eGsXZ
         yT/MBkn7CRk45oMn+vcA6ri4dT+dTUxCq/5HIEl3LCiQRJ7yCnos+zZchBKpaL9VBE6N
         iWvVFLcypooE3tgQYh5qyRKNOPolGouhJXsFZr88O+l3p/UiW++PTSIkpMzUfnu++mg6
         PUWQlT0/eMtJX/PYO+O6QVH/FDysGK2DTTPmWPxteG2qINO109Ip6K9npGpumUudXHl6
         YE5g==
X-Gm-Message-State: AOJu0YzEsPNy4orIsN6nLzsxhX1trHRZbX7KqWwaYI9t1rPw1Jykn5lk
	kuByV7o4KLFiDpYTTZYTCRxvTMxO9inwRclTqdxIUT6Rjjf35aDDXz7jFk/lUQXb84KOiqduSOj
	6EWgeIWQ3zmmnMSBD1Unr3uFBPntPTZLwed0jYe4dwCmCPZmpzQ1VnOqz/8tfCK2JWtRMWA==
X-Gm-Gg: AY/fxX5ZuTKWcVJphm2ThlFwDX47kcwE0OWEA3R/NorgX2UzFwJKocfOZ5oZXi2XJnm
	Mheu0h0g/yGoMdf4pW5QelqTQZBGwkPRkZtmrA8Bu4H0kCbKpkmeJilRO1OPYdLAdqmhBERbrq+
	WLniORe5rZGbB404kCHD9pGFUZd1pibdMjdSdiw2MwozRgXpFnB2SVBiWkewBgwCWuYe1cLEk+A
	HYBdhVDc+sYZ4ZuUXuJKR0Lp7trLZtlNe1sRla5vky8x7zLPez+v54DpFXT7OaGvm4sT+VO+a0D
	qxMb049v54PNKPUdyDwQffblgYDz8wIPmBxaFNOEi5ADUre0bkeoD21bSYLoewQ7KWU/ZWnMZMd
	2Uw6zL1kUN6EcTaOnyPmaknZmmv804558lX7/zuV3qA==
X-Received: by 2002:a05:6a20:734d:b0:366:5c80:d5c4 with SMTP id adf61e73a8af0-366e35c777cmr6040814637.78.1765456901563;
        Thu, 11 Dec 2025 04:41:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhYjhofirC8h+b9YdyksbiDzK6yw5XS6x31waBB2WHdgs4fKvoO09skyY3m6TVgJb1xYRD+A==
X-Received: by 2002:a05:6a20:734d:b0:366:5c80:d5c4 with SMTP id adf61e73a8af0-366e35c777cmr6040790637.78.1765456901037;
        Thu, 11 Dec 2025 04:41:41 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:40 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 11/14] wifi: nl80211: Add new NL attributes to support (Re)Association frame encryption
Date: Thu, 11 Dec 2025 18:10:48 +0530
Message-Id: <20251211124051.3094878-12-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OAVOUM-ipzdpFhX7SBaqC6rMeal1EiPh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfX4hwDzTrZqmnS
 XhNVCNRhW3Jmk19vMz/apm7HxV+eWpYs0xfrz3h9N+5wkj6bM2cAfIjCrtezhej6hBsQsiXwhwl
 G3HPuF0RrqpmXU65MGFnDPTJDYOd5z++EdKxOOIN3dlNYTs7mKhKd6+RP7+jMC9es0b7je8IqcE
 hyNm2Msa3tYVrmSaBUCeKx8ghdTgZQFgBCpmC6bkpHL6qFh9dR6546VkVZyvofwZPcyTCGcgXZB
 2kw3pPadJfUZMTPux875FqxE4E7i0LXaxLNXbzSObHc50y5SpWViRRlW0Kn9HgDYxgHiHhvnBDT
 nY8D8Yg6jyZZXuDfA8bfYz0sQUL0mIHmR6qBe1nHSrwJ4NElVBoI8+uWASWol5Ug21op6OH0z2M
 RO6IzApEn26KvYOyDXC95JlxQtnj1A==
X-Authority-Analysis: v=2.4 cv=FYU6BZ+6 c=1 sm=1 tr=0 ts=693abc06 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=jRV2BHI1QgqqTT6Ge1oA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: OAVOUM-ipzdpFhX7SBaqC6rMeal1EiPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

From: Sai Pratyusha Magam <quic_smagam@quicinc.com>

Introduce new netlink attributes for the userspace to indicate
following to the driver in AP mode:

A new netlink attribute NL80211_ATTR_EPP_PEER for NL80211_CMD_NEW_STA
and NL80211_CMD_ADD_LINK_STA to indicate that it is an
Enhanced Privacy Protection (EPP) peer.

A new netlink attribute NL80211_ATTR_EPP_FLAGS for
NL80211_CMD_SET_STATION to indicate the negotiated EPP capabilities of
an EPP AP and an EPP non-AP STA

The Extended RSN capabilities for EPP that an EPP AP and an EPP
non-AP STA can negotiate are as per "IEEE P802.11bi/D3.0, 9.4.2.240"
(RSNXE), few of which are driver dependent, hence need them to be
communicated from userspace for later use.

Co-developed-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Sai Pratyusha Magam <quic_smagam@quicinc.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  5 +++++
 include/net/mac80211.h       |  3 +++
 include/uapi/linux/nl80211.h | 26 ++++++++++++++++++++++++++
 net/mac80211/cfg.c           |  6 ++++++
 net/wireless/nl80211.c       | 10 ++++++++++
 5 files changed, 50 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8f2ad094779f..08fbd44d1cf6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1785,6 +1785,9 @@ struct cfg80211_ttlm_params {
  *	present/updated
  * @eml_cap: EML capabilities of this station
  * @link_sta_params: link related params.
+ * @epp_peer: EPP peer indication
+ * @epp_flags: Negotiated EPP capabilities
+ *	(bitmask of BIT(%NL80211_EPP_FLAG_...))
  */
 struct station_parameters {
 	struct net_device *vlan;
@@ -1811,6 +1814,8 @@ struct station_parameters {
 	bool eml_cap_present;
 	u16 eml_cap;
 	struct link_station_parameters link_sta_params;
+	bool epp_peer;
+	u32 epp_flags;
 };
 
 /**
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 5154002f2534..69814d10f86c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2521,6 +2521,8 @@ struct ieee80211_link_sta {
  *	by the AP.
  * @valid_links: bitmap of valid links, or 0 for non-MLO
  * @spp_amsdu: indicates whether the STA uses SPP A-MSDU or not.
+ * @epp_flags: Negotiated EPP capabilities
+ *	(bitmask of BIT(%NL80211_EPP_FLAG_...))
  */
 struct ieee80211_sta {
 	u8 addr[ETH_ALEN] __aligned(2);
@@ -2546,6 +2548,7 @@ struct ieee80211_sta {
 	struct ieee80211_txq *txq[IEEE80211_NUM_TIDS + 1];
 
 	u16 valid_links;
+	u32 epp_flags;
 	struct ieee80211_link_sta deflink;
 	struct ieee80211_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0074fccd4b51..85a06e361733 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2994,6 +2994,13 @@ enum nl80211_commands {
  *	This attribute is used with %NL80211_CMD_AUTHENTICATE.
  *	See &enum nl80211_hash_alg for details.
  *
+ * @NL80211_ATTR_EPP_PEER: A flag attribute to indicate if the peer is an EPP
+ *	STA. Used with %NL80211_CMD_NEW_STA and %NL80211_CMD_ADD_LINK_STA
+ *
+ * @NL80211_ATTR_EPP_FLAGS: A (u32) bitmap attribute to indicate the negotiated
+ *	EPP capabilities of an EPP AP and an EPP non-AP STA. See
+ *	&enum nl80211_epp_flags for details. Used with %NL80211_CMD_SET_STATION
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3568,6 +3575,10 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HASH_ALG,
 
+	NL80211_ATTR_EPP_PEER,
+
+	NL80211_ATTR_EPP_FLAGS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3729,6 +3740,21 @@ enum nl80211_sta_flags {
 	NL80211_STA_FLAG_MAX = __NL80211_STA_FLAG_AFTER_LAST - 1
 };
 
+/**
+ * enum nl80211_epp_flags - EPP Flags
+ *
+ * Negotiated EPP capabilities of an EPP STA
+ *
+ * @NL80211_EPP_FLAG_ASSOC_FRAME_ENCRYPTION: (Re)Association
+ *	Request/Response frame encryption support
+ * @NL80211_EPP_FLAG_1X_UTILIZING_AUTHENTICATION_FRAMES:
+ *	IEEE 802.1X (EAP) Authentication utilizing Authentication frames
+ */
+enum nl80211_epp_flags {
+	NL80211_EPP_FLAG_ASSOC_FRAME_ENCRYPTION = 0,
+	NL80211_EPP_FLAG_1X_UTILIZING_AUTHENTICATION_FRAMES,
+};
+
 /**
  * enum nl80211_sta_p2p_ps_status - station support of P2P PS
  *
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2044eeedfa8b..c0e634112c6d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2230,6 +2230,12 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	mask = params->sta_flags_mask;
 	set = params->sta_flags_set;
 
+	if (params->epp_peer)
+		sta->sta.epp_peer = true;
+
+	if (sta->sta.epp_peer)
+		sta->sta.epp_flags = params->epp_flags;
+
 	if (ieee80211_vif_is_mesh(&sdata->vif)) {
 		/*
 		 * In mesh mode, ASSOCIATED isn't part of the nl80211
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c83252cfc0bb..a41c5c1b0f74 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -938,6 +938,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_HASH_ALG] = { .type = NLA_U32,
 				    .min = NL80211_HASH_ALG_SHA256,
 				    .max = NL80211_HASH_ALG_MAX },
+	[NL80211_ATTR_EPP_PEER] = { .type = NLA_FLAG },
+	[NL80211_ATTR_EPP_FLAGS] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
@@ -8433,6 +8435,10 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 			nla_len(info->attrs[NL80211_ATTR_STA_EXT_CAPABILITY]);
 	}
 
+	if (info->attrs[NL80211_ATTR_EPP_FLAGS])
+		params.epp_flags =
+			nla_get_u32(info->attrs[NL80211_ATTR_EPP_FLAGS]);
+
 	if (parse_station_flags(info, dev->ieee80211_ptr->iftype, &params))
 		return -EINVAL;
 
@@ -8806,6 +8812,10 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 	}
+
+	params.epp_peer =
+		nla_get_flag(info->attrs[NL80211_ATTR_EPP_PEER]);
+
 	err = rdev_add_station(rdev, dev, mac_addr, &params);
 out:
 	dev_put(params.vlan);
-- 
2.34.1


