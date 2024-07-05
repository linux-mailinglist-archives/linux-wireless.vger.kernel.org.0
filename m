Return-Path: <linux-wireless+bounces-10002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE3928090
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 04:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E651C20FBA
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 02:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8363367;
	Fri,  5 Jul 2024 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DxJeqADe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A66ECF;
	Fri,  5 Jul 2024 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147668; cv=none; b=kue08TT+XtlqxpP8kosxor6zdCbKD6e3cbC8PdVbNxJ5zRa5nLUkUnmxXzrenjxVD+W21OK95OX+hJc4m1bP2rlM6jEPIxAwv5od6em9Qok9QKPsZCfQfC3BBnFH7xy3kHuULJoe0VplP30ckJpni+viAawM2JuvDSfag6nFSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147668; c=relaxed/simple;
	bh=f0McIqjsWBQADUx1xWkaQx3X8DzvB7aDmb+NakTDKx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EOxEH8PNn6QwPWA8SUP/6EUeI2jjPE9fCJJvzdgRzmYsHmU4aloo8oKkX/tmak7V+ThF5QJBy5qqRNN1mheMUvx1UCQCN6g8PUHqJeFNw63AQd/8ujHdvBxSA+AjfaMvhWpE/H3uMdJqwuarNuXtgDbk8ApwAFQzGFNlLP2l198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DxJeqADe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464NlTE7007685;
	Fri, 5 Jul 2024 02:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MZDju9pB+4L/qZTGVDF9DmV7kuGMW2ssXwY+xyjksLs=; b=DxJeqADehu2qXYAx
	Gen8gvxX/Di9nYDs7XpHcsYrYNuSOGbs0i7mRfgGQ7md8Pl2e2ywlCxy+zW5KwSO
	Zu4N9kjHSPS/6xRczmvKnWFMYmCK/erM9EsqMkX0NKDA4+J2AAw9HC2XQwZ9grWt
	cjDEspjuq/+PcjoNnkodZHIsQoBYowm8szoXxz4O1nBc5n5vM1Y+87fyCY5+73K2
	C4ntd/LGx/NyiCIDeze2Qkclf4bGlTfYtzGjkpiMs18v5ZWJXgyQ2gkub5x8eS/Y
	eCT4sN+OAtSqKM5EB8yCWWNYZVXxjXPFntmXuUSZPMc3WbtHHWr+H56Y96fx8fiX
	xpQqHA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4052yhmbr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 02:47:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4652lRUN009032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 02:47:27 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 4 Jul 2024
 19:47:25 -0700
Message-ID: <462c97dc-f366-4f75-9327-04d9424b819a@quicinc.com>
Date: Fri, 5 Jul 2024 10:47:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Kalle Valo <kvalo@kernel.org>, James Prestwood <prestwoj@gmail.com>,
        <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Chun Wu <chunwu@qti.qualcomm.com>
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
 <1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com> <87iky7mvxt.fsf@kernel.org>
 <37ba6cb0-d887-4fcf-b7dc-c93a5fc5900f@gmail.com> <875xu6mtgh.fsf@kernel.org>
 <f7faff80-864a-4411-ad28-4f1151bc1e51@quicinc.com>
 <082024ce-fdd4-4fb1-8055-6d25f7d2e524@molgen.mpg.de>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <082024ce-fdd4-4fb1-8055-6d25f7d2e524@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d_cU7cvgqZOAhIQCxRLfHpClzKdsHIhk
X-Proofpoint-GUID: d_cU7cvgqZOAhIQCxRLfHpClzKdsHIhk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_21,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 clxscore=1011
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050019



