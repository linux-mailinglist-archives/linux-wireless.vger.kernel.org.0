Return-Path: <linux-wireless+bounces-9587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C14917B6C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 10:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6001F24457
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338C116630F;
	Wed, 26 Jun 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o2oEClm+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721D8EEC3;
	Wed, 26 Jun 2024 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392032; cv=none; b=OkVMEhww7KKOceIvNivIJM2eftRTS0/LCnODOamM6RrAXCeoztG0Wx0rGkPz/GY2ZCQ3YqMb0jQVOTVcsR1GmYv5ijbPfKpAlNc+ctTeWEeDqOaLFSl90QbNuUOIY6S3A5KKe4XXs8jsv+pl1j+vbUFnC06b/5YroYD6k9v/Wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392032; c=relaxed/simple;
	bh=cbTxet+FZ4Bu2+e7qEqSm8laeIUnXZOfao48nnF/iNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JdcVAfD6ejS9Ex9AEyM8hEjlTAVSCXSEzWgjPvR0NsbjApA3epLO/9+xsFcFdjUTq6SFZ4MrsuA+GrtrsAQfYnsPKwC8WmPR1GkecSHc8atFoljN3NainmiIYKMHgB9WEZGbKRPtuK7TfWKUG2wPVyw3XOF74H15oNy0TcHF/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o2oEClm+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q4anhj001756;
	Wed, 26 Jun 2024 08:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vtiWjzaRVELuAtYmqwTMNPx5ECIiXFHRCQkUzUemNYg=; b=o2oEClm+Rjm0NcdE
	ftM8otmZ/iA3C1qYZvxQCq4DhVpP3rHzwaE7RKsxlMVJxcK+5X8le2ZprCeTBccl
	P117yWt8kanYlCJWrH0LW5pY7zk+zEv1amTYgqLZBn0f2t4kunMGK1SQxj0IgngB
	GVuaMvyJXka5Y/QBs+YGMsGfJDd6BTY/1VWCxRvIKe1b+ockMEwUIQOUuQENUK6t
	F8pHtxMhINh5aYewMes9+a7ok6gLxqZfWoht/QXr4uhn6w+v+2L9TZN86WWEgG2f
	9kowNGL5NVZ4KszT85vlDrpEnDyaKHfL84SNGcgUH0Hic6cRoq5kHd7hCxFgsZM/
	3+73HA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400c468k21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 08:53:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q8rU0F022444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 08:53:30 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 01:53:28 -0700
Message-ID: <f7faff80-864a-4411-ad28-4f1151bc1e51@quicinc.com>
Date: Wed, 26 Jun 2024 16:53:27 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
To: Kalle Valo <kvalo@kernel.org>, James Prestwood <prestwoj@gmail.com>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, <linux-wireless@vger.kernel.org>,
        <ath10k@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
 <1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com> <87iky7mvxt.fsf@kernel.org>
 <37ba6cb0-d887-4fcf-b7dc-c93a5fc5900f@gmail.com> <875xu6mtgh.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <875xu6mtgh.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VFgmVXFK74dkMqecOEk-jiqHlF8M2vwT
X-Proofpoint-GUID: VFgmVXFK74dkMqecOEk-jiqHlF8M2vwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260066



On 6/18/2024 6:33 PM, Kalle Valo wrote:
> + baochen
> 
> James Prestwood <prestwoj@gmail.com> writes:
> 
>> Hi Kalle,
>>
>> On 6/17/24 8:27 AM, Kalle Valo wrote:
>>> James Prestwood <prestwoj@gmail.com> writes:
>>>
>>>> Hi Paul,
>>>>
>>>> On 6/16/24 6:10 AM, Paul Menzel wrote:
>>>>> Dear Linux folks,
>>>>>
>>>>>
>>>>> Linux 6.10-rc3 (commit a3e18a540541) logged the warning below when
>>>>> connecting to a public WiFi:
>>>>>
>>>>>      ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps
>>>>> nss 2 mcs 9
>>>> This has been reported/discussed [1]. It was hinted that there was a
>>>> firmware fix for this, but none that I tried got rid of it. I got fed
>>>> up enough with the logs filling up with this I patched our kernel to
>>>> remove the warning. AFAICT it appears benign (?). Removing the warning
>>>> was purely "cosmetic" so other devs stopped complaining about it :)
>>>>
>>>> [1] https://www.mail-archive.com/ath10k@lists.infradead.org/msg13406.html
>>> More reliable link to the discussion:
>>>
>>> https://lore.kernel.org/ath10k/76a816d983e6c4d636311738396f97971b5523fb.1612915444.git.skhan@linuxfoundation.org/
>>>
>>> I think we should add this workaround I mentioned in 2021:
>>>
>>>     "If the firmware still keeps sending invalid rates we should add a
>>>      specific check to ignore the known invalid values, but not all of
>>>      them."
>>>
>>>     https://lore.kernel.org/ath10k/87h7mktjgi.fsf@codeaurora.org/
>>>
>>> I guess that would be mcs == 7 and rate == 1440?
>>
>> I think its more than this combination (Paul's are different). 
> 
> Good point.
> 
>> So how many combinations are we willing to add here? Seems like that
>> could get out of hand if there are more than a few invalid
>> combinations. 
> 
> Yeah, but there haven't been that many different values reported yet,
> right? And I expect that ath10k user base will just get smaller in the
> future so the chances are that we will get less reports.
> 
>> Would we also want to restrict the workaround to specific
>> hardware/firmware?
> 
> Good idea, limiting per hardware would be simple to implement using
> hw_params. Of course we could even limit this per firmware version using
> enum ath10k_fw_features, but not sure if that's worth all the extra work.
> 
> Baochen, do you know more about this firmware bug? Any suggestions?
OK, there are two issues here:

1. invalid HT rate: "ath10k_pci 0000:02:00.0: invalid ht params rate 1440 100kbps nss 2 mcs 7".

As commented by Wen quite some time ago, this has been fixed from firmware side, and firmware newer than [ver:241] has the fix included.

2. invaid VHT rate: "ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps nss 2 mcs 9".

After checking with firmware team, I thought this is because there is a mismatch in rate definition between host and firmware: In host, the rate for 'nss 2 mcs 9' is defined as {1560, 1733}, see supported_vht_mcs_rate_nss2[]. While in firmware this is defined as {1730, 1920}. So seems we can update host definition to avoid this issue.


> 

