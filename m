Return-Path: <linux-wireless+bounces-38657-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zgj7HSBvS2puRQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38657-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 11:02:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B870E66A
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 11:02:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=CP1pcY8u;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=gACQ0JVU;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38657-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38657-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BC8532D737A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 08:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69663F8896;
	Mon,  6 Jul 2026 08:39:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22D3F39E8
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 08:39:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327155; cv=none; b=S5wWVNZ1/PfMSMijZpCAKxitVSHgEKFuGYBqmg9lKeEc4gQV8HgiJODLE2fTo3teOA2KhDtxcAQTi9wEPGWHc33h5zQa5Epu17cRk2FE0jSUrwNRQ54mYnRyD/A4VUiku2HY353NiuOjuoj0t8l0f+kmNoAf0BZ7feR/pjQCjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327155; c=relaxed/simple;
	bh=jEm2tV3pX/zzwr/OtaYnlVvIS+E1a74cLqDU5XBzs68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dtwy3lRBQ5Pi+vtvyi5vK99ZgoUT0pN4c7DFB+7dZkTtCAq9y4S0eeISxLUgW0m60KWTAJ8uh1DtdA45ORBLQ1xSYEgg4TzeIFCZZ9S+2N9P4KJ5SlCrphHMKTqf2QSkxdeJShGz0I0Lv6sfIcyDXpJXJl3wBOSbJLblJTe7YOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CP1pcY8u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gACQ0JVU; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6668NIm84073011
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jul 2026 08:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JOjxCxm6f36YUPcmZ/Wy0SceUz4YqGAp1Gl
	e6QFSgq4=; b=CP1pcY8u6M1VvoJ1bbCbnAxT9E9N/TLVgstSZuHBzlhu3KGAWwT
	0tiYReOlIQgf72aowrePZyqpuR6NdpneWXa1ZYT+wF7XRqedKMkFEManlFrhuQxX
	kopdxg4+ks7sALaarjL5Tzs1E+XZkOVS7cw9eaP5Y0oIwn+T/CH+3HYaSTg7w/ge
	SD91rFdFiID5xWyxZghHhEPVh8ePDBAqJkO+Rx4/mrxRZol6I5DHHctEKxYOoTDK
	M/3Pivcr5vP7MKG75pSvQPMIjZDbn1v/oJadYgZ1OkY0wEg72RX6nIiyMeZnDX9a
	4vmIhvyAmMM5PcuzaBwLx8pg+GBHxe+XqTg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8826h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 08:39:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c98136ceff4so4891856a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 01:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783327146; x=1783931946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JOjxCxm6f36YUPcmZ/Wy0SceUz4YqGAp1Gle6QFSgq4=;
        b=gACQ0JVUWBQyXehTe9Et3lEfHu4tz+UJ5cSc8Z8H2ul5iwXfe34DxAoW9Gbc4/Xa+H
         n5orSDs/tgwP6r+jowceo0yn1bW1lkDSzJtU+IZpHApHILaYlvMbwQVZVKyAg5IUcV3Q
         8mHjzrRSoL4MSzC3zPST19rY7Cd6XGxIJzk5xJjkvPRgnHM8+5oWVQE/Hv3AI7AxpeKl
         ijwCEsyFbi6TqV3Ppypataa5sD1KK53A6N3qxwjahmNrGp1wZ6MkJNjFAORshea9umz6
         yMQ4Zz4y8/4QW63GQ5yPFbp4U5rTEWuUPIIrqB1e6UN9QXXjEJQZBSaugSI6jrvCfHDy
         kgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327146; x=1783931946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOjxCxm6f36YUPcmZ/Wy0SceUz4YqGAp1Gle6QFSgq4=;
        b=JFY7r3ZZTjDxFdzXI/jZt4drsQtVF+PVFDRG9q1ON1oCvgbF5kYUFpbg7i4XDuUiQM
         f6cquOK4+IjyDk864g+5346rQ7dusT+8AsZ9iv5dzTdp/o386UP4bTHyRDIezEByOeIB
         7SBtFUlxFRJm9lOc8QJqxd9969u5qYbUQDUIB2Z9+y8x/VsFgEBQvlTAWD5/yWuWREvt
         3VLBuo3Qvc8sAa5/rDe3pvgEJd5MNUKyHOR4Ill2kRNA3NuJBSDPVmkmZh4Q1tgufYX3
         +uQNK3dgaUm6Ph1i8JZK8c7JdAym5a4ObeXhZ1q0E3KjJdi1XeDGupUPwjiewZ1hBdUX
         BNlg==
X-Gm-Message-State: AOJu0YzB9R1Cr2X0QDPt+Do1vGDw0dGBWNdSe0Lc1mSy4+iNQsnZhSFl
	wfvxaW4HdSCYN1Yh54gLAdzEwvhkAcCq5PtPJLkSAYx2CnqALiiE2wXgy0qahAd/SCxWfxSERPz
	OGi8a9WBPRNy5TUIno36tb5lNw08fJ+2SnY504iAZVZsHPi/IIedZOXJcA+B5ApWRR04F
