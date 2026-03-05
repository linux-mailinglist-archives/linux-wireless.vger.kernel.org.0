Return-Path: <linux-wireless+bounces-32555-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGq7I3yqqWlSBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32555-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:08:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E47215233
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7010A30266E3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F112E3C3C1D;
	Thu,  5 Mar 2026 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XgQ1aauL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wx3wGR6V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA273CD8B4
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726886; cv=none; b=nbSUBs1/6i+flzz/OeFqfTYKu+xQ2558OY89vEJQdfNjLdEAKPVztWY0IMyj7FHTVPLcLk+AeYWHSzsAxa1/eMU8F+zt0vlSa8DVTtP2MqO0qAioutw2lKxK+gGbh4J9CeY+KcqPammBwREBUPpl/Rx8Zd8A79iqo9lys1Bg678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726886; c=relaxed/simple;
	bh=K0ZzQZ1d3ODWIoGXYDYAKSyKhHhi4qKEZ/mg2WiPGWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QemBQXjNPhf7NoewpXjeneQuskkTnruNA+zNm5ortNBThcXeAFfJ+oJwwQAlq+0jWI1RCLU4Y+lTKRdgCuzw9VS2y4NMQUnBvT/uKCragNAHk0EKpt6Hewjbl0CFNTaDRDJCXsatxRKugNkEmBL9HYaEIFQX6czOEq/jpjJMO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XgQ1aauL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wx3wGR6V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFjnY917159
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=38GMsG9hEpB
	6vl8DsuQQEKPp6p8TDuZ35ZHDMqHYitY=; b=XgQ1aauLHVDPi7GA/LQqA1iPiC+
	aP14kvWU8W5YqWNZCmqoBy8RuijU//AQOuLUQP9yTCtx4+8xaHQEEwx7qwO074L9
	IdPUs3OknCfYYJw3xVdR4Q8SgdluU/A1QOd5dMF6FxUHiERnBdlhGAnOpbJHa7vz
	cRMFifuody/n9i8FD3VX2wqY5xIlNPAUNUfech1sNjV60g1DEyK1H1kp1KD5U6O2
	8mn50ei7QuQtI2lsMzaO958FZsuIJnPFBf8emFvmkSOv57qWEVfwskj3i0XzMUYZ
	4R8xcCM/Z9x4NuuSY7ehsQey8EFGtMLD+5UC/Df//PPSHzFvAbkqTmoSaKg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq380t5hx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:08:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aad5fec175so297192205ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726881; x=1773331681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38GMsG9hEpB6vl8DsuQQEKPp6p8TDuZ35ZHDMqHYitY=;
        b=Wx3wGR6VDyG8fGL/FqNLSbkY5Yf6soJm75cpaE2WxF6huOD0ycTQl+Z1rW7g8CR5Iz
         Ek5ggpSGi6JBn6SHVByzpKYfDc39NsbyijCF2MWXtZPJujXo3hmlCKwRe5Zq6oZROYVh
         Qzx/2/XrGYGEZT9Z8ji2qZrPJf7U4umC+hct7H9gerQwIMWCCyKyouV3NL3Ump3z3IzI
         A2LRuzTXzJ9cfS/Syc+2x3t3EU41RlFEW6FePoBvyD0MLKOUQ40RKXENfYc1AnTwQD+t
         AT6VWypLj9wOpqyo+qaXXXWFGIapP/ZWXcuo1h1KKQhCpG/IAkNHb5PX5rgkZCBvZMgt
         bKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726881; x=1773331681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38GMsG9hEpB6vl8DsuQQEKPp6p8TDuZ35ZHDMqHYitY=;
        b=chPSdGbyp8fJWuLvulgC4tIXNxPtU8YmhOAr5/9/gZtXE3Bajddt1tc9D9QOr/tneL
         9IJF9Ngh2yImBKBDRxWzZSCrUGjSIgAmtMbGN+WZiZDNWhqOmAUJ6Ao/YEebX6ODxz6l
         pmc+ux+5ldNmZtTbnUwQJ+55RQChyzlX6Hfal38wcz5leRLk1pxgXQGEoe47tBmQ0zqV
         HlPRqLzQNEWXWKygPwg1ko6dkZKH33CG9BdkaQq6yGKHw6rAltJNyARQ2dKy77pf09xe
         +2ZG7CzfvuJVgx9hLKTQ+wEd2cQLgYJU5nA475S82Q9K9aldpyFCv+J3N8ehYoD/rAhj
         85Kw==
