Return-Path: <linux-wireless+bounces-32442-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA07HHrcp2lnkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32442-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A71FB798
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5017E308C5AE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAFC344DA8;
	Wed,  4 Mar 2026 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F8DoLrBK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWvOVAOy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0C30CDAF
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608588; cv=none; b=B1MKfnia9ANwIcKliLcJxQ3Tb3krvUQXJ2/U0xGFp9nLEt4TCyzCi4dGUsJ/xtw6Tds9Z/txwIS3vSv4/dTbsb1q6ArBqf8DL/G/5gWAR6p/MJ8UsuoQj5O2h0f4ZupYVHlluxKDN+eJu5BImvHWu/aHwSwtwVTSxKZVfBvPAyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608588; c=relaxed/simple;
	bh=HL2qAXlyEqVbHwfkDCEipnAuM5MXEab3vtexq0Mn8Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NLdPW68NZG7fApKkU/xMGTa8TUv80X8sx4hCFaGHyCss8RGpLMF1KqTvzdjOgbiTUyAsqwrWDJwMgHxj1qs3oDllG6XCLEcp/UIGHy0DRI4PLRXZDBVDGFrvlRZ8jBlcNa8aHAieznLhdYqN7WV4CGPpW4zpqyFEy5hfZFrfsxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F8DoLrBK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWvOVAOy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245Sx8F2306688
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EyRfLI2ckij
	dDXm9UfJpuZaBCDcMiUx47CBw8wxBERo=; b=F8DoLrBKldfGahLn6hnB26iRVWJ
	SkeU24OUpumEd6S7fFRtqeXtMgnrB2f2M+8nurrKToFQIjQmJgX8OVXAvAD8wgeK
	ciNFtF2NkbyPeN1crhUVU9DvH0U82980s/2CElNG33+sLPGGnKZax1TI/PXSdh+p
	XkWAa54vJI+RbbR0ZDB8oaJ+HArk7BtmN8D+vfkhTUl2bt1ZFZ92fp+JhdDLq1R5
	mzO7kt7HIoilk2yjCISKhj8xCoajmxA+wyYxBu6XLVrpwlvnMSY8De2IFPu03l7+
	owMRt1stAfvfZWS9dWfxIwvHvgNPBNX7pbDfbkz9GCA2Enr6bbOQMAL7eyg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpau8s241-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:24 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c70eb09daefso3681236a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608584; x=1773213384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyRfLI2ckijdDXm9UfJpuZaBCDcMiUx47CBw8wxBERo=;
        b=fWvOVAOyU4zs1tPf0dM7EKwyl4h650F+m0YROIK3O9mYe6RUbwSxVjls0fGnL8XKci
         df2foQBgHuDBOFAYXUTBG5mrS3bLwInVLBJN9fFojOPuuit5/el8TxMKwQnZoA5nsYh6
         iXL5UUnL3EiHzBHDtWqXyQKdsGjf7iYq2MEo7NAPAJqlbbGibTsSYWlQaHHuQyp6FuwK
         s3cNg4eQeIkmuhlGejMtm/Uxvo/hE1cnvS0KSgkpEI2JKm0MXlraWVwqb54F9xV/e01t
         VEdN6L/SonZZNGBkdJ6jdH1j5pXqPVi7yD7n2ZSd8TBCdS/mTZVbZC67mMrQg9TmngJL
         HvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608584; x=1773213384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EyRfLI2ckijdDXm9UfJpuZaBCDcMiUx47CBw8wxBERo=;
        b=bGTkR7abZQd8ed/Mq/XwdwiOkQHYTsz3jryDdx+VUPLPlaHfXHqw6h2QtwZmS3Mo+F
         CmEBwTC0BNki6dOILlQFIn/EixpVg+v57nIHI5iqgv1nr2GfETJoxUdRlmTNNuNM9i4r
         V/efgBWXHTujKBIfwGPHbQkpQ37/+WSadAO2kUlyHk8DuLe4nNgCQUJkOBQUIuKkzJQc
         TdEIoj5KwSihG9U3kCxU0/ZB6gy8ZHfGLLcI14Bh+yzmLltpH7jPjsn2rbGEafYrQDmG
         1OAcgJraI1ndKxmVH+Jub6f/UG1iyjdMhrdY/hQztEhnKiyQv7p/ErJAYcAarmi2oG6c
         A5TQ==
