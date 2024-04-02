Return-Path: <linux-wireless+bounces-5766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C3895E68
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 23:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2CC1C23471
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 21:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2294F15E5A2;
	Tue,  2 Apr 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ynw2I/0l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5059815E200
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091956; cv=none; b=X+doRdCscc0xcJHcLa34p6H+3nFDkAM4zP9qHfRRthoO6+hY+ss6xrTgJENUNNOvm9qXQsdWXQ2KnVBnUrDw6Z7o74jmv+AOAU9PYWwfypHRbHPJkIEZ8JcPwQS6FXFSeNOv1wV/PLJFr3mjTmmFRtPqzHTDlS4Tne5NfECysPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091956; c=relaxed/simple;
	bh=vuJ4Bijtahk+1dkUYyfw9B3QI1rx9OcihkPlCxlpPMQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KO9xDHO7OMqGgRddSFUYHsqNaTlAF35/rA73hQXVd0PgWVA8vYdwX6ZauwckeaNQMPmTceqAQGu0EhGybw6uNj00KsYzI0YHs0IQq4sEEUeltEpaqetyLjjA5EHrelhfLfmzNPSfGEB/xd0wiCDWd8PGhWWgnTslqATqZBow704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ynw2I/0l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432L5Nbs021037;
	Tue, 2 Apr 2024 21:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Eja0qQ4
	bFpG/cnGcLoou9CJZ8WjMSBNFw5DfrEJWOBE=; b=Ynw2I/0lOWYoqr9Tz262XQt
	roEn/gzgotDMszSJZgnwvQkptr+OwhdRJ6tmvLtINWupalNZQ7SfIsVGX+rIvwFm
	9r3jzvBUgrIvIUSCuMoT+vqNoi7Y+4EKvFDAqbN3pf1/Aa/xYPSKE7gZD2nH2GmS
	qDPbpVrWBAiCZcH3CRxh/Jx03ciJVX0Bgsv3iBx/ClFyeGCPAUYO/N2W/tskClyB
	XkSdFPNgVeSc6lpzwZtSFELFZ63rAgqvfSu/tNQmfndh4r/r8tB3Z1SA6JqhA2Vg
	nsT6IEWr8MDPXEKcopZmjIBnbBgMe1xaiziSPOYKOjhEV0Tg4ftgIuJINpK05Ig=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8eymhw0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 21:05:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432L5m2J031796
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 21:05:48 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 14:05:48 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 0/9] wifi: ath12k: MBSSID and EMA AP support 
Date: Tue, 2 Apr 2024 14:05:29 -0700
Message-ID: <20240402210538.7308-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EOM-q9X879RN9p88-Q6IeFF7EHk1dXke
X-Proofpoint-ORIG-GUID: EOM-q9X879RN9p88-Q6IeFF7EHk1dXke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1011 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020157

Add support for multiple BSSID (MBSSID) and enhanced multi-BSSID
advertisements (EMA) features in AP mode. Set extended capabilities,
WMI resource configurations to advertise the driver support to
userspace and to firmware. Configure each MBSSID profile by sending
BSSID index, total BSS count to firmware. Retrieve and propagate
MBSSID/EMA beacon templates to firmware. Set the arvif security
parameters for non-transmitting profiles.

This series has been tested on QCN9274 for AP mode but not on
WCN7850 as STA support is not part of this version.

One issue unrelated to these driver changes but seen with these:
cfg80211_mlme_mgmt_tx() fails when hostapd tries to send a Probe
Response for a directed probe request for a nontransmitted interface.
Failure happens because both cfg80211_allowed_address() and
cfg80211_allowed_random_address() return false when SA is that of the
transmitted interface but wdev points to the nontransmitted interface.
Association is successful and pings work. Issue is not seen with
hostapd version up to commit ID 3cd377eb54e7 ("MLD: Ignore failed links
from association attempt") so will debug commit ID 82453a3482c4
("AP: Split Probe Response frame IE generation into a separate
function") and commit ID 6b5e00a80e5f ("AP: Use a struct for Probe
Response generation in/out params").

Aloka Dixit (9):
  wifi: ath12k: advertise driver capabilities for MBSSID and EMA
  wifi: ath12k: configure MBSSID params in vdev create/start
  wifi: ath12k: rename MBSSID fields in wmi_vdev_up_cmd
  wifi: ath12k: create a structure for WMI vdev up parameters
  wifi: ath12k: configure MBSSID parameters in AP mode
  wifi: ath12k: refactor arvif security parameter configuration
  wifi: ath12k: add MBSSID beacon support
  wifi: ath12k: add EMA beacon support
  wifi: ath12k: skip sending vdev down for channel switch

 drivers/net/wireless/ath/ath12k/hw.h  |   1 +
 drivers/net/wireless/ath/ath12k/mac.c | 324 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/wmi.c |  40 +++-
 drivers/net/wireless/ath/ath12k/wmi.h |  46 +++-
 4 files changed, 345 insertions(+), 66 deletions(-)


base-commit: fe7e1b830cf3c0272aa4eaf367c4c7b29c169c3d
-- 
2.39.0


