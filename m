Return-Path: <linux-wireless+bounces-29778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A649DCC123F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99EC43001857
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515A8342511;
	Tue, 16 Dec 2025 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dx03zvUO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aBA6bWed"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8237342CB5
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866456; cv=none; b=Z8Urh8zKwvbqJVdoX5eNUM9Lpit9UC3N6uBtVAbfjagA8wGjQ7V0XcXRisPQDt/BuqQrnnZjIdUSAVhBCRFZcncJ3ZOrGgYhYPdHEird0v+0ul4CghSDFB/tLeiC8MmB1N0ePlUthQiXzXpHJwC/kwLTijBZzLtKgLnv+vXX1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866456; c=relaxed/simple;
	bh=guqzePKhHmYrzANZHEZ+LjmtnN6n1Tuw6x2hCsH/BGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCZ0/U5f1GftU7gdhvcCQsg71WYixwLsb5IZeHJLnOt/gTxHalIGWBGh664tp/43lssNdXNOBsPm8R/QeaV1ZPk3Otkm4LFYUSedZjqunhrqR4u7LNe8NsJD+i//PyyFa06A9x0uOOWubch1GoSPzaxlgGLbeReIJgbdB9wYCiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dx03zvUO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aBA6bWed; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG2apcJ1756374
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+EILwcr1iTF
	X9mTEKIH411BbjmzXxp27A6Z7tF+84D4=; b=dx03zvUOdPAHbkakdTyDnvjzEuh
	+LOY1Q2PAlBIqWsWCBblAUg1Pyv+LIO+IZPOav5ZnDCMrbap5c7uyD5u8CSvoHpJ
	3pstxzws7l2J68B/k23i4FmwdGYUgn7ZjXzzVD8Zw/MLNlmDgdaskR31a9NDXuhT
	TTGi11WE8q1aFQZfFDNBIdNN5xX8GH+mFhlkU9ei/VL475T1H5OucIDFg7n8h6lx
	sabfcQ/cN82wJ93OgLsFSBOrbAuJCGzF76/VxjeZ6kV0mYUFG3D1oda7SgAMV71G
	4Uw58wiDCtiV78dtt/h390/q95bbfJA4QlZCGsSvweOEryFUa+1MtqOqJjQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2peract7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0d59f0198so32996785ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866446; x=1766471246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EILwcr1iTFX9mTEKIH411BbjmzXxp27A6Z7tF+84D4=;
        b=aBA6bWedu+AQQVXzMUsXdv91/NJyRCErDcP6WFYPhyO7g/QTU8UrANDO0qvn480nxg
         30EE53jPX8/dYTt75Z20Q+kE4+0fsD8TbfO7YcTXnjHQK7ES652YBr3x5TqeMK8UAevN
         XPQZZ/o/V9tlgtnhVVKzijzdGyd5vch6tIQuFW0juHtCYmoRoOG2Uam6MbW+V46qc1Z6
         gjcHrvhupEzPgho6paWYLvjGQ6L9ImLHIUUijSXBk27kg5iS7DtO3EOab6pltkcHidEM
         W7Ri1GyMwJGUcKx/HodLg0o1RejWhH431cW4JAI+yYq4KtIbwFKTh38WK4IeHT7OP9oJ
         dlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866446; x=1766471246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+EILwcr1iTFX9mTEKIH411BbjmzXxp27A6Z7tF+84D4=;
        b=AkE9Ks3wrKIW7SXPtWfDvHvSWcqFZRaY67p5O963Dut9tIHFIbHQiunVFLT/aM3adt
         Owbg09+LXWRqAsSM8pA63MT3xIMVojYOekkwuGkLWXARgeDtAgBECrIGY1ZijrrJ25AR
         Do86jJgsexLHt6qZuz3Ix7PpDDJ0ybv7uS9MZoZJm73kB1q1NlMALM61hAkacywUdYcO
         0tmquMB+8MTSimjaAAJXS4BV9M5XvoinKw+2tD9bopTrZrCvluTUT6qY+Kyq08dPOhSo
         /E0OLwlm86PUVvNTU7Eu+oChgSgjovKLaSdF5mYY7kfNeEje4191PkvZxySey6ZTRwQO
         YsRw==
X-Gm-Message-State: AOJu0YzT3gIzkh4gFtWXJyLeRFSTFXTBJ1Ax8BJyBaTIyDnHCsRs0jge
	scGYALJ3s2y+ZZkCOcXgw2ugcUE2G732KDRyGqk3fUyeavmjkPZvSY6sp8ohy5MRazXIX80m6N1
	B39JsnZoXlg9eFiU7nwiP0dpqkI6bHYJ0QBaJ+VAHsknpgTmzqZ7KFuWXEU87NvXL3C8Ybw==
