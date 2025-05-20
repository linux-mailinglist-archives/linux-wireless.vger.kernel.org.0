Return-Path: <linux-wireless+bounces-23168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CDAABCE24
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 06:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7793B9A13
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 04:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA9E259CB4;
	Tue, 20 May 2025 04:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lywcwxId"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2686337160
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747714336; cv=none; b=eRoFXkjKKSNeTD9fZVdfVWWdjm4VxRFMI5jXCy80vnlINwyprS6JC7K7MIlxoOx8xNx+lHoul25CMFYBxW8WyILCWtds8AnUp2jmXLQgoKtsH2EH/qxf/R9c3LQWyMvCyI+u2k9af2vYqogxPsJfaQkBJUFj9T4xqqZihs5wR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747714336; c=relaxed/simple;
	bh=AA5z1Iv12EICjBiN6kqrFqLyeWGwCCQ1jyhoLxGEHpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cunYP65/Y4ABEyDelMxAMr/gJZqZzAoFwN+jcRyUYLBeAc6bo8QpGkkchTVtFfFyOj3IHpGK4+4p3Ix1usAik+A8zVVV0m2HJrGNguktaNzu+6nOTXOWQiui8OyZ6E0BKTl9c6KrkCO2Kjrs1pCt+1IiJzxUF8E1yFLQ8F7vTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lywcwxId; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JFR99H023182
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 04:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K3tXKNyZNuZQgUCz+o2yPQ/bI2CEVtZtYjF3TqmtdC4=; b=lywcwxId5OmbcrEh
	/CJqR1sA26WgjKj0WAtXnpSsrQwYfBonv/giChvR+jIHajB/VGcR68mBjrdLQ0NM
	cl2NxTMuRbWyqyqm12gPwb+FY0++nlu4jcsU/NwMZw/pimxeUo92OhrlfRiynK/M
	++t0uan5lGrEB+fyfI6D3Mk1cgBdbo8ata8BQa67CDleiLbiZ7G+QmJSr/cCc3DG
	5yztyiOXyaZTQEMa2vT6fSSvr2EfwOwcUPfZpjtd/Tq6N6vgfbTAi9V5KEjSdF+P
	uhYAOSlAJxKKA0pVNfoWgcMFBkOF50LdHMMeotam+IePGjH1Y5LZRwf+0+z6VXtC
	onRlsQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r041u1wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 04:12:14 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b16b35ea570so5041257a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 21:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747714333; x=1748319133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3tXKNyZNuZQgUCz+o2yPQ/bI2CEVtZtYjF3TqmtdC4=;
        b=hnBwf5uFyS4CQRFmqveL7MgA7QBWzZhp0WY8JmL+Cm7BLu0sibm1DeUYhWZYMv2WJZ
         +jPQNtt1PpJ0x8trn/p494Ag1oJOpLN/73ZVb5qaENkXNOJU1rvjjerktir9yz23hoQ/
         gVWfLFz2CTCCEsR+H2W5wEd9j8o34NN5mIay5Awwj+qffFeXFzHF5QHutGs5eSQZBXd+
         LZ5ehIWjGQ5Rv46PEBKUfP78xQu40o6Fai4ralX5vEzoR2qAfKuHZ4oHvvvtOHxqWzAe
         SlP2cyqbO+z7L17OWYE1PACHHc/j1FoT92QYdEmNIVaIg3syqZTfLGyIZeNCAm5vsuDJ
         axXg==
X-Forwarded-Encrypted: i=1; AJvYcCXrptx0XbUsHMKMyAGomyECBblgBA4HGUplKY4aAFpJcsopjAwJIhlWV8Ks5sROYXjVVBKgW69hBSXDqOfhuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgKYY+JofP350q7bF85qYAH6sJ9jH+nNGfis8FPDv//+oGowQ
	qrwvsSmm1NiFJOL1r+2wNTLwlgOPxRCn/MSxeNTrZiSMHrkyLtZcGEC+TSvdJKxFjV4ZszkOwSf
	uC5hP5Z+Oc+kcawZanhUcTDrxCcjMuUp4he5dcUyvPZXnIo3PKhXzcu2PMZp8eXZMPGGOPw==
X-Gm-Gg: ASbGncu+WY6Tdb3eGY0WxRHpLj+aRFIpuzkVyU6mVz6C5VLaeBhDrbVHLdOUu4zR7L2
	pYIvyGq7xxPVLIocSGnpvwIm+WKihq00JE2gBILPrzphI4qHCWJ/1GuKYA+mUG3dpJjvGCp/uBQ
	/yR7oCn/C7kfpsh+LGthU9CHp1ZRe+wB/r0mY7wbR2vtVLaaMCC7N1CEWF/ar1PjXToKTjz2OwS
	y6vsB5DdMgbSMWd5Qak0AHWepXnZi4flYUltlmduBXRbAGZTFupzeugwWLDYhhSK3xVV9BLQvZj
	Ld3gPYvnmL40JAA4Lxh2EX17xVQ+JugEBVxtqovb1g==
