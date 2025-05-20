Return-Path: <linux-wireless+bounces-23166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C758ABCE13
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 06:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235D03AE5E1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 04:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D99253F27;
	Tue, 20 May 2025 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ok2dYX/2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7342258CE5
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713969; cv=none; b=Uc1RmYy3Rt8fKqV1Kx1uqp469OE00BQKKmwXRehF9Ip514koHbSmDXVg5iIOfSikcvAEiT56hnIt+0xdmHgYULooPCVvEJvwDHXZPQd1++QpJi70Ijntf4R7JVcCdp3TGqSGYWfITOBFl0dBYtbTRt96N+w1jtsaYzEhbjH+s6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713969; c=relaxed/simple;
	bh=OjHg+Vyus8o0ZLxaz0u47ocwameFVHjmY7vBPG4yAT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZewBynLf+pOjbXSz4B9FYZv1ZPs7KVM8KHRn7uyf6hBHuagAzXDva7kgKctP53xz82wOcbJsRpuGD7kgRdxbhTgcytnZZWiWrSzWn4bG3i9f8jmeW7IzRbb8q50uxjhcD5tAr6k1qyIn2H3l0ECp0gCUgnRdi3qpizJG9j8+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ok2dYX/2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JFculq023185
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 04:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mRkL6ZD37aILbTjnj5L1nOvB0DmK7nmgx/7Bty5lsHA=; b=ok2dYX/2JfvIPoT5
	1EdJ6q1GigS8gpD+pcbPatWPkZVETqe0DYpUc8C50rI0AHNF6NWQuYu6OrO9zTF5
	sc7MlmfF9JG7cGOGVvPfyNhs07LnS3ykzrWV1YpJcyUdrpvOHdcEpWGkJQZYp8no
	5wFcgJJhoKju92/h2mCRC7a0zwME8nqH46J4mKl7Wha4CRpscBqrZNgGm+Z7vuwp
	6dDmpSaDx8aHL7ypmvUw1jY6rWMGHa6a6EqVy4bnYffiExWD3RWgVa0x0zqFYB+C
	WLUIPi54xiZlGU29YULaKW10p095pn4FoqRQpTL1otMeVPAECP3Iwls+a8MlwSQP
	5rlSmw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r041u1ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 04:06:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b1fdf8f67e6so3337165a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 21:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747713965; x=1748318765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRkL6ZD37aILbTjnj5L1nOvB0DmK7nmgx/7Bty5lsHA=;
        b=rxnTzLNTPFHYZSUGXAW3dovN3uyvJ6NOibDwLcE3CLR6ia7QkWFRgGu7vxACe1FqEe
         sZSke07IEf4XHDMKXD/A1wl9yeSnWjS6uKx7VOuVzFiTEs04nMd6TBTYXMYPfYuZ/Mo2
         3Y++FhZyYd1tKhEqtujimVxNyWKmf3RDBqNdIzCRIes3WPzk2sVH/sBaXbIfTf6so9NT
         wJU6vkx9S7F2gFPUkqyXU8GqnR6Bvkx2LT26Ru+hjFbD0eZ9OZnbQGpUDwfPMTmURpev
         NVobmadtLdO0h8XtytKQ38PmYEta459E2SWRB08QBrM6i/sLCAnh9HXvrC0M2upviDAL
         RWpA==
X-Forwarded-Encrypted: i=1; AJvYcCWNYCLRIy1o9C/WP1+TYm++8mjPE1+PZSuPYsrNn3ZANoXhSmAgGHanR6m8PaGEya8YX3cUsgceDKT9cwCq5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4BqOGPuCYj557vjATzxG6Y2vc4XfrWAEg0eIK32BRIuVdJ1y
	MB5xSa3ZSUAqXy6ZkuuJYwRizua+URCJeOaT/Rdc69cbi1uoXb+NSIQUbRcnFzAKVq3QONl9shO
	3JkXKVf1ehHbWp8pT56qGQt2wNlwRES9rUNUcjpu36Cb3ZAZpNMqphNavBR6o9hDDl9G5UA==
X-Gm-Gg: ASbGncuO3I8MosaI+5xqFUwB3FqtHNi8y4JmtYBoq1ARtAwpElW8XuzII2j4ZFogUY5
	5x9aekPr09siyPmBkixFY8JF3sCuCyXYz29Eo+RcAlBM26bUT3YOc7ObOI140PYNhry4DXcxKnz
	egZDTkOlu65pP/8wvegGnM9ykWlyA83+oSLB4dy7xGQZxTOIPrJ9Fe6kaI5bp72CFL2zmCdPejE
	s6NFnU3tyDmzLUGMxUpUVAxheQuAafbt11mf619n9peOeidaiOrkcXAW9heCm+X0SiTTZLjEn7s
	WHes0MCP8gbamo8VBdDuVuzh/L89FXzB2YuV7FmCNA==