X-Gm-Message-State: AOJu0Yz9KRxOOeoIZHPlJklKXESSiw9TdX2SnVYJSIiszFF40xk59pCk
	wEndMlBQqxprYPzPBJwJoP/NAva96CuFYS/DCbNCxM8rU58nTWtTdFZvg/ExdmXWSCOoxOReLwK
	tCJbWaBmsKAuqrOw+t4rZH4jX9X9oR3kZNd84cIuAjmwJjdZasIp/u7sw2kQWzitI2wFLEI9mUn
	Tc
X-Gm-Gg: ATEYQzyslzhFgTiZuGbuPFsQa+KE7QvFg3sj9vwXhAAQAqnbjh2IJe6q+d8pMB03VGT
	AuO5L/XiZioKsm4jGvvx45kJq21Dh8Udjn3buUY1M0aGxNnaiysQRyjaVFJlHnZ/PdkJCTikMVy
	Jm8FB9qnCRuN0cqnTGSf0Nqb+ziABB/O4svawPep4AURU/Kydbo7OQ3w+3ylGq6X6Oi3P5Equxf
	dKUkqwlxQ9TYGb415DA+t+MlT+HU2PoauFzXjXYjXE1o+NUeTOqdBolvS4yOMzumuo/UaT0s8tv
	oHaaLHlsJiDu8zdUZtZuFj/Ex96cNJDukKKX0ab3A2GnnkQ3sCX7Z5QjsT87QkjrLDhRrjMnaBK
	reKgJBw4prQuO9l7Pb8t+yiCLLrK+byqmWI5L2OwncF3rF2vNH2TwhbU=
X-Received: by 2002:a05:6a21:4781:b0:394:549d:ecf5 with SMTP id adf61e73a8af0-3982e21e57amr1145079637.60.1772608584237;
        Tue, 03 Mar 2026 23:16:24 -0800 (PST)
X-Received: by 2002:a05:6a21:4781:b0:394:549d:ecf5 with SMTP id adf61e73a8af0-3982e21e57amr1145046637.60.1772608583604;
        Tue, 03 Mar 2026 23:16:23 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:23 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 06/16] wifi: cfg80211: add proximity detection capabilities to PMSR
Date: Wed,  4 Mar 2026 12:45:28 +0530
Message-Id: <20260304071538.3833062-7-peddolla.reddy@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=AJS1/0o2 c=1 sm=1 tr=0 ts=69a7dc48 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=nclPvYkPYs_wI36UdL8A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: yb0upybNbp6DwHTJnKsKO4spfzCfosVS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX4N0lQR7gZLnj
 DWSLFS+bGwqiuZljEdmYvp6aTnCf1RdAvejSybm16NJaZthSSDL5n+HfmFBbSYqqLegn1MVlTVv
 zwl+7Ksul8ZI0wZeXAGl0E1Jv6KtdvayUOOxpgRWbQuv/18P+C3ksr+1H1SOAaQ3fz1LqrxGjyS
 64vRCrAJZqG0QoDtKcDndG4O26mHV3LJJuy+8j22RWc21nA84QvWc1avWoc7+gfm6B9kLgtk1/t
 cC8KZOfiuBt+Wao80cbtQieDXv/blpoHOzC0iobDsJOcfV+j9X/v5hCfr7Y9wlHSJWDX4fwkSOz
 aJ5BL5IrloXwQdKghJ/V9ewIRiTWiiUs4PdLHsqbxW00UGN748kI22a/AlMl3wBsY8O2WVXEX0C
 um/nHNgOAziMHkozhCSbAEh7mDsG53DoExs7WKgpWfKVFHwD7dtexcx6mKPbDcGzV/gi+6AcOPB
 xAQWuszxSqlTJB6I4BA==
