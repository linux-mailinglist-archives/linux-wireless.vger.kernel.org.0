Return-Path: <linux-wireless+bounces-13035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE7197D0A1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 06:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D951C1C2149E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 04:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FF779C2;
	Fri, 20 Sep 2024 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mDfJ2M08"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE95422309
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 04:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726807438; cv=none; b=XJVrAN5lvrg9pYVyLH3CSXj9uG78uQJyamBeHawrW5FMDzyeTfdf1NgmPASfpy0iZauheD/3gS36aDOLpw8pEdtWB3PIo7VveIAcdYSkTzBMTYa4f0VsUop4D8zZIP90tJDSYEAAA5MzHo4lMTvrGbJgM2nW8EvKqrl339xCVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726807438; c=relaxed/simple;
	bh=KYz4gU9+UFrMDiMPGh487Js+k+3NIt1yrhEcEAi0INE=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:CC:
	 In-Reply-To:Content-Type; b=eRemxlO1c5N11EhYP61J1abbRqdnQI8yTDTKPV0sZ+WZy4j/7g9ZkiEEgX20xYGGdXgMA44gkHguHUXfYDLX3VkTj/NoZOq8AE8OPtOozAyXMJC1LTS4ps3Ti7ypIWqqGo+4m+Zou5HweoYY1DvA1O5209M/2MFLRrNkNlzzgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mDfJ2M08; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JJ3rCK022695;
	Fri, 20 Sep 2024 04:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xpRWGD7dSGr/XgSvqmIAk4vXt7jhrYqUrp1WdW/shdY=; b=mDfJ2M08+XRVDHQe
	FkK+LnjUNLr3kFsZVY86tLWuDtBdwIqyBm/8mxbjcTuJ+UoeNovFcK95Zs8bHnSt
	VBjJADx+IHMci9A1yS3ZfaCFjogRHQYFceV7R8auG8IjQhNw6dsb47i51705QnFl
	U9qHTJzqwUU0Hn4/XiHv6JEU0J0lEJ6cBn97w6OjHNnRy0PYEhjgkU7LiM/p06uC
	Demnt7ogzzC5TInOqV1iNKNGHwjsVVM41Azy6bZkdt2NAhpQioDKOz34m0CLBmW8
	w69bcWCB/KkZtnEiWsUE2JrI32E5Aq5hht8UcyqWeFobfx+FgloJiyNIgO7umgnD
	8U7jaQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4gnyqd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 04:43:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48K4hnhl026870
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 04:43:49 GMT
Received: from [10.216.21.130] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Sep
 2024 21:43:47 -0700
Message-ID: <51afbe69-e770-0344-6ca0-0fe5cd721d2d@quicinc.com>
Date: Fri, 20 Sep 2024 10:13:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] wifi: ath12k: fix tx power, max reg power update to
 firmware
Content-Language: en-US
References: <D41LUTO0MIC3.12475D2J3VNX3@gmail.com>
 <93d580b4-cf7a-471f-8f3a-673d456f726f@quicinc.com>
From: Santhosh Ramesh <quic_santrame@quicinc.com>
To: Nicolas Escande <nico.escande@gmail.com>
CC: <quic_santrame@quicinc.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        <quic_murugana@quicinc.com>
In-Reply-To: <93d580b4-cf7a-471f-8f3a-673d456f726f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QpTxwQbQwW6ru8-soRiXoLgkb5DZxSnA
X-Proofpoint-ORIG-GUID: QpTxwQbQwW6ru8-soRiXoLgkb5DZxSnA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=638 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200031

"Nicolas Escande" <nico.escande@gmail.com> writes:
> On Mon Sep 9, 2024 at 9:30 AM CEST, Santhosh Ramesh wrote:
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 137394c36460..6d7a005d83b4 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -7217,9 +7217,9 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
>>  							chandef->chan->band,
>>  							arvif->vif->type);
>>  	arg.min_power = 0;
>> -	arg.max_power = chandef->chan->max_power * 2;
>> -	arg.max_reg_power = chandef->chan->max_reg_power * 2;
>> -	arg.max_antenna_gain = chandef->chan->max_antenna_gain * 2;
>> +	arg.max_power = chandef->chan->max_power;
>> +	arg.max_reg_power = chandef->chan->max_reg_power;
>> +	arg.max_antenna_gain = chandef->chan->max_antenna_gain;
>>  
> 
> For what it's worth, I already got a similar patch from QCA a few month ago, and
> it fixed some tx power problems when scanning so I know there is truth in this.
> 
>>  	arg.pref_tx_streams = ar->num_tx_chains;
>>  	arg.pref_rx_streams = ar->num_rx_chains;
>>
>> base-commit: 903aaf66edc97dd5b9e3118d19677291051a9c40
> 
> But there also was more in the patch:
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index a97e1399eeed..87e3ae49afa5 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -2563,6 +2563,8 @@ int ath12k_wmi_send_scan_chan_list_cmd(struct ath12k *ar,
>  						  WMI_CHAN_REG_INFO1_REG_CLS);
>  			*reg2 |= le32_encode_bits(channel_arg->antennamax,
>  						  WMI_CHAN_REG_INFO2_ANT_MAX);
> +			*reg2 |= le32_encode_bits(channel_arg->maxregpower,
> +						  WMI_CHAN_REG_INFO2_MAX_TX_PWR);
>  
>  			ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
>  				   "WMI chan scan list chan[%d] = %u, chan_info->info %8x\n",
> 
> It seems that ath11k has a similar piece of code in the equivalent function
> ath11k_wmi_send_scan_chan_list_cmd . Isn't this needed ?

This change is in a separate patch, which will be sent for public review soon.

> 
> Also I see that in ath12k/reg.c in ath12k_reg_update_chan_list we also send to
> the firmware:
> 			ch->maxpower = channel->max_power * 2;
> 			ch->maxregpower = channel->max_reg_power * 2;
> 			ch->antennamax = channel->max_antenna_gain * 2;
> 
> As it is in a different wmi message, I guess the units are different. 0.5 dBm
> increment in struct ath12k_wmi_channel_arg right ? Or should we remove the '*2'
> 

Yes, the firmware expects these values in 0.5 dBm increments, so we multiply 
them by 2 in the ath12k_reg_update_chan_list function.

