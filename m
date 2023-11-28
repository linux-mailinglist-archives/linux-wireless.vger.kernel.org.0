Return-Path: <linux-wireless+bounces-136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 396317FAF6D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 02:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F691F20F0B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 01:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FED15C9;
	Tue, 28 Nov 2023 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p2Mhgd8U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D805294
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 17:13:42 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS0jLb4032114;
	Tue, 28 Nov 2023 01:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zmXrVDwk9PW2eTGFIyou52WJVtdPQELuoB2+agP0haY=;
 b=p2Mhgd8UlvC/oLcF3QDMRQnMuit71WSJXSteG2qxd+z5l7u25Zyuhb5Eon0XNncP7XR6
 vqg4RwIoztPdCl8NTNPtVMIpaPQSUkqy1OHrZJulYHUJi/M/wt4ldytFgCTqhnvntQRL
 c8GANT01L+VoTKqBez5QHzY0Rb5sz5HYH1DIfz7ikYrSmAkhuywhr2hpfMYrzUH1NYRx
 qX57YGYxyQTtrclf+Nhd3eKIC6ABbevYHeEXz6yDhVq4Qkpsg8krM++nUQPjEzFCVn9J
 9u8zudJ7+WAnUTOWjQ07cG4K9jFFZvob+mFChhQnKZuNrr3eULQZ7ZyYZ+s46QBDye7n jw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umt9c1y00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 01:13:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS1DUcS002839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 01:13:30 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 17:13:29 -0800
Message-ID: <7b833b76-13d2-4672-8f70-5ec681648c28@quicinc.com>
Date: Tue, 28 Nov 2023 09:13:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/8] wifi: ath11k: remove MHI LOOPBACK channels
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231127162022.518834-1-kvalo@kernel.org>
 <20231127162022.518834-5-kvalo@kernel.org>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20231127162022.518834-5-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PnEjgTK82t8yS0PAczJNIMkXt5uuzWhE
X-Proofpoint-ORIG-GUID: PnEjgTK82t8yS0PAczJNIMkXt5uuzWhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_01,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxlogscore=928
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311280007



On 11/28/2023 12:20 AM, Kalle Valo wrote:
> From: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> There is no driver to match these two channels, so
> remove them. This fixes warnings from MHI subsystem during suspend:
> 
> mhi mhi0_LOOPBACK: 1: Failed to reset channel, still resetting
> mhi mhi0_LOOPBACK: 0: Failed to reset channel, still resetting
With v2, these warnings are gone even without this patch. so it should 
be removed from commit log. It's enough to only mention that those 
channels are not used.

> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/mhi.c | 56 ---------------------------
>   1 file changed, 56 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
> index afeabd6ecc67..579af57f7377 100644
> --- a/drivers/net/wireless/ath/ath11k/mhi.c
> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
> @@ -21,34 +21,6 @@
>   #define RDDM_DUMP_SIZE	0x420000
>   
>   static struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
> -	{
> -		.num = 0,
> -		.name = "LOOPBACK",
> -		.num_elements = 32,
> -		.event_ring = 0,
> -		.dir = DMA_TO_DEVICE,
> -		.ee_mask = 0x4,
> -		.pollcfg = 0,
> -		.doorbell = MHI_DB_BRST_DISABLE,
> -		.lpm_notify = false,
> -		.offload_channel = false,
> -		.doorbell_mode_switch = false,
> -		.auto_queue = false,
> -	},
> -	{
> -		.num = 1,
> -		.name = "LOOPBACK",
> -		.num_elements = 32,
> -		.event_ring = 0,
> -		.dir = DMA_FROM_DEVICE,
> -		.ee_mask = 0x4,
> -		.pollcfg = 0,
> -		.doorbell = MHI_DB_BRST_DISABLE,
> -		.lpm_notify = false,
> -		.offload_channel = false,
> -		.doorbell_mode_switch = false,
> -		.auto_queue = false,
> -	},
>   	{
>   		.num = 20,
>   		.name = "IPCR",
> @@ -114,34 +86,6 @@ static struct mhi_controller_config ath11k_mhi_config_qca6390 = {
>   };
>   
>   static struct mhi_channel_config ath11k_mhi_channels_qcn9074[] = {
> -	{
> -		.num = 0,
> -		.name = "LOOPBACK",
> -		.num_elements = 32,
> -		.event_ring = 1,
> -		.dir = DMA_TO_DEVICE,
> -		.ee_mask = 0x14,
> -		.pollcfg = 0,
> -		.doorbell = MHI_DB_BRST_DISABLE,
> -		.lpm_notify = false,
> -		.offload_channel = false,
> -		.doorbell_mode_switch = false,
> -		.auto_queue = false,
> -	},
> -	{
> -		.num = 1,
> -		.name = "LOOPBACK",
> -		.num_elements = 32,
> -		.event_ring = 1,
> -		.dir = DMA_FROM_DEVICE,
> -		.ee_mask = 0x14,
> -		.pollcfg = 0,
> -		.doorbell = MHI_DB_BRST_DISABLE,
> -		.lpm_notify = false,
> -		.offload_channel = false,
> -		.doorbell_mode_switch = false,
> -		.auto_queue = false,
> -	},
>   	{
>   		.num = 20,
>   		.name = "IPCR",

