Return-Path: <linux-wireless+bounces-17896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ECCA1B139
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 09:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A096C16A6BE
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DD31DB361;
	Fri, 24 Jan 2025 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kmXHm3Gi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A113C00
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737705627; cv=none; b=b4jAwbvm762R/K6Kna0dJbYvSJfz0B+i5ZkBHsArKaNBuGHpo+YD/FEG/AtIx/GQHKgjIR7OLFygEvEUNjCWo9DC42FwoMCHlORBnHr77ciBrzlbnftrx5uhrDmW1/WCSd427b4qeewq/a+O/92ykiTf8vk+MkIGsBJZ68+sVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737705627; c=relaxed/simple;
	bh=i9UHfIovSgjtMRAwNE80NheDFfIxrLelY30Cvmzwi3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ChP8PGEobLb5JRlBvpuG1fyNq2fEalqFodaHyk1Hb5plLnTeIErUomDuoVJk9i3JG0P9Vx2jmsorq/hK/ASPwBYcN5akBjiMs5Nn0UotTRGJYiDyAGz4O+6OSnr4c5SNYmvtNfbufqWHUEBQp3miDjqKfLC7d2ygwnFjCA28Ce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kmXHm3Gi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O5O8Tv029935;
	Fri, 24 Jan 2025 08:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=b2EHa9JrxW3sCx6X5boYK1
	RU8gHGNRBzTmwtvVn0ZhM=; b=kmXHm3GiqyONZUSQGc9u2WZNluYe4vglIopcZx
	TSO5kx6GI4H8rwoCPQVkebtOg6t2oSyU6q85UYtVkjQ/Ho50CXV3vfOqKLz+r7AY
	OtQOlgg0U6DS4+/HtMV2t3iNftyyCg6aGWCFvnOgfA3tcbY+9zjqZo5xqWw6oJyb
	HZKhPWCxtTnLLsFpvK46qZsJtMj1xXcBNFnYR1KlmEkqi584UDm/3kb4TuMKbb2j
	EXdkwmBDUHQl3Hi1lgOxCyesDgcqUzItS7RPlusIAwsr4bPU0tonizNrf/gncpxc
	jJ0oz07xkdhNtfTAEeK87MpBDyWnPelX98Ox1Kmzo2I4BQkg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c4p5gac8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 08:00:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O80LvX004636
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 08:00:21 GMT
Received: from yuzha-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 24 Jan 2025 00:00:19 -0800
From: "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_yuzha@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix wrong overriding for VHT Beamformee STS Capability
Date: Fri, 24 Jan 2025 15:59:53 +0800
Message-ID: <20250124075953.2282354-1-quic_yuzha@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YGsqUMJ013QKos6EkZQKxxckOeQLn9Bi
X-Proofpoint-ORIG-GUID: YGsqUMJ013QKos6EkZQKxxckOeQLn9Bi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_03,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=918 impostorscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240056

Current code in ath11k_mac_set_txbf_conf overrides nsts, which is
incorrect as it confuses nss and nsts. nss is Number of Spatial
Streams，nsts is Number of Space-Time Streams.

As mentioned in Fixes: 55b5ee3357d7, the nss used when acting as a
beamformee in VHT mode should be reported by the firmware and should not
be greater than the number of receiving antennas - 1. The num_rx_chains
related nss rather than nsts.

If STBC is enabled, nsts is greater than nss. About nss are mapped to
nsts, refer to IEEE Std 802.11-2020: 19.3.11.9.2 Space-time block coding
(STBC), Table 19-18—Constellation mapper output to spatial mapper input
for STBC.

Remove wrong overriding for nsts of VHT Beamformee STS Capability,
acting DL MU-MIMO in VHT mode is working properly.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Fixes: 55b5ee3357d7 ("wifi: ath11k: fix number of VHT beamformee spatial streams")
Signed-off-by: Yu Zhang(Yuriy) <quic_yuzha@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f8068d2e848c..b375b4c06790 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5337,8 +5337,6 @@ static int ath11k_mac_set_txbf_conf(struct ath11k_vif *arvif)
 	if (vht_cap & (IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE)) {
 		nsts = vht_cap & IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
 		nsts >>= IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
-		if (nsts > (ar->num_rx_chains - 1))
-			nsts = ar->num_rx_chains - 1;
 		value |= SM(nsts, WMI_TXBF_STS_CAP_OFFSET);
 	}
 
@@ -5422,9 +5420,6 @@ static void ath11k_set_vht_txbf_cap(struct ath11k *ar, u32 *vht_cap)
 
 	/* Enable Beamformee STS Field only if SU BF is enabled */
 	if (subfee) {
-		if (nsts > (ar->num_rx_chains - 1))
-			nsts = ar->num_rx_chains - 1;
-
 		nsts <<= IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
 		nsts &=  IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
 		*vht_cap |= nsts;
-- 
2.34.1


