Return-Path: <linux-wireless+bounces-21510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B26A88559
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 16:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6729B16A53B
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9985728BABB;
	Mon, 14 Apr 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hHPr0i7o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12925228A
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640101; cv=none; b=Vcf6bgt1ULXhJ/95jaYoQ3+7QVCz2Mucp+FQ1werADllTSDEaSDwj6S4JT3nlr9BHwD0ftJ+fy41kaYCRJX+O73VkYUo35ogXOUyG9DAEsVK8JhQEGxodBwIJfM+IvlFJY3xOjESr+SXNwULvNzIlYHiL1vbwDXnD3kiRIO5WUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640101; c=relaxed/simple;
	bh=ByeCTNaZr4Ph/HGr+OwVdxCPEuDR7nboM0glWluYFW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NX0EttTp/sGaeqtu3Kf7iy6ohaPBKbaOeJuNfUplj1GuIlYXlFapoI5wGjOjxO/THxrpFRKugBrtxAEQX5awWD4tQmNxFWoXMEZoST3jtlhDSI7WMJyY9Yxayi8ePSIMy3CHEh3930ZD9QfitRnouquoOZfm/Js1dw3r8Z6yhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hHPr0i7o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99qls002926
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 14:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wxG3IdlEU0/EeaB+zxx6yERTFdkVhtJDwmR5p/NkIrU=; b=hHPr0i7osx8vFaom
	VYV+Mtndw1qOIbkeg8tmmJa2RB+jki0pRpOT1cTI7EI+aQ5yw/S9bjphuAvvPMC/
	8+B+8lw9zUWhTzEG0d3w2XWn6YBuSMgN1ryUc5xM6T3/MGLLWA8rW4Hq0VbErtDP
	d/53phYC2zoWTDWhSHFj/VDYdb4cyIF2Y3FP9gdinwl5uWQTtvotm56cE8vf+p0e
	fiRsTp2egrw6cWVMeFRnfyE7xhahZscAj5mwHL8I1Zil46Lpe6WxC7wvRY/dox7j
	qE2VlXfWy9oHphiKtL2syJgo55z2RpfpKomtdH5AqpLNy29LQzfpzjHRWnhbbk+7
	Q3qABw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbpmmpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 14:14:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2241e7e3addso38219615ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 07:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744640098; x=1745244898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxG3IdlEU0/EeaB+zxx6yERTFdkVhtJDwmR5p/NkIrU=;
        b=K5Rl9Bk99IVP8LqXSsrocPVCumB8+Nw1/Vbd2qyazoB74BkVmLQcEj0XptrAg7CLzm
         F4xT785iJAMWSTumVXT022+0qgMcf2YH7GFbJ91AkvWkbcbcL5xqFMPWTnPboR0Jsxxg
         IgRoSN8di227K3Z0WAVyFqv1EBu/ANJQfkZYsYC1Od3QHN/YA69c++4Vk3T1H0TzkKd3
         yZ9wgz4S6/Hst2hK+enKe+Ed6fo9KcyyRFWgqz+UjXNC0YajReWOEUSmCCHsPK+U7AxO
         BYhPhXKi4RUPDP4x0nYddgfgfoKVDEMPQdJ9xmWlWjCVuXrEDHsYhQATn3vUhPU3ffDx
         V8Lw==
X-Forwarded-Encrypted: i=1; AJvYcCW2mcM5KIGyLhGHHHwSQ/u6uoxmbFaGc37iIEP7oOiv8ab78A7rI9E9tmfV8Y+E+/TVirv3Q8G7QNtPyTkH2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrcZKavcX5YC8In2sfnu9yWRiFXHn1e9xe1oGYZ+45dJOZrFIZ
	J+9ZldcsrgWavuNakGvUSxORK9WvJMhiJ5R6EbX+vB7RmaaFTMRSJtFVQ19CA8eoV98o7+TYwrX
	I7XBKvCShLTGjcoq8WevJBy1sdxi6vqGXa8oq7wva1F0HMXaxqnzuRnQnAyJcR58jnQ==
X-Gm-Gg: ASbGnctQfu4f+vVto7xsR4UKDqsgUa+wqrAHwIaf4mrN3N0DuOi7GhfDF17xZ3x+FQ7
	7iUqx8lpBR+QyDxLc3b5UcgdJ9leYFbDg0+pj9JO9POO7xkTxLSM939pUayD+IdDxynreYq5XgH
	f0CKfgDEpaR7+hggHcFnGMWRjct2y1BJBv6xJG8foDQfDaFsfq/jzkaHkIjoFK7r1xV1UrlxyzV
	APCsuafbdHlhmzrcQ4CDk5QeUCx958FbSrg8jtLEs2Nrp1RFN2ardhbVab2CthS+eVxQMreHLH6
	xv+k290nMFGrMvFrWwDWla6qKEgPF/FLBCA9yzzCJrVnRzvhz2rakFqRPCB1YA==
