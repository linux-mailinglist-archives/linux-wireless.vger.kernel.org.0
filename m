Return-Path: <linux-wireless+bounces-10739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C91942DBC
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 14:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D92E1F24C11
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425C018DF93;
	Wed, 31 Jul 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kKVKErzE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891AC1A7F71
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427618; cv=none; b=lOqDWfGJm4QauKus0PsbYC5vns3MgVhP6uwSiy/HwSKUwHie11lCwxTQq/VGJnVzKxLYBQaskgmuslhdQpVX6/e2KnFPz2Bf48FcPZL7xv4Q1zZp3Lp4xfjk1Uqlg3H2UV1eB4JqURAMVapStqhupPUVXWez8boR6M+mU4iQXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427618; c=relaxed/simple;
	bh=M1wXdQNPKZWzRDe/oVivRwfL/B5KMGdmLoDJR0Zmh7g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cAKAK/oDggymF2qbPWS7a2Ym3MKGusVjwG7T/ElFkUcXv9eztQVm9PthEjDh0gYu6YQYiSJjcfOKzbvo8k/GPUncuUv5i6VRMus/riN/6U+xkGDfc69DD0wxRtEtMKjdujaBd/hymKEZuq0GWtF0NTHrDnOphR3Ah1J3FfsZOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kKVKErzE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V73Mre008941;
	Wed, 31 Jul 2024 12:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bpSVZrpzntsIjYO9iZ3Akr
	GilqhM71mg8wtrUUAyHd4=; b=kKVKErzE+zS/UVwY+aaWZV8kEsq941E1AVRhI8
	aIq+PZPWXM65k79YjwrAPAGWTXuRo9vD8L732HxRV1/+VTCBPfYwidJspDPhKksI
	r7NWYusgFVP8jB2OSUInpsJXbtEpJkWlRZPHF8E1plY9aY76hYW3EMp0HH2e+E68
	Qst0wQ1eUcfRHXYsy3Wxo4iSJKmUtP/a04FxJbSNIhujNmC/lXOGfVgewAHqEHpH
	t6fBBmMWMnMqYqBRo2Qk/Y/sBEGKsErhJQY1a0OVfupOY8tC4AsvO+/NEED/S0jq
	Jc/39wNiLwZrbj18hl58oAf+NqdAPO6AFADO2exCAE2EcmPg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ms43b2ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 12:06:52 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46VC6pIa021243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 12:06:51 GMT
Received: from hu-mdharane-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 31 Jul 2024 05:06:50 -0700
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Manish Dharanenthiran
	<quic_mdharane@quicinc.com>
Subject: [PATCH RFC v3 0/2] Add Multi-Link Reconfigure link removal support 
Date: Wed, 31 Jul 2024 17:36:33 +0530
Message-ID: <20240731120635.2162332-1-quic_mdharane@quicinc.com>
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
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ih-BdTbOX6exsm2eTgf0E95gtIau2Pp5
X-Proofpoint-ORIG-GUID: Ih-BdTbOX6exsm2eTgf0E95gtIau2Pp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=763 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310090

This is a preparation for supporting Multi-Link reconfigure link removal
procedure[IEEE P802.11be/D5.0 - 35.3.6.3 Removing affiliated APs] for
driver which supports offloaded Multi-Link reconfigure link removal.

Multi-Link reconfigure link removal offloaded drivers will take care
of updating the reconfiguration MLE in self and partner beacons. It
also updates the AP removal timer automatically and notifies once the
counter is expired.

This patchset also adds mac80211 routine to support sending link
removal command from userspace to offloaded driver which accepts
reconfigure Multi-Link element and the TBTT count for the link to be
removed.

Driver (ath12k) changes that utilize this will be posted in the future
versions.

Manish Dharanenthiran (2):
  wifi: cfg80211/mac80211: Introduce nl80211 commands to support MLD
    link removal offload
  wifi: mac80211: Add support for link reconfigure removal

---
v2:
 - Addressed Johannes comments
 - Some of the open items are yet to be finalized from previous version
   Lore link for the same:
    [0/2]: https://lore.kernel.org/linux-wireless/1f0ae919-0562-4da0-8218-69cbb21e6068@quicinc.com/
    [1/2]: https://lore.kernel.org/linux-wireless/20240404185950.776062-2-quic_mdharane@quicinc.com/
    [2/2]: https://lore.kernel.org/linux-wireless/20240404185950.776062-3-quic_mdharane@quicinc.com/

v1:
 - Addressed Johannes comments on coding style and return usage.
 - Still some of the open items are yet to be discussed from the previous
   version
   Lore link to the previous discussion is below,
    [0/2]: https://lore.kernel.org/linux-wireless/544b2adc-9b4f-4198-8547-c556c9ebdaa9@quicinc.com/
    [1/2]: https://lore.kernel.org/linux-wireless/70d9c885-d528-4892-8cc8-3450dfca6ac4@quicinc.com/
    [2/2]: https://lore.kernel.org/linux-wireless/8b0f6f62-ff3a-483c-bceb-2f9c56526f44@quicinc.com/

---
 include/net/cfg80211.h       | 52 ++++++++++++++++++++++
 include/net/mac80211.h       | 25 +++++++++++
 include/uapi/linux/nl80211.h | 30 +++++++++++++
 net/mac80211/cfg.c           | 12 +++++
 net/mac80211/driver-ops.h    | 19 ++++++++
 net/mac80211/ieee80211_i.h   |  4 ++
 net/mac80211/link.c          | 34 ++++++++++++++
 net/mac80211/trace.h         | 31 +++++++++++++
 net/wireless/core.h          |  2 +
 net/wireless/nl80211.c       | 86 ++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 17 +++++++
 net/wireless/trace.h         | 58 ++++++++++++++++++++++++
 net/wireless/util.c          | 17 +++++++
 13 files changed, 387 insertions(+)


base-commit: 338a93cf4a18c2036b567e9f613367f7a52f2511
-- 
2.34.1


