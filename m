Return-Path: <linux-wireless+bounces-36873-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD/EJHUvFGqUKgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36873-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:16:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E63595C9D55
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89C8B302A6C7
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1522F37CD35;
	Mon, 25 May 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVftKGaC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3937D100
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707406; cv=none; b=ETcCxRHipGj6ygVX6wqEqXfNC2buE7ZQCBvUYKYB3uRgCC8oNyPkWHyAUEucpGO6Y3cth2on4ykz6MfY4UXii4EdIgXgZ+85nEpT7BPUsBkhwzJtOc85BnH0NkFm3tSMytHBFkJAIr7sElEc4t0fa4Aw6mfuXlCRnDA0VM5pnfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707406; c=relaxed/simple;
	bh=lc1neAJ/doRgnoTNkBeuVXCeu1hIthfBd+GiGLa5d+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9nzSHNG5X4ijFPrjBb3PkAKpb968uPT7hylPq5622E351eOR2aqn2XtiJIgcGVQw5U5EQfs4gmlKxH5lwWxZayX71bzrrZSDDwuTB1K1NEIsMR6RNqFjYFv71d3X77RNCsGOgMQySuMH2yfkq9tBvoXUDpIByEQkpmS5MvsbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVftKGaC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P6pw13388786;
	Mon, 25 May 2026 11:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=F4PjlBgTJ4J8WS/jI+iugHRwYZi7DDg+KmK
	YY0s7w9k=; b=jVftKGaCdmDjokJeSJW4WGiYVmL/QQ784dEIcrZJPzWDaUsA0Af
	ZCqLybXFHxALR2z7iViOVrlzDPE8H4z7C2+MD9TpvmBh4UJ+VbiWVXfkNQxBehzk
	TvUIvijWzppOmoMOPUKk9nASCDYq1kZXJRADcBYe7LYZAgI1a8F5wQrOVz3pQbyD
	pW39YJn/YGw9oB3kK+khETXN9vac42fdnfLXmq079xDeukqs6LxoStvML75VkhND
	Qaol2IZUOTIaWWH84AlhyMCisvshmuxMuEWsf8WkKUsWa9FwuUCegv1lLSr0JGzG
	jLB+vam4zMbbv5G0JE77VvcdDct4vbEIjqw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3eb6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:01 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64PB9vCO025757;
	Mon, 25 May 2026 11:09:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4eb5ajfbx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:09:57 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64PB9vaD025752;
	Mon, 25 May 2026 11:09:57 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64PB9v81025751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:09:57 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id A81EF4195D; Mon, 25 May 2026 16:39:56 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next 0/6] wifi: ath12k: Add driver support for WDS mode
Date: Mon, 25 May 2026 16:39:36 +0530
Message-Id: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: rC1xd4wveoyZXwIz6NMKUf1Av2ldIlnk
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a142e09 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=gUSijwvDI9inCNw2KXAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDExNCBTYWx0ZWRfX/JzvOJ1xyUBL
 6DYG8kHXP508/q4z3kB6QmvzowKUH4M9iDDd0JJW4LqESsvf4oYzQQlZrn7u47zmVgEbyWL8v1E
 Ihw3YkLOTUeHBOeeks+YWQ1bXsri4JDMJ4YdZzGh8jCPiV6n3gnG1R4HLZJlczRfVJNGmDSHxoW
 QO+olY2XJvSGwXqcMotz9zVB4GsFXxAHC7MZOOmuENwdGhkcY7yODvvXMB3dIT0KW6rOC3WIExF
 Q1ECcU9m+kP/ImKRghBerqCz4YT8UeD8vt5aL7MIQZEMnnL3LsQIS67USVSTapKg56JnkApR1sa
 2HlF4Y6hUri6NuQdfgBySmfjFr+D8g/WtgZpZsdaFu+BjiEwytzxmZVxE034iE602e9QIiDMRmu
 TGA+bH0n64ZUnCmK4jZyYk4do60LVLf0TBm/4UZTKWQHx5V1M8ZYztTMW88oswueCDojaLDYpOt
 p2xjURaIuyfv0glAYjA==
X-Proofpoint-GUID: rC1xd4wveoyZXwIz6NMKUf1Av2ldIlnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250114
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36873-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E63595C9D55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series introduces support for WDS in the driver by adding
below changes

Handling of 4-address frame formats required for WDS operation.
Proper setting of peer 4-address WMI param to ensure correct transmission
and reception of multicast and unicast frames in WDS mode.
Conversion of eth offload Rx frame to 802.11 frame for mac80211 to
detect 4address frame and initiate AP_VLAN creation.

Tamizh Chelvam Raja (6):
  wifi: ath12k: Set WDS vdev parameter for 4-address station interface
  wifi: ath12k: Add support for 4-address mode
  wifi: ath12k: Add 4-address mode support for eth offload
  wifi: ath12k: Add support for 4-address NULL frame handling
  wifi: ath12k: Add support for 4-address frame notification
  wifi: ath12k: Handle 4-address EAPOL frames from WBM error path

 drivers/net/wireless/ath/ath12k/core.h        |   9 ++
 drivers/net/wireless/ath/ath12k/dp_peer.h     |   2 +
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  10 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   3 +-
 drivers/net/wireless/ath/ath12k/hal.h         |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 124 +++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h         |   3 +
 drivers/net/wireless/ath/ath12k/peer.c        |  11 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  91 +++++++++++--
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  41 +++++-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   4 +-
 .../wireless/ath/ath12k/wifi7/hal_qcc2072.c   |  16 +++
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  16 +++
 .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |   4 +-
 .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |   1 +
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  16 +++
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  18 ++-
 drivers/net/wireless/ath/ath12k/wmi.c         |  47 ++++++-
 drivers/net/wireless/ath/ath12k/wmi.h         |  17 +++
 19 files changed, 409 insertions(+), 28 deletions(-)


base-commit: 30d516006fa1f72f957c18c6171f5680dcdebfb0
-- 
2.34.1


