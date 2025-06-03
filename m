Return-Path: <linux-wireless+bounces-23538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791CBACBE78
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 04:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035E21712CB
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 02:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765314901B;
	Tue,  3 Jun 2025 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GQpxs7X0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCAF2F32;
	Tue,  3 Jun 2025 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748917574; cv=none; b=A4qXOjkJ9WStUJpSUOn8ElbetENNIH0IQ4yUCDgG+spKqwJlHqBzLRHpxnqWdIhtPKEd5n1u1HsDBH9hCkDutAUT2hekUozacs4OfmhXMrNnduzn2OOCDYn6qroxqtHtvEd/TTpLXlJCRIhG2N88y5BOoRWbYMQxTUdLSXre+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748917574; c=relaxed/simple;
	bh=Io0+bEqEUTccIkE7WKV5wh8RD2PGXRuYSPuBXx56ZWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=iO60fJ7VrhCV6+2CAbu1oOtJU82PlfP938GTzlUpIHk4SORcMa/BcQf31E1MxwW0RWM3OBRV3gEumQHY4MK2b2d/H2VJEE/8NkUjjS/HoGBm/8ddFH44eRtAFAqHSerTonK2dxcPkOazKm0VID3MUlDSI89WaW6qYFOKpAPZ+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GQpxs7X0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HKV1s012543;
	Tue, 3 Jun 2025 02:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Vj1k61r/rKkCnbDgTyGOAr
	yQPdF7b2vebfxYw9m7RGo=; b=GQpxs7X0h87cRA9GhtgdfgyLyzDOPywYM38P2r
	FUf8WIJWekiqJmgRl3Yjv9pEWomA64TMl/yC2dYamijX0t8wyiptdzmv2LSTUEw6
	32gkcfjBUfbgtLXEQxJeWBPy5Bc2Hf9wgpjB+pQy3q6BjdFT5TX5LcZ9W9qANUZG
	LVek7nwAFj2NFZKkJ/bzN5QJAysVzPahZxXpCKIXsBQo9U8FMldOUDjLhCDc64pP
	eQH5fpuYwn4xwYtamm8SzPAjYsF/X6e9o39YgUx4fJQm2kZQI4soHoQaVXxJMV7+
	UZZSQVvlUQfU7PzkxxR4u6p1RR0riykKFqpMSmXNQTHCAQ2g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8ss29f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 02:26:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5532Q6Oo019045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Jun 2025 02:26:06 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 2 Jun 2025
 19:26:04 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Tue, 3 Jun 2025 10:25:28 +0800
Subject: [PATCH ath-next] wifi: ath11k: fix sleeping-in-atomic in
 ath11k_mac_op_set_bitrate_mask()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250603-ath11k-use-non-atomic-iterator-v1-1-d75762068d56@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABddPmgC/5XNQQ6CMBAF0KuYrh3TFinUlfcwLmgZZGJotQWiM
 dzdCUvd6G5+Jv/9l8iYCLM4bF4i4UyZYuCgthvh+yZcEKjlLLTUpSwLCc3YK3WFKSOEGDjGgTz
 QiInPBK62lbRt6bt9LRi5JezosQ6cBHch4GMUZ/70lLnwXJdntf5/HZkVKDDWKYMNSpT6eJ/IU
 /A7H4cVn/V/oGZw3zrjnTSIpvwGi//AgsHCVbarKqtb9QEuy/IG+v6SIXoBAAA=
X-Change-ID: 20250530-ath11k-use-non-atomic-iterator-b89709d5cf48
To: Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yEYEXMIcVbDkkv04F8yM7rgx7GQ3DfxV
X-Authority-Analysis: v=2.4 cv=EPcG00ZC c=1 sm=1 tr=0 ts=683e5d3f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=VvPa7mMQmCZPogn7yUkA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: yEYEXMIcVbDkkv04F8yM7rgx7GQ3DfxV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDAyMCBTYWx0ZWRfXxap40OA2TFd1
 k/uf2ZEgQfIRk+yrWykL9UBgGAqF648o8eecLgWZUjYsPQ59Af4Kj9GY7NCnSzMSgHLoxW1BZVJ
 64PEpYcR8RpvCt78HLllMZTVeOZf3Rrdg5Z5aslUjM+gpC3YH46PXAnROldCZYlQxUtgdEFSvVN
 E4ANr9AaZ888dHU+pZXwpjhf1B40ZNxNYbDDoCHT+dDfcUPsJ1C3d5/Cv09xaEDQZGQiagEKCUv
 vMLwj/0iMJV/xZZIdQJCq1rNJbh8tdmVu/Oco+9X9TS7PEMKk7fP1D8fHy1WeJeWpdbx5QSV347
 TTS2ZhgJBaHE5NXv8QqWvA3C3cNz3OfNRARTQVc5l7LHZc3B69YWrk9XMrDaMZPVvU9JQgUgTD2
 qs3okn5N7sDOH7dAMLadWYapCsyi3kBoFra7qfLMPbVOrdN4zq3HlUNhqKcFfuS++UO4rVOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_08,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=810 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030020

ath11k_mac_disable_peer_fixed_rate() is passed as the iterator to
ieee80211_iterate_stations_atomic(). Note in this case the iterator is
required to be atomic, however ath11k_mac_disable_peer_fixed_rate() does
not follow it as it might sleep. Consequently below warning is seen:

BUG: sleeping function called from invalid context at wmi.c:304
Call Trace:
 <TASK>
 dump_stack_lvl
 __might_resched.cold
 ath11k_wmi_cmd_send
 ath11k_wmi_set_peer_param
 ath11k_mac_disable_peer_fixed_rate
 ieee80211_iterate_stations_atomic
 ath11k_mac_op_set_bitrate_mask.cold

Change to ieee80211_iterate_stations_mtx() to fix this issue.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 08d7b136851fabb0a1c1032abcf9c01550e9f4f5..068805daf5fa4e0894be4ea4e8f2e9f756cfdcd3 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8740,9 +8740,9 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 			return ret;
 		}
-		ieee80211_iterate_stations_atomic(ar->hw,
-						  ath11k_mac_disable_peer_fixed_rate,
-						  arvif);
+		ieee80211_iterate_stations_mtx(ar->hw,
+					       ath11k_mac_disable_peer_fixed_rate,
+					       arvif);
 	} else if (ath11k_mac_bitrate_mask_get_single_nss(ar, arvif, band, mask,
 							  &single_nss)) {
 		rate = WMI_FIXED_RATE_NONE;
@@ -8809,9 +8809,9 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 		}
 
 		mutex_lock(&ar->conf_mutex);
-		ieee80211_iterate_stations_atomic(ar->hw,
-						  ath11k_mac_disable_peer_fixed_rate,
-						  arvif);
+		ieee80211_iterate_stations_mtx(ar->hw,
+					       ath11k_mac_disable_peer_fixed_rate,
+					       arvif);
 
 		arvif->bitrate_mask = *mask;
 		ieee80211_iterate_stations_atomic(ar->hw,

---
base-commit: 3d933084a072fd5fb5da54c06a017abc0412c86f
change-id: 20250530-ath11k-use-non-atomic-iterator-b89709d5cf48

Best regards,
-- 
Baochen Qiang <quic_bqiang@quicinc.com>


