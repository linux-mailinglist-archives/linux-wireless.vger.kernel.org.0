Return-Path: <linux-wireless+bounces-11936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B395E7F3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 07:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793B41C209BB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 05:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5662E400;
	Mon, 26 Aug 2024 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R9MJpJFx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF748C11
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650436; cv=none; b=KvjndF84GbzGrVR5x4O1AVA8U5UhJNFLNSRVxyvJhia50Rkj+Aa05iqEA4Qp+0siCqw13LYuQGpLgs5EvtV7qtI5YrLt0DaObT1OV74MOu6LfskDU9Z80grs/4fglnS2AaW4xUTGIkM0Kxlp6I4Osho+jsMiYUBtqHeqCR3AQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650436; c=relaxed/simple;
	bh=b0mN9y0Q/PFOJac6vCoulm8TUoOnlT6sN+vrPu/ldak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qMLj7PAOyMXDR9FKaZkizO7dIvQ/of7qavNFBRvPU9yS4bAPNBPYw31Xu4NegUmwi+ho7Csmsv/5TgsJT5FqLgOcScO3+HePFiKt7obA/bLJjNdsm9nYdO08POJ6Y0RySh42JJTPB+tG5Xd1W1DOBgHB7Cn5bCAK25xuOs44/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R9MJpJFx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PMGCIk002126;
	Mon, 26 Aug 2024 05:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=aiVr+YYkpbp6zObIQMjLy+qWSX10e0xMWuRvjsWQykA=; b=R9
	MJpJFxrhOOSld5SN913EaW5/4vWI7LVMW8UMnIhT6b9k0nsAWT61q2yHE6uY9HkJ
	5dplkewysVu4slIjX7JA00XRElaCgkFZM7WNWxSdXStXeH2zI87n2aangahgTuyj
	G/2Nq0BPkdqKvcYMId00FrBa5tCWuicasKxjiSBvsE6+pIzBi8kSwK4NREqb9+uj
	uM9VAoePb/VzWkKmVXV3V8ng+LjmQ8zIk2XPAjj2dXYel6kBnXUq0I0WXQVvLWZ8
	HnWZ3bpIvySSSiJpdZb7QoiPWbrGQ1FtMG3iCG2NR18T1x+/SUKUI6h/CEJ4fpWh
	BbNPe9qVZ+XeurQD4OCA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417988ahkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 05:33:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47Q5Xm2H001421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 05:33:48 GMT
Received: from hu-bpothuno-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 25 Aug 2024 22:33:46 -0700
From: Balaji Pothunoori <quic_bpothuno@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty
	<quic_mpubbise@quicinc.com>,
        Balaji Pothunoori <quic_bpothuno@quicinc.com>
Subject: [PATCH] wifi: ath11k: Fix double free issue during SRNG deinit
Date: Mon, 26 Aug 2024 11:03:26 +0530
Message-ID: <20240826053326.8878-1-quic_bpothuno@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KbcIIO-nWKvi0sR_QA5Iln6LY5mtG9jy
X-Proofpoint-ORIG-GUID: KbcIIO-nWKvi0sR_QA5Iln6LY5mtG9jy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_02,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 suspectscore=0
 mlxlogscore=629 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408260043

From: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

Currently struct ath11k_hal::srng_config pointer is not assigned
to NULL after freeing the memory in ath11k_hal_srng_deinit().
This could lead to double free issue in a scenario where
ath11k_hal_srng_deinit() is invoked back to back.

In the current code, although the chances are very low, the above
said scenario could happen when hardware recovery has failed and
then there is another FW assert where ath11k_hal_srng_deinit() is
invoked once again as part of recovery.

Fix this by assigning the struct ath11k_hal::srng_config pointer
to NULL after freeing the memory.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
---
Resending the original patch as standalone patch:
https://patchwork.kernel.org/project/linux-wireless/patch/20230417054145.12359-2-quic_mpubbise@quicinc.com/

 drivers/net/wireless/ath/ath11k/hal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index f02599bd1c36..61f4b6dd5380 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1351,6 +1351,7 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 	ath11k_hal_free_cont_rdp(ab);
 	ath11k_hal_free_cont_wrp(ab);
 	kfree(hal->srng_config);
+	hal->srng_config = NULL;
 }
 EXPORT_SYMBOL(ath11k_hal_srng_deinit);
 
-- 
2.17.1