X-Received: by 2002:a17:903:1987:b0:223:5e76:637a with SMTP id d9443c01a7336-231d451906dmr235890325ad.23.1747713965015;
        Mon, 19 May 2025 21:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCF1HMD5IOIAcLUdbyDa32PLQI1LeHPs7Pwruc6NNnS2Fm+f5VrtQdL4uL+gDaDwT1GlS9+w==
X-Received: by 2002:a17:903:1987:b0:223:5e76:637a with SMTP id d9443c01a7336-231d451906dmr235890025ad.23.1747713964612;
        Mon, 19 May 2025 21:06:04 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e98009sm67639245ad.152.2025.05.19.21.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 21:06:04 -0700 (PDT)
Message-ID: <25723231-c396-2d20-aea1-5e506b44a778@oss.qualcomm.com>
Date: Tue, 20 May 2025 09:35:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 01/11] PCI: Update current bus speed as part of
 pci_pwrctrl_notify()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
 <20250519-mhi_bw_up-v3-1-3acd4a17bbb5@oss.qualcomm.com>
 <10de35f5-bec6-5df3-768d-04f88c4e3d77@linux.intel.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <10de35f5-bec6-5df3-768d-04f88c4e3d77@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDAzMSBTYWx0ZWRfXxiWa6kJhEIUi
 KVojU4d14wnMepv7MFJPbe1IoG2bYu/fEfeDbChYKadF/2rYhy5HTZfG0gSkrr88eZ1hIb0TAOb
 dQYkzfAe4OgWgc3d0mXCv48lZCLX+/McqeV/jum3+xQxccYtdDLXR7BWzyohPVpD6iI3qFCgsgJ
 PPFcOlyf+KBMNELrsoCrXufmX7Pw4OKhEnjISdaT9zyJoc5jjJBSfT3oQ9YwVG3fn3oP1FvzBjI
 YffrJitrJZ1JnR+ACzJDPvkagPqvgIbxaYw4gNvQwDhJ9V8Vyub/FvDQ9WDQpNdyZfjAOhuUNue
 uOYwdW3e7tmX1ro21k6nsMK+yfcjvtS7ZdyUI6soE1+qqD0yPlR3DxqudrPm/FNDVhpijNtBkZX
 cwEM8AiDk9wNQjtMzMNWyZdhjGQnZjQjnYAg8QbeYEQamIOcUT6ZwieroOGyUfyAynZFR+pS
X-Proofpoint-ORIG-GUID: IX1hVA1p0u87ZfHSbt2f5SJmIHZmCeK3
X-Proofpoint-GUID: IX1hVA1p0u87ZfHSbt2f5SJmIHZmCeK3
X-Authority-Analysis: v=2.4 cv=HIjDFptv c=1 sm=1 tr=0 ts=682bffad cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=tf4daXCc1kDTc5M98m0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505200031



On 5/19/2025 6:39 PM, Ilpo Järvinen wrote:
> On Mon, 19 May 2025, Krishna Chaitanya Chundru wrote:
> 
>> If the link is not up till the pwrctl drivers enable power to endpoints
>> then cur_bus_speed will not be updated with correct speed.
>>
>> As part of rescan, pci_pwrctrl_notify() will be called when new devices
>> are added and as part of it update the link bus speed.
>>
>> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/pwrctrl/core.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
>> index 9cc7e2b7f2b5608ee67c838b6500b2ae4a07ad52..034f0a5d7868fe956e3fc6a9b7ed485bb69caa04 100644
>> --- a/drivers/pci/pwrctrl/core.c
>> +++ b/drivers/pci/pwrctrl/core.c
>> @@ -10,16 +10,21 @@
>>   #include <linux/pci-pwrctrl.h>
>>   #include <linux/property.h>
>>   #include <linux/slab.h>
>> +#include "../pci.h"
>>   
>>   static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
>>   			      void *data)
>>   {
>>   	struct pci_pwrctrl *pwrctrl = container_of(nb, struct pci_pwrctrl, nb);
>>   	struct device *dev = data;
>> +	struct pci_bus *bus = to_pci_dev(dev)->bus;
>>   
>>   	if (dev_fwnode(dev) != dev_fwnode(pwrctrl->dev))
>>   		return NOTIFY_DONE;
>>   
>> +	if (bus->self)
>> +		pcie_update_link_speed((struct pci_bus *)bus);
> 
> Why are you casting here?? (Perhaps it's a leftover).
> 
yeah it is a leftover I will remove it in next patch.

- Krishna Chaitanya.
>> +
>>   	switch (action) {
>>   	case BUS_NOTIFY_ADD_DEVICE:
>>   		/*
>>
>>
> 