X-Gm-Gg: AY/fxX7VPNjIp74kPFG40gZLp41HHoMp9oEgj5HWTxz6meckcZsNsRJHXCELBS6Wc3K
	TZWv+uLUUC2Vysh9KwrUDxHbUxDDvqKQ2Y/zyuuMT+o15m9yXd9iwEbC7AZAaCxu5obWyiNp3Or
	NRaJmIAsnHwOnWbrvb/GFz3Upg8Mc7G5pR4Zm4CD9av00pbWOhKxO2a5WGlG6RPNjSfZrTKCS+1
	5ndDlD+WMAXSYfL6NCvTR7x1yfMU2xfRqncVDM2tq66R0QMkZLsDEi5C1Rvn9gjP+mlerQH7pu2
	p2qmK19PlSUVXgaYMxW/UaNNPhuv4ey5HCr4l51Y2coCdisn9OhLz2iJwZ04iyrmHsZ3xivrpGP
	SfzYQRQKJ9hd23EBrKnloFtqEgpbLuOidrBNgpBJS8b2xlLDFmtJSTw==
X-Received: by 2002:a17:903:13ce:b0:2a1:360c:3659 with SMTP id d9443c01a7336-2a1360c38c0mr19437285ad.58.1765866445536;
        Mon, 15 Dec 2025 22:27:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0BttbVKdNyPFbC7WzqGyWycUyVxyPzT0NwPddXB1WKqgrSIOZUy/Td5bnXfB+0ntLk4mjoQ==
X-Received: by 2002:a17:903:13ce:b0:2a1:360c:3659 with SMTP id d9443c01a7336-2a1360c38c0mr19437155ad.58.1765866445003;
        Mon, 15 Dec 2025 22:27:25 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:24 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 05/13] wifi: cfg80211: Support configuration of station UHR capabilities
Date: Tue, 16 Dec 2025 11:56:48 +0530
Message-Id: <20251216062656.1738022-6-karthikeyan.kathirvel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Evi_3zaJ-1P-tIvav4905FMyzbTl4vLd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX8qqpXGXu4SKS
 GolhrHyZEB3+PBMMGDtJ2IEm9qQkSsgZc8KAvFvHdQkIOkCbMRiAHEeB9JJi3wUU03zx/2iaNVo
 Zm/Se1zXznd16Q/5qcBS5d+DmpFZTUneum6e74D9M/WMysDurl21EPOnppwH19ohhNvP7fqcOjy
 G4GTpu6JI/innk9evjUp3EWCDvm65lR7tSirjAVLDTtvG07AKHgbauxpaZAeoXdZPuSyW6v50G2
 +yn9GQnrOojIlypevViLG/A56bJhcBEzjqR2pb/GhSWxLR33kIcfyehKZjWjFXFOqvm2GOw1s9h
 JMhzNUbK8ZyOMC52HgUV5UzYvnLOIYUokFEnOqiJLsrqUj6h7oxYU/poagMkxeS3AZQUkupNlCR
 L9EAi7/ahnpLzBefELTDPi9pn1iSoQ==
X-Proofpoint-GUID: Evi_3zaJ-1P-tIvav4905FMyzbTl4vLd
X-Authority-Analysis: v=2.4 cv=PYHyRyhd c=1 sm=1 tr=0 ts=6940fbce cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=IATnR_tsQU5s0FvmeE0A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

