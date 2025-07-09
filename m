Return-Path: <linux-wireless+bounces-25096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA66AFE8FB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 14:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4553B45AC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 12:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273252D978C;
	Wed,  9 Jul 2025 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bl45FezI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB9D2DAFCB
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064294; cv=none; b=fV41ANmTih6h4vTfjpiAOymrOP/3xVfmw2TQ9ZHOimTAJ1HBJsO4UhUrRZo/lFywQneVyKtCXArKHbtVyKV84G7IVThEB/f2i3WldFxH32s5ZS1OcS/jifI8pzMYp81n02NkUsv4FyvDtByyYWp/vON9TsqAQoTqk1KmaFfwApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064294; c=relaxed/simple;
	bh=7yd5xrkWlkddJneP+p37SueXY9r93VYw7uJzxQg3qFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONkn1rjtIHisnd6ATADknQuv3tw3XBW+z69wrYiCB8w2IH4noOOJC19HTtokfO5EO+0IZPhc6BOjPmRNuk6NnEa1AmzPE1zIUwefyusRo2RSeg747fb+o+HfKHt68+95P3BWQIXjHdGK2PpCqg16OFheSaKfxO81T5m10XWNw4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bl45FezI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5699dxMh031658
	for <linux-wireless@vger.kernel.org>; Wed, 9 Jul 2025 12:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iJx6t7w6ssrs3a9tOwEvfHFgR1eHqpcHEVJO/pfvIZY=; b=Bl45FezI+8ohQ6Fs
	efgc2EZuyghwoIPcmAUNMZ+PWHFI9zV5bjYaxY3C3FfMrmh7bscGdS9dCnksJPMW
	Tj1NH4oO9KP+N9Ig+rO/QCpnd8y/g4cBHOszdZ1Eb6ybxoFTAuGls5rnOESmNiDb
	+8/HhVGyWeodCpeQ2PWfXgnI81BYFkw1DVYMYw5nGEyKjSE5VHTUKaX15tZUpgNQ
	DTtwY9d83yAEtyHbsF/lNRBWcBiXnWiH8P9TzMnJwCPnDDu8/j70ojlLg7ulb4cq
	3c3BJohQmGRK451I98VQuOpn6OId4aXDm9nab7HgL+US0JqaLIkB9u0zb1kyufCm
	Q0vytQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn4hus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Jul 2025 12:31:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-237e6963f70so96466615ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 09 Jul 2025 05:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752064290; x=1752669090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJx6t7w6ssrs3a9tOwEvfHFgR1eHqpcHEVJO/pfvIZY=;
        b=a99FLdSIou6fxvJ6tDJC74JzMG3Ko6tvbwU+zWARAHRbyNHXSgDXkBouE6sN8cFX4y
         4s4n9/lTFQeVomz9nitGdI7AQkB9Shc0a3BgCpfHYHn/yUQNgY8YbGHcGwGX3EVoPUq5
         8StKgOlRanBQe7XCwxAZrBSLWemHpxQ8FIfa6khCnJ2KtzOGXKWJtk0x9KDLv42Ph7dJ
         2MjmRP8R0DP4YJ+3A0ZqDGZG5uo5nGLH2O5prx5OJ5wM3ZAnOkX/d+I8OCq8hfyPw37v
         p3fMzUL8UZxSkpM624mMzkh9DHqcUI1M4uQddiHO7C85uMzVWqqi7NDTtHEXsFfhhJRK
         tWoA==
X-Forwarded-Encrypted: i=1; AJvYcCXjf1zJLBlFGBab2DgpEEA5JdS3sUDZnf1zusb2j8vKG7O4E2vefxetPAo9/PLYWdhzTwZBOIb4xheYSeiSFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5KE9N84KLHhApeCIg0wfU27PuS6EE+nMPM4U4AAdaBH0LnJW
	ZiSJC84Aaw7pFZlm7nrvGcRcup2p4/wFJc5fL4So04uBWkoTEfKz95yBqRQXjhjhKmwLtSsBra1
	XTqeIsfH87TTjH3ks0pBRwz3eOT7QQs9doaC7xWzz4okeAPiba/j/YWin/BBZVbajl38n3Q==
X-Gm-Gg: ASbGncv826xxGH/JTsBttzlImNbIOzCujd6rV9j4fqAIlUj8hztKappIHhWQF6vm0Se
	9r95fm0113LtIGbBOYrtl6x1cgh5hjrkqVubtxXq2HuJ0zFA8AwhvFIpFBi7Rcxms9Ki3tdBQpl
	p3GV8xsk6/dqAFf3wuLJFkkzgOX9gMIkVc4l+RreLuBGNijV2TSs5UvK/aTg2GfF2V6emGqYxbG
	J9UzFlY6GPp19mmKy/KLrNUrmG1dCYHYlY0xKmsp6mPa5C72agyKSiy/jpQKzZ7kpyWRqseDKQc
	CIo3ERaXQgk25VbkfJUjYT2U957xIxzu/Sk1ZRQBJK6RaLB7qdrh
X-Received: by 2002:a17:903:3c47:b0:235:5a9:976f with SMTP id d9443c01a7336-23ddb2f2db9mr46315395ad.24.1752064289653;
        Wed, 09 Jul 2025 05:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjreNNXd3+SYHL4S/oHX+L23Vo5LZefCgSCCamZIx++CFBdFw3mmJOU4Ve8ksAGPCCBqWoEg==
X-Received: by 2002:a17:903:3c47:b0:235:5a9:976f with SMTP id d9443c01a7336-23ddb2f2db9mr46314845ad.24.1752064289178;
        Wed, 09 Jul 2025 05:31:29 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431e2c5sm139239055ad.39.2025.07.09.05.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 05:31:28 -0700 (PDT)
