Return-Path: <linux-wireless+bounces-25847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23242B0D7A9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 13:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4C43A2D3A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3D02D8766;
	Tue, 22 Jul 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTRM5A+Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4164C2D63F3
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182242; cv=none; b=nbn3eEo/hM6PjKYaOAWcLdzHPkwq/X+RXY+XwaVKTWoNDpZBg+eL2KWTjZJ4/IHiaEKISvZ1AV8svfo9vtIgC/EBo6IQKxEGtb60dCRtjfOFOYznSDw3G5nSxIz5+JciXJSTrCXJ1ZwVlEuPEa6Va7kLTw5lXlw528nn7GQLnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182242; c=relaxed/simple;
	bh=kWCUG31bkJ6dZkQu4ecUTQJmDb9akcJNyNVIFUvX4So=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CwSeSp/syAxabQb4fMUj2fXXaVWaft/ZEd9UQKJ6x1wXp1nWaIAchdTveoED7a2U0HPpK+8pNSvGaOlSKsXNRugXGhuaCeVVsPwtYkMyvdjUcNp013Ynw4s28s1AVn4or0cnvVJBYQPzHmq20ltblqraugzKXqWp9+TUA3ith98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gTRM5A+Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M4djrH016432
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 11:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jCcIy69ciDOUcVdtD2bZCMzRk/SyBUFRLG70HN1E2+Q=; b=gTRM5A+ZXBV1LYZH
	oVBmEosxHP33U+7/2sCjFSscWe4nGK/f+gXjn5xNeKKUV1yqF6yNb7EFMn0i8LRR
	16mhIwk9iplEJHanlgtA783cn44423NPSDypNTK0L/GbZUsgmTL96QEYBUm2ko7+
	CCrwFohoQJjQPt91kyCR0aCn/iyGBgFhB9XNH2kIRlEqGPsCnkJC7LxqSY4jPrOK
	iKo5zANUOwW6Vw3jcKypisxjmS7VHgiZciDZS5sxKjBkPOG7Frg4d/zFg28Spfp2
	khieEqYk/0ri3+2XImGWUKMe1zVosO5/wq3L5wzBpx7TPhMmX8RXHM7QrMGYc6kr
	cbL36g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451h11r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 11:03:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-75494e5417bso5051864b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 04:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753182238; x=1753787038;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCcIy69ciDOUcVdtD2bZCMzRk/SyBUFRLG70HN1E2+Q=;
        b=Kqg6kKAGxKlwccyzkhwr8hlC0nFYTiefk3p8jQhsPRqqPIt9IuxjBxKzrHsJBfpyK7
         HLhTrZGRF5RBPyfIZ7q7qjlMNl7mkfxC9MIWugJl0kxcpxe3hrVMRMr72RjvyDi9sLEx
         wXtSie+h8pSfgUsJI8KcBhfvqZ9Im58a6Gf+0ICxUkKfCqiehTP0t6U0Y2e2ColbTbF3
         5XKoSx+a4l6NHJ9AInmmMzk8lps/Cia3ZPWEbDXiqTUAQ3i8C0FkSo/lEHQTbWsxvtlX
         MRqI2cBmckz+XyCIsPzXPHhxtmb5W+6mi+iBykxqhAdlqDfoRF1pWfZYHk8ip7QFR+eh
         J3fA==
X-Forwarded-Encrypted: i=1; AJvYcCVD9tMoUL4tAsuX5wrh4fZi74Qa1aatqCQueMgH2jPtazPjPCUtnmFtVpFt3oYV0sf96N4iLmCmYQq3YlT+Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwUEmWaW8ox5Y8KELOV5Kqj/kKAKaPMTskr7HJXGIeE6/ZlmJ
	ulIiBnJFKvWgkYe0UT0z+pK6x+73rZb/rU02m//1Pb6KY644jAqKjT4WgNv3HIcf8/RnzTBrPMc
	I2+5dk86j5BiJmTCaEH1/6/8KWm9lOfPuJcj89/TjUR06UKkm2EyGy8hWOY6eKQgLwuvt+g==
X-Gm-Gg: ASbGncv7JmZuzpbF4cF3kaKJYX7/u9ZDKMNsH7+ZADjzDB4fO4aHSlj7wW3WTIir7I6
	8+76ItShLE/HJpJRlGeAXusbwDLJZYqryvPELa9cbqXFDStb9kov3qBksM4kkSsjWZy2h0zj/Ah
	R05GhnDd8j1kO2RiIlsgbeTVEn7CoMVKqdyyckjCVczen7qAYTM7br/dQWd5MuuBnnlAltHPALq
	V11EWxdl1xFLBm8o0QxQsjm06t9cjV6fkwzq2kntGvU8JTKnYkvUIxrtObD/aAVZrkdLyQaa6O1
	280jsOk5KqqKqbWQeHs+HZdpAG9AhNoMLrTN/SOEnQ5kEiYxa8zFN8quGIZoajiRvV6BKB60Wg=
	=
X-Received: by 2002:a05:6a00:1817:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-75ed156d03bmr3761903b3a.6.1753182238336;
        Tue, 22 Jul 2025 04:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgZIDkCUV2AXz/9PK4/a4NCij1DJxFB71Da611o7fAf8jI0CKXgwVrcrLnlMSH3ym9h+L+Lw==