Introduce support for configuring UHR capabilities of stations
via userspace. This includes adding new attributes and corresponding
logic to parse and apply the UHR parameters provided by userspace
applications.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  4 +++
 include/uapi/linux/nl80211.h | 13 ++++++++
 net/wireless/nl80211.c       | 63 ++++++++++++++++++++++++++++++++----
 3 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7964dd1ee691..7593f1a1875b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1734,6 +1734,8 @@ struct sta_txpwr {
  * @eht_capa: EHT capabilities of station
  * @eht_capa_len: the length of the EHT capabilities
  * @s1g_capa: S1G capabilities of station
+ * @uhr_capa: UHR capabilities of station
+ * @uhr_capa_len: the length of the UHR capabilities
  */
 struct link_station_parameters {
 	const u8 *mld_mac;
@@ -1753,6 +1755,8 @@ struct link_station_parameters {
 	const struct ieee80211_eht_cap_elem *eht_capa;
 	u8 eht_capa_len;
 	const struct ieee80211_s1g_cap *s1g_capa;
+	const struct ieee80211_uhr_cap_elem *uhr_capa;
+	u8 uhr_capa_len;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8d9038ba1208..3488fa638bbd 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2973,6 +2973,10 @@ enum nl80211_commands {
  *	primary channel is 2 MHz wide, and the control channel designates
  *	the 1 MHz primary subchannel within that 2 MHz primary.
  *
+ * @NL80211_ATTR_UHR_CAPABILITY: UHR Capability information element (from
+ *	association request when used with NL80211_CMD_NEW_STATION). Can be set
+ *	only if %NL80211_STA_FLAG_WME is set.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3541,6 +3545,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_S1G_PRIMARY_2MHZ,
 
+	NL80211_ATTR_UHR_CAPABILITY,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3612,6 +3618,13 @@ enum nl80211_attrs {
 
 #define NL80211_CQM_TXE_MAX_INTVL		1800
 
+/*
+ * TODO: as of now used the len same as EHT, modify it
+ * based on UHR once spec is finalized
+ */
+#define NL80211_UHR_MIN_CAPABILITY_LEN		2
+#define NL80211_UHR_MAX_CAPABILITY_LEN		51
+
 /**
  * enum nl80211_iftype - (virtual) interface types
  *
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d05d098c4dc7..a54618eae8e5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -932,6 +932,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
 	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
 	[NL80211_ATTR_S1G_PRIMARY_2MHZ] = { .type = NLA_FLAG },
+	[NL80211_ATTR_UHR_CAPABILITY] =
+		NLA_POLICY_RANGE(NLA_BINARY, NL80211_UHR_MIN_CAPABILITY_LEN,
+				 NL80211_UHR_MAX_CAPABILITY_LEN),
 };
 
 /* policy for the key attributes */
@@ -8292,6 +8295,19 @@ static int nl80211_set_station_tdls(struct genl_info *info,
 		}
 	}
 
+	if (info->attrs[NL80211_ATTR_HE_CAPABILITY] &&
+	    info->attrs[NL80211_ATTR_EHT_CAPABILITY] &&
+	    info->attrs[NL80211_ATTR_UHR_CAPABILITY]) {
+		lsta->uhr_capa =
+			nla_data(info->attrs[NL80211_ATTR_UHR_CAPABILITY]);
+		lsta->uhr_capa_len =
+			nla_len(info->attrs[NL80211_ATTR_UHR_CAPABILITY]);
+
+		if (!ieee80211_uhr_capa_size_ok((const u8 *)lsta->uhr_capa,
+						lsta->uhr_capa_len))
+			return -EINVAL;
+	}
+
 	if (info->attrs[NL80211_ATTR_S1G_CAPABILITY])
 		lsta->s1g_capa =
 			nla_data(info->attrs[NL80211_ATTR_S1G_CAPABILITY]);
@@ -8615,6 +8631,23 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
+	if (info->attrs[NL80211_ATTR_HE_CAPABILITY] &&
+	    info->attrs[NL80211_ATTR_EHT_CAPABILITY] &&
+	    info->attrs[NL80211_ATTR_UHR_CAPABILITY]) {
+		const u8 *uhr_capa;
+
+		lsta->uhr_capa =
+			nla_data(info->attrs[NL80211_ATTR_UHR_CAPABILITY]);
+		lsta->uhr_capa_len =
+			nla_len(info->attrs[NL80211_ATTR_UHR_CAPABILITY]);
+
+		uhr_capa = (const u8 *)lsta->uhr_capa;
+
+		if (!ieee80211_uhr_capa_size_ok(uhr_capa,
+						lsta->uhr_capa_len))
+			return -EINVAL;
+	}
+
 	if (info->attrs[NL80211_ATTR_EML_CAPABILITY]) {
 		params.eml_cap_present = true;
 		params.eml_cap =
@@ -8665,19 +8698,20 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	if (parse_station_flags(info, dev->ieee80211_ptr->iftype, &params))
 		return -EINVAL;
 
-	/* HT/VHT requires QoS, but if we don't have that just ignore HT/VHT
-	 * as userspace might just pass through the capabilities from the IEs
-	 * directly, rather than enforcing this restriction and returning an
-	 * error in this case.
+	/* HT/VHT/EHT and UHR requires QoS, but if we don't have that just
+	 * ignore HT/VHT/EHT and UHR as userspace might just pass through
+	 * the capabilities from the IEs directly, rather than enforcing
+	 * this restriction and returning an error in this case.
 	 */
 	if (!(params.sta_flags_set & BIT(NL80211_STA_FLAG_WME))) {
 		lsta->ht_capa = NULL;
 		lsta->vht_capa = NULL;
 
-		/* HE and EHT require WME */
+		/* HE, EHT and UHR require WME */
 		if (lsta->he_capa_len ||
 		    lsta->he_6ghz_capa ||
-		    lsta->eht_capa_len)
+		    lsta->eht_capa_len ||
+		    lsta->uhr_capa_len)
 			return -EINVAL;
 	}
 
@@ -17651,6 +17685,23 @@ nl80211_add_mod_link_station(struct sk_buff *skb, struct genl_info *info,
 		}
 	}
 
+	if (info->attrs[NL80211_ATTR_HE_CAPABILITY] &&
+	    info->attrs[NL80211_ATTR_EHT_CAPABILITY] &&
+	    info->attrs[NL80211_ATTR_UHR_CAPABILITY]) {
+		const u8  *uhr_capa;
+
+		params.uhr_capa =
+			nla_data(info->attrs[NL80211_ATTR_UHR_CAPABILITY]);
+		params.uhr_capa_len =
+			nla_len(info->attrs[NL80211_ATTR_UHR_CAPABILITY]);
+
+		uhr_capa = (const u8 *)params.uhr_capa;
+
+		if (!ieee80211_uhr_capa_size_ok(uhr_capa,
+						params.uhr_capa_len))
+			return -EINVAL;
+	}
+
 	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
 		params.he_6ghz_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
-- 
2.34.1


