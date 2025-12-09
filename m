Return-Path: <linux-wireless+bounces-29615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9B6CAEE7D
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 06:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A134300B6A7
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 05:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A239916CD33;
	Tue,  9 Dec 2025 05:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N5klPZ/1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fOrqR3ks"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B32E65D
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765256535; cv=none; b=jD0YJjayjqSlLhShBxeXStzvp2O2aGWccBCjlpyZ9d6O3iHcvz6q5+Of7eqPycw9yfxL5+jf5ZSosVFlMakhb1ZTB+TqDKQTYJWx0k8Av+76Mmqr708WBERnty2E1BpUN9Sm0ql4sJHe1ZZNRBKb3tYyA5Xw9ZVQU9jJBXi1nB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765256535; c=relaxed/simple;
	bh=i/E8NqFYX+FtRYbeAzrMOV+c808Z1Yr+re4Tbnjd+qA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hylWdS+OJLRh7AvjxAKmB2EOmuM4lAWeQ+2n3Dx2fVTvWndtIZrlG6fGMbrA6/OuxYLWnn7mcNfq5wVNsmRw3gTtsJgTOcheo7CsHw2wK+ffMdI11J9CI0OGg5EGjxg95uMh3AMnntMEqmYfOScwyo6ppjY/rpncWFoyul1Ag/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N5klPZ/1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fOrqR3ks; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8NX5do2429239
	for <linux-wireless@vger.kernel.org>; Tue, 9 Dec 2025 05:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jc4jv2RNuyXGveHXHTVYyuwtb9MnQoiXlS8KJa9ej4A=; b=N5klPZ/1AvOgjugL
	nkdxD1LwFil6nKqnTeMQK/1A8D/sf8Hhswkpynx+heqYl/67/jJyDSl7DKEWIcct
	l2dPBB7fuLjHgQxC5p01wQY+Qv3laQMCtpkH/MhgZUtXIF2Xla+QS1BzleyhrcqA
	JN8MsaGlrjV9vYDa8WOntoDR3Poa7cTJYCuYylyhjs9YpVom4RKp460YIAZ2T7zv
	OehClvfmc5LF1BjsiXF1uscI6vmSVsHeLLfrl1TO581cXreaNCGflsbbutIuP2Ix
	NT9oQSXiTRB59ZVaeY0eyuzDASnYEQng0AJRzAaYYuCNyzeFZH4ZF+jy+0PscQ4U
	tkwVmw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ax2rf1rbd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Dec 2025 05:02:12 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a9fb6fcc78so3740194b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 21:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765256532; x=1765861332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jc4jv2RNuyXGveHXHTVYyuwtb9MnQoiXlS8KJa9ej4A=;
        b=fOrqR3kspiUHj6GfiTJv4IS/OLQkNslWhQ+vWvkfOoS4prtKSlNZmH2RpG0LFSwVEi
         ExUbtoQhNHxx5QEXsOGnclFmbO6lAGbmapuTkoDx3myx8KifWprv5nMhIwSVD7nyDuo9
         LWr0vRwSVwD4R1JAWfJ5GGbrGgnGzrvjy8w+bGaLbjR/p0m0Y33Bw7xxgf/T35DbH5k9
         kocUQnBGo4EayweerjyPv9zgur2kL9AS/y/anwnhJ5lz+jTcCcdUJfrDOtoa0ITueuZw
         l9cMlgpVU1Ujd/TUKx5NB7OAoCoums2zIJV9Lhi2X1bWPAjfx0c50sJauly31zO4qNlT
         8Zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765256532; x=1765861332;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jc4jv2RNuyXGveHXHTVYyuwtb9MnQoiXlS8KJa9ej4A=;
        b=LQLslYFe6SIcZAA5MoIduCHMj0QqOAWgYxsTk8i06C3ir6wjhrbE/7+KpAaExYjIKo
         ads8B9k4ZPy8+xBCp0U0QHOh4xwAXq92w+lutvXya8KMUuURvPwGOJKaA5JIORvW+87R
         sFfg3R00CrBCvwNE9qkLUPxtAEDWZD92VY70l8O2v1D7NmB5tqovPuaH47znmFujFWs2
         Iezc2/gkJkeM6FSGwzQUS/92ScQGE3KrMLqGvFJjSMzQJnm6M/D7Tget09ggw9Qv+KM0
         OGnfDBBZt++ZALVPlXUU57oYx6JtcRHnHTUVbwj1vePCdPF4YEq0CA0DfW9FUXtkdfFI
         LzyQ==