X-Proofpoint-GUID: yb0upybNbp6DwHTJnKsKO4spfzCfosVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040058
X-Rspamd-Queue-Id: 291A71FB798
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
	TAGGED_FROM(0.00)[bounces-32442-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Introduce Proximity Detection (PD) capabilities in Peer Measurement
Service (PMSR) as defined in the Wi-Fi Alliance specification
"Proximity Ranging (PR) Implementation Consideration Draft 1.9 Rev 1
section 3.3". This enables devices to advertise PD support and
concurrent ISTA/RSTA operation for simultaneous initiator and
responder roles.

Extend FTM capabilities to support PASN negotiation and device timing
constraints. Add antenna configuration for PR Element during PASN
negotiation as per the specification. Add ranging interval limits to
advertise device timing capabilities for EDCA and NTB-based ranging.
Add EDCA-based responder support to indicate if the device can operate
as FTM responder for EDCA-based ranging. These capabilities allow
proper negotiation and validation of PD sessions between peers.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 28 ++++++++++++++++++++++++++--
 include/uapi/linux/nl80211.h | 29 +++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 32 ++++++++++++++++++++++++++++++++
 net/wireless/pmsr.c          |  3 ++-
 4 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 099a2ff9af58..62a2139b2f37 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5692,6 +5692,13 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
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
@@ -5718,12 +5725,24 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
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
@@ -5744,7 +5763,12 @@ struct cfg80211_pmsr_capabilities {
 		u8 max_rx_sts;
 		u8 max_total_ltf_tx;
 		u8 max_total_ltf_rx;
-		u8 support_rsta:1;
+		u32 max_no_of_tx_antennas;
+		u32 max_no_of_rx_antennas;
+		u32 min_allowed_ranging_interval_edca;
+		u32 min_allowed_ranging_interval_ntb;
+		u8 support_rsta:1,
+		   support_edca_responder:1;
 	} ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 55a882535e2b..59e8ba9c37c4 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7829,6 +7829,15 @@ enum nl80211_peer_measurement_peer_attrs {
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
@@ -7841,6 +7850,8 @@ enum nl80211_peer_measurement_attrs {
 	NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR,
 	NL80211_PMSR_ATTR_TYPE_CAPA,
 	NL80211_PMSR_ATTR_PEERS,
+	NL80211_PMSR_ATTR_PD_SUPPORT,
+	NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT,
 
 	/* keep last */
 	NUM_NL80211_PMSR_ATTR,
@@ -7899,6 +7910,19 @@ enum nl80211_peer_measurement_attrs {
  *	This limits the allowed combinations of LTF repetitions and STS.
  * @NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT: flag attribute indicating the
  *	device supports operating as the RSTA in PMSR FTM request
+ * @NL80211_PMSR_FTM_CAPA_ATTR_EDCA_BASED_RESPONDER: flag attribute indicating
+ *	the device supports operating as the Responder in PMSR FTM request for
+ *	EDCA-based ranging.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS: u32 attribute indicating
+ *	the maximum number of transmit antennas supported for ranging
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS: u32 attribute indicating
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
@@ -7924,6 +7948,11 @@ enum nl80211_peer_measurement_ftm_capa {
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
index 0ae96063c032..77447f63d112 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -404,6 +404,10 @@ nl80211_pmsr_attr_policy[NL80211_PMSR_ATTR_MAX + 1] = {
 	[NL80211_PMSR_ATTR_TYPE_CAPA] = { .type = NLA_REJECT },
 	[NL80211_PMSR_ATTR_PEERS] =
 		NLA_POLICY_NESTED_ARRAY(nl80211_pmsr_peer_attr_policy),
+	[NL80211_PMSR_ATTR_PD_SUPPORT] = { .type = NLA_REJECT },
+	[NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT] = {
+		.type = NLA_REJECT
+	},
 };
 
 static const struct nla_policy
@@ -2375,6 +2379,25 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	if (cap->ftm.support_rsta &&
 	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT))
 		return -ENOBUFS;
+	if (cap->ftm.support_edca_responder &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_EDCA_BASED_RESPONDER))
+		return -ENOBUFS;
+	if (cap->ftm.max_no_of_tx_antennas &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS,
+			cap->ftm.max_no_of_tx_antennas))
+		return -ENOBUFS;
+	if (cap->ftm.max_no_of_rx_antennas &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS,
+			cap->ftm.max_no_of_rx_antennas))
+		return -ENOBUFS;
+	if (cap->ftm.min_allowed_ranging_interval_edca &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA,
+			cap->ftm.min_allowed_ranging_interval_edca))
+		return -ENOBUFS;
+	if (cap->ftm.min_allowed_ranging_interval_ntb &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
+			cap->ftm.min_allowed_ranging_interval_ntb))
+		return -ENOBUFS;
 
 	nla_nest_end(msg, ftm);
 	return 0;
@@ -2409,6 +2432,15 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
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
index c2977a37add2..17f0b1c97d58 100644
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


