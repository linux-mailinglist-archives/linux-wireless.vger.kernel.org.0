Return-Path: <linux-wireless+bounces-29786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2BBCC11A0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCB763034A0D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6804B344039;
	Tue, 16 Dec 2025 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9S5t2Vd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fE+eavFd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4815E343216
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866473; cv=none; b=ZM1r76gKsGI+NAP1YejRqc+POCsznxWx9iH81BXK6Ca4TefbYn5huc5WpFOqReahuPCc6sZo95EyAH1iBBchy16vJuHUlK0mX5S2I2tBihTxzp7XQGNOvX4eaxReKA5e4su5sFN1EKYkj6L8QOUrN5vHf1nOWQzARg/8k6bbw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866473; c=relaxed/simple;
	bh=T1QOWPHxv2qAAhq3NV8qsOV//ViWgk9jyY2UsXakdPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HcHHoLFm724PzuYh5OdHDqIN3gMW32PcZgzALhANoaZzvwgaEhFVsV1gxI8t92XyFw6JXo3JEYyzyV1UlC5v8PE7zQ8g8rvIqxX6QSRU/HHDp0weqiafFebrtfTkyinipIs9HaCz5Tb5jLpoS6Ae9zxFC+CGYPIuljyaZCTP+HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9S5t2Vd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fE+eavFd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG50f9c2282192
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=OVwV1V+UveK
	otdIMhguotgFCtdYk9+7uPZlz6Nhmt9o=; b=E9S5t2VdMs6k0p4jv5tSWpkyVxC
	1qcneakE+c/VB4nNCjWhayyvkFXkGz/rye+qHTqQqUAuxxcHYzgDnKlgjCQuXdjq
	/Ic5bsA2INmmOLc0ky0yTwwse6DLa0csiWCdb0VWQ5pxKAztRi7rHFrjeoqp5PYQ
	5NrCSJkEY/SBqLvk63ufTD7PpX+/H1c6CStZmhXAS7cEEdVdIcDyhADlLOiPAHY3
	TQYGXOGAJJ77ICtYWWqivfJIm6A7wRb80JWaDaPSSmJKMv6QNFFkctzfEkRSDMhw
	/0LsNliQpJ+YfkDI3noSLzvpJ/y301IUg3xC6+y9X84M5u4wW9v0xbdlHvw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2peractp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0c495fc7aso31951495ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866460; x=1766471260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVwV1V+UveKotdIMhguotgFCtdYk9+7uPZlz6Nhmt9o=;
        b=fE+eavFdEt2Z5t/lHEt+nZDRPrbzEARhuYXxG98tyDRoFtcIpA/M87hUH2PJiVTUOk
         WkZRWlT3ao4o7vgtc8GXgRSyBQ3yL3TcEii2a2IesAa496aHHTq64W/otgWYddBd/u7V
         TxOWpt0KhyHIkoZlLzFl/JG5y3qbeowJEHEt4BOKAlLvDn7BHqVdZ/aH9fX2egxlmNnM
         UJmM7pAZbvkdjNyqSz8YI+5iMFUs28eanPVjaZjNvMwT8NzuRf/iskdga0UGqQBEhjOn
         DAE1YACrH7uGYnKxuuD2orwu/o+XEQ68FABH9JeaHawEf+Fvsv56q45qkNJbYoThwYFF
         5NCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866460; x=1766471260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OVwV1V+UveKotdIMhguotgFCtdYk9+7uPZlz6Nhmt9o=;
        b=QL8oNYkFH3mqC/9ktmPVuDVwMgBkMmD6VQEh0NEn0tgK4CjzGPpZl9vLofHNNZsUMH
         O6dqvN0zh5XUTdNZkj5R4+QKr3yT/+qwiFjcbdItqMDnlQf1E0rR/l52EOvNa1qe75gC
         Z2qKVisTyOxBql/wzFx7FGLDz6B85FypfxSr64xsNAQ4bfw/Uc4U3HotTj9/EtCjRqmW
         M9u/EuAofps47ApalacuVoejogOl4gssPlmKRnDd7ENrDLpKmzw1waoAg1OEaLok7YWX
         QZRsj4xsYxvKfuVERXhdEu3xyB/5Rs7PHenPK3AaedgeHzRCy5bPjkD+13xgGuv4V0Aq
         qm5g==
