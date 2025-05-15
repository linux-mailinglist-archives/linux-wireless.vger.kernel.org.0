Return-Path: <linux-wireless+bounces-22992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49941AB7FF6
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 10:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B977B530E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F53CCA6B;
	Thu, 15 May 2025 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UVG3A59J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0463412CD96
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296783; cv=none; b=FyYR+uPlTUkPDzY3uyRAgaMYCPHJBmPhyGnkdiFuwM5vOQeEHEpiOs+iaO83luG4UGmZhZyMWQX7opRmFUzH2A2f7ycscaQk5c6gxtGevEtNV2+afFjv8N+j6jb7GsqaJEhW2LoTC9C02MD60OWRUPXl1343CWgAmc6ZasTcLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296783; c=relaxed/simple;
	bh=bQSW16+Ke3Ljchrdm4EitG94GC+EKUPP9MiIwQQoL8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmTt36ObYjFiXRzcJW3/bOIBMJ3pwuyNr32/17JDzoiDUpSOOjPXza17ZPGyM1zvg9uPwF8GsEHMVjjlDXrTu/utgvFOhGehd0yciq0gwheG8EzdRXZi/fW1s++f2TnH9NvUFh357WHErnb0xgKdRb1JUgpvizRkI6W7xJxwou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UVG3A59J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EL4NQ4025420
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 08:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E++65UOF5tmrMaX3qnnORuCpMPsb5CliKQB6jPoS5L8=; b=UVG3A59JrUa7bOKQ
	luaGhRxXdD1EMbSsqhsGm0KZmKyys+yiFD7dy9rQuTbiMEeijWO0CjNG9gebE0D0
	iN60EMbZqughecCEv1bAF5a+jLFVuQdroxtUUgB8QCidg7ooDLOXGgB+c/Pbtbxh
	rjL9c6KentifVn7qvsoOR8SkVmuQNdVbYUjQnhs69+AnhoTxdEwRj/38PT02OQSm
	EAawVF3c2upPtfQoJqvd5/ezN/1cX3gPE+DI9C6I+JvEpa8XPEWWefG5gXILnsdF
	KOwoG34FnngbINQkf1/0N98eTRhxvX4A/VdNuhwpAe6TWu6ULoDuGTUHfOY73/19
	eA9eJA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbew5asf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 08:12:59 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-72e2f2b9e7dso604115a34.2
        for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 01:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747296778; x=1747901578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E++65UOF5tmrMaX3qnnORuCpMPsb5CliKQB6jPoS5L8=;
        b=S292PUxPBTYVIaJ6VsqG4XYLCD9XzeszGhs+DxX7Wy+rrPFWPyhhTycLfkci5ZmSie
         +Y2zw0Cph+iWCbPu9vxr3QByiu/ZEexe1M1/IjTDWQ6jivQOSTvIbeeecOF2EerXgL9/
         py2ogSwf6ZeNdQs7D/GOlXi4vo5nVRr9yItZN9EFVK9BgE3QZt1ln9qjNEkytlgebLlG
         ZaK8FVRWm48AgKvxaAp7JsbLJPsSlWE5+oDZHUw76ZB5IUfvplBl6VdwpQLN3DvImqoZ
         Cx1o6o5vqMXY0sBikgnVhJCqFXyzGz6zVbWUbyOsAd9vLC4QRb63jRRejt6WAiFMJr67
         EOhg==
X-Forwarded-Encrypted: i=1; AJvYcCXcwlfzGj+j8KbeeRyBkW9D6HlovCEjZR9yBi9nZF4yp4aw6tLCTWER2oTYDpbXx+Ninsg+o4gGkzhKTOPEPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+0i6eF15pD5ONknzDoMnN291v2iF+aUD44ZI4lFF7Tw5sggXO
	WVBj0i9aZCHobjgSpZGQYnBKd8zB4SeI+Nu0SPu1Gs7mFOc9+9wrvXJgjNzir/CKy5xQl4X7lj5
	BnlEmohjkp2JW7QOIun9X2jv1eBhbwf5sWEI90d60d2CnOtUxjskwrr6fP07qyq0hzNaPuGCq/Q
	==
