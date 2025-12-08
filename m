Return-Path: <linux-wireless+bounces-29586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF48CACCC3
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 11:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 180C8301AD09
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7922D739D;
	Mon,  8 Dec 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KYZMjRSF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jxxnzD79"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927FC283C83
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765188521; cv=none; b=p5Boxq/KFFeV2AmSnA+6wvXmMz9Q57WjsFVjC7nVZ73mXtdsagCSx0vvSgJRtDFNoH8OM8cBJKOqBE1DwI360/YElrXHCMWxdlDMSgRqj4k9y/T226XXmDMFQjqE8+kUFMtuwyifr66YFMaan8Cxc3jIzy6ZSfTEEINarlfxaxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765188521; c=relaxed/simple;
	bh=6lxXIkzbDAGAIeMBp3NAuBv0FGQ0Onp6b6eakQm4BAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcikWTA8yLwiJE8ZkE0dfRM4sW/bZdbQbxgVNMTb+HleUKGcRMVMy7rPsnsRwvFPcGdFYigUkl3lAioFc2mi3LQ76454DWIo7NfbuqGXChn978oVMuDFJFhLEPK0thbkUB3cv60usrOqiW7T9mzCzaxTcX2aSn4Ou/ABHSRyRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KYZMjRSF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jxxnzD79; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B89F1Qt3862924
	for <linux-wireless@vger.kernel.org>; Mon, 8 Dec 2025 10:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f9jHdYoc3oT9NHwSrNbma2xbBTUVUF9I4q9RnVy+smo=; b=KYZMjRSFuXDkYsGF
	mupgbAPftYjwMnWo60n7ArrV8tGqyTGjzxlOqd3ofwFu9DN1MFJGZm41PMhZ6ddM
	bP4n0hU1sxBlu87sjSkDFKOYpyk4J4iNlb6PLSkukPERoNuK0UKIsA/AkziTZq6E
	VwtQZOXckqVY93LexDtTtADnGEj8hpNMvZ4A/RDkBtFN8fUIASdmmuPOA2cQGSFe
	9G8Z/yqh8r3X6ZQfyE44IR3G0xjX1YYSpg8Ac8lIJ387UIHDBzaDE9ZFrv5DqSm3
	EYb2lnEYLchxQtC43l5X2X6ujdsVnWmxR/mA76kutaXQ6r1jnhc3VbIgjVgS51+W
	eZnMuQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awuvg05ny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 10:08:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2956cdcdc17so46113255ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 02:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765188517; x=1765793317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9jHdYoc3oT9NHwSrNbma2xbBTUVUF9I4q9RnVy+smo=;
        b=jxxnzD79ivgVb+/0iL4mrzYAWLMZsBkyOWff4S+WO0lAM//SIgfAaAhyiVhWHClBpR
         /taUNFPaJV23AAu6Wv4l3MXPdY8vx9jTyewnItS2b1XsuVRJYI7FKyVi2qy2z45WzFdm
         DKKVX3+mNSIIepd6w/O2Jm8pr+Q49bVwzAL0vaW0kDqKqbsd4ouYR3b4JtldyoyWxrQc
         ZGBg26tJznKzOn28OMyrcRt+VCs1cCfsvV/OcBpXkqAejXR+Cb5U3RrUNZ7wrBfvwSCR
         x25qWTv5J/GQY/pmdslpYpFKF2RfdJdb27c4BFpA0E58tzU+/PQiigigkG047QeOi/42
         CnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765188517; x=1765793317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9jHdYoc3oT9NHwSrNbma2xbBTUVUF9I4q9RnVy+smo=;
        b=v3kehhT1kCV7zTlFeEQ7YLnXwxre2e6Xof4LQSvSeVA+8hMU/4SyfM8+IjnTPQWLQB
         xvJStM0T8jhWSkmLEu8KizwGASo29VPRP2ALS9iKOFWsXZPUO+y9Sgiqv9ktsQr9mA0d
         r1kwd9NDAHWrD8XOJ0d2DeAM8BuwdHJbymRY3FLYZu/iLYClYRjEXGB8/Q5dsI+iQvHo
         dbXE6bdKjeL+0wroTrdWomge/jCxtcXFKNfPwNdI0JjhzPq/3ec9xy7KEHSEKKMppnKu
         r2Tmlam+K8FfLhJJSKLbJ/7vHhD3EpR/59eaVltBGZ2RqUQFyJxMkCrol7iTP/HPUfBn
         6BDQ==
X-Gm-Message-State: AOJu0YwgWXC9E+MhoxH9eBHjjpaspDByIEJgfH+MWBRhHLKI4eXttWHM
	UB2cuHCqUvWRchpy0qIbLFbA6g4QahnGwq4uoNW3tJX/BQPn6PeWJC+LxOMRnZLovSQq23NfTtv
	46dqaFjoG2aKdkEhqJyjv5FC4MK2exnU+XfQRsziWjiZWY/uf3VbjD4oaeg9r7aMRZ3Rcxg==
