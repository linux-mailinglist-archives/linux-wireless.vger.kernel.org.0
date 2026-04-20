Return-Path: <linux-wireless+bounces-35031-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPRGKaXt5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35031-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:11:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4176E428B15
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCAC3303DA2C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0B38BF7F;
	Mon, 20 Apr 2026 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AwT0UWxJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S32sAGI4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062C73859D6
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676194; cv=none; b=mx0x0Fntl1OJ3HDyt89Jq0HnLRrqW+D+/NEljoE8mxQDZUQO2OXi0sNAZH+WZaCgB6545PvlAhDHTYg8j6jX0AKtjW0Wm+rPT9gj+1a8OOBaHamWyDLKWa5Wd9L8UYp8t4YmjuNCsluVHkaDHiLQAn4oVIkK94yCQK6GqPJphDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676194; c=relaxed/simple;
	bh=NjoNIAb7XpW42WFDv2v0hRb0j97KB1JyKXJUaFoQI3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D26r4Gp18a9HNf89dkZOUwI8pL6Uc1HA6UrhgwK+IXCRKqigwy9S2pzlAzRRx7e+XTra7u2/PIZOURG4mmnGD7Rj7TT6JSFQyWH0DPgwWF+K3aJYeR8D6ttclo5JfpwrsD1Cp1N6v33GkZt55DqX2IjwlCtjq2zS9ktx6b/7iO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AwT0UWxJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S32sAGI4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K5oC3f1624231
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DMGRO1W+HYE
	Fb0wN1sCELHBQSSWtcksoMJClSqSj7VM=; b=AwT0UWxJGHzAWtiGl7HPbzu6oow
	1JLEkEWzEc8iYo3V1UvCltiA4rICZf5sNRsj8dr3Y3Uhvnf7LshSeYXlQXDhXJgC
	ilFz8bTs8r1iL+RNLgn+NgFHbjYd9KasUeY8Zj6lOEeG7mRYxW6PeU88tkc8Ra1I
	x2i8GBtjWmGJq2k880XKrikoWKT76cbNai0PEDyhLmHoceepijoQXp+wOvwLLz0r
	Bkf2EIHaqfpoDjc26QbiiHBnVpcYfNzeWen9Z1omFjtL/o8fMHUl7cPypYYVFdLW
	FVP/aDr+Y1zw6Z0nvcF6jbXCTAwVHIdJi2R5a2D1+Ehl6/RiY6S/z0Cs4ww==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2qan933-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35da99b90f6so3524270a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676192; x=1777280992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMGRO1W+HYEFb0wN1sCELHBQSSWtcksoMJClSqSj7VM=;
        b=S32sAGI4QIwkSunZvYY6yjk5QABJnskDsvxmckrLEP3OfMAXEHe1Y2iAAta4nh4ri9
         Hw18RikFiAmdaqIcAiPH3OfnJROxTKPzIPl0vuM7C3qBv30FUekFtGwak+Lr6k7L9Ujv
         KFJMH5O6H7lDEpASYxRWbgrGmXa0XClaqDNPH+t3WrVh7olIW2rmFPehW7QBjgAXpwl6
         mNm570Yzo2hDTbPfkqhk9XSjOs9el9lfUkas8aIELYiU37Uq88RzKMUPTsenavLdONMm
         xxTV+sgNYjByLpTYtLVvLBO65DmbA7YgDoGrtGhHIsKgOH8/8ktCbMjE/gFbmeIytNvC
         C6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676192; x=1777280992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DMGRO1W+HYEFb0wN1sCELHBQSSWtcksoMJClSqSj7VM=;
        b=LrspUD2xtw+/yTBapfA79MRKl3XrcBao70dLznA3gwiKTm7rjJ6B03OYeaVMTOt3bn
         swhJl2smiMb8oq1rUbeH3GicGxI7e8sDiQybRxepfYE/s9f8co6/KjC9evDXWPha0PUE
         LxjADWPdESGjjPTO6V1qkJ+1vMcEG0PyCLTDl5dfW+MLb/bEvwlA2CWX1JtWpJSDCgMG
         CkvHYwTRYYj55n/GzZ7Tj91K5IN8uR8a8qyqzBvJhdLZX06zL0Lta4RDQ/XROnjl0AOh
         WN0NHBCSXa9+ofoyubiYcgHriHZPUHiw0133C5ZHsE5Y2T4q61Q+FXWD/QEjUmE+gflz
         VVqg==
