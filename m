Return-Path: <linux-wireless+bounces-29782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D372DCC1190
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D98B3020C79
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3BB343208;
	Tue, 16 Dec 2025 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0WLSdAK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NfZyjoe+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD3A34252D
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866463; cv=none; b=oc6s4Tx/8Sl4aEfnXX1j6cTJQmqaJ/KgHBACRu5PhBbDWWevA/JtNxL1rtwrgu306grayAMkwOjHvk9CkEeHWhxPBucqWAeSKC1Am6ftnvC9CJ2DSlqSdSmzN4FyrgA9rtu3TPuHoGzVOQa1bKJxknR6oy+MpYMtQWdJfY2uf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866463; c=relaxed/simple;
	bh=CYOGDR6fpBP+3NtfluXqJRnlXhkJsHpecSY0/grSDVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9amIpMA5qveGOtyzH5LCvbhVnJijWEhkIrVvr5M092a4kTnORGA5AR2711O892ALKZGLLfvZQ54IiXOPZibQmsJFFWtO/9Vvf8MyqbIuLYTFzDmlcbq5sso6KDg2LwI1jkEnBi6oiRXbtoVRDJzBseG4ftV7BQAG4vgseQo248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0WLSdAK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NfZyjoe+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG25JbH1389366
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=70zogL1OyG6
	TFjxO+LG4e+E4T5EW8vdBTgu2R6Zn4GQ=; b=L0WLSdAKtlmwlG4QhxGnuNtrpLJ
	WhG0PP7rth7yNDhz0c+CL1wJvsJyauLUWSFKH8Q6NXKKmUEFu3LE7FkvapPvE9BX
	KTkrcgrE7ICj4EoqtXfA6z7iPiQv+8PP5LFezvpkIZ+1/jI0CGuAf/RPv8XqW/6d
	SNn6UD0cv6K0rC3reP/2Jzf+lN7hfaOf9hHeiKtEr4FvROzS1m+4ZzOJ4LFLomwK
	0V/jJ79czXp/IaDFO590A66kpefqXQ25lAPkjozgVWFp+Bk1HiF8EQ7ASSjCG3ed
	U+bQsR0NWdDsj6vtjOpY/Irh8YPH3pzOS3f7ANbLSVXarrSVRbFEKSnfGUA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2nu1jkym-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f8e6a5de4so38376375ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866452; x=1766471252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70zogL1OyG6TFjxO+LG4e+E4T5EW8vdBTgu2R6Zn4GQ=;
        b=NfZyjoe+3DQ3lVl2i4bEet0xIy6vq59gIr43m8J96ca3q0tHvisDCTyqkqurloJgJM
         B+pDw0wOpv7cI0fnFsxNtZIqA9c/1Y3FS3n35gy4VghDzzTOLd5uY5JOUbppGpgUtQj4
         BL5Sl764YgI/YhqLxraRyiGScWda29NigaxmhSyJG8vcxcJaGPP9XQvQIjVMWZRfsByq
         HGSxLL+2NGMM3IbmOwq6p55b8zWjdf9WrqMX8xDSJhja37obuUdEAZEdBA9Y5LhV2ObF
         lEDhv8debKapxxIbda7eYUSj5tIwkPmfoDj3hLZCmulHYPHHItb1p3ErCKsTW6SbEsPl
         Uu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866452; x=1766471252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=70zogL1OyG6TFjxO+LG4e+E4T5EW8vdBTgu2R6Zn4GQ=;
        b=N5iSDEy5sr4eG2+mVWJ3/JmGHPGTOwoeBP5w7oCtseQ7MVebFF74wKPA4OOQq8+qol
         PkDAE09GLPI+pq5rVxReHY8uPkNK52FSIRQGVAZbFnGPxWNptlfMMB8WQb1qr116a6VW
         G2w40pMZ5FBUxNsqJq1pdHfEVKcGsByybmN0heSsjB3uc6pr+RB4zkG9HCWeho5G9u9f
         lDQ6/uF+4P5Av/waNB2ftaymRpmO4mtTYmnr3nLSdAeNfLJVmi+fPvfs5YosU1wHwg6V
         3usXU18xs4JXdMYct1VEkw4HitjYkBe4iDxwNRQUjklLf8x6NQkLTuvzOrp+Bdd2biOd
         8jNA==
