Return-Path: <linux-wireless+bounces-32452-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHDcJrjcp2lnkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32452-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:18:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEC31FB80F
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 398643048EFE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E5D36C9E1;
	Wed,  4 Mar 2026 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QuQSTlDS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PEdBojAr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C736C5BA
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608611; cv=none; b=OB51p3aoXQZcuxGbV1B8jRIf7Z0J3ZWl+KnlKtKcscSKdWzD20qAieKbzgk6P0TI7dUHZaldR/V8J3kx5icOhqnq8zyIQHgJVJGptIl/0x0kuEVjqnwMUkAS6vnPDessTsBT+JAIFoEDAIR+BFjCWP0jaFYJ1GUTLmpfOT8j96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608611; c=relaxed/simple;
	bh=dUbjEKuFGw8sDFmBIhsQEPuK4lt+Jqt1QtXoBK6aSxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XXgr8UsRr32/orBL+J4Ay+sEdStqEqK/z85xnkbEnRTY8LLNcrwBbxlmk5frKb3uxi9QBu3Aw5v5OdE+x5/PXcC/Zz5C/HzMtqkTLSU8D1fDIWKkWEWC8RdZskF4YkqvgdFAHVbaLA3PmoQUG+fzo2r2efbLpJqFLn60xqRFrY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QuQSTlDS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PEdBojAr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SVbS957059
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/p1K1S4OO0d
	M/4vPIV6L2Sly0W8mLXISPUCdZ4K4f3s=; b=QuQSTlDSY45I8VpC9u7l1c0pX11
	+U2BgT5q5wDFyZkjO2cCD4znO/JLy0pIcltT079mritSBVTEl5rfGEzCsiAIiPTo
	9dZo2xypKERkVu52VYKMuehbMFvth3HbW1cp6PC/2BJOV/e9L21ZKi/I8xi44XDb
	U5QhvyINmQDUwYmuzBS0Q2yerw2w9evt6TLAkorShOoBpGpt1KXdtVG1qFgT4MMK
	88IdFeo/ojg/dilqM6UBX8wzi27OYpBLAB7VFqCHIDdrs+nBymTqP8lY105dvHFH
	thUD5zs/0+M+cEU4U/TcL+ZbOpw/gqGrFsXOSBdsyVfXEslH5vYb9tU1aYg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp6qg9td2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c7384869dafso43261a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608606; x=1773213406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p1K1S4OO0dM/4vPIV6L2Sly0W8mLXISPUCdZ4K4f3s=;
        b=PEdBojArXGtVW3vVcHf0XM8bX+8MAYLnJuLYKKvKWdjghfBUj/hLhpPtTD1pfY5ctB
         b0A1ou/xKIclIsGDdXsrFS2IpWMTwj1rvyZ4VONhKLnrWjQRNmahhWYC80QIRRhZEYH6
         0xD4EVP4ylltmozk+pdhM4/aJaA3bOaHcKQZDIjBjpJ/zw8Ygg/J1her8ShlS+mpiSIe
         enlEDR5URaNjza5937F5lhaND2KnViztMc7U0a3+OoTIG6FFcbkQhwn0qUjADw8tQd/J
         U/7m+Y5a6AI1JHVaCFcocmqiaAJUpRsM498ZDcS6+TEETs1fOY4sPLlfJSpB4SYym0Nz
         Qx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608606; x=1773213406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/p1K1S4OO0dM/4vPIV6L2Sly0W8mLXISPUCdZ4K4f3s=;
        b=uyeGNMAdKlp+yqTPgaouWB9NagmKui54FG+wxRkzMOFABuIquJJMp9CI1tGwnjU7uS
         TOtTRDUCrGCKukQCLOhbuP7rxS0UK24hqDnrUXiPAUT0bK3UNMyhJtc7amgTM/yfkxjx
         ArRRc/LQqeBss0AiH99gPP7CVZYdgtJlb9X40mzP15InykJzNgxiGHegN6Fjx8bkggGx
         baklF2NM2XCTKeFeHE4on76P7MkPp46ZwBJksPDh5ZeHoB6bZATuOQx69vQ/9FdbSEGZ
         xPEz4l9dAH3ejZ7qHtPiwlPKeT9/IiB0LYff4KqSf0YWHolMO0ZTcHpu+H/A4kjNKV1w
         7czg==
X-Gm-Message-State: AOJu0Yz8mF8+LgE28NJtSX5R2eNnbENoC/zVBc20oFD6F3xreMEyq4CV
	f/p+EgrHJXqObRMPZHSsuRyUyAyPKzhk+zBWKzo2l6bohq7v8UJCvu+7zQDJzZS268h1c8tAxp9
	AP017iS5Q9AYGoAksWkpz3iYK3Hbp0dznxqv6ZFAc/IYa8ksI1IIH+y1aYzS7wn3MVTQi