X-Gm-Message-State: AOJu0YwIFwX1u4/8d0yRLjce/MbmyR0FWlwaozNxcibsI7nO0cuL41PH
	HQRZXzZEuljHLktaZDcrZ0tM2F+fBD+nL3aMudMg5U/DiHHujXUYbjWiRvTPj50ZtbHMWEYP5LV
	mPUNuCaNIeP2QLwsJEdis8XpO8rkiGBNiFLzIdcqsbqpd+h5DChFSjGkV6AngzIXH1dUx9EIzAG
	nuqQ==
X-Gm-Gg: AY/fxX57PGtlmeMFjmwt0K5sqPAwlBzvrKFMX299w3fh61reTAM0CxJLCFD1QH1QRdq
	iZlTGRcJTXsucT2OUUaLGHqwshQUHKbUc4TOMmA8qek4zWoGhLz4IaYpOKEipb9DvvSo0imBwWH
	Lf5xYmDy9sikTAwKDsKU/zOQTrzV4L1Vyw72TEOZW+uEVHbV/voh8+UBGYf96Vh8KzEmiu5PDu3
	MyI7JnvrHeX31p1CGw7MSnm1I/h4KwO4+kd1qp6ietnijgF29mqjpu2nHs9UlF9tiN4I3pf1s1u
	eCBLJraiwT/+scsvReYILXhJ/QRT5e9EPzAkqzkydPMLp8yn+1mftSr7c7bRI7oBLwp1Oe6fwXa
	PV8bhfuYoy7B9a4s1lmv2QZDNAEtTP3o+dWK2dKtHuQCSxt/BTx5qNQ==
X-Received: by 2002:a17:903:120e:b0:295:24ab:fb06 with SMTP id d9443c01a7336-29f23b7620amr140160325ad.22.1765866459482;
        Mon, 15 Dec 2025 22:27:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4RgX0xouq1E4iL6jyrI6cC1UNHpJX2jFlfVXyrKXKO7c78VRyGZg6oshZElTzxp8QSEuauA==
X-Received: by 2002:a17:903:120e:b0:295:24ab:fb06 with SMTP id d9443c01a7336-29f23b7620amr140160125ad.22.1765866458771;
        Mon, 15 Dec 2025 22:27:38 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:38 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 12/13] wifi: cfg80211: support disabling UHR mode
Date: Tue, 16 Dec 2025 11:56:55 +0530
Message-Id: <20251216062656.1738022-13-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
References: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y3n4U2tg3LuPM0697GVaDup6ypGJggzA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX9U1ORAueSWY/
 Og1Q0T0iuyrNTjyUph67Bj33avf1Cvz98bUsojPmkUDhqZrgCBUqTJUJogQnfTd9T452cXs674K
 suvUxzVBSESly+3GgYGyYybDZ2Jll8leCM9MoLrBbBRhfLyk3fsGTppx3gSW+KAnlSWecruiJRS
 9ts6VjYNDIdc7JK7/l8+vJxjhrOls8J5W1NAC8oXfblOnXdzUC8eXgf0VvMC1NtlrTtY5BktdzV
 jqSQw9GQreXIIC3H3i2JCazsuriu5heWymDNMw69Qk87FaezfSWRaeppDkU8RTWiUWL8aJrZp1V
 oYoUvZExxuFyoieX+IiuSbQnp1rFJg2/WuVAZ2gCZk+ChT0LQdXFIm86ONjpJ/HbKLWOO5RLbIw
 dvJ9YETRTjmMbuTs5q9wDGx9CMATBQ==
X-Proofpoint-GUID: Y3n4U2tg3LuPM0697GVaDup6ypGJggzA
X-Authority-Analysis: v=2.4 cv=PYHyRyhd c=1 sm=1 tr=0 ts=6940fbdc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=qsZ2wIBKZbV9ayqZ97wA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

Allow userspace to disable UHR mode during association
via NL80211_ATTR_DISABLE_UHR.

