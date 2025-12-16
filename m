Return-Path: <linux-wireless+bounces-29775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 857DDCC120F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 825D6300B6BA
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBE1342C93;
	Tue, 16 Dec 2025 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W5ZcT1jt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dmuV7XC4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE6D342526
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866447; cv=none; b=YNC4xPt4755RO3tH4Nf30tXbTPjiWavc5HZ9hFDM1m1/ql45Ctnmzfa0Oa9DQySDqEpxtvEI0ADCokkuOyB2iLViOps5ocMfO2FERwOu1Dc1TYIVqn/m3Ba8nGsAOGDEJPchQn9tfF79KljpJ5jlf1jzZ4a6ebgrCl8mEl9ATPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866447; c=relaxed/simple;
	bh=rbJCpUp0zZkNFFG6TTmDLluaYssEThVBzItm9lC4XrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CTCCuH58f6Re2tZvwpF90+a+LPKHX3MLdWvSF4Trh9XZbU1jd52sk1eZ5WD3Zjc8xEjuhUy77mopjwSGmLPsjMz1B1lEMZwE1x/+0wjPxkUbV0qS6cfVH/Ahql9hwdOWUk9pjaybshWy7A2OOHC2XYABmBgfEzEJUogCd2T3hqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W5ZcT1jt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dmuV7XC4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG4a4J32278664
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qSLR9rXiEiT
	a88I7LvnRQNaguR79bYcDZ6WbiKvfXL0=; b=W5ZcT1jt8NRRjUYqDdxUSjKrbeW
	lfE7R3ixaTNLRFulaSD2VZ9EUmHc9spVgq9dxa8S9aV7rZ14suneXIt/tvJSE9Qf
	XmLm++1eaNUmqK1w/12rB4iDGsWOTkcwi87HMnoks3w5e2/un3T+EQZfkgXuQy8V
	6pXUMiQuS5ZdONR862rRcqmJ32xZWPtdtAGrdU0w1/HMJzLHPLIQqeZ/EF4Tacd0
	bi3CO6ZY5uD1CqYPm/L7l2G9XpAUI4sfguH4t06JKqRpU/bnVdwsHwDBpkTO/L23
	JqDW9Q7qXKcGIshCdxnW2ANIo7tt4dYcN2UFqav2He/tv9ki2mraIZb2W5g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2peracsv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a07fa318fdso63298205ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866437; x=1766471237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSLR9rXiEiTa88I7LvnRQNaguR79bYcDZ6WbiKvfXL0=;
        b=dmuV7XC4zIb7FdfxAIQIi/GPBgUqr0gyD2pzkpszeeliirG7gp5PRGvoIF34RWPkEQ
         sYX1FtKZ8mPjyeD1MQYhgr5KLsKx9e1850g/jpRfDZ8c4mwcRP5B/Hnta5+feXmanbST
         n04kusmXdBMe2RefRDW/GajJiziHLrpTFcWjHxo4ZlRrLcgK/sr7Cne5Z4Ej3r8z677V
         KKdm6/ouolBW5JAuzv7a9/srLro+4CWQrSeYEJmK6NgN+g7ZPcMIp1zle4MLUpVli8bB
         e1W0cxRVXqji+yoBe+ZMNgQC3HVFsxl8n+9zFUWqX6UMqkGXoyut+JYM3BFKCPiLHobT
         wlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866437; x=1766471237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSLR9rXiEiTa88I7LvnRQNaguR79bYcDZ6WbiKvfXL0=;
        b=jjx6kihVNUub/9uDRuiGGmh4jzPrW2Fr8vO0LjT34seHWeUTTij6l+AFTpl4q8MIEL
         y3RKIrsbe9zWkBovdf9cEs/Inx/15ysjhYbwDA/TWy90m4BVGtGUk2wzX+orfRvmjKVY
         xBdPjxA88GIZUsJQWSjuEO/jDBLpFINncZeeT4gKo8nGNrTnWcOdXLpecLDBTbc+BqhI
         qAfMihT7bVQY4TeLN43tzVUki5ZmDbE5m6xkxR0zfhElb2FwGEOhJTehphpIMWqJWK5F
         Wk1yFXrDqJGx/Pft4X3y+sxMxwCzlJ3jqEEb4kAzfOs0hTepiw6zqjScZf7EMkS26+dD
         hBsQ==
