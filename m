Return-Path: <linux-wireless+bounces-23229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A714BABF8ED
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 17:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85A78C7EF0
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 15:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6819F41C;
	Wed, 21 May 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WxBUaiwU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A431DE891
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840028; cv=none; b=JYM/s48ZzLDybGLIiZLJ5OI+LFhLZqjIgtfKyYCHhy9ger+XTpyn3OxTy+eLB2o0bOA6BHd/HpCjGJKEZ7hdR4su7E6o1V0UoNTRnNE+Avj0WQ+z2WrE0XdCBQfTYZ1Jm4PrClr/lh0uxChKV4mOlfz9exoFGNHRI/Ja6VlNn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840028; c=relaxed/simple;
	bh=WWjOuamSMaHm/GzcJFFxoHMbGV3TrZed8/0kkOrQRsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkMjUZWMX38iMcmGRe9/spaabxafFu4BhGKOP6XvTIIvzqYEeYOcbqx1Ty9uOAU1ha59WaoRRup8ClGYXCIa4zpTy6GqkgPnyuBzNaIBM5trW6J/Wf+5m9IF6q5OzJsobQMaBr4ZjX/rHietOciLSLMaVoMsKNoHPgZN9AtNuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WxBUaiwU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XtiU002269
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 15:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gclGxcmh2deSgmjENsWitrKLn40jp6PQMWWDoTEhlBY=; b=WxBUaiwUqXnZxZd2
	Pd611+dgTkvm5OUDNfiUVG7/R5T12uUOXQhCFFASiyzo2czfAQwckFrZxksxkytm
	8Y/VbIb6xXjtvQFV/U27FUJkCwivja9aLTzfTyrTf9Rl2xXCdAlR8KLhMkHtIbsl
	+FLSejtqOiAt/LtC/t98RpQvmw1KGT6Ti5r9cdbhS2RK7S28O0L4PuY8ls7z1z8h
	6Mp033oUPMRVvzLhuy9mrBceZBh1uPHVGzhfqpjWjyFO8DXQ4mHKsvKOhj4g9N1x
	kLtU1+JRrnYrRaJOFEXzoyijusYv7Lv+ql6yUfT4O7ebZTeHc3hD65QHqMegXTFD
	xDEr1w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf6ubne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 15:07:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-30ebfc28a1eso5842305a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 08:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747840024; x=1748444824;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gclGxcmh2deSgmjENsWitrKLn40jp6PQMWWDoTEhlBY=;
        b=Slkka0yNlZtTylff1Gb3CN0OEh9dQPYvFaFpx7km7EWLZ4wBpV1SMmY1s598p5isE2
         XQAUctYJjkvRlqP+kXoV9uuUPhh+F//aNb0spt35aTS4MmsRdaqtuHUVVmmxZY7SMkM0
         a7KgmD9kYO66DXnMmEVjU9NdWZakZkA71cm24xoKFu0QuVcj72E00kRBcELD/hm/rzeo
         pdGOVlRhi62fcd/Hv1Hkx8cilOeroSJizlJzEDqgKGfLbUZObOzlYYjdCyRE/yvqna8A
         xklQcyBR6YszuV9LZl9jHCwSMI+4z+NRhiVZgjXSzfnT8o6dHxjf6eThxxs2pa2BVgDv
         lzCw==
X-Forwarded-Encrypted: i=1; AJvYcCWv8hAC0VVFTt3oVCRGj27uLeFjz7D8FeiGqkljNqCh8/MSuBEzsTioVkpD6FFQPsYtKHCouzH0nadfWAfOWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBNnTsRGCt931YQJ4HjuZSB1yRHA9oBeLljcARtDv7bJXiJXL7
	CTgk9AgEtBcTFRJ1tve9lBBNzYZoo9jo+815VQCIFjMUb5+p3nK1ifg0rDuGmjIyUZ7p+wZM5Pr
	AqT9/ozXfIyYQK2OiHC/O6chtd18SKVfXXEzrUAftBnCjVcAEGodMYCwxfOBkEjbWsJWOng==
