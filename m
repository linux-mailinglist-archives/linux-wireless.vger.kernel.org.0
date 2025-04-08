Return-Path: <linux-wireless+bounces-21255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F05A7F92E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 11:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FD53A9864
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104D686352;
	Tue,  8 Apr 2025 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pwh7rr3f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14444249F9
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103830; cv=none; b=L4leg4q2JDgDMxD3S7oecguhq8stwJG3uT4JKoldAylSsgz2929y86jlAVjpViCSgwoGbIWq+J6hmR3V2C6gQ+BOlFaacxeVuPpTRfgfxF2HBrF/AwiTwK07lIqD6fq1PRHZEZH+IhzNr0ztY0jK5pQs4sNRtyesStWNomtdPT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103830; c=relaxed/simple;
	bh=lUOOUG/E/QJiY5o+isw5i4bDLYNLE58fz2BGVMcqVDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mfSQuhVP6nRVOp7LlvhrfpBxmIdUoHORGsmeiaLqv9sIrh0RS2N2EiV0bcDz+5be4YMwl+QWZS/bePmTSj9jSVOY0nBZqX4IgWL9eb8UQOjZwrcMk6aP2yGGKN4JlBBVdWwhkPCL3sv5oO8AqGtEjbnP4M90wHxSWQH70YRn/lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pwh7rr3f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GYYs010566;
	Tue, 8 Apr 2025 09:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1PvFVa7gvkOmuYC5zXwl8OMogZpesDaSb/Rsk0be6Tk=; b=Pwh7rr3f51P3dWQY
	191WKV9Gmdw/ZLlwZBhH8Sk+ldx6VR/svSGS/CLKzfJMtDRfnh3yOFEy8xONOprj
	Vx9e0Y3snCn3QmiWZ0bG4cKN6xMiNzZW8h1hKYv4sTbMfFq6+0KozDf8Xgy6tD/b
	Gk4Du0bPnxbiAnFWTacuAaNLXTGJMyny2UXYV1I9CdAgNC2hNdsQfNDlqo40ZcEE
	3W2kt63r8GaIfhys1v/URcNzBwV4vW7J8w580GuVgERyUia4BiF1lpbMmvctZTXM
	qtY7pislglF7o43AHGdbzwSYe8kA4KMTPMHHVavLKJ7oIE4fLMKLPX8/8Yutuvec
	cQi7Hg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1f426-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 09:17:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5389H1rn018301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 09:17:01 GMT
Received: from [10.133.33.131] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 02:16:59 -0700
Message-ID: <16ccbe02-b315-40d1-8600-232b592d4dd6@quicinc.com>
Date: Tue, 8 Apr 2025 17:16:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k: No 6GHz Wireless found
To: Walt Holman <waltholman09@gmail.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
References: <CAMb39_ngQs8=FUML5QXMh2RmEZBZ2NwUHefhGoTkGtHat+KWJA@mail.gmail.com>
 <f45323db-ce4d-4374-9c93-0be4d0645fcd@oss.qualcomm.com>
 <CAMb39_ki7F1XgezyVfb9Tkm9D-FZE0XK3RcSYtFmFf0jP8-M_Q@mail.gmail.com>
 <dc0abf98-862b-47f5-ae71-749c68cffc73@quicinc.com>
 <CAMb39_kUUv24q6QUq9B9+TEUMrUhu12-8WJadzB53nMPhcAZSQ@mail.gmail.com>
 <ef81db9e-99cb-4802-b17f-94eb623a8b32@quicinc.com>
 <CAMb39_m+4dNBDbkZmn-rDA7T+u84y-dx1jSfmPNWnse=R1=gCw@mail.gmail.com>
 <18788f02-e374-4aa6-ac4a-fd53bc93754c@quicinc.com>
 <CAMb39_=G_TEL1pbeF_PAZLQh-JOFcncSfqZChPmEj63NjsEOLA@mail.gmail.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <CAMb39_=G_TEL1pbeF_PAZLQh-JOFcncSfqZChPmEj63NjsEOLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I5HRD1O0krBpqUTqesYRWXcn-dkWgyIN
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f4e98e cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=uwoirNMxE0jC0tTp6k8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: I5HRD1O0krBpqUTqesYRWXcn-dkWgyIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080066



