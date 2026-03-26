Return-Path: <linux-wireless+bounces-33984-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBcpIXVnxWkn+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33984-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:05:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E40338E3C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BEAC30E6404
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0C641C2FE;
	Thu, 26 Mar 2026 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ONSVDxq6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743464219E4
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543660; cv=none; b=NcM2i7N/eHltJKZzLRBP4KRF26aErJeGk08CPAKFOUxCCJa7ciJcRa/zZAgY6EplyH8Y3eB4L5xeNoGjBvLvfFUGxbAMvdCO4pt8apHpTZQL6ZUt5gm8gJ3rLVwlnskQZDM7q9neSAs+RT5RdxaRN3zQTQ1yMqBFP33OppfFPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543660; c=relaxed/simple;
	bh=1mrnVRbKyoY6lU0Tyh4H8nsmADdOXps0aWgAX7cXIA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vyta9guS56VeYmtJCKkhGRdnw9EjO7drCxPuv79NYEnM9E0xow+dStzvv+bwUgbRT6/u88mJmhRRGxVWnXuFkGV4NAAkiJe103t2gNMJ8m6EfdrJ4sNwP3nd9e0g5gfCPO3GHlBubTCwny+KGcVFVe71qYxQDxwFj7l4Oa7hzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ONSVDxq6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9sn02451576;
	Thu, 26 Mar 2026 16:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+CzP6SPhrfGJfmtvitWUu5jbXr05+nl1i9E
	yGCGwDYA=; b=ONSVDxq6RGaP5C0UuLi9JmGp0ISdLgUjcvQTaZTd45ipT94xqCM
	mT+C/Xi4M7H0dW0IcG/gY57LIbMD2BVp0datZ7lcm+OGjTcbXXB7W2xkvr3ziIz+
	cVPJnthDjCCkxekOKnOJGho/iPQNyVDhIJ8U+9Lf2kZGZvgeSMSK9JBy55XwaAEA
	mA8JG/u/DfnXsJL1zq4acC7Jrd8V10vkWGG7GVGtwlCwxp+gQSFWRusSD8otZZLP
	FLbNMVfZ2zlJXCn/z/fTKuJarwh13qeIknLOyoEeWu9JJn08sFf7vTDDF3iSYJGZ
	6bTxziyGCHAa/08JadKeFNne3o1RVVPG+2w==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q1t3pxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:47:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QGlR7d010527;
	Thu, 26 Mar 2026 16:47:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4d1mdn6sk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:47:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62QGlR7n010522;
	Thu, 26 Mar 2026 16:47:27 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 62QGlR9P010521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:47:27 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id DBE2B417A3; Thu, 26 Mar 2026 22:17:26 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH wireless-next 0/3] wifi: mac80211: Enable MLO support for WDS/4-address mode
Date: Thu, 26 Mar 2026 22:17:20 +0530
Message-Id: <20260326164723.553927-1-tamizh.raja@oss.qualcomm.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=e7cLiKp/ c=1 sm=1 tr=0 ts=69c56325 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=5OdqSBBF1fRPrwlLa5AA:9
X-Proofpoint-GUID: t6jvImFHayIGkTvHCIZsKRlSNMjttq63
X-Proofpoint-ORIG-GUID: t6jvImFHayIGkTvHCIZsKRlSNMjttq63
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExOSBTYWx0ZWRfX4rONXnVdaaqc
 qMT9dvoo6d3jz1n5jsdyD5oGaW28wYDZripqn5eQ/BZ/C1v08hBhHsaVT7aNsUKXR8DAjLgdNni
 cb0JsXHxAM25+b6c3vWcE3+evb7yhInL9YpE+EtwuE/H4sQyPvWJ5hdxvA6Ty8mVPs9XUCGwI6h
 /BNn+zenx3MF9tBLy1sD/hU9i8s1B9a4bOcksJr++cHKBDUCNVbio4CWnabqVI9ly5RWS3G7K5L
 yyOy0RuGLvdC4tl6Uxf7odxEWm6nYygSDJtZaTKKGKJKX4q07Abzxw3fA6spYebUBA8Xm7VspAG
 +OGpNmV3meu3rkklGi5CqZVb79I6qdvx/MM0e2VqQICtYFRNmaMN+ED9cQsvGTpUwWLq/01qTi9
 NsKRwMhO65PLDBVJIaWFDgi6xOZxTfIRSwCcIt2lJ29uP3iKGydOtLVUYymLRgNdqd+AMxzAlKL
 iShYq+6ngAaZWbQY6TQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260119
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33984-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 84E40338E3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series enables Multi-Link Operation (MLO) support for 4-address mode
(WDS) interfaces in mac80211, allowing WDS stations to establish MLO
connections with capable access points.

The patch series removes restrictive MLO checks in the bring-up and
connectivity paths, allowing 4-address mode interfaces to initiate MLD
bring-up and connect to MLO-capable Access Points. It also ensures that
valid links are correctly propagated to 4-address AP_VLAN interfaces
based on the master interface and station's link capabilities.

Tamizh Chelvam Raja (3):
  wifi: mac80211: synchronize valid links for WDS AP_VLAN interfaces
  wifi: mac80211: use ap_addr for 4-address NULL frame destination
  wifi: mac80211: enable MLO support for 4-address mode interfaces

 net/mac80211/cfg.c   | 74 +++++++++++++++++++++++++++++++++++++-------
 net/mac80211/chan.c  |  8 +++++
 net/mac80211/iface.c |  7 -----
 net/mac80211/link.c  | 43 +++++++++++++++++--------
 net/mac80211/mlme.c  |  8 ++---
 5 files changed, 102 insertions(+), 38 deletions(-)


base-commit: 7dd6f81f4ef801b57f6ce7b0eee32aef5c488538
-- 
2.34.1


