Return-Path: <linux-wireless+bounces-25267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B48D6B01A2C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 12:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B481CC064D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0A9288CB4;
	Fri, 11 Jul 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bz+QdSKw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC52288C17
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231327; cv=none; b=CD5m9XbLqfWqoEGJJYBqd2CVlmbb5yuGCbvPsgxK/eurTO+Q+mCDr3sqALtLqflCmWsbu2RnxOOg7z30iBS5QCfJbv072dhaLTPUquzSfEIP/uvhNUTOwPqigJkoNbLS2anlPv5IhRLV+ouUVnAxuuF6mBjr3HVC8slCxvJHtQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231327; c=relaxed/simple;
	bh=2xu+OXOLKfoKa+DHjFfwab+SE6ntpEh2pVa/29N5gAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ctl1OajXE3s1s1lBtsn0MLAB9KemZMa6QAAjam/DkLdTqiIoA4BX6U16wQ1oPSc6DjJT1kR4Jx6dDseUMNKYZpn3XRGQnK3Cq4BY/KSNxprvYZ0MmwNqluAtSrRdICvs5qOO5BynwQ4EQg2FEEDJn1pwUpbrxZBxCooHQCTBZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bz+QdSKw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BADFsq021884
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 10:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RBto8+nkBzC3SIB5+AQtnfGYPNuUEuMvL0M4sbENf7M=; b=Bz+QdSKwQl5wal/U
	gbg+0WNw8MtXdTa6Uj7kikkL6LG93PVtd1ukrhBBNo+7sDT8LDNirMEIL8DpW4l2
	yhwwHsETVlCt7X6wCyeE+hfmdhGU9ur//FySrA3jehGFrSYHOtPL+fXo8rSaHq1l
	VJNcEuAPbd9W0KONfQMPj1D6fX2Tk7oAOjrntUj6IXeWm8WMFdt2CKpBfxP/1Bo0
	5c+v8w1pNWFWASpvoftVHdLNHFRbYUmvTVSaYwbXtK8tdTQ3E7N0P98WEVO5F+2d
	xB3GTzJhrD6lMeyiTNyHVAMMROAPUbrPt4jvHM0rRiwD24R7bgS8OAMZmfXVVRMt
	AsSTDA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b19aw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 10:55:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-236725af87fso32214805ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 03:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752231314; x=1752836114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBto8+nkBzC3SIB5+AQtnfGYPNuUEuMvL0M4sbENf7M=;
        b=qBYcE7X6GT03pWcKlNLSsMW7lMC/uWQjC4BNWfUrYH7C2xgk4hItfRPvreWVG/OXlD
         DxDYM6n7sKLozZnU8xM0NCCslFkWa8ta3lMX2rdjAsjGpExJ+P1nkKzUcMHwy6d4HeZH
         sUGI3YjDlGl1aa+AxiVrRQliai3Xcam99RUCDrN1brKM55Kbtb1TzUgYqjluxpRug3N1
         gfqHMnEcTb5soO9p7UjGE3t2oHWPdh1aVzVDLUIGBdveTVaOHK8p0KOtwokzph5FR1dp
         KHqKMsw2qdKB0afNedYTCqqnJtXBgNdHG2uUpo8Im0Z7nMx1rk4xVXfWQYlAzkOPquU3
         Jwfg==
X-Forwarded-Encrypted: i=1; AJvYcCVEjQQWtQ4xP39WJSv2/CQEgLEbKVWx+XmaEdSFHtiLXdjuaY3X8bzCTBxjm5A8pXGRWqhlv3wTIF6mRj63kA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyuPmOhzt3zVLjvFN2p5Qc+7jDbYjnoFhe77ZaWZlW7CCiAnit
	WBeYm5QHuypbbRd5PBFFUE6Vc+9GxRPhrARCnvTkZE1ogsM8StX27AFZbU5WSYVVCD/Ts4YBH3H
	Raj7jyR4KRysTuEVSIG2knT+K7on/9iFTlSUEUF7etfBQGATwhe7pdprOQOhVPdHAPLX/Jg==
