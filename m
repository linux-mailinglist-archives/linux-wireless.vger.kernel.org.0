Return-Path: <linux-wireless+bounces-33603-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MICyJBiMvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33603-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:04:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9442DF1EA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E64B3303EBAC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6458B3DD534;
	Fri, 20 Mar 2026 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kEU/cmjx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="klxcxMZB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BC331209
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029654; cv=none; b=rgUGIMXp6UOKpn1UVdhHHnO7E7R7Il4gWGfZ7+TiWUcf70YMsBPlrszQc5bldqkFgWPAuDUsd7qNJpgbqCpAooxLUEiPkxBJXKWUDxpNFe7O6wDbzKENIKziKM85O+0y5mKBk4PjNjgKv4JcSFROQRQms08VEPzcEyNs1mPBhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029654; c=relaxed/simple;
	bh=eHh6pTptSqB+Zh7VEQoWZz53s3EKEz2xGxrq4P6GPF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ky6VLIPqGXX+RvCbSS4D9Y5i1SjvqoWRoWDDQrD+m/G4WTicyQvss2COHJFFOAbmaFy+mxNWlbii0OPK+qKF4O7d+sJL8D5L3h7dp+wOxx2k0AS065Slkg8XrjqCWX3QOYJKiDbS1hgZ54I0TWuhZFbo0zkLjLijzUEynQs9nMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kEU/cmjx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=klxcxMZB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KEeEkE1692180
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=27v1dxF//bc
	/3Ix9d2a2wBt57AiDU1DNM55rRoIx3Vo=; b=kEU/cmjxgOttely0zQ1nyh8lLd2
	TjOVF44dlqiSXzHCOYnOdbrOrEOEnjgIEFFUchfoAmZAV/4rmNudSlo3x0IqYMHF
	cP5Rj1YSpsVhesLo4z9FlA8AS0KaTUTxqMLrdiuq48bCaZy1m5YfwjseRQGGHwVM
	mSo3Hh1ySPS1D6chqO7AiXD1uGYJdjvPemTlF21WeBTs59FDLx9Ssy5COY96QaOg
	mzxMA9wF1O93NXRF6cnbci/udiI0YDJEQPB8RN+f96fUDVBi4dOjDRE3okHs45yi
	HxjEX7GW3qSieZKiMZuibz9kXtyGCkRB3VjGoJn42f9ym8Ob03gkkXsSIkA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0s5d2tuy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aed1beaa73so23690475ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029648; x=1774634448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27v1dxF//bc/3Ix9d2a2wBt57AiDU1DNM55rRoIx3Vo=;
        b=klxcxMZB2PU5puFjok8U+oUCXs8if9Jks/j+m/BlaBc2oyr+8/RZk7e7OXxtTKD768
         nOWPQNGBzk708OR163jBqMgW7MKw0d1SDBNGgRouLnUmPGGAcwappEsyjWVzqorcrR6R
         H+x7dFWPruMCFZT4cvKpk4SeXE//60l1qaBEf92eQOQdATZWvjsKr7iylILQ6S+fFPHW
         i90QcKBKVOyKdR4YiDEge6qQCczMe/LYoDIKYDl/M//8OPEpj6iKEmzTJEzsybNWlrod
         jmJ0nYbpw/nhL7j3vDsJE/rjNNO9DxABo1vHWRPSnhjdZZxKjtbWqZ5mu7cAHlKBbVyh
         MMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029648; x=1774634448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=27v1dxF//bc/3Ix9d2a2wBt57AiDU1DNM55rRoIx3Vo=;
        b=HseljPT0J0GjZNywWtav7399/GChVCDFhM6VCXtQMa9rxidT22PLxGtIC7jY4P1ca4
         66SfAdrXOhqr7aBVK74nuATKAOOgAZfE8bDAGm916gU1JPTGwf9rcg/HCjIF+x2tJzPo
         M+wEpBb0Bbm5xwYiIYImKMK5nKDIBzmuync2g/GAiCbXmc+qclB4M3rsOjYJ5Kl2xcRA
         wE5Oq56yReHpQvoyGizU9saOS38Bz8ftmT9cQKIEBCly8iyHB6WhPMkoH1ZQnV+vD0Al
         4TEv7U0zZRBQgVEzULSyNe54ufzLnk5WMyCzPkyHnHcvrQRZzLfz4UKJtKNZNNip5bgc
         rlTw==
X-Gm-Message-State: AOJu0YxV3Xs69w+RdQvUYcSH2y+R/q3QhaBQ0ice0ZWLyr7zlosG54xk
	PgytBeg6BaYFBBJDxXYq/zSuLv0OQlYJswS0nlhsqU+JebpctpeRZDGa2JYXvPCWpGSo9QH6DYh
	qEbK/1lm9CV7ovxsMFFkD34NKscFohRKqHZqIumhrjDgVSc7rqINjcpEz+12eu0Tg3+5d