X-Gm-Message-State: AOJu0YxQySbi1jyZcibo4Vlx7F0rG+45tTedsGe/vH7lJKvi+y97A/Z7
	9o/ERecb8lmIVhB5lonyZLmSaX438UJta+xxyXvxT1hmA0N3xeaav1GQG5Jhfv6+MBxNvTNL9+5
	zDhFOP0asWxV9jz6J8je2IaIcSAgFgWkzXciTwaLI8/t8hl+DdjV/k78MraQuTJEqVAjvsg==
X-Gm-Gg: AY/fxX5zuakMhWNq/EQeAhGBCHk8kkC0PIdVQFurCSFxvFNtA1MGUPhwn642zcjx+gP
	GWleDi1dRLWneypN2IaJHpk1tzvYklE8s83+TseCQPtGjgyzgu4Ra3H1K/ujiTZwnmcUr6PDe1t
	0kxnWb/AJ4JHKljptxqiDltxuAnK2OMPiQ0+BKwVvyUTvq1Ti0CjOGGSDFukyMOwDAvg+8uEDxT
	BFFjsw8s6S+9K49CarMHLxTElCnjTTfs2fa+zDLRwObN1MP1N2rETlf2DRN8va2fQQJ3wHGuHcI
	3mQdEZif8aFAnVc8XywPgcVYQ87m7lQOZFNQWT1wD5+rMTGN0k21bIg2gqImenhu5bBt3cSfx8Y
	i9pZtkDbAxGFUkV9lqpeOJF5/8rskDUny72oSBVg/KZ08cCaeaHf5Hg==
X-Received: by 2002:a17:903:2ca:b0:2a0:d596:a88d with SMTP id d9443c01a7336-2a0d596ab66mr75323755ad.26.1765866451602;
        Mon, 15 Dec 2025 22:27:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvHXUCm63SqcD0v0tRrNhOnLbCHnc5elIqNxpBs+lB6yxdQy8XiPzxbQHHSV0ejUOoMRDulQ==
X-Received: by 2002:a17:903:2ca:b0:2a0:d596:a88d with SMTP id d9443c01a7336-2a0d596ab66mr75323565ad.26.1765866451098;
        Mon, 15 Dec 2025 22:27:31 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:30 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 08/13] wifi: mac80211: Support parsing UHR elements
Date: Tue, 16 Dec 2025 11:56:51 +0530
Message-Id: <20251216062656.1738022-9-karthikeyan.kathirvel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: _iEhXozfjIVxkHcfHMj9T7_KRPxCfZoY
X-Proofpoint-GUID: _iEhXozfjIVxkHcfHMj9T7_KRPxCfZoY
X-Authority-Analysis: v=2.4 cv=AOuEbwt4 c=1 sm=1 tr=0 ts=6940fbd4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=h5j4BVn6lG1j3psvHjkA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX8VqLe3BH8JIi
 zlmvjy4hOU0U7y/rNm+WPcIBkB8MfarWSw0KzusEcA874vueBlE17O4V6Kv8MkaWf/gznUEb5nJ
 9N/JXoTL00JYb87ZTiAHcoaAuRGIIT3NNhmzAk4Ul4cUODWlb3cmPvgfEPCETa7CGcN3eZDyI7z
 B3NbcwVk5WMrKsLe8LCJrl6laYkkV6RLPm+RLaj0BnSOvMpHwOr67/JLNJWPXQ1zZhkUoFeyhti
 9MAbYL4WkC9RKegbHmUY/FYz1MuHZVyL3LEcWUpAmxjU0OjEqVReLvcjK2cQQ5b7xcRaNZ5LzG8
 9/kpj8SILIA22zlliEOp6esNhjLIBY21mWNhGEFIZ6Nn1lfoifwJ/UuYlAkhlDsikaases2lybM
 flThLbqE/LQ5RZVhkOQh4CSg5SIbGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

Parse the new UHR elements in the element parsing utilities.