Message-ID: <2a18cf9e-1dd2-4e09-81f4-eb1d07324c8e@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 18:01:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-6-3faa8fe92b05@qti.qualcomm.com>
 <qo6mb3qlt3xpuvhepwcv6be4wd53neee2t6buzk4tdiy22xsub@vu7lykp3rnu2>
 <226bab3a-54e5-94ad-9d84-0b82f9dc4e2f@linux.intel.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <226bab3a-54e5-94ad-9d84-0b82f9dc4e2f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686e6122 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=WFThVEArfCvG9L-vA9EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: k4KjrtTG3FKGZVdAi40NfQ5zyrRWeDoq
X-Proofpoint-ORIG-GUID: k4KjrtTG3FKGZVdAi40NfQ5zyrRWeDoq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExMiBTYWx0ZWRfX4prv4DfEXYQp
 fhRNYJcv5ZbXMwmyTQ/thwC4QE+UpRD9CYYGZtpqrthChEkz1WPPdlSUNsj9rp1VLiaxW4MkUYI
 0mDxiH5/MKMFv+CA+rfUuVqy7zEPHoSF2Y8vZuovbHz7snrUHe56u68zZOnQP+IuoQn115Yl6Ed
 phcvuOsPysQfvIkh2rgYW6Ie2GiCiLfU/8V2S9SnZnfxJIa5cJVKcYuuhE9xCHYTvL3aR1bloUA
 QBa7dFY+UpLez2D7l1kn5LbBIz4u8/Gnl8RqhU7tObDXxYtd6QeoOZICO/KtUXWFJTpo0eTuMBD
 pTgqlIu09lUW0QfmD7m2UE0VsL1LmXLUjjlPWl8BObVfOfeWoliC00PHHZQG1TmVVNgQgRfTZOC
 sibOVWyCeDiJi1xI4FCJKkOEo2JlHR3Ty/6UTB97DGXQnUMtYUOMfN1ZLsx/dEFCY9ewCVZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090112



On 7/9/2025 2:40 PM, Ilpo Järvinen wrote:
> On Tue, 8 Jul 2025, Manivannan Sadhasivam wrote:
> 
>> On Mon, Jun 09, 2025 at 04:21:27PM GMT, Krishna Chaitanya Chundru wrote:
>>> ASPM states are not being enabled back with pci_enable_link_state() when
>>> they are disabled by pci_disable_link_state(). This is because of the
>>> aspm_disable flag is not getting cleared in pci_enable_link_state(), this
>>> flag is being properly cleared when ASPM is controlled by sysfs.
>>>
>>
>> A comment in pcie_config_aspm_link() says:
>>
>>   /* Enable only the states that were not explicitly disabled */
>>
>> But the function is called from both aspm_attr_store_common() and
>> __pci_enable_link_state(). So I don't know if this is behavior is intentional
>> or wrong.
> 
> Hi,
> 
> I think it's intentional. Whether the behavior is useful is another good
> question but the current behavior aligns with the explanation in the
> comment.
> 
> My understanding of the situation is:
> 
> pci_disable_link_state() and pci_enable_link_state() are not symmetric
> despite the names, never have been (this is one of those many quirks ASPM
> driver has which should be eventually cleaned up, IMO).
> 
> It might be appropriate to rename pci_enable_link_state() to
> pci_set_default_link_state() to match the name to its functionality (and
> the function comment):
> 
>   * pci_enable_link_state - Clear and set the default device link state
> 
> Note: "the default ... link state".
> 
> 
> I've already raised this concern earlier! As you see, my comment are
> not getting addressed. I'd like to see the author does one of these:
> 
Hi llpo,

I replied to your comment on v3 patch[1], and I feel instead of having
new function() we can use same API to our purpose.
> 1) Renames pci_enable_link_state() to pci_set_default_link_state()
> 
> 1b) If pci_enable_link_state() is still needed after that, a new function
> is added to symmetrically pair with pci_disable_link_state().
> 
> or alternatively,
> 
> 2) Changelog justifies very clearly why this change is okay with the
> existing callers. (And obviously the function comment should be altered to
> match the functionality in that case too).
> 
> If approach 2 is chosen, it should be very carefully reviewed when it
> comes to the callers.
>
I am in favor of approach 2 which you suggested, but lets wait for other
reviewers feedback on this. Based up on the response i will make
necessary changes in v5.

[1] 
https://lore.kernel.org/all/b3d818f5-942c-1761-221d-af7d7e8f3624@oss.qualcomm.com/

- Krishna Chaitanya.
> 
>>> Clear the aspm_disable flag with the requested ASPM states requested by
>>> pci_enable_link_state().
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>
>> Fixes tag?
>>
>> - Mani
>>
>>> ---
>>>   drivers/pci/pcie/aspm.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>> index 94324fc0d3e650cd3ca2c0bb8c1895ca7e647b9d..0f858ef86111b43328bc7db01e6493ce67178458 100644
>>> --- a/drivers/pci/pcie/aspm.c
>>> +++ b/drivers/pci/pcie/aspm.c
>>> @@ -1453,6 +1453,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>>>   		down_read(&pci_bus_sem);
>>>   	mutex_lock(&aspm_lock);
>>>   	link->aspm_default = pci_calc_aspm_enable_mask(state);
>>> +	link->aspm_disable &= ~state;
>>>   	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>>>   
>>>   	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
>>>
>>> -- 
>>> 2.34.1
>>>
>>
>>
> 