X-Gm-Gg: AfdE7cnlagmFXjn/RBWzUHEaBFxojZVExVqvY7aHtzf6EtfPrwxayDc7D2UE7yv6Pit
	T2XTf2LJD2RADB8l+czOkn2EmqgQ7mtKSy+UKNw0jq270WcHVjV4esHLYDSkYUzEPWRbAxgjtnC
	C9u8n6X+inDE1TtRlI9MRz2ZFw/SWmzHp03A5KKpdkYEMKVcTsjNFjqAk1ZiAuVLoWsK1sjyzin
	/g8AzhNQ3dOCje4AVEVBpZ8c31t58tnV4plSeFlfIZVC65DDHl9rYXvi6q0fv8WFOJ65pOpc0cg
	CzRjwhj0gT5S9kDIsqt6JhQQrVVIINoVi0uvB8i7+TcJTSMf+XQhKyfAhhp94gT75kSpTW1YuA0
	CuaksAREIUIfiu7KL5jBIYxOcrlBuVb3gIy7QbNBKEsOBJ0bARG83JGDDvRTR3fSnzcE+SWbmO1
	PkWwBaTdKKCKiziarVjh+k8oB5V8MW8Fm1Um8x
X-Received: by 2002:a17:902:e78f:b0:2cc:7d4a:3f5a with SMTP id d9443c01a7336-2cc7d4a4716mr64754275ad.20.1783327146334;
        Mon, 06 Jul 2026 01:39:06 -0700 (PDT)
X-Received: by 2002:a17:902:e78f:b0:2cc:7d4a:3f5a with SMTP id d9443c01a7336-2cc7d4a4716mr64752965ad.20.1783327143695;
        Mon, 06 Jul 2026 01:39:03 -0700 (PDT)
Received: from hu-pshashik-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25f92sm45656925ad.9.2026.07.06.01.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:39:03 -0700 (PDT)
From: Shashikala Prabhu <shashikala.prabhu@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, cgopi@qti.qualcomm.com
Subject: [PATCH wireless-next v2 0/2] wifi: cfg80211/mac80211: Add Max Channel Switch Time (MCST) in channel switch started notify event
Date: Mon,  6 Jul 2026 14:08:58 +0530
Message-Id: <20260706083900.908140-1-shashikala.prabhu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfXzB05+5NamFaN
 27qL3HnglpXm0/8Q3jniYHz5YHhvn/iCFEUEqz5xfC7yEnBK5XpuZiP61G2xNCJGPg2/9X3zvd0
 pYQ7ntuTFjlRzIxiSSgqaYTGQZgUXAo=
X-Proofpoint-GUID: FJHtbCr09WXKm1URReBHiQrdMlt-Sz2A
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4b69ab cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=7hzyat0Z0xvXN-skQlgA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: FJHtbCr09WXKm1URReBHiQrdMlt-Sz2A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfX301+3s0OZ1l/
 e0k8FRPw+Le6T9i5oeddMe8+iXm3bqh3EubLuoEceJCk7YCPcbWyXofzDx+eK2G3AnkNxeyI6zY
 fJPVAP1L8d49fygNdeGMidxTQjOPQSiAMwhpt3ESrJ2r6+5RfjwV1Lvd1Va4w6AJrApvkS6jhs8
 Jv9MFQj4klL++gTXoBgnrENTN0ESrZC1+sRJRBI5Ubeq0kJwUgAMEhuDSP1R0eq3OwRax98Y0Oy
 N5ZuYaPb3FH98/+b0fuXMvdyRk94g32NW71FNpLVa9LogETw+F83VNM4Bhh+VERQ/ppCpH7g50x
 0OUkpx7KtNFTmqioFiQEBN/R8YMKtm8lUjDQyLubehzW5CLTpQplbOpC75G/xoNLT74Tp/egFNB
 06Hq8At9Wdct1ElkgewTiYLaLrTzVVlYzUieVZEuG8bOlfmQlzu2IEbCKmU6mQSWUcX3TUfJRWY
 dIvn3ra5WKT4KJiEXLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060086
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-38657-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D51B870E66A

IEEE Std 802.11-2024 subclause 9.4.2.216 (Max Channel Switch Time element)
defines a Switch Time field in the Channel Switch Announcement (CSA)
element that indicates the time delta between the time the last beacon
is transmitted by the AP in the current channel and the expected time
of the first beacon transmitted by the AP in the new channel.
 
Add a new u32 nl80211 attribute, NL80211_ATTR_MAX_CH_SWITCH_TIME, to
carry this value in the NL80211_CMD_CH_SWITCH_STARTED_NOTIFY event to
userspace. This enables userspace to decide whether to remain connected
or disconnect before the AP moves to the new channel.

Chandru Gopi (2):
  wifi: nl80211/cfg80211: Add MCST value to channel switch started
    notification
  wifi: mac80211: Pass MCST element value in ch_switch_started_notify

---
Changes in v2:
- Reorganize the patch to group nl80211 and cfg80211 changes together.
- Advertise NL80211_ATTR_MAX_CH_SWITCH_TIME only for STA and P2P client
channel switch notifications.
- Addressed review comments from v1.
- Update subjects and commit messages to reflect the revised patches.
---

 include/net/cfg80211.h       |  4 +++-
 include/uapi/linux/nl80211.h | 11 +++++++++++
 net/mac80211/cfg.c           |  2 +-
 net/mac80211/mlme.c          |  2 +-
 net/wireless/nl80211.c       | 13 +++++++++----
 5 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.34.1


