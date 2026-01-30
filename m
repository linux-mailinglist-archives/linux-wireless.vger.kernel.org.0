Return-Path: <linux-wireless+bounces-31395-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPJKFCTWfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31395-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:02:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FE9BC5B3
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D523007AF2
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C504C2F4A05;
	Fri, 30 Jan 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FWgZh+xI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EmKUAv6z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49C303A3B
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788880; cv=none; b=MviLQrq1k6BTY+BFgXkE9Z3MnxMpwW6qCL8d4/4Eixz02TkRrmxq1OkOeebIw6YIOGcOettdQioDNf0U437gRih5Nzn2KFrLbcjN5l6BxZ2aukNeP3GArx5FdQlh032v8Qh6nAcqguHXG/xdiivC2iT0RMzfFxvIDLF8TddPaAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788880; c=relaxed/simple;
	bh=lzpDkE1gtUI9kREXwbQ7DnCe/NFBiFEqgDlDAO1nfr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BR2AYpdR9ToZOrKj5khB9vccpZZrBqvP7JHmyKqjX/F047YmKkDIlNa/N1dpua7DNtEfYSynUjA32KXUQVVXYFvQcjzzfWK4OaXuhKUgEAznMBCJbMIBR2LTjJqTPGY190boG7mksaRo82/KwQctmes6UGrRpzokgkisgqzudsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FWgZh+xI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EmKUAv6z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UBw5GB555423
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZOA66pXd6AV
	RKu7WWqDjpaNob7S782sX2iWlZYnEh+A=; b=FWgZh+xIIaZrKRXmOY7HlnZqAol
	lYFDHMc4nzp6RaSDbOBYxtnCxz9OTgctr3YMOpZnZ/Zpfn8Rb6XwsSJ2cugMxhrX
	LDj720Lj43nrMMT4eigAU4HjypR+mM+i41aOF291g6FwT6QCvu8XzQ1LLtzijov/
	b2wKk5uxd6s35Fe4VilYZR2aTwkhIDREFTZ3d7Ne4IwIVkHAkFXP5ZPpMuDw9dW4
	iWESMton3qr125aNrayHEpjo4XNgzRCisdWO4aN8/MtvxtXMmcRzLh3mFoSgmlkp
	OdKCzXd002G6fM4+hlQhWSjLpUvQSOLkzbGm9GyqwhkA4zAErCGlwf6m8qA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0p59hwxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:17 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c337375d953so1617699a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788877; x=1770393677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOA66pXd6AVRKu7WWqDjpaNob7S782sX2iWlZYnEh+A=;
        b=EmKUAv6z9IFiyRj4I3kWVaMRerTcgbgWJ9GflfDzVYbTkzc1FruKQ+Qgp1//s0oFcP
         u5suman7stLaH1cVLOgoWLvhEmIHEb6GIqf4X/R6bGPbw4xJ5HjdbxPYbijRTmzmpyqH
         CxlS2ANWs95pjgmEv4E2WKCtoaLPoRM0BtbxOGDljfyBmBFeTDDorGC+3SK6g2hf8LJp
         +muYartPSju5Aey16dsZcJ59u04XB65D5FVLBswAILmKUmO1eiwbz4c5CPWyK5Y1muFm
         kZHDE5HAmVvOVCjO0FYuV9mlHk1tm9E5W2huElFrnOX4HfNwiTq3kPnVIi7tmQw3O9bB
         UKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788877; x=1770393677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOA66pXd6AVRKu7WWqDjpaNob7S782sX2iWlZYnEh+A=;
        b=KLPcShRrcduvKOvnkgtxTZT6OSFl7EoO5k0Sd6Yhk+A3f6a+PHbbQwxrLyh3dUZ3eI
         +JKUDhM3bw8dmtKvYK3phbpTfXo+KwOsizcmnUHZyj7/HpMfF04YjExwsp455tNGJdJ4
         VC1W0Co61CSfFaet8Kfh6+nzRGKpEDbOYNVoThVZH7vOw7jIpSN09D4meehkcMKJmuiK
         x6kdJawFZhuPbTwnw/MOQfxxHNyrc0jHStlHKUPvyu+0iXG+F67iY92AKlG4Lq5lacH7
         SUiP+QAjiieGgl97gHGKnu9nIxmqMmzmn1U9nYj/6sv/uHqFU1TWk5v2L3ePCDDRUk7N
         uAEQ==
