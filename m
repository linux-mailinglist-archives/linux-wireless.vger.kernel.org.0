Return-Path: <linux-wireless+bounces-2475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2788B83C2EB
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 13:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D361F23A89
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 12:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9F14EB24;
	Thu, 25 Jan 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YH7aEVCV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F001EF1F
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187558; cv=none; b=fBxmWWppmz455M0n3qZbS7nqFnsL80YiRXYo9kr6O0DnbCOMYKt6GzDTbh3k2P5iM9TIgb3+exzXM9pWXD8FoWwPugBPNgk5b+v2w2jgIRvxmkDrJn7CXPEUTL+9KwHg6eZuI95LZ6cek1hMMIf1KkcCq9cIBW9boqxiRXRUb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187558; c=relaxed/simple;
	bh=pFgxJjJbnp0YLKAjOwfUw5bHtK1ARZCYwZVAIifnTzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PUBcjzimn7uQ5ptKdxuKyzkaIGaZfKp6mpZGHl+zUNODDlh+0LWUq9SNkmM0rw8nyKBN2N1gq/pB3HEWam8xDY7Y5fZFOCunlhwNdrGYKJBWeoc03Aba6D2l/UzK0E6rhdzufkHOUWZs8NRnr3ZbBu3pu5sctofDZEuVZzTGrXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YH7aEVCV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PBsDft017822;
	Thu, 25 Jan 2024 12:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=j5R7vvd
	coSYowHa6GzIzCCZR6J/O1SdEfcFvAMYL6ck=; b=YH7aEVCVkOAYkV39wVs770d
	v6X5DPpsqUG4nSqPk/25T1H20wUllPbL23PuFaZjfAZLB3u7P3bfUsn36EyxhVuJ
	RfGdRWcCi3o6M/WpFxUjlCcxbZOMLLuC2u8ZDGjR0j7MMuzMV9Q6jX4BKW0lg/aY
	yvL+oOIiqSENwYO3A+zrWSVdjwoeAe0PBPBrDjCW+TR6e6pxaP/rJxB8xSQ/WpL7
	JykFkPnDh7SQKyLenqm+RaIBYK8x/IOIFyTZzHKR5mgGJJqE+261zhqzACUI81ec
	HR87611YQw8NNWVMXHeV2XFZ1PqAdf8ykJftzVN0hyxU3GHpyBNZ7RN0tMNpqrg=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vufk99bra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:59:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PCxBI0025860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:59:11 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 04:59:09 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 0/3] wifi: cfg80211/mac80211: add support to flush stations based on link ID
Date: Thu, 25 Jan 2024 18:28:48 +0530
Message-ID: <20240125125855.827619-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rNfHnv-woI_xyFEGNIG5VB1vdrofbp9n
X-Proofpoint-ORIG-GUID: rNfHnv-woI_xyFEGNIG5VB1vdrofbp9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=241 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250090

Currently whenever sta_flush() function is called, it flushes all stations
connected to the given interface. However in case of MLO, all the links
would be using the same interface and hence at certain cases flushing all
stations is not desireable.

There is a need to flush the stations based on link ID. This series aims
to add support for the same.

Currently two cases are handled - 
1. During NL80211_CMD_DEL_STATION command handling. If this is called
   without any mac address, all stations present on that interfaces are
   flushed. More details in the patch [1/3]

2. During stopping link AP via ieee80211_stop_ap(). Again here, all
   stations are flushed. More details in the patch [3/3]

Aditya Kumar Singh (3):
  wifi: cfg80211: add support for link id attribute in
    NL80211_CMD_DEL_STATION
  wifi: mac80211: add link id argument for sta_flush() function
  wifi: mac80211: remove only own link stations during stop_ap
---
 include/net/cfg80211.h       |  3 +++
 include/uapi/linux/nl80211.h |  3 ++-
 net/mac80211/cfg.c           |  4 ++--
 net/mac80211/ibss.c          |  4 ++--
 net/mac80211/iface.c         |  2 +-
 net/mac80211/mesh.c          |  2 +-
 net/mac80211/mlme.c          |  2 +-
 net/mac80211/ocb.c           |  2 +-
 net/mac80211/sta_info.c      | 20 +++++++++++++-------
 net/mac80211/sta_info.h      | 14 +++++++++++---
 net/wireless/nl80211.c       | 18 +++++++++++++++++-
 net/wireless/trace.h         |  7 +++++--
 12 files changed, 59 insertions(+), 22 deletions(-)


base-commit: acf868ff60b1cd1f2e597f0b15aee2ff43f9fcd3
-- 
2.25.1


