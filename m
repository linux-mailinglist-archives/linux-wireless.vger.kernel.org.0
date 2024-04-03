Return-Path: <linux-wireless+bounces-5836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D668D897519
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 18:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904242817E6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F0014F9D2;
	Wed,  3 Apr 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lI4VHGPI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343EF14C5A5
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161391; cv=none; b=AsjxGd2XHY2E1je/JyLU8lhCsMVfakvrG6EfLPS2u6MRBMviE0RlFMg1p2wIB+rmJQH9i6opJE+eZNqNKt8vZmTWzMLTGenNEHFeLVf2AM+eq4tkack58c3vZ9h5YMvXTqTR7WeoXv7P0LdtoXjhUFw42tss9dmErK4iEiHXOjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161391; c=relaxed/simple;
	bh=qLj/ewjY5fbX9J2zurxPR1GVjjfzgFYpGTVS99c6mRw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BNon42zS8xYHvZmoJ9q0bPZ/QXg5bErJrXHiwTxc013Jl7mm6aiBuPYp8pT8Y4JaEAnhV/d4BNgTyzjpOPvysR4AhNKmDh2QnMr07kvdPsjAotB0Zm9+j6B5bBmXct57VRlkYh1L+68aQIX2H1CUuLOQOUqwid+lNLivX7vJT2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lI4VHGPI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433AbnMY022474;
	Wed, 3 Apr 2024 16:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=lgI+0B/
	FFy8UH6pkGOSVvTpmVj1c0sME7zN5qz2Kg6c=; b=lI4VHGPIB99QbkK9PFu7Mbs
	ILWjd4aqkaMI+OQC6H1tUGMGebqcEZlQJx41TbfYvlvo1FUTPgFbDRzgW53ncsHY
	FbmLOTvKHkzidpeziHz4sSCnR4A8arDvZ7AYm8CExGj5f2UvlCaVeTJ8oS/rdiVj
	7qS8/zmFCKzNC0wLatokzRyjWWal8/M1WnjJ5ZMZTo5iY6iK1a3NTcfWasbuZRHH
	7CeuqOXVS4jldYkojarT/huKpprF7gUrmhAieYQ2QYSoTWIL90l6T5m8ZYuMkeOv
	Sl5Extz4SYO7rXY6XPX1bRE8w+n2e+kRwtEzvRCa+/kWN6ijJh5pFDFeyZpojvQ=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93pw969q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 16:23:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433GN4A2027445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 16:23:04 GMT
Received: from hu-rrchinan-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 09:23:02 -0700
From: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_rrchinan@quicinc.com>
Subject: [RFC v2 0/2] wifi: nl80211/mac80211 Handle BSS critical update
Date: Wed, 3 Apr 2024 21:52:23 +0530
Message-ID: <20240403162225.3096228-1-quic_rrchinan@quicinc.com>
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
X-Proofpoint-GUID: 23c1QFNnY9-o9RxUt85Z4yP-8Vn9ZjZI
X-Proofpoint-ORIG-GUID: 23c1QFNnY9-o9RxUt85Z4yP-8Vn9ZjZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_16,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=734
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404030112

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

Based on the suggestion received on below link, add extended feature
NL80211_EXT_FEATURE_CRITICAL_UPDATE_OFFLOAD flag if driver handles
synchronization among all the links and update critical information on
partner link beacon for AP MLD and user space can update critical
information only on impacted link beacon template. Add this critical
update attribute on NL80211_CMD_FRAME only when this flag is set
by driver.

Link: https://lore.kernel.org/all/df711a5978b84856a54953a32e4b05923b48870a.camel@sipsolutions.net/
Suggested-by: Johannes Berg <johannes@sipsolutions.net>

Rathees Kumar R Chinannan (2):
  wifi: nl80211: Add attribute to send critical update parameters
  wifi: mac80211: Indicate ongoing critical update parameters

 include/net/cfg80211.h       |  10 +++
 include/net/mac80211.h       |  13 ++++
 include/uapi/linux/nl80211.h | 104 +++++++++++++++++++++++++++++
 net/mac80211/cfg.c           |  43 +++++++++++-
 net/mac80211/rx.c            |  12 ++++
 net/mac80211/tx.c            |   9 +++
 net/wireless/nl80211.c       | 123 ++++++++++++++++++++++++++++++++++-
 7 files changed, 312 insertions(+), 2 deletions(-)

-- 
2.34.1