X-Received: by 2002:a17:903:1b03:b0:223:501c:7576 with SMTP id d9443c01a7336-22bea4aac90mr209768665ad.12.1744640097840;
        Mon, 14 Apr 2025 07:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUc9+/UIqegjATJ9UbGeCCAJ0DtjU4YNhpXakGi/P6OIAyr24MclI3pdwUoau+1IS1bxBK3g==
X-Received: by 2002:a17:903:1b03:b0:223:501c:7576 with SMTP id d9443c01a7336-22bea4aac90mr209767795ad.12.1744640097219;
        Mon, 14 Apr 2025 07:14:57 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb681asm99532345ad.204.2025.04.14.07.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 07:14:56 -0700 (PDT)
Message-ID: <ad5e99e8-3ff1-4727-aed6-528ac747f409@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 08:14:54 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Qiang Yu <quic_qianyu@quicinc.com>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kunwu Chan <chentao@kylinos.cn>
Cc: kernel@collabora.com, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20250410145704.207969-1-usama.anjum@collabora.com>
 <ba09ae0c-fe8d-8f4e-a1b8-9c7e5913c84e@quicinc.com>
 <fc9ca0da-9f6a-42b5-aa79-abcd43c97043@collabora.com>
 <e0159cb8-fe21-7f71-1ebe-744ed26bd698@quicinc.com>
 <85580a01-289a-461b-b0f1-38fa1b96717c@collabora.com>
 <1c0b2217-49d9-360c-ed60-db517eaf2ccc@quicinc.com>
 <7d6b074c-8499-4984-b235-d1285b006ab3@collabora.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <7d6b074c-8499-4984-b235-d1285b006ab3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EbqWz3g3UjNhh6fI3yLVY52ihqZXWRt_
X-Proofpoint-GUID: EbqWz3g3UjNhh6fI3yLVY52ihqZXWRt_
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=67fd1862 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=e8kDqSdrP573SdWI4XoA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140103

On 4/14/2025 1:32 AM, Muhammad Usama Anjum wrote:
> On 4/12/25 6:22 AM, Krishna Chaitanya Chundru wrote:
>>
>> On 4/12/2025 12:02 AM, Muhammad Usama Anjum wrote:
>>> On 4/11/25 1:39 PM, Krishna Chaitanya Chundru wrote:
>>>>
>>>>
>>>> On 4/11/2025 12:32 PM, Muhammad Usama Anjum wrote:
>>>>> On 4/11/25 8:37 AM, Krishna Chaitanya Chundru wrote:
>>>>>>
>>>>>>
>>>>>> On 4/10/2025 8:26 PM, Muhammad Usama Anjum wrote:
>>>>>>> Fix dma_direct_alloc() failure at resume time during bhie_table
>>>>>>> allocation. There is a crash report where at resume time, the memory
>>>>>>> from the dma doesn't get allocated and MHI fails to re-initialize.
>>>>>>> There may be fragmentation of some kind which fails the allocation
>>>>>>> call.
>>>>>>>
>>>>>>> To fix it, don't free the memory at power down during suspend /
>>>>>>> hibernation. Instead, use the same allocated memory again after every
>>>>>>> resume / hibernation. This patch has been tested with resume and
>>>>>>> hibernation both.
>>>>>>>
>>>>>>> The rddm is of constant size for a given hardware. While the
>>>>>>> fbc_image
>>>>>>> size depends on the firmware. If the firmware changes, we'll free and
>>>>>> If firmware image will change between suspend and resume ?
>>>>> Yes, correct.
>>>>>
>>>> why the firmware image size will change between suspend & resume?
>>>> who will update the firmware image after bootup?
>>>> It is not expected behaviour.
>>> I was trying to research if the firmware can change or not. I've not
>>> found any documentation on it.
>>>
>>> If the firmare is updated in filesystem before suspend/hibernate, would
>>> the new firwmare be loaded the next time kernel resumes as the older
>>> firmware is no where to be found?
>>>
>>> What do you think about this?
>>>
>> I don't think firmware can be updated before suspend/hibernate. I don't
>> see any reason why it can be updated. If you think it can be updated
>> please quote relevant doc.
> I've not found any documentation on it. Let's wait for others to review
> and it it cannot be updated, I'll remove this part.
> 

Wouldn't this be trivial to test?  Boot the device, go modify the 
firmware on the filesystem, then go through a suspend cycle.

-Jeff

