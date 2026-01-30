Return-Path: <linux-wireless+bounces-31390-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIiHH/HVfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31390-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D99FFBC581
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2FC2301D322
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6662F4A05;
	Fri, 30 Jan 2026 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LFwRnytl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q00Uecyj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F13446C7
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788870; cv=none; b=JLUmlYVKKPG4CfrB8aN9PK1RuGPglRU94BhBNNGkj+gCLglUSdTitxbOr5oh0WJrgLsDGZgMihNcfnF0zRISNOYFVY7Na6inYfozwnlVJUndQKxdlUOi5z4u+q0D4jiIFYeEeVuInTLGiKsVvUF//hhLkOOuCDRBOQbe6D8y+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788870; c=relaxed/simple;
	bh=s5ZP3YHuEw9FqeppncOTLtpfDm1kubfzo5F1a+XkKN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wr9olwBp95DPjOOOH5iLOuGapF1URvXtiTWTWgWTEVG3qh6Qw4yYMd4y34C8cMXNlglngBzKr2UjDBetE86oy5xI3qAFz2nnSEAKT/sZtpCR6PtPFkabD8oxdYP+UwkHecazbkCetXZ+ee8ijFYsVCO6SUYpl82pS9AcCCAdv2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LFwRnytl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q00Uecyj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UADdLA485882
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=juGkkaXlLWu
	qh+dFJpotYumwMu8HupAlQO8ydXLb/lw=; b=LFwRnytlQiI9Sqs3Ar+2+L2w7ze
	uZZ37jXtlRPN86J42QaAHvupZlIjmEm2RKwiQuu8EXV8DMctJgbJUJfblPP7SQgv
	tiifT9Kf2dfrXC+04u3Bko7jj7KxvylINQaQ/hG3d3HZjOsjzPsNUN5au+MijxTS
	lfNXmc/2aZTNe8JHVwPKe3JoXQtUuY3phB40u5b0hxXX4SuvOuY/BHTd1E1xOcXF
	1WzY0Kono73JzrpniY6hphH88mOup3ZlVgrLvIPsCYO1cjat+WlmRgGzRVepW5cn
	spxtDukXPGrykSxYEWArCM/dENv/rRAiDAKz4zwZMJna9aWlXI/xMGvxhzw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0gtnjrk4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0a8c465c1so20736055ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788867; x=1770393667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juGkkaXlLWuqh+dFJpotYumwMu8HupAlQO8ydXLb/lw=;
        b=Q00Uecyjw8htpjSDqNP6CeG8UBvQmeE8La5+HGD2l/8tbUw/3kXJMMBGq84HompG9d
         qZ6bzB4ZJroGKSphj+YTKDtiDI0rKwk4/Mj9uQnxy4BAtvvl8qKQGNAdaUCiCLKIq1Yl
         RqL7rme70zWNuKc0z/UIpjrCpBfgkRGvzPoFV4vNIxeZrv1mvWA0jabudjTSvF40fPrm
         5LYN14gU8t8TmpCDGD0RDNgxYbZ4cxhuL909RrK6dJ5wEwVIK1v3V/+7aXlQaLQ/PTkD
         VOIv7D059m/1wj8AdGEJ6EL/TfJ3RIKUkxl2K2OtnGaqDQUtSg9XxoVkT4OtqBd0OeaE
         tsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788867; x=1770393667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=juGkkaXlLWuqh+dFJpotYumwMu8HupAlQO8ydXLb/lw=;
        b=lVH76zjonRZ0Otjxn1fCrbYD68149DFCCeDrTpkxQ1dKIDgWrVhGOc1eDPD6akC+2x
         7LpCxkBomhWynMoNx6VwB3GCBVLvAs7jW1lsToBFMPElh+EMRrhNzQIhBGZ0tznZCV3O
         rra3ZbGPVPg9U+Z5yLCtvQ6uExbn947KuXMuj0To45O0QvaBMmlP69QUp8m+fQZEUo41
         nt/ul39WDSkSvGQqXiQW99G5Otn6N40TIJ58/tcR3vQhMM6EBEhMQk5t8o7BPsMlYtgx
         U3LVI4DwIWwB+/6sPSaOUiNBXy3QcbDD4pAkbLxc2MpTLUKuI2hV1VQTssjoD3poacJt
         oDMA==
