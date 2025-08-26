Return-Path: <linux-wireless+bounces-26655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C5B370AB
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758DE3B23D8
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 16:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E301F2BEFF6;
	Tue, 26 Aug 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G58DRmbu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65D293C44
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226443; cv=none; b=WeeuDz1rl2qQHFf4uiUTHF05T9U+8MxXoUzWmhwnPkzthw0bO/hARaEsQOrdc0+5w7YxY7u4ifG9GroU93Ahrp+61LPfCl+BcoQ+aIGZGx7fvu1g5ub7KVgbKkJfGlsQiJ37L0nG9ydBguXxyFtGUnmH/zx7E+0bCSi1Q7gbtGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226443; c=relaxed/simple;
	bh=J56EJimurRukl3HtUzV6/w+RvxdfQC5smmvRwJRThGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZ3H+T2wW42A1CyfPRDYALNCXRzcwuEjKB+t/IrF9SgOXdEv4GtXRsRz+uczuGUqhYiNoL7L8LbIFiZN8Q8QLNwUkKnHJJw3yBprygbtRjN2x35WCAQCLfW458E2MIkC1m4J3EVvDN2GCGOmt13CO45yMTM2YtoGHsZ+KhK5QhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G58DRmbu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFrexb004390
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D8Cf1CJKboWxP5q6R9op8Umbt3K2i/Dw/P1MbHCzwOI=; b=G58DRmbuwEUS4o2h
	8tV3cbWxBlhGZysuRweeh60AncgOaM3rPSQVPCZoBEAdLGxK60cKoGCIOuJEcL7m
	Q9mNEve5xv+EfeCXpqc3lWz+dr/U9cV+wYYyO1mPltRPWf2NarpdBrziynk4lUsz
	NeFX+VrObpy/5frnVlzvuOKGstYpF33J3323wdw/xDs9NC6GxCFqOLKk3aG9gaF/
	vX/DA3S0beVvqKryKMVJ+L5EZe/2ZKps8tdsnIKx7+EwA68MhxdGvLDSWLRz3R6x
	YAiQoB857POlABA/DuetPtzzqDFQ7rzMPHPm2rA5kM1xdzqfeXjPaA/ca0Jx3Ly/
	ju7H9g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we1gcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:40:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-246164c4743so106317385ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 09:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226439; x=1756831239;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8Cf1CJKboWxP5q6R9op8Umbt3K2i/Dw/P1MbHCzwOI=;
        b=h0Trb0Ijkb1aWNH1yW/y5ZkSoRdMamU5iQOW3F/rFbjDIxVNlmD42Vx9f+Kxakn4hw
         V0j7QYcRwM/R2rupcEVml5NTctPMFwlyXlyRLNal7DobJwOx/qiMz8zFmpPh5cWSax8J
         DUySSUC65aRUWgcFmTiBgjL9smPeq7Eu40Oqhn+Yyvw1JfFHqUUUO8mu/kjcn42065pg
         dUQT92WyMgRH9K52KxWHeyOHe66hVleeDucFAp/OelUqoVxtaKWEzuON1X9T4Fthx8aw
         sywEzMjL7cVnHaGPMo/iNTOHA4q2zzfsWFGiJ7sK2+6SLjDKfQ6h9STkmQzI/8cVu7AY
         QW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9KzUdbybRZepVQjlQyc2gcXoYPuOrLDim2G3MM7sm/HCe0+HI/HtSZbMFkw+54okUe3PFiUo0wW5O8gvb7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRri5nqi6pw2pt0yhxKICiqsvaj6iG4E6EQLPjXRj6mAAL6M7D
	TAo4gWwu45m3yYKMhK+dnlKJxj4fjhm2jwqmcV/Gmk3aIphUVRCVCt4WwSjASdIJGs5W3ceVOsn
	wOxpPoSsJ4OF2Wcs6w83XtalDydtH4/5KjpevfP8hGMDNYITgmTpr3hrpE07Psl/Uvw9b9Q==
X-Gm-Gg: ASbGncvSGEVbsyOreupncpUH9O+076Qsuf++G8F8QSpUypvTutmQDn3/7aTn5Zs4LQy
	a7/CpBflzEN/QjRnP7WefzCXbjGcpmPYGTwdthBRY3FW5iRD8S3pKI+g0RxXe9zs1F7xAi6OXTr
	uThdHwB0LYp0v/yyosOCcenBhuOHNZRb63jXluekUolo2+M73ZTFDO8ZAuGTNKVJkVFNd9Ps5Jx
	rgCuEAGzGOl5qktKWEUd7ihpmlfsIE0yTJdketzXCZZd0/BVl4MjA6VEaCrljYWi4UFoUlZvrkd
	dbmGnGv6JWTWjvbZa496VOn9Tj/8wtrgaqJmAC0s1dE+PMotIlyRq4M6nIDapP2OnGhsKG6kJwj
	a0EcI7VdGrN5sUYhjhrY=