X-Gm-Gg: ASbGncvpy60A8gAkXEPl365Yd0xvdw7l5i5qIDrDCp8KFgSlI4KTkR5kYSclvdr8UON
	VBjiMx1AJx9FDTAMXHxcB3d57AB1D7RyTlzgsikWO8fKiSYuoEeFBHVkn5BsTnGA2SUstfT1ROC
	HBl+TcgxZhkBC2/3XYhziT784JW8v/4YP8XhjEddjKLMMYbY/JlwoKvOzg9RzX1e0rN3D2EMxPo
	ejqDWVKYw9MOw0KueOmEI73sd1LQHDrdaZ7LFC/Bih1eXPHukM+IZFYcub+e2YM8hu3D+G+a/jm
	fxHI5lwX0ie+Yku9LnnHFksHLd3iJaVNEcefAsMvbIRPuJptViBmTtj8ZEB6mQCWae7r
X-Received: by 2002:a17:903:19cb:b0:23d:da20:1685 with SMTP id d9443c01a7336-23dede2d1fbmr41332515ad.4.1752231314422;
        Fri, 11 Jul 2025 03:55:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO7zVGoYd5Gn585ClIUPh1ymONaAtRPnkgGM+Z60hbp5/SJEPrqzqHuoCurum2APuuK+XViA==
X-Received: by 2002:a17:903:19cb:b0:23d:da20:1685 with SMTP id d9443c01a7336-23dede2d1fbmr41332125ad.4.1752231313936;
        Fri, 11 Jul 2025 03:55:13 -0700 (PDT)
