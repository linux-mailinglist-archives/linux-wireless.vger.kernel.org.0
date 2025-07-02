Return-Path: <linux-wireless+bounces-24780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C141CAF63FE
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 23:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB7F188ED89
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 21:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E32882C5;
	Wed,  2 Jul 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ptp18aqn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C70271473
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491762; cv=none; b=C4jbnOobNsE6nxJP6vTn9XOVMHe89iIzi+q0HsHB8XJyfGuV3uxoeYH7u12N9POVrPeQBTKdQHxGQGzJjfMiGPXmwTCh2GL2TFgNNHTxKVctvNpz4UdNm63XESjMsqCpsJlcxHdx7gwpRO5v8tlb83dwz43MRANSYHYJTUTmkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491762; c=relaxed/simple;
	bh=Y5btjcLStliu36Bn8Uhic+V1o6cgfUUtrOPeBAIpTMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZJHG47EJDNo75MjcBNBE4eYhW+bGDua1Ce/0Lhiw6oMJPVXMUwkM5x2ljcQxHMUiCLsLgmH5j5R5yciRguXfnybv7mywIjcF1PIV/LaFTpKUD2dZm3S2MZ80dIfEc8qfCs1e20gBbMz+t21vt3fM15M2P02H/LkNaXRcdsUnAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ptp18aqn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562KRU07024702
	for <linux-wireless@vger.kernel.org>; Wed, 2 Jul 2025 21:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QAMUxNTMudJ0u2WdFXC4VN
	sJOM9BJjWzohjBXdkzFms=; b=Ptp18aqn6XyQBoOs9ViAMe7T2Sp72K6D9XFt+T
	sDfznSvZDxPu2RqKT+KPYald9dUBiX+SYZm+h/8dBJbvo3yy9ibH1sVFrC1icMU0
	BvT+NTU6UAXI1xWxS3D6ACsW4K0s3E3mJfgQNuaAcXLFGrQ9gJx0s0mny5XKmZQr
	IdrYJjMq8tzSdKAl45h0mtlphThZHMjj0sTaKlXtiTl9y0hGq/BmBEmDLSHse72U
	oDNs9bvoRP9pIwHcIIe5rOrVHKzMDNwK44bQWxud6suY05QJkCI7Bshi5xsSC30B
	13SDjKKQNsQn5Op75uw6lToYnNFR/m5VKMv0NVG54NJna0HQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8s9p3rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 21:29:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b34ca003f1cso3573197a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 14:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751491758; x=1752096558;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAMUxNTMudJ0u2WdFXC4VNsJOM9BJjWzohjBXdkzFms=;
        b=lNq618AqZEMAoQ+hjsbbA83F0YhLJjpMbD/DzoXoqhrehaHzFA5jIsnD0n3TVpfQMY
         mvJZNAcTDQagStB3AbRkd65XIda+mv5z4SAwKu3pSNZiaGPB5wTTAhuJKN1Kre12I+KZ
         D5McOarvAYZymwRObVoDE9Zal9TcKfKsV8YoufNpR5ETolyDVDlr3y8G8usDejAAiHcX
         Ngbw/FZvJuSqdbldz2UOfZDMlCte3fjYjy8+9zLDmR+bCunJJN1tHYcIikp4+QfFUVZU
         iT6v91qoySJipnojcqc4iUrWloR1v+WreuwiGsdyuuHIDcMB198yUVLCZRLUH0V0nM+G
         t/lQ==
X-Gm-Message-State: AOJu0YyWcaLV6VOrDXflz0WDGxbbmGBc7OwmZDFSiIiBHDZGrt51fuqY
	4pWa+IA0qiey9qSuv7jdLLz7YFaV+jxq9h0lg4RGkkOYGj8iLzUGHBwvsMWNt+hFxAymbCeDFWH
	SkAD5wLAjcn52hUy1EVMt3mAtjB861OGTegBdoVhH60TDjWy4Y/lN8/aC73Lt9PPQyRsmcQ==
X-Gm-Gg: ASbGncvMQrHOsA1whgXbdQTj+W3byzEhpCK4L15j1mUnD24f9br6riar+MtKWAZy7mZ
	9xVRswb2hBabiy+MCgD/Mc46AyNPm4W/698M9WnTqS5tbqcyseQ38nM/yXoZCGK2wkmZJG3Vi2W
	wa74wqgZ5YTDiWiAvOqOZ343IHW09VoCOfqGdH1Yu0PltYSDZJc6z263h4Ut43hJispRVdsej3l
	si2xio/xpYW2KvszQVf/ljWFxk9sc9O12yPckiyeapFc5yTSS8Zefb1n5thP2Ct3xdfaLsilTju
	E5Y1HTHGBndJ0YgKmGGZQ2HYjFiBAdZ2IkKwkw9UrQ0QpsgtrSAAQcJMKo8=
X-Received: by 2002:a05:6a20:4328:b0:220:2d0f:f8e1 with SMTP id adf61e73a8af0-222d7daa53emr8016848637.3.1751491757716;
        Wed, 02 Jul 2025 14:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEmyEvM038J3qLY65BE/Fi+fMTyDd0sD3BGBXcQD/A4mIsv9ZpGlW6A9zozkpoV7Ns/MnkpA==