X-Gm-Message-State: AOJu0YwgAswteofnqIOGrQ6iJb4hMUpurVEDMALj5aLCjZsGL/X4clMB
	k8viPPCZy7sqKK+F5hArluJlYUKCG3UONZSPIchEFEkFPjvB2aiLNvA6Ep48WtU+K0aN41OoqZD
	ANnUu9SYSRIqItBGeHnPqnlQyWjxj380NIZWp0oAqG+WB/NCu0qeLWyQrl68cIh6nn+9a
X-Gm-Gg: ATEYQzxB7mAWvPy9mUVwlJCbxG3yhqWOaqHJzch15htOCKdWz4Mf1YP5ib5pxmCO4Y6
	E2WgWNdLNJM9RXPLPZ3+hKjCdwY3fc81mQUf8aWGERsQq8xE8KKER61Uk/C2MW6RbnUdfgVrzNU
	rr82q4k22++/uxd0EOFqCAzco9PaXI11FIVLOQO4sju5E+vMuUtgLCZDA6Z+mlY5lCO/pnreSuR
	uiJ++W0u+UIWjcWPxc5caLrbEmAHsFZhFQ9iwkS9hv0+aWyDon8PEk8j+ryWrkBGsiNyn3hFLRx
	jKbrObHpfzA1KwK7znVtYNVjwjYCdvwoNWsFFXLzHnrdicEf4U7K7ZWsKsGpgB25rzQFE2mDgIk
	vvcNtiWwIWWEUbZpeXKZVbDv2NbLa0lg3EbQQRkgUTHmidsIsr2MWvQI=
X-Received: by 2002:a17:902:d4c4:b0:2ae:3a77:a1eb with SMTP id d9443c01a7336-2ae8023b605mr1493055ad.39.1772726881214;
        Thu, 05 Mar 2026 08:08:01 -0800 (PST)
X-Received: by 2002:a17:902:d4c4:b0:2ae:3a77:a1eb with SMTP id d9443c01a7336-2ae8023b605mr1492855ad.39.1772726880713;
        Thu, 05 Mar 2026 08:08:00 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:08:00 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 06/15] wifi: cfg80211: add proximity detection capabilities to PMSR
Date: Thu,  5 Mar 2026 21:37:03 +0530
Message-Id: <20260305160712.1263829-7-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I5Johdgg c=1 sm=1 tr=0 ts=69a9aa62 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=nclPvYkPYs_wI36UdL8A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Mr9jnAZEgDsEmJWL7SCeWfcMkMh5kjea
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfX6Aux2LWaNNKv
 6+wYpBIbTo6qAYxdjQIR7iLuebtyTjLeaRZWzAlAzRGqYL9NFhEVe2A6aEm0RFyrqqhIvG/Wyh/
 motKTHp9jmMc4px9QaLJQJU7ezP2dAJk6bm4zy0bdYi6qnfl8AfG9gFxze9UOz2nsvEOhjKzsqn
 VmM9Vnqh1Gm7NejK8LELDcxv/9a2rCW5xHhPZjqPkSiyuR4oFQY/Q1Xbeopsh1aCznW/9o58JHT
 epzMvvdq2cVhpcQdde2hjyG9TCWhvVBfeY4Q2Fi3u0JhSJqXjhW+W3xcfuQMQ5+vfhyUiVBEKPB
 MHTInft1RbfYERTeacszIFgim0IerIDmLrxu2WQYwcSzhyFCUbZbfPjt2nmBIRfAn+ZU3hJ9ump
 Dnqm5yyMy7h+IgOHP0k6Cx6TzGkdPlBFOr8ks2a7Bi9M/i5wPJwz6OUtw+7dHDAtQSrLvnVSR5t
 MofvAJvGqI87cGxBMkg==
X-Proofpoint-GUID: Mr9jnAZEgDsEmJWL7SCeWfcMkMh5kjea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: 12E47215233
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-32555-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
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
 net/wireless/nl80211.c       | 29 +++++++++++++++++++++++++++++
 net/wireless/pmsr.c          |  3 ++-
 4 files changed, 86 insertions(+), 3 deletions(-)

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
index 0ae96063c032..4fbc2c8ff395 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -398,6 +398,7 @@ nl80211_pmsr_peer_attr_policy[NL80211_PMSR_PEER_ATTR_MAX + 1] = {
 
 static const struct nla_policy
 nl80211_pmsr_attr_policy[NL80211_PMSR_ATTR_MAX + 1] = {
+	[0] = { .strict_start_type = NL80211_PMSR_ATTR_PD_SUPPORT },
 	[NL80211_PMSR_ATTR_MAX_PEERS] = { .type = NLA_REJECT },
 	[NL80211_PMSR_ATTR_REPORT_AP_TSF] = { .type = NLA_REJECT },
 	[NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR] = { .type = NLA_REJECT },
@@ -2375,6 +2376,25 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
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
@@ -2409,6 +2429,15 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
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


