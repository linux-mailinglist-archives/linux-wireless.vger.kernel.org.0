Return-Path: <linux-wireless+bounces-7173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 616F38BBE3B
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 23:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167BE281766
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CAE84A3B;
	Sat,  4 May 2024 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FPEYMe5P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE63FE5D;
	Sat,  4 May 2024 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714859129; cv=none; b=LH44zZwugv6jRffY4S+/S0os/yycNp4zykweqsh4Q9sb5M0R/3BAUE/S7Dm39SFYnb069LbGT0eIXvLY1kolCP8pV3oc1hfH6B42eVlwsRN462sUfNOS4tuF+q+33V74rra/qJSCvNvhO1ZW1lIQFsb4dnUal9jL+TjcvN8oUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714859129; c=relaxed/simple;
	bh=QRV01anaNxE4mhz0geY6t65Oip3bBcPnYhK8ngLuOXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DhNeYRFMlB1OF35PNy+XHsH/kFNjP1raCwpVJrYL/XJtCbIn8rEtUG3PzjxbHDDLikhaVIuDBEZozB+gCNuzD6lwjChPzuKFoSXtXJRbtd6nZ29ENgRw/GhlisOMp07I8EJFAFnYcPGMIIAj5eVJ29ATTht6JtxxkzgGQ6ulLk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FPEYMe5P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 444LjMex022046;
	Sat, 4 May 2024 21:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=X0DTNHb5cyoWRdUfdaXHgLkbG2fY5hFJfr8EKDrFk9g
	=; b=FPEYMe5PSA8PjwWkG8gn3ckSqeVWN58yw27M+7ol4fwD85FfiYVZGaZ+KZF
	G7FnSfeJTtHPvNlwxAIg7jEwWSM4RTzgil6Qtd5gWWPYdAu+YYM2gBifA47qyLy9
	1DgSi58Roc11WvT0ZSF82RggFfu0Dk1dOPhtorcDBzU64ES3DZrxMj93Ab0VrpUQ
	OsQReHWffBWFI3+pXd5pH0G/JBH9aJJw/tEZJIKkU+SS+1neO6oJW5Y93GI13pAE
	4SvJPmbnNl9EAXUpznthTrQN5I035G7ikqfbg5/do0Q0tkqyslfJ5B8tGO4i+Qr9
	+N317zNv6Xjpiz9J8NYJM01vPuw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwc1c14e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 21:45:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 444LjLYF001237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 4 May 2024 21:45:21 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 4 May 2024
 14:45:19 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 4 May 2024 14:45:18 -0700
Subject: [PATCH 2/2] wifi: ath12k: initialize 'ret' in
 ath12k_dp_rxdma_ring_sel_config_wcn7850()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-2-44d2843a2857@quicinc.com>
References: <20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-0-44d2843a2857@quicinc.com>
In-Reply-To: <20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-0-44d2843a2857@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C9VRFUXFJNhB7HgPu4ctg6i_cZRCkQx3
X-Proofpoint-ORIG-GUID: C9VRFUXFJNhB7HgPu4ctg6i_cZRCkQx3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=895 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405040139

smatch flagged the following issue:

drivers/net/wireless/ath/ath12k/dp_rx.c:4065 ath12k_dp_rxdma_ring_sel_config_wcn7850() error: uninitialized symbol 'ret'.

In ath12k_dp_rxdma_ring_sel_config_wcn7850() if it were ever the case
that ab->hw_params->num_rxdma_per_pdev was 0 then 'ret' would be
uninitialized when it is returned. This should never be the case, but
to be safe and to quiet smatch, add an initializer to the declaration
of 'ret'.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 2adcb4238c3e..188a4e422909 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -4029,7 +4029,7 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 	struct ath12k_dp *dp = &ab->dp;
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	u32 ring_id;
-	int ret;
+	int ret = 0;
 	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
 	int i;
 

-- 
2.42.0