X-Received: by 2002:a05:6a20:4328:b0:220:2d0f:f8e1 with SMTP id adf61e73a8af0-222d7daa53emr8016824637.3.1751491757335;
        Wed, 02 Jul 2025 14:29:17 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56cd84csm15732466b3a.132.2025.07.02.14.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 14:29:16 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Wed, 02 Jul 2025 14:29:12 -0700
Subject: [PATCH ath-next] wifi: ath12k: pack HTT pdev rate stats structs
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-debugfs_htt_packed-v1-1-07bd18b31e79@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKekZWgC/22NQQ6DIBREr9L8dTEgtWhXvUdjDIWvkFaxgMbGe
 PcS1t1M8jKZNzsE9BYD3E47eFxtsG5KwM4nUEZOAxKrE0NJy4peOSUan8vQh87E2M1SvVCTXl8
 kFY2oK8UhDWePvd2y9AEyGjLhFqFNjbEhOv/NbyvLfRYLyv6JV0YYkbXivFSNrAS7uxCKzyLfy
 o1jkQLa4zh+ZVl2dMUAAAA=
X-Change-ID: 20250630-debugfs_htt_packed-fd4a079785c3
To: Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Lingbo Kong <quic_lingbok@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=H/Pbw/Yi c=1 sm=1 tr=0 ts=6865a4af cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=x3mXCiuBoapq5SUTYUMA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: KOg9HV1CGGUVsjB1P-t7QzGpVJuR6Na-
X-Proofpoint-GUID: KOg9HV1CGGUVsjB1P-t7QzGpVJuR6Na-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE3OCBTYWx0ZWRfX3T7s1Qic+XYs
 iYjPrjs4Gpm+uTiMA6qYidhT9q5x2c55lSdlrNUfFUzlYYnu5tRBtLPd3M8E2nNOyVUeKcSGBoQ
 OFsb/TQn93IJtNj5uqfxLErkUQ8A1Iy6egDSBg1lwWYpB9sZJWiwmGONXaktnYCgKBJByxf+m/g
 qlTQQWcXoBkm1GOPHg7XjoHjRNvVt5SlYL+IB3DwJXSI2p3Z2qju+u7nyXBtlgSZa41Y2eC56AS
 s6y9tlM9T4VugxMHdBq2T0LLPkQxaKtrdz/vOpwdoPaBCN98r3Bwo+adJyErUlWsj1OY8ZvPpR9
 uu9BloYvvL2CVgb/feb84vr2VjwA9080om1iBFkuA5pYe/x1O9lw8qu42dRYot1DiOVC4WQBg5J
 4dV67iTdV/K1itPNLFUR8usqZRI8GiLc3kZ/rAmGHS0ogPX1d2i9zXjf4Whiw4NzWGo2Ung6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020178

In order to ensure the HTT DebugFS structs shared with firmware have
matching alignment, the structs should be packed. Most of the structs
are correctly packed, however the following are not:

ath12k_htt_tx_pdev_rate_stats_tlv
ath12k_htt_rx_pdev_rate_stats_tlv
ath12k_htt_rx_pdev_rate_ext_stats_tlv

So pack those structs.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: ba42b22aa336 ("wifi: ath12k: Dump PDEV transmit rate HTT stats")
Fixes: a24cd7583003 ("wifi: ath12k: Dump PDEV receive rate HTT stats")
Fixes: 7a3e8eec8d18 ("wifi: ath12k: Dump additional PDEV receive rate HTT stats")
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 13fbfb069ead4062487e40bfb17ef0f423f33b3f..9bd3a632b002d02db6c1f7fb173635b6119cc62c 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -490,7 +490,7 @@ struct ath12k_htt_tx_pdev_rate_stats_tlv {
 			   [ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS];
 	__le32 tx_mcs_ext_2[ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS];
 	__le32 tx_bw_320mhz;
-};
+} __packed;
 
 struct ath12k_htt_tx_histogram_stats_tlv {
 	__le32 rate_retry_mcs_drop_cnt;
@@ -579,7 +579,7 @@ struct ath12k_htt_rx_pdev_rate_stats_tlv {
 	__le32 rx_ulofdma_non_data_nusers[ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER];
 	__le32 rx_ulofdma_data_nusers[ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER];
 	__le32 rx_mcs_ext[ATH12K_HTT_RX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS];
-};
+} __packed;
 
 #define ATH12K_HTT_RX_PDEV_STATS_NUM_BW_EXT_COUNTERS		4
 #define ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT		14
@@ -609,7 +609,7 @@ struct ath12k_htt_rx_pdev_rate_ext_stats_tlv {
 	__le32 rx_gi_ext_2[ATH12K_HTT_RX_PDEV_STATS_NUM_GI_COUNTERS]
 		[ATH12K_HTT_RX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS];
 	__le32 rx_su_punctured_mode[ATH12K_HTT_RX_PDEV_STATS_NUM_PUNCTURED_MODE_COUNTERS];
-};
+} __packed;
 
 #define ATH12K_HTT_TX_PDEV_STATS_SCHED_PER_TXQ_MAC_ID	GENMASK(7, 0)
 #define ATH12K_HTT_TX_PDEV_STATS_SCHED_PER_TXQ_ID	GENMASK(15, 8)

---
base-commit: 0339e1433e228fbbbb106d9284dcc8b35ae6c4e6
change-id: 20250630-debugfs_htt_packed-fd4a079785c3