X-Gm-Message-State: AOJu0Yy77KRtvBcmVrE3vCjoilea8SLxD1J2zT3x7trFekiQSAV9H2KK
	RJanUmdeATdk/Tu3RGfxW2CvewO/m80LJ5tORP+b45AtCyxtHBplJESH2vzNkvSDvF3sxbvneXi
	FHPh54CREr8O++KrELQIq4kmJa5M5DmKbF6R5tXZeaLBnVcvy3hB3WuX5Y9CJUwvIyVwXgg==
X-Gm-Gg: ASbGncst38pfpUPxLDIdHy/U9nPkYvcGc1vir8pmFVPXONVjY86N8s01Fnl0uLtGl/T
	kwLogH9/hg5rJcMPVEbWaTtqTY/Goo3+WDlKRbCJD/43/ClI1XYyD5vb505pdyVTWU4pRpLJHPy
	z4Ge8chJ+tCyWOk/IgWKTHb7QYoOvOyM8WOm35fpSs1bqQLjSdgDC6X3hJoQJQ9qHEQNFTGq2BO
	Uiol4VdNXRD/8Xbd/oulNYw4Rv93m6tfeKMTprpTQdu1L+Cdw3F/kh9XmHiCA/ol9UVZtPd0KUF
	bsuCzYLb7L9TqVrISp+VMSWczcGqrgMqmw0vJZERNe3r6Qa2k4LPu+4I1aplXwXKtdEBGUAhLVf
	l7M4GE6xDce/ObS91Jga0Bf4wtyVNcvfX+707W9nlqR5NoLAk885B0dY=
X-Received: by 2002:a05:6a00:3981:b0:7e8:4587:e8ae with SMTP id d2e1a72fcca58-7e8c3912445mr8517332b3a.33.1765256531723;
        Mon, 08 Dec 2025 21:02:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYLdzTPb0B57/9aI4fS+XKXuKcTD/o71EuRLCeGYL7FTGUtSJh8ceVafXGdQFf2b8l3oLSuA==
X-Received: by 2002:a05:6a00:3981:b0:7e8:4587:e8ae with SMTP id d2e1a72fcca58-7e8c3912445mr8517312b3a.33.1765256531194;
        Mon, 08 Dec 2025 21:02:11 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2aef9f649sm14743547b3a.55.2025.12.08.21.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 21:02:10 -0800 (PST)
Message-ID: <4b793236-2008-e57f-3257-48a65dae5d8b@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 10:32:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: ath11k: fix qmi memory allocation logic for CALDB
 region
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, jjohnson@kernel.org,
        ath11k@lists.infradead.org, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20251206175829.2573256-1-mr.nuke.me@gmail.com>
 <01a05a49-ae5f-a3ec-7685-02a5f7cb9652@oss.qualcomm.com>
 <cbf3e828-77c9-8291-1328-7e876a8843d1@oss.qualcomm.com>
In-Reply-To: <cbf3e828-77c9-8291-1328-7e876a8843d1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ee0wvrEH c=1 sm=1 tr=0 ts=6937ad54 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=EWcMrb2KQbkG0C4WZugA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: eDX2y95v4lHeOpxFpWL0bqwMA9VgvEeX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDAzNiBTYWx0ZWRfXw4YFUxoC97ux
 qVlsODquvyBfGT/OQA7bPodehxB9+mbKuVlnZ+NZyEi9MTWDNZ1PfqVUrwAdcHAz7XzL5U7uX8l
 e08hbiD/WlspRvKDGNdj3QnButhqzl0q0A+RRozJqSKdTc798+c9zIfcJS8HCIM6a75pOAnloMA
 nxkOcJhJRgxp8K5mEBnW26DZeo0Kn5dzQgcBWCJgq1e2kSd/hdNI7FDC1yfNV2V5Ytjo9gearLk
 oo7NLRJzBw41Y2COo8PO8r6as4vkXqjF+Rb25U99713sg+CXpF8FVOX0EOuyTABg1nlQdCWVKKm
 2U1BSC5uRZ0lyJvA4NdF2eTGPt7N1xihMX1tzpuJQdkdvLreF7Hv4m0kEL9iKsmPFrDm6i8Kdoz
 prMNluvHI8zybE2J3JzKDLtntct3Lg==
