Return-Path: <linux-wireless+bounces-32456-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPwHA4/zp2nImwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32456-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 09:55:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 987671FD003
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 09:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 805243044DC4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A71386C1E;
	Wed,  4 Mar 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h7UWy8mE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bmJaqgig"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24D386C30
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614448; cv=none; b=ILT5urNYcJ4M+4gYKUX/DO07mquRqLCZZYupsRxd5+puPClA3s9nArwpVAiAjAzkACLDBgA5fBfW+2bhYmpkUhAI4iGeki7juZTOKZqxu/UvObBeLR4y6lLOT1bVWxH3b6yFaL96YzSZ7h9Yn49vH9ynxDfcyoUp0ua1vKT3D78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614448; c=relaxed/simple;
	bh=uy+tTAPXE+h21QeAeD1Pn2HqfWO8sEx+eoBy2tx9TZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BonNCMWHLbKvSjCeSjXARKRqoM/SkMxFLnqYCa4qkagkad0Xm8XdLqm2Rw1i6SbkPOO/QBKUpkMd+zEjew7rpWYcvwmiAXs139uIU2MSEOs4Vidn3z0sxgwszOhpm+VVRVkOoZpQ0KRtmfJve4n72MQKXHhRDYHuYi1lNr0UObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h7UWy8mE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bmJaqgig; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SUIi1677945
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 08:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iXNn8gE+HxSx+H98VO9vSfJk7bcf6vTbEo1SVs+3ZeU=; b=h7UWy8mEE0RpTVdZ
	zQcWJHg6BIamccaFE/u6sOQmfoASWNM7W7fIF60h8AKodSK0ovrx5l/WsQEPgUsx
	ro+iqAWc9oOjKSkhEtj7R6qwMXy0gciodW+rlZbdLAXViE9f8/GlP9xJos8qQJEX
	e1OI9g/xXle/KQ21Twr0ILutnJ4zVSGGG+m1fCjTPqCFztYf6FnhjHLpeNB3dfov
	t7jvbeOAeHctt9XJgJCc7nfa2ImXaD9f6Dsg+8ux2K/5FJQbNLG1hAUmuYCUec5Z
	JdhvduAdqx6pPQ8NE2KFZYZ0Zk48NW6GaTix+DcW8/wXQj9hb8T+sJY5c/pnPyXC
	hTgQVA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp73ha48c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 08:54:06 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8272abdecafso3833610b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 00:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772614446; x=1773219246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXNn8gE+HxSx+H98VO9vSfJk7bcf6vTbEo1SVs+3ZeU=;
        b=bmJaqgigDgL+yX6QqTzf/XNr9FGxJsSX6ynx1p96hmKf3HtbwSJ8eZC0IMNa5NJHTk
         Pr/hGS/hAp6oZ/lqm9i3GhupTd/L8ErNh7kGvFiktYItfEqnhZWPbW0SfVIOWd+hlTmQ
         0CFjAcc8Riy49+AcKbD+xZT6IUzhY5VtDurjxgnt7IOj9GHKg7I/yWzUTjEOlGKG6Lnx
         Cbkoqc7c/M9dLDaA7eBrPPSlzlNZfiELxkeR9eMjCL/ECxFPEKjn9/P/vmF8yuD44HLY
         BYC7RDZZw9nTAQG4LBIhyxglOg7uCA24NMYgBs1ytVLV9sYMaNAc1kPS9G2Qzpf7eKj8
         rV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772614446; x=1773219246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iXNn8gE+HxSx+H98VO9vSfJk7bcf6vTbEo1SVs+3ZeU=;
        b=J/Wd5PRLevlMU+2cQsno/qrfyAnxwknn4PNb2fFVtQeJjPPBfPjTR4yMUAH8tNeRPM
         WjnQEURCt9qhx/hrNo6XK8cez7cixEEEQKtDhv+ava+W3ZYFTdLfxDMwYPbmrLNxTjf6
         MwNmNCiTns8pjuYrohiKqBewtHpkn8SLmKuC3mNQEkzj7nHtCzdSuzVe6vVDkTEE7eK9
         zJgO8b5EswW/LTNJNUa4/OcPuKBRAKET53I9O460mps+yBhxxviCjSZ2D7GC0rJ+D9t/
         lB+YvUBwKJ1/dYV9Co6a3UXR929sqZIAnULJenoPtwM1ZrOyIumKz6KtwykWeiHUZSld
         jA+Q==
