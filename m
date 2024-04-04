Return-Path: <linux-wireless+bounces-5879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD0898E74
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 21:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B3628C81C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F271327ED;
	Thu,  4 Apr 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g5f+n2S2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C1130E55
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257216; cv=none; b=LrXYfNGHJJ4eLPb2U/AbHE35MCXPUyABk9ZWyNSoxwLtxmWEm1Fs3fq9dhfPSLhYU4kPFoWAYn59jYhdT9IS18eXeVAVJp82g/1fAGqiCLOn3ek67V4xAP1VwIv2fLkEXpAyOOSYiBlmtGnOMYUVPMakJiqGBPECG7m30FkdpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257216; c=relaxed/simple;
	bh=XR4n8VVJVdD37lG88yLVSyxEMVdTIAE9v7D+YH1JGm4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R6VO/rS8DDAh9dcmTR3uqFc6np3JiuGqbyu2ZaROsXJ16K5S+6bMM0QR7izOR+EdaHKA7W0smpsLMcgvFLrwJ5I2Q3NfS+oghU0hcS8fRDgb/qxlst4nst//6fl5uzP+ch8f3tjH0063+uGeoAxiyqMQyxAOnW9v1ZZarphb23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g5f+n2S2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4349Z11V007282;
	Thu, 4 Apr 2024 19:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=q/XzrF2
	g4I+TDPGLBni+N06aHPChSDE88t2UdA0UOP0=; b=g5f+n2S2XFv9V7iiJn9EATv
	BUluw6uGG7Hz2VRSkae24+adMkjz041Nnh0LSTsyx29dQCNN1RTgT8UAp3ianO2q
	jB0EMX79THdMlbs2HEDUF0Ep0ZQbG5aq2sSsZriDjRYa0OAgPza0jiNbydgjA7xD
	/e7m85DuJ8nsoIwdv5Z2C3i5xW0iRm6yN6c5zDZTBMFberOskSdP13UQdmwwCKlA
	h1sns4k1A41s415NDkr6g/1ee+QlJI2ieBVrs/fSa0SJILWkDnQPAHyetCPT9gSU
	phPxaikA9ewfatChUOWIFoDdhpDA/LqOgmcsKekrvII8c3DBIO0QaJ+O9bb9Utg=
	=
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9ep3tbb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 19:00:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 434J07KJ004005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 19:00:07 GMT
Received: from hu-mdharane-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 12:00:06 -0700
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Manish Dharanenthiran
	<quic_mdharane@quicinc.com>
Subject: [RFC v2 0/2] Add Multi-Link Reconfigure link removal support
Date: Fri, 5 Apr 2024 00:29:48 +0530
Message-ID: <20240404185950.776062-1-quic_mdharane@quicinc.com>
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
X-Proofpoint-ORIG-GUID: QN8Kb-H1LIJiS5m1Y6YCQzQ3uP6rF7RR
X-Proofpoint-GUID: QN8Kb-H1LIJiS5m1Y6YCQzQ3uP6rF7RR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_15,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=639 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040134

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
v1:
 - Addressed Johannes comments on coding style and return usage.
 - Still some of the open items are yet to be discussed from the previous
   version
   Lore link to the previous discussion is below,
    [0/2]: https://lore.kernel.org/linux-wireless/544b2adc-9b4f-4198-8547-c556c9ebdaa9@quicinc.com/
    [1/2]: https://lore.kernel.org/linux-wireless/70d9c885-d528-4892-8cc8-3450dfca6ac4@quicinc.com/
    [2/2]: https://lore.kernel.org/linux-wireless/8b0f6f62-ff3a-483c-bceb-2f9c56526f44@quicinc.com/

---
 include/net/cfg80211.h       | 57 +++++++++++++++++++++++
 include/net/mac80211.h       | 25 +++++++++++
 include/uapi/linux/nl80211.h | 30 +++++++++++++
 net/mac80211/cfg.c           | 12 +++++
 net/mac80211/driver-ops.h    | 19 ++++++++
 net/mac80211/ieee80211_i.h   |  4 ++
 net/mac80211/link.c          | 34 ++++++++++++++
 net/mac80211/trace.h         | 32 +++++++++++++
 net/wireless/core.h          |  2 +
 net/wireless/nl80211.c       | 87 ++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 17 +++++++
 net/wireless/trace.h         | 58 ++++++++++++++++++++++++
 net/wireless/util.c          | 17 +++++++
 13 files changed, 394 insertions(+)


base-commit: 0ccf50df61f98a9f98d46524be4baa00c88c499d
-- 
2.34.1