X-Received: by 2002:a17:903:187:b0:235:ec11:f0ee with SMTP id d9443c01a7336-2462eded8bbmr208960615ad.14.1756226439421;
        Tue, 26 Aug 2025 09:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkvFu2SKqaYn2g8jSdQZR+kEMDsbfiuYDSgXyjcnbv8H+hGCJesN+r1R0F9BmVI7ktbx+DaA==
X-Received: by 2002:a17:903:187:b0:235:ec11:f0ee with SMTP id d9443c01a7336-2462eded8bbmr208960165ad.14.1756226438902;
        Tue, 26 Aug 2025 09:40:38 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668864a4fsm100775575ad.91.2025.08.26.09.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:40:38 -0700 (PDT)
Message-ID: <e4178055-f3a6-4cb3-8c86-731130c6f25a@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 09:40:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] wifi: ath12k: Use
 pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org, ath10k@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
 <20250825-ath-aspm-fix-v2-6-61b2f2db7d89@oss.qualcomm.com>
 <2fab10a7-8758-4a5c-95ff-2bb9a6dea6bf@oss.qualcomm.com>
 <705a4fe5-658e-25ac-9e4d-6b8089abca46@linux.intel.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <705a4fe5-658e-25ac-9e4d-6b8089abca46@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eN-H0hxdbyW32mgYgQpWFmQsKgiqwBtC
X-Proofpoint-ORIG-GUID: eN-H0hxdbyW32mgYgQpWFmQsKgiqwBtC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX7rNwAAlQoAFH
 Yy+pafK0rG2LdttG5eUVrblYzAxpphVuSxWfIKIxnX3aHMIJJIVwPkfUOoylrXYb0YLVoejZgPz
 /t6MvYLM1GV/suwWiM5Tn+Lk1RrlJNRyLFMjAeeO/lBLGO17QfEuZgkO/f+UKyOwE6iIhmahELK
 XQ14I3B688qU56H/QCLaCjXZwuVQ9FYj7BfxbGib4q8mkUG5AeO+R0ZJZeRyBT1xpapHyBuYkNp
 jiHAUWhKiT8/8E47ySNDFN7QeQt5rByjB/YivYhgF+PLIx1n8O3u0ZzBYwnNm9h0r+xseuToCE1
 ZjZtJGiKqswhCJO7cxwZhMDYE5yQ8DN+UlNpC2WPQ8epN6MJbmhtAhSMbPYAjdyqOQyeGCkeeHA
 rSKlbpbh
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68ade388 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8JU3Fd4Pt_mHVKaqA_UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

On 8/26/2025 9:00 AM, Ilpo Järvinen wrote:
> On Tue, 26 Aug 2025, Jeff Johnson wrote:
> 
>> On 8/25/2025 10:44 AM, Manivannan Sadhasivam via B4 Relay wrote:
>>> --- a/drivers/net/wireless/ath/ath12k/Kconfig
>>> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
>>> @@ -1,7 +1,7 @@
>>>  # SPDX-License-Identifier: BSD-3-Clause-Clear
>>>  config ATH12K
>>>  	tristate "Qualcomm Technologies Wi-Fi 7 support (ath12k)"
>>> -	depends on MAC80211 && HAS_DMA && PCI
>>> +	depends on MAC80211 && HAS_DMA && PCI && PCIEASPM
>>
>> As you point out in patch 1/8, PCIEASPM is protected by EXPERT.
>>
>> Won't this prevent the driver from being built (or even showing up in
>> menuconfig) if EXPERT is not enabled?
> 
> It doesn't work that way, PCIEASPM defaults to y:
> 
> $ sed -i -e 's|CONFIG_PCIEASPM=y|CONFIG_PCIEASPM=n|g' .config && make oldconfig && grep -e 'CONFIG_EXPERT ' -e 'CONFIG_PCIEASPM=' .config
> #
> # configuration written to .config
> #
> # CONFIG_EXPERT is not set
> CONFIG_PCIEASPM=y
> 
>> Should we consider having a separate CONFIG item that is used to protect just
>> the PCI ASPM interfaces? And then we could split out the ath12k_pci_aspm
>> functions into a separate file that is conditionally built based upon that
>> config item?
>>
>> Or am I too paranoid since everyone enables EXPERT?
> 
> One just cannot control PCIEASPM value if EXPERT is not set. ASPM is 
> expected to be enabled, or "experts" get to keep the pieces.
> 

Thanks for the clarification. I now have no issues with the ath driver patches.

/jeff


