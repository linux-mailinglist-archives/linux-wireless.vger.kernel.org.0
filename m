Return-Path: <linux-wireless+bounces-31386-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J3GENHVfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31386-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9706EBC55B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F5F930071F6
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC2D32B992;
	Fri, 30 Jan 2026 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NPeHulKI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F0t3AeN5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972AF342C98
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788863; cv=none; b=IDxnc+TFG5mspnMLdfrlC8626gE6NDODr4ReGbjRrsAO6V9R96AA56PFzMGJJoFyy3vFlpRztRhVb8L6lpWD5UOJnSSSkerGTX8ynBKt9ujhkU5+IzEK1ygs5H6XPJX0BN1LwspUf4uEpCb7mmZozOKXnXFXfFxVoyZvAHrijGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788863; c=relaxed/simple;
	bh=fzzTIEp8pe8QVTfBQ/SgXHlC1n3uy+doLGM/PmA6BkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1yexHYawXU0kfW/kNAwFr/JXmxUdxanGWMEm2rGeykS1niKBllkaa3FuESqale71GOm+VTV4f3hxOS8vaOii4Qv+0d/MU1AnyDfn1f8rHVmGiFlGZgeBErfOMfvqnx8eYSqse/6Wm7f/v3q91No+rZ4eFT0QtPCcuEOnV0/kDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NPeHulKI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F0t3AeN5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UCrATF2294979
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WqlJD9qY67T
	2f4D1Y3MiI8npAJwdmnb7wMTOG5rozFc=; b=NPeHulKIRbx4fpyE362KAssXPk9
	WmGqXSMoLfAOw2VExsEwXfETQM4eYBXaH9XplCpac00pFN6N8jMYIrq9EllBpKY4
	6JDPnlX8fvY788cIR8tsB5vQs/ICgFzI9cuLsIyZdwhhXLBOHpxGYI6wLzkW2nTP
	GfoL4ZUgfRGIDac9zWXHrOo/qlnzWJIC3A5sDqttB3T9onEIH2+ckxXcXt1u73m8
	fT5W5GNSF8dGPvqJ/NTQ7ia0HQGqbiLWa3CaVcIsDLjbyBFtM4QCv+X6vQn7+Q27
	/5lJAI7F+ZaBvCScUxIYvk6KC4QTGKDbwT5CEQeka9fyPyniG8YRIymhMMw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0p1x9wb0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-352de7a89e1so1973633a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788859; x=1770393659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqlJD9qY67T2f4D1Y3MiI8npAJwdmnb7wMTOG5rozFc=;
        b=F0t3AeN5TJNVEytRRzglIX8kd92d/vI6TwsSTy2oMdxozJxWpr3dGiJOoOTWB5Js/I
         f8x70K+G6FQn8pOTnwTAC9kYn485rmJ3THr19Muh1NJyhFmQLFAEESGIqlwdX9fkY+9f
         zpPsM6ijHhzz3mlF+8xAyM+bgf7wCur9bUezbfv2vXNMOinGq6K/uOts/qX2OEu3LqoL
         swiozUtlqm90uNBIOF//haDkYsxgCeJCdXeIEiVdmUfAN+JIKD67UbV+1fZ0R3nNAyro
         DAAMksFBiRijjVLx58tFElLsG1AUm2AlNpmnyEdGe425coVEQ4cT76xt6NXNQpW0nXSK
         00Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788859; x=1770393659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WqlJD9qY67T2f4D1Y3MiI8npAJwdmnb7wMTOG5rozFc=;
        b=fNLRL1G28pZ261WLa2PHRpHVTGYPtIwDUwkDpoBD9R24QcHMYVuCiROta5gxAngFnS
         TvfaCK84TnMs9njVSAk8kXLCOG6o0OaxbEzjc8R03x2zb2VO2/0VFKSoeKXqCqbTnY2W
         G0+znqVGwk1IpJE9HjeLsw2tJxCj+J02aWuzpwb24Gj4p7yFeeF+qEGZO/cslfZ0brYf
         x2m8Pd6CdoINPfS2PUmdq5iSmvfGOwDs7P+EwI5yLQVbO+1X6OG/l7iCDutV2o5Uf1hB
         OUhYA7nKxKSzU0Kl9852UCYb2PnluMssVG3REuMQFy/ppAa1aGI0EGpUx80A38qQ9E5n
         hQgw==
