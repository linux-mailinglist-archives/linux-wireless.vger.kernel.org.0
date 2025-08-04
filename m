Return-Path: <linux-wireless+bounces-26124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99C4B1A30D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD453A4210
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 13:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D42580F1;
	Mon,  4 Aug 2025 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bFFm/K5l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B891DF256
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313402; cv=none; b=skxdYyIpRg3LuqPhwwNU+L7n5pGZQ7Dp5Q3pw8Ny2tNqxJ93JhkW6Kb+1HSLpCESHh75c0e23A0f+D0JDkH0nV1jiI/B4FWMp6yVulK9hHuoDl86+STOsn5YrFR05Vls1FhZXOA3NLN9/ncveAxwPQsnA/lUOVLMr1rRkG+LlUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313402; c=relaxed/simple;
	bh=LGF57M35rgadv8iq9N20lyYQI6dPzqa4pdKZimyhlbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEyfoxuPg4SUX8s7jeqtuuWXvU26cKLhTCCaDDdZj7PUXK0i7YjWRE1zG2ZzjB4BET0gNn4lkef6TnM5eP11HqPG0CG0WGdoXgak8BARqvbDSrgpfRSd4G8dc0Subd82JxDhj75TWTP+rCKTDoJAoFGO9b/1uWDj88aLGBVzwHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bFFm/K5l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574981Uu012229
	for <linux-wireless@vger.kernel.org>; Mon, 4 Aug 2025 13:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wgXRWKdb8/uIkJlxKRlTEuKqEVXG1EaXlBO5d+CRj9c=; b=bFFm/K5lguhDneyS
	WrB0qC9uZnJMCyoyyTzA6D60uGTmBFWV6+ajaDsBYc1M+qeI0hVynRSaVyh8d0HP
	vwUnwNppc377sTEXgSpfUHt03B8qogqY6JbmEouNYZ7fHWrEBd0/gfNw8xSD/prH
	fWYh3kkIGXJxh4p0najhgLrQ/FqojwQwsRctULet+Dj22D296Hxn2OC3IurXQxWr
	yJL/48cqWZoEUdKxG93HmQv9sUkTj8/LIA9wJqBtIHt6TYLpEiZYUT1oNkGz8Zgq
	5IiC9Po82NlTrbgZdOvfdi1ahcQYSoQC0njdkx/BQgF3u/mzPzx22uEuXmiJYxSq
	pgMJMA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rnb95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 13:16:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af23052fb8so2380921cf.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 06:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754313400; x=1754918200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgXRWKdb8/uIkJlxKRlTEuKqEVXG1EaXlBO5d+CRj9c=;
        b=WcRqjX47EY8cgGXUCnC06R6b45SP0W37uBNOWuLs9Tffq9gqBkBxttSQYoHMRjqUX6
         1KLp3qiE47CAS32r85qQN6aqHW4AbYLVz7O08OgaO5DowLKUJLMJw0yvBuQ0rwN8LmhV
         Ue+EU+dBax3r5O78Q8/0fCGyZu6/K076xvWRlOJdTF2zpliCiprD33BiNx0odKbJzndN
         KxnJv3mLhl+zNv5qbzdHn8xSVDikScKDeTI8trY5k6Ul4ilAqpjRNtEhwvSxT0zxI1RQ
         DBnJEEvXjgeW8l/94mD+a7o6kH8hGPrj38PWqR+bOEfZHS8jPR50Z2ZiUR1cLg18JO2v
         e6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxh6K4t9p5eS7sRwQfA0ZRmV9iz0NkXGdm7MTe/vGkopk3VZ+3XQcEcnT2H2fI1jNFoGAR7GBvfewAS6ZMIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21M12f8Ng6Q/+1PjlfsD/ag5Ra/6J5CRP8cT85OeAV3tNaD31
	6dlZvU0+SwRlF2QN7hFTdv/XxVNB60m/nnn7IG4hKMQYKuumT+Sxg4vtKDvyx6nTgZ5EcYfMiy6
	1jQ5ngl4/hVdlu24GPE3QEp7SbOvLiCFdJOJjnI2GyZxSzxEy2UEMVbnyGRDm1qmbs06/gw==
