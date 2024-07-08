Return-Path: <linux-wireless+bounces-10065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1172D929A9B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 03:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FF21F2110A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 01:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202F8EDB;
	Mon,  8 Jul 2024 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GwR0TTKr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F112EC7;
	Mon,  8 Jul 2024 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720403621; cv=none; b=ml+O2BHap8+UZL9nO6Na7K7LbyxXnhpwaYOoeRxFnNXITl5WZu8mO2bWU8JwfcorXTlzQOD3AUmxn44YqDws/Ttqahg8X95eRhKSFODrT/YD548oLnKvethIughfAapl54caY934GjmfDBh0V4p/rO0yu12SGertIj4XfJIGJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720403621; c=relaxed/simple;
	bh=y7NC+pcsRcBECH1Ri/X1ow8Ix8NmkrK6fPPI2pRQf7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O2QNtbd5S9iQIMTiz39nuY7onHdJhpSBhDY/U8vweEXRvzo1imAM2qWkBevEGtJVDC7U+3Rs6Q/bR9lIU7oAuM3aIPyGQ01wNNcjqCs4VSAC+0uWCvVkkL08TV6X39qN13vhVqiZJ9JxSi32+Hynvd2ovzPB8Tnz8nAC81mgE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GwR0TTKr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4680TfPG006130;
	Mon, 8 Jul 2024 01:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1JWkPTMjo7oprM/b4876gJfs5NLaGg/ZrXqWHPtPzfg=; b=GwR0TTKrje3lU/7X
	1LmHhCQVvpakM0OXoZrRvnR28IlSrsfOLd7j/3Z5bapPt5kWYyxD0R5XJGc3Yhb0
	hHYMcUNrCSoKEoOVFolLKuQkLxnInMVZzS+3Pg4bZC9qZVvjYKiIl684YML2Ve56
	TQmBDCOPEC4KqQGgI8M1mMat5Q09Sx6CJ/2qgAKFynMCiFCz0YZtZJpqXg122FhB
	k7eOdwPAx1Imv4q2gD+n65IxBVnkmU2aErQELCMtVA73NVokOy7Emvo3QTEzlcVg
	BbyTHrV3msW2VqDSCf0pWmHeNUr4i0kglLtQ8e6qOohlBpBXLft+hTbpO2jQGmbX
	dew3sA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa62c9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 01:53:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4681rCGt006062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 01:53:12 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 7 Jul 2024
 18:53:10 -0700
Message-ID: <82e10a1a-ed23-4d5c-b691-02e39296a91e@quicinc.com>
Date: Mon, 8 Jul 2024 09:53:08 +0800
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
 <462c97dc-f366-4f75-9327-04d9424b819a@quicinc.com>
 <b30307fd-4417-4220-a3ac-e3e80f23105e@molgen.mpg.de>
 <ceddb62b-61dd-44c9-babd-cd375c5a147d@quicinc.com>
 <fb8acc69-89aa-4b26-91b4-e768ae4c2238@molgen.mpg.de>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <fb8acc69-89aa-4b26-91b4-e768ae4c2238@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7RwnUIHM_1d2NjAB57jgILEAW2tRyCXK
X-Proofpoint-ORIG-GUID: 7RwnUIHM_1d2NjAB57jgILEAW2tRyCXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_10,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080013