X-Gm-Message-State: AOJu0YyfdwpfMKxr9SKD4ImX2fNZMCtaZucwQPgYWP/5LSwNKr7hRfIr
	jZcWeWdkIxnbe89yGnjULqVQbm++LgwY0k25Ce3RA/HIy/ulsxSH5Gky5F3zLXLbt6pimaedGcI
	0IPgf9AU60undikb5tLpPpljCbJtQoAZ2ZHzgBWzTcSVs6I/1E4gYdjzQ8eIC6n647QedmQ7qFS
	ri
X-Gm-Gg: AZuq6aIwZydCBORSfchnPCZBpgPns0JqHG8LzvtUAyJalgXxtrQivqzHSWkc1LufS0g
	2FGpfMZ+yzbmvMt+zXu1xHkw71dEqL/IWxUEDtTnzglpamKC50r3iLr0EPvTvR8rkzTxvM73sqk
	aeNwglivO8qg+V6urjajYWauuLgw02OADST7wtqFJpaIg6LaxUBHbSQcbI+WIcy4vc7wijpCUqq
	BYwixCumwJWLcY/2DywhcPsyH6GzVbZOIfjj3iWpRGFhJ8heG43VjU1jw80B2E2cKqHL3rpdJX6
	XqwBJH57qwZ88UrDZjA3rKAwN6TSF26BCaJYC5TZpoQqTybBCiCtdNQNEKRB+0v8DsANk56zDuE
	KxVNw7faPSFnqnEaGr1THQKOA73ZFwXD6V+AD8o0v1NQ=
X-Received: by 2002:a17:90b:50c3:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-3543b3f3682mr3619009a91.33.1769788858760;
        Fri, 30 Jan 2026 08:00:58 -0800 (PST)
X-Received: by 2002:a17:90b:50c3:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-3543b3f3682mr3618918a91.33.1769788857883;
        Fri, 30 Jan 2026 08:00:57 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:00:57 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 02/13] wifi: nl80211/cfg80211: add proximity detection capabilities to PMSR
Date: Fri, 30 Jan 2026 21:30:28 +0530
Message-Id: <20260130160039.2823409-3-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: N0_6B0OC1op-3jPA0ZZ6h5or_LO0uSqf
X-Proofpoint-ORIG-GUID: N0_6B0OC1op-3jPA0ZZ6h5or_LO0uSqf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfX4u7/+NojeKpw
 Lq7ElIOhS9mLda+yrIpeJ7cCNv8FegtGVApIYx565RQJgWPNeOn889ws1H8xozmFptLyAbmk6Ds
 M/k1P6VaZWsQUpKMEuRtPCJTtViXzVqlkGcoXsjwrM9jH/7hcKXZ69xhsM57toDyL/LTQmiylgM
 xgDYAmOF1wCxEmXaVz4MF/baJX0UvAUsRSaCXXb0y1D1MSWtp/gXNzZ0WVBpWExjI1qiY8oTkWx
 PD0yIRBHYXkc0MgyZlOv5pOGcydRdZmen91CdG/I5ek77fhb0XYoKbxEVyBz4yDhJPZhRe5s1Cz
 uTrhOqHwSqtY7W+wgzrmkD6dhV9pYPim/iwD+SY/60yxIPVWM9oTCTqHHnBXx5XLigWtOrhpZHM
 Zi4x3ZhRLJ3O2cTzYKydX0PzaKAAB3PtNlsdzbOdwRHdh9VIW5/gBctsWnpOW7PzBhiI5cMBCPy
 3oBf80qwFN9+uLSDxbQ==
X-Authority-Analysis: v=2.4 cv=G5cR0tk5 c=1 sm=1 tr=0 ts=697cd5bc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=nclPvYkPYs_wI36UdL8A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31386-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9706EBC55B
X-Rspamd-Action: no action

Add support for Proximity Detection (PD) capabilities in Peer Measurement
Service (PMSR) as defined in the Wi-Fi Alliance specification
"PR Implementation Consideration Draft 1.9 Rev 1". This includes the PD
support flag, concurrent ISTA/RSTA support for simultaneous initiator
and responder roles.