X-Gm-Gg: ASbGncu4Gf05SEMpJpLTwSbA+hRO1lRO3n+FIoVbgNmBTjIZI4s+15bvD+0JnA4pli1
	wZZfeZOlFwr2AqITjE70wYT872mnFsNsyfGZBMx1l1tjxKDeTc4UlndTvXRsCzTi3b9cjHwZJBx
	bOCuUdnTLJaH7Ag6EFp08zNzvsZxpb64lAQiG3PzeIBG0Sfk9dHV6DctrISnscX6M73AwESJZJo
	6zHOJVb8R6RBqHJHAa5Uk275YBTy4bc2ITt4bkmW8ykjv/CTBdtkjVW3nEoYWC0Rsqso0TuVwIs
	QrHbFMftQHhUyUn95/q3h3P75PzLSBbm43O1DLbMB3SGbND8tg5qVay6X7+jCpeMMnE9pVCKMQU
	rWrRiHjhuxTGBc2C9VA==
X-Received: by 2002:a05:622a:1211:b0:475:1c59:1748 with SMTP id d75a77b69052e-4af10aa56d2mr63735421cf.11.1754313399506;
        Mon, 04 Aug 2025 06:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf7yZ8n4Kn22sR5Uevb5Blz+Ts3PocLhzk4Ya+jFjCOhrB42Tx4xCPXD1tnN8w3MczWz9xng==
X-Received: by 2002:a05:622a:1211:b0:475:1c59:1748 with SMTP id d75a77b69052e-4af10aa56d2mr63734971cf.11.1754313398788;
        Mon, 04 Aug 2025 06:16:38 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe82a7sm6859797a12.30.2025.08.04.06.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 06:16:38 -0700 (PDT)
Message-ID: <095ab6dd-9b0d-4f58-872a-852c5f19818c@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 15:16:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] soc: qcom: mdt_loader: Remove pas id parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
 <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oQnjFa5VkE6zZ8st7Oz4mzlSMutpsSY1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3MiBTYWx0ZWRfX/GZe8AOz2o0S
 8/m7Weog5QuAUbUEyHjLYJQKWz1uGjGuwiPOon63gbDf15S25967B/KNYkXSg5g1TiI3wAYkimd
 T55JoOYkHkwQHWpUIakWu7WJFMLr2Y7LGyTvu0SS9jnvqwpPNF3Eiw19wCRy7zsHy3HtH4iwPQC
 OAvqXc71izfQmxbstciGd9oBE5ZOOjR83EwrQHLaYG/v1zCWnLsEAIqNG7i8Ss+aA5RZlbjqVUH
 4T/tLgVj6GFrlSvy7lyoNL0zp9BBlhJEroqKr0hzwlDrqmh9y+zvqMgcr5g3tiV6K+OhZpTl+t4
 boUJzakVpfVwtHU+84uEsQRJK8SVP1nPm/jweXQN9Ruu7b5Wf/ucBaP+QooNADgfT5v8gqkV3Zz
 iKKpOK0sZANdK7WAEYFcTWiP0LOttpMAIl12fbyi9ILq9Wn77X5aM+sWduxdJq+3pdl7EgAY
X-Proofpoint-GUID: oQnjFa5VkE6zZ8st7Oz4mzlSMutpsSY1
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=6890b2b8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=IDvrs2r2PCma8_SM7s4A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040072

On 8/4/25 2:41 PM, Mukesh Ojha wrote:
> pas id is not used in qcom_mdt_load_no_init() and it should not
> be used as it is non-PAS specific function and has no relation
> to PAS specific mechanism.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

[...]

> -static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_name)
> +static bool qcom_mdt_bins_are_split(const struct firmware *fw)

This seems unrelated (or at least unmentioned)

Konrad

