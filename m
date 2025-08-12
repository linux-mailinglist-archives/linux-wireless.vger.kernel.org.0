Return-Path: <linux-wireless+bounces-26303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11891B22347
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 11:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455341715F3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AB52E92C6;
	Tue, 12 Aug 2025 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VRwOt31B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3932DF3CF
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991154; cv=none; b=I++L0dudQQE4UpxTH/0aR4a4CnAXqcAe58Ar2q8HVSeOszZmcD8ex+6nzmT8WpaWnsEMxzKR7HUCqB5rCI18vZ7ahxifJWtqg13YgSeq17P5eNZy7yjBX2kyIhLA/JB4zMHleqctbY8hWfOz10SSbCK4D91NsxYQdFv0+nvvn2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991154; c=relaxed/simple;
	bh=KBltDy1VlOm6vly3kEqikeo37kbO/rgKlf8mjUJGwKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoOmmMt2g0KkDd3gp4BfIWjhD60MmdTXiidj97PecZW1B7tu4v7PHj8Qql7lOqEt3OvzB5XLTIF8zxZAFnethbAR/sAfmi/p9nP184khKB6LzwCq/rclNwpSvRpjTU4Mwj2csFDcLlOEV3QHzN1/C1pUx5yvXVeCocDDEDUVS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VRwOt31B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5Y0E1005398
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 09:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7n24b5y09554bTu/Veo3VDRFW4pPHKlo+XBhAE2yofU=; b=VRwOt31B+kdwV4Lc
	HbCkN4bGsdbKDoq6E9J/tAgN+Siin1Fd5VRPjlzYzVehmkdAJsl4h6iSzOSXrgo9
	fVmKvsD1M38R6Cf/xtch0CCyZiiUg2QfsrfigToFbGgw99XNnMb2lT1A5/5ZiSF1
	bkzG7EqGv0nNhebOYPUwO1otY1USFEl06+cs+uTGRl0vvmjaGjPvkO+oSivykrk4
	GTaJgm1F7gaVZBYrDbOgrPrP7SzmpiM9tSizkHUmxlQiR5mJrmmaeF6YMPeYe5w2
	3TYEikwPLlve3n2zyT8jNU3143grbvJyoQau1KqR3zY6vB84F442EBSE4RSfu6ia
	ZvSSGw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx5sny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 09:32:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-242abac2cb4so61399195ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 02:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754991150; x=1755595950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7n24b5y09554bTu/Veo3VDRFW4pPHKlo+XBhAE2yofU=;
        b=uXY9tX97Svn/zTLZzecz+0Jp/dMILPCJkua8BxoVJCt6mTncAdsCk3T4cFVxK8uxs/
         T5+1Of/p6mFRYRIk0KQPGr7ZH7xUcSpv0QKxsMNdt7STVhnnGMuJsy1DL0oGcwp6p33h
         TQGBaJVad5+lTgya9bAth+R3U7/MLuIqoEbFutZE7GI6PlgqNZkiIZQwqjjV3zc6iRPI
         v2uv3xTPA0pOV0eGrTiTzHRQ4JiXYhzEN+sJegfPoL7JHs0hJkGTB0R09ie40qvJ8gnR
         ss3HibE37LHPtzZSiWgPPqL1PVINB0+SNfhNu0AgXByCnmUpXxpUGCwsisx8j37xYfb5
         +tNg==
X-Forwarded-Encrypted: i=1; AJvYcCUFkiibZBzLu6/JTRgonkaI242KdRqgN8Xd6RTRAkBBl2BGUmJ4Dovx93lANmgwL5SBwTXwWcZGlVeptyStEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsyWdfg8l0A/ODgJkumnaDhEx4/NqPkwaqd1CNiFnoAb4D52sO
	DrsIq9mx61UFbcgmpAma4hRpGGnZdJJdW3e5Q1SKDqZ5AG8SakRv1DkgWqEyY1+B9hjhP60D/2I
	qWtpFNo9KNIn0zkqCLrLY5UNYL3BT9sxYubLhojtzZGqXbv/cR/mTskpoN17rTAA/xq/xtA==
X-Gm-Gg: ASbGnctNpT2WpyO+3vLlBqBMBIO6TfPrn6QsNpA4Q+HGbQIudceRk0CNkiV7lEf36Ad
	LlC3go/LKIsLcz/N2pVz6IXkKAxYENa+ufh1FFAOnPv46A1VTcHUHqxqwScILVuf3aMmVb74lfz
	ym1cCRJiuM+x1lwmvNstMzdfRToYu/BBD1ydRLba4ZO+w7qGSHfr/6NcEb+Z3vWWCSxjdouRQvU
	VO7W3uz3NW6jKEzrIDgs1dLxMdzwkz6/dbCHLxYSlmUxPgmoayYk1dELuAod7l+HEmASymG1kZe
	lj3xmkhgos+tEonXRDLKjkVxIKKy7wGvX6+v5gKPvMYaAypnJyTKGRLstDvdJKiIsnH2T5XEIA=
	=
X-Received: by 2002:a17:902:ef07:b0:243:485:269d with SMTP id d9443c01a7336-24304852b18mr13228375ad.31.1754991150186;
        Tue, 12 Aug 2025 02:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9kdodTnnV+PESNDgF1+JEyc7nLGF4AcUeaMfke5Rq0BxrIP5ikbInr31f30kDeqp4lDDApQ==