X-Gm-Gg: ASbGncuDW5SHllmkVU5BtfkJV9k3VGSJkXkHFbFC88mDwfUaMbnjIQz/QWj/SnhN6r7
	Sfgihnmen80pGiH3NitTBs2sGT9sOMMVrtyVwxYp06cnMbmpargxXeFTmj/5bTFX8mhaNb38sf2
	OY+sJYB6bvWq54gc/ymVjyMtoGMnyrtm7jga5kaKObXAIvQxfKTOLjYM5lLaWhjAS252H78GYRU
	/w5AgzzAtsx3IEQW8n/aRXBGDuiOOcra5ENd7oWlTi6iyeJRHSdt0ax7ai6Jwkohf35lUvPm+II
	u4SWkHWV2tk2je8C0i2ea+7v5rAb3K8USPaccY04sPPfekaaGNMLz4WTyn/npKHAyoc8gaim5w=
	=
X-Received: by 2002:a05:6830:d1a:b0:72a:4762:d387 with SMTP id 46e09a7af769-734e13f447emr3622638a34.11.1747296778008;
        Thu, 15 May 2025 01:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMiBBT028vAiPRbmbnHNufIUadRwh9SpGyoaqjF82x037R2osbhu9UBvY7NfMA8j7mcksdsg==
X-Received: by 2002:a17:903:1b4b:b0:224:10a2:cad5 with SMTP id d9443c01a7336-231980bbcf9mr113045915ad.10.1747296766499;
        Thu, 15 May 2025 01:12:46 -0700 (PDT)
Received: from [10.133.33.17] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82705e5sm112527675ad.120.2025.05.15.01.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 01:12:46 -0700 (PDT)
Message-ID: <e9da4ad5-52cb-416d-991a-259140469e2c@oss.qualcomm.com>
Date: Thu, 15 May 2025 16:12:44 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k: No 6GHz Wireless found
To: Walt Holman <waltholman09@gmail.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <CAMb39_ngQs8=FUML5QXMh2RmEZBZ2NwUHefhGoTkGtHat+KWJA@mail.gmail.com>
 <CAMb39_ki7F1XgezyVfb9Tkm9D-FZE0XK3RcSYtFmFf0jP8-M_Q@mail.gmail.com>
 <dc0abf98-862b-47f5-ae71-749c68cffc73@quicinc.com>
 <CAMb39_kUUv24q6QUq9B9+TEUMrUhu12-8WJadzB53nMPhcAZSQ@mail.gmail.com>
 <ef81db9e-99cb-4802-b17f-94eb623a8b32@quicinc.com>
 <CAMb39_m+4dNBDbkZmn-rDA7T+u84y-dx1jSfmPNWnse=R1=gCw@mail.gmail.com>
 <18788f02-e374-4aa6-ac4a-fd53bc93754c@quicinc.com>
 <CAMb39_=G_TEL1pbeF_PAZLQh-JOFcncSfqZChPmEj63NjsEOLA@mail.gmail.com>
 <16ccbe02-b315-40d1-8600-232b592d4dd6@quicinc.com>
 <CAMb39_n4tyrzS=-j0L+ekJVer=KiZyDYFhMqrrcpr9py_itU9w@mail.gmail.com>
 <0933d8d6-5b72-40df-95f8-69f6fbbdfde7@oss.qualcomm.com>
 <CAMb39_nHO_TbHPQawdLVY8nt3yt4wDuEHyEuzMa-p5Ab1n94sA@mail.gmail.com>
 <CAMb39_nQ-uyKAqCz1HEUDt5qjszbhzf3oikVcvzHcVwt4_qt=A@mail.gmail.com>
 <CAMb39_n89hBL_GvfXb7Jw9h5-h-+Qg-3GyqvpahL7MT5ewpvJw@mail.gmail.com>
 <CAMb39_=YPYg0q7Lf0sMgTx5QwKOqcyJrZR7kTspyXEDa6qz9Bw@mail.gmail.com>
