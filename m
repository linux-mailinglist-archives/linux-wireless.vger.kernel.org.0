Return-Path: <linux-wireless+bounces-11424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6309518E3
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 12:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5945282D8E
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 10:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0843D552;
	Wed, 14 Aug 2024 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ABqGMMpt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9DD1AE02D
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631689; cv=none; b=gYbynv724MZbeGMg3mR31nO56Pmt+ZGKvbHVLwPuRTOwYNqYoG1E88lrCZp4Zc9hzc2J5CISm6kdCWxOHzb+NCj0XdG+HgRTaJhlDTHTgd/gz6sckgqNf0nZ9qpIbrsrcxlM4sBjd9IfF7uXDAX7b83gwsElEsUQJmcMrkmN9AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631689; c=relaxed/simple;
	bh=ZtgfR0FxlNEoh/zgGN0lF2vxhVP51tm4NJS4Ul6umOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iW5mU/2hs4zm+82TFeQEnfC+yE2SSCMH5ku1fjS/7U8pVwel2erdAeDYJtQ8uu3zhVYeoE6ccJJXEyc7Pcutn4F9P/oKU4HXNsX8cxKf0lb9YskY+fJvgcdIzYqylUPuxqqm/qiYvQnQxmAGPzyvbEERWQqHL4resBSwMyMBb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ABqGMMpt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EAUBuk009032;
	Wed, 14 Aug 2024 10:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Heh0jK4gsEemKAW3bsGK3Go1NAYv8mKuP5jcfRMOBr0=; b=ABqGMMpt2HphEkOg
	Sn4VfjFkWzVKrWRAwaqK7F2lZW6ePnTGKZ6+RdWY346Xc/evWylVzpefe7XMQ094
	Zd1iJEgm3mORIkrzjlDvxRMMjHFEntKfW9tu+7srj2sqTdnsV7vQvWQLY6afg40E
	vjPwLAIjZn7XDT5HqFga2/UAigwTrDzc10SuxRKUseJtxDrE/NAiP8C/OdnNHSnn
	+abv/Bb0+pgODaeqaPiBmPlTslPbqY9s+qhZryPGmGKfKUyeeTbnIoJvB6umNbNm
	8mgZ2YccFDIo+MI1i4Kjt2AjtvDeSoKDoEgNDVDqMiTIJbOUf7AOLF7srJ1oog/E
	A+RrqQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4108bc31uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 10:34:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47EAYhqX002568
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 10:34:43 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 03:34:41 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/3] wifi: ath12k: Refactor radio freq low and high information
Date: Wed, 14 Aug 2024 16:04:22 +0530
Message-ID: <20240814103423.3980958-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814103423.3980958-1-quic_periyasa@quicinc.com>
References: <20240814103423.3980958-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: TIq21BXuznXotWXKcIw9BWNnZ8HBvSNI
X-Proofpoint-GUID: TIq21BXuznXotWXKcIw9BWNnZ8HBvSNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_08,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140073

Currently, radio stores the low frequency and high frequency information
as a separate variables. However, cfg80211 already provides a suitable
data structure struct wiphy_radio_freq_range, to store this information
efficiently. Additionally, for multi radio per wiphy infrastructure, this
frequency range information is essential. Therefore, to enhance
adaptibility and leverage existing structures, modify the storage of
frequency low and high information to the struct wiphy_radio_freq_range
data structure.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00183-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 3 +--
 drivers/net/wireless/ath/ath12k/mac.c  | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index cdfd43a7321a..ff830d91ceb6 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -645,8 +645,7 @@ struct ath12k {
 	bool monitor_started;
 	int monitor_vdev_id;
 
-	u32 freq_low;
-	u32 freq_high;
+	struct wiphy_radio_freq_range freq_range;
 
 	bool nlo_enabled;
 };
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 69f50c1a52d6..6761204048f6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -639,8 +639,8 @@ static struct ath12k *ath12k_mac_get_ar_by_chan(struct ieee80211_hw *hw,
 		return ar;
 
 	for_each_ar(ah, ar, i) {
-		if (channel->center_freq >= ar->freq_low &&
-		    channel->center_freq <= ar->freq_high)
+		if (channel->center_freq >= KHZ_TO_MHZ(ar->freq_range.start_freq) &&
+		    channel->center_freq <= KHZ_TO_MHZ(ar->freq_range.end_freq))
 			return ar;
 	}
 	return NULL;
@@ -8717,8 +8717,8 @@ static void ath12k_mac_update_ch_list(struct ath12k *ar,
 			band->channels[i].flags |= IEEE80211_CHAN_DISABLED;
 	}
 
-	ar->freq_low = freq_low;
-	ar->freq_high = freq_high;
+	ar->freq_range.start_freq = MHZ_TO_KHZ(freq_low);
+	ar->freq_range.end_freq = MHZ_TO_KHZ(freq_high);
 }
 
 static u32 ath12k_get_phy_id(struct ath12k *ar, u32 band)
-- 
2.34.1