X-Gm-Message-State: AOJu0YxwdK7heEvFfgjNj06obolclvsSxWmn1o0OamlTV6ApWLJ9Food
	Sj1KC9TXVTA2nVR8b+ObIwQh0mgZUExtywpMtKsZdrmqrhL+OVzgMDBmTclqdY86yGL7e70JO7y
	EoW8bVkzH4BEz1dtGvNMAtzMv2ERTyTFGDAr2jl76iqGOxbg79Wb0D8gkr26uR/2CCD4LQA==
X-Gm-Gg: ATEYQzy3Y8rUzhGEhH3GurtXPghy2Wvk/nK0uztMvj9S0WIOc+SaB1Y+N/4BJh+tXXv
	rQaHHj3XX/EPtZDdregNBOEc8NcnQhEaN+wCjK+7xRPjJMKSAtGFN6n9cef4UARBuCabcMwAYw2
	9ys7vBjXB2MFSL3EAPL5fD70iPAhhBriWFR6TnwJHGko7FiOnmI6SycUyjouNjscNlc3ecR0Jy9
	YsuxUBLh/0MkfpNE0gdeItO9HWo+QVjRi9ppbhSxm7X30EhkF9psHoAco4gm7XBADJQ8aHNhYw/
	248kqCK3rz/RWWSmqTP9xEqc5XtCHVpEczunWBylL3hZGJZUr0FP8ipryHDcSaUksrdGATrkz+F
	mnEabAITC7AIu2IIG0H13VbgYZunBELNLWSsL2vIvXHaGS85RcffA04KFbrcsQQCNSw==
X-Received: by 2002:a05:6a00:189d:b0:824:3d5b:3cd3 with SMTP id d2e1a72fcca58-82971f8f4c8mr1336551b3a.0.1772614445533;
        Wed, 04 Mar 2026 00:54:05 -0800 (PST)
X-Received: by 2002:a05:6a00:189d:b0:824:3d5b:3cd3 with SMTP id d2e1a72fcca58-82971f8f4c8mr1336536b3a.0.1772614444932;
        Wed, 04 Mar 2026 00:54:04 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01a9dasm18205140b3a.49.2026.03.04.00.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:54:04 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH wireless-next v5 2/2] wifi: mac80211_hwsim: Add UHR capabilities to the driver
Date: Wed,  4 Mar 2026 14:23:43 +0530
Message-Id: <20260304085343.1093993-3-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304085343.1093993-1-karthikeyan.kathirvel@oss.qualcomm.com>
References: <20260304085343.1093993-1-karthikeyan.kathirvel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6pULKHeGwBMg_5gKhv8dO1hr7Z607cYw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfX2k258nMTG6vG
 vieSTsFOJcW0tOR4AcVjzptN4sd2sSGZmM8S48tD3XEfiVWsNr98fpzJpFZ16fwO3B3A/bePy4N
 wHp0TScQQ9ydxVa2flQg18ikDWptutPqMajlPGG5MbWut7En3/KMTZZ0KUgLj0Wa9dYE1YEiwvo
 xTVZs6JdyZZWCZiG+a8w5NLmkKrEEAD+yuNiZdRC3bPEq2hI0OcbfvNhFwUuttvQ05l4Ow4xxzB
 aIgr5BJW5ChV2NHZ1R2GKL3ppWWN/vY0nvptLbiUK9meJVuuLc9QXwApX6l7dkzc69hjIOILFko
 +bHXn21PIPDLhLB96pclPk4gLQTVYMgaDT236l1bhEb5VGHOqBnsGXdyE8sM2uYrfSu8snnNFJM
 tsoDbx92meg/yiOE1cS80/Z5zVSTjc/p5Z3WaOzqeLE7GVY96r4SCaeOVJu3+2J+9uvOJd8aZoJ
 r4tnEhh7cnoOos6arQQ==
X-Proofpoint-ORIG-GUID: 6pULKHeGwBMg_5gKhv8dO1hr7Z607cYw
X-Authority-Analysis: v=2.4 cv=BpWQAIX5 c=1 sm=1 tr=0 ts=69a7f32e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=HmXHpSMdhKLYPtCZ9UQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040067
X-Rspamd-Queue-Id: 987671FD003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-32456-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add UHR capabilities for bringing up the interface in UHR mode.
This is required to validate UHR test cases.