X-Gm-Message-State: AOJu0YzrdrZMSMZSqauO4r6deaL/ubgZEVOHWKNEG0ZaetQzpPR3Odd3
	N6y+4d2YYHLfoF32W45uAqfAx1AZ4qd49eZOmxTYT6AGJCpyZ20n1/vqgIFEPlAaaHBCm6Ivs9L
	F+12IoLcgPCLtnYdMJo7p/bnKiHei0dwnqFAcqI5sngaYRF+Im35TvegX9c4UR98Z5deq
X-Gm-Gg: AZuq6aI8A71whg34zsTMAvTQZpwIrjT7wnkwU+pc1qc1CL/o7QY/gd99LFD4R3Y3qOe
	29zL1Xk2stpunkh0OGQZOguBtPAsg2AMabNSmBBkXHtkCSeanq6riFHs1LiDwwi828clV0Da4+t
	YqUXgYqEXy/8GSCsFpAVrGs3qmcaBfuAK1GVx2LFwxlQRZvN2IADKcNKutUdbKqkCIkyKkwtqjd
	cxhBV2h5Cs3xwXYhkn0R0L6I9Bi1l+IJ1F4W5fIBNH1e6PAs7OHWBZi+aCcNgY+xK3czwIz2MdS
	oGr108pPlECCg28NZT4a/sXS2bFekMO3lMF5PVny8ygIHwlkYYX97qpHhGG6DcV+II6WL8wxzjv
	VWJW9yc/NlZEqclFtZGT6Xbc+Pvw32iVEt2lU4zkhZkk=
X-Received: by 2002:a17:903:3508:b0:2a0:b432:4a6 with SMTP id d9443c01a7336-2a8d99502eemr36031065ad.15.1769788866772;
        Fri, 30 Jan 2026 08:01:06 -0800 (PST)
X-Received: by 2002:a17:903:3508:b0:2a0:b432:4a6 with SMTP id d9443c01a7336-2a8d99502eemr36030415ad.15.1769788865789;
        Fri, 30 Jan 2026 08:01:05 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:01:05 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 06/13] wifi: nl80211/cfg80211: add role-based PD peer limits
Date: Fri, 30 Jan 2026 21:30:32 +0530
Message-Id: <20260130160039.2823409-7-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-GUID: Y8fG7IR4tUkgkRfApEu6-78zfVdmHqHY
X-Authority-Analysis: v=2.4 cv=FPcWBuos c=1 sm=1 tr=0 ts=697cd5c3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=XesYEwEoQZ8k41pBQkUA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Y8fG7IR4tUkgkRfApEu6-78zfVdmHqHY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfXz8Q9/Gl/7ZbU
 QU8apfBDSP4Z9uQLI4Jb0kVxiccPClsXXDGot2APG90Wk0eQOCfycPSOZ69HWTla4A1+LjASEKW
 0gXOF3df4EjHbKZXE5RZeeiUB7gyqNhzLAR+a88Suzpp6/cA3+cbClosowk72rQFnldaRTS46XI
 ltNBf3PC0t4e4+GIN/VLiTCBJ6yJwguDpQt1BGazQWOws1RqCtXUlJ37U5fPIuHuNhwXsfTo9VK
 nZT/xp0WAxxUHCFIKbEsNfSqaggyGdZTFhWRq2tJivy1KdpGmLTi/4fo5FYwY/O9HssdKt5y4gO
 lG2NRp8PA0ed6sv2cKC2oMlS2i3OIZR0xeomH6UdTzdQWUp1ZOWaqgFRx2rinPFrr2lqj2Nqqqa
 x0tmJwzFch/jotXd4vZ2h1kR7fUht00fKtADjX+/UbIkMJ5CV8aQMGoztiCWVD8eeI/R92bHJpZ
 CTPVxe63OCLuHXE6V8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31390-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D99FFBC581
