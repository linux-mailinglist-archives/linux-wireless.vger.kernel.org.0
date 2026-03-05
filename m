Return-Path: <linux-wireless+bounces-32558-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JYcMMOqqWlSBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32558-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:09:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1907821527D
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EEF6313535F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33AF3CD8C8;
	Thu,  5 Mar 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M2IOxNur";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XMbBQ2ow"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D53CD8B4
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726891; cv=none; b=J7ziHR2yHL/E1MXg595QVyPQrmqluQBJOPSmdQFwlP8wEQex8b3A02rxzwrtOie1E20Z9zbgcK5YUvS3YJOfxQ50XWsMScCJxOvWoEaWD703XzG5hfLRWJ2DDqzwrFf/vKyplXUAdoxDW7qj9mUswqpaoM0U9ztEjUEfVvFnfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726891; c=relaxed/simple;
	bh=YcQq71zoJb9lZk8UY0rS7Yu5iN08eiFrw0h3iIKPBU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nxlIJs23JzLjq7EATsO0IgFAkUHhg4M5KX+hZxIA4yefGm20cuEDTXxxXXXzraEtP8a3Ge3JOZcP2ZDpL0miFWJ1neCE6+csDQ95YwGH2XYHX6YckYTagkQujuAh36RzAShSaUdDV7rnN+/JE/4klHGaFE4GtokD+BAOSllLSCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M2IOxNur; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XMbBQ2ow; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFfVl2922564
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8flTi5CIs12
	4l8rQ+i4Ol34YI35IycJhsHapNQM//h4=; b=M2IOxNurdFFHjj3beWnmHU4x+W2
	RWUSQuXZ/81imo4I2e5Gg8mwp1KlbF5pfuA3vId+pBT3CP6G8bd6EWAKORimsBip
	1kh+1Lfu0ybshe0jgYZ/bJao0FnyjZvmRpScsklSfl4RPDYmt0P8tW4a7sxf5r3O
	ev3xVgXGKcQBASNCDLK6MJeNRFHJ6fQBvoIJ1636c7ctJNopSCdPOGSXPOJWzc+0
	GLN9d8Bguz6l/3Xp0e0aydYeo1SqR8fhoxtw+wphbqSZJSzvZdCObqufG5HUThpT
	x8ISj3B8C75palvTQpwO1NJOHv37Lfmj5o+K4nrCZkkRlqJcg5L2xbH5yHQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq2q82959-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:08:08 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so5030526a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726887; x=1773331687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8flTi5CIs124l8rQ+i4Ol34YI35IycJhsHapNQM//h4=;
        b=XMbBQ2owxtpmpKqAJmaPoiGkELoy8gP4B2PLFi1IxAoCKQZFq1DC7t/uwWEQ1+2AjG
         OVoEyhPTUPxLgdWyDqJ5u0r3gzk/kVDpfWA+tGvGQJU4jhxkumfomS3o+xDFSudmpjSD
         52H3CWK+nF7qsZgoHWUh2KGF7OT6u0G/EYysKCGrhywqs4uhc3Yx4T6m5s0FvlVOAHrb
         jMdxzmkZ/S87AUFyT+irpTt4VqUmMdRdzfnAbk1IFYjy3VunpOqJAEuGD+XeAA6lNPA+
         0K2IK3Bjf+MBujXdNfg7w1aLmulqUEUjIKxhJAYGLmAY6QR+voYnh1lo9w6eAMDDV/xP
         WAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726887; x=1773331687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8flTi5CIs124l8rQ+i4Ol34YI35IycJhsHapNQM//h4=;
        b=WlidTfgxm8b/zmjMCYHm/Qg5mlJmfiWM/LhkQMIuEksIAsqoGizCYO4c1SWxhdqTID
         HZHTJkyQr5nAZErcbr3NSCjU++xxDln2LlJIkIOv62LmLpP5taD8bpHbtM50lmaJnUuB
         X7IVrGOx68NmbDCVp3stQ+dlYhtOuxh9ZCjMU9bNPMMq0ry4yyIVWiERFQwV2vqAe0tZ
         3IwpO4jQCifgrGw9BiW9QndjWsMIHsDt0R+PmNLPuj5xRLKtxZ8Vc42VWsR63+gtuEAy
         kqKbMtnSQ9OyqTYDoL9+Jnga9xaJ+RDlMLdkQeukeDNGn5V1R6u0hdLXhyFgHT8ckF8F
         XA8Q==