X-Proofpoint-ORIG-GUID: eDX2y95v4lHeOpxFpWL0bqwMA9VgvEeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-08_07,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090036



On 12/8/2025 3:55 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 12/8/2025 3:38 PM, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 12/6/2025 11:28 PM, Alexandru Gagniuc wrote:
>>> Memory region assignment in ath11k_qmi_assign_target_mem_chunk()
>>> assumes that:
>>>    1. firmware will make a HOST_DDR_REGION_TYPE request, and
>>>    2. this request is processed before CALDB_MEM_REGION_TYPE
>>>
>>> In this case CALDB_MEM_REGION_TYPE, can safely be assigned immediately
>>> after the host region.
>>>
>>> However, if the HOST_DDR_REGION_TYPE request is not made, or the
>>
>> AFAICT, this is highly unlikely as HOST_DDR_REGION_TYPE will always be before
>> CALDB_MEM_REGION_TYPE. >
>>> reserved-memory node is not present, then res.start and res.end are 0,
>>> and host_ddr_sz remains uninitialized. The physical address should
>>> fall back to ATH11K_QMI_CALDB_ADDRESS. That doesn't happen:
>>>
>>> resource_size(&res) returns 1 for an empty resource, and thus the if
>>> clause never takes the fallback path. ab->qmi.target_mem[idx].paddr
>>> is assigned the uninitialized value of host_ddr_sz + 0 (res.start).
>>>
>>> Use "if (res.end > res.start)" for the predicate, which correctly
>>> falls back to ATH11K_QMI_CALDB_ADDRESS.
>>>
>>> Fixes: 900730dc4705 ("wifi: ath: Use of_reserved_mem_region_to_resource() for 
>>> "memory-region"")
>>>
>>> Cc: stable@vger.kernel.org # v6.18
>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>> ---
>>>   drivers/net/wireless/ath/ath11k/qmi.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
>>> index aea56c38bf8f3..6cc26d1c1e2a4 100644
>>> --- a/drivers/net/wireless/ath/ath11k/qmi.c
>>> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
>>> @@ -2054,7 +2054,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base 
>>> *ab)
>>>                   return ret;
>>>               }
>>> -            if (res.end - res.start + 1 < ab->qmi.target_mem[i].size) {
>>> +            if (resource_size(&res) < ab->qmi.target_mem[i].size) {
>>>                   ath11k_dbg(ab, ATH11K_DBG_QMI,
>>>                          "fail to assign memory of sz\n");
>>>                   return -EINVAL;
>>> @@ -2086,7 +2086,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base 
>>> *ab)
>>>               }
>>>               if (ath11k_core_coldboot_cal_support(ab)) {
>>> -                if (resource_size(&res)) {
>>> +                if (res.end > res.start) {
>>>                       ab->qmi.target_mem[idx].paddr =
>>>                               res.start + host_ddr_sz;
>>>                       ab->qmi.target_mem[idx].iaddr =
>>
>> The rest looks good.
>>
>> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
>>
> 
> Well, since CALDB_MEM_REGION_TYPE will always come only after HOST_DDR_REGION_TYPE we'll 
> not be running into this issue in real deployment with ath11k firmware binaries available 
> in public.
> 

Nevertheless, I agree this is a critical issue to be fixed. There is another patch[1]
fixing the same issue a bit differently.


Vasanth

[1]: https://lore.kernel.org/linux-wireless/20251208200437.14199-1-ansuelsmth@gmail.com/


