Return-Path: <linux-wireless+bounces-38659-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZnZoMcxpS2oJRAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38659-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 10:39:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 374EC70E330
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 10:39:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=i1sBktuc;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BFswgWsF;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38659-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38659-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A31D3013882
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74493E3169;
	Mon,  6 Jul 2026 08:39:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FB3ADB9B
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 08:39:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327158; cv=none; b=KcdC7d4WzAhhkRYcG3i4b2EGv5DcLRBE3UD3y6JTUSAtMV8OPzTD2pRyDOOj/3ZXtZh8ll5hGaT0fKw8ufAD+S0dImbO7NFVkHgR/weSB4FBZlpY/hoLARlvzF0XLQ5R3Auii+wZas/zukkyylULvJQxzFuD3q6xnQfOqMMM2Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327158; c=relaxed/simple;
	bh=+Sb04CoRg8ILm+uWYzza0kiEe7hjANTDL5x1JD6zrFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJEarnx6DNQNv9XuZU58RJ+GrjVihQ0regZO1NDum4/rQRXc3z9PJeJELRlG+CnHXU9/caxca1f1iPFvmzKv6mFQSKwBZkICEILPdk5irb1KA51WVtbua5MAADdh0NoxOFDuYFeoMuOZGgbSEFHQA+5wYbxf2JaIH0eH70OpojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i1sBktuc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BFswgWsF; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66642DKW3618367
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jul 2026 08:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SHJ+bxRD3be
	r4oA4GYSGTUcN0gXQZAnUvCnoA/vU0qw=; b=i1sBktucBpL/aTNN3yWdsifWMOp
	HAsyzjRVp11Mrs4OIOr6jnoIZQYp5AWwlghzUi8dxXq0xgSm2BLwNTqvGx0K7QlS
	H6AtyJqqWCngCzguZZ2nzaJZfsHGofEkUsPOiE5gmoksKgh1JsSr+vbWs99fZIA/
	10GOdu8nKt6BstlZwdz0PjtFH4JjP0rUxIso/73Efvl9PGHgA2WRPBdeNvwxaWqS
	063R8+uczZe4R4sLrTJB4sEhF5kjYUU75AFBB8HZGaJJtYG1M+0zpknqfNgueWza
	AORhc4vLQ2Bqu9DOyypbFxBfbbvlCUKsTDjMYbIgRDHxfKQ73EoaTmhMxkQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s64net5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 08:39:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c6a20348ceso38702975ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 01:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783327146; x=1783931946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SHJ+bxRD3ber4oA4GYSGTUcN0gXQZAnUvCnoA/vU0qw=;
        b=BFswgWsFz5XVF/tB9eysyy5XvZ/IoLXqI651kY0JnkQB1png9KJ2SiBuQKGN23kXXp
         xsyARWsiAOBM71L59jqQXEVD+dYyYYjmwmeQeropoKUU/So1+qyOWq1U/o6dy3n1LRr7
         iq53Q08sD+ji0lZrQ9xHuu6HThlButuhjl2+hTj0ghkivgheh3/Qz/SPsKJYl+AJime1
         YgUB2ftBTJkAK8+SV2OAkx1MpYW7Pd9oZrwtUHbEEw+G9YO0lpjKMsbbRffo0BDWFC+R
         yz/eKZnlUZMYXNoBB94BxD5XyzuEBWB2uKF648d0Ao5/eCxmmWRjg0m2Kwrvqi5kTDxR
         8trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327146; x=1783931946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SHJ+bxRD3ber4oA4GYSGTUcN0gXQZAnUvCnoA/vU0qw=;
        b=VFqlakwhCiaLkbHv4UvNgCRb3TbAo7HFAZPNsrqxap9DjuxkUAwdK82qFzvN0fbquK
         zP6Jh2wCKLzygfbfG5v8F1oCP0kbNZVvMSMxS46GIOMEirDVLyQIZ+etO1nfcSCwZEtA
         r8rO+kVyyvSbiOV3JJMsT5KpPPLbSnatoT8tU1YSz+xEJaRvp7/4PKL4PsxTV1T9DHfa
         RDAWZG98Ko4hvS5hHEidoN4yp45lYvLA+0M5dVMITFSopjlCzdZZiKuz5JVwQh3xe9ib
         e/e2Lrt5CVclgS45bskq6+Ldxr6E0OHLjs3apV5OWb7AV4oEnwQmeOQa64CBpNxSMQLe
         YJzA==
X-Gm-Message-State: AOJu0YyEGxPXfO/60soaWboEN2kBw9oEvAEjuLYAPRuNBfVDs6FEypv2
	jE+m3d4xl36zePMGAW1leofsGtDQT4WPzwYHPjriiWq0mBAdfGDDZLKbx1EAOjcNwTPLtzIjPjo
	OYTcgk7GP33ggorjwLB75o5kf3t1E40VUrs/QEPi4RyxqjSVbkjpyzrdsRup5bpfv4zAp
