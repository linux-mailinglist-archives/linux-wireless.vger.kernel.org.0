Return-Path: <linux-wireless+bounces-18939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE3DA34BFE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A470C7A1B18
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E7222157B;
	Thu, 13 Feb 2025 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jRWBxSrR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CEC13A3EC
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467959; cv=none; b=jiaX+k5tQHvdlfzTj2TB1t7KXLATuQhfcmDxKKA93YRsBeafKqaiwdsBM5oWa+VekVfXdv+IXT4mpKLW6HnyOGBJNud/joSKHaCCZhqc8PTvV2RzIEn1kSl43BwI5xscwAFgm84XmPbOt5+E0FS6k8vg6zf/OJtc59lkJxf1WcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467959; c=relaxed/simple;
	bh=msB0fGdD2cpZ8GdmOZHb8FPF7lX1A5MbMhcN5IoAf94=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=orEsK5qEpI1jlDiVuLMQnmPgkgCE7IbojAFey5pL25dbAyxNd90fiAL7nClpMK0lQrSzb4h1ih4eJGrV+b538QnlcWbvpILS8WaCvn3wemu/8kGLTO4DdI01y3QPII48xuA9GfP2JBi7g81973v0NNfYbQC/AzwfEqHdw4+jGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jRWBxSrR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DA70AL031744;
	Thu, 13 Feb 2025 17:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=L86rz2INuqMLIKpQmCJYbn
	lT2jO9JwNru/tQ45YREaU=; b=jRWBxSrRObjjUlVcINRCbqpo8YiWM3kIEJsTgM
	WPsgyNhIPKCrRL0bGCEu5ZoPbG+2vxKct0B6UQV/7ftl1gloBhxzxGZkdsCazFpc
	ld4BnxcPJf8tl/9oJ33EKN+LepKL4OCCoDf1fFEFYPLiAseyIVLolUa7MTlZvAkj
	/fwurtNXhUuocvU5aYF1eH+c84l0or0hhfO+u6HZy7JKs2kG1dPrb8DHXjAYwsBG
	7csjCUfsc1mwIpamMXNPK5lC9gXAD590FxayqKuIc0h1XiQ64y+dUniWVt7C36Y5
	+hyPuJPtBTCsEWpAsxu2C6YshNaW5B+gOgkJHuOmwbFkKBxQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44seq014kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:32:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DHWTwJ014462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:32:29 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Feb 2025 09:32:27 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        "Sarika
 Sharma" <quic_sarishar@quicinc.com>
Subject: [PATCH v2 0/5] wifi: mac80211/ath12k: add support to fill link statistics of multi-link station
Date: Thu, 13 Feb 2025 23:02:01 +0530
Message-ID: <20250213173206.1665731-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IRV-5YIpCkXyqW_4398zS8JG5ku3cGOC
X-Proofpoint-ORIG-GUID: IRV-5YIpCkXyqW_4398zS8JG5ku3cGOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=663 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130125

Currently, station statistics are filled at deflink for both non-ML and
multi-link(ML) station.

Hence, add support to fill station statistics for the corresponding
link of station.

Depends-On: [RFC,v2,00/12] wifi: cfg80211/mac80211: add support to
            handle per link statistics of multi-link station
Link: https://patchwork.kernel.org/project/linux-wireless/cover/20250117124554.3719808-1-quic_sarishar@quicinc.com/

v2:
 - Convert RFC patch to actual PATCH with each patch bisectable.
 - Add new patch to update bw for ofdma packets.
 - Add new patch to fetch tx_retry and tx_failed packets.

Sarika Sharma (5):
  wifi: mac80211: correct RX stats packet increment for multi-link
  wifi: ath12k: add link support for multi-link in arsta
  wifi: ath12k: add EHT support for TX rate
  wifi: ath12k: correctly update bw for ofdma packets
  wifi: ath12k: fetch tx_retry and tx_failed from
    htt_ppdu_stats_user_cmpltn_common_tlv

 drivers/net/wireless/ath/ath12k/core.h   |  2 ++
 drivers/net/wireless/ath/ath12k/dp.h     |  2 ++
 drivers/net/wireless/ath/ath12k/dp_mon.c | 23 ++++++++----
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 45 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.c    |  5 +++
 drivers/net/wireless/ath/ath12k/peer.h   | 27 +++++++++++++-
 net/mac80211/rx.c                        | 15 ++++++--
 7 files changed, 102 insertions(+), 17 deletions(-)


base-commit: 704a2d7237043317ed1b0f8a08203e9ddde70097
-- 
2.34.1


