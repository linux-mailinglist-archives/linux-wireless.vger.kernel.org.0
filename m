Return-Path: <linux-wireless+bounces-25625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B186B0999A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 04:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BFE07AEFF4
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 02:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153AC35959;
	Fri, 18 Jul 2025 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KtxVv2G7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E612433AD
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804314; cv=none; b=DJWD4QE4BB3FIdb5quqoeE4j1U18p9xpO2Ikz9Ib/OY45QGo2rvg28qTEtEgJ7pfp8k5X1/wFv4ZzlrrxH+XplbM4/WzsKTvPzea3+aLcneDdXRVS9zCdMd74uprX0trdgmX39gZjQ5XanAnY2YSNf/IzB367gPM8I7ItBUEuwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804314; c=relaxed/simple;
	bh=gSDrkic5W1Hr3FuZ1KWmk1eVUKDcM+ZHRgVlt9HjAak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUvyTfyU2Zt/XoDQd+24umdIlwzRCwxbt0QT5ifn0R5Z7UQ/iH2cQ/hoNO6DsNViJgOBxKdHWWEqjB8bwVKl2PxAZ6UP2mokuC11oACUxfnG7DpelklYDYkY5omvqdnIU7ZArcgcecHLBSKmL9pLWo0swbpboaDo8sphbcimlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KtxVv2G7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HLDDXu025369
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ukDmLOBA9Me68ebZBlzYCp7a83Bc1sghnwXXZNSGT/k=; b=KtxVv2G7r6dPu94+
	AUnmdiwdI4mGN7ZscNcbkhidqi+r8pnCPrcf+tQHHrZ/8vBQZ23RrSZt7+bcuHoe
	BHVKoOb4x5sDu6B0KrglM+fTxJHX2WCmkbz/ebhnG0KH/SBmDFBNGjUunccNRuIT
	8BeCg44lOl8yLHvliJ7V0caSwzA1A20Oe4k9e8z03e0Sj3ekCiLsWN7Fqj4/MOvv
	VByiPiibQ2QA7XijlHyPejJZBSSLDHcpFz0jmwUHGLmU2/Pev5yWn7aNLw+zgSjQ
	sR9XApZ2mpKuARfL3SQIUTevCsPBhBFDJiKeKW4kux8h/XhqjRR2KVu20uLZkCJd
	eL2fyQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqe04k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:05:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so1432528a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 19:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752804309; x=1753409109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukDmLOBA9Me68ebZBlzYCp7a83Bc1sghnwXXZNSGT/k=;
        b=gqWkp1k0RCqpv/aZOFMOHvd3+KVkVJLYvM7/bioi4j2HJEk/DXFt0e3Xw4ddW6l7zO
         4KM1PqovjnwOK5h/B+3h/sfgfeSlfdhGg0W9rKZCCAN5u8wdAdWbp6Yr1XXovZWejHSr
         4dgeuRVgcRZyYPOQFZj0C5j+bPtgRoNASJiboSNQa24CoKwiUwqvgTAJy+o7LNUl+U0P
         nz5gBHcBJXJXSxr2eg6vU3JoQq7o2lG54IAbiBq/4vkEdZNTirMOEj05Jz8tZr3yqyje
         3bPEbEFeuptkZQxN9fS8Z4V+41k6zrCRqrfj9hZpJnIiaSwT/nSrzpqJ2cUcTzeb5b7G
         onQg==
X-Forwarded-Encrypted: i=1; AJvYcCXWDoyXlaO++hsFpInxe21Iy+nkL2a5JdGYNaloO0ZGYeXHcaAU35lwLR0QN+4OX48pYDPdnHloe3eEHNGuAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yybg2sYKRgHEdmSNTQPhEJ4x6eu88EAdHzGaDIjqGfTsVGi6thq
	k4zwpd2ouhGoY/Z9L30V7O47N9T7DXdD/nu1qxI5s6tiwa5Us0qUKFm06qhwvNB6nSDxejGSm/x
	TCgEV1D+yQr2ETlgvB/w1N7mDhzstJajRqyyPZWHOjUPInxK4BQIaucWhOFmWmGfZKFCcEw==
X-Gm-Gg: ASbGncvynwDLJJ56pitkQPPnicGbiu1BbOGYZiu4fUEFEJfGAOO99w8ieKyiGJsY+v6
	eYIu9Y9rhnyVEO8d7MXGqVPw+G0iBfNwWUZpqBL/gF3dnvYk88U98mEwFu84ewWrJ83UDcjiWyk
	QoNfCCDbRWkl8bAgP/d0HUP4CjjNJWesUt38ixRXs8+XyZHuC9kLNcbl2Q0gvmpzZ1I93cjsxQn
	XLCjxMI9ErNgqT2X93s5HqqEPXSd8JP6iZ2/OA8dGL+skEGn63vgc+09Fh4ocKbTnt3L2sCYM+S
	/+W1Fd4xnL0dF/sc18UdhZH5lqlxpN65iNu9aBkqjBpLsPfda0cMc8kkdxGxh5xkyf7V465bI3k
	8aBWQTvr3T2s5XRCtpOyechIUg9aKL2OE