X-Gm-Message-State: AOJu0Ywjm5fuzFEUFlJesd6tDnP2KOxW+9UaSkUHMEfrtWxTC/2kH3zN
	P4Yi9drgAs4gGoSdDiOYiyOU9W5Bfd7eEIPM2C74Cx+Rs3nYSiCCXVWh7g+qEgM1ewClmQ+bksR
	G95ff7Uk8yHvJMPVnE70Bf5t8DeLQvcb18yumOg2KiZAcWVblcfK6qP3JcbHRavIAocsT
X-Gm-Gg: ATEYQzzXr6TnYVePZZsU1feTpX9vAMaWJfwe4wOgiwQ/JtlRld6RTBeX7YIenWHpOQv
	mILULkz488LQnuYQy6+kwSQTPt7bbUGKYFr18W7/x04YmThRn1uvf6CsvBZ9vwuedmQ4YucwRik
	FCC2whtZMiAfHHnNldwsvNfo8VnXLlbnXRp8fkywXOw3AYdfOipNADUyestCkCOkJG+901hSmWH
	ZUX9GeVyF6KZ4PUC5vdGp+uNmdRzuDkfwUmNTBof5vHpTNpvQJ2KYNi970wDDilInEG/Uuwc9OS
	w4ThVpKxgFCR7tswpkPYUuc6mFydVrkXxqnoDx1t8yCdlnBTN4rC+HI3uaGPFS0TjmRnX6r6OGi
	oGPIjgaqyK92nxCOcn5/rXsesTOn3fPZJZHZzq1D7yrDy9QsulpQmEMg=
X-Received: by 2002:a17:903:8d0:b0:2ae:5804:baeb with SMTP id d9443c01a7336-2ae75c8935amr32949205ad.30.1772726887328;
        Thu, 05 Mar 2026 08:08:07 -0800 (PST)
X-Received: by 2002:a17:903:8d0:b0:2ae:5804:baeb with SMTP id d9443c01a7336-2ae75c8935amr32948835ad.30.1772726886733;
        Thu, 05 Mar 2026 08:08:06 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:08:06 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 09/15] wifi: cfg80211: add role-based PD peer limits
Date: Thu,  5 Mar 2026 21:37:06 +0530
Message-Id: <20260305160712.1263829-10-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-GUID: C8vqhzNjaB00G4HSAw7INMPmwAUqjl8x
X-Proofpoint-ORIG-GUID: C8vqhzNjaB00G4HSAw7INMPmwAUqjl8x
X-Authority-Analysis: v=2.4 cv=GecaXAXL c=1 sm=1 tr=0 ts=69a9aa68 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=K7Y0hQzyhBSOCp0i4yEA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEyOSBTYWx0ZWRfX0YuFmruGGQzb
 rZSWwUZE6zyFXbAdOxCN54AyyzqDqlTCvbNQWYF74cb9GdyQ22oFpmu1ESM2HmTyxQ+/RtJJO6A
 1l7b/eKE95188PkDH7tOUoD4Y3z0T1CBpbORUAqkDDBZVpKSeKZcX/EWMNy20rZDEDylVr1G5h0
 AqLL4CA+s6/bvfMJKlmhP5oZ1NTpiTB3DfnjISGhkH9/6JrN2JDjHUX3xUDIovNjQ0G34nAGjUw
 WNznIktDJO8yXEjX6p9sDBjZTSJ57HzAbWlZPAkz0b6v3s9rbblmKb/aE0h1eX5CTWeZb9DKFC5
 ityxsQLFgJEq8Otxj47xfah7uWb/rJbuBATu2ZjIiUezoWcSAzCrIj/cB7D6BkPjGSUx7ThYPpo
 PkdONKYJMYuBR4/kjSaR74f4ZwAPrdfjyOKw4S61A1vIOge846mmuS5bEktvElw+l5HliC0v2Iy
 ktJJOC8/Tb8Eb9WELyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050129
X-Rspamd-Queue-Id: 1907821527D
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32558-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Peer measurement capabilities currently advertise a single maximum
peer count regardless of device role for proximity detection (PD).
Some devices support different peer limits when operating as PD
initiator versus PD responder.