X-Gm-Message-State: AOJu0YwxyyUyVqIaYtEyrJYy7+LSTeIpJK256TOBfehti99nSn84UzS/
	Tx6UGra+S9ab2rMyrduoABUtGg1J61sJRA9BSjS7yjCyTN8xYNeIe6j4fyx8bQUmtp+usZPfGWC
	cX+YM7iU5eEIPZ+McchFc/YVFrmb/OPhvuKlfbiitwqD73CJxdPdNec6VT9zOuaZWaE20Tkp17K
	3mhw==
X-Gm-Gg: AY/fxX6fqdVE3xFN334PuqmSYqcEuwsFXABX3G3xJ2GhhybX0m69PYyziiHuolOkOIp
	WErse5hTLs6htOs3X5Zh6btzgIADOq6yg3ZCkcRiNKI+yAbz+FuSByL2oi4MpboJKSvEIU5vHeT
	iy09Sh7LGSm1VfUbkDh+Fg+/NZTZGehPW2WMj/A3EIGq5ca8+IpP0idPblmInYoML+d4sAtUI89
	nLm4sURXLnK8kb8XFv5g66D+LWUR7N/PFBQfMFakZroMCuPI4iL+GtUhyNr/uj/aSHdmj8IURvq
	eqjAjv+Oei8aCiuuxtM7VtbG4fvATRbT2SD291zmhUBIIoJPIQPAoWg7yU1+jxOOo4keoaBbEkl
	Dqt4Egk6oUDZ2QEws0FzkLtaRpk2sMQrPxZnVs5qbMuSdwEuCB7V41w==
X-Received: by 2002:a17:902:f64d:b0:29f:ad9:f705 with SMTP id d9443c01a7336-29f26ed30aemr130384015ad.45.1765866436819;
        Mon, 15 Dec 2025 22:27:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRufnMyayf3VhEjw88vkY8+9i8eolOGK9UIY/3FdNAGauuvgFfjFzj8Vr88kp7xQVVxM4rsQ==
X-Received: by 2002:a17:902:f64d:b0:29f:ad9:f705 with SMTP id d9443c01a7336-29f26ed30aemr130383035ad.45.1765866436298;
        Mon, 15 Dec 2025 22:27:16 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:15 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 01/13] wifi: nl80211: reduce multiple deference of link_sta_params
Date: Tue, 16 Dec 2025 11:56:44 +0530
Message-Id: <20251216062656.1738022-2-karthikeyan.kathirvel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: z-QeHmwR6Z0N7IfsQ18g_jmuIEo5MAgv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX1YLrcAN3vSFF
 VJCHVMO+SGfOGKLovIGAHUUSm0ll0CS7nWUMxwYYvQ3voyt8pexGR7rXfS23bsdU8DMcFfZuMTa
 9GJfgfuvxw2eN8mLYWJjqvUQV9AWmGU8si9bMt1z7ODzO19Uy/Jffl//pgxqUuGbN+wIVPXHiXR
 e5uRb9CFiqmFPXSUc7iobgk1LGiXpoAT3YCHqym0OmX34M3GiA6Zj2MnSAk+UrzK50qWFrSaPUd
 XoVfIgBWnurOMJDPl1DACrC0rrbPAlZ5oxPM1d8D+Bf+ZAUJw+5pArXxLdfl+YECR5mDoQZIGg7
 UeX6GE6tm8ZH4j4d5hdUNE3bpgSZuQTw1d0mczkwlkGDvaJ7oQEjJE+y+Rz71QxFySK7HQeeKNw
 BCe1o8qPv0HS6tbZs9w+QlNBcEPMzQ==
X-Proofpoint-GUID: z-QeHmwR6Z0N7IfsQ18g_jmuIEo5MAgv
X-Authority-Analysis: v=2.4 cv=PYHyRyhd c=1 sm=1 tr=0 ts=6940fbc6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=NvnMXIGTFUzh4brNVGIA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

