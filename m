Return-Path: <linux-wireless+bounces-26348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B41B23F32
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 05:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3545C723C21
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 03:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031BE29C323;
	Wed, 13 Aug 2025 03:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MzoMEIEP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB42BE620
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 03:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057314; cv=none; b=iIVhEQcCTkvsVvlgaZWFMQxUbEa+qeM+PWYPGMS93VEeMWj4I3/ez9EFV+NaZjwws+rCEjMGHmnnLBA2xl7T8y2hK6tJRvtlXojCDuTaamUQiO6DySE6U41VMa+RO4bLSrqWRHXHeggMlTXFjJcw7UFomMO5xjIL+HwXcKwYyWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057314; c=relaxed/simple;
	bh=dnz52Dgxeba8OreSCFoW8AzKahq6NE+sYCZabA34LQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvcavoSmPoEQB9i4xiF4fxNyOIcAKerU/OpxATWDpwKaheoFVFQJMbr8hDisitMl6yg3HVjacnhXZUSoYDG3qjCaZ5B7j3gKwBFAy+pzgx3g8E3JP7IIUN17xWnVapwyYIEl2H8vR23d3EQnDsIcNhhV1/rA1yS/P/+DLF88wJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MzoMEIEP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D3nvjY027783
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 03:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nL73GNJKLk9gxYhZAyNJw/OghTTtC6l/WSrfhqhdCug=; b=MzoMEIEPMWSVoNUJ
	3sk0aj2VjkqD3b8AyFo6WpEwt8aIVsj4ufroqT3KgThb9nUcDLnfknXUywqb0bif
	jmlCYgJduTOO2IfnHo+PtlO9nwL3z8Xylhf2EFCrE9e0+Ik/45GhJihZqtBptd7S
	LEHKIewo8ZpbSfIiDVo7LcWkaaFump4j4z1DiqqCHuPNexgS0bMwWB8VHS5i9IuH
	1ltASY2fCZ9XrwK9+PDBJc+gFLL4G6yHyxjSirc5jqwrA9c54IBNnVw+hvf1cluq
	bNN9c4oLcG3HtzWd2t1y0ArTQG+4b2mHkhFcPTRalnIJK+8SaTDBn8y+E6TtYFVD
	O+LvzA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6p7fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 03:55:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31f65d519d3so11650981a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 20:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755057311; x=1755662111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nL73GNJKLk9gxYhZAyNJw/OghTTtC6l/WSrfhqhdCug=;
        b=YCz1M5gBNcIOzOCMN+prnMItTcRZaEDk1FalwCf6MIH2aZFSRvk/5vIr0W41CamMGz
         O7YbiwOILacncW+fGgcNZk+qQcZAiqvD2DMLCPZnG+FXU01hGfTYVzT+BF4FJBWkMzGE
         gT8BlkAdMziZw3NvFYeo5j6WTEJemFJB0i+qzuvNTH3Wf33f07Xem+huYzT9T+8Rl6SH
         AWHJt62/mRQ2x4Y9JHjXvzoSaKJW0XG3PFK4D8LAraT2107vY/KfA8Q4hy+GjaZRSEz0
         7LaFERY8Vgt8ZEV+lCZDX1f1/PHZCyt98vcpwLkaQystwFhjlYKzzVXxEykl2pYEU86n
         vewg==
X-Forwarded-Encrypted: i=1; AJvYcCVjOOBPpNWtI/A1EVktWMaFcy1yY8cBT0h/S0Z8FV7ooA5aYhO51mFZR21SmUOQ+V8gLxaaJPwBMs+y2llPOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUni7htgUmHc/Sk8cRfbm83rBU9KbaOSPnWbpXs8vkJAf2T10z
	tFOsYPcdTOflSNd6piNAELi94S1mRxKbpiTeps1YyLc2EAswes4oSGdPQFpt/x58OAdto6QAUjM
	ZFyzqvLEPXSXKY1RBAdpOTPRToI45f1R/6uIw3jK57l6QtTWgAzssY56OpqYWZAQdnuBEjQ==