On 6/26/2024 5:12 PM, Paul Menzel wrote:
> Dear Baochen,
> 
> 
> Thank you for your reply.
> 
> Am 26.06.24 um 10:53 schrieb Baochen Qiang:
> 
>> On 6/18/2024 6:33 PM, Kalle Valo wrote:
>>> + baochen
>>>
>>> James Prestwood <prestwoj@gmail.com> writes:
> 
>>>> On 6/17/24 8:27 AM, Kalle Valo wrote:
>>>>> James Prestwood writes:
> 
>>>>>> On 6/16/24 6:10 AM, Paul Menzel wrote:
> 
>>>>>>> Linux 6.10-rc3 (commit a3e18a540541) logged the warning below when
>>>>>>> connecting to a public WiFi:
>>>>>>>
>>>>>>>       ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps nss 2 mcs 9
>>>>>>
>>>>>> This has been reported/discussed [1]. It was hinted that there was a
>>>>>> firmware fix for this, but none that I tried got rid of it. I got fed
>>>>>> up enough with the logs filling up with this I patched our kernel to
>>>>>> remove the warning. AFAICT it appears benign (?). Removing the warning
>>>>>> was purely "cosmetic" so other devs stopped complaining about it :)
>>>>>>
>>>>>> [1] https://www.mail-archive.com/ath10k@lists.infradead.org/msg13406.html
>>>>>
>>>>> More reliable link to the discussion:
>>>>>
>>>>> https://lore.kernel.org/ath10k/76a816d983e6c4d636311738396f97971b5523fb.1612915444.git.skhan@linuxfoundation.org/
>>>>>
>>>>> I think we should add this workaround I mentioned in 2021:
>>>>>
>>>>>      "If the firmware still keeps sending invalid rates we should add a
>>>>>       specific check to ignore the known invalid values, but not all of
>>>>>       them."
>>>>>
>>>>>      https://lore.kernel.org/ath10k/87h7mktjgi.fsf@codeaurora.org/
>>>>>
>>>>> I guess that would be mcs == 7 and rate == 1440?
>>>>
>>>> I think its more than this combination (Paul's are different).
>>>
>>> Good point.
>>>
>>>> So how many combinations are we willing to add here? Seems like that
>>>> could get out of hand if there are more than a few invalid
>>>> combinations.
>>>
>>> Yeah, but there haven't been that many different values reported yet,
>>> right? And I expect that ath10k user base will just get smaller in the
>>> future so the chances are that we will get less reports.
>>>
>>>> Would we also want to restrict the workaround to specific
>>>> hardware/firmware?
>>>
>>> Good idea, limiting per hardware would be simple to implement using
>>> hw_params. Of course we could even limit this per firmware version using
>>> enum ath10k_fw_features, but not sure if that's worth all the extra work.
>>>
>>> Baochen, do you know more about this firmware bug? Any suggestions?
>>
>> OK, there are two issues here:
>>
>> 1. invalid HT rate: "ath10k_pci 0000:02:00.0: invalid ht params rate 1440 100kbps nss 2 mcs 7".
>>
>> As commented by Wen quite some time ago, this has been fixed from
>> firmware side, and firmware newer than [ver:241] has the fix
>> included.
> This is the issue from 2021, correct?
> 
>> 2. invaid VHT rate: "ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps nss 2 mcs 9".
>>
>> After checking with firmware team, I thought this is because there is
>> a mismatch in rate definition between host and firmware: In host, the
>> rate for 'nss 2 mcs 9' is defined as {1560, 1733}, see
>> supported_vht_mcs_rate_nss2[]. While in firmware this is defined as
>> {1730, 1920}. So seems we can update host definition to avoid this
>> issue.
> Looking through the logs since May 2024, I have four different logs:
> 
> 1.  invalid vht params rate 878 100kbps nss 3 mcs 2
which chip are you using when you hit this nss 3 issue? QCA6174 firmware does not support NSS 3 so really weird.

> 2.  invalid vht params rate 960 100kbps nss 1 mcs 9
> 3.  invalid vht params rate 1730 100kbps nss 2 mcs 9
> 4.  invalid vht params rate 1920 100kbps nss 2 mcs 9
OK, these are due to mismatch between host and QCA6174 firmware, we can update host to fix them.

> 
> I believe it’s only happening with Cisco networks. I am happy to test a patch.
> 
> By the way, is the firmware version logged by Linux?
> 
>     ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
>     ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
>     ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp crc32 bf907c7c
>     ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
>     ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
> 
> Is it 4.4.1-00288? How can I find the file in `/lib/firmware/`?
> 
> 
> Kind regards,
> 
> Paul

