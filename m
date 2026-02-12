Return-Path: <linux-wireless+bounces-31789-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG2BErMVjmmZ/AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31789-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 19:02:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A186813021E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 19:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3518301D128
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8C654774;
	Thu, 12 Feb 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O+3Xc0y2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vyp8Zhjo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7DF513
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919328; cv=none; b=DNZZPyeA2EfXJ9yJ0WWZs0iR6/orQZd7faF7HmuQawzE4eQ+IKfmpidYMAamYJ6DhGuduKbhYpvY6CW3C5vCMmlHnuwK4w4Aqy47l7KX+zUJH66Ee+IfMBGotadIHakQjj8rMWEgme4/l2Q0DnvUMTzcNBymEvv1tQ+bMOObrCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919328; c=relaxed/simple;
	bh=xJEzKVMLSgniActanYyGXpJS2kJOWVrybZl6dmova9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OVs7KWoqkZGQrSH4SV+Uq8U5B9M80jLdohX80hXUNHtaM13bdsZQ/bGNWjRVQHH0HrGwAEe0pLjr8m9rkhEoBbJhQUZoX+8syiEXgcjUIBh38O02uOU2lZJ/IXdknTVS+zNIr8ednLOcg0TfPWSj3bsJni7b+e/2stMISwdn8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O+3Xc0y2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vyp8Zhjo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRgMk3943718
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 18:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RL+KtDcQa5Y
	ZPbZ+XfDdGWOzmh28HH26N59rjfwIUxk=; b=O+3Xc0y2rAm3Tkg1DAzbqqnapYE
	8kmknS4nHgm8fkeA63a60CkBbmkpdlw14lp6S9p0DZUEXU4ewt5Rhtcg00dJKF4G
	pf3HIKQRclIZSHVezu4OhFey/VugChcKnRoSweiGuTlPcGM+zCyzxGCr2ruInVVp
	pe4mK7PLTey+bo+smghYK/BWUMqdF+MBcObhqm3qIS369/EREJACDmLeb6RnhFcE
	adiHs43PjehfyoZ9FnFWvjUMzNwA6fdAkEhZ0C0/CNzi3f/Ogrme85J4a54NsSOT
	0KBQ4jHqBmkDuMs9uyM00QuOXAq61Oy0BS+eB2Dlw+hnXqjqsnCcfBH5ytA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c90d6uumw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 18:02:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35658758045so115789a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 10:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770919324; x=1771524124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL+KtDcQa5YZPbZ+XfDdGWOzmh28HH26N59rjfwIUxk=;
        b=Vyp8ZhjoyfMj351k3Jkbr0k+uLRXViXVuLDBlIAPacd9dT6evK635/hiCwgoR+kufW
         7555O3ZC4/kpHn0ZETnEI6GemOdNrXdcMTAv//HCU8zctlpcFCXh5uwPUU8CHsv1K46Q
         6TvIt9L3dI5p66S7J/qC+MMgIRjNmxpyyyZL33fQeABluJfne2Xf1lcSVTdykaIkA08U
         WMk5hZ3ci4b6S0kC2HuP1Z10pwsqCxlvaSl7nWxaFxqqh1+7BClQcPQddGlWATa9G7t/
         nAvingciza5uHK9RfHPfUCfLkxuYj/o2mXs33IwICcr//WNVoNfdNMCxJb4p+ttMjb1n
         PDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770919324; x=1771524124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RL+KtDcQa5YZPbZ+XfDdGWOzmh28HH26N59rjfwIUxk=;
        b=dQnBlQjh+YTI/XVAewSMFQdzqaKHh9mguubZDOKSRFmD2XqNK3onYQEH466tmR2s6H
         PpYvhkvDV4OfuzJhsl+5dwHY3sneDmi8u9TeDl00oNdao5IhumNF5iK/ZO4hkcfmwciU
         r3XPEOiSyiHc5nRG/aGKZ4LPUxHoHgv3pTVrxOI/osJH1V9QdjJlpha3Y/rHtXJAc8L1
         Cf4YAJXu4rcEgHLQbTEHpfPb679MK6LVZKjHNo+XoBFsDjL++KZc7U0fjsFDNWbEbbbB
         40Fg5PWEF+3lRnlL2nB4T/URb8R0Up16ZAf3UGR1hwm/kSFt2YZwVIUTY2Evsdgv1zv3
         TQGg==
X-Gm-Message-State: AOJu0YxlbjlE499HyS4/ATJn32daYu94Kgp1vmb6JlP3bSvbEmwvr36l
	L3TZabvm/pGkoNzhc2d5nWP2RbhWRe9tbA15m8yFId9bGcaPZAqdbfOZ/6VLDqQXsv6RBMnr7lU
	0GR4QQtw34FN9geWRa4NoQTWFBcURx0pVk9ncddE2XBRGoEWrj/Xufrwif588u+sLh9eBqwp6co
	ZEJg==