This attribute provides a mechanism for userspace applications to
explicitly opt out of UHR operation during association. It is
necessary because certain regulatory or deployment scenarios may
require disabling UHR features on specific channels or devices.
By exposing this control to userspace, we ensure flexibility and
compliance without relying on static kernel configurations.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 4 ++++
 net/mac80211/mlme.c          | 9 ++++++++-
 net/wireless/nl80211.c       | 7 +++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 85321948b7ec..a72247b05cf5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3307,6 +3307,7 @@ struct cfg80211_ml_reconf_req {
  *	Drivers shall disable MLO features for the current association if this
  *	flag is not set.
  * @ASSOC_REQ_SPP_AMSDU: SPP A-MSDUs will be used on this connection (if any)
+ * @ASSOC_REQ_DISABLE_UHR: Disable UHR
  */
 enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_DISABLE_HT			= BIT(0),
@@ -3317,6 +3318,7 @@ enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_DISABLE_EHT			= BIT(5),
 	CONNECT_REQ_MLO_SUPPORT			= BIT(6),
 	ASSOC_REQ_SPP_AMSDU			= BIT(7),
+	ASSOC_REQ_DISABLE_UHR			= BIT(8),
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9e957378f43b..1bda6a379bbc 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2976,6 +2976,9 @@ enum nl80211_commands {
  * @NL80211_ATTR_UHR_CAPABILITY: UHR Capability information element (from
  *	association request when used with NL80211_CMD_NEW_STATION). Can be set
  *	only if %NL80211_STA_FLAG_WME is set.
+ * @NL80211_ATTR_DISABLE_UHR: Force UHR capable interfaces to disable
+ *  this feature during association. This is a flag attribute.
+ *	Currently only supported in mac80211 drivers.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3546,6 +3549,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_S1G_PRIMARY_2MHZ,
 
 	NL80211_ATTR_UHR_CAPABILITY,
+	NL80211_ATTR_DISABLE_UHR,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9b730aa5fc3a..9d5906682a1f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6020,6 +6020,12 @@ ieee80211_determine_our_sta_mode(struct ieee80211_sub_if_data *sdata,
 		mlme_link_id_dbg(sdata, link_id,
 				 "no EHT 320 MHz cap in 6 GHz, limiting to 160 MHz\n");
 
+	if (req && req->flags & ASSOC_REQ_DISABLE_UHR) {
+		mlme_link_id_dbg(sdata, link_id,
+				 "UHR disabled by flag, limiting to EHT\n");
+		goto out;
+	}
+
 	uhr_cap = ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif);
 	if (!uhr_cap) {
 		mlme_link_id_dbg(sdata, link_id,
@@ -9727,7 +9733,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		if (req->flags & (ASSOC_REQ_DISABLE_HT |
 				  ASSOC_REQ_DISABLE_VHT |
 				  ASSOC_REQ_DISABLE_HE |
-				  ASSOC_REQ_DISABLE_EHT)) {
+				  ASSOC_REQ_DISABLE_EHT |
+				  ASSOC_REQ_DISABLE_UHR)) {
 			err = -EINVAL;
 			goto err_free;
 		}
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index cb0592c292b4..1e18606c5e44 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -935,6 +935,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_UHR_CAPABILITY] =
 		NLA_POLICY_RANGE(NLA_BINARY, NL80211_UHR_MIN_CAPABILITY_LEN,
 				 NL80211_UHR_MAX_CAPABILITY_LEN),
+	[NL80211_ATTR_DISABLE_UHR] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -12399,6 +12400,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_EHT]))
 		req.flags |= ASSOC_REQ_DISABLE_EHT;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_UHR]))
+		req.flags |= ASSOC_REQ_DISABLE_UHR;
+
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK])
 		memcpy(&req.vht_capa_mask,
 		       nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK]),
@@ -13278,6 +13282,9 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_EHT]))
 		connect.flags |= ASSOC_REQ_DISABLE_EHT;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_UHR]))
+		connect.flags |= ASSOC_REQ_DISABLE_UHR;
+
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK])
 		memcpy(&connect.vht_capa_mask,
 		       nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK]),
-- 
2.34.1


