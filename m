Return-Path: <linux-wireless+bounces-4679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8187287A9CF
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 15:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371201F22765
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA2947F;
	Wed, 13 Mar 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AGznQI0c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2041426C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341667; cv=none; b=CR/mRLv8JT/0tnGL6hDmLp3vN4HdUE1XTu0VbUg2pt0kSXBJwxU2z9QiRh6LmA+c4UUHaC6LyPUXctgJ7qXQNIzvdoHqksMR9Yk5objLDnwvDF6FgvLeRQ0uBlZyATX4tcMIevLr3uf3MWpSAqi8UOdirYGlQxfHUIMPZGwtm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341667; c=relaxed/simple;
	bh=3eho8jYCAjMs8WtVHXxmNk/+SgFX6mvTWl058PG4H6M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m1OTv+wMO7eNzVQ30qRwKnRodd6VQOyycYPh+DG6P5Ly4K+zBhqxqd0+Ire4UIM/OQtYY2aCQVbqMPGouwDNmXMlX7OV+DmYw1hWIhCZlC0CkS7ctVdVU4L/Vlr8/1n5vpkrVZItScH/3HP7MbNDRNk4dDltUqrSTddYV4U4xKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AGznQI0c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DENtuf004517;
	Wed, 13 Mar 2024 14:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=lyG2r0a
	Edl9aZ6k/UnIDZZxlvmVMWBGdlKiIT9nHaGk=; b=AGznQI0cU7h6xG2xPgzASZ6
	AW9tKZ9XaDxSeQqTc/UbJ1EwYEjMRHsXjoa/L9FvFxwGq5rWlyS+/PjVWUBkPzif
	zW7zakMVGiO6pHjp9y6qrjDgCKsn3P+TBikoFu4O+AD4LNR+uFo3G08XjgfsjYDH
	AOICef+SUi5zvLCL1jRx8QU9TNxVsoex5U82bPCseGK3plxtgGDfQ333xr4NuM3t
	jf5M93hLF+Ie8sHZs7muAINeDDre8euEpSRDdA1NBt4yiUhY0ijMdlDzlOa5izXz
	IR3do3FtguAoD8qpgayZIp5k12gWtZ3Pnrf8TEN6R4ibMsMn/BE11t4ET/zf4Xg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu9xarkcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 14:54:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DEsJCQ016484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 14:54:19 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Mar 2024 07:54:17 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH] wifi: mac80211_hwsim: set link ID information during Rx
Date: Wed, 13 Mar 2024 20:24:02 +0530
Message-ID: <20240313145402.456514-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ohHAeryzjlUIPRge1tIGn9Y665GCMIdA
X-Proofpoint-GUID: ohHAeryzjlUIPRge1tIGn9Y665GCMIdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=748 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403130111

Currently link ID information is not passed to mac80211 via Rx status by
mac80211_hwsim. This leads to packet getting dropped in function
__ieee80211_rx_handle_packet since it expects the link ID if packet is
intended for a MLO station and the station is not directly passed via
pubsta function argument.

Add changes to pass the link ID information in Rx status.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index b55fe320633c..783114ccb5b8 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1721,6 +1721,9 @@ static void mac80211_hwsim_rx(struct mac80211_hwsim_data *data,
 				sp->active_links_rx &= ~BIT(link_id);
 			else
 				sp->active_links_rx |= BIT(link_id);
+
+			rx_status->link_valid = true;
+			rx_status->link_id = link_id;
 		}
 		rcu_read_unlock();
 	}

base-commit: e27b02e23a701e5761f1d6028643e1203a1c56de
-- 
2.25.1