X-Gm-Gg: ASbGncsa1hNiC0u3fnFsiET0BKYpIcLolP2PJd5S3WLMlPAqfmYVHAJY96tsOQ380x8
	LKV2ggtE7nEReZqYwJIsYc7bCeceMnj2diHN4oojgiB3Ux2yJ1Uucnui8KMQZU54TqxVPxBM2dP
	BwXENdAVoCbl71t6ksSbhs5OZJudHVRHn4pE6ygLbib9zdXXPGTD+kCp9NIa7HXSIIhkkxf6AW1
	surlKGL5vp7h1Rh8V9/WWjfq7ZbuTfWzbK3TimzFoK0d1hMQqUZsUj/K/b5UXTtAmpiqr9WQfhh
	50iLe3WPCa5n7Cw7J/IDivOieETPPAy+vN3tRB4yjI4S5x94ddD45Sz/9f8Ep9ghoyhp6bbDhg=
	=
X-Received: by 2002:a17:90b:2808:b0:311:a4d6:30f8 with SMTP id 98e67ed59e1d1-321d0da48c2mr1826569a91.13.1755057311366;
        Tue, 12 Aug 2025 20:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6DBH2kfzGflZ64cNW7+2CaKUESotFcZzef6cAyZ1L/M83j5cwOGYdfHt9J3/vXq3xPUnICQ==
X-Received: by 2002:a17:90b:2808:b0:311:a4d6:30f8 with SMTP id 98e67ed59e1d1-321d0da48c2mr1826528a91.13.1755057310792;
        Tue, 12 Aug 2025 20:55:10 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321d1db5da0sm668773a91.16.2025.08.12.20.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 20:55:10 -0700 (PDT)
Message-ID: <ec0e3b33-76f4-4ad5-8497-5c8c8b42f67e@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 09:25:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250711213602.GA2307197@bhelgaas>
 <55fc3ae6-ba04-4739-9b89-0356c3e0930c@oss.qualcomm.com>
 <d4078b6c-1921-4195-9022-755845cdb432@oss.qualcomm.com>
 <68a78904-e2c7-4d4d-853d-d9cd6413760e@oss.qualcomm.com>
 <ycbh6zfwae3q4s6lfxepmxoq32jaqu5i7csa2ayuqaanwbvzvi@id4prmhl3yvh>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <ycbh6zfwae3q4s6lfxepmxoq32jaqu5i7csa2ayuqaanwbvzvi@id4prmhl3yvh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfXw8hhmnI5brQF
 lcmiBZDskSVDkAT+IqLvz0P7J5wLw5N8OB1E+xDs75vyXpGdZ1kzr6ydUhlf6kAcFhCe9VlivGo
 TCWhmx2lRMUvH6L+mn/1z6Zc8uedWXhQM/XYQwNBwa2rocJBDPV9gLWVzcWF8YzNXsIpJdeP32K
 RToUSSS7ILJ/+g57nO5DN5AmV+UYNjk0dQ5LpN/nAqX9gKYeLVIcIAT7J2aTkTasWRlV8SxnU1l
 Nj5ENpwDGiuYx3Hj74h+oVTXhXiyMz4vd7G06hI10Z7ef/1q8UCQcTkmGNds568aHik2mJN2mgu
 am1U7OEU4zIE+bg79peBmuSTabcdaCiFP5h1k+nLwuu4OOGJNA/6kQxbzgVj78Dz3zUuArkyHad
 ntlH7pNU
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689c0ca0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Rc7TGh9G46w0mRT8ouYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Wx_cZfiZPjWdq3QHBhWljWFdvZeXHEdV
X-Proofpoint-ORIG-GUID: Wx_cZfiZPjWdq3QHBhWljWFdvZeXHEdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075



