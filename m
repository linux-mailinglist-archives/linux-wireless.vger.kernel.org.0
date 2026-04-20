Return-Path: <linux-wireless+bounces-35036-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBdlEnTt5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35036-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:10:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F30428AF8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD110300C323
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6472D97BD;
	Mon, 20 Apr 2026 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y9+kB81L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JAajzNu5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1435338B12A
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676208; cv=none; b=tMDHVdDSW01k1aCFGT8ag7+0hxe8fDqldXXLu1DWGqed3Qh7SU3b0zQFXrGjetg/zEzKz5Al/Kske6t8ltkx+Tfkjnqogskskz+/w+RutyOSY6xbtgIzAjv9xDvRGbg7GlFkyhdpgbU2eIIfZPi2h+mxrAtAXqSoZONkpGHLtwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676208; c=relaxed/simple;
	bh=ml2iTznzrrBlLNGOgIlj4g5RPo/jUuCOFRuv+zifa3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=munWCp7q0Ag+YxBWFt2Ds7b4m+BqtdI1GGGIrbfIagX5HFfL/3Vk3SbYRxVv7Xk5/5zcDDuJWASGgKt/uQRJ7FcTv5XrcMNYMVrZ0tiiMfJBp3yOv8JUU+qfeB9FlDIubGsESVihv7SKoXTiIElV7+mH9kyKpmXs3ZR55GfX7Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y9+kB81L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JAajzNu5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K91RkD2281683
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=t3FN6HG5Onw
	nZnQ+Uh4DcENG/3pQLj5Deqhh1sStyzU=; b=Y9+kB81L5EHBkYa7ZLNcr5X2k4J
	3VacsRXyGAL0tSVrmbkZeJ0ExRb7yuywM6xqddtO0mLmpbgS0/58nDIhZBjE6ycO
	CVh5I0wRSfCo1TTBO8OJQU3Mkoq6rehX8tSDV8yP1cafTiQQo+srtR4VxlZMCoLk
	7JbN/1kEfO2DUi0UiG5T1N20WKs+dr6LY+0xPTkir/TYxjG73do9aG5H+jBjZ2qB
	se5V3i0qDvXVJk7hCpUw7AnqB7uRojNzCdHZTJL1w+vxS009QyOe8ZIZI6UlhVtO
	G83FD9nGl4M7lmmIMWlf0npj7FlwvLJWW3Ql3iQUhkSLS1h7EYsUVzXrweA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh59819n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:10:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso5530576a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676203; x=1777281003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3FN6HG5OnwnZnQ+Uh4DcENG/3pQLj5Deqhh1sStyzU=;
        b=JAajzNu5qf2KiNx5D4nwCJVNGOWMs+JQdqzBZbI5/5UdpnwL6OzNEh8uAtRswrYY51
         +rA2mXAxPWlIeFtwRn4DfNTOY1B55nOEgQEPQbjaSQA30QQV0l3toStGq3jnW6fxvbxV
         JgqADxWZy/biKcLGkSN2k+q6CV6wUR0PheyVJBVkwzxpr1Irigf9qARWb8Y4umo+U1Y0
         jHQlIdpMqHyUw1r6X0Sxgj9dvsAh/QLR7le9dUY/WSseDyUjkvREG6yCGSuxlvGGFRxS
         OLv4+oBsrL4UH3+LG+ttBcF5zSb1uwhYGyW/R7iq0gudkp8xKArfmt6Hn1BBVLPcxnRw
         +eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676203; x=1777281003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3FN6HG5OnwnZnQ+Uh4DcENG/3pQLj5Deqhh1sStyzU=;
        b=p/cODC9u0HQtdDqP4NAia8rBCn/i/ARNU7taa7Y/VTdeONaEYHqT4jffh4AXNNuLbt
         Cw4rQxKO+DacSMtIZUr4xaZol/sskQtcznvmmXc3tT7ycVOTp1SxCbPHdz6BvlTOQKUv
         SD2VbLZvP9UbqNbkmx+nf+oDZUVNuOlM1A5PehX/e973NwBW9QvQUzjx8C1j8BkEVUZe
         MRyIR0HDNtDO66TKDrygGsWCF0ujUnxQWOWArm7iAqW9SDW2o7g0BSuycGBcZFQrBqgl
         YGB2yIBNC4w/VTgvgZPtIbiXlNqsxCgYBMpV6ZFp98Lt1F/HDz7EMdBUec/mBSA6bir1
         LB4g==