X-Gm-Gg: ATEYQzxvFVolOcvRtTXa11idMaMFQK3Y5pyl0V8yfZzNuGVrysFajrrOTdqcesVZymU
	1lh3V9hVUzKMoFzuszN4AaqbTpHgelZh+VAMaAvRs2Q+fITr8W02mZRtHmJvH0z54w3eW9Be6RG
	iLaYrDxgfkhmE6e0a9Duxdt46S+sXVdmdr3bOqWwiX3kQu9oKv+6NTdZR2njFRZ6uW47dApFiZG
	kLaxgYwRok0SuX5vdlpLqJRJrxKq8FrjTRgy9YgTAwwLcWtZfdLxsshKIFmUTmCs/VIQpCUQrcf
	3h+KSPew9WmYgRqsBp8mSN45Qgzlf2fJ4SoIZ7g6JQtE2DYmrTUJuJ2eH7P3Savb8kRscdhaWBy
	LyAebK11VFjj/rHGB9iqwd9rLYdKTw7gkVCf9DPp5iqxHHkyCyyqJHhE=
X-Received: by 2002:a17:902:f651:b0:2b0:4d7d:fbc8 with SMTP id d9443c01a7336-2b0825e0b04mr34858905ad.0.1774029648106;
        Fri, 20 Mar 2026 11:00:48 -0700 (PDT)
X-Received: by 2002:a17:902:f651:b0:2b0:4d7d:fbc8 with SMTP id d9443c01a7336-2b0825e0b04mr34856245ad.0.1774029642727;
        Fri, 20 Mar 2026 11:00:42 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:42 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 06/14] wifi: cfg80211: add proximity detection capabilities to PMSR
