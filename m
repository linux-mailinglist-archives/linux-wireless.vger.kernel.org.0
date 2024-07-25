Return-Path: <linux-wireless+bounces-10516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C493C6B9
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 17:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52B7B21E8A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270F519B3D3;
	Thu, 25 Jul 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CAlRHECA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939219AD81
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922369; cv=none; b=Ru3RYM6QXOsvJ35a76rYI3ZRSfJYYDI5sK7Rrw60upKE3CIbWrGPTkBoAx9sSDKiun8kGzZGqy0r8rJdRNeBnIIYn1AcvMd9s7PIIjbZvlJvbIrTDf8qNbabgGtSDIEnI4ahAWIyT2mBs0aDmy/jE78iO/osmQJt0k9xnTzGRcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922369; c=relaxed/simple;
	bh=igGFGWlSeVSnW8dnBQfaYtuwJLZbh5kWgAqK66gv47o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H6ZxFmUc7ARUTdSLyCFZS0zbeYRx75lr0AAXN2+EllErAFqYCn+7rE8sndeZ3xJCs98bAm72gMqF4kRztbld3mPdUdShqWkIJ+lTB+/ai7sa6t2fddkJJzuVxikZnQn07mNka3D9tXsDkf+C/v6x5epNUpUtZql3RN6tyDRMMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CAlRHECA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P91xPZ016347;
	Thu, 25 Jul 2024 15:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B7P7CNDJ2NEfsMBrkCO+6SYpm45F/5MW9IUB1GrHIjM=; b=CAlRHECAOGWci8dZ
	yVGYX5i+Rsk335wIuyYLFNDIWWo7NINSKjMjZzHT1Pf63fOOK8r1v06IVyzMSORG
	5Seul9SXllcslm9QiAFRzsXdNwd7FTIbHSJ+bG/h1QpXG+lIRIkhQybiVfWxysxG
	XW61fkTvAdraJLN5SvlHgPezBigMGlkIeCkcG47tkhxzS9KDpMMAaA9dyecMkyfn
	vlhSLzdpMfFk7lTEUqDeHZx2j2s+v+FtC9sLQ1ANrAE3pd1a7CoKCXU4IpCS4j1o
	oL6VimAw0ne5fr95egkOEYTJNpRvZKRrLd17yvSGgwsjHCB55yCCHIncSgQZAbAW
	0P8JaA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40gurtv8jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 15:46:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PFjxuK002408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 15:45:59 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 08:45:59 -0700
Message-ID: <75b0db02-b0cd-4265-9c8e-306c2ba75d3b@quicinc.com>
Date: Thu, 25 Jul 2024 08:45:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Support transmit hardware queue stats
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240724042809.3716580-1-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240724042809.3716580-1-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VNOtuUbbWric0WLnAVzr4zOehDvUceC6
X-Proofpoint-ORIG-GUID: VNOtuUbbWric0WLnAVzr4zOehDvUceC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_14,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250108

On 7/23/2024 9:28 PM, Ramya Gnanasekar wrote:
> Add support to request firmware hardware stats through HTT
> stats and display the stats information in debugfs.
> 
> Sample Output:
> -------------
> echo 3 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_reset
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> 
> HTT_TX_HWQ_STATS_CMN_TLV:
> mac_id = 0
> hwq_id = 0
> xretry = 0
> underrun_cnt = 42
> flush_cnt = 0
> filt_cnt = 0
> null_mpdu_bmap = 0
> user_ack_failure = 42
> ack_tlv_proc = 0
> sched_id_proc = 0
> null_mpdu_tx_count = 42
> mpdu_bmap_not_recvd = 0
> num_bar = 0
> rts = 0
> cts2self = 0
> qos_null = 0
> mpdu_tried_cnt = 0
> mpdu_queued_cnt = 42
> mpdu_ack_fail_cnt = 0
> mpdu_filt_cnt = 0
> false_mpdu_ack_count = 0
> txq_timeout = 0
> 
> HTT_TX_HWQ_CMD_RESULT_STATS_TLV:
> cmd_result =  0:42, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0
> 
> HTT_TX_HWQ_CMD_STALL_STATS_TLV:
> cmd_stall_status =  0:0, 1:0, 2:0, 3:0, 4:0
> 
> HTT_TX_HWQ_FES_RESULT_STATS_TLV:
> fes_result =  0:42, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
> 
> HTT_TX_HWQ_STATS_CMN_TLV:
> mac_id = 0
> hwq_id = 1
> xretry = 0
> underrun_cnt = 0
> flush_cnt = 0
> filt_cnt = 0
> null_mpdu_bmap = 0
> user_ack_failure = 0
> ack_tlv_proc = 0
> sched_id_proc = 0
> null_mpdu_tx_count = 0
> mpdu_bmap_not_recvd = 0
> num_bar = 0
> rts = 0
> cts2self = 0
> qos_null = 0
> mpdu_tried_cnt = 0
> mpdu_queued_cnt = 0
> mpdu_ack_fail_cnt = 0
> mpdu_filt_cnt = 0
> false_mpdu_ack_count = 0
> txq_timeout = 0
> 
> .....
> .....
> 
> HTT_TX_HWQ_STATS_CMN_TLV:
> mac_id = 0
> hwq_id = 20
> xretry = 0
> underrun_cnt = 0
> .....
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