Introduce separate peer limit capabilities for each PD role. When a
device supports concurrent initiator and responder operation,
enforce the sum of both limits to prevent resource oversubscription.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 12 ++++++++++++
 include/uapi/linux/nl80211.h | 16 ++++++++++++++++
 net/wireless/nl80211.c       | 10 ++++++++++
 net/wireless/pmsr.c          | 32 ++++++++++++++++++++++++++++----
 4 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index febd7bf50d88..8bbca2a98ac1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5776,6 +5776,16 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
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
@@ -5820,6 +5830,8 @@ struct cfg80211_pmsr_capabilities {
 	   randomize_mac_addr:1,
 	   pd_support:1,
 	   pd_concurrent_ista_rsta_support:1;
+	u32 pd_max_peer_ista_role;
+	u32 pd_max_peer_rsta_role;
 
 	struct {
 		u32 preambles;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 67cc1ce6d2a1..83d2a822c770 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7841,6 +7841,20 @@ enum nl80211_peer_measurement_peer_attrs {
  *	multi-peer request, the device can act simultaneously as initiator and
  *	a responder, where the multiple requests are being processed
  *	simultaneously
+ * @NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE: u32 attribute indicating the
+ *	maximum number of peers allowed for a device operating in the ISTA
+ *	(Initiator STA) role under proximity detection. Only valid if
+ *	%NL80211_PMSR_ATTR_PD_SUPPORT is set. Sum of both
+ *	%NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
+ *	%NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the
+ *	max peers supported in case the request is of peer-to-peer PD type
+ * @NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE: u32 attribute indicating the
+ *	maximum number of peers allowed for a device operating in the RSTA
+ *	(Responder STA) role under proximity detection. Only valid if
+ *	%NL80211_PMSR_ATTR_PD_SUPPORT is set. Sum of both
+ *	%NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
+ *	%NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the
+ *	max peers supported in case the request is of peer-to-peer PD type
  *
  * @NUM_NL80211_PMSR_ATTR: internal
  * @NL80211_PMSR_ATTR_MAX: highest attribute number
@@ -7855,6 +7869,8 @@ enum nl80211_peer_measurement_attrs {
 	NL80211_PMSR_ATTR_PEERS,
 	NL80211_PMSR_ATTR_PD_SUPPORT,
 	NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT,
+	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE,
+	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
 
 	/* keep last */
 	NUM_NL80211_PMSR_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 01a70f1898bc..0642b7a31a32 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2447,6 +2447,16 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
 		    nla_put_flag(msg,
 				 NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT))
 			return -ENOBUFS;
+
+		if (cap->pd_max_peer_ista_role &&
+		    nla_put_u32(msg, NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE,
+				cap->pd_max_peer_ista_role))
+			return -ENOBUFS;
+
+		if (cap->pd_max_peer_rsta_role &&
+		    nla_put_u32(msg, NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
+				cap->pd_max_peer_rsta_role))
+			return -ENOBUFS;
 	}
 	caps = nla_nest_start_noflag(msg, NL80211_PMSR_ATTR_TYPE_CAPA);
 	if (!caps)
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index a0c07fd841d8..ab25fe07c946 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -326,12 +326,15 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *reqattr = info->attrs[NL80211_ATTR_PEER_MEASUREMENTS];
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	int count, rem, err, idx, pd_count, max_pd_peers;
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
@@ -346,7 +349,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 	nla_for_each_nested(peer, peers, rem) {
 		count++;
 
-		if (count > rdev->wiphy.pmsr_capa->max_peers) {
+		if (count > capa->max_peers) {
 			NL_SET_ERR_MSG_ATTR(info->extack, peer,
 					    "Too many peers used");
 			return -EINVAL;
@@ -362,7 +365,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 		req->timeout = nla_get_u32(info->attrs[NL80211_ATTR_TIMEOUT]);
 
 	if (info->attrs[NL80211_ATTR_MAC]) {
-		if (!rdev->wiphy.pmsr_capa->randomize_mac_addr) {
+		if (!capa->randomize_mac_addr) {
 			NL_SET_ERR_MSG_ATTR(info->extack,
 					    info->attrs[NL80211_ATTR_MAC],
 					    "device cannot randomize MAC address");
@@ -387,6 +390,27 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
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


