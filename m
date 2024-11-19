Return-Path: <linux-wireless+bounces-15513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5BC9D2A5D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 17:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67CA7B2A583
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B8E1D12E5;
	Tue, 19 Nov 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B0fvycUA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70E1D0DE2;
	Tue, 19 Nov 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031279; cv=none; b=HnpPpvRWZ0BQBXRTtBdcWwq4UWvT0qVmPVtajNO5O4tocYMUcYz4WZsfKq0ezayYKhpkQ0KLSQbKYmN8Q+VIFQ/6CAGa2VuzXvgsT/ARQadIgdObOOVXY/uOVCYr0jECu+tDvqlCJa+lAo0xpNR/rgCm6LqZAub9PGNJED+fTvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031279; c=relaxed/simple;
	bh=cLw12Zjh6zUfG86/iyBkPkfgzbOqHF0Ea4GJvzYXXb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c2PVLKL2+RF0jxxH1cz37uQRZ/D84B7qir2PD9UixPqc8yuyp4xnX9l/5ooBNJMEDlnf3wVyCSx+eM1Fbca2sHf1ZeLsJoSIMKCH9GaD1LGDkTkNeUDmLNKTRG4rAyYvYWU0PZUcgSwrhWL/vylvurxHJ3vx6fFNTwYiE3oMhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B0fvycUA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7tQpF028408;
	Tue, 19 Nov 2024 15:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EGSwUJHgOxgr1HMRtCMrkYZZWmUpYkPwRq8EfT9qEz8=; b=B0fvycUA0nLOys3S
	UPpBXpI1keFd54UqrIBn/4S2iX8LWPwAAyh0H/XjEHJPAIZcK3g3453AXG+kB4HD
	+/Cr6D11HbJ4DHgNbSaj62uwoeIZw1OceUfdYkXeO5/FJkmIRAZ4nmR7Kdxq1FOm
	AihAtaoNAnOQSCMjFXu4VeadzJELGT6iBfZKcMggyj5cZPwLWl3FY9ph6Be5P825
	QMmqmE9BKwzXpAC0n1HoFFJ76Y0OjhM5ayFoJKsfXGyUWWdr4X7vgFdc+oi48qaP
	4Xol05RTUQr1+jVGLA/ikGFOG3jURyPUqW+RsjctTuQCGZAFoE8C4Gz5iUUddHm0
	+FM56g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y5tyqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:47:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJFljga008291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:47:45 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 07:47:45 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 19 Nov 2024 07:47:39 -0800
Subject: [PATCH 2/3] wifi: ath11k: mark ath11k_dp_rx_mon_mpdu_pop() as
 noinline
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241119-ath11k-noinline-v1-2-4ec0a8aa30b2@quicinc.com>
References: <20241119-ath11k-noinline-v1-0-4ec0a8aa30b2@quicinc.com>
In-Reply-To: <20241119-ath11k-noinline-v1-0-4ec0a8aa30b2@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        "Nathan
 Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Arnd Bergmann" <arnd@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sw7WdpPCnlm3rNfk5s6_Gdlp0txLOK8r
X-Proofpoint-ORIG-GUID: sw7WdpPCnlm3rNfk5s6_Gdlp0txLOK8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=926 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411190117

When compiling the ath11k driver using clang with KASAN enabled, the
following warning is observed:

drivers/net/wireless/ath/ath11k/dp_rx.c:5244:5: warning: stack frame size (1304) exceeds limit (1024) in 'ath11k_dp_rx_process_mon_status' [-Wframe-larger-than]

This is similar to the issue found in ath12k/qmi.c that was discussed
in [1] and fixed with [2]. The issue is that clang inlining can
explode stack usage.

ath11k_dp_rx_process_mon_status() itself is a pretty
lightweight function, but it dispatches to several other functions
which do the real work:

ath11k_dp_rx_process_mon_status()
	ath11k_dp_rx_reap_mon_status_ring()
	ath11k_dp_rx_mon_dest_process()
		ath11k_dp_rx_mon_mpdu_pop() *
		ath11k_dp_rx_mon_deliver()
			ath11k_dp_rx_mon_merg_msdus()
			ath11k_dp_rx_deliver_msdu()
	ath11k_dp_rx_update_peer_stats()

Of these, only ath11k_dp_rx_mon_mpdu_pop() has non-trivial stack
usage, so mark that function as 'noinline_for_stack' to prevent it
from being inlined in ath11k_dp_rx_process_mon_status(), thereby
eliminating the excessive stack usage.

Link: https://msgid.link/bc214795-1c51-4cb7-922f-67d6ef98bff2@quicinc.com # [1]
Link: https://patch.msgid.link/20241028-ath12k_qmi_driver_event_work-v1-1-0d532eb593fa@quicinc.com # [2]
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 40088e62572e..f253fac116bc 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4690,11 +4690,12 @@ static void ath11k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
 	}
 }
 
-static u32
-ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
-			  void *ring_entry, struct sk_buff **head_msdu,
-			  struct sk_buff **tail_msdu, u32 *npackets,
-			  u32 *ppdu_id)
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
+u32 ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
+			      void *ring_entry, struct sk_buff **head_msdu,
+			      struct sk_buff **tail_msdu, u32 *npackets,
+			      u32 *ppdu_id)
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
 	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&dp->mon_data;

-- 
2.42.0