X-Gm-Message-State: AOJu0YxO/pRQJbvMdMtW2zyYCgK/ck2Vst53S/ZcWpZvJMwnojtJKEyG
	yS8BONp7O7w/ULxyFGca2n7pvlaw6IRpEePSrRSnlWqAtOEO24jA93E/CbcJAvPG2d6ryvQ36HH
	Z+nFxtQsmDopu74E45eFnDArXmWOIGWkWq3KGqAiq0+H6SaBqbHxO5KdvLAEq1xPiSuWB
X-Gm-Gg: AeBDies5Q4R7bE5QpIK3iM+nhgh1TPFrwbJ975S5+hh3xK3KBkVTRJxOsNRg51vtT7Y
	16TooUYwBHVQ+mLdiKilt/HbkwAYsJHvWQLEQnCF9Xcfjme4JOURmwNh/sWUUD2okesM9t+/ufO
	XXy2AOFvORll1afxYp7GNHqiy58If2URgEMr0eMXmdkQ4sIa0tr2uWWvKXcVpeYGYG5UVBHySv/
	e1/1ryVmruPXaIbSy3hreaZtmlr5VE9IO39LN1AN1vaON64dH8abeHDTsLw210aUETo+1varDiK
	HVBkfmoY+bVrxWS/nlnYOwd71qYLK9P4vpRa0zuXv0R1himeCy2lgvH3vrzWEVEQBi7wWOIbVvM
	sOAB9Wp+uvmq/tnstAkvMDwSEWRGmkhuD/vAjLKUeByMJ6uSj3LxB4E1+/z8VaYyS+A==
X-Received: by 2002:a17:90b:3909:b0:35e:3e86:e2d3 with SMTP id 98e67ed59e1d1-361403f12fcmr13880508a91.10.1776676202778;
        Mon, 20 Apr 2026 02:10:02 -0700 (PDT)
X-Received: by 2002:a17:90b:3909:b0:35e:3e86:e2d3 with SMTP id 98e67ed59e1d1-361403f12fcmr13880484a91.10.1776676202282;
        Mon, 20 Apr 2026 02:10:02 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:10:01 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 13/13] wifi: mac80211_hwsim: Add support for extended FTM ranging
Date: Mon, 20 Apr 2026 14:38:56 +0530
Message-Id: <20260420090856.2152905-14-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
References: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2LdAP3M1Y-VGER2WS9VSFeUFnbhngXBi
X-Proofpoint-GUID: 2LdAP3M1Y-VGER2WS9VSFeUFnbhngXBi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NiBTYWx0ZWRfX4VJ4xq7EnjVN
 IIj7YMjYuGLVZ2t7XLzezMugM2Otc5rFqr6VqlG6hPS3rHVo1jFNoBlET4WiHrUnzqU9Z1ID+Px
 bqtxx6fsLcqbjdTnGgMt+Zpn4CkImX9oJRXWEx9uDc19n0PLp6pc0zzYBgaegAk7TbTnE+xuTp3
 P5S9EsPoSSHTzrU/su3YRM1evF1Ls/BD3/2grvSZU95ueVKG62hF+mx3ssdasoNsi6WXa1NevnQ
 tyei0N9SY+XumyWloac4P+seJZ7HNojk3hyAYaTmdXUqkEIiGUG79J73cRMbNWyaMywPpHZgA/f
 6qcYzS26WGxAYP3UuzPcV/UdUyd/nkrE+3uNTDuRJ63olac3XBIAEUT2xzHfjKJQCsycfAvRXqj
 1W950yvVvUu4xbf2v8JOIPUqTGDFneXZk074lZkKKeIR/uDhlARhcsXQsKIWCNk//EwyhPMZzr1
 UxHA7OG+CY7DY1KDEoQ==
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=69e5ed6c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=OkJDwh_UPq5n3OtPVzQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200086
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35036-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D9F30428AF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>

Introduce support for continuous ranging and advanced timing
parameters in the FTM request, response, and capability paths.
This enables more flexible ranging scenarios with improved control
over measurement timing and session management.