X-Received: by 2002:a05:6a00:1817:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-75ed156d03bmr3761869b3a.6.1753182237848;
        Tue, 22 Jul 2025 04:03:57 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbd67ed2sm7293938b3a.135.2025.07.22.04.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 04:03:57 -0700 (PDT)
Message-ID: <d4078b6c-1921-4195-9022-755845cdb432@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 16:33:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250711213602.GA2307197@bhelgaas>
 <55fc3ae6-ba04-4739-9b89-0356c3e0930c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <55fc3ae6-ba04-4739-9b89-0356c3e0930c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687f701f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=UU_a8xXafIRJjp1WqNEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 52-D2eF96bT0wzZn_CYfA3e5zgmMboLo
X-Proofpoint-GUID: 52-D2eF96bT0wzZn_CYfA3e5zgmMboLo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5MCBTYWx0ZWRfX2+YPZic6AOMx
 ZCHBXoCyap/mPUvuOSXry6GpLPK80hMIlv/MGt2WK4KPx0ptRQW4vSCAqyFDNlubVQ0pIxKjdHe
 nMCQ7LoxGmTJbkIjr0jj1UHn9FMlhet4ActAxXG7PuG9wR6ZIppknfvFUlrT9eN8hsqFDh84z8i
 52MOPOu+VCtvnTXLyVMnUFebfVqXm45PGvQ9K8JO2OcG/VuzMJcI2zryOdSk8yoDux0s9wC3qXJ
 SHC+sClWiUdBSKO+1bWO8JdTfXms2QL6NDn801DXmTr4W8c9z5ejoA1k1xzYTkH6KfwJUZaAVF9
 K5ir8gdtLGs5ESlAUXNsVne4meTMDNJ65uz8Cqm7CI7lNN+Jxx1ERzqae7aLyIwRDJI/a5lrZCh
 lkERY4KdEoLiwThw4361n21IqW47ZYj0Z/uGl3UVIvxjKQ0CiNHdl6yDsqcwuT6Bg1+3Wl5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=965 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220090



On 7/12/2025 4:36 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/12/2025 3:06 AM, Bjorn Helgaas wrote:
>> On Mon, Jun 09, 2025 at 04:21:23PM +0530, Krishna Chaitanya Chundru 
>> wrote:
>>> If the driver wants to move to higher data rate/speed than the 
>>> current data
>>> rate then the controller driver may need to change certain votes so that
>>> link may come up at requested data rate/speed like QCOM PCIe controllers
>>> need to change their RPMh (Resource Power Manager-hardened) state. Once
>>> link retraining is done controller drivers needs to adjust their votes
>>> based on the final data rate.
>>>
>>> Some controllers also may need to update their bandwidth voting like
>>> ICC BW votings etc.
>>>
>>> So, add pre_link_speed_change() & post_link_speed_change() op to call
>>> before & after the link re-train. There is no explicit locking 
>>> mechanisms
>>> as these are called by a single client Endpoint driver.
>>>
>>> In case of PCIe switch, if there is a request to change target speed 
>>> for a
>>> downstream port then no need to call these function ops as these are
>>> outside the scope of the controller drivers.
>>
>>> +++ b/include/linux/pci.h
>>> @@ -599,6 +599,24 @@ struct pci_host_bridge {
>>>       void (*release_fn)(struct pci_host_bridge *);
>>>       int (*enable_device)(struct pci_host_bridge *bridge, struct 
>>> pci_dev *dev);
>>>       void (*disable_device)(struct pci_host_bridge *bridge, struct 
>>> pci_dev *dev);
>>> +    /*
>>> +     * Callback to the host bridge drivers to update ICC BW votes, 
>>> clock
>>> +     * frequencies etc.. for the link re-train to come up in 
>>> targeted speed.
>>> +     * These are intended to be called by devices directly attached 
>>> to the
>>> +     * Root Port. These are called by a single client Endpoint 
>>> driver, so
>>> +     * there is no need for explicit locking mechanisms.
>>> +     */
>>> +    int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
>>> +                     struct pci_dev *dev, int speed);
>>> +    /*
>>> +     * Callback to the host bridge drivers to adjust ICC BW votes, 
>>> clock
>>> +     * frequencies etc.. to the updated speed after link re-train. 
>>> These
>>> +     * are intended to be called by devices directly attached to the
>>> +     * Root Port. These are called by a single client Endpoint driver,
>>> +     * so there is no need for explicit locking mechanisms.
>>
>> No need to repeat the entire comment.  s/.././
>>
>> These pointers feel awfully specific for being in struct
>> pci_host_bridge, since we only need them for a questionable QCOM
>> controller.  I think this needs to be pushed down into qcom somehow as
>> some kind of quirk.
>>
> Currently these are needed by QCOM controllers, but it may also needed
> by other controllers may also need these for updating ICC votes, any
> system level votes, clock frequencies etc.
> QCOM controllers is also doing one extra step in these functions to
> disable and enable ASPM only as it cannot link speed change support
> with ASPM enabled.
> 
Bjorn, can you check this.

For QCOM devices we need to update the RPMh vote i.e a power source
votes for the link to come up in required speed. and also we need
to update interconnect votes also. This will be applicable for
other vendors also.

If this is not correct place I can add them in the pci_ops.
- Krishna Chaitanya.
> - Krishna Chaitanya.
>>> +     */
>>> +    void (*post_link_speed_change)(struct pci_host_bridge *bridge,
>>> +                       struct pci_dev *dev, int speed);