X-Received: by 2002:a17:90b:3c4b:b0:311:fde5:c4be with SMTP id 98e67ed59e1d1-31c9f45c8e9mr12273916a91.35.1752804309273;
        Thu, 17 Jul 2025 19:05:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHleUA4lqoylvc2MFKPhIkTtj2OpjdSpesz+JpNk4bXp3YNmyys7zS5On4MFq6zBZbVyFLw4w==
X-Received: by 2002:a17:90b:3c4b:b0:311:fde5:c4be with SMTP id 98e67ed59e1d1-31c9f45c8e9mr12273871a91.35.1752804308759;
        Thu, 17 Jul 2025 19:05:08 -0700 (PDT)
Received: from [10.133.33.245] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1ba792sm4071428a91.5.2025.07.17.19.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 19:05:08 -0700 (PDT)
Message-ID: <1db7c119-882f-4184-9ca4-9dbe5a49cb16@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 10:05:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
 <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
 <38ace6a3-d594-4438-a193-cf730a7b87d6@oss.qualcomm.com>
 <wyqtr3tz3k2zdf62kgtcepf3sedm7z7wacv27visl2xsrqspmq@wi4fgef2mn2m>
 <03806d02-1cfc-4db2-8b63-c1e51f5456e2@oss.qualcomm.com>
 <o2gqqty6lakc4iw7vems2dejh6prjyl746gnq4gny4sxdxl65v@zmqse3244afv>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <o2gqqty6lakc4iw7vems2dejh6prjyl746gnq4gny4sxdxl65v@zmqse3244afv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=6879abd6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=J7HomXw41qA7Or-Ob6oA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 2LwQDEOJ8CoQIBJqlaRxL81OOuW35eYW
X-Proofpoint-GUID: 2LwQDEOJ8CoQIBJqlaRxL81OOuW35eYW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDAxNCBTYWx0ZWRfXy/0geKBqvkdB
 52m4OkjD5E+rLawTt13ZN8VU9u1wr49lCHHoB0Box4b+uVFKwV8nZO//3Ytc8viHS+KfNPF7NgX
 8N5c9isRFUEW9AGqdSc/cpUZlLYV5kxj5tGcVTjrAko1WnYh9o1q3hn70eudLiNBZdak1/XeuJ4
 fqM3iLkkuF0pkWwKDw6Y/yUPqIJcu0c6tq3QoaiM9KvN8KwzrUQIVm+HU36ebefHEhTp7jASEKv
 yRhUHNVIe8/h/B2Tm6acjGBYO747rJ+Gc7VGjfzXYAfFsraaFVxHYr+2BCdM4nCM9XDrM6mteEN
 3Z38xGbPECi9ElH+rCYQH4twlcKF9zAELA+cveqK3IsYq7CtZTl/fc+Biy0G1ICtJsoC74J96Sh
 1Fh1tnBwKNWH7cl10T2hO8IBZRZg50RTIGcRfyvvWaDziir49ppicip4/seQC4c9KzBgQ8Iu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180014