On 4/8/2025 1:49 AM, Walt Holman wrote:
> Attached is a small packet capture where I did an 'iw wlp99s0 scan'
> and also deactivated and reactivated wireless while the scan was
> ongoing. Hopefully there's something interesting for you in there.
> Also, I've take 3 screenshots showing the configs of the wireless AP
> for the 6ghz network. The first screen is just the definition of the
> network. No advanced settings are used. The 2nd screen shows the
> channels and radio enabled. The 3rd screen has the advanced
> (professional) settings for the network. I believe I changed 'Agile
> Multiband' to enabled, but other settings are their defaults. Hope
> some of this helps. Let me know if you need anything else. Thanks,
> 

Your packets are Ethernet packets. I need wireless packets.


Not sure if you know how to add a seperate monitor interface to capture 
6 G channels' packet on your AP(you can google for specific command).


Also, please capture firmware log:

1. sudo apt install trace-cmd
2. sudo trace-cmd record -e ath12k_wmi_diag
3. run test
4. "ctrl c" to stop recording:
Hit Ctrl^C to stop recording
^CCPU0 data recorded at offset=0xdf5000
     2605056 bytes in size
Then share the trace.dat to us.

So you need to:
1. try to capture wireless packets.
2. capture firmware log(trade.data).
3. save kernel/wpa_supplicant/iw logs.