X-Gm-Message-State: AOJu0YywCRGe3VfwzRQRQU4Xxf8QlN2yO4F61jMS4s4XJatyT5SndPQb
	M06PVTWARRXbHWmmSfbBK2O+yjUr0qCbPe5hpcF7xPA8Zu2P/p7kKjkKjDhoSYKWoxTi1kOGNyA
	K9tltZxw8tSZeif8LbzMQfIodkQm/ajYMxz7hlv56Qcx4vRBaxqEyoE4eJN3Urou7eXXwf8euDC
	8l
X-Gm-Gg: AZuq6aJ7u5mAkkAm+7EMcDQxtTjTGwaXhTJr2FSuQjkM17YL4p3S2l7eOOSGjlhQC+L
	lYxCgPVIdbBZqcCHtvQCNl0d71uSnjENFV8sYBY75hg1p+cBf0j/0ecFHg/JKmFbDKRxze4beNm
	aQ4FUTh6lp6BZNZ6cC5XCcZ77qCLLIdZ9R1tqLVisphlTr0h/O9K9rGFo9VMvFWmPRA3MSJO+m7
	61tg3YzKCWMcZqJS+2BEHDf6OEKtV5+AIqc4lvRQLjlzyi77JwjbCNJyKzjwnv35juwtmvnYsnj
	1m00znm66rTYf+F0gXCj/9+f7UiSIbE1jQqUwye93kCETCdB+lrmSeibgIJ5UvGb7UPJsAbB6nA
	Xhfyb7+B61U4uOv2dKk2C1++nhiQCEvtC+KklrqMenh8=
X-Received: by 2002:a05:6a21:7903:b0:392:e5eb:f0a with SMTP id adf61e73a8af0-392e5eb1256mr2149109637.75.1769788876643;
        Fri, 30 Jan 2026 08:01:16 -0800 (PST)
X-Received: by 2002:a05:6a21:7903:b0:392:e5eb:f0a with SMTP id adf61e73a8af0-392e5eb1256mr2149068637.75.1769788875849;
        Fri, 30 Jan 2026 08:01:15 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:01:15 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 11/13] wifi: nl80211/cfg80211: add MAC randomization support for PD requests
Date: Fri, 30 Jan 2026 21:30:37 +0530
Message-Id: <20260130160039.2823409-12-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: J4OBE1K4Cco2wSks9-7dyaHJm9KvaEtm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfX35kzdM271sX2
 P9po6V3Yua4pg8QT+VkHorLjogp5p9+HsAqFReuMNzKRm/pP/TB7wtE9O5mytwCqsmbRNGXrPUv
 24h06z2rrwy7j7FBH8iLpHIXrCdV+GneGF0s44p519U3Hi8Yxhzt/GkfmGSO3buILScZcZZO+/E
 T4UL29pO1O86oYnnLqSjLXezuNtco+dHFnzoYnr8f+31+wTymojIijK6BtdUbhD+x4iGN3dQwwP
 I8oBB2I1A3Rt2b+BFSIYi+i23GnO2RLxk/Fqpq8lTJmD8ldjVvleHoNfc2TaKp8YZ2QdbGwKhaD
 ALSJhQRGF0KhzU2m9KPw510wHeW6oX2KcTmC3xjnHYu7/TbjKMubN596RQGgM+pGpMUk/Q7MjCZ
 3X05ErfcxGYNmQEARZ1+1glKXJ7j+DX/ZMGB70Y0kjitstDqt4cemcCU3vwE/dtBlxv/vM+/fZ5
 Dh/ZGX7MDqHyIVgX32w==
X-Proofpoint-GUID: J4OBE1K4Cco2wSks9-7dyaHJm9KvaEtm
X-Authority-Analysis: v=2.4 cv=Re+dyltv c=1 sm=1 tr=0 ts=697cd5cd cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=dwHZau_51_vYx2LytkEA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31395-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A4FE9BC5B3
X-Rspamd-Action: no action

Add support for MAC address randomization in proximity detection
(PD) requests. When enabled, the same randomized MAC address
used for discovery and authentication phases will be used for
the ranging measurements, maintaining privacy throughout the
entire PD session workflow.

