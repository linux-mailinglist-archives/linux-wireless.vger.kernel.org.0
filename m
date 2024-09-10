Return-Path: <linux-wireless+bounces-12772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD7797443E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 22:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF711F218D3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 20:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C260F187578;
	Tue, 10 Sep 2024 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xze3ourd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9017622D
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001160; cv=none; b=DUCg183CoSpDavH9qWsB9Dd+vELGciDPQ28SM0Rl9rD47uy+gjy0Xsj31yFajUUFVz4bV//UQZSPP1YR+PQvINhiCW95rQ/7ZKJTaWpV4PLWdr18+M2l9IBwoUBN/Sjus3SLdOvXmt8gDC2U6xSy7oPFLCvMRVbZYdLlCaXaXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001160; c=relaxed/simple;
	bh=g15Vpib+Q+DojDSMTd96n1cwlTX6rDVoDLjX+AlgOKs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R21BoQeaBLxRMO43/sUerOn1PduQeWriUjqPyjgRcYmAPIjeN1/R+4DME64TlHmIUh2+H/1eWmB1jZp5ZyXgTdi0CbWszTJUH3mMgQ8n6lzHrhAUcvdPaNKcwsk/U4cy9fQEoG5FC7B0r8Zx+y/Nj9T1ZJ8wepAXjLH6wkmdbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xze3ourd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AEciq3022192;
	Tue, 10 Sep 2024 20:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=v673NUDOsAO5fVUwjJVPGG
	WyKayM4rK4azbU/2hOEkw=; b=Xze3ourdJrEwPhFjQcRVJYtk3Xrh/r7Mi51RNU
	8PZ5DA9pWRhnPPrVncix+3Zf/FwV8lvCrB0UUe9Y0+rE+s7qp7tCyOG+kitXnbgE
	lg12xoDwqR9N9kJN/DmwN/BWSeM6zKY39hpLZDDMcinMFre+dnZ3jOyVGcQeJHDm
	uBjjrTBEaPX09UgUt6zAnlYKOU1BTT2LCvtZ6DlhJnbuQbVmvbeDXQDX1KGQ4u5f
	ObqSVFox6SQuLeehaa4IzrmF9k0iIvR52F5ZyYjaJ9/kWaZcw6itV5n0SP2n+Rz0
	dXHxrP6P1ZXhf81HDwI7x7bxtTIzIe9+shZBdzuR6H8i1p5A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41he5dxhym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 20:45:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48AKjsjt030309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 20:45:54 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Sep 2024 13:45:53 -0700
From: Muna Sinada <quic_msinada@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 0/2] MLO MBSSID Support
Date: Tue, 10 Sep 2024 13:45:36 -0700
Message-ID: <20240910204538.4077640-1-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HGWq0NIi6R81FlrG-wWSM1d4jR8rCAOz
X-Proofpoint-GUID: HGWq0NIi6R81FlrG-wWSM1d4jR8rCAOz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=355 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100154

Enable MBSSID for Multi-link Operation.

For MLD if transmitting link of an MBSSID group is part of MLD then
link id of TX link BSS along with TX interface index has to be
specified. Add new MBSSID NL attribute to get link id of transmitting
vap link in case TX vap is an MLD

Additinaly for MLD, tx vif along with link id is needed to find tx
link BSS of a non-tx link BSS. Currently mbssid_tx_vif is inside vif
structure which won't suffice for finding tx link for any non-tx link.
Move mbssid_tx_vif to link conf and add mbssid_tx_vif_linkid.

Update ATH drivers to access mbssid_tx_vif member from the correct
structure.

Rameshkumar Sundaram (2):
  wifi: nl80211: add link id of transmitted profile for MLO MBSSID
  wifi: mac80211: restructure vif and link conf for mlo mbssid support

 drivers/net/wireless/ath/ath11k/mac.c         | 20 ++--
 drivers/net/wireless/ath/ath12k/mac.c         | 18 ++--
 drivers/net/wireless/virtual/mac80211_hwsim.c |  2 +-
 include/net/cfg80211.h                        |  2 +
 include/net/mac80211.h                        |  7 +-
 include/uapi/linux/nl80211.h                  |  5 +
 net/mac80211/cfg.c                            | 86 ++++++++++++++---
 net/mac80211/ieee80211_i.h                    |  1 +
 net/mac80211/iface.c                          | 94 +++++++++++++++----
 net/wireless/nl80211.c                        | 29 +++++-
 net/wireless/sme.c                            |  4 +-
 11 files changed, 207 insertions(+), 61 deletions(-)

-- 
2.34.1