Content-Language: en-US
From: Kang Yang <kang.yang@oss.qualcomm.com>
In-Reply-To: <CAMb39_=YPYg0q7Lf0sMgTx5QwKOqcyJrZR7kTspyXEDa6qz9Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bBHx-6iz1It0rkpJdJXiA4hTce4QVNae
X-Proofpoint-ORIG-GUID: bBHx-6iz1It0rkpJdJXiA4hTce4QVNae
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA3OSBTYWx0ZWRfX3Vn3Fy/ly9rG
 HgTlTRVl5MM17XrLlMDIhTIDD1xW/04S6Dmrwb3SBXL6Ce2mKVhMZtuU542wNMLIts/evhtf7tH
 OUIXiZd+DdkoevCquwTvzfX4tExbm8sH4/FTv+Ef1bD8PzA28LJ00ZlOWQchXBmTst8n94nxPrR
 BaTdJCmacP4+OII6f8XfzDroGZrCGaSgM042eJlHdCkZKfVr1XL9RiCc/1LMx7vX02X3dJOUDEa
 4BGeubYO+j6Ojd21QQxibY22hSUH8U5VP0qhVs/zq/KZyfy8i0Sa424jFtWmeKdRyapF2BxoKbT
 IOTsl+vOPqrhjH4SGfky4QuK86HfDaakfFcGbWUxaXo5nH+vzFR1UtI+PfPIT3HvpoTUoxA7xnd
 6Xf4QydopH6H62+66Q86tMzzTka03xKgAt0jOByB6bE67Iaf0A8Hx6+34evfHg1fVBiTRZn3
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=6825a20b cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=lMMYwoh7bgqQ9NEZEYgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_03,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150079


