Return-Path: <linux-wireless+bounces-8282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C448D3F0D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 21:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F791F23835
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBCF181CE2;
	Wed, 29 May 2024 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iR1qrBZf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF7167288
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012160; cv=none; b=FTsFlW5fhtE7tDBzdzfnet4ayanLukePxZ+7WSq+KQhQ89ILGREjL3JK1HJu1NlPfFybsjcVR2INXIlH8F4+lGSdm3frQMixe4uPIDqMc2MPkd3BuamFjwZJ0vyqsRisNJoLCgmGlBhgstQViafM39vG112JHN+2pIDk+6QYlv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012160; c=relaxed/simple;
	bh=rj0s/XIrnc9SuFkvnYuFp2Ie8pVMoLumE4NdCLyc6Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UAw4mrPPVC00I+KuGmmAXLdSPBr3cXXDgwi8rUOSOFR3tEGuUd0XzKjp8zXaD5K8SmgmizrjkSM1XjB1m4C3MVAPUeNt0rmG6sS7mqny7wVZM8ocYjsU+EsXJTpIGRxHbvxtkQ3VlUawmUjfUU7gL9/h4w4baFN8J0QAMJv4mTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iR1qrBZf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TBIFng023663;
	Wed, 29 May 2024 19:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MFM8CqFxIyuOBnGz94bCXh+vZIc4PV364ikCyTcMhkU=; b=iR1qrBZfttXkm5pK
	6Hg26U5qikur1NBtZkDzOfeBtKZA3yDvp4NTGMgWTifioajpy11MUhUwQP22hqTR
	UzhcL9hcZJ+Tv1AbLcSzdAc1GBXkXrjOqoEoy7Xo7CGqzFxyvL556ZcK/OdjgFzv
	iqJe8d11/yFKqSdhbKmRk2IZJLqBrkhZRr0wMmy5DtY3FXmcO+SNsvHz6DR24nVb
	iT3PpYwxZDHUhqoLjpc9TERqp9gtWRTskMKDoliksFzpst6Swat7A+qvcNHlU8EP
	THOWHL1ZB6MqADgO7/eNO+hI5kOMaCy5lokuvJ9xe2PQIp0WSFgALIFj/3O0ynJ3
	G/8lxA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2pt8x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 19:49:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TJnCOs025587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 19:49:12 GMT
Received: from [10.110.109.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 12:49:11 -0700
Message-ID: <35652b57-2447-483e-8b8f-bc42a575602e@quicinc.com>
Date: Wed, 29 May 2024 12:49:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Add WMI control path stats infra
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>
References: <20240529180920.1472003-1-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240529180920.1472003-1-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: maPOG8LXEyDpzSDXBCThuqrHKKUe7Ici
X-Proofpoint-ORIG-GUID: maPOG8LXEyDpzSDXBCThuqrHKKUe7Ici
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_15,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=996
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290138

On 5/29/2024 11:09 AM, Ramya Gnanasekar wrote:
> From: Rajat Soni <quic_rajson@quicinc.com>
> 
> Currently, firmware stats is requested by host through HTT interface.
> Since HTT interface is already overloaded for data path stats,
> leveraging control path to request other stats through WMI interface.
> 
> Add debugfs to request the stats and dump the stats forwarded by firmware.
> 
> ath12k
> `-- pci-0000:06:00.0
>     |-- mac0
>         `-- wmi_ctrl_stats
> 
> This patch also adds support to request PDEV Tx stats, parse and dump
> the data sent from firmware.
> 
> Usage:
> echo <stats id> <action> > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/wmi_ctrl_stats
> 
> Sample:
> echo 1 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/wmi_ctrl_stats
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/wmi_ctrl_stats
> WMI_CTRL_PATH_PDEV_TX_STATS:
> fw_tx_mgmt_subtype =  0:0, 1:2, 2:0, 3:0, 4:0, 5:37, 6:0, 7:0, 8:908, 9:0, 10:0, 11:18, 12:2, 13:3, 14:0, 15:0,
> fw_rx_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0,
> scan_fail_dfs_violation_time_ms = 0
> nol_chk_fail_last_chan_freq = 0
> nol_chk_fail_time_stamp_ms = 0
> tot_peer_create_cnt = 7
> tot_peer_del_cnt = 7
> tot_peer_del_resp_cnt = 7
> vdev_pause_fail_rt_to_sched_algo_fifo_full_cnt = 0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> ---
> Depends-On: [PATCH v2 3/5] wifi: ath12k: Fix Pdev id in HTT stats request for WCN7850
> Link: https://lore.kernel.org/linux-wireless/20240510050806.514126-1-quic_rgnanase@quicinc.com
> ---
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