> -Walt
> 
> On Sun, Apr 6, 2025 at 8:58 PM Kang Yang <quic_kangyang@quicinc.com> wrote:
>>
>>
>>
>> On 4/4/2025 12:04 AM, Walt Holman wrote:
>>> On Thu, Apr 3, 2025 at 3:20 AM Kang Yang <quic_kangyang@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/3/2025 1:48 AM, Walt Holman wrote:
>>>>> On Tue, Apr 1, 2025 at 9:48 PM Kang Yang <quic_kangyang@quicinc.com> wrote:
>>>>
>>>>>>
>>>>>> Test on 6.14.0-rc5-wt-ath+, with the firmware you used.
>>>>>> I can get 6 GHz AP and connect to it.
>>>>>>
>>>>>> ath12k_pci 0000:03:00.0: fw_version 0x100301e1 fw_build_timestamp
>>>>>> 2023-12-06 04:05 fw_build_id
>>>>>> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>>>>
>>>>>> yk@yk-Mayan:~$ sudo iw wls1 scan | tee iw_scan.log:
>>>>>> BSS 62:03:7f:12:64:64(on wls1) -- associated
>>>>>>             TSF: 606308271476 usec (7d, 00:25:08)
>>>>>>             freq: 6275
>>>>>>             beacon interval: 100 TUs
>>>>>>             capability: ESS Privacy SpectrumMgmt ShortSlotTime (0x0511)
>>>>>>             signal: -17.00 dBm
>>>>>>             last seen: 52 ms ago
>>>>>>             Information elements from Probe Response frame:
>>>>>>             SSID: MLO-KANG-6G
>>>>>> and other 6 GHz APs:
>>>>>>            SSID: 6G-gxia
>>>>>>            SSID: NETGEAR97-6G
>>>>>>            ……
>>>>>>
>>>>>>
>>>>>> kernel log:
>>>>>> [88158.033218] wls1: Inserted STA 62:03:7f:12:64:64
>>>>>> [88158.033232] wls1: authenticate with 62:03:7f:12:64:64 (local
>>>>>> address=00:03:7f:37:12:54)
>>>>>> [88158.033242] wls1: send auth to 62:03:7f:12:64:64 (try 1/3)
>>>>>> [88158.041895] wls1: authenticated
>>>>>> [88158.041914] wls1: moving STA 62:03:7f:12:64:64 to state 2
>>>>>> [88158.044291] wls1: determined local STA to be EHT, BW limited to 320 MHz
>>>>>> [88158.045719] wls1: associate with 62:03:7f:12:64:64 (try 1/3)
>>>>>> [88158.067045] wls1: RX AssocResp from 62:03:7f:12:64:64 (capab=0x511
>>>>>> status=0 aid=4)
>>>>>> [88158.089090] wls1: associated
>>>>>>
>>>>>> I can even connect to it by Ubuntu GUI.
>>>>>>
>>>>>> Can you update to 6.14.0-rc5-wt-ath+ and have a retry? Also please make
>>>>>> sure that your wpa_supplicant/iw support 6 GHz(or directly update to the
>>>>>> latest version).
>>>>>>
>>>>>> If you still cannot find 6 GHz AP, you can set debug_mask to 0xffffffff
>>>>>> to get ath12k logs. Then give it to us.
>>>>>>
>>>>>>
>>>>>>> -Walt
>>>>>>>
>>>>>>
>>>>>
>>>>> OK, I retested with the wt-ath 033125 tagged build. This included the
>>>>> patch the Jeff suggested I try, but the rest of the tree was clean.
>>>>> Still no 6ghz Wifi. I'm attaching a log file of the boot and first few
>>>>> seconds with the debug mask turned on. I noticed that if I rmmod the
>>>>> module and then modprobe it, it complains about not finding
>>>>> firmware-2.bin, however, I thought that was only for the qcn based
>>>>> chip? The HW info from dmesg looks like this:
>>>>>
>>>>
>>>> I cannot find this tag...
>>>>
>>>>
>>>>    From the log, the 6 GHz channel should work. When scan is triggered, FW
>>>> shall send probe req on these channels. If AP send probe resp, station
>>>> shall find the AP.
>>>>
>>>>
>>>>
>>>>
>>>>> [    6.070282] ath12k_pci 0000:63:00.0: BAR 0 [mem
>>>>> 0xdd800000-0xdd9fffff 64bit]: assigned
>>>>> [    6.070310] ath12k_pci 0000:63:00.0: enabling device (0000 -> 0002)
>>>>> [    6.071249] ath12k_pci 0000:63:00.0: MSI vectors: 16
>>>>> [    6.071254] ath12k_pci 0000:63:00.0: Hardware name: wcn7850 hw2.0
>>>>> [    6.596331] ath12k_pci 0000:63:00.0: qmi dma allocation failed
>>>>> (7077888 B type 1), will try later with sma
>>>>> ll size
>>>>> [    6.604041] ath12k_pci 0000:63:00.0: chip_id 0x2 chip_family 0x4
>>>>> board_id 0xff soc_id 0x40170200
>>>>> [    6.604044] ath12k_pci 0000:63:00.0: fw_version 0x100301e1
>>>>> fw_build_timestamp 2023-12-06 04:05 fw_build_id
>>>>> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-
>>>>>
>>>>> Also, I noticed when looking through the debug logs there are the
>>>>> occasional WARNING statements from a BUG it appears. They trace back
>>>>> to the mac.c file inside the ath12k code. There should be some in the
>>>>> debug log that's attached. Let me know if I can do anything else.
>>>>> Thanks,
>>>>>
>>>>
>>>>
>>>> I have never seen this warning on my upstream setup...Not sure if you
>>>> have changed anything or using the correct code base.
>>>>
>>>> Jeff merged this patch-set into ath-202504021602. Can you try on this
>>>> branch?
>>>>
>>>> git clone https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/
>>>> git pull
>>>> git reset --hard ath-202504021602
>>>> compile and install...
>>>>
>>>> Also make sure that the firmware you used is from the same folder, don't
>>>> mix with other folders:
>>>> linux-firmware/ath12k/WCN7850/hw2.0
>>>>
>>>> 1. rmmod/insmod(debug_mask=0xffff)
>>>> 2. iw reg get
>>>> 3. iw reg set US
>>>> 4. iw xxx scan
>>>> wait and collect logs.
>>>>
>>>> don't do anything else.
>>>>
>>>>
>>>> Also, can you show me your AP configuration.
>>>> If you have another 6 GHz AP, you can have a try(better different brands).
>>>>
>>
>> Thanks for testing.
>>
>> Could you share your AP configuration?
>>
>>
>>>>
>>>> If you have sniffer, could please capture packets during testing?
>>
>>
>> Can you capture packets during the testing? I need to check probe req
>> and probe resp.
>>
>>>>
>>>> Thanks!
>>>>
>>>>> -Walt
>>>>
>>> OK, I cloned and built the kernel based on your instructions in your
>>> last email. Originally, the result was identical to my last email,
>>> including the WARNINGS. The .config I use is configured for a fully RT
>>> PREEMPT kernel, which I wondered if that was why I was receiving the
>>> WARNING. So I configured it as a Low Latency PREEMPT Desktop without
>>> the RT_PREEMPT and that eliminated the WARNING. However, still no 6Ghz
>>> networks. The firmware I'm using is straight from kernel.org GIT and I
>>> do a 'make install; make dedup' to install it. I believe it should be
>>> good. Attached is the latest log file.
>>>
>>> -Walt
>>