Co-developed-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 217 ++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 1fcf5d0d2e13..a06bb22dbdf0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -848,6 +848,17 @@ hwsim_ftm_result_policy[NL80211_PMSR_FTM_RESP_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_RESP_ATTR_DIST_SPREAD] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_RESP_ATTR_LCI] = { .type = NLA_STRING },
 	[NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC] = { .type = NLA_STRING },
+	[NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_CHANNEL_WIDTH] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -881,6 +892,19 @@ hwsim_pmsr_peers_result_policy[NL80211_PMSR_ATTR_MAX + 1] = {
 	[NL80211_PMSR_ATTR_PEERS] = NLA_POLICY_NESTED_ARRAY(hwsim_pmsr_peer_result_policy),
 };
 
+static const struct nla_policy
+hwsim_ftm_role_capa_policy[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1] = {
+	[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA] = { .type = NLA_FLAG },
+};
+
+static const struct nla_policy
+hwsim_ftm_type_capa_policy[NL80211_PMSR_FTM_TYPE_CAPA_ATTR_MAX + 1] = {
+	[NL80211_PMSR_FTM_TYPE_CAPA_ATTR_INFRA_SUPPORT] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_TYPE_CAPA_ATTR_PD_SUPPORT] = { .type = NLA_FLAG },
+};
+
 static const struct nla_policy
 hwsim_ftm_capa_policy[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_CAPA_ATTR_ASAP] = { .type = NLA_FLAG },
@@ -893,6 +917,19 @@ hwsim_ftm_capa_policy[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_FTMS_PER_BURST] = NLA_POLICY_MAX(NLA_U8, 31),
 	[NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_PREAMBLES] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_BANDWIDTHS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS] =
+		NLA_POLICY_NESTED(hwsim_ftm_role_capa_policy),
+	[NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS] =
+		NLA_POLICY_NESTED(hwsim_ftm_role_capa_policy),
+	[NL80211_PMSR_FTM_CAPA_ATTR_TYPE_CAPS] =
+		NLA_POLICY_NESTED(hwsim_ftm_type_capa_policy),
+	[NL80211_PMSR_FTM_CAPA_ATTR_CONCURRENT_ISTA_RSTA_SUPPORT] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -3623,6 +3660,47 @@ static int mac80211_hwsim_send_pmsr_ftm_request_peer(struct sk_buff *msg,
 	if (nla_put_u8(msg, NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR, request->bss_color))
 		return -ENOBUFS;
 
+	if (request->min_time_between_measurements &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS,
+			request->min_time_between_measurements))
+		return -ENOBUFS;
+
+	if (request->max_time_between_measurements &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS,
+			request->max_time_between_measurements))
+		return -ENOBUFS;
+
+	if (request->availability_window &&
+	    nla_put_u8(msg, NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
+		       request->availability_window))
+		return -ENOBUFS;
+
+	if (request->nominal_time &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME,
+			request->nominal_time))
+		return -ENOBUFS;
+
+	if (request->num_measurements &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS,
+			request->num_measurements))
+		return -ENOBUFS;
+
+	if (request->ingress_distancemm &&
+	    nla_put_u64_64bit(msg, NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
+			      request->ingress_distancemm,
+			      NL80211_PMSR_FTM_REQ_ATTR_PAD))
+		return -ENOBUFS;
+
+	if (request->egress_distancemm &&
+	    nla_put_u64_64bit(msg, NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
+			      request->egress_distancemm,
+			      NL80211_PMSR_FTM_REQ_ATTR_PAD))
+		return -ENOBUFS;
+
+	if (request->pd_suppress_range_results &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS))
+		return -ENOBUFS;
+
 	nla_nest_end(msg, ftm);
 
 	return 0;
