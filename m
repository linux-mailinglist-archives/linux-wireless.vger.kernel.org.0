Return-Path: <linux-wireless+bounces-29787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CB0CC117A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9542B30210E1
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336B7344044;
	Tue, 16 Dec 2025 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eJ61dDJd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OC4SZxCS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D92A3431E6
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866476; cv=none; b=ozWcn+9vHbADxn27GxZHbsz8S0x+4tWc0QzjBAAR5QcRCwV0esIQbSX41jOLtbgruEl9jYVk0DHUyyljHuo1PE4M6VNI/xP1ULPHsIR5t7hJaLQtBu0hOHwSjmZKCC5afaOc5CS4Gf0pE+1+G9Dvi5KGOHp0w+hjndSRGBdL00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866476; c=relaxed/simple;
	bh=neLfsPnJExPlTeMfEoTJhoVp2n3CiTgL9+mKIRvGP50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVuK0k33NFJbjr56L7zhoOWO2ACZscZhFlOGAkefq3jnBEiNvUgGXxnQh5xf2KVdYRru0K6Mj+8CFsCvern76G4GJSrpmLKWZJwA4hBuc7W658RoEuw9L1JxccmuEqSyJds9sdaVQgJJ/5m2jhflqH7ZCDqH/O3VZGyD2Ifa4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eJ61dDJd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OC4SZxCS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG1jVaN1391484
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=P7MytiaR0n0
	qWsMt+jN96k6HlO9o2ZvPZBOnEFwznzw=; b=eJ61dDJdmOif80DT9MM58cw+DOh
	s/LtzIWShq7SvszM6LRWgWiVmNLkzb6JqiT5hUlFV2yGD4L9AIpiZHteC+V6wWtS
	Bn+faTM7mFq1ggYVm/tk4uml9GclbDqjmwV34UFJWkeWIMZp7czDssV7/JYZoJgJ
	JWz33eKb1IKoFxPWMa92yqHeEhresnw6TH5FwcSnB8+oQ1zbKmexC0bU2V8+vkQy
	4otC0pLTAQzUV8oGpzIYk7uuxomxy/OJdagyTdpZ0wDDhkmJtV1vmQDhofXKTBMa
	9jMQFoAeMzU2tkGFmnYaAhb7buhhdnyizD6SkhHDxsqmNpMoCa27lX93mqA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2nu1jm00-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f29ae883bso50943805ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866462; x=1766471262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7MytiaR0n0qWsMt+jN96k6HlO9o2ZvPZBOnEFwznzw=;
        b=OC4SZxCSwJLyxYiM/Aj9KEpR6Pk6MOWuSPDlCzorbrkrJXBOeVcmn0IU1KXxl3azOU
         F9E9McyBQg2X1zxT+G86IcODIXmUdceJ/n1HSqwN24L3BhcaaLChAFP7kPH9EX4amxMM
         3scjvQbhYtV5NLdbholmFUODRC19vmjZJ6Oz+sQngO8Uql9S9wn2hwBDvj8n2QCiMJ9V
         +FQaHapEmboVICwTSO/f5UG/8kM/jNgfGS+KBFhbT6zq/EpzRSzBgAQZ+0Vus8ZFJWlq
         xxnC/0Tu7aRZJl5a4DxWJM0AC6baKKBR8SeqFVu41wdE4KS17yHeHfd1IpVhcadE4uJy
         8nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866462; x=1766471262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P7MytiaR0n0qWsMt+jN96k6HlO9o2ZvPZBOnEFwznzw=;
        b=rdZpzW0WEUsfHe6ExN3MsAlpUnOJpeWOXMFL1WdVs+0IcoiB/Ap7p1iQMSqq7ju79d
         5mr9C6fc0IzKj6U5hAwcFwnRlpVAArsNyVNNcw+3OfQW9WS4VS7M84BnB6qhOujuiPf+
         IAmrRJaVxejevPTHQY7ZynN5TbX+ECvn6tkSfzERIy8Ntc5p6QNCzNo54b/djNvj2/Jb
         ZndwERWe9cgAZoUpFKbuDi/GSulc0hAWa8sQwvslAuTUMgREl0I0WzMSc80udvUl2Cbx
         yNJa6zGX5CSvfnQQ/l+lCqQfT8EiZZn/D6sA60AUMhwsPKzpJXF2nFdbqfDyoLnUSfp9
         QTcQ==