X-Gm-Gg: AfdE7ckqpr+lRW1sN7JjtpLvQUE0DpEdqza9hHVxpeJtQpFXTagJAaVyY25Mgn1NdZI
	0MZsNGWJCt0s3pBYx3nIUOPFiPZgvDMQzZzr85TXdd9wxxDGexWsySt7yIEi8zMJLhxSwokfbk0
	DPjG8Aa4ALfj65IFpMpAf0zSCtBKbegb/Ste8bNd588WE+0td3aWRGhjmsThkEUgFe6M2KRrtbu
	halDa+xwIoqZRDiEow4BUR2fEaqavYucxchfhG//EkZk+9mYGTNnUTiVMWZZgyg0joG0fCUz4/x
	lJmTPjRJ+63KOTcpWy6BNPE9ZqWWHzd4l+P/A1jd6mo5VcJNCBXcZJINSbDASO9Kba99HpchwtZ
	4DmvbbqkeITXkE7v//ezMM/Q4qPHPC3C/348pLYCA/6GVnNn6F32eLNi4ljb82aUOoANe/AmFvX
	wlNS7L1rsy2cQ+pyQeddRoAP/03CIIso5g/ykN
X-Received: by 2002:a17:903:26c3:b0:2ca:4cfd:a6df with SMTP id d9443c01a7336-2cbb9f2ab77mr89792925ad.43.1783327146242;
        Mon, 06 Jul 2026 01:39:06 -0700 (PDT)
X-Received: by 2002:a17:903:26c3:b0:2ca:4cfd:a6df with SMTP id d9443c01a7336-2cbb9f2ab77mr89792745ad.43.1783327145686;
        Mon, 06 Jul 2026 01:39:05 -0700 (PDT)
Received: from hu-pshashik-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25f92sm45656925ad.9.2026.07.06.01.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:39:05 -0700 (PDT)
From: Shashikala Prabhu <shashikala.prabhu@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, cgopi@qti.qualcomm.com
Subject: [PATCH wireless-next v2 1/2] wifi: nl80211/cfg80211: Add MCST value to channel switch started notification
Date: Mon,  6 Jul 2026 14:08:59 +0530
Message-Id: <20260706083900.908140-2-shashikala.prabhu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706083900.908140-1-shashikala.prabhu@oss.qualcomm.com>
References: <20260706083900.908140-1-shashikala.prabhu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfXzXF2F/seqc5W
 aN+fbSpjAAAJaCnNzLEwa87/KSOTkLYPOhG5OGhrve5YAVz+/z/pfHTOjsjju3VjJA2lMkFVUIn
 hZZf7lFOuKKPskEkZmCjizZh6ltzzqi6HGh7Bx7OFxnOaqcB6a3TzXn65tLtHbfTKoqSPGp4Qrc
 SFiSOJK7pUFSYCpZRAzqnP1s3FGh1wvPF4xQNvugI7sWiU+rUla5hU37PWFl7CAsvghLEtV5bud
 lwc1I8G+0FxAL8gvkSg+LYWrErgR3+5Ms08RWYTwFyM93ovD6yGfq0TlxlQ1zF4aBFGwPi2QGy2
 e30OdcCVFyJ1bfeAP5PJJ3utg2lTYUxjHcsXErq/r4sWBH4BdsavThMmuJXip8ZHSa5o3JwbSf3
 UnQBFiklaEyMh4USmZprOb0830uMa8QYyDiSmLJS/XFgPSSc9Xllfepx9kNWjOzHrjNuweWX6Ht
 m+Gb9aLNCoEIJkszYwA==
X-Authority-Analysis: v=2.4 cv=VvITxe2n c=1 sm=1 tr=0 ts=6a4b69ab cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=XG50IErifMXcszP_SugA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: upK4KVelQDF5AzSQxTTDoyZzUa6m6TuI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfX2jhEZURTA52N
 LX0gSKAXeP+a/swatf1tnqGMQY61dkiJILBKZ9E0GdDpVYmh9AR8dIF4nyaHebuKeDN0N87ah/D
 G4QsCASSxBDizWKPLWiiZuDQXR2zJk8=
X-Proofpoint-GUID: upK4KVelQDF5AzSQxTTDoyZzUa6m6TuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060086
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-38659-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:cgopi@qti.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shashikala.prabhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shashikala.prabhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 374EC70E330

From: Chandru Gopi <cgopi@qti.qualcomm.com>

IEEE Std 802.11-2024 subclause 9.4.2.216 (Max Channel Switch Time element)
defines a Switch Time field in the Channel Switch Announcement (CSA)
element that indicates the time delta between the time the last beacon
is transmitted by the AP in the current channel and the expected time
of the first beacon transmitted by the AP in the new channel.