X-Gm-Gg: ASbGncuXBdblV8xHGk98GVQa1dfb3TJ9PNwZEF9aaprnOmhYC3TYIWc0Jfr5f27OD9l
	5HqpGjOYkmceQ49DnGnXJskb96QmS0sfxXQjQVA6lujItQOn4QwJ2J7gILfrAweFPB5I964mTed
	ilWfRGd0NYAv+/AYDc6eDrnBZSi74c3MF3MfiJxqemRmAtI1NsPR/5Dscd5LT0cztvbqdxlJlR7
	hPoTFL7mN7oX4c77RTLlMhZJSy8icSyFLRiNqbwJjfUkF/r2BullloF2XtbhLWvvq9uoM1g7uG7
	lgLs6w9lOWWvRde2U0iad5FArkvKGaqxiUeV5KxhIIPycpnXXBAjdW6ooX6KI223BfLscv+/fC9
	cNsU51WF+13kocrqTMKub8FWQGXmTuSKro62GHWLuc9opqXxV0Anigco=
X-Received: by 2002:a17:902:cecb:b0:290:c0d7:237e with SMTP id d9443c01a7336-29df5ca8b3emr75729445ad.39.1765188516994;
        Mon, 08 Dec 2025 02:08:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUA8/9IdhCw4HBguQRklGSxNYLRNSBocndWUNTCInJrc5onf69jXc87HhRJlEXhIIgDWsBDA==
X-Received: by 2002:a17:902:cecb:b0:290:c0d7:237e with SMTP id d9443c01a7336-29df5ca8b3emr75729125ad.39.1765188516473;
        Mon, 08 Dec 2025 02:08:36 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6d75sm122467355ad.98.2025.12.08.02.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 02:08:36 -0800 (PST)
Message-ID: <01a05a49-ae5f-a3ec-7685-02a5f7cb9652@oss.qualcomm.com>
Date: Mon, 8 Dec 2025 15:38:32 +0530
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
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, jjohnson@kernel.org,
        ath11k@lists.infradead.org, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20251206175829.2573256-1-mr.nuke.me@gmail.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251206175829.2573256-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA4NSBTYWx0ZWRfX6uKo0FkfIKGN
 xUTwRFf8gU6gRt2SGoAjto2lKJxxna81dLBGHzXspJl9j4ZLX3w6r8FFTosP7yaGxm7keYmou+6
 by/UjpYKuLtz5vqjVUo2nDXdbl7AnJ/KR0NTfQA0n3WDZ8Y7rR0aQnp8lcD699Zw/bdR4Cvc3CS
 q2/vDZ0bY5wxnjHbKk0JVT6p6SAGjF48Ao9zNpGl3F8vSyl7XdNKo1yOSAKsNj3sLvGjEZIk0sS
 lgrfhL3gjGXdV6sHGSVHIwPUNJ4oExFtFpjfzq3IL0i36KwCbeuUzbSfWzShVaD+mjb3I2E2+50
 mPOj8ks4Wzfjtp0OEaz+81dSYZmOZIAjlY4mdnsNWpDaRx+AxIgtx9KY+14pcsz9FTPV2o+zhxr
 K8FEXVCYWfD7Wf4SoFb6ZvB6yO53vQ==
X-Proofpoint-ORIG-GUID: ztg5vf45YVuVcRHBbibh6jhQc4uO7NIt
X-Authority-Analysis: v=2.4 cv=cqSWUl4i c=1 sm=1 tr=0 ts=6936a3a5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=3EvvSBrUXICK9wu0dFAA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ztg5vf45YVuVcRHBbibh6jhQc4uO7NIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080085



On 12/6/2025 11:28 PM, Alexandru Gagniuc wrote:
> Memory region assignment in ath11k_qmi_assign_target_mem_chunk()
> assumes that:
>    1. firmware will make a HOST_DDR_REGION_TYPE request, and
>    2. this request is processed before CALDB_MEM_REGION_TYPE
> 
> In this case CALDB_MEM_REGION_TYPE, can safely be assigned immediately
> after the host region.
> 
> However, if the HOST_DDR_REGION_TYPE request is not made, or the

AFAICT, this is highly unlikely as HOST_DDR_REGION_TYPE will always be before
CALDB_MEM_REGION_TYPE.

> reserved-memory node is not present, then res.start and res.end are 0,
> and host_ddr_sz remains uninitialized. The physical address should
> fall back to ATH11K_QMI_CALDB_ADDRESS. That doesn't happen:
> 
> resource_size(&res) returns 1 for an empty resource, and thus the if
> clause never takes the fallback path. ab->qmi.target_mem[idx].paddr
> is assigned the uninitialized value of host_ddr_sz + 0 (res.start).
> 
> Use "if (res.end > res.start)" for the predicate, which correctly
> falls back to ATH11K_QMI_CALDB_ADDRESS.
> 
> Fixes: 900730dc4705 ("wifi: ath: Use of_reserved_mem_region_to_resource() for "memory-region"")
> 
> Cc: stable@vger.kernel.org # v6.18
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>   drivers/net/wireless/ath/ath11k/qmi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index aea56c38bf8f3..6cc26d1c1e2a4 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -2054,7 +2054,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>   				return ret;
>   			}
>   
> -			if (res.end - res.start + 1 < ab->qmi.target_mem[i].size) {
> +			if (resource_size(&res) < ab->qmi.target_mem[i].size) {
>   				ath11k_dbg(ab, ATH11K_DBG_QMI,
>   					   "fail to assign memory of sz\n");
>   				return -EINVAL;
> @@ -2086,7 +2086,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>   			}
>   
>   			if (ath11k_core_coldboot_cal_support(ab)) {
> -				if (resource_size(&res)) {
> +				if (res.end > res.start) {
>   					ab->qmi.target_mem[idx].paddr =
>   							res.start + host_ddr_sz;
>   					ab->qmi.target_mem[idx].iaddr =

The rest looks good.

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