X-Gm-Message-State: AOJu0YzQoSl/dXi15gi0oKWCNp70KlgrrQXVamkwdnoxuFXucnZMuOIQ
	LDTNaY8V5CXonWttFHUrQvSzg8ASbzwovsEmDssB7UgUcgoe+qnIjWGBHf6HTVTICnMvnjuzEo+
	brN+emXqXoRbcM1oq1G+bu8oHvQGFlO+BrUiv4LM7yPJzWKm20Up/6HJB8ugaU6DJXZMJzVeITt
	NZjw==
X-Gm-Gg: AY/fxX72cRVFQ2zdPATi6bsQ4yLvS4CIIxO0gt3XONw75ETWnO6NVU08KaKPqRsca7K
	rU1Zcl9dmQbEqHUaxiNayA+hnUFDe++MLsA/ORijpxJHtYpiBh4dYmGv3NEPLnchHh/OIiUi8fz
	8q83FHmDUJgIiSZxlQ4VCZP9hmJLHpdBxWRVdGAZ4GoK2jdHILof/OyllCG49qhdheYsdP2Vyjh
	b299Yc91JN5wjM8tkz0z1vuW8qJezVW9GNHtLkkWylhlTXOOhzlilRR+rq70PHSAz63kopLqF6G
	rHm3lUM/5zRj9M792SrUt3A4r8L2kWbzTN6Kw4ylG6NYfLbPQFmzMtA+n493WS08T9rIsNQsj2h
	DJufZJFNK/V+Xw1yNbKtQTvzZzK9t18ek7jxW68TE/w/QSHSVxzRa/A==
X-Received: by 2002:a17:903:37ce:b0:295:195:23b6 with SMTP id d9443c01a7336-29f26eff462mr133036585ad.55.1765866461722;
        Mon, 15 Dec 2025 22:27:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFE4f1TVkxb/4N5Q+k7qPeR0qyRkiJ6HqDpKErplzcGXXtlYtkK7DO2a7yBJbfowmDmXMK9A==
X-Received: by 2002:a17:903:37ce:b0:295:195:23b6 with SMTP id d9443c01a7336-29f26eff462mr133036325ad.55.1765866461184;
        Mon, 15 Dec 2025 22:27:41 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:40 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 13/13] wifi: mac80211_hwsim: Add UHR capabilities in driver.
Date: Tue, 16 Dec 2025 11:56:56 +0530
Message-Id: <20251216062656.1738022-14-karthikeyan.kathirvel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: JRFVFMIW5P6B_ng-vUYFHptiNPEO9E4x
X-Proofpoint-GUID: JRFVFMIW5P6B_ng-vUYFHptiNPEO9E4x
X-Authority-Analysis: v=2.4 cv=AOuEbwt4 c=1 sm=1 tr=0 ts=6940fbde cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=i733qYAASXlvfHyrTlUA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX6L32tPHCT0vE
 iisY4auH+X/XrZa13Dt6QptG/HlyratokWqh2iyc1M5SpEV9IreSWjBhzPCX7E8jQQQ936O4c/j
 tXPh0HJSOvPxlMjeS6ywHO891Mk6Gi9AgN5tUt4GnlJBkJVOVUMD30JEf29GzEcj51uAPU9zgLt
 CDe0P5zl8lKBWkx5C9Xrml3oOgaUDlyTR//usUHYrX6jFpApA/vtZSb+mkXrrt462x+QlK9rtyR
 GkV4SXuQMC6BKGxiAecIDGw0yiyXxTyx6bnAFuKUvwOkEPc1P74pKTMlKM6+HYZCkx1ZylOhsBh
 DtO3EoqyrOIXskERTuFTG/OMWK6emCWNVd9K0A+o9np6vISH/MxW6NGy1YTNUKFEdEb6ocs1Vz+
 xe9SuTLqz14zVaC7cJ9SsbGtajg6mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

Add UHR capabilities for bringing up interface in UHR mode.
It is required for validating UHR test cases.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 288 ++++++++++++++++++
 1 file changed, 288 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 551f5eb4e747..b3de13aa7354 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4478,6 +4478,54 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.uhr_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_DPS_ASSISTING_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_ML_POWER_MANAGEMENT |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPPORTED |
+					IEEE80211_UHR_MAC_CAP0_ENHANCED_BSR_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_ADDITIONAL_MAPPED_TID_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPPORT,
+				.mac_cap_info[1] =
+					IEEE80211_UHR_MAC_CAP1_DSO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_P_EDCA_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_DBE_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_PUO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPPORT,
+				.mac_cap_info[2] =
+					IEEE80211_UHR_MAC_CAP2_OM_UL_MU_DATA_DIS_RX_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_IFCS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_TXOP_RETURN_SUPPORT_INTXSPG |
+					IEEE80211_UHR_MAC_CAP2_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK,
+				.mac_cap_info[3] =
+					IEEE80211_UHR_MAC_CAP3_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK |
+					IEEE80211_UHR_MAC_CAP3_PARAM_UPDATE_ADV_NOTIFY_INT_MASK |
+					IEEE80211_UHR_MAC_CAP3_UPDATE_IND_IN_TIM_INT_MASK,
+				.mac_cap_info[4] =
+					IEEE80211_UHR_MAC_CAP4_UPDATE_IND_IN_TIM_INT_MASK |
+					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
+					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE,
+
+				.phy_cap_info[0] =
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_80MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_80MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_160MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_160MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_320MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_320MHZ |
+					IEEE80211_UHR_PHY_CAP0_ELR_RX_SUPPORT |
+					IEEE80211_UHR_PHY_CAP0_ELR_TX_SUPPORT,
+			},
+		},
 	},
 	{
 		.types_mask = BIT(NL80211_IFTYPE_AP) |
@@ -4586,6 +4634,54 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.uhr_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_DPS_ASSISTING_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_ML_POWER_MANAGEMENT |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPPORTED |
+					IEEE80211_UHR_MAC_CAP0_ENHANCED_BSR_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_ADDITIONAL_MAPPED_TID_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPPORT,
+				.mac_cap_info[1] =
+					IEEE80211_UHR_MAC_CAP1_DSO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_P_EDCA_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_DBE_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_PUO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPPORT,
+				.mac_cap_info[2] =
+					IEEE80211_UHR_MAC_CAP2_OM_UL_MU_DATA_DIS_RX_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_IFCS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_TXOP_RETURN_SUPPORT_INTXSPG |
+					IEEE80211_UHR_MAC_CAP2_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK,
+				.mac_cap_info[3] =
+					IEEE80211_UHR_MAC_CAP3_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK |
+					IEEE80211_UHR_MAC_CAP3_PARAM_UPDATE_ADV_NOTIFY_INT_MASK |
+					IEEE80211_UHR_MAC_CAP3_UPDATE_IND_IN_TIM_INT_MASK,
+				.mac_cap_info[4] =
+					IEEE80211_UHR_MAC_CAP4_UPDATE_IND_IN_TIM_INT_MASK |
+					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
+					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE,
+
+				.phy_cap_info[0] =
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_80MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_80MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_160MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_160MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_320MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_320MHZ |
+					IEEE80211_UHR_PHY_CAP0_ELR_RX_SUPPORT |
+					IEEE80211_UHR_PHY_CAP0_ELR_TX_SUPPORT,
+			},
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
@@ -4755,6 +4851,54 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.uhr_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_DPS_ASSISTING_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_ML_POWER_MANAGEMENT |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPPORTED |
+					IEEE80211_UHR_MAC_CAP0_ENHANCED_BSR_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_ADDITIONAL_MAPPED_TID_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPPORT,
+				.mac_cap_info[1] =
+					IEEE80211_UHR_MAC_CAP1_DSO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_P_EDCA_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_DBE_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_PUO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPPORT,
+				.mac_cap_info[2] =
+					IEEE80211_UHR_MAC_CAP2_OM_UL_MU_DATA_DIS_RX_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_IFCS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_TXOP_RETURN_SUPPORT_INTXSPG |
+					IEEE80211_UHR_MAC_CAP2_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK,
+				.mac_cap_info[3] =
+					IEEE80211_UHR_MAC_CAP3_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK |
+					IEEE80211_UHR_MAC_CAP3_PARAM_UPDATE_ADV_NOTIFY_INT_MASK |
+					IEEE80211_UHR_MAC_CAP3_UPDATE_IND_IN_TIM_INT_MASK,
+				.mac_cap_info[4] =
+					IEEE80211_UHR_MAC_CAP4_UPDATE_IND_IN_TIM_INT_MASK |
+					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
+					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE,
+
+				.phy_cap_info[0] =
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_80MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_80MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_160MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_160MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_320MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_320MHZ |
+					IEEE80211_UHR_PHY_CAP0_ELR_RX_SUPPORT |
+					IEEE80211_UHR_PHY_CAP0_ELR_TX_SUPPORT,
+			},
+		},
 	},
 	{
 		.types_mask = BIT(NL80211_IFTYPE_AP) |
@@ -4880,6 +5024,54 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.uhr_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_DPS_ASSISTING_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_ML_POWER_MANAGEMENT |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPPORTED |
+					IEEE80211_UHR_MAC_CAP0_ENHANCED_BSR_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_ADDITIONAL_MAPPED_TID_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPPORT,
+				.mac_cap_info[1] =
+					IEEE80211_UHR_MAC_CAP1_DSO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_P_EDCA_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_DBE_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_PUO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPPORT,
+				.mac_cap_info[2] =
+					IEEE80211_UHR_MAC_CAP2_OM_UL_MU_DATA_DIS_RX_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_IFCS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_TXOP_RETURN_SUPPORT_INTXSPG |
+					IEEE80211_UHR_MAC_CAP2_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK,
+				.mac_cap_info[3] =
+					IEEE80211_UHR_MAC_CAP3_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK |
+					IEEE80211_UHR_MAC_CAP3_PARAM_UPDATE_ADV_NOTIFY_INT_MASK |
+					IEEE80211_UHR_MAC_CAP3_UPDATE_IND_IN_TIM_INT_MASK,
+				.mac_cap_info[4] =
+					IEEE80211_UHR_MAC_CAP4_UPDATE_IND_IN_TIM_INT_MASK |
+					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
+					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE,
+
+				.phy_cap_info[0] =
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_80MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_80MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_160MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_160MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_320MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_320MHZ |
+					IEEE80211_UHR_PHY_CAP0_ELR_RX_SUPPORT |
+					IEEE80211_UHR_PHY_CAP0_ELR_TX_SUPPORT,
+			},
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
@@ -5073,6 +5265,54 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.uhr_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_DPS_ASSISTING_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_ML_POWER_MANAGEMENT |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPPORTED |
+					IEEE80211_UHR_MAC_CAP0_ENHANCED_BSR_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_ADDITIONAL_MAPPED_TID_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPPORT,
+				.mac_cap_info[1] =
+					IEEE80211_UHR_MAC_CAP1_DSO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_P_EDCA_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_DBE_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_PUO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPPORT,
+				.mac_cap_info[2] =
+					IEEE80211_UHR_MAC_CAP2_OM_UL_MU_DATA_DIS_RX_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_IFCS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_TXOP_RETURN_SUPPORT_INTXSPG |
+					IEEE80211_UHR_MAC_CAP2_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK,
+				.mac_cap_info[3] =
+					IEEE80211_UHR_MAC_CAP3_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK |
+					IEEE80211_UHR_MAC_CAP3_PARAM_UPDATE_ADV_NOTIFY_INT_MASK |
+					IEEE80211_UHR_MAC_CAP3_UPDATE_IND_IN_TIM_INT_MASK,
+				.mac_cap_info[4] =
+					IEEE80211_UHR_MAC_CAP4_UPDATE_IND_IN_TIM_INT_MASK |
+					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
+					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE,
+
+				.phy_cap_info[0] =
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_80MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_80MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_160MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_160MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_320MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_320MHZ |
+					IEEE80211_UHR_PHY_CAP0_ELR_RX_SUPPORT |
+					IEEE80211_UHR_PHY_CAP0_ELR_TX_SUPPORT,
+			},
+		},
 	},
 	{
 		.types_mask = BIT(NL80211_IFTYPE_AP) |
@@ -5219,6 +5459,54 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.uhr_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_DPS_ASSISTING_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_ML_POWER_MANAGEMENT |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPPORTED |
+					IEEE80211_UHR_MAC_CAP0_ENHANCED_BSR_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_ADDITIONAL_MAPPED_TID_SUPPORT |
+					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPPORT,
+				.mac_cap_info[1] =
+					IEEE80211_UHR_MAC_CAP1_DSO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_P_EDCA_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_DBE_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_PUO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPPORT |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPPORT,
+				.mac_cap_info[2] =
+					IEEE80211_UHR_MAC_CAP2_OM_UL_MU_DATA_DIS_RX_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_IFCS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPPORT |
+					IEEE80211_UHR_MAC_CAP2_TXOP_RETURN_SUPPORT_INTXSPG |
+					IEEE80211_UHR_MAC_CAP2_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK,
+				.mac_cap_info[3] =
+					IEEE80211_UHR_MAC_CAP3_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK |
+					IEEE80211_UHR_MAC_CAP3_PARAM_UPDATE_ADV_NOTIFY_INT_MASK |
+					IEEE80211_UHR_MAC_CAP3_UPDATE_IND_IN_TIM_INT_MASK,
+				.mac_cap_info[4] =
+					IEEE80211_UHR_MAC_CAP4_UPDATE_IND_IN_TIM_INT_MASK |
+					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
+					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE,
+
+				.phy_cap_info[0] =
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_80MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_80MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_160MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_160MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_320MHZ |
+					IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_320MHZ |
+					IEEE80211_UHR_PHY_CAP0_ELR_RX_SUPPORT |
+					IEEE80211_UHR_PHY_CAP0_ELR_TX_SUPPORT,
+			},
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
-- 
2.34.1