X-Rspamd-Action: no action

Currently, proximity detection capabilities only advertise a
single maximum peer count that applies regardless of whether
the request is of PD type. However, some devices may support
different numbers of simultaneous peers depending on whether
the request is of PD type or not.

Introduce separate capability fields to allow drivers to
specify distinct peer limits for each request type. When a
device operates as a PD initiator, it can now advertise how
many responder peers it can measure simultaneously.
Similarly, when operating as a PD responder, it can indicate
how many initiator peers it can serve concurrently.

In scenarios where a device supports concurrent operation
as both PD initiator and PD responder, the enforcement logic
considers the sum of both role-specific limits to determine
the total number of peers allowed in a single measurement
request.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 12 ++++++++++++
 include/uapi/linux/nl80211.h | 16 ++++++++++++++++
 net/wireless/nl80211.c       | 13 +++++++++++++
 net/wireless/pmsr.c          | 32 ++++++++++++++++++++++++++++----
 4 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a82d1606345a..ae63a3ead165 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5716,6 +5716,16 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	multi-peer request this will indicate if the device can act
  *	simultaneously as initiator and a responder. Only valid if @pd_support
  *	is set.
+ * @pd_max_peer_ista_role: Maximum number of peers allowed for a device
+ *	operating in the ISTA role under proximity detection. Only valid if
+ *	@pd_support is set. Sum of both @pd_max_peer_ista_role and
+ *	@pd_max_peer_rsta_role is considered to enforce the max peers supported
+ *	in case the request is of peer-to-peer PD type.
+ * @pd_max_peer_rsta_role: Maximum number of peers allowed for a device
+ *	operating in the RSTA role under proximity detection. Only valid if
+ *	@pd_support is set. Sum of both @pd_max_peer_ista_role and
+ *	@pd_max_peer_rsta_role is considered to enforce the max peers supported
+ *	in case the request is of peer-to-peer PD type
  * @ftm: FTM measurement data
  * @ftm.supported: FTM measurement is supported
  * @ftm.asap: ASAP-mode is supported
