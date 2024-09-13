Return-Path: <linux-wireless+bounces-12846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3F977CEB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 12:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91575B24EB4
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F491D7E54;
	Fri, 13 Sep 2024 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IFc1moc3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15BB1D6DDF
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222077; cv=none; b=i1jZuyzi0OSFjgBOmtKNiHK8qNJjfcrqUJeI4GZRZ+3ADxYhOYrF3Jbl5Gs1/Nz53YAE9WHEytDzko6IaX/QADXj8We3gERhXvOkWI9YCjSV5nlzwY2G0cKo+Sqor93tkn/MT3vicC9g6Flg7OxI/5Qskh5gHiFP8Z7exZRdBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222077; c=relaxed/simple;
	bh=E8IxYfJXdV0NAuphU2ra6g56Q7y3vlv+29Ttai/LQ4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEHZdLx4GO+sH+Lpvs6dJHtrqU0fYAIsKYiEt2b8inT8Zc2AZE2CNCyl2kCcUzqZmzyet9P3ncxeqBRGW3osktmAjHMuKBfFmtXRwm91do7GAL3kSakGw63YA4/fWNVLnoC2+9zeCl5MbkuAhx2lakEJiK7GqQhbERNOaJOVi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IFc1moc3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMBLjr005627;
	Fri, 13 Sep 2024 10:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e8/v5AQ/TbVhaMFC9E2pZ4PHRPNp7nKC58qNqZ+37ao=; b=IFc1moc3tXuG7z6Z
	WwibNGxqR+YGq0acNu/MDHkvVFnQjSjEcuWX8dYJX2TCUoSl4yrBV7TLPvmoIy+3
	108drsaIgkVEJkJtcLBC6shZoxn3/tz3XuFWEnHTj4gcehdmJWLzUzSS0zYQ3XWM
	YE+buU10nlTs9ITGTHRlENazC4HJBJJ42srZz3cYeoEAcHTRWpHUD+iGjOhXaDeB
	2SividNeS4V7LR4rN3JoKEwWJc9bhAOW+p2cKipWQWr8Vl0bHH56LYPRNASqrko4
	GlGxQr/cQ2pV74hZijYfyblg7B0/dOZWfFkMayhpsC4T54bkquxn88Kr0EAXpSVw
	wcZI/Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy738fjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 10:07:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48DA7jqb015897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 10:07:45 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Sep 2024 03:07:44 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 2/2] wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode
Date: Fri, 13 Sep 2024 18:07:08 +0800
Message-ID: <20240913100708.756-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20240913100708.756-1-quic_kangyang@quicinc.com>
References: <20240913100708.756-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JvMmJrlp9DZVNbhHiovvmZWd77r-QCNc
X-Proofpoint-GUID: JvMmJrlp9DZVNbhHiovvmZWd77r-QCNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=883 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409130070

ath11k_hal_srng_* should be used with srng->lock to protect srng data.

For ath11k_dp_rx_mon_dest_process() and ath11k_dp_full_mon_process_rx(),
they use ath11k_hal_srng_* for many times but never call srng->lock.

So when running (full) monitor mode, warning will occurr:
RIP: 0010:ath11k_hal_srng_dst_peek+0x18/0x30 [ath11k]
Call Trace:
 ? ath11k_hal_srng_dst_peek+0x18/0x30 [ath11k]
 ath11k_dp_rx_process_mon_status+0xc45/0x1190 [ath11k]
 ? idr_alloc_u32+0x97/0xd0
 ath11k_dp_rx_process_mon_rings+0x32a/0x550 [ath11k]
 ath11k_dp_service_srng+0x289/0x5a0 [ath11k]
 ath11k_pcic_ext_grp_napi_poll+0x30/0xd0 [ath11k]
 __napi_poll+0x30/0x1f0
 net_rx_action+0x198/0x320
 __do_softirq+0xdd/0x319

So add srng->lock for them to avoid such warnings.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 072963d3396c..5fd681b5df2e 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5146,7 +5146,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&dp->mon_data;
 	const struct ath11k_hw_hal_params *hal_params;
 	void *ring_entry;
-	void *mon_dst_srng;
+	struct hal_srng *mon_dst_srng;
 	u32 ppdu_id;
 	u32 rx_bufs_used;
 	u32 ring_id;
@@ -5163,6 +5163,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 
 	spin_lock_bh(&pmon->mon_lock);
 
+	spin_lock_bh(&mon_dst_srng->lock);
 	ath11k_hal_srng_access_begin(ar->ab, mon_dst_srng);
 
 	ppdu_id = pmon->mon_ppdu_info.ppdu_id;
@@ -5221,6 +5222,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 								mon_dst_srng);
 	}
 	ath11k_hal_srng_access_end(ar->ab, mon_dst_srng);
+	spin_unlock_bh(&mon_dst_srng->lock);
 
 	spin_unlock_bh(&pmon->mon_lock);
 
@@ -5607,7 +5609,7 @@ static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
 	struct hal_sw_mon_ring_entries *sw_mon_entries;
 	struct ath11k_pdev_mon_stats *rx_mon_stats;
 	struct sk_buff *head_msdu, *tail_msdu;
-	void *mon_dst_srng = &ar->ab->hal.srng_list[dp->rxdma_mon_dst_ring.ring_id];
+	struct hal_srng *mon_dst_srng;
 	void *ring_entry;
 	u32 rx_bufs_used = 0, mpdu_rx_bufs_used;
 	int quota = 0, ret;
@@ -5623,6 +5625,9 @@ static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
 		goto reap_status_ring;
 	}
 
+	mon_dst_srng = &ar->ab->hal.srng_list[dp->rxdma_mon_dst_ring.ring_id];
+	spin_lock_bh(&mon_dst_srng->lock);
+
 	ath11k_hal_srng_access_begin(ar->ab, mon_dst_srng);
 	while ((ring_entry = ath11k_hal_srng_dst_peek(ar->ab, mon_dst_srng))) {
 		head_msdu = NULL;
@@ -5666,6 +5671,7 @@ static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
 	}
 
 	ath11k_hal_srng_access_end(ar->ab, mon_dst_srng);
+	spin_unlock_bh(&mon_dst_srng->lock);
 	spin_unlock_bh(&pmon->mon_lock);
 
 	if (rx_bufs_used) {
-- 
2.34.1