X-Received: by 2002:a17:902:ef07:b0:243:485:269d with SMTP id d9443c01a7336-24304852b18mr13227695ad.31.1754991149647;
        Tue, 12 Aug 2025 02:32:29 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aa9055sm296829815ad.150.2025.08.12.02.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:32:29 -0700 (PDT)
Message-ID: <5dbd782a-1d52-4614-9e7e-3b7d9dfd099f@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 15:02:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
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
 <d4078b6c-1921-4195-9022-755845cdb432@oss.qualcomm.com>
 <68a78904-e2c7-4d4d-853d-d9cd6413760e@oss.qualcomm.com>
 <3939605c-7335-4401-ba32-b88ee900f1d5@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <3939605c-7335-4401-ba32-b88ee900f1d5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX9gq6tyWvl1RQ
 D8euRe6OJcdRUM9GhGixLzkvu1v6UIq9TI2K7WYqhx4V8+Uwp+NC+EplKTXkAeQohchC6zassw5
 XKDCCiOOlc0ViVJdxa4+SiNBzCx3RVy+N2nDz42NHIXdV1Q+zdMT7uEJpSScRVAlevK8bhexw95
 AS8XossOKFyD8fjFCfILTPuogtiD7TCTCd40errhpED+i0sfjhEuGYubPET4vUMqQGyFppRviLb
 k69zpDC1zsmIcLUS8aMceOzycrB2Qqtpdvft6M0OGTMOJGTNpLdMKYOlRvf7JiOti3VByrx+bCf
 bH8Nx+UWiCGs/GViDo4ruET/boheFPYSuhbEmGzIEJ0zCC/osBIzZeoNEm6goF2nyh4KRvgCtjG
 linQqjb9
X-Proofpoint-GUID: _c_19mRQEIDf-OOsYy1riiXl0FuDEVzj
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689b0a2f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Jnfc8Lo_MkJUCzdN-ZEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: _c_19mRQEIDf-OOsYy1riiXl0FuDEVzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057



On 8/12/2025 2:57 PM, Konrad Dybcio wrote:
> On 8/12/25 6:05 AM, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 7/22/2025 4:33 PM, Krishna Chaitanya Chundru wrote:
>>>
>>>
>>> On 7/12/2025 4:36 AM, Krishna Chaitanya Chundru wrote:
>>>>
>>>>
>>>> On 7/12/2025 3:06 AM, Bjorn Helgaas wrote:
>>>>> On Mon, Jun 09, 2025 at 04:21:23PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>> If the driver wants to move to higher data rate/speed than the current data
>>>>>> rate then the controller driver may need to change certain votes so that
>>>>>> link may come up at requested data rate/speed like QCOM PCIe controllers
>>>>>> need to change their RPMh (Resource Power Manager-hardened) state. Once
>>>>>> link retraining is done controller drivers needs to adjust their votes
>>>>>> based on the final data rate.
>>>>>>
>>>>>> Some controllers also may need to update their bandwidth voting like
>>>>>> ICC BW votings etc.
>>>>>>
>>>>>> So, add pre_link_speed_change() & post_link_speed_change() op to call
>>>>>> before & after the link re-train. There is no explicit locking mechanisms
>>>>>> as these are called by a single client Endpoint driver.
>>>>>>
>>>>>> In case of PCIe switch, if there is a request to change target speed for a
>>>>>> downstream port then no need to call these function ops as these are
>>>>>> outside the scope of the controller drivers.
>>>>>
>>>>>> +++ b/include/linux/pci.h
>>>>>> @@ -599,6 +599,24 @@ struct pci_host_bridge {
>>>>>>        void (*release_fn)(struct pci_host_bridge *);
>>>>>>        int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>>>>>>        void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>>>>>> +    /*
>>>>>> +     * Callback to the host bridge drivers to update ICC BW votes, clock
>>>>>> +     * frequencies etc.. for the link re-train to come up in targeted speed.
>>>>>> +     * These are intended to be called by devices directly attached to the
>>>>>> +     * Root Port. These are called by a single client Endpoint driver, so
>>>>>> +     * there is no need for explicit locking mechanisms.
>>>>>> +     */
>>>>>> +    int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
>>>>>> +                     struct pci_dev *dev, int speed);
>>>>>> +    /*
>>>>>> +     * Callback to the host bridge drivers to adjust ICC BW votes, clock
>>>>>> +     * frequencies etc.. to the updated speed after link re-train. These
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
> 
> Do you even need to set the OPP explicitly? The global irq handler
> already does so on linkup, and you seem to toggle the link state in
> the newly introduced helpers
> 
> Now not all DTs currently have a global interrupt, but that's a mass
> fixup to be done anyway..
> 
Konrad,

global IRQ in the qcom controllers will only come in only on initial
linkup, and later on link speed change through bwctrl driver we will
not get global IRQ.

For QCOM controllers we need to change the RPMH vote for example if
we want to update the PCIe data rate from 5 GT/s to 8 GT/s we might
need to update the RPMh vote from low_svs to NOM corner before we
initiate link up. for that reason we are introducing pre & post
link_speed_change function pointer.

- Krishna Chaitanya.
> Konrad