On 7/17/2025 7:29 PM, Manivannan Sadhasivam wrote:
> On Thu, Jul 17, 2025 at 06:46:12PM GMT, Baochen Qiang wrote:
>>
>>
>> On 7/17/2025 6:31 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Jul 17, 2025 at 05:24:13PM GMT, Baochen Qiang wrote:
>>>
>>> [...]
>>>
>>>>> @@ -16,6 +16,8 @@
>>>>>  #include "mhi.h"
>>>>>  #include "debug.h"
>>>>>  
>>>>> +#include "../ath.h"
>>>>> +
>>>>>  #define ATH12K_PCI_BAR_NUM		0
>>>>>  #define ATH12K_PCI_DMA_MASK		36
>>>>>  
>>>>> @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
>>>>>  		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
>>>>>  
>>>>>  	/* disable L0s and L1 */
>>>>> -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
>>>>> -				   PCI_EXP_LNKCTL_ASPMC);
>>>>> +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
>>>>
>>>> Not always, but sometimes seems the 'disable' does not work:
>>>>
>>>> [  279.920507] ath12k_pci_power_up 1475: link_ctl 0x43 //before disable
>>>> [  279.920539] ath12k_pci_power_up 1482: link_ctl 0x43 //after disable
>>>>
>>>>
>>>>>  
>>>>>  	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
>>>>>  }
>>>>> @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
>>>>>  {
>>>>>  	if (ab_pci->ab->hw_params->supports_aspm &&
>>>>>  	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
>>>>> -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
>>>>> -						   PCI_EXP_LNKCTL_ASPMC,
>>>>> -						   ab_pci->link_ctl &
>>>>> -						   PCI_EXP_LNKCTL_ASPMC);
>>>>> +		pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci->link_ctl));
>>>>
>>>> always, the 'enable' is not working:
>>>>
>>>> [  280.561762] ath12k_pci_start 1180: link_ctl 0x43 //before restore
>>>> [  280.561809] ath12k_pci_start 1185: link_ctl 0x42 //after restore
>>>>
>>>
>>> Interesting! I applied your diff and I never see this issue so far (across 10+
>>> reboots):
>>
>> I was not testing reboot. Here is what I am doing:
>>
>> step1: rmmod ath12k
>> step2: force LinkCtrl using setpci (make sure it is 0x43, which seems more likely to see
>> the issue)
>>
>> 	sudo setpci -s 02:00.0 0x80.B=0x43
>>
>> step3: insmod ath12k and check linkctrl
>>
> 
> So I did the same and got:
> 
> [ 3283.363569] ath12k_pci_power_up 1475: link_ctl 0x43
> [ 3283.363769] ath12k_pci_power_up 1480: link_ctl 0x40
> [ 3284.007661] ath12k_pci_start 1180: link_ctl 0x40
> [ 3284.007826] ath12k_pci_start 1185: link_ctl 0x42
> 
> My host machine is Qcom based Thinkpad T14s and it doesn't support L0s. So
> that's why the lnkctl value once enabled becomes 0x42. This is exactly the
> reason why the drivers should not muck around LNKCTL register manually.

Thanks, then the 0x43 -> 0x40 -> 0x40 -> 0x42 sequence should not be a concern. But still
the random 0x43 -> 0x43 -> 0x43 -> 0x42 sequence seems problematic.

How many iterations have you done with above steps? From my side it seems random so better
to do some stress test.

> 
>>>
>>> [    3.758239] ath12k_pci_power_up 1475: link_ctl 0x42
>>> [    3.758315] ath12k_pci_power_up 1480: link_ctl 0x40
>>> [    4.383900] ath12k_pci_start 1180: link_ctl 0x40
>>> [    4.384026] ath12k_pci_start 1185: link_ctl 0x42
>>>
>>> Are you sure that you applied all the 6 patches in the series and not just the
>>> ath patches? Because, the first 3 PCI core patches are required to make the API
>>> work as intended.
>>
>> pretty sure all of them:
>>
>> $ git log --oneline
>> 07387d1bc17f (HEAD -> VALIDATE-pci-enable-link-state-behavior) wifi: ath12k: dump linkctrl reg
>> dbb3e5a7828b wifi: ath10k: Use pci_{enable/disable}_link_state() APIs to enable/disable
>> ASPM states
>> 392d7b3486b3 wifi: ath11k: Use pci_{enable/disable}_link_state() APIs to enable/disable
>> ASPM states
>> f2b0685c456d wifi: ath12k: Use pci_{enable/disable}_link_state() APIs to enable/disable
>> ASPM states
>> b1c8fad998f1 PCI/ASPM: Improve the kernel-doc for pci_disable_link_state*() APIs
>> b8f5204ba4b0 PCI/ASPM: Transition the device to D0 (if required) inside
>> pci_enable_link_state_locked() API
>> 186b1bbd4c62 PCI/ASPM: Fix the behavior of pci_enable_link_state*() APIs
>> 5a1ad8faaa16 (tag: ath-202507151704, origin/master, origin/main, origin/HEAD) Add
>> localversion-wireless-testing-ath
>>
> 
> Ok!
> 
>>
>>>
>>>>
>>>>>  }
>>>>>  
>>>>>  static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
>>>>>
>>>>
>>>> In addition, frequently I can see below AER warnings:
>>>>
>>>> [  280.383143] aer_ratelimit: 30 callbacks suppressed
>>>> [  280.383151] pcieport 0000:00:1c.0: AER: Correctable error message received from
>>>> 0000:00:1c.0
>>>> [  280.383177] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Data Link
>>>> Layer, (Transmitter ID)
>>>> [  280.383184] pcieport 0000:00:1c.0:   device [8086:7ab8] error status/mask=00001000/00002000
>>>> [  280.383193] pcieport 0000:00:1c.0:    [12] Timeout
>>>>
>>>
>>> I don't see any AER errors either.
>>
>> My WLAN chip is attached via a PCIe-to-M.2 adapter, maybe some hardware issue? However I
>> never saw them until your changes applied.
>>
> 
> I don't think it should matter. I have an Intel NUC lying around with QCA6390
> attached via M.2. Let me test this change on that and report back the result.
> 
> - Mani
> 