X-Gm-Gg: AZuq6aK4TGVxV50ydWsdIkmZ+8CguPdX/D5n7yOcA9yvea8IWCJkz/6X/AOCLk8yK0h
	PeC9Ap3+l7MsTxDBKUlHqsZztEtwlAFmiwETJv4+mDCqzVJ5udU/1DAi5qZI9CDvdRnpfOgbBRR
	Qhvschsuh1CsSQEJPDTpQ+9LZyClz+13e6BSUoqOC2W0/KMNmWgUo/gfeDWh10estnqu1Ts0x6u
	zQW3dRD/ABtxNv03eRFMZdxTSqsxRTz4JHl2rKT8mWKmqOXkX75QQVN2N6U3QQSZiNYxOUSmO4D
	BaB7/KSe0aVkXH7MmMr9XcPkU2CWLAeN1ojl25RkY6KZfsYdPGuBvS4Nhmx/PAOyehpvVuGJnKY
	NSPi7UyEvKfI3EDwfSDjHklO8grbMLowRyAzsuEdE/PjPJFgb614f5HWM/dkBuozwuQ==
X-Received: by 2002:a17:90b:4fc3:b0:33b:a906:e40 with SMTP id 98e67ed59e1d1-3568f2d68e8mr2889831a91.2.1770919324002;
        Thu, 12 Feb 2026 10:02:04 -0800 (PST)
X-Received: by 2002:a17:90b:4fc3:b0:33b:a906:e40 with SMTP id 98e67ed59e1d1-3568f2d68e8mr2889780a91.2.1770919323113;
        Thu, 12 Feb 2026 10:02:03 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662fac3c1sm9714130a91.17.2026.02.12.10.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 10:02:02 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH wireless-next v3 2/2] wifi: mac80211_hwsim: Add UHR capabilities to the driver
Date: Thu, 12 Feb 2026 23:31:28 +0530
Message-Id: <20260212180128.257565-3-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260212180128.257565-1-karthikeyan.kathirvel@oss.qualcomm.com>
References: <20260212180128.257565-1-karthikeyan.kathirvel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZexzmJ_Si5qic5E_OFiXnc3b-rioKORq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEzOSBTYWx0ZWRfX+E52cQrItyFO
 qwQ1C3wq9A5x4YlAXXDI57K0uCK1UQaiWcgOnGFSWgq1b76dzr9VwilWmykpHGlmaHvkfFBVaDU
 DncaaxjIepZRENXkWQEVBCwq1ea1d466gcft5smpw2G5oV8ZPW7E7RWLbmygh4Puzo1yl96N4a6
 iibCOqykpZEV/yy6q+9RVazaOx8kI+BIzqWI1PC5s+aDlQWK8CzY5zZ4NF9RL7ndTsQl7n4vZFX
 /oDaeyu61mUNKC8JsGywQMl08uFIRwPyDpVk9o4ZKIMYm2gSelf+xNT26Ih9PfA+amw13D1zvww
 gih/1gPBd70fWjTFQI/R8Fdk6O7OzW4X37EmE0Y9GLukjM7YNzvhYyorZiyGL7SvlZMP/DnhaHj
 W/SGgifRLmQ3FcrNij/T+WOkqDykbEtrKqYMXbL9j6kKTNqui+G0jblXMyDDMsx2E6FI+in+Hg0
 VUvdy2f1gYUBWZrVm4w==
X-Authority-Analysis: v=2.4 cv=ZaMQ98VA c=1 sm=1 tr=0 ts=698e159d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=zvSoEyNLsJKm_rXvJ_sA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: ZexzmJ_Si5qic5E_OFiXnc3b-rioKORq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120139
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31789-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RSPAMD_URIBL_FAIL(0.00)[qualcomm.com:query timed out,oss.qualcomm.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim]
X-Rspamd-Queue-Id: A186813021E
X-Rspamd-Action: no action

Add UHR capabilities for bringing up the interface in UHR mode.
This is required to validate UHR test cases.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 285 ++++++++++++++++++
 1 file changed, 285 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..5a576bbb7688 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4478,6 +4478,49 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.mac = {
+				.mac_cap[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
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
+					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
+				.mac_cap[2] =
+					IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
+					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
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
+					IEEE80211_UHR_PHY_CAP_ELR_RX |
+					IEEE80211_UHR_PHY_CAP_ELR_TX,
+			},
+		},
 	},
 	{
 		.types_mask = BIT(NL80211_IFTYPE_AP) |
@@ -4586,6 +4629,50 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.mac = {
+				.mac_cap[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
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
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
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
+					IEEE80211_UHR_PHY_CAP_ELR_RX |
+					IEEE80211_UHR_PHY_CAP_ELR_TX,
+			},
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
@@ -4755,6 +4842,55 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.mac = {
+				.mac_cap[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
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
+					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
+				.mac_cap[2] =
+					IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
+					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
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
@@ -4880,6 +5016,56 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.mac = {
+				.mac_cap[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
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
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
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
 #ifdef CONFIG_MAC80211_MESH
 	{
@@ -5073,6 +5259,55 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.mac = {
+				.mac_cap[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
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
+					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
+					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
+				.mac_cap[2] =
+					IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
+					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
+					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
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
@@ -5219,6 +5454,56 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.mac = {
+				.mac_cap[0] =
+					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
+					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
+					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
+					IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
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
+					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
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
 #ifdef CONFIG_MAC80211_MESH
 	{
-- 
2.34.1


