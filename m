Return-Path: <linux-wireless+bounces-4824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4099687E327
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 06:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1630B20B74
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 05:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7531E20B34;
	Mon, 18 Mar 2024 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cqTQW3m9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD4200C7
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740200; cv=none; b=Y6CEPZP6Ve860RgGOOBtvdchzFWxLSRALkTpViAO7VDJDvx4kEXGRNiAZ3n3wAD5YJsY5cQroxuDDpP2qXKYVMlcFKNmbuK7I7kznGbrGhyTuiCHwv33jg2dWU6ogDcbmcChksb4v2OPewSEkd4z522csqusCDiuO7+Bq+hs2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740200; c=relaxed/simple;
	bh=26WDOsoQQFmzIpkDJUSsBYq+hwTwjg+DGDMAyNCA3J0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qt9ejHaFmqVQp6DJL4Ziaw413cahdtF5psSul0OG+fFuQrhFYzKIk0mk7+urP15zLY0hI1A/RXSurQc2wi4B808RcWADG4YvjJIoe8YkqIvrvOFmGChlqFeFMZfMYxSQGpm4Md5uUKehlRDQJ87/d2y/ydHtVxJLkPF+5hDMBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cqTQW3m9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42I2PExM000520;
	Mon, 18 Mar 2024 05:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=CxLJBn6
	5moSuiffvFsewAP0cWTjzjESvlMN6WyV3cM4=; b=cqTQW3m9+W+8AmiXS4kb6Qt
	DxnTrrVgBrqH8nUNElfgzz7wDINlYBm5PH4Gf161IInP9mOJP9iZVfQeVLirLn5t
	kNc0iALBmQNjZLL7WC545Vbdky8MrDLWqRR5z/ovu1WxSliJAdtfIv6wLbwxvIYq
	V2PwgT8seEpUadxwaTADu986ihAHoVyM3ODpqeCC9qIcalj6AS7C3F8il0NcYSmZ
	BTOdrifcFBNYC53it4eL5TBKVQzibaE/Ozo6ESzhLemuQq3jrnMF04N8aK4GIW8B
	vqulJVy+zc6Drs1ybzGhGcNdHvspjsmzTsABSV11MRa/3ewjy5c0UtMCMxuLZaA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wwxta95b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 05:36:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42I5aPVE014164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 05:36:25 GMT
Received: from hu-rrchinan-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 22:36:24 -0700
From: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rathees Kumar R Chinannan
	<quic_rrchinan@quicinc.com>
Subject: [RFC 0/2] Handle BSS critical update procedure for probe
Date: Mon, 18 Mar 2024 11:06:05 +0530
Message-ID: <20240318053607.1056739-1-quic_rrchinan@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nk9x_sVHLUe5mwMkxQCLHrcUuiOXPbd_
X-Proofpoint-ORIG-GUID: nk9x_sVHLUe5mwMkxQCLHrcUuiOXPbd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=662 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403180040

When a critical update occurs to any of elements inside beacon frame, AP
shall increment BSS Parameters Change Count(BPCC) subfield and set the
Critical Update flag subfield of the Capability Information to notify
client that the critical update occurred on AP. Refer section "35.3.10
BSS parameter critical update procedure" on IEEE P802.11be D4.0 for
details.

On beacon offload case, change in CU parameters should be sent to user
space either before or along with probe or assoc request frame receive
to ensure that user space uses latest CU values and BPCC while generating
response to the received frames. So, add the critical update parameters
as a new attribute to existing NL80211_CMD_FRAME command instead of
sending this on a separate NL80211 event.

Add an ieee80211_critical_update() API to send the parameters to cfg80211
and call it when event received from firmware to update critical
parameters to user space.

Driver (ath12k) changes that utilize this will be posted in the future
versions.

Rathees Kumar R Chinannan (2):
  wifi: nl80211: Add attribute to send critical update params
  wifi: mac80211: Indicate ongoing critical update parameters

 include/net/cfg80211.h       |  10 +++
 include/net/mac80211.h       |  13 ++++
 include/uapi/linux/nl80211.h |  98 +++++++++++++++++++++++++++++
 net/mac80211/cfg.c           |  35 ++++++++++-
 net/mac80211/rx.c            |  12 ++++
 net/mac80211/tx.c            |   5 ++
 net/wireless/nl80211.c       | 117 ++++++++++++++++++++++++++++++++++-
 7 files changed, 288 insertions(+), 2 deletions(-)

-- 
2.34.1