X-Gm-Gg: ASbGncsoqOpD+AkQaebG4a8fWZi6nlo800mn48Z3/iugTOlfsTLk7XiMegU7tSvv9yX
	cYg11qsBPRb/XOb6rLAKnjqRMRPK5WBEK3XdT5u1vDXQ5TYEOPKEco1ZafBjvyfyeEadwCD89/k
	PnhUJ/xInNSnTPGpv4qC0FiwXstMhK79bGIY3jXaeVuhbr9rWQY32zKABg+5P1iEE0ruefi27wx
	cgHLC03QyeyKtE2JAdub3L/ndl9BhSFGmV4pBjthIWmTY8w22fy34pfgUG6OI7i4zjmYjzQPUfm
	vBTMXXKuX78AhArybEx6SOExzN5tx7lXKXuLovRjbF4=
X-Received: by 2002:a17:90b:1dd1:b0:2ff:6167:e92d with SMTP id 98e67ed59e1d1-30e8323ee6emr27639006a91.32.1747840023813;
        Wed, 21 May 2025 08:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkFeyasrtr+2FBvL7+PLcu+wKkij8Ce3tKmpJG2Tgqbvq/sTmcpPLrmVJ4iiOnvVwgI3U6lA==
X-Received: by 2002:a17:90b:1dd1:b0:2ff:6167:e92d with SMTP id 98e67ed59e1d1-30e8323ee6emr27638930a91.32.1747840023284;
        Wed, 21 May 2025 08:07:03 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.230.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36368bdcsm3791783a91.5.2025.05.21.08.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 08:07:02 -0700 (PDT)
Message-ID: <8bb9acff-b2cf-edb0-bd55-251cf4a93f5b@oss.qualcomm.com>
Date: Wed, 21 May 2025 20:36:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 07/11] bus: mhi: host: Add support to read MHI
 capabilities
Content-Language: en-US
To: Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
 <20250519-mhi_bw_up-v3-7-3acd4a17bbb5@oss.qualcomm.com>
 <aa45ff83-bc8f-4cef-a82c-9a868396d19d@quicinc.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <aa45ff83-bc8f-4cef-a82c-9a868396d19d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SqHtrRxzoHp27VmHVGAdxonDNt5Dbp1F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE0NyBTYWx0ZWRfX2yUqWU22CkL8
 etgaVosbLRsWnXN4XmE6HBP0023zjzwetVAewnzZbL3nxF89yScLHheV3TKaMClhM6qd5dg0g6q
 hdGu3h6W1DGgd9C7rlT+8VOee/QmjLq6hdB6nqw8takcL/gcRpWUWhe/BdOKx3f03BRajL01O8v
 2lpzZiH3ib/8Y1FtvdYrZTWR+7J/ZcCNO8LjFx/vW6/xQ22f+LcYJkail81a1pPhowcTIpSng/f
 aG2mqnGlhW3tUU/VEtzLYOyr3p4zqkjbnBc3tjBlT0OpDBRYA7aXnZJopzJgSIdr63NXlMB56wp
 xt2ulVH7CvkNpClbun9LH5qHmyC2mQNk5OdTcoLvxMm0N8HWlCFqLngb2bOttTlCy7f/xEL33Bw
 t0DMkTR3gRhGqIzVOMcnStBsYQD0eYYk5RLHMPKki56DwIPQI0mbVs1dAXEYT/rrm9+SR+Lq
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=682dec19 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=m9Fid+qPLYWXQ4ltJ96dlQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=mVMa0e8YI0uuylkBircA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SqHtrRxzoHp27VmHVGAdxonDNt5Dbp1F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210147