Add a new u32 nl80211 attribute, NL80211_ATTR_MAX_CH_SWITCH_TIME,
and extend cfg80211_ch_switch_started_notify() to carry this
value. The value is forwarded to userspace via the
NL80211_CMD_CH_SWITCH_STARTED_NOTIFY event. Userspace can use this
information to decide whether to remain connected or disconnect
before the AP moves to the new channel.

Signed-off-by: Chandru Gopi <chandru.gopi@oss.qualcomm.com>
Signed-off-by: Shashikala Prabhu <shashikala.prabhu@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  4 +++-
 include/uapi/linux/nl80211.h | 11 +++++++++++
 net/wireless/nl80211.c       | 13 +++++++++----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8188ad200de5..93ce6bf4d385 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9987,6 +9987,8 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
  * @link_id: the link ID for MLO, must be 0 for non-MLO
  * @count: the number of TBTTs until the channel switch happens
  * @quiet: whether or not immediate quiet was requested by the AP
+ * @mcst_tu: max channel switch time in TUs, 0 if the MCST element was not
+ *	present
  *
  * Inform the userspace about the channel switch that has just
  * started, so that it can take appropriate actions (eg. starting
@@ -9995,7 +9997,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
-				       bool quiet);
+				       bool quiet, u32 mcst_tu);
 
 /**
  * ieee80211_operating_class_to_band - convert operating class to band
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9998f6c0a665..daee71bcf9cd 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -953,6 +953,10 @@
  *	after %NL80211_ATTR_CH_SWITCH_COUNT TBTT's.  The userspace may
  *	decide to react to this indication by requesting other
  *	interfaces to change channel as well.
+ *	%NL80211_ATTR_MAX_CH_SWITCH_TIME included in this command indicates the
+ *	AP's Max Channel Switch Time. Userspace can use this information to
+ *	decide whether to remain connected or disconnect before the AP moves to
+ *	the new channel.
  *
  * @NL80211_CMD_START_P2P_DEVICE: Start the given P2P Device, identified by
  *	its %NL80211_ATTR_WDEV identifier. It must have been created with
@@ -3165,6 +3169,12 @@ enum nl80211_commands {
  * @NL80211_ATTR_NPCA_PRIMARY_FREQ: NPCA primary channel (u32)
  * @NL80211_ATTR_NPCA_PUNCT_BITMAP: NPCA puncturing bitmap (u32)
  *
+ * @NL80211_ATTR_MAX_CH_SWITCH_TIME: u32 attribute carrying the Switch Time
+ *	field from the MCST (Max Channel Switch Time) element, indicating the
+ *	time delta between the time the last beacon is transmitted by the AP in
+ *	the current channel and the expected time of the first beacon
+ *	transmitted by the AP in the new channel, expressed in TUs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3762,6 +3772,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_NPCA_PRIMARY_FREQ,
 	NL80211_ATTR_NPCA_PUNCT_BITMAP,
+	NL80211_ATTR_MAX_CH_SWITCH_TIME,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 53b4b3f76697..b6bc5e395a7f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -22290,7 +22290,8 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 				     struct cfg80211_chan_def *chandef,
 				     gfp_t gfp,
 				     enum nl80211_commands notif,
-				     u8 count, bool quiet)
+				     u8 count, bool quiet,
+				     u32 mcst_tu)
 {
 	struct wireless_dev *wdev = netdev->ieee80211_ptr;
 	struct sk_buff *msg;
@@ -22322,6 +22323,10 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 		if (quiet &&
 		    nla_put_flag(msg, NL80211_ATTR_CH_SWITCH_BLOCK_TX))
 			goto nla_put_failure;
+		if (mcst_tu && (wdev->iftype == NL80211_IFTYPE_STATION ||
+				wdev->iftype == NL80211_IFTYPE_P2P_CLIENT) &&
+		    nla_put_u32(msg, NL80211_ATTR_MAX_CH_SWITCH_TIME, mcst_tu))
+			goto nla_put_failure;
 	}
 
 	genlmsg_end(msg, hdr);
@@ -22374,7 +22379,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 	cfg80211_sched_dfs_chan_update(rdev);
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
-				 NL80211_CMD_CH_SWITCH_NOTIFY, 0, false);
+				 NL80211_CMD_CH_SWITCH_NOTIFY, 0, false, 0);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_notify);
 
@@ -22421,7 +22426,7 @@ EXPORT_SYMBOL(cfg80211_incumbent_signal_notify);
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
-				       bool quiet)
+				       bool quiet, u32 mcst_tu)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -22435,7 +22440,7 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_STARTED_NOTIFY,
-				 count, quiet);
+				 count, quiet, mcst_tu);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);
 
-- 
2.34.1