X-Gm-Gg: ATEYQzx2DkZpHufGYDokLdZFy3BJMauVICrbs1iPmTAELZvyp0IrHuEpe0yyPM+0K6e
	6gT21OI3EnL+NA/pXLhyYFg1lQ/Wh16kTQNhvcpYc8jQleuP24BRYGjiE8BUsxLcWEN/MxZ2nDO
	jEmymSmj5BdeIVzJG78TGK9v4eSco43/tidke4NDjiIRAvqbzmNawQEgu1c+Xg0VI15Nny0pq50
	xWJLM/80+RxeQxmHQyNC5BuxwBqe3Q0UgcCMTV5iJrdd+t8GFFgR0eFx6uXU/FjLKZQStPpZoBc
	ny73PVH0Gq2RCZaNxbpQktyoZMqsPM5nsncyqp6wmPJmfFwl69zp0qNMyfkgay2FhSIdXIBicp9
	fwSiaIZR4qnv9DsMKY7pjz/0RZJAVc19cm6Pb4cnXUKrBU3BH0319vwY=
X-Received: by 2002:a05:6a21:6d9c:b0:38f:df47:87bc with SMTP id adf61e73a8af0-3982e201036mr1239511637.64.1772608605831;
        Tue, 03 Mar 2026 23:16:45 -0800 (PST)
X-Received: by 2002:a05:6a21:6d9c:b0:38f:df47:87bc with SMTP id adf61e73a8af0-3982e201036mr1239487637.64.1772608605334;
        Tue, 03 Mar 2026 23:16:45 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:44 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 16/16] wifi: mac80211_hwsim: Add support for extended FTM ranging
Date: Wed,  4 Mar 2026 12:45:38 +0530
Message-Id: <20260304071538.3833062-17-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX1Pl4/Z7L6y4C
 mp8p/v2vvCwYzfjaoR3mmtE3OndK1/m60XJUw37eToNwOVrGj2ww6RrzRdH82PRU6vSYc7Z7XoO
 AKxikybqqorUYMWesklHx4QEJkOoPMDv57QQiLrN4k8CUX/+2iMi8HXiq9T8eGcmUeuPqeNNGL1
 33pgqe0n2zveZEOoyr+YDKMKwgA57ENh+hBKRHxGId6L1jWs0flpE5akqtg9pJmumNU2b3dOxNN
 GVv295DMyspDkl7QqGhTCIknLXK7nV8uzbN37/adS7U+TyRT2N3qDJvCouUhcfZgiNRRAPkvvql
 +nj4mn86/EQyE9sUslEFDtjC06VHGfOmjuJAPqrYA8hTcDypoXavHg8LNmIo8zWznoiWDUqP4Jh
 ArudflWEQ8/q4dKnv/M4++9xKi+l0Z7iLQ4oX9AETZaqnbbi+JiShYAeMxPY4hw9Z6/ev5TRTgK
 +idVgcg4zFUApe6AhQg==
X-Authority-Analysis: v=2.4 cv=UJ3Q3Sfy c=1 sm=1 tr=0 ts=69a7dc5e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=13r4Q-eI3Re6bTJqT04A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: i1KkwWb1s_u3tCrP6KiVVLwaLNxxddt5
X-Proofpoint-GUID: i1KkwWb1s_u3tCrP6KiVVLwaLNxxddt5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040058
X-Rspamd-Queue-Id: 0BEC31FB80F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32452-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>

Introduce support for continuous ranging and advanced timing parameters
in the FTM (Fine Timing Measurement) request, response, and capability
paths. This enables more flexible ranging scenarios with improved
control over measurement timing and session management.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 171 ++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 475918ee8132..12257797f29d 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -844,6 +844,18 @@ hwsim_ftm_result_policy[NL80211_PMSR_FTM_RESP_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_RESP_ATTR_DIST_SPREAD] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_RESP_ATTR_LCI] = { .type = NLA_STRING },
 	[NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC] = { .type = NLA_STRING },