On 5/21/2025 8:22 PM, Jeffrey Hugo wrote:
> On 5/19/2025 3:42 AM, Krishna Chaitanya Chundru wrote:
>> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
>>
>> As per MHI spec v1.2,sec 6.6, MHI has capability registers which are
>> located after the ERDB array. The location of this group of registers is
>> indicated by the MISCOFF register. Each capability has a capability ID to
>> determine which functionality is supported and each capability will point
>> to the next capability supported.
>>
>> Add a basic function to read those capabilities offsets.
>>
>> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
>> Signed-off-by: Krishna Chaitanya Chundru 
>> <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/common.h    |  4 ++++
>>   drivers/bus/mhi/host/init.c | 29 +++++++++++++++++++++++++++++
>>   2 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
>> index 
>> dda340aaed95a5573a2ec776ca712e11a1ed0b52..eedac801b80021e44f7c65d33cd50760e06c02f2 100644
>> --- a/drivers/bus/mhi/common.h
>> +++ b/drivers/bus/mhi/common.h
>> @@ -16,6 +16,7 @@
>>   #define MHICFG                0x10
>>   #define CHDBOFF                0x18
>>   #define ERDBOFF                0x20
>> +#define MISCOFF                0x24
>>   #define BHIOFF                0x28
>>   #define BHIEOFF                0x2c
>>   #define DEBUGOFF            0x30
>> @@ -113,6 +114,9 @@
>>   #define MHISTATUS_MHISTATE_MASK        GENMASK(15, 8)
>>   #define MHISTATUS_SYSERR_MASK        BIT(2)
>>   #define MHISTATUS_READY_MASK        BIT(0)
>> +#define MISC_CAP_MASK            GENMASK(31, 0)
>> +#define CAP_CAPID_MASK            GENMASK(31, 24)
>> +#define CAP_NEXT_CAP_MASK        GENMASK(23, 12)
>>   /* Command Ring Element macros */
>>   /* No operation command */
>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>> index 
>> 13e7a55f54ff45b83b3f18b97e2cdd83d4836fe3..a7137a040bdce1c58c98fe9c2340aae4cc4387d1 100644
>> --- a/drivers/bus/mhi/host/init.c
>> +++ b/drivers/bus/mhi/host/init.c
>> @@ -467,6 +467,35 @@ int mhi_init_dev_ctxt(struct mhi_controller 
>> *mhi_cntrl)
>>       return ret;
>>   }
>> +static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 
>> capability, u32 *offset)
>> +{
>> +    u32 val, cur_cap, next_offset;
>> +    int ret;
>> +
>> +    /* Get the 1st supported capability offset */
> 
> "first"?  Does not seem like you are short on space here.
> 
Misc register will have the offest of the 1st capability register
from there capabilities will have linked list format.
>> +    ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF,
>> +                 MISC_CAP_MASK, offset);
> 
> This fits on one line.
> 
>> +    if (ret)
>> +        return ret;
> 
> Blank line here would be nice.
> 
>> +    do {
>> +        if (*offset >= mhi_cntrl->reg_len)
>> +            return -ENXIO;
>> +
>> +        ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
>> +        if (ret)
>> +            return ret;
> 
> 
> There is no sanity checking we can do on val?  We've had plenty of 
> issues blindly trusting the device.  I would like to avoid having more.
> 
we can check if val is not all F's as sanity other than that we can't
check any other things as we don't know if the value is valid or not.
Let me know if you have any taught on this.
> Also looks like if we find the capability we are looking for, we return 
> the offset without validating it.
> 
For offset I can have a check to make sure the offset is not crossing
mhi reg len like above.

- Krishna Chaitanya.
>> +
>> +        cur_cap = FIELD_GET(CAP_CAPID_MASK, val);
>> +        next_offset = FIELD_GET(CAP_NEXT_CAP_MASK, val);
>> +        if (cur_cap == capability)
>> +            return 0;
>> +
>> +        *offset = next_offset;
>> +    } while (next_offset);
>> +
>> +    return -ENXIO;
>> +}
>> +
>>   int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>   {
>>       u32 val;
>>
> 

