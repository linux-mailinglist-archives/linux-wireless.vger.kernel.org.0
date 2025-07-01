Return-Path: <linux-wireless+bounces-24723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F1FAEF5F3
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 13:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B247A5910
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E032727EE;
	Tue,  1 Jul 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j6AEDccr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E5270EC3
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367596; cv=none; b=CMhUWu87dQIq3vPh+9iGP3n95P5FPKhXppMSgTir1gI8PefvPxsa4OHoJvUKznS2F82y6ejw0hWhRbua+47y7k4IvS5tgVTTRjJ8gp7cvBGd4+SdiNd4UkZDUaTh+Uu72l5GG8ZcDG60ohPmMUwqkJ1s97m2zgJvOodJMLJMf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367596; c=relaxed/simple;
	bh=JCnVMPNWRPuxFTR5t7bHxPk3RCGDoIJgs/JuvBq4r0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKk+5Lagodic9XkACrasgc1jEtvSxOJ3/pJTwsHvlyyiYXmu+em8kuVIX1S1ecpHPRK6kDRpkRldjNiMmecTzAmRjph7QrfrSILj3w+v8EWwDDzz/oyEyLhZZbOrpfO/hDFv5twPn9XykAE5zV2foulVZIxNPqMU7d5Uueus3vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j6AEDccr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5619ppP1007049;
	Tue, 1 Jul 2025 10:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PBaPrfoVHDoZhimDvHLYVvAmF2xfILiS0UdtilZz3jg=; b=j6AEDccrk4iVu+e2
	W4Rs54YreC1c9qBXcbkRHTbTURGM22JhM4pWxDm5OXU/lsrr6vdPcZNI89zY70nr
	1qv2RDaR3HFVVTRGGRo/e+wTYticrge9M7VE75WJL8HM7db2f77BvKGdjn4MYhSl
	ubcUqcG0EDaQtywBZz/huDuzj60NzQCl4s2GUrDo/iftpd1Mv7475WvFOu9PTf9r
	1hTBQ7VyI7XiBZ+IUv5ujN/QAN5T6TlsbvMkIWRdAcfstK8nIsGR2leRM57jb6vB
	VKs+4FNEX64lCloIuqKLS+G7UdSS1ZexwqFuPbhJEUmmX1LRXJsxp8+o0277lhzf
	GnbBuA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5jcxbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 10:59:50 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 561AxoV5022272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 10:59:50 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 1 Jul 2025 03:59:48 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v8 3/5] wifi: ath12k: add EHT support for TX rate
Date: Tue, 1 Jul 2025 16:29:25 +0530
Message-ID: <20250701105927.803342-4-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701105927.803342-1-quic_sarishar@quicinc.com>
References: <20250701105927.803342-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=6863bfa6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=nwLLUvrA-SLCDLgIScsA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Sv81AqrgTNfoA05csSO6Yum6-17ffSbU
X-Proofpoint-GUID: Sv81AqrgTNfoA05csSO6Yum6-17ffSbU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2NiBTYWx0ZWRfX5nyOFzd6lFBM
 ieDjxvLYiRaS0l+gC3ifDkz92p47ZwSEaP2tlRyUWxDPoRKqIWGZ8BNLW0UXrYi/qg/skVrunnh
 tiW9uGoZHFKcyrpgzBh+Tr7+MtgNKcliXeal8Tbhy8q4Jh6nrWcEUwfgJiUBQX4aKr/lefx5TQ5
 mwSHb/+PGaclR0tV+88sPCAg0kr/FGYoe5aCuCj7Y/qdQs3LKFvD6abHMk+J9MBrfwmcysPNt8q
 4dvseaskAt2ZbcZqkzzALb3+IIpORAFf0zodOlwTUPDgMLU+O9B0LwMcy2aCT62kmWXqEtS+K0G
 UrCwM5uQ1dhBdjo9UQpioPZTW9QUarF/19lJMhyrTxBzb7o2USyU3YSX/hPD6WGjb8p8V1S2v4q
 Ja1WH0ju5ukNnNFz0ntpg0ycx2boWP7L/q4m+9Q5A1sM3fRQzyVrEFV0ZzSu/P7CE+TbvWF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=837 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010066

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