Reduce multiple dereferencing for link_sta_params, since this crosses the
maximum column width in multiple lines.

Replace multiple dereferences of link_sta_params with a local variable
lsta.

No functional changes.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 net/wireless/nl80211.c | 84 ++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c961cd42a832..6b99416862a4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8250,38 +8250,39 @@ static int nl80211_parse_sta_channel_info(struct genl_info *info,
 static int nl80211_set_station_tdls(struct genl_info *info,
 				    struct station_parameters *params)
 {
+	struct link_station_parameters *lsta = &params->link_sta_params;
 	int err;
 	/* Dummy STA entry gets updated once the peer capabilities are known */
 	if (info->attrs[NL80211_ATTR_PEER_AID])
 		params->aid = nla_get_u16(info->attrs[NL80211_ATTR_PEER_AID]);
 	if (info->attrs[NL80211_ATTR_HT_CAPABILITY])
-		params->link_sta_params.ht_capa =
+		lsta->ht_capa =
 			nla_data(info->attrs[NL80211_ATTR_HT_CAPABILITY]);
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY])
-		params->link_sta_params.vht_capa =
+		lsta->vht_capa =
 			nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY]);
 	if (info->attrs[NL80211_ATTR_HE_CAPABILITY]) {
-		params->link_sta_params.he_capa =
+		lsta->he_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
-		params->link_sta_params.he_capa_len =
+		lsta->he_capa_len =
 			nla_len(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
 
 		if (info->attrs[NL80211_ATTR_EHT_CAPABILITY]) {
-			params->link_sta_params.eht_capa =
+			lsta->eht_capa =
 				nla_data(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
-			params->link_sta_params.eht_capa_len =
+			lsta->eht_capa_len =
 				nla_len(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
 
-			if (!ieee80211_eht_capa_size_ok((const u8 *)params->link_sta_params.he_capa,
-							(const u8 *)params->link_sta_params.eht_capa,
-							params->link_sta_params.eht_capa_len,
+			if (!ieee80211_eht_capa_size_ok((const u8 *)lsta->he_capa,
+							(const u8 *)lsta->eht_capa,
+							lsta->eht_capa_len,
 							false))
 				return -EINVAL;
 		}
 	}
 
 	if (info->attrs[NL80211_ATTR_S1G_CAPABILITY])
-		params->link_sta_params.s1g_capa =
+		lsta->s1g_capa =
 			nla_data(info->attrs[NL80211_ATTR_S1G_CAPABILITY]);
 
 	err = nl80211_parse_sta_channel_info(info, params);
@@ -8492,6 +8493,7 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct link_station_parameters *lsta;
 	int err;
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
@@ -8518,23 +8520,25 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	    !info->attrs[NL80211_ATTR_PEER_AID])
 		return -EINVAL;
 
-	params.link_sta_params.link_id =
+	lsta = &params.link_sta_params;
+
+	lsta->link_id =
 		nl80211_link_id_or_invalid(info->attrs);
 
 	if (info->attrs[NL80211_ATTR_MLD_ADDR]) {
 		mac_addr = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
-		params.link_sta_params.mld_mac = mac_addr;
-		params.link_sta_params.link_mac =
+		lsta->mld_mac = mac_addr;
+		lsta->link_mac =
 			nla_data(info->attrs[NL80211_ATTR_MAC]);
-		if (!is_valid_ether_addr(params.link_sta_params.link_mac))
+		if (!is_valid_ether_addr(lsta->link_mac))
 			return -EINVAL;
 	} else {
 		mac_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
 	}
 
-	params.link_sta_params.supported_rates =
+	lsta->supported_rates =
 		nla_data(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
-	params.link_sta_params.supported_rates_len =
+	lsta->supported_rates_len =
 		nla_len(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
 	params.listen_interval =
 		nla_get_u16(info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL]);
@@ -8573,28 +8577,28 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_HT_CAPABILITY])
-		params.link_sta_params.ht_capa =
+		lsta->ht_capa =
 			nla_data(info->attrs[NL80211_ATTR_HT_CAPABILITY]);
 
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY])
-		params.link_sta_params.vht_capa =
+		lsta->vht_capa =
 			nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY]);
 
 	if (info->attrs[NL80211_ATTR_HE_CAPABILITY]) {
-		params.link_sta_params.he_capa =
+		lsta->he_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
-		params.link_sta_params.he_capa_len =
+		lsta->he_capa_len =
 			nla_len(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
 
 		if (info->attrs[NL80211_ATTR_EHT_CAPABILITY]) {
-			params.link_sta_params.eht_capa =
+			lsta->eht_capa =
 				nla_data(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
-			params.link_sta_params.eht_capa_len =
+			lsta->eht_capa_len =
 				nla_len(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
 
-			if (!ieee80211_eht_capa_size_ok((const u8 *)params.link_sta_params.he_capa,
-							(const u8 *)params.link_sta_params.eht_capa,
-							params.link_sta_params.eht_capa_len,
+			if (!ieee80211_eht_capa_size_ok((const u8 *)lsta->he_capa,
+							(const u8 *)lsta->eht_capa,
+							lsta->eht_capa_len,
 							false))
 				return -EINVAL;
 		}
@@ -8607,7 +8611,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
-		params.link_sta_params.he_6ghz_capa =
+		lsta->he_6ghz_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
 
 	if (info->attrs[NL80211_ATTR_S1G_CAPABILITY])
@@ -8615,8 +8619,8 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			nla_data(info->attrs[NL80211_ATTR_S1G_CAPABILITY]);
 
 	if (info->attrs[NL80211_ATTR_OPMODE_NOTIF]) {
-		params.link_sta_params.opmode_notif_used = true;
-		params.link_sta_params.opmode_notif =
+		lsta->opmode_notif_used = true;
+		lsta->opmode_notif =
 			nla_get_u8(info->attrs[NL80211_ATTR_OPMODE_NOTIF]);
 	}
 
@@ -8634,8 +8638,8 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		return -EOPNOTSUPP;
 
 	err = nl80211_parse_sta_txpower_setting(info,
-						&params.link_sta_params.txpwr,
-						&params.link_sta_params.txpwr_set);
+						&lsta->txpwr,
+						&lsta->txpwr_set);
 	if (err)
 		return err;
 
@@ -8656,19 +8660,19 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	 * error in this case.
 	 */
 	if (!(params.sta_flags_set & BIT(NL80211_STA_FLAG_WME))) {
-		params.link_sta_params.ht_capa = NULL;
-		params.link_sta_params.vht_capa = NULL;
+		lsta->ht_capa = NULL;
+		lsta->vht_capa = NULL;
 
 		/* HE and EHT require WME */
-		if (params.link_sta_params.he_capa_len ||
-		    params.link_sta_params.he_6ghz_capa ||
-		    params.link_sta_params.eht_capa_len)
+		if (lsta->he_capa_len ||
+		    lsta->he_6ghz_capa ||
+		    lsta->eht_capa_len)
 			return -EINVAL;
 	}
 
 	/* Ensure that HT/VHT capabilities are not set for 6 GHz HE STA */
-	if (params.link_sta_params.he_6ghz_capa &&
-	    (params.link_sta_params.ht_capa || params.link_sta_params.vht_capa))
+	if (lsta->he_6ghz_capa &&
+	    (lsta->ht_capa || lsta->vht_capa))
 		return -EINVAL;
 
 	/* When you run into this, adjust the code below for the new flag */
@@ -8765,16 +8769,16 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	/* be aware of params.vlan when changing code here */
 
 	if (wdev->valid_links) {
-		if (params.link_sta_params.link_id < 0) {
+		if (lsta->link_id < 0) {
 			err = -EINVAL;
 			goto out;
 		}
-		if (!(wdev->valid_links & BIT(params.link_sta_params.link_id))) {
+		if (!(wdev->valid_links & BIT(lsta->link_id))) {
 			err = -ENOLINK;
 			goto out;
 		}
 	} else {
-		if (params.link_sta_params.link_id >= 0) {
+		if (lsta->link_id >= 0) {
 			err = -EINVAL;
 			goto out;
 		}
-- 
2.34.1