On 8/12/2025 10:13 PM, Manivannan Sadhasivam wrote:
> On Tue, Aug 12, 2025 at 09:35:46AM GMT, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 7/22/2025 4:33 PM, Krishna Chaitanya Chundru wrote:
>>>
>>>
>>> On 7/12/2025 4:36 AM, Krishna Chaitanya Chundru wrote:
>>>>
>>>>
>>>> On 7/12/2025 3:06 AM, Bjorn Helgaas wrote:
>>>>> On Mon, Jun 09, 2025 at 04:21:23PM +0530, Krishna Chaitanya
>>>>> Chundru wrote:
>>>>>> If the driver wants to move to higher data rate/speed than
>>>>>> the current data
>>>>>> rate then the controller driver may need to change certain
>>>>>> votes so that
>>>>>> link may come up at requested data rate/speed like QCOM PCIe
>>>>>> controllers
>>>>>> need to change their RPMh (Resource Power Manager-hardened) state. Once
>>>>>> link retraining is done controller drivers needs to adjust their votes
>>>>>> based on the final data rate.
>>>>>>
>>>>>> Some controllers also may need to update their bandwidth voting like
>>>>>> ICC BW votings etc.
>>>>>>
>>>>>> So, add pre_link_speed_change() & post_link_speed_change() op to call
>>>>>> before & after the link re-train. There is no explicit
>>>>>> locking mechanisms
>>>>>> as these are called by a single client Endpoint driver.
>>>>>>
>>>>>> In case of PCIe switch, if there is a request to change
>>>>>> target speed for a
>>>>>> downstream port then no need to call these function ops as these are
>>>>>> outside the scope of the controller drivers.
>>>>>
>>>>>> +++ b/include/linux/pci.h
>>>>>> @@ -599,6 +599,24 @@ struct pci_host_bridge {
>>>>>>        void (*release_fn)(struct pci_host_bridge *);
>>>>>>        int (*enable_device)(struct pci_host_bridge *bridge,
>>>>>> struct pci_dev *dev);
>>>>>>        void (*disable_device)(struct pci_host_bridge *bridge,
>>>>>> struct pci_dev *dev);
>>>>>> +    /*
>>>>>> +     * Callback to the host bridge drivers to update ICC BW
>>>>>> votes, clock
>>>>>> +     * frequencies etc.. for the link re-train to come up
>>>>>> in targeted speed.
>>>>>> +     * These are intended to be called by devices directly
>>>>>> attached to the
>>>>>> +     * Root Port. These are called by a single client
>>>>>> Endpoint driver, so
>>>>>> +     * there is no need for explicit locking mechanisms.
>>>>>> +     */
>>>>>> +    int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
>>>>>> +                     struct pci_dev *dev, int speed);
>>>>>> +    /*
>>>>>> +     * Callback to the host bridge drivers to adjust ICC BW
>>>>>> votes, clock
>>>>>> +     * frequencies etc.. to the updated speed after link
>>>>>> re-train. These
>>>>>> +     * are intended to be called by devices directly attached to the
>>>>>> +     * Root Port. These are called by a single client Endpoint driver,
>>>>>> +     * so there is no need for explicit locking mechanisms.
>>>>>
>>>>> No need to repeat the entire comment.  s/.././
>>>>>
>>>>> These pointers feel awfully specific for being in struct
>>>>> pci_host_bridge, since we only need them for a questionable QCOM
>>>>> controller.  I think this needs to be pushed down into qcom somehow as
>>>>> some kind of quirk.
>>>>>
>>>> Currently these are needed by QCOM controllers, but it may also needed
>>>> by other controllers may also need these for updating ICC votes, any
>>>> system level votes, clock frequencies etc.
>>>> QCOM controllers is also doing one extra step in these functions to
>>>> disable and enable ASPM only as it cannot link speed change support
>>>> with ASPM enabled.
>>>>
>>> Bjorn, can you check this.
>>>
>>> For QCOM devices we need to update the RPMh vote i.e a power source
>>> votes for the link to come up in required speed. and also we need
>>> to update interconnect votes also. This will be applicable for
>>> other vendors also.
>>>
>>> If this is not correct place I can add them in the pci_ops.
>> Bjorn,
>>
>> Can you please comment on this.
>>
>> Is this fine to move these to the pci_ops of the bridge.
>> Again these are not specific to QCOM, any controller driver which
>> needs to change their clock rates, ICC bw votes etc needs to have
>> these.
>>
> 
> No, moving to 'pci_ops' is terrible than having it in 'pci_host_bridge' IMO. If
> we want to get rid of these ops, we can introduce a quirk flag in
> 'pci_host_bridge' and when set, the bwctrl code can disable/enable ASPM
> before/after link retrain. This clearly states that the controller is quirky and
> we need to disable/enable ASPM.
> 
> For setting OPP, you can have a separate callback in 'pci_host_bridge' that just
> allows setting OPP *after* retrain, like 'pci_host_bridge:link_change_notify()'.
> I don't think you really need to set OPP before retrain though. As even if you
> do it pre and post link retrain, there is still a small window where the link
> will operate without adequate vote.
> 
Hi Mani,

we need to update the OPP votes before link retrain, for example if
there is request  to change data rate from 5 GT/s to 8 GT/s on some
platforms we need to update RPMh votes from low_svs to NOM corner
without this clocks will not scale for data rates 8 GT/s and link
retrain will fail. For that reason we are trying to add pre and post
callbacks.

- Krishna Chaitanya.
> - Mani
> 