@@ -5760,6 +5770,8 @@ struct cfg80211_pmsr_capabilities {
 	   randomize_mac_addr:1,
 	   pd_support:1,
 	   pd_concurrent_ista_rsta_support:1;
+	u32 pd_max_peer_ista_role;
+	u32 pd_max_peer_rsta_role;
 
 	struct {
 		u32 preambles;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b2410d4f572c..b6c28c75e141 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7762,6 +7762,20 @@ enum nl80211_peer_measurement_peer_attrs {
  *	multi-peer request, the device can act simultaneously as initiator and
  *	a responder, where the multiple requests are being processed
  *	simultaneously
+ * @NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE: u32 attribute indicating the
+ *	maximum number of peers allowed for a device operating in the ISTA
+ *	(Initiator STA) role under proximity detection. Only valid if
+ *	NL80211_PMSR_ATTR_PD_SUPPORT is set. Sum of both
+ *	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
+ *	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the
+ *	max peers supported in case the request is of peer-to-peer PD type
+ * @NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE: u32 attribute indicating the
+ *	maximum number of peers allowed for a device operating in the RSTA
+ *	(Responder STA) role under proximity detection. Only valid if
+ *	NL80211_PMSR_ATTR_PD_SUPPORT is set. Sum of both
+ *	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
+ *	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the
+ *	max peers supported in case the request is of peer-to-peer PD type
  *
  * @NUM_NL80211_PMSR_ATTR: internal
  * @NL80211_PMSR_ATTR_MAX: highest attribute number
@@ -7776,6 +7790,8 @@ enum nl80211_peer_measurement_attrs {
 	NL80211_PMSR_ATTR_PEERS,
 	NL80211_PMSR_ATTR_PD_SUPPORT,
 	NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT,
+	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE,
+	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
 
 	/* keep last */
 	NUM_NL80211_PMSR_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1ad7eb103189..bfe88f7068da 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -408,6 +408,8 @@ nl80211_pmsr_attr_policy[NL80211_PMSR_ATTR_MAX + 1] = {
 	[NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT] = {
 		.type = NLA_REJECT
 	},
+	[NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE] = { .type = NLA_REJECT },
+	[NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE] = { .type = NLA_REJECT },
 };
 
 static const struct nla_policy
@@ -2017,6 +2019,7 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 		    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE,
 			    ppe_thresh_size, eht_cap->eht_ppe_thres))
 			return -ENOBUFS;
+
 	}
 
 	if (sband->band == NL80211_BAND_6GHZ &&
@@ -2415,6 +2418,16 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
 		    nla_put_flag(msg,
 				 NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT))
 			return -ENOBUFS;
+
+		if (cap->pd_max_peer_ista_role > 0 &&
+		    nla_put_u32(msg, NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE,
+				cap->pd_max_peer_ista_role))
+			return -ENOBUFS;
+
+		if (cap->pd_max_peer_rsta_role > 0 &&
+		    nla_put_u32(msg, NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
+				cap->pd_max_peer_rsta_role))
+			return -ENOBUFS;
 	}
 	caps = nla_nest_start_noflag(msg, NL80211_PMSR_ATTR_TYPE_CAPA);
 	if (!caps)
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 8b7665f2f824..e1b4cc7244cd 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -318,11 +318,14 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *reqattr = info->attrs[NL80211_ATTR_PEER_MEASUREMENTS];
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct wireless_dev *wdev = info->user_ptr[1];
+	const struct cfg80211_pmsr_capabilities *capa;
 	struct cfg80211_pmsr_request *req;
 	struct nlattr *peers, *peer;
-	int count, rem, err, idx;
+	int count, rem, err, idx, pd_count, max_pd_peers;
 
-	if (!rdev->wiphy.pmsr_capa)
+	capa = rdev->wiphy.pmsr_capa;
+
+	if (!capa)
 		return -EOPNOTSUPP;
 
 	if (!reqattr)
@@ -337,7 +340,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 	nla_for_each_nested(peer, peers, rem) {
 		count++;
 
-		if (count > rdev->wiphy.pmsr_capa->max_peers) {
+		if (count > capa->max_peers) {
 			NL_SET_ERR_MSG_ATTR(info->extack, peer,
 					    "Too many peers used");
 			return -EINVAL;
@@ -353,7 +356,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 		req->timeout = nla_get_u32(info->attrs[NL80211_ATTR_TIMEOUT]);
 
 	if (info->attrs[NL80211_ATTR_MAC]) {
-		if (!rdev->wiphy.pmsr_capa->randomize_mac_addr) {
+		if (!capa->randomize_mac_addr) {
 			NL_SET_ERR_MSG_ATTR(info->extack,
 					    info->attrs[NL80211_ATTR_MAC],
 					    "device cannot randomize MAC address");
@@ -378,6 +381,27 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 			goto out_err;
 		idx++;
 	}
+
+	/* Count PD requests and validate against PD peer limits */
+	if (capa->pd_support) {
+		pd_count = 0;
+
+		max_pd_peers = capa->pd_max_peer_ista_role +
+			       capa->pd_max_peer_rsta_role;
+
+		for (idx = 0; idx < req->n_peers; idx++) {
+			if (req->peers[idx].pd_request) {
+				pd_count++;
+
+				if (pd_count > max_pd_peers) {
+					NL_SET_ERR_MSG(info->extack,
+						       "Too many PD peers used");
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