Date: Fri, 20 Mar 2026 23:29:30 +0530
Message-Id: <20260320175938.2547288-7-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
References: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eQX1MW6WkzLZgb0rVLYMwLopehgQCLSk
X-Proofpoint-GUID: eQX1MW6WkzLZgb0rVLYMwLopehgQCLSk
X-Authority-Analysis: v=2.4 cv=CqCys34D c=1 sm=1 tr=0 ts=69bd8b51 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=k_tH67ytrenphrTz7ncA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfX3+kT6MwNESOS
 HUnHySFLsaPHQ/vF8J/G+d8GE6lXs/gHgpavxqF3oHmgq8uA3wwDUMCtJfK/X68CNjHFup11xWO
 5GWtxEOrvTqKqxMnPbGZ+i7s2JbKKm+f92y3aPJhj3zzTOoqPsccZvS3Ck9VnnS68dNKHW86C35
 YgjvEFuf6A/LmQAg/y1nBSdNlumk44G0m1jiM3BQpON31SAAUpGN13yl+1Bv56oyQidrX7eUYvp
 6LD6m/aCPcl5Qsul5ya34B39Ewjn+GznHmJxwzPPiwFIVvToCsrW8BxRc6ITOGpQpygNZgZFdwN
 LBjMsEM8WFsbUiZBNH5XvRpKeXSsSeucFmIb0SZUqS7W45oifFkxtm7HVU9p10+ljZjsNBeJhgA
 Khsk+mYq+6GPOgT7+WDP9Cm3LYia1T4jdFeVlt9GKGxR7tEpIt0tvzOs8Us1nmdrsi3CrI8XUD4
 WSRPsxB5PTljTbdM9Yw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200146
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
	TAGGED_FROM(0.00)[bounces-33603-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0D9442DF1EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce Proximity Detection (PD) capabilities in Peer Measurement
Service (PMSR) as defined in the Wi-Fi Alliance specification
"Proximity Ranging (PR) Implementation Consideration Draft 1.9 Rev 1
section 3.3". This enables devices to advertise PD support and
concurrent ISTA/RSTA operation for simultaneous initiator and
responder roles.

Extend FTM capabilities to support PASN negotiation and device timing
constraints. Add antenna configuration for the PR Element during PASN
negotiation as per the specification. Add ranging interval limits to
advertise device timing capabilities for EDCA and NTB-based ranging.

The existing support_rsta flag provides only a generic indication of
RSTA capability without distinguishing between different ranging
protocols, and there is no equivalent capability advertisement for the
ISTA role.

Restructure the FTM capabilities to use nested ista and rsta
sub-structs, each carrying per-mode flags for Non-Trigger Based,
Trigger Based, and EDCA based ranging.

Expose these capabilities over nl80211 using new nested ISTA_CAPS and
RSTA_CAPS attributes. The legacy RSTA_SUPPORT flag is retained for
backward compatibility and is set whenever any per-mode RSTA capability
is supported.

Update the FTM request validation path to check RSTA requests against
the per-mode capabilities, rejecting requests for modes the device does
not support.

Co-developed-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 47 ++++++++++++++++++++++-
 include/uapi/linux/nl80211.h | 48 +++++++++++++++++++++++
 net/wireless/nl80211.c       | 74 ++++++++++++++++++++++++++++++++++--
 net/wireless/pmsr.c          | 22 ++++++++++-
 4 files changed, 184 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7bc4fff024d6..986775cd4502 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5717,7 +5717,35 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	(0 means unknown)
  * @ftm.max_total_ltf_rx: maximum total number of LTFs that can be received
  *	(0 means unknown)
- * @ftm.support_rsta: supports operating as RSTA in PMSR FTM request
+ * @ftm.ista: initiator role capabilities
+ * @ftm.ista.support_ntb: supports operating as ISTA in PMSR FTM request for
+ *	NTB ranging.
+ * @ftm.ista.support_tb: supports operating as ISTA in PMSR FTM request for
+ *	TB ranging.
+ * @ftm.ista.support_edca: supports operating as ISTA in PMSR FTM request for
+ *	EDCA based ranging.
+ * @ftm.rsta: responder role capabilities
+ * @ftm.rsta.support_ntb: supports operating as RSTA in PMSR FTM request for
+ *	NTB ranging.
+ * @ftm.rsta.support_tb: supports operating as RSTA in PMSR FTM request for
+ *	TB ranging.
+ * @ftm.rsta.support_edca: supports operating as RSTA in PMSR FTM request for
+ *	EDCA based ranging.
+ * @ftm.max_no_of_tx_antennas: maximum number of transmit antennas supported for
+ *	EDCA based ranging
+ * @ftm.max_no_of_rx_antennas: maximum number of receive antennas supported for
+ *	EDCA based ranging
+ * @ftm.min_allowed_ranging_interval_edca: Minimum EDCA ranging
+ *	interval supported by the device in milli seconds. (0 means unknown)
+ * @ftm.min_allowed_ranging_interval_ntb: Minimum NTB ranging
+ *	interval supported by the device in milli seconds. (0 means unknown)
+ * @ftm.pd_support: supports peer-to-peer ranging as mentioned in the
+ *	specification "PR Implementation Consideration Draft 1.9 rev 1" where
+ *	PD stands for proximity detection
+ * @ftm.pd_concurrent_ista_rsta_support: As the peer measurement request can be
+ *	a multi-peer request this will indicate if the device can act
+ *	simultaneously as initiator and a responder. Only valid if
+ *	@ftm.rsta_support is set.
  */
 struct cfg80211_pmsr_capabilities {
 	unsigned int max_peers;
@@ -5743,7 +5771,22 @@ struct cfg80211_pmsr_capabilities {
 		u8 max_rx_sts;
 		u8 max_total_ltf_tx;
 		u8 max_total_ltf_rx;
-		u8 support_rsta:1;
+		struct {
+			u8 support_ntb:1,
+			   support_tb:1,
+			   support_edca:1;
+		} ista;
+		struct {
+			u8 support_ntb:1,
+			   support_tb:1,
+			   support_edca:1;
+		} rsta;
+		u8 max_no_of_tx_antennas;
+		u8 max_no_of_rx_antennas;
+		u32 min_allowed_ranging_interval_edca;
+		u32 min_allowed_ranging_interval_ntb;
+		u8 pd_support:1,
+		   pd_concurrent_ista_rsta_support:1;
 	} ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4fd2d3fb84ec..a1a5bc21ab6f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7905,6 +7905,42 @@ enum nl80211_peer_measurement_attrs {
  *	This limits the allowed combinations of LTF repetitions and STS.
  * @NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT: flag attribute indicating the
  *	device supports operating as the RSTA in PMSR FTM request
+ * @NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS: nested attribute containing ISTA
+ *	(initiator) role capabilities. Uses the same sub-attributes as
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS: nested attribute containing RSTA
+ *	(responder) role capabilities.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB: flag attribute (used inside
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS or
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS) indicating NTB ranging support.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB: flag attribute (used inside
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS or
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS) indicating TB ranging support.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA: flag attribute (used inside
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS or
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS) indicating EDCA based ranging
+ *	support.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_SUPPORT: flag attribute indicating that the
+ *	device supports peer-to-peer ranging as mentioned in the specification
+ *	"PR Implementation Consideration Draft 1.9 rev 1" where PD stands for
+ *	proximity detection
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT: flag attribute
+ *	indicating that as the peer measurement request can be a multi-peer
+ *	request, the device can act simultaneously as initiator and a responder,
+ *	where the multiple requests are being processed simultaneously. Only
+ *	valid if @NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT is set.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_6GHZ_RSTA_SUPPORT: flag attribute indicating
+ *	the device supports operating as RSTA in the 6 GHz band
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS: u32 attribute indicating
+ *	the maximum number of transmit antennas supported for EDCA based ranging
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS: u32 attribute indicating
+ *	the maximum number of receive antennas supported for EDCA based ranging
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA: u32 attribute indicating
+ *	the minimum EDCA ranging interval supported by the device
+ *	in milli seconds. (0 means unknown)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB: u32 attribute indicating
+ *	the minimum NTB ranging interval supported by the device
+ *	in milli seconds. (0 means unknown)
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -7930,6 +7966,18 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_TX,
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_RX,
 	NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT,
+	NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS,
+	NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS,
+	NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB,
+	NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB,
+	NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_SUPPORT,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT,
+	NL80211_PMSR_FTM_CAPA_ATTR_6GHZ_RSTA_SUPPORT,
+	NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS,
+	NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS,
+	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA,
+	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 90953194d0e3..8e06ff02c5cc 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2387,10 +2387,78 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_RX,
 			cap->ftm.max_total_ltf_rx))
 		return -ENOBUFS;
-	if (cap->ftm.support_rsta &&
-	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT))
-		return -ENOBUFS;
 