Additionally, extend FTM capabilities with antenna configuration, ranging
intervals for EDCA/NTB-based ranging, and EDCA based responder support
flags with corresponding netlink attributes and capability reporting.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 28 ++++++++++++++++++++++++++--
 include/uapi/linux/nl80211.h | 29 +++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 32 ++++++++++++++++++++++++++++++++
 net/wireless/pmsr.c          |  3 ++-
 4 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 83dbe9aeab4d..fedff0a8b982 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5633,6 +5633,13 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  * @max_peers: maximum number of peers in a single measurement
  * @report_ap_tsf: can report assoc AP's TSF for radio resource measurement
  * @randomize_mac_addr: can randomize MAC address for measurement
+ * @pd_support: supports peer-to-peer ranging as mentioned in the specification
+ *	"PR Implementation Consideration Draft 1.9 rev 1" where PD stands for
+ *	proximity detection
+ * @pd_concurrent_ista_rsta_support: As the peer measurement request can be a
+ *	multi-peer request this will indicate if the device can act
+ *	simultaneously as initiator and a responder. Only valid if @pd_support
+ *	is set.
  * @ftm: FTM measurement data
  * @ftm.supported: FTM measurement is supported
  * @ftm.asap: ASAP-mode is supported
@@ -5659,12 +5666,24 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	(0 means unknown)
  * @ftm.max_total_ltf_rx: maximum total number of LTFs that can be received
  *	(0 means unknown)
+ * @ftm.max_no_of_tx_antennas: maximum number of transmit antennas supported for
+ *	ranging
+ * @ftm.max_no_of_rx_antennas: maximum number of receive antennas supported for
+ *	ranging
+ * @ftm.min_allowed_ranging_interval_edca: Minimum EDCA ranging
+ *	interval supported by the device in milli seconds. (0 means unknown)
+ * @ftm.min_allowed_ranging_interval_ntb: Minimum NTB ranging
+ *	interval supported by the device in milli seconds. (0 means unknown)
  * @ftm.support_rsta: supports operating as RSTA in PMSR FTM request