On 7/5/2024 7:52 PM, Paul Menzel wrote:
> 
> Dear Baochen,
> 
> 
> Am 05.07.24 um 12:51 schrieb Baochen Qiang:
>>
>>
>> On 7/5/2024 2:55 PM, Paul Menzel wrote:
> 
>>> Am 05.07.24 um 04:47 schrieb Baochen Qiang:
>>>
>>>> On 6/26/2024 5:12 PM, Paul Menzel wrote:
>>>
>>>>> Am 26.06.24 um 10:53 schrieb Baochen Qiang:
>>>>>
>>>>>> On 6/18/2024 6:33 PM, Kalle Valo wrote:
>>>>>>> + baochen
>>>>>>>
>>>>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>>
>>>>>>>> On 6/17/24 8:27 AM, Kalle Valo wrote:
>>>>>>>>> James Prestwood writes:
>>>>>
>>>>>>>>>> On 6/16/24 6:10 AM, Paul Menzel wrote:
>>>
>>>>>>>>>>> Linux 6.10-rc3 (commit a3e18a540541) logged the warning below when
>>>>>>>>>>> connecting to a public WiFi:
>>>>>>>>>>>
>>>>>>>>>>>         ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps nss 2 mcs 9
>>>>>>>>>>
>>>>>>>>>> This has been reported/discussed [1]. It was hinted that there was a
>>>>>>>>>> firmware fix for this, but none that I tried got rid of it. I got fed
>>>>>>>>>> up enough with the logs filling up with this I patched our kernel to
>>>>>>>>>> remove the warning. AFAICT it appears benign (?). Removing the warning
>>>>>>>>>> was purely "cosmetic" so other devs stopped complaining about it :)
>>>>>>>>>>
>>>>>>>>>> [1] https://www.mail-archive.com/ath10k@lists.infradead.org/msg13406.html
>>>>>>>>>
>>>>>>>>> More reliable link to the discussion:
>>>>>>>>>
>>>>>>>>> https://lore.kernel.org/ath10k/76a816d983e6c4d636311738396f97971b5523fb.1612915444.git.skhan@linuxfoundation.org/
>>>>>>>>>
>>>>>>>>> I think we should add this workaround I mentioned in 2021:
>>>>>>>>>
>>>>>>>>>        "If the firmware still keeps sending invalid rates we should add a
>>>>>>>>>         specific check to ignore the known invalid values, but not all of
>>>>>>>>>         them."
>>>>>>>>>
>>>>>>>>>        https://lore.kernel.org/ath10k/87h7mktjgi.fsf@codeaurora.org/
>>>>>>>>>
>>>>>>>>> I guess that would be mcs == 7 and rate == 1440?
>>>>>>>>
>>>>>>>> I think its more than this combination (Paul's are different).
>>>>>>>
>>>>>>> Good point.
>>>>>>>
>>>>>>>> So how many combinations are we willing to add here? Seems like that
>>>>>>>> could get out of hand if there are more than a few invalid
>>>>>>>> combinations.
>>>>>>>
>>>>>>> Yeah, but there haven't been that many different values reported yet,
>>>>>>> right? And I expect that ath10k user base will just get smaller in the
>>>>>>> future so the chances are that we will get less reports.
>>>>>>>
>>>>>>>> Would we also want to restrict the workaround to specific
>>>>>>>> hardware/firmware?
>>>>>>>
>>>>>>> Good idea, limiting per hardware would be simple to implement using
>>>>>>> hw_params. Of course we could even limit this per firmware version using
>>>>>>> enum ath10k_fw_features, but not sure if that's worth all the extra work.
>>>>>>>
>>>>>>> Baochen, do you know more about this firmware bug? Any suggestions?
>>>>>>
>>>>>> OK, there are two issues here:
>>>>>>
>>>>>> 1. invalid HT rate: "ath10k_pci 0000:02:00.0: invalid ht params rate 1440 100kbps nss 2 mcs 7".
>>>>>>
>>>>>> As commented by Wen quite some time ago, this has been fixed from
>>>>>> firmware side, and firmware newer than [ver:241] has the fix
>>>>>> included.
>>>>> This is the issue from 2021, correct?
>>>>>
>>>>>> 2. invaid VHT rate: "ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps nss 2 mcs 9".
>>>>>>
>>>>>> After checking with firmware team, I thought this is because there is
>>>>>> a mismatch in rate definition between host and firmware: In host, the
>>>>>> rate for 'nss 2 mcs 9' is defined as {1560, 1733}, see
>>>>>> supported_vht_mcs_rate_nss2[]. While in firmware this is defined as
>>>>>> {1730, 1920}. So seems we can update host definition to avoid this
>>>>>> issue.
>>>>> Looking through the logs since May 2024, I have four different logs:
>>>>>
>>>>> 1.  invalid vht params rate 878 100kbps nss 3 mcs 2
>>>>
>>>> which chip are you using when you hit this nss 3 issue? QCA6174
>>>> firmware does not support NSS 3 so really weird.
>>>
>>> This is all from the same device Dell XPS 13 9360 with QCA6174 and firmware 288.
>>>
>>> ```
>>> Mai 20 12:07:09 abreu kernel: Linux version 6.9.0-09705-g08b269af52c0 (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.2.0-23) 13.2.0, GNU ld (GNU Binutils for Debian) 2.42) #147 SMP PREEMPT_DYNAMIC Mon May 20 07:33:23 CEST 2024
>>> […]
>>> Mai 20 12:07:11 abreu kernel: ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp crc32 bf907c7c
>>> […]
>>> Mai 20 15:37:55 abreu wpa_supplicant[613]: wlp58s0: Trying to associate with e2:b3:70:83:01:af (SSID='public' freq=5500 MHz)
>>> […]
>>> Mai 20 15:37:55 abreu kernel: wlp58s0: authenticate with e2:b3:70:83:01:af (local address=9c:b6:d0:d1:6a:b1)
>>> Mai 20 15:37:55 abreu kernel: wlp58s0: send auth to e2:b3:70:83:01:af (try 1/3)
>>> Mai 20 15:37:55 abreu kernel: wlp58s0: authenticated
>>> Mai 20 15:37:55 abreu kernel: wlp58s0: associate with e2:b3:70:83:01:af (try 1/3)
>>> Mai 20 15:37:55 abreu kernel: wlp58s0: RX AssocResp from e2:b3:70:83:01:af (capab=0x1501 status=0 aid=4)
>>> […]
>>> Mai 20 15:39:29 abreu wpa_supplicant[613]: wlp58s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-55 noise=-97 txrate=300000
>>> […]
>>> Mai 20 15:54:44 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht params rate 878 100kbps nss 3 mcs 2
>>> ```
>>>
>>> It was some public WiFi in some restaurant. No idea, what hardware
>>> they use. Maybe you can deduce this from the MAC address.
>>
>> Then it is QCA6174 definitely.
> Sorry, I meant, I do not know, what the access points were.
Sorry, I commented at the wrong line :(

I was meaning the station you were using (i.e, the one you hit this issue) is QCA6174.

> 
>> Checked with firmware team and just know that, the TX rate info is
>> generated by firmware directly but for RX rate it is from phy side.
>> From firmware TX rate generation code seems NSS 3 is an impossible
>> value, so it might be an RX rate generated by phy side. But I could
>> not tell for now since the log is not complete. Paul, could you
>> enable full ath10k log and try to reproduce? With full log we can
>> check whether it is a RX rate issue,
> 
> Please tell me how I enable full logging. 
once boot, first unload ath10k modules by 

sudo modprobe -r ath10k_pci

then load ath10k modules with

sudo modprobe ath10k_core debug_mask=0xffffffff
sudo modprobe ath10k_pci

you should see lots of prints now

Also, I cannot promise I am going to be in the area with that WiFI in the next weeks.
Never mind.

> 
>>>>> 2.  invalid vht params rate 960 100kbps nss 1 mcs 9
>>>>> 3.  invalid vht params rate 1730 100kbps nss 2 mcs 9
>>>>> 4.  invalid vht params rate 1920 100kbps nss 2 mcs 9
>>>>
>>>> OK, these are due to mismatch between host and QCA6174 firmware, we
>>>> can update host to fix them.
>>
>> Kalle, the root cause to these three warnings are clear now and if
>> you agree I can submit patches to fix them. Or I can also wait until
>> the NSS 3 issue is clear.
> 
> Don’t hold your breath, that I am going to be able to get to the public WiFi network for 1. in the next weeks.
> 
>>> Nice. If there would be a test framework to test this, so I do not
>>> have to search for a Cisco network, that’d be great. >>
>>>>> I believe it’s only happening with Cisco networks. I am happy
>>>>> to test a patch.
> 
> Kind regards,
> 
> Paul

