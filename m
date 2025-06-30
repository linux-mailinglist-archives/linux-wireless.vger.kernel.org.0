Return-Path: <linux-wireless+bounces-24652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F31CAED553
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 09:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E116175628
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 07:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6BE21ABB1;
	Mon, 30 Jun 2025 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ehJ4qblK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837C2192F4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267547; cv=none; b=h0EIyT4EGgJ/CxQOahaggrJ/JaJz9qf7wTHboOykUjIaPRTdFYB/8qTzfMzJIKaJRX96EeiQRCcR2S+9E9Ii13pi+phg35a0ziT9v9eAFNG8PCVRR0OnR+bSlmtmcRfTZIbuCmL1E3fFivOLH2/Yc/q8+mi1w67WlXDbPt/+g5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267547; c=relaxed/simple;
	bh=JCnVMPNWRPuxFTR5t7bHxPk3RCGDoIJgs/JuvBq4r0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBHXWyrjBtJPBSa2+0MNLWCm9Km1XUSiljXwuYQ9uD+0mEQCXWKJav6OhxSVfXBbdqJAhqyOclFv8wTn3vuLxOr7xtfXW7O81TZNsBdfTKK0sumVF0IkQFDXNfqVQQJj72Fy2W1jk8b5Qk4TIhQlIEDdBfbVNBas1ZKcbl/qkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ehJ4qblK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TNFHsB021411;
	Mon, 30 Jun 2025 07:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PBaPrfoVHDoZhimDvHLYVvAmF2xfILiS0UdtilZz3jg=; b=ehJ4qblKH2Df7USM
	pEVX8F2AUm80mTcsWfkB1jD1r/f17lTpnVY+8WEJLWVzNQTXIMTwG1WnK9264OFm
	bVrhogXLwQCufumD0erVT6pJ8J6l/cqTCll6f6z3BWaWuUJtaf2+uiSgXM8kzZ+C
	xj9EmQSOWLkBXHylw1JwHhQezgtIbWa5AuNDDIO54jXK7MJ1ex3nqIgD3csrJOfb
	afArDeqHtfW7G5W4/ynRJyo8f+jv/sw776sEmGRC23OFxV69sTph42UjCmUeTNb/
	lwS26BTTGuEDgGXjreudd6DKR0VZbam1hdGQng3ojTcsI4nO4ksq0Diq1MWjlUpY
	7ojyew==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j63k3vmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:12:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55U7CNac030507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:12:23 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 00:12:21 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v7 3/5] wifi: ath12k: add EHT support for TX rate
Date: Mon, 30 Jun 2025 12:41:12 +0530
Message-ID: <20250630071114.3474672-4-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630071114.3474672-1-quic_sarishar@quicinc.com>
References: <20250630071114.3474672-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=ZKfXmW7b c=1 sm=1 tr=0 ts=686238d7 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=nwLLUvrA-SLCDLgIScsA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1OCBTYWx0ZWRfX1a8/B41Brx3U
 EZZa4KJafUdngzrFFyYTjPFnzOFlAAAmvQ3fRQj2x4pDQ4ROjHwnA20/HuHapa/8RrH1/dYRoKc
 +UZ1c2LqU6mTOuRYAPZ0ulXX1A+xAbpVRLboKLDHrJnQmiFfl16GDV1yex+1HYi7L72zlpoW0fU
 sYs7XbQqGzRsGdIjCKqvDK3Ff07jZmqVuaK202lAkYK3evXOopALD3zQcg430fslnhu1NwheTpY
 FSzS5MuApCJs+o1fEjL52y1Jx2In7upQmtTjstcSi1UMbpoRuec9wiCTq9VQCwagSsGQj+jaW+D
 GDMU+ojh87pBM6k+qGVxHlh2NGkFEDq96vsH9YWgaqZOkjx7n/Hx+QqBSNa3ly4pTNAvePbZ2Ot
 /3cP1iW/7xynDGFbEy5zC1HhfzZ1wnyiKaGxo+VoWOTTDs14kvw1IOyJQxkJiST/mhpycKo7
X-Proofpoint-ORIG-GUID: zI1p40Ba6c-FPeK386NcWC7sx0EFF9Xo
X-Proofpoint-GUID: zI1p40Ba6c-FPeK386NcWC7sx0EFF9Xo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=834 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300058

Currently, TX rates are not supported for EHT. Hence, add EHT
handling for TX rates and update the EHT-specific fields in arsta
accordingly.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index f0cfe03d74b6..0f5edc81fc5d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1535,6 +1535,16 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 		v = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(tones);
 		arsta->txrate.he_ru_alloc = v;
 		break;
+	case WMI_RATE_PREAMBLE_EHT:
+		arsta->txrate.mcs = mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
+		arsta->txrate.he_dcm = dcm;
+		arsta->txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(sgi);
+		tones = le16_to_cpu(user_rate->ru_end) -
+			le16_to_cpu(user_rate->ru_start) + 1;
+		v = ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(tones);
+		arsta->txrate.eht_ru_alloc = v;
+		break;
 	}
 
 	arsta->txrate.nss = nss;
-- 
2.34.1


