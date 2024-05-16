Return-Path: <linux-wireless+bounces-7728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834278C7039
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 04:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100CC2839C0
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 02:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5AB10FA;
	Thu, 16 May 2024 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nLtKFNRL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A30A4A12
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715825959; cv=none; b=JMNjdVZq6zkEc5HVIEWyuXM1GBvVOwOesFUknLIRSr8vetbDkrIFbeGWYp/1ZFirV8DIKPgV1U3wg+p9ZNgfbZ/rzohXShFFDyv9wx+Fkjkpw54olKdvWNU6ws5ComML1t2E2pSP2r+3ugfsUqsQb0dCAteOK2JNDO+QI+mdw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715825959; c=relaxed/simple;
	bh=BOO7EahpWnjemPHsQ40SZrtlJRc9PuFYcnB1Fiap7/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=imNU9eXUUNCm5jyhuZBhT1oA7P6643L2gQEdv4whA1ICAsQ2AUZ10QsaRSzaStjm4GtpypJF96iK3ZqvmpkCG/QUQ30jG/wiqm5N7w15qUQZrrmT1LcGdadgJEl22gjTNvrRPli89gHDZpuYa8CZOClKlbmJdLGfFwz09JjHUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nLtKFNRL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FJY8oA027363;
	Thu, 16 May 2024 02:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=MJft9Fv
	IBqGBBJP6BCddWa2Bjnq+mBWbVZRdd8qhDh4=; b=nLtKFNRL8ze7WzZiRkAKnkT
	XXU6RoT7NPpmnCKA0K6SLx6hLaTX0NnJwX5yor/TMovM+sLqN9lXVW6VWbI6Rfjp
	O7VIJN/QtDeXRMSIqWR2Y1BwV90+YKfelfwgU6ba3InuCeezIEhTNf5SUSWS4eZ9
	vqO4s+8mCuk5TEFb/PfXB1PlzgnJxiQLR64p9GQzTyghJgNZAFrA0UbwqWxjdtik
	j5VJTCaGkiTAtqEMEFW6fLyKrDjYBX8Ex0bg6GXndqldrz3GFALuszeTSc/yb9MG
	K8vwuawuXbzk7DeYeb62njfc5CkME61pC6MAmAwqd0t+PWUM4V70fswGQchkZug=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y42kvw229-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 02:19:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44G2J69S029415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 02:19:06 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 May 2024 19:19:04 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH 0/2] wifi: mac80211: fix some issues about Spatial Reuse IE
Date: Thu, 16 May 2024 10:18:52 +0800
Message-ID: <20240516021854.5682-1-quic_lingbok@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gq7qkbAXzeohu-LEOReaehc_5SBwJnDM
X-Proofpoint-ORIG-GUID: gq7qkbAXzeohu-LEOReaehc_5SBwJnDM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_01,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=914 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160014

Currently, the way to check the size of Spatial Reuse IE data and parse
Spatial Reuse Parameter Set element are incorrect. Besides, some members of
struct ieee80211_he_obss_pd are not assigned.

To address these issues, change the way of checking the size of the Spatial
Reuse IE data and parse Spatial Reuse Parameter Set elements in order.

Lingbo Kong (2):
  wifi: mac80211: fix the issue that checks the size of Spatial Reuse IE
    data
  wifi: mac80211: correctly parse Spatial Reuse Parameter Set element

 net/mac80211/he.c    | 10 ++++++++--
 net/mac80211/parse.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)


base-commit: 5b501f801ab443046d5c31881bba21350396e5c5
-- 
2.34.1