+	[NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_MEASUREMENTS_PER_AW] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_CHANNEL_WIDTH] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -889,6 +901,16 @@ hwsim_ftm_capa_policy[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_FTMS_PER_BURST] = NLA_POLICY_MAX(NLA_U8, 31),
 	[NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_EDCA_BASED_RESPONDER] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -903,6 +925,15 @@ hwsim_pmsr_capa_policy[NL80211_PMSR_ATTR_MAX + 1] = {
 	[NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR] = { .type = NLA_FLAG },
 	[NL80211_PMSR_ATTR_TYPE_CAPA] = NLA_POLICY_NESTED(hwsim_pmsr_capa_type_policy),
 	[NL80211_PMSR_ATTR_PEERS] = { .type = NLA_REJECT }, // only for request.
+	[NL80211_PMSR_ATTR_PD_SUPPORT] = { .type = NLA_FLAG },
+	[NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT] = {
+		.type = NLA_FLAG
+	},
+	[NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE] = { .type = NLA_U32 },
+	[NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE] = { .type = NLA_U32 },
+	[NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR_CONNECTED] = {
+		.type = NLA_FLAG
+	},
 };
 
 static const struct nla_policy hwsim_genl_policy[HWSIM_ATTR_MAX + 1] = {
@@ -3561,6 +3592,49 @@ static int mac80211_hwsim_send_pmsr_ftm_request_peer(struct sk_buff *msg,
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
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
+			request->availability_window))
+		return -ENOBUFS;
+
+	if (request->nominal_time &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME,
+			request->nominal_time))
+		return -ENOBUFS;
+
+	if (request->measurements_per_aw &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW,
+			request->measurements_per_aw))
+		return -ENOBUFS;
+
+	if (request->ingress_distancemm &&
+	    nla_put_u64_64bit(msg, NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
+			      request->ingress_distancemm, NL80211_PMSR_FTM_REQ_ATTR_PAD))
+		return -ENOBUFS;
+
+	if (request->egress_distancemm &&
+	    nla_put_u64_64bit(msg, NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
+			      request->egress_distancemm, NL80211_PMSR_FTM_REQ_ATTR_PAD))
+		return -ENOBUFS;
+
+	if (request->range_report &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT))
+		return -ENOBUFS;
+
+	if (request->pd_suppress_range_results &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS))
+		return -ENOBUFS;
+
 	nla_nest_end(msg, ftm);
 
 	return 0;
@@ -3930,6 +4004,57 @@ static int mac80211_hwsim_parse_ftm_result(struct nlattr *ftm,
 		result->civicloc_len = nla_len(tb[NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC]);
 	}
 
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT])
+		result->tx_ltf_repetition_count =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT])
+		result->rx_ltf_repetition_count =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS])
+		result->max_time_between_measurements =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS])
+		result->min_time_between_measurements =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS])
+		result->num_tx_spatial_streams =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS])
+		result->num_rx_spatial_streams =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME])
+		result->nominal_time =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW])
+		result->availability_window =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_MEASUREMENTS_PER_AW])
+		result->measurements_per_aw =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_MEASUREMENTS_PER_AW]);
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
 
@@ -6431,6 +6556,41 @@ static int parse_ftm_capa(const struct nlattr *ftm_capa, struct cfg80211_pmsr_ca
 	out->ftm.request_civicloc = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_REQ_CIVICLOC];
 	out->ftm.trigger_based = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED];
 	out->ftm.non_trigger_based = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED];
+	out->ftm.support_edca_responder = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_EDCA_BASED_RESPONDER];
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS])
+		out->ftm.max_no_of_tx_antennas =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS])
+		out->ftm.max_no_of_rx_antennas =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA])
+		out->ftm.min_allowed_ranging_interval_edca =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB])
+		out->ftm.min_allowed_ranging_interval_ntb =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES])
+		out->ftm.pd_edca_preambles =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES])
+		out->ftm.pd_ntb_preambles =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS])
+		out->ftm.pd_edca_bandwidths =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS])
+		out->ftm.pd_ntb_bandwidths =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS]);
+
+	out->ftm.support_range_report = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT];
 
 	return 0;
 }
@@ -6453,6 +6613,17 @@ static int parse_pmsr_capa(const struct nlattr *pmsr_capa, struct cfg80211_pmsr_
 		out->max_peers = nla_get_u32(tb[NL80211_PMSR_ATTR_MAX_PEERS]);
 	out->report_ap_tsf = !!tb[NL80211_PMSR_ATTR_REPORT_AP_TSF];
 	out->randomize_mac_addr = !!tb[NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR];
+	out->pd_randomize_mac_addr_conn =
+		!!tb[NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR];
+	out->pd_support = !!tb[NL80211_PMSR_ATTR_PD_SUPPORT];
+	out->pd_concurrent_ista_rsta_support =
+		!!tb[NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT];
+	if (tb[NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE])
+		out->pd_max_peer_ista_role =
+			nla_get_u32(tb[NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE]);
+	if (tb[NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE])
+		out->pd_max_peer_rsta_role =
+			nla_get_u32(tb[NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE]);
 
 	if (!tb[NL80211_PMSR_ATTR_TYPE_CAPA]) {
 		NL_SET_ERR_MSG_ATTR(info->extack, tb[NL80211_PMSR_ATTR_TYPE_CAPA],
-- 
2.34.1