As per spec ieee80211bn D1.0 Section 37.29 Beacon Optimization
"A UHR AP shall not include the parameters associated with
operating modes currently enabled at the AP defined by UHR
in the UHR Operation element or any other element carried in the
Beacon frame, except when specified otherwise"

For beacon frames UHR operation size check done only for UHR operation
parameters not for operation information.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 net/mac80211/ieee80211_i.h |  5 +++++
 net/mac80211/mlme.c        |  2 ++
 net/mac80211/parse.c       | 13 +++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9d9313eee59f..04f1df209cec 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1826,6 +1826,8 @@ struct ieee802_11_elems {
 	const struct ieee80211_multi_link_elem *ml_epcs;
 	const struct ieee80211_bandwidth_indication *bandwidth_indication;
 	const struct ieee80211_ttlm_elem *ttlm[IEEE80211_TTLM_MAX_CNT];
+	const struct ieee80211_uhr_cap_elem *uhr_cap;
+	const struct ieee80211_uhr_operation *uhr_operation;
 
 	/* not the order in the psd values is per element, not per chandef */
 	struct ieee80211_parsed_tpe tpe;
@@ -1866,6 +1868,7 @@ struct ieee802_11_elems {
 	struct ieee80211_mle_per_sta_profile *prof;
 	size_t sta_prof_len;
 
+	u8 uhr_cap_len;
 	/* whether/which parse error occurred while retrieving these elements */
 	u8 parse_error;
 };
@@ -2423,6 +2426,7 @@ static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
  * @mode: connection mode for parsing
  * @start: pointer to the elements
  * @len: length of the elements
+ * @is_beacon: %true if the elements came from beacon frame
  * @type: type of the frame the elements came from
  *	(action, probe response, beacon, etc.)
  * @filter: bitmap of element IDs to filter out while calculating
@@ -2442,6 +2446,7 @@ struct ieee80211_elems_parse_params {
 	enum ieee80211_conn_mode mode;
 	const u8 *start;
 	size_t len;
+	bool is_beacon;
 	u8 type;
 	u64 filter;
 	u32 crc;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e56ad4b9330f..73649d57d0c3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7400,6 +7400,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	    !WARN_ON(ieee80211_vif_is_mld(&sdata->vif)) &&
 	    ieee80211_rx_our_beacon(bssid, ifmgd->assoc_data->link[0].bss)) {
 		parse_params.bss = ifmgd->assoc_data->link[0].bss;
+		parse_params.is_beacon = true;
 		elems = ieee802_11_parse_elems_full(&parse_params);
 		if (!elems)
 			return;
@@ -7470,6 +7471,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	parse_params.bss = bss_conf->bss;
 	parse_params.filter = care_about_ies;
 	parse_params.crc = ncrc;
+	parse_params.is_beacon = true;
 	elems = ieee802_11_parse_elems_full(&parse_params);
 	if (!elems)
 		return;
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index bfc4ecb7a048..ed8411aa8b32 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -189,6 +189,17 @@ ieee80211_parse_extension_element(u32 *crc,
 			elems->ttlm_num++;
 		}
 		break;
+	case WLAN_EID_EXT_UHR_CAPABILITY:
+		if (ieee80211_uhr_capa_size_ok(data, len)) {
+			elems->uhr_cap = data;
+			elems->uhr_cap_len = len;
+		}
+		break;
+	case WLAN_EID_EXT_UHR_OPERATION:
+		if (ieee80211_uhr_oper_size_ok(data, len, params->is_beacon))
+			elems->uhr_operation = data;
+		calc_crc = true;
+		break;
 	}
 
 	if (crc && calc_crc)
@@ -963,6 +974,7 @@ ieee80211_prep_mle_link_parse(struct ieee80211_elems_parse *elems_parse,
 
 	sub->mode = params->mode;
 	sub->type = params->type;
+	sub->is_beacon = params->is_beacon;
 	sub->from_ap = params->from_ap;
 	sub->link_id = -1;
 
@@ -1062,6 +1074,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 		sub.mode = params->mode;
 		sub.len = nontx_len;
 		sub.type = params->type;
+		sub.is_beacon = params->is_beacon;
 		sub.link_id = params->link_id;
 
 		/* consume the space used for non-transmitted profile */
-- 
2.34.1


