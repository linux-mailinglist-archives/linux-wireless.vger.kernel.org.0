Return-Path: <linux-wireless+bounces-3890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F9885EF17
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 03:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56DA1F220CE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 02:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD21125B4;
	Thu, 22 Feb 2024 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IgT2pGFL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29865111B2
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708568346; cv=none; b=n894BV69iBqN7ByhHFG8s5iKuOYD+NcrGUAE3F4wL9YUuTfdLpaWkBs79OKPzW6irUGO1shTOtfa5tIu67ka6ZI/H8VeXelSBvTljN5Fusg9BPX0ETszVKIJcA2DtdPkVDiEFMJepyR+b/0U1BtEZb0VsQybVFAZMss1u49lyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708568346; c=relaxed/simple;
	bh=ofCaiGyvmfm8tDxX8cC1M7/1MUSyo4AA6DTrM9DemzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YsiYbc0tKf5NoSxlFVg4RE3KLwHnEt/vxaVvuF2MUPoqfTSYvpQl6py5wLAZlwhLm2dtpTOTtdguOtevll48mBZbeFooSZ4FpPVr6yUSf1H9dSKsJoVmMontvPRsfeRcNs4CUNAkMnAT7em2GaDpgL9Z4q8+KjZWN85xiDlc7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IgT2pGFL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M2GZAd014672;
	Thu, 22 Feb 2024 02:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ql9ttM3rKe6EnnK/aKnq7HzPNy/fJQHcEhzfXSLmaJs=; b=Ig
	T2pGFLRk0iumy2/nyUODef6Pc80M8wt3d4JlGwCr5EcPiivODyWHaBTwWf1Q36kn
	q9HveJ1KsMrTSmvZfFoNlSNhtQDCmfD/0pY7YfP8ZfTFKF+gko0lZqZrkGalsMYr
	HHnXzsM1Cx4qRe6p9CF8fFWzTJJsxuy+furLA7T9wshJYeNoNNMhlZrD2wDCiQUL
	KrYKGtHCqZ1WiKH2yMAMfcSi2Ya3TdD+S8paN9hscqwkq9tbP3lYgjU/9geIa5PP
	Wqj19/x090CCoriPeycClcfUNyVUBPlFgkLPmDAuPSFVVJ5eXwmoxmZTlInpx2ch
	4VKwPgFDu/mkJR+zCrpQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdvseg266-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 02:18:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M2Ixd5016364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 02:18:59 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 18:18:57 -0800
Message-ID: <0ee7ae2f-8034-4908-b6e3-fa17a995c661@quicinc.com>
Date: Thu, 22 Feb 2024 10:18:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: poll service ready message before failing
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240221031729.2707-1-quic_bqiang@quicinc.com>
 <d67fb4f4-aea2-4668-aac4-6e7eca8db4fa@gmail.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <d67fb4f4-aea2-4668-aac4-6e7eca8db4fa@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vBaF4_VFcJRNW6blg8bGEQGS1q-u2-aL
X-Proofpoint-GUID: vBaF4_VFcJRNW6blg8bGEQGS1q-u2-aL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_10,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402220015



On 2/21/2024 8:38 PM, James Prestwood wrote:
> Hi Baochen,
> 
> On 2/20/24 7:17 PM, Baochen Qiang wrote:
>> Currently host relies on CE interrupts to get notified that
>> the service ready message is ready. This results in timeout
>> issue if the interrupt is not fired, due to some unknown
>> reasons. See below logs:
>>
>> [76321.937866] ath10k_pci 0000:02:00.0: wmi service ready event not 
>> received
>> ...
>> [76322.016738] ath10k_pci 0000:02:00.0: Could not init core: -110
>>
>> And finally it causes WLAN interface bring up failure.
>>
>> Change to give it one more chance here by polling CE rings,
>> before failing directly.
>>
>> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
>>
>> Fixes: 5e3dd157d7e7 ("ath10k: mac80211 driver for Qualcomm Atheros 
>> 802.11ac CQA98xx devices")
>> Reported-by: James Prestwood <prestwoj@gmail.com>
>> Link: 
>> https://lore.kernel.org/linux-wireless/304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com/
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath10k/wmi.c | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c 
>> b/drivers/net/wireless/ath/ath10k/wmi.c
>> index ddf15717d504..bf6cb2c73128 100644
>> --- a/drivers/net/wireless/ath/ath10k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
>> @@ -1763,12 +1763,28 @@ void ath10k_wmi_put_wmi_channel(struct ath10k 
>> *ar, struct wmi_channel *ch,
>>   int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
>>   {
>> -    unsigned long time_left;
>> +    unsigned long time_left, i;
>>       time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
>>                           WMI_SERVICE_READY_TIMEOUT_HZ);
>> -    if (!time_left)
>> -        return -ETIMEDOUT;
>> +    if (!time_left) {
>> +        /* Sometimes the PCI HIF doesn't receive interrupt
>> +         * for the service ready message even if the buffer
>> +         * was completed. PCIe sniffer shows that it's
>> +         * because the corresponding CE ring doesn't fires
>> +         * it. Workaround here by polling CE rings once.
>> +         */
>> +        ath10k_warn(ar, "failed to receive service ready completion, 
>> polling..\n");
>> +
>> +        for (i = 0; i < CE_COUNT; i++)
>> +            ath10k_hif_send_complete_check(ar, i, 1);
>> +
>> +        time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
>> +                            WMI_SERVICE_READY_TIMEOUT_HZ);
>> +        if (!time_left)
>> +            return -ETIMEDOUT;
>> +    }
>> +
>>       return 0;
>>   }
>>
>> base-commit: 707e306f3573fa321ae197d77366578e4566cff5
> 
> Thank you for looking at this I will test this and see if it resolves 
> the problem we're seeing but since its somewhat rare it may take me a 
> bit to validate.
> 
> Is this any different than just trying to bring up the interface again 
> from userspace? I could be wrong, but my concern with this is that when 
> I retried in userspace things got into a very odd state:
> 
>   - IWD starts
> 
>   - ifdown interface
> 
>   - ifup interface, timeout -110
> 
>   - Retry ifup, success
> 
>   - Authenticate/associate succeed
> 
>   - 4-way handshake fails because the device never received the 1/4 frame.
> 
Don't get time to look into this case, but I suppose there might be some 
issues in error handling when interface up fails, kind of incorrect irq 
enable/disable or something else impacting data path, so no data frame 
received even after a second interface up retry succeeds,

Anyway please test this patch, which is supposed to be the right fix to 
this issue.

> IWD would then retry indefinitely with auth/assoc succeeding but never 
> receiving any 4-way handshake frames. The only way to get things working 
> again was reloading the ath10k driver/reboot. Maybe this patch is 
> different because its waiting for the initial request and no issuing a 
> second one? Just wanted to point that out in case it sheds any light.
> 
> Thanks,
> 
> James
> 