X-Gm-Message-State: AOJu0YwNpRg2ijUbacdMSGhau4PXfyVHfMbt1fKWXDMGj2SgX4la5R6m
	89wPNnrUodi3ZqnFVOs8E1X9VxVfHQsciQAEYAB3S2+BfZzZtcGgsowPxUp6VcmqcKRB3XgSnJA
	e/MzaYnVn8OxTB0QbI2dNmbRXTRZqlop3OagFrtfAb4FHA+kFMMHq8RlXVhVJ8184lB17
X-Gm-Gg: AeBDieucipEm417pvY8N05D6hD5jQEqQfc+5em4TAMV4DwQ1tIS3aLZCmub6V3H0RPx
	0oTUTWcjxOaq5HTThyl4P6ly2o4kEg0eZ4ZYQxNdCdn2I8jQK6D+t58sCDAFefdcNXSXeVzJi2m
	vt44vDSsErQ+Zt7/KS2c4e4PhcvDgmcZq2LIO1CFK+UHElKdfpIa81G6YSWZD9Bv8x6nrIy7Kiw
	WsfNwTJiNWmLrEu1ywLdka0sYLlESGhZv38wdFEjQeKZxxO3OtqjfTm1/V4GhD0JC1pNnJVOsfT
	32s8VOkaDhfdBi2T484rPTXUeYe0PVy7rAaGNUK+N794bk5XgyGhDHE4OK4m3pRe0HnNsX/KEmG
	jeqe8t9b2Qu5LOgIKH/Vmwkn2rBAn/MTbhsgqCWxNuXcelZgjvVDtz3qr4DA6+LVxDg==
X-Received: by 2002:a17:90b:3dcd:b0:35f:b953:244c with SMTP id 98e67ed59e1d1-3614022c91bmr12112236a91.0.1776676191433;
        Mon, 20 Apr 2026 02:09:51 -0700 (PDT)
X-Received: by 2002:a17:90b:3dcd:b0:35f:b953:244c with SMTP id 98e67ed59e1d1-3614022c91bmr12112202a91.0.1776676190877;
        Mon, 20 Apr 2026 02:09:50 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:50 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 08/13] wifi: cfg80211: add role-based peer limits to FTM capabilities
Date: Mon, 20 Apr 2026 14:38:51 +0530
Message-Id: <20260420090856.2152905-9-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-GUID: dSKSV0ees2_UIoWqg2QA-LCqtH7wsqrd
X-Authority-Analysis: v=2.4 cv=KdDidwYD c=1 sm=1 tr=0 ts=69e5ed60 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=6VYxBCXtY2oc1u8p7HUA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: dSKSV0ees2_UIoWqg2QA-LCqtH7wsqrd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfXw71tK34/wkqB
 GFRLtAoqTOB6TaOCsZMvPO5mRWxUbEH5L7W3bJ7bkMROcZKvJyCE8z1vC0hXicXFTbjLNAnxh3p
 rrf/2aTtpFNXC0r3GwZuvs0GyZG2XnFdsg4yjQ4wd0i6iWDoQIJtHPCocQ20v676TDZ+Pej4sZI
 qTur1zIQ2yyYCbb5k213hLEcuQNNHatROsT5I4VAaAq5d2IgI9r5HXTf6DmddsKbvmiXd6o1Mmn
 nhxBMF4VKOs24D5ctCtidRzIe+ndmERQnCKd7IqWKYZcPQIjHSL11fxTBWmYY1snSuC1wQTsgg5
 xYtfkz92Zo+GuHCskgUwwa/nxWLjiSdqDu/nfCMKqV9IZ/3s1KrjRdtCI+cAEvEMIt0bPufn9qE
 gvSmweyoJXy37GLLoNNKeM2hLwc6TKTcPaGaDfvbF9XFcE5nCjKQ68l2eF0RInLa8cTjYvhJNjp
 UJyXbzDwobvKPbN5eig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200087
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35031-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4176E428B15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Peer measurement capabilities currently advertise a single maximum
peer count regardless of device role. Some devices support different
peer limits when operating as initiator versus responder.