On 4/20/2025 11:18 PM, Walt Holman wrote:
> On Fri, Apr 18, 2025 at 4:18 PM Walt Holman <waltholman09@gmail.com> wrote:
>> On Tue, Apr 15, 2025 at 4:23 PM Walt Holman <waltholman09@gmail.com> wrote:
>>> On Thu, Apr 10, 2025 at 10:32 AM Walt Holman <waltholman09@gmail.com> wrote:
>>>> On Thu, Apr 10, 2025 at 3:26 AM Kang Yang <kang.yang@oss.qualcomm.com> wrote:
>>>>>
>>>>>
>>>>> On 4/10/2025 3:37 AM, Walt Holman wrote:
>>>>>> On Tue, Apr 8, 2025 at 4:17 AM Kang Yang <quic_kangyang@quicinc.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 4/8/2025 1:49 AM, Walt Holman wrote:
>>>>>>>> Attached is a small packet capture where I did an 'iw wlp99s0 scan'
>>>>>>>> and also deactivated and reactivated wireless while the scan was
>>>>>>>> ongoing. Hopefully there's something interesting for you in there.
>>>>>>>> Also, I've take 3 screenshots showing the configs of the wireless AP
>>>>>>>> for the 6ghz network. The first screen is just the definition of the
>>>>>>>> network. No advanced settings are used. The 2nd screen shows the
>>>>>>>> channels and radio enabled. The 3rd screen has the advanced
>>>>>>>> (professional) settings for the network. I believe I changed 'Agile
>>>>>>>> Multiband' to enabled, but other settings are their defaults. Hope
>>>>>>>> some of this helps. Let me know if you need anything else. Thanks,
>>>>>>>>
>>>>>>> Your packets are Ethernet packets. I need wireless packets.
>>>>>>>
>>>>>>>
>>>>>>> Not sure if you know how to add a seperate monitor interface to capture
>>>>>>> 6 G channels' packet on your AP(you can google for specific command).
>>>>>>>
>>>>>>>
>>>>>>> Also, please capture firmware log:
>>>>>>>
>>>>>>> 1. sudo apt install trace-cmd
>>>>>>> 2. sudo trace-cmd record -e ath12k_wmi_diag
>>>>>>> 3. run test
>>>>>>> 4. "ctrl c" to stop recording:
>>>>>>> Hit Ctrl^C to stop recording
>>>>>>> ^CCPU0 data recorded at offset=0xdf5000
>>>>>>>        2605056 bytes in size
>>>>>>> Then share the trace.dat to us.
>>>>>>>
>>>>>>> So you need to:
>>>>>>> 1. try to capture wireless packets.
>>>>>>> 2. capture firmware log(trade.data).
>>>>>>> 3. save kernel/wpa_supplicant/iw logs.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> -Walt
>>>>>>>>
>>>>>>>> On Sun, Apr 6, 2025 at 8:58 PM Kang Yang <quic_kangyang@quicinc.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 4/4/2025 12:04 AM, Walt Holman wrote:
>>>>>>>>>> On Thu, Apr 3, 2025 at 3:20 AM Kang Yang <quic_kangyang@quicinc.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 4/3/2025 1:48 AM, Walt Holman wrote:
>>>>>>>>>>>> On Tue, Apr 1, 2025 at 9:48 PM Kang Yang <quic_kangyang@quicinc.com> wrote:
>>>>>>>>>>>>> Test on 6.14.0-rc5-wt-ath+, with the firmware you used.
>>>>>>>>>>>>> I can get 6 GHz AP and connect to it.
>>>>>>>>>>>>>
>>>>>>>>>>>>> ath12k_pci 0000:03:00.0: fw_version 0x100301e1 fw_build_timestamp
>>>>>>>>>>>>> 2023-12-06 04:05 fw_build_id
>>>>>>>>>>>>> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>>>>>>>>>>>
>>>>>>>>>>>>> yk@yk-Mayan:~$ sudo iw wls1 scan | tee iw_scan.log:
>>>>>>>>>>>>> BSS 62:03:7f:12:64:64(on wls1) -- associated
>>>>>>>>>>>>>               TSF: 606308271476 usec (7d, 00:25:08)
>>>>>>>>>>>>>               freq: 6275
>>>>>>>>>>>>>               beacon interval: 100 TUs
>>>>>>>>>>>>>               capability: ESS Privacy SpectrumMgmt ShortSlotTime (0x0511)
>>>>>>>>>>>>>               signal: -17.00 dBm
>>>>>>>>>>>>>               last seen: 52 ms ago
>>>>>>>>>>>>>               Information elements from Probe Response frame:
>>>>>>>>>>>>>               SSID: MLO-KANG-6G
>>>>>>>>>>>>> and other 6 GHz APs:
>>>>>>>>>>>>>              SSID: 6G-gxia
>>>>>>>>>>>>>              SSID: NETGEAR97-6G
>>>>>>>>>>>>>              ……
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> kernel log:
>>>>>>>>>>>>> [88158.033218] wls1: Inserted STA 62:03:7f:12:64:64
>>>>>>>>>>>>> [88158.033232] wls1: authenticate with 62:03:7f:12:64:64 (local
>>>>>>>>>>>>> address=00:03:7f:37:12:54)
>>>>>>>>>>>>> [88158.033242] wls1: send auth to 62:03:7f:12:64:64 (try 1/3)
>>>>>>>>>>>>> [88158.041895] wls1: authenticated
>>>>>>>>>>>>> [88158.041914] wls1: moving STA 62:03:7f:12:64:64 to state 2
>>>>>>>>>>>>> [88158.044291] wls1: determined local STA to be EHT, BW limited to 320 MHz
>>>>>>>>>>>>> [88158.045719] wls1: associate with 62:03:7f:12:64:64 (try 1/3)
>>>>>>>>>>>>> [88158.067045] wls1: RX AssocResp from 62:03:7f:12:64:64 (capab=0x511
>>>>>>>>>>>>> status=0 aid=4)
>>>>>>>>>>>>> [88158.089090] wls1: associated
>>>>>>>>>>>>>
>>>>>>>>>>>>> I can even connect to it by Ubuntu GUI.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Can you update to 6.14.0-rc5-wt-ath+ and have a retry? Also please make
>>>>>>>>>>>>> sure that your wpa_supplicant/iw support 6 GHz(or directly update to the
>>>>>>>>>>>>> latest version).
>>>>>>>>>>>>>
>>>>>>>>>>>>> If you still cannot find 6 GHz AP, you can set debug_mask to 0xffffffff
>>>>>>>>>>>>> to get ath12k logs. Then give it to us.
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> -Walt
>>>>>>>>>>>>>>
>>>>>>>>>>>> OK, I retested with the wt-ath 033125 tagged build. This included the
>>>>>>>>>>>> patch the Jeff suggested I try, but the rest of the tree was clean.
>>>>>>>>>>>> Still no 6ghz Wifi. I'm attaching a log file of the boot and first few
>>>>>>>>>>>> seconds with the debug mask turned on. I noticed that if I rmmod the
>>>>>>>>>>>> module and then modprobe it, it complains about not finding
>>>>>>>>>>>> firmware-2.bin, however, I thought that was only for the qcn based
>>>>>>>>>>>> chip? The HW info from dmesg looks like this:
>>>>>>>>>>>>
>>>>>>>>>>> I cannot find this tag...
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>      From the log, the 6 GHz channel should work. When scan is triggered, FW
>>>>>>>>>>> shall send probe req on these channels. If AP send probe resp, station
>>>>>>>>>>> shall find the AP.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> [    6.070282] ath12k_pci 0000:63:00.0: BAR 0 [mem
>>>>>>>>>>>> 0xdd800000-0xdd9fffff 64bit]: assigned
>>>>>>>>>>>> [    6.070310] ath12k_pci 0000:63:00.0: enabling device (0000 -> 0002)
>>>>>>>>>>>> [    6.071249] ath12k_pci 0000:63:00.0: MSI vectors: 16
>>>>>>>>>>>> [    6.071254] ath12k_pci 0000:63:00.0: Hardware name: wcn7850 hw2.0
>>>>>>>>>>>> [    6.596331] ath12k_pci 0000:63:00.0: qmi dma allocation failed
>>>>>>>>>>>> (7077888 B type 1), will try later with sma
>>>>>>>>>>>> ll size
>>>>>>>>>>>> [    6.604041] ath12k_pci 0000:63:00.0: chip_id 0x2 chip_family 0x4
>>>>>>>>>>>> board_id 0xff soc_id 0x40170200
>>>>>>>>>>>> [    6.604044] ath12k_pci 0000:63:00.0: fw_version 0x100301e1
>>>>>>>>>>>> fw_build_timestamp 2023-12-06 04:05 fw_build_id
>>>>>>>>>>>> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-
>>>>>>>>>>>>
>>>>>>>>>>>> Also, I noticed when looking through the debug logs there are the
>>>>>>>>>>>> occasional WARNING statements from a BUG it appears. They trace back
>>>>>>>>>>>> to the mac.c file inside the ath12k code. There should be some in the
>>>>>>>>>>>> debug log that's attached. Let me know if I can do anything else.
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I have never seen this warning on my upstream setup...Not sure if you
>>>>>>>>>>> have changed anything or using the correct code base.
>>>>>>>>>>>
>>>>>>>>>>> Jeff merged this patch-set into ath-202504021602. Can you try on this
>>>>>>>>>>> branch?
>>>>>>>>>>>
>>>>>>>>>>> git clone https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/
>>>>>>>>>>> git pull
>>>>>>>>>>> git reset --hard ath-202504021602
>>>>>>>>>>> compile and install...
>>>>>>>>>>>
>>>>>>>>>>> Also make sure that the firmware you used is from the same folder, don't
>>>>>>>>>>> mix with other folders:
>>>>>>>>>>> linux-firmware/ath12k/WCN7850/hw2.0
>>>>>>>>>>>
>>>>>>>>>>> 1. rmmod/insmod(debug_mask=0xffff)
>>>>>>>>>>> 2. iw reg get
>>>>>>>>>>> 3. iw reg set US
>>>>>>>>>>> 4. iw xxx scan
>>>>>>>>>>> wait and collect logs.
>>>>>>>>>>>
>>>>>>>>>>> don't do anything else.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Also, can you show me your AP configuration.
>>>>>>>>>>> If you have another 6 GHz AP, you can have a try(better different brands).
>>>>>>>>>>>
>>>>>>>>> Thanks for testing.
>>>>>>>>>
>>>>>>>>> Could you share your AP configuration?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>> If you have sniffer, could please capture packets during testing?
>>>>>>>>>
>>>>>>>>> Can you capture packets during the testing? I need to check probe req
>>>>>>>>> and probe resp.
>>>>>>>>>
>>>>>>>>>>> Thanks!
>>>>>>>>>>>
>>>>>>>>>>>> -Walt
>>>>>>>>>> OK, I cloned and built the kernel based on your instructions in your
>>>>>>>>>> last email. Originally, the result was identical to my last email,
>>>>>>>>>> including the WARNINGS. The .config I use is configured for a fully RT
>>>>>>>>>> PREEMPT kernel, which I wondered if that was why I was receiving the
>>>>>>>>>> WARNING. So I configured it as a Low Latency PREEMPT Desktop without
>>>>>>>>>> the RT_PREEMPT and that eliminated the WARNING. However, still no 6Ghz
>>>>>>>>>> networks. The firmware I'm using is straight from kernel.org GIT and I
>>>>>>>>>> do a 'make install; make dedup' to install it. I believe it should be
>>>>>>>>>> good. Attached is the latest log file.
>>>>>>>>>>
>>>>>>>>>> -Walt
>>>>>>
>>>>>> Sorry for the top-post earlier. I can't figure out how to capture the
>>>>>> wireless packets as my chip/driver combo doesn't support monitor mode.
>>>>> Your AP also cannot capture wireless packets?
>>>>> log in AP by usbserial or ssh.
>>>>> Try to enter command line. use iw command to create monitor interface.
>>>>> Then use tcpdump to capture packets.
>>>>>
>>>>>> I've attached a tarball that contains the trace data and additional
>>>>>> firmware logs from the kernel.log file. Anything else you need, just
>>>>>> ask. Thanks for your help,
>>>>>
>>>>> Your AP mac address?
>>>>> Need it to help check the fw log.
>>>>>
>>>>>
>>>>>> -Walt
>>>> Sorry, the AP doesn't have tcpdump available on it. Also, this is a
>>>> mesh setup with 3 nodes total. The main AP and 2 mesh nodes. I'm
>>>> within 10 feet of one of the nodes and it's MAC for the wireless 6ghz
>>>> network is: 10:7C:61:6F:2A:CA
>>>>
>>>> -Walt
>>> The other 2 node 6ghz mac addresses are:
>>> 10:7C:61:6F:1F:11   - Router
>>> 10:7C:61:6F:32:92   - Node
>>>
>>> The first MAC address I gave you earlier was a node located
>>> approximately 5 feet from where the laptop is.
>>>
>>> -Walt
>> Well, I'm running into a brick wall it seems trying to get 6Ghz
>> enabled on this. I tried the ath-next-20250418 tag just now and still
>> don't see or connect to my 6Ghz network. I applied the patches in:
>> https://lore.kernel.org/linux-wireless/20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com/T/#t
>>
>> hoping that would help, but alas, no 6Ghz networks. I see that MLO and
>> other nice fixes are coming in 6.16, but without 6Ghz, they'll do me
>> no good. I'm really wondering if it's a firmware issue that excludes
>> my chip or something. Again, anything I can do to help, let me know.
>> Thanks,
>>
>> -Walt
> Well, I used the swiss army tools to look at the firmware, and my chip
> is listed in the firmware, so it's not excluded or anything. Really
> puzzlling issue as my other two laptops connect to the 6Ghz network
> just fine, and this laptop does in Windows, just not in Linux. I
> really don't use Windows at all though, so that does me no good.
>
> This laptop used to connect to the 6Ghz network around the Sep. - Oct.
> 2024 timeframe. Something has changed and now it doesn't. I'm going to
> boot off a live image of Ubuntu 24.10 and see if I can see the
> network. It was always hit or miss so we'll see.
> -Walt


Can you find 6 GHz AP now?