The implementation adds a capability flag for devices to
advertise PD MAC randomization support and validates that
randomization is only requested when the device supports it.
This ensures consistent MAC address usage across all phases of
proximity detection while preventing invalid configurations
where randomization is requested but not supported by hardware.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  7 ++++++-
 include/uapi/linux/nl80211.h |  5 +++++
 net/wireless/nl80211.c       |  6 ++++++
 net/wireless/pmsr.c          | 10 ++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 00ef211f20f1..dd45dda7e619 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5734,6 +5734,10 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	multi-peer request this will indicate if the device can act
  *	simultaneously as initiator and a responder. Only valid if @pd_support
  *	is set.
+ * @pd_randomize_mac_addr: flag attribute in capability indicating that MAC
+ *	address randomization is supported for PD request. if capable a mac
+ *	address used for discovery, authentication will be used for ranging too.
+ *	only valid if @pd_support is set
  * @pd_max_peer_ista_role: Maximum number of peers allowed for a device
  *	operating in the ISTA role under proximity detection. Only valid if
  *	@pd_support is set. Sum of both @pd_max_peer_ista_role and
@@ -5795,7 +5799,8 @@ struct cfg80211_pmsr_capabilities {
 	u8 report_ap_tsf:1,
 	   randomize_mac_addr:1,
 	   pd_support:1,
-	   pd_concurrent_ista_rsta_support:1;
+	   pd_concurrent_ista_rsta_support:1,
+	   pd_randomize_mac_addr:1;
 	u32 pd_max_peer_ista_role;
 	u32 pd_max_peer_rsta_role;
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 85223b16eb84..c102a54ff335 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7776,6 +7776,10 @@ enum nl80211_peer_measurement_peer_attrs {
  *	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
  *	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the
  *	max peers supported in case the request is of peer-to-peer PD type
+ * @NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR: flag attribute in capability
+ *	indicating that MAC address randomization is supported for PD request.
+ *	if capable a mac address used for discovery, authentication will be
+ *	used for ranging too. only valid if %NL80211_PMSR_ATTR_PD_SUPPORT is set
  *
  * @NUM_NL80211_PMSR_ATTR: internal
  * @NL80211_PMSR_ATTR_MAX: highest attribute number
@@ -7792,6 +7796,7 @@ enum nl80211_peer_measurement_attrs {
 	NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT,
 	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE,
 	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
+	NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR,
 
 	/* keep last */
 	NUM_NL80211_PMSR_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6d53eb3eb78c..2909520bb949 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -414,6 +414,7 @@ nl80211_pmsr_attr_policy[NL80211_PMSR_ATTR_MAX + 1] = {
 	},
 	[NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE] = { .type = NLA_REJECT },
 	[NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE] = { .type = NLA_REJECT },
+	[NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR] = { .type = NLA_REJECT },
 };
 
 static const struct nla_policy
@@ -2441,6 +2442,11 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
 		    nla_put_u32(msg, NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
 				cap->pd_max_peer_rsta_role))
 			return -ENOBUFS;
+
+		if (cap->pd_randomize_mac_addr &&
+		    nla_put_flag(msg,
+				 NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR))
+			return -ENOBUFS;
 	}
 	caps = nla_nest_start_noflag(msg, NL80211_PMSR_ATTR_TYPE_CAPA);
 	if (!caps)
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index a55eb73e6938..fcd7af0c61ba 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -376,6 +376,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_pmsr_request *req;
 	struct nlattr *peers, *peer;
 	int count, rem, err, idx, pd_count, max_pd_peers;
+	u8 use_random_mac = 0;
 
 	capa = rdev->wiphy.pmsr_capa;
 
@@ -422,6 +423,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 					       req->mac_addr_mask);
 		if (err)
 			goto out_err;
+		use_random_mac = 1;
 	} else {
 		memcpy(req->mac_addr, wdev_address(wdev), ETH_ALEN);
 		eth_broadcast_addr(req->mac_addr_mask);
@@ -453,6 +455,14 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 					err = -EINVAL;
 					goto out_err;
 				}
+
+				if (use_random_mac &&
+				    !capa->pd_randomize_mac_addr) {
+					NL_SET_ERR_MSG(info->extack,
+						       "PD mac randomization not supported");
+					err = -EINVAL;
+					goto out_err;
+				}
 			}
 		}
 	}
-- 
2.34.1