@@ -3992,6 +4070,69 @@ static int mac80211_hwsim_parse_ftm_result(struct nlattr *ftm,
 		result->civicloc_len = nla_len(tb[NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC]);
 	}
 
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT]) {
+		result->tx_ltf_repetition_count_valid = 1;
+		result->tx_ltf_repetition_count =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT]) {
+		result->rx_ltf_repetition_count_valid = 1;
+		result->rx_ltf_repetition_count =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS]) {
+		result->max_time_between_measurements_valid = 1;
+		result->max_time_between_measurements =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS]) {
+		result->min_time_between_measurements_valid = 1;
+		result->min_time_between_measurements =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS]) {
+		result->num_tx_spatial_streams_valid = 1;
+		result->num_tx_spatial_streams =
+			nla_get_u8(tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS]) {
+		result->num_rx_spatial_streams_valid = 1;
+		result->num_rx_spatial_streams =
+			nla_get_u8(tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME]) {
+		result->nominal_time_valid = 1;
+		result->nominal_time =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW]) {
+		result->availability_window_valid = 1;
+		result->availability_window =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_CHANNEL_WIDTH]) {
+		result->chan_width_valid = 1;
+		result->chan_width =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_CHANNEL_WIDTH]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE]) {
+		result->preamble_valid = 1;
+		result->preamble =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE]);
+	}
+
+	result->is_delayed_lmr =
+		nla_get_flag(tb[NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR]);
+
 	return 0;
 }
 
@@ -6532,6 +6673,82 @@ static int parse_ftm_capa(const struct nlattr *ftm_capa, struct cfg80211_pmsr_ca
 	out->ftm.trigger_based = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED];
 	out->ftm.non_trigger_based = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED];
 
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS])
+		out->ftm.max_no_of_tx_antennas =
+			nla_get_u8(tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS])
+		out->ftm.max_no_of_rx_antennas =
+			nla_get_u8(tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA])
+		out->ftm.min_allowed_ranging_interval_edca =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB])
+		out->ftm.min_allowed_ranging_interval_ntb =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_PREAMBLES])
+		out->ftm.pd_preambles =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_PREAMBLES]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_BANDWIDTHS])
+		out->ftm.pd_bandwidths =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_BANDWIDTHS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS]) {
+		struct nlattr *ista_tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1];
+
+		if (!nla_parse_nested(ista_tb, NL80211_PMSR_FTM_CAPA_ATTR_MAX,
+				      tb[NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS],
+				      hwsim_ftm_role_capa_policy, NULL)) {
+			out->ftm.ista.support_ntb =
+				!!ista_tb[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB];
+			out->ftm.ista.support_tb =
+				!!ista_tb[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB];
+			out->ftm.ista.support_edca =
+				!!ista_tb[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA];
+			if (ista_tb[NL80211_PMSR_ATTR_MAX_PEER_ISTA_ROLE])
+				out->ftm.ista.max_peers =
+					nla_get_u32(ista_tb[NL80211_PMSR_ATTR_MAX_PEER_ISTA_ROLE]);
+		}
+	}
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS]) {
+		struct nlattr *rsta_tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1];
+
+		if (!nla_parse_nested(rsta_tb, NL80211_PMSR_FTM_CAPA_ATTR_MAX,
+				      tb[NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS],
+				      hwsim_ftm_role_capa_policy, NULL)) {
+			out->ftm.rsta.support_ntb =
+				!!rsta_tb[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB];
+			out->ftm.rsta.support_tb =
+				!!rsta_tb[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB];
+			out->ftm.rsta.support_edca =
+				!!rsta_tb[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA];
+			if (rsta_tb[NL80211_PMSR_ATTR_MAX_PEER_RSTA_ROLE])
+				out->ftm.rsta.max_peers =
+					nla_get_u32(rsta_tb[NL80211_PMSR_ATTR_MAX_PEER_RSTA_ROLE]);
+		}
+	}
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_TYPE_CAPS]) {
+		struct nlattr *type_tb[NL80211_PMSR_FTM_TYPE_CAPA_ATTR_MAX + 1];
+
+		if (!nla_parse_nested(type_tb, NL80211_PMSR_FTM_TYPE_CAPA_ATTR_MAX,
+				      tb[NL80211_PMSR_FTM_CAPA_ATTR_TYPE_CAPS],
+				      hwsim_ftm_type_capa_policy, NULL)) {
+			out->ftm.type.infra_support =
+				!!type_tb[NL80211_PMSR_FTM_TYPE_CAPA_ATTR_INFRA_SUPPORT];
+			out->ftm.type.pd_support =
+				!!type_tb[NL80211_PMSR_FTM_TYPE_CAPA_ATTR_PD_SUPPORT];
+		}
+	}
+
+	out->ftm.concurrent_ista_rsta_support =
+		!!tb[NL80211_PMSR_FTM_CAPA_ATTR_CONCURRENT_ISTA_RSTA_SUPPORT];
+
 	return 0;
 }
 
-- 
2.34.1