+	if (cap->ftm.ista.support_ntb || cap->ftm.ista.support_tb ||
+	    cap->ftm.ista.support_edca) {
+		struct nlattr *ista_caps;
+
+		ista_caps = nla_nest_start_noflag(msg,
+						  NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS);
+		if (!ista_caps)
+			return -ENOBUFS;
+		if (cap->ftm.ista.support_ntb &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB))
+			return -ENOBUFS;
+		if (cap->ftm.ista.support_tb &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB))
+			return -ENOBUFS;
+		if (cap->ftm.ista.support_edca &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA))
+			return -ENOBUFS;
+		nla_nest_end(msg, ista_caps);
+	}
+
+	if (cap->ftm.rsta.support_ntb || cap->ftm.rsta.support_tb ||
+	    cap->ftm.rsta.support_edca) {
+		struct nlattr *rsta_caps;
+
+		/*
+		 * Set the generic RSTA_SUPPORT flag if any of the specific
+		 * ranging modes is supported to maintain the backward
+		 * compatibility.
+		 */
+		if (nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT))
+			return -ENOBUFS;
+
+		rsta_caps = nla_nest_start_noflag(msg,
+						  NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS);
+		if (!rsta_caps)
+			return -ENOBUFS;
+		if (cap->ftm.rsta.support_ntb &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB))
+			return -ENOBUFS;
+		if (cap->ftm.rsta.support_tb &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB))
+			return -ENOBUFS;
+		if (cap->ftm.rsta.support_edca &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA))
+			return -ENOBUFS;
+		nla_nest_end(msg, rsta_caps);
+	}
+
+	if (cap->ftm.max_no_of_tx_antennas &&
+	    nla_put_u8(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS,
+		       cap->ftm.max_no_of_tx_antennas))
+		return -ENOBUFS;
+	if (cap->ftm.max_no_of_rx_antennas &&
+	    nla_put_u8(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS,
+		       cap->ftm.max_no_of_rx_antennas))
+		return -ENOBUFS;
+	if (cap->ftm.min_allowed_ranging_interval_edca &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA,
+			cap->ftm.min_allowed_ranging_interval_edca))
+		return -ENOBUFS;
+	if (cap->ftm.min_allowed_ranging_interval_ntb &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
+			cap->ftm.min_allowed_ranging_interval_ntb))
+		return -ENOBUFS;
+	if (cap->ftm.pd_support) {
+		if (nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_SUPPORT))
+			return -ENOBUFS;
+		if (cap->ftm.pd_concurrent_ista_rsta_support &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT))
+			return -ENOBUFS;
+	}
 	nla_nest_end(msg, ftm);
 	return 0;
 }
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index afc0e3f931ec..c21f693fac29 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -188,10 +188,28 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	}
 
 	out->ftm.rsta = !!tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA];
-	if (out->ftm.rsta && !capa->ftm.support_rsta) {
+	if (out->ftm.rsta && out->ftm.non_trigger_based &&
+	    !capa->ftm.rsta.support_ntb) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
-				    "FTM: RSTA not supported by device");
+				    "FTM: NTB RSTA not supported by device");
+		return -EOPNOTSUPP;
+	}
+
+	if (out->ftm.rsta && out->ftm.trigger_based &&
+	    !capa->ftm.rsta.support_tb) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
+				    "FTM: TB RSTA not supported by device");
+		return -EOPNOTSUPP;
+	}
+
+	if (out->ftm.rsta && !out->ftm.non_trigger_based &&
+	    !out->ftm.trigger_based &&
+	    !capa->ftm.rsta.support_edca) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
+				    "FTM: EDCA RSTA not supported by device");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.34.1


