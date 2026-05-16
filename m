Return-Path: <linux-wireless+bounces-36514-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEN6EHybCGoGxwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36514-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 18:29:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B1755C9BB
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 18:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29225300E5EA
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E583E833B;
	Sat, 16 May 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NGOaOKbe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C43E8324
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778948981; cv=none; b=MFckLJ1i4Z1YAqh5U4xNyzcIUqJTz2SUmjtRL5YnqIuuersFejJiGAlkXkRO2Zx01Hc0Jcb+/aSy5Y9vX3eotiDB2+ooaKHtayyoNLyP+nTSiXUSjXlpM3mMqzhK5Unc7jSvGpwBE3cAo0Bar5k5Y/6pnZfZPKll0OnUX3OmAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778948981; c=relaxed/simple;
	bh=7dSYdBM1F8AqJo+MA3hJ4ysq+lLD24T0E2i7yUMhXQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JCsNGYk+nrQeFWKaUgVo+ICgDAf0+bfpwtfnjYwwtVN3k559Z3yZXSMrO3OKWkzX3G6/iVkU7AlAOWyHn4Q/aYe3sqDOiriJ+LqCStBdt36o1dkpIlpUKy9E3hLgA3LOjDzgKyFJXAAqu1JpiYkfVaYajveglmbrdci0/kGuQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NGOaOKbe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G3kJQd3847386;
	Sat, 16 May 2026 16:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eWHiWvaKGBWB4Zlp0SwSbaSRtQ3Vxh3qbHb
	ERAm4jro=; b=NGOaOKbeHw94mQMKkw9ltAZ2BslJh3q3a7jomc9lSJkASE3Ixqf
	nXisJrPwVD+p5dkMKCc5vY6aFBBZNq0Km6EoVXMTx26ntYiqDClKLiLaVoXSIqlx
	8YT2TjqDXyDpyaNcUD+SL84Mf7X1qhMNfna0ix+ZVZf6F9Af4oe1ceVnJTGSxN8H
	H74m5UfPbp+kaRtGtakf2s8eQ/P6IzC3tzi6EhtJeDmKfPQOirWRACt3c0ZeJI+m
	uGKOSYGIX/jhhy/h/FaWLbZGN5BfYUerCfjhwNED7/5idIcWAlvVg8Ur+uxNRAss
	m4oQnzZwWaJjcnbbfK88Wj+QGz63xTy9MFQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gy5195x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 16:29:23 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GGTKE7016985;
	Sat, 16 May 2026 16:29:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4e6hnh5ymc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 16:29:20 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64GGTKW5016980;
	Sat, 16 May 2026 16:29:20 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64GGTKHL016979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 16:29:20 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id B79B241929; Sat, 16 May 2026 21:59:19 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH wireless-next 0/3] wifi: mac80211: Add 802.3 multicast encapsulation offload support
Date: Sat, 16 May 2026 21:58:57 +0530
Message-Id: <20260516162900.1981500-1-tamizh.raja@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Wusb99fv c=1 sm=1 tr=0 ts=6a089b64 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=k9boe5s0Preo3kyLpH4A:9
X-Proofpoint-GUID: st2acEe4gcyR6C0xtMOUoqbcr8GL_HhK
X-Proofpoint-ORIG-GUID: st2acEe4gcyR6C0xtMOUoqbcr8GL_HhK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE2MyBTYWx0ZWRfX7zkMM59BG00N
 CEdjeA9A6a2LafzYxdLRi2u/dksLmnnS+oGVGN4hSIlGBf/KMaZ5aZjbrPPpMhbRhdGP6wjEkBs
 YXqSrutWTWGx/JQtwaEAnItS+jalyVkwPVXrdD7QN6zLPiw15+g77coJM4+KBzZHN57B0MOFssF
 7IRGj2WE7Hy8vy7YVOJg7F428vR+W9lV2Z/rEg/eAOAkC6nwosE6k56lYgTWLIK3tZzY8ewT0vS
 bmJ8mH49h01GXSY7BbkbGaaceciPCP9btQ1yV/cBmvaHGutNWYCSA+CeG/j30LiMUhW2oOa54NM
 6j+1VfXd/jyqtdvvMezF+OrSd6m00wrYh7qnaUUMNaDu3ADq6SNVVFbZFSO6Acsu4XuSo3MnMXY
 IaokfEqkTv5fI9+RD8dTjp9YDBW0tocaEZB2TdQQFVTT4Ci33KQPV4tYxpLtU14x5EzPbQDYZ54
 BdZsRfLwMVO3JwlDREg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605160163
X-Rspamd-Queue-Id: B3B1755C9BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36514-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

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
 net/mac80211/tx.c      | 87 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 80 insertions(+), 11 deletions(-)


base-commit: 6a4c4656b0d2d4056a1f0c35442db4e8a5cf8021
-- 
2.34.1