Received: from [10.92.212.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aef8fsm50345125ad.76.2025.07.11.03.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 03:55:13 -0700 (PDT)
Message-ID: <35f057fd-9aa0-4de1-a6cc-0d17ffb99e23@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 16:25:07 +0530
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
 <2a18cf9e-1dd2-4e09-81f4-eb1d07324c8e@oss.qualcomm.com>
 <irnkdlrmlozp7joydgnawfuivl2nnuxsb2t4osgxzbtyrfzd3n@7dhzjcd42aiw>
 <c7d4288d-4d0e-a3c2-83d2-c3f1b282d4ac@linux.intel.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <c7d4288d-4d0e-a3c2-83d2-c3f1b282d4ac@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=6870ed9c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=9wcXyvJq732FR575IagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3NyBTYWx0ZWRfX9hiO4WDFqRuK
 VQG79N7cd7MQCliKun4S+5s24AhanP0YeiMsAG6XHelbfgR6JcXRDs37NQclcUMxhJjCdzZ5glM
 oSH4lds31tFjycwlJWQnKe2z1X6dyhFVtsJyctiAjU/+Qv7D357X3rDCRsCSxbivfvddB3Q3JSI
 L3HmZXOAtV7jdfJz4Jbe5X6J58kSnBRExnnfnSy0dtJBQ7tj6EsrWwXg/Wa9ifpkF400vRdu85a
 fGr98KAW1XGsy0Exk+AmSCELc0SG06RNYhcjRRLKRhJsafv/G8K8CbGwB2SQ5reK/cRXnzNlXFB
 y258qAjZkZzw96UkQ1vnXSBvRI4mHilkNGOS3Fxl0F/UZO3f3BCUBBIkil1Z7W3ngUwldTkiDLD
 GM1ogVlgsfnaDCJFtN2ZVGYsGH5cxjVnozB96EhH4Ti8pGBzVjo2elyuxWpQyHw1qDVDx7B2
X-Proofpoint-GUID: 4wVCJO20GghjSK4GTDpFsYEL9AmLIb9K
X-Proofpoint-ORIG-GUID: 4wVCJO20GghjSK4GTDpFsYEL9AmLIb9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110077



On 7/11/2025 2:51 PM, Ilpo Järvinen wrote:
> On Fri, 11 Jul 2025, Manivannan Sadhasivam wrote:
> 
>> On Wed, Jul 09, 2025 at 06:01:22PM GMT, Krishna Chaitanya Chundru wrote:
>>>
>>>
>>> On 7/9/2025 2:40 PM, Ilpo Järvinen wrote:
>>>> On Tue, 8 Jul 2025, Manivannan Sadhasivam wrote:
>>>>
>>>>> On Mon, Jun 09, 2025 at 04:21:27PM GMT, Krishna Chaitanya Chundru wrote:
>>>>>> ASPM states are not being enabled back with pci_enable_link_state() when
>>>>>> they are disabled by pci_disable_link_state(). This is because of the
>>>>>> aspm_disable flag is not getting cleared in pci_enable_link_state(), this
>>>>>> flag is being properly cleared when ASPM is controlled by sysfs.
>>>>>>
>>>>>
>>>>> A comment in pcie_config_aspm_link() says:
>>>>>
>>>>>    /* Enable only the states that were not explicitly disabled */
>>>>>
>>>>> But the function is called from both aspm_attr_store_common() and
>>>>> __pci_enable_link_state(). So I don't know if this is behavior is intentional
>>>>> or wrong.
>>>>
>>>> Hi,
>>>>
>>>> I think it's intentional. Whether the behavior is useful is another good
>>>> question but the current behavior aligns with the explanation in the
>>>> comment.
>>>>
>>>> My understanding of the situation is:
>>>>
>>>> pci_disable_link_state() and pci_enable_link_state() are not symmetric
>>>> despite the names, never have been (this is one of those many quirks ASPM
>>>> driver has which should be eventually cleaned up, IMO).
>>>>
>>>> It might be appropriate to rename pci_enable_link_state() to
>>>> pci_set_default_link_state() to match the name to its functionality (and
>>>> the function comment):
>>>>
>>>>    * pci_enable_link_state - Clear and set the default device link state
>>>>
>>>> Note: "the default ... link state".
>>>>
>>>>
>>>> I've already raised this concern earlier! As you see, my comment are
>>>> not getting addressed. I'd like to see the author does one of these:
>>>
>>> I replied to your comment on v3 patch[1], and I feel instead of having
>>> new function() we can use same API to our purpose.
> 
> It's not about what "feels" something. One should clearly write down why
> such conversion is correct/acceptable when it comes to existing callers
> if changing an existing API. The note should be such that it remains a
> permanent record for future (in the changelog).
> 
> I don't have answer to what are the expectations or intent of the existing
> callers. Convincing a patch is fine is responsibility of the one who is
> submitting the patch, not reviewer's.
> 
> Unfortunately, it is usually quite hard to figure out for existing drivers
> we're not familiar with. I'm not saying your "feel" is necessarily wrong,
> but the existing callers need to be properly investigated if you choose
> that path, not just handwaved over. It likely boils down if the
> ->aspm_default and controlling it are useful features to have in the ASPM
> driver as your patch would take away that ability.
> 
>> You replied to Ilpo, but never got an agreement. Please try to close the
>> discussions before posting next rev. If reviewers forgot to reply to your query,
>> feel free to ping them in the same thread itself.
>>
>>>> 1) Renames pci_enable_link_state() to pci_set_default_link_state()
>>>>
>>>> 1b) If pci_enable_link_state() is still needed after that, a new function
>>>> is added to symmetrically pair with pci_disable_link_state().
>>>>
>>>> or alternatively,
>>>>
>>>> 2) Changelog justifies very clearly why this change is okay with the
>>>> existing callers. (And obviously the function comment should be altered to
>>>> match the functionality in that case too).
>>>>
>>>> If approach 2 is chosen, it should be very carefully reviewed when it
>>>> comes to the callers.
>>>>
>>> I am in favor of approach 2 which you suggested, but lets wait for other
>>> reviewers feedback on this. Based up on the response i will make
>>> necessary changes in v5.
>>>
>>
>> I would go for (1). It is always going to be a problem to change a legacy API
>> like this. We might end up causing regressions. So it is safe to rename to
>> reflect the purpose and try to come up with a new API that does what you want.
>> If callers want to migrate to the new API, they can also do it in the future.
> 
> That's my recommendation as well.
I will take this as learning, we will go with approach (1) as both of
you are having valid points.

llpo,
In the previous patch you said you have some patches on can you send me
those or shall I proceed with patches from myside.

- Krishna Chaitanya.
> 