Add max_peers fields inside the ftm.ista and ftm.rsta sub-structs of
cfg80211_pmsr_capabilities to allow drivers to advertise per-role peer
limits. These limits are generic and not restricted to any specific
ranging type.

Expose these over nl80211 using new NL80211_PMSR_ATTR_MAX_PEER_ISTA_ROLE
and NL80211_PMSR_ATTR_MAX_PEER_RSTA_ROLE attributes inside the
ISTA_CAPS and RSTA_CAPS nested attributes respectively.

When a role limit is advertised, validate the number of peers in the
request separately for each role using the existing rsta flag in the
FTM request, and reject the request if the limit is exceeded.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  6 +++++
 include/uapi/linux/nl80211.h | 14 +++++++++++
 net/wireless/nl80211.c       |  8 +++++++
 net/wireless/pmsr.c          | 46 ++++++++++++++++++++++++++++++++----
 4 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4f1f66a137ae..8c82f33bfc40 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6000,6 +6000,8 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	TB ranging.
  * @ftm.ista.support_edca: supports operating as ISTA in PMSR FTM request for
  *	EDCA based ranging.
+ * @ftm.ista.max_peers: maximum number of peers supported in the ISTA role.
+ *	If zero, no role-specific peer limit applies.
  * @ftm.rsta: responder role capabilities
  * @ftm.rsta.support_ntb: supports operating as RSTA in PMSR FTM request for
  *	NTB ranging.
@@ -6007,6 +6009,8 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	TB ranging.
  * @ftm.rsta.support_edca: supports operating as RSTA in PMSR FTM request for
  *	EDCA based ranging.
+ * @ftm.rsta.max_peers: maximum number of peers supported in the RSTA role.
+ *	If zero, no role-specific peer limit applies.
  * @ftm.max_no_of_tx_antennas: maximum number of transmit antennas supported for
  *	EDCA based ranging (0 means unknown)
  * @ftm.max_no_of_rx_antennas: maximum number of receive antennas supported for
@@ -6061,11 +6065,13 @@ struct cfg80211_pmsr_capabilities {
 			u8 support_ntb:1,
 			   support_tb:1,
 			   support_edca:1;
+			u32 max_peers;
 		} ista;
 		struct {
 			u8 support_ntb:1,
 			   support_tb:1,
 			   support_edca:1;
+			u32 max_peers;
 		} rsta;
 		u8 max_no_of_tx_antennas;
 		u8 max_no_of_rx_antennas;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index cb55e8b69097..a42bae666d02 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8054,6 +8054,18 @@ enum nl80211_peer_measurement_peer_attrs {
  *	meaningless, just a list of peers to measure with, with the
  *	sub-attributes taken from
  *	&enum nl80211_peer_measurement_peer_attrs.
+ * @NL80211_PMSR_ATTR_MAX_PEER_ISTA_ROLE: u32 attribute indicating the
+ *	maximum number of peers supported when the device operates in the
+ *	ISTA (Initiator STA) role. If absent, no role-specific peer limit
+ *	applies. The sum of %NL80211_PMSR_ATTR_MAX_PEER_ISTA_ROLE and
+ *	%NL80211_PMSR_ATTR_MAX_PEER_RSTA_ROLE is enforced when the device
+ *	supports concurrent ISTA/RSTA operation.
+ * @NL80211_PMSR_ATTR_MAX_PEER_RSTA_ROLE: u32 attribute indicating the
+ *	maximum number of peers supported when the device operates in the
+ *	RSTA (Responder STA) role. If absent, no role-specific peer limit
+ *	applies. The sum of %NL80211_PMSR_ATTR_MAX_PEER_ISTA_ROLE and
+ *	%NL80211_PMSR_ATTR_MAX_PEER_RSTA_ROLE is enforced when the device
+ *	supports concurrent ISTA/RSTA operation.
  *
  * @NUM_NL80211_PMSR_ATTR: internal
  * @NL80211_PMSR_ATTR_MAX: highest attribute number
@@ -8066,6 +8078,8 @@ enum nl80211_peer_measurement_attrs {
 	NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR,
 	NL80211_PMSR_ATTR_TYPE_CAPA,
 	NL80211_PMSR_ATTR_PEERS,
+	NL80211_PMSR_ATTR_MAX_PEER_ISTA_ROLE,
+	NL80211_PMSR_ATTR_MAX_PEER_RSTA_ROLE,
 
 	/* keep last */
 	NUM_NL80211_PMSR_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3fb540c6adcf..4f6612311de3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2531,6 +2531,10 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 		if (cap->ftm.ista.support_edca &&
 		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA))
 			return -ENOBUFS;
+		if (cap->ftm.ista.max_peers &&
+		    nla_put_u32(msg, NL80211_PMSR_ATTR_MAX_PEER_ISTA_ROLE,
+				cap->ftm.ista.max_peers))
+			return -ENOBUFS;
 		nla_nest_end(msg, ista_caps);
 	}
 