X-Received: by 2002:a05:6300:218b:b0:216:1ea0:a51a with SMTP id adf61e73a8af0-216219fffedmr22921461637.38.1747714333302;
        Mon, 19 May 2025 21:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECTNHl0XI2RQjqcne0zYA1ZVA00vadeEtwniXUnY/EXFpPQMXaSNaBx2qH/VBg0UrtXPfDsQ==
X-Received: by 2002:a05:6300:218b:b0:216:1ea0:a51a with SMTP id adf61e73a8af0-216219fffedmr22921423637.38.1747714332879;
        Mon, 19 May 2025 21:12:12 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb082c66sm7092530a12.60.2025.05.19.21.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 21:12:12 -0700 (PDT)
Message-ID: <b3d818f5-942c-1761-221d-af7d7e8f3624@oss.qualcomm.com>
Date: Tue, 20 May 2025 09:42:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 04/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
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
 <20250519-mhi_bw_up-v3-4-3acd4a17bbb5@oss.qualcomm.com>
 <649c2bb2-d9a3-66ce-8bc5-2735195aaa5e@linux.intel.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <649c2bb2-d9a3-66ce-8bc5-2735195aaa5e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDAzMiBTYWx0ZWRfX0Th8SCu0HNUt
 C09CLtL46puCPIX4a8SSqiji09TOdjlkURoxEMAJLrDROsZmPIN6qads2kGxya3xfKiEMiZkYMU
 C/7QU2++FpFyiGXVm7NYKfXgYSvS9bY4Pu0V8CkH/izulV0LVTUiTIHf8xZObYBFKFdka5Gi7UE
 y/QGre++7LzbPpWKDeMfkd7y8VbtTHYOBoRL8SqtDtCbmrQWf04MSPsrOZ3Yrgw2TCObStlLInj
 +Zn4ADvg+p6WA7RSiQUAf8UmrKPJOiVSU5YB+cGGuUUrVemaFOqcZsT/Pagxs+B5UNTvYU72a8s
 96WUqhuC4NllyPS/pwE41NnLXuhYow1/cT8w4KUXE9EwulwGxJ8KF+726CQbw0EKLb3RvF8tWv2
 mhVm5jfY4ZWILfD7Qo1tQUcqixBil0fCNdJjnl3dtBw7RHKKlPTCdpcNKn6cqmIQP73hR8c9
X-Proofpoint-ORIG-GUID: lselrILnfzSNo5alVWoUoqzkMXW-1S3v
X-Proofpoint-GUID: lselrILnfzSNo5alVWoUoqzkMXW-1S3v
X-Authority-Analysis: v=2.4 cv=HIjDFptv c=1 sm=1 tr=0 ts=682c011e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=cbGetAF2pF-RjulI4vsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505200032



On 5/19/2025 6:51 PM, Ilpo Järvinen wrote:
> On Mon, 19 May 2025, Krishna Chaitanya Chundru wrote:
> 
>> If a driver wants to enable ASPM back after disabling ASPM for some
>> usecase, it is not being enabled properly because of the aspm_disable
>> flag is not getting cleared. This flag is being properly when aspm
>> is controlled by sysfs.
> 
> This sentence has broken grammar/is missing something?
> 
> aspm -> ASPM
> 
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/pcie/aspm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 94324fc0d3e650cd3ca2c0bb8c1895ca7e647b9d..0f858ef86111b43328bc7db01e6493ce67178458 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1453,6 +1453,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>>   		down_read(&pci_bus_sem);
>>   	mutex_lock(&aspm_lock);
>>   	link->aspm_default = pci_calc_aspm_enable_mask(state);
>> +	link->aspm_disable &= ~state;
>>   	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>>   
>>   	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> 
> I disagree with this change.
> 
> The problem currently with ASPM driver is that pci_disable_link_state()
> and pci_enable_link_state() are not symmetric pairs despite their
> misleading names. pci_enable_link_state() should be renamed to
> pci_set_default_link_state() and if the symmetric pair is needed for
> pci_disable_link_state(), it would have to be added separately.
> 
I just want to know what are disadvantages/side effects having this
change here, we can use same API to be symmetric with 
pci_disable_link_state(). The drivers which are using this API has
already option to specific the ASPM states which they want to enable and 
they don't need to call pci_disable_link_state() to specify the states
they want to disable.

- Krishna Chaitanya.
> I've some (rotting) patches which try to do that, in case you want to try
> to solve this inconsistency in the ASPM driver (I can send them to you)?
> 