+ * @ftm.support_edca_responder: supports operating as FTM responder in PMSR FTM
+ *	request for EDCA-based ranging
  */
 struct cfg80211_pmsr_capabilities {
 	unsigned int max_peers;
 	u8 report_ap_tsf:1,
-	   randomize_mac_addr:1;
+	   randomize_mac_addr:1,
+	   pd_support:1,
+	   pd_concurrent_ista_rsta_support:1;
 
 	struct {
 		u32 preambles;
@@ -5685,7 +5704,12 @@ struct cfg80211_pmsr_capabilities {
 		u8 max_rx_sts;
 		u8 max_total_ltf_tx;
 		u8 max_total_ltf_rx;
-		u8 support_rsta:1;
+		u8 max_no_of_tx_antennas;
+		u8 max_no_of_rx_antennas;
+		u32 min_allowed_ranging_interval_edca;
+		u32 min_allowed_ranging_interval_ntb;
+		u8 support_rsta:1,
+		   support_edca_responder:1;
 	} ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d4738bcc9914..6a858e46bf3e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7745,6 +7745,15 @@ enum nl80211_peer_measurement_peer_attrs {
  *	meaningless, just a list of peers to measure with, with the
  *	sub-attributes taken from
  *	&enum nl80211_peer_measurement_peer_attrs.
+ * @NL80211_PMSR_ATTR_PD_SUPPORT: flag attribute in capability indicating
+ *	that the device supports peer-to-peer ranging as mentioned in the
+ *	specification "PR Implementation Consideration Draft 1.9 rev 1" where
+ *	PD stands for proximity detection
+ * @NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT: flag attribute in
+ *	capability indicating that as the peer measurement request can be a
+ *	multi-peer request, the device can act simultaneously as initiator and
+ *	a responder, where the multiple requests are being processed
+ *	simultaneously
  *
  * @NUM_NL80211_PMSR_ATTR: internal
  * @NL80211_PMSR_ATTR_MAX: highest attribute number
@@ -7757,6 +7766,8 @@ enum nl80211_peer_measurement_attrs {
 	NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR,
 	NL80211_PMSR_ATTR_TYPE_CAPA,
 	NL80211_PMSR_ATTR_PEERS,
+	NL80211_PMSR_ATTR_PD_SUPPORT,
+	NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT,
 
 	/* keep last */
 	NUM_NL80211_PMSR_ATTR,
@@ -7815,6 +7826,19 @@ enum nl80211_peer_measurement_attrs {
  *	This limits the allowed combinations of LTF repetitions and STS.
  * @NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT: flag attribute indicating the
  *	device supports operating as the RSTA in PMSR FTM request
+ * @NL80211_PMSR_FTM_CAPA_ATTR_EDCA_BASED_RESPONDER: flag attribute indicating
+ *	the device supports operating as the Responder in PMSR FTM request for
+ *	EDCA-based ranging.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS: u8 attribute indicating
+ *	the maximum number of transmit antennas supported for ranging
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS: u8 attribute indicating
+ *	the maximum number of receive antennas supported for ranging
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA: u32 attribute indicating
+ *	the minimum EDCA ranging interval supported by the device
+ *	in milli seconds. (0 means unknown)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB: u32 attribute indicating
+ *	the minimum NTB ranging interval supported by the device
+ *	in milli seconds. (0 means unknown)
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -7840,6 +7864,11 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_TX,
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_RX,
 	NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT,
+	NL80211_PMSR_FTM_CAPA_ATTR_EDCA_BASED_RESPONDER,
+	NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS,
+	NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS,
+	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA,
+	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9aa83a6943a2..accbc80b4a90 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -394,6 +394,10 @@ nl80211_pmsr_attr_policy[NL80211_PMSR_ATTR_MAX + 1] = {
 	[NL80211_PMSR_ATTR_TYPE_CAPA] = { .type = NLA_REJECT },
 	[NL80211_PMSR_ATTR_PEERS] =
 		NLA_POLICY_NESTED_ARRAY(nl80211_pmsr_peer_attr_policy),
+	[NL80211_PMSR_ATTR_PD_SUPPORT] = { .type = NLA_REJECT },
+	[NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT] = {
+		.type = NLA_REJECT
+	},
 };
 
 static const struct nla_policy
@@ -2340,6 +2344,25 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	if (cap->ftm.support_rsta &&
 	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT))
 		return -ENOBUFS;
+	if (cap->ftm.support_edca_responder &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_EDCA_BASED_RESPONDER))
+		return -ENOBUFS;
+	if (cap->ftm.max_no_of_tx_antennas > 0 &&
+	    nla_put_u8(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS,
+		       cap->ftm.max_no_of_tx_antennas))
+		return -ENOBUFS;
+	if (cap->ftm.max_no_of_rx_antennas > 0 &&
+	    nla_put_u8(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS,
+		       cap->ftm.max_no_of_rx_antennas))
+		return -ENOBUFS;
+	if (cap->ftm.min_allowed_ranging_interval_edca > 0 &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA,
+			cap->ftm.min_allowed_ranging_interval_edca))
+		return -ENOBUFS;
+	if (cap->ftm.min_allowed_ranging_interval_ntb > 0 &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
+			cap->ftm.min_allowed_ranging_interval_ntb))
+		return -ENOBUFS;
 
 	nla_nest_end(msg, ftm);
 	return 0;
@@ -2374,6 +2397,15 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
 	    nla_put_flag(msg, NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR))
 		return -ENOBUFS;
 
+	if (cap->pd_support) {
+		if (nla_put_flag(msg, NL80211_PMSR_ATTR_PD_SUPPORT))
+			return -ENOBUFS;
+
+		if (cap->pd_concurrent_ista_rsta_support &&
+		    nla_put_flag(msg,
+				 NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT))
+			return -ENOBUFS;
+	}
 	caps = nla_nest_start_noflag(msg, NL80211_PMSR_ATTR_TYPE_CAPA);
 	if (!caps)
 		return -ENOBUFS;
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 4db6c40dd782..8cc8d6be0e98 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -188,7 +188,8 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	}
 
 	out->ftm.rsta = !!tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA];
-	if (out->ftm.rsta && !capa->ftm.support_rsta) {
+	if (out->ftm.rsta && !capa->ftm.support_rsta &&
+	    !capa->ftm.support_edca_responder) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
 				    "FTM: RSTA not supported by device");
-- 
2.34.1