@@ -2559,6 +2563,10 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 		if (cap->ftm.rsta.support_edca &&
 		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA))
 			return -ENOBUFS;
+		if (cap->ftm.rsta.max_peers &&
+		    nla_put_u32(msg, NL80211_PMSR_ATTR_MAX_PEER_RSTA_ROLE,
+				cap->ftm.rsta.max_peers))
+			return -ENOBUFS;
 		nla_nest_end(msg, rsta_caps);
 	}
 
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index caffa2421c20..432d34be7945 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -361,12 +361,15 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *reqattr = info->attrs[NL80211_ATTR_PEER_MEASUREMENTS];
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	int count, rem, err, idx, peer_count;
 	struct wireless_dev *wdev = info->user_ptr[1];
+	const struct cfg80211_pmsr_capabilities *capa;
 	struct cfg80211_pmsr_request *req;
 	struct nlattr *peers, *peer;
-	int count, rem, err, idx;
 
-	if (!rdev->wiphy.pmsr_capa)
+	capa = rdev->wiphy.pmsr_capa;
+
+	if (!capa)
 		return -EOPNOTSUPP;
 
 	if (!reqattr)
@@ -381,7 +384,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 	nla_for_each_nested(peer, peers, rem) {
 		count++;
 
-		if (count > rdev->wiphy.pmsr_capa->max_peers) {
+		if (count > capa->max_peers) {
 			NL_SET_ERR_MSG_ATTR(info->extack, peer,
 					    "Too many peers used");
 			return -EINVAL;
@@ -397,7 +400,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 		req->timeout = nla_get_u32(info->attrs[NL80211_ATTR_TIMEOUT]);
 
 	if (info->attrs[NL80211_ATTR_MAC]) {
-		if (!rdev->wiphy.pmsr_capa->randomize_mac_addr) {
+		if (!capa->randomize_mac_addr) {
 			NL_SET_ERR_MSG_ATTR(info->extack,
 					    info->attrs[NL80211_ATTR_MAC],
 					    "device cannot randomize MAC address");
@@ -422,6 +425,41 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 			goto out_err;
 		idx++;
 	}
+
+	/* Validate per-role peer limits if advertised */
+	if (capa->ftm.ista.max_peers) {
+		peer_count = 0;
+
+		for (idx = 0; idx < req->n_peers; idx++) {
+			if (!req->peers[idx].ftm.rsta) {
+				peer_count++;
+
+				if (peer_count > capa->ftm.ista.max_peers) {
+					NL_SET_ERR_MSG(info->extack,
+						       "Too many ISTA peers for device limit");
+					err = -EINVAL;
+					goto out_err;
+				}
+			}
+		}
+	}
+
+	if (capa->ftm.rsta.max_peers) {
+		peer_count = 0;
+
+		for (idx = 0; idx < req->n_peers; idx++) {
+			if (req->peers[idx].ftm.rsta) {
+				peer_count++;
+
+				if (peer_count > capa->ftm.rsta.max_peers) {
+					NL_SET_ERR_MSG(info->extack,
+						       "Too many RSTA peers for device limit");
+					err = -EINVAL;
+					goto out_err;
+				}
+			}
+		}
+	}
 	req->cookie = cfg80211_assign_cookie(rdev);
 	req->nl_portid = info->snd_portid;
 
-- 
2.34.1


