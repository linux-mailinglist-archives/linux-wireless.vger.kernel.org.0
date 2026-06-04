Return-Path: <linux-wireless+bounces-37393-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ko1tHUWpIWovKwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37393-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 18:35:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ACF641E10
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 18:35:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=P9Zm78Tv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37393-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37393-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7B1030A6DDB
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC5D47CC6C;
	Thu,  4 Jun 2026 16:24:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAFB48A2BF
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 16:24:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590271; cv=none; b=Poqwrdw1Sr9NBh6tJdnnaNJJOaceJhS0xhqh6RsXVuzoJuVZny06ceOMYPF7dmnfs3Adj3LkXELyjrRmRb3e1yV2NDfoZ/ywgSnY9ZOvsb0Zoxal3ftKMR+jn5uBCAHmkoIAXW656/E47sj/I8yvCPp0hrvmZGKeAywCk7qKch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590271; c=relaxed/simple;
	bh=DZvpXTBvJmQMQjAQYRAT7u0i1B8yODPMtFGoBCA606s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KHcl29hCXUu80LxPmoc4duFEQsOeGR1yPcKz2ETcGCn5Lgh6cnw/WKC56zAT6SsWSWaSto8VTuhnaKL41SbFUXUKMHn2TjsPO9f6D7FHaAlWw6E1/iZlZxkMZTlIQNLJ7fcP4mG3jHol3BIAwZKoO05tqH0L33xx2dArIsQwYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P9Zm78Tv; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654CPiQL2477908;
	Thu, 4 Jun 2026 16:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9AP3ucK8HyQMpA0IoJm7JX16o0UkCuxlc02
	e45Be4eg=; b=P9Zm78TvIuPJr5Gj1JXDm2pmpPiFsGVuPFNn2DM9DIWc+mX3FB+
	phHYOhbZOTAn6sYVnMxyWgRxtB2ucbj+K4egWIsL02vg7b9g6bSCZM2XM0hPtCf8
	FgvXYUdBBNmfA8hUVv9zk/h8fJWAGnhTWDxejqQFxWk+PVrjLiLMPduGjmpgozyP
	EtYGBLoTlhqfj3RzV/Cel9oRXN7oe89PIfb+5iKsELWFJOkhqYALnEfcx/m36m5v
	BYs+SYYdyClPF9PX9Ze76ag0DNbxnrsp7tYFuMeS7QxMKjQrA9CKm8EgJOk+/AnD
	RH88+YMkQNdZaJuURQ0beCTOWmi7ZNU483g==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek4hvjcgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:24:22 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 654GOILL020800;
	Thu, 4 Jun 2026 16:24:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4efrykcnm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:24:18 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 654GOI4x020795;
	Thu, 4 Jun 2026 16:24:18 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 654GOIlR020794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:24:18 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 5A00542107; Thu,  4 Jun 2026 21:54:17 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 0/3] wifi: mac80211: Add 802.3 multicast encapsulation offload support
Date: Thu,  4 Jun 2026 21:54:00 +0530
Message-Id: <20260604162403.1563729-1-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: Vi2vaK9W4fnGEXDW3oyAmx0vIpSiJkoP
X-Proofpoint-ORIG-GUID: Vi2vaK9W4fnGEXDW3oyAmx0vIpSiJkoP
X-Authority-Analysis: v=2.4 cv=Zp/d7d7G c=1 sm=1 tr=0 ts=6a21a6b6 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=k9boe5s0Preo3kyLpH4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2MCBTYWx0ZWRfXxdtIk3Txy7rt
 KO11J/62X/cDUMGhPZEVdb97i1SgZrfcXIe71VDj9kJdt7YMHilH0Ud2QLTam7LH+tbTyVz22v0
 YzPLHuUVGz31KoHNSYQOikpVDtKx1sbB/hHokg6pHM6N/OJv97Adk24V3nc61J0J6TH9czWoSE4
 btBcMMlaKVGMdq+iImsFJmMOm8jZGATkt9YreKSJk1eWbqfrIYvxStFTfvIVRbcmSwq1/8/HZoM
 omLOVZhaWp2VGscvdb82OOquosI1WJAi6k0cGjV29zfm1VS6CFwiNTJ9NztBRE5VDIPcjispYYu
 3g/XR4VkqBedWsfoGQ02UtSLq1saJAzPp7PrrdG0W+nmOPTwhSj2KvoNrsKlY5EruX/tzDDuYVN
 g2bC+d/pCvl7v2l6v+Gv00kUmF2x/kKZhIszgBhS3zO4eESY/1iCR0+/zWGAp6SqXunkpsAqKzN
 Zxe4vMzHWSJu8w76XvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040160
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37393-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:tamizh.raja@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:mid,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10ACF641E10

This patch series add support for multicast eth offload, particularly
for drivers supporting multicast offload functionality.

Adding sanity check to handle sta pointer in ieee80211_8023_xmit().
And add multicast to unicast support in 802.3 Tx path.
Skip 802.11 conversion for the multicast packets for the driver
advertising IEEE80211_OFFLOAD_ENCAP_MCAST vif offload flag.

Tamizh Chelvam Raja (3):
  wifi: mac80211: Add sta pointer sanity check in ieee80211_8023_xmit()
  wifi: mac80211: Add multicast to unicast support for 802.3 path
  wifi: mac80211: Add 802.3 multicast encapsulation offload support

 include/net/mac80211.h |  4 ++
 net/mac80211/tx.c      | 95 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 82 insertions(+), 17 deletions(-)

v2:
  * Fixed comment section and commit log in
    wifi: mac80211: Add 802.3 multicast encapsulation offload support patch

base-commit: a26c2a22e7e88b2b5afb1349f3994fc564c988b1
-- 
2.34.1