The fields added to AP and STATION mode for each bands based on the
IEEE 802.11bn Draft P802.11bn/D1.3 "Table 9-bb3—Fields of the UHR MAC
Capabilities Information field" and "Table 9-bb6—Subfields of the UHR
PHY Capabilities Information field"

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 246 ++++++++++++++++++
 1 file changed, 246 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index e89173f91637..1d8060ad86fd 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4478,6 +4478,43 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.mac = {
+				.mac_cap[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
+					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
+				.mac_cap[1] =
+					IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
+					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
+					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
+					IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
+				.mac_cap[2] =
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
+					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
+					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
+					IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
+					IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
+				.mac_cap[3] =
+					IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH,
+				.mac_cap[4] =
+					IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
+			},
+			.phy = {
+				.cap =
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80 |
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80 |
+					IEEE80211_UHR_PHY_CAP_ELR_RX |
+					IEEE80211_UHR_PHY_CAP_ELR_TX,
+			},
+		},
 	},
 	{
 		.types_mask = BIT(NL80211_IFTYPE_AP) |
@@ -4586,6 +4623,48 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.mac = {
+				.mac_cap[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
+					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
+				.mac_cap[1] =
+					IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
+					IEEE80211_UHR_MAC_CAP1_DBE_SUPP |
+					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
+					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
+					IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
+				.mac_cap[2] =
+					IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
+					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
+					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
+					IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
+					IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
+				.mac_cap[3] =
+					IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH |
+					IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV |
+					IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW,
+				.mac_cap[4] =
+					IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH |
+					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
+					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE |
+					IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
+			},
+			.phy = {
+				.cap =
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80 |
+					IEEE80211_UHR_PHY_CAP_ELR_RX |
+					IEEE80211_UHR_PHY_CAP_ELR_TX,
+			},
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
@@ -4755,6 +4834,45 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.mac = {
+				.mac_cap[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
+					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
+				.mac_cap[1] =
+					IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
+					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
+					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
+					IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
+				.mac_cap[2] =
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
+					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
+					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
+					IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
+					IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
+				.mac_cap[3] =
+					IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH,
+				.mac_cap[4] =
+					IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
+			},
+			.phy = {
+				.cap =
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80 |
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80 |
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160 |
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160 |
+					IEEE80211_UHR_PHY_CAP_ELR_RX |
+					IEEE80211_UHR_PHY_CAP_ELR_TX,
+			},
+		},
 	},
 	{
 		.types_mask = BIT(NL80211_IFTYPE_AP) |
@@ -4880,6 +4998,49 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.mac = {
+				.mac_cap[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
+					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
+				.mac_cap[1] =
+					IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
+					IEEE80211_UHR_MAC_CAP1_DBE_SUPP |
+					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
+					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
+					IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
+				.mac_cap[2] =
+					IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
+					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
+					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
+					IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
+					IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
+				.mac_cap[3] =
+					IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH |
+					IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV |
+					IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW,
+				.mac_cap[4] =
+					IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH |
+					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
+					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE |
+					IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
+			},
+			.phy = {
+				.cap =
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80 |
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160 |
+					IEEE80211_UHR_PHY_CAP_ELR_RX |
+					IEEE80211_UHR_PHY_CAP_ELR_TX,
+			},
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
@@ -5073,6 +5234,47 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.mac = {
+				.mac_cap[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
+					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
+				.mac_cap[1] =
+					IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
+					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
+					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
+					IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
+				.mac_cap[2] =
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
+					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
+					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
+					IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
+					IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
+				.mac_cap[3] =
+					IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH,
+				.mac_cap[4] =
+					IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
+			},
+			.phy = {
+				.cap =
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80 |
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80 |
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160 |
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160 |
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320 |
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320 |
+					IEEE80211_UHR_PHY_CAP_ELR_RX |
+					IEEE80211_UHR_PHY_CAP_ELR_TX,
+			},
+		},
 	},
 	{
 		.types_mask = BIT(NL80211_IFTYPE_AP) |
@@ -5219,6 +5421,50 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.mac = {
+				.mac_cap[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
+					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
+				.mac_cap[1] =
+					IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
+					IEEE80211_UHR_MAC_CAP1_DBE_SUPP |
+					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
+					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
+					IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
+				.mac_cap[2] =
+					IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
+					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
+					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
+					IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
+					IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
+				.mac_cap[3] =
+					IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH |
+					IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV |
+					IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW,
+				.mac_cap[4] =
+					IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH |
+					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
+					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE |
+					IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
+			},
+			.phy = {
+				.cap =
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80 |
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160 |
+					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320 |
+					IEEE80211_UHR_PHY_CAP_ELR_RX |
+					IEEE80211_UHR_PHY_CAP_ELR_TX,
+			},
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
-- 
2.34.1


