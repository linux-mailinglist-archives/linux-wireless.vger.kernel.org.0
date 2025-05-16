Return-Path: <linux-wireless+bounces-23095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F676ABA36C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 21:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F15B188EF90
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CCF192D97;
	Fri, 16 May 2025 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rh88UX7x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C56024678B
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422537; cv=none; b=pN1U61voaYq2tchHlfUzL3Y9PfPk+Ju7DGkvFKqjDPQQ6amH1YsMj8biRCAM/Fv5cive2YV5TQuUBSTM/P8ONoo/Hvvo/+K1Ix75UgH2Z9GcESMC9udUUqU11ptVNl73FxhbGtpKkuX8WI4d/z6rcid4EPnXipxHvLQdJK+XopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422537; c=relaxed/simple;
	bh=pxXpE/fZNq6yLvc52y7PdDeNl9o9v335j69UIWK1LFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AN1Sb2gBH52EBj3ywTAc2eEp3PUtHqfWfkz5WoEtFRe6Rz7U9AtwgZqa6f0q8XEowCTJy+cq4rYOBoGYkLMJ6L5bpSq2aGxx3nowsVCcFVCy/9IB8Np1ScD5xWo9VUSprq4cH07rkTFVBLmaMVLerSeoGNVKsd3Dx0b9o7Fedzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rh88UX7x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GAkLK4014970
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W1EJKheOMiPM9GqihfGtt+delr480OzcwQJk/CmfpTs=; b=Rh88UX7xz+3klM2w
	aTUXEORusMkVUL3WJQOOb3b2/WiVDz6HndDxyIzoyosIg9PJK2r6iH6H1BqCuadA
	1Fji2zptDczbA7437/kxynI4nB1ijYe1Y0XIebjYan5Wo/1/DUxCH1Fo62nLqG/R
	SsCBNDwHi6SUYkT1wMbs1R1k5/HwnVAe26DEVa18hh9heI513OIPktfYscrgIfyB
	8MzssdGq+f/9mo81ZGjp49Av5NU8nVLmEs62umkqCfoMDdgHvLejec4yRZA+cgS6
	AHOdZpAiFm5hKMlgNRsY3F5O1NcUfwsCHSoGon0To+vBlTZj9eAURzpV0sWg/n89
	yG2ZRg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcpk3rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:08:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-30e8aec4689so703755a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 12:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747422534; x=1748027334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1EJKheOMiPM9GqihfGtt+delr480OzcwQJk/CmfpTs=;
        b=JA+sPe9MD/M4LTJopfXxqZPm7cW1fkGmyNPtzAOsygU1g9q/DV83kLwNFc1M26crwL
         dOqV0rySe8zPuUJxCxIo9Xx+rYP7/tAsw3oBbBldgAyp6lJAMiXmuSHcLlzsK9XyO25o
         a8B8Bw1sdmt/lo4mvb9iD0EexNrx/jLmdym56JEdjYwxVZxKoizUoCD0fkI8E2fQf4DH
         vhinQNErubq5Po4rlyoQoTEZSasPP9HZvapek2xOtfyQnylMOCcXbQiR4KjgtES6BCW8
         MyAd2Z933u91Mhtj695+I+C0SKMweCQ0e66zHH7CDe5zChAKVROQlR6GCFSueB/PBJvm
         UT5w==
X-Forwarded-Encrypted: i=1; AJvYcCVDIvbW+DXhxh1bxalYNlcDmHTgGYnV0X1/ARUZ71le1YUb5koE29xED2/ao7BNANOF57DvVS8bc52nst0PpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGkGNriqGUps9l1N7m4XEczYF6bjTLomSvCvHNYsceW8Z4Ztq
	3RHTLKzg4RY4ZZF2rLSHlNlqowEcLZUoaCfgUpKFI0kdPLm55Z38MwfYBXZp0WJOfGJig0jB1dC
	jeiMjE8VM6O63SwvXIp0HCdWIQB+zy4g2hKGvLdcAF0iq4kh8f9hSelhjGlTHTWUpGhiTug==
X-Gm-Gg: ASbGncvCsDlWtWBDkBYfCAZP4Jtl4UAOvgjTmAf9YoTrFskCyBArVey1b0KWRJqVU7W
	KlTNN+fgaTEOGc6loNWP2YEgsPY2oz624kvNJ4ZYajEh9N230KIVhtQZs3x6wQ/EfEH5Y7hFuL+
	xhRh6rNkN5bLy0Iw44QnGsHWb5ZrFRvOebHTWkCktj89HLDeTrr1uw1qzlREMQXLMPe+omAg1na
	MqbHjOoKIB9cgjHvrDENtPYmbq9SGfGo3TB2nCgwPKzzIIQC5yV4IUZlrIAKhH2L1m4YLaAI/jN
	oET/h1mufJhnaIfqChk8mr5ntbKmZx/k2kk8nJ0I2mb2PHams759nrxXh7kT+A==
X-Received: by 2002:a17:90b:1dd1:b0:30c:5255:ffd6 with SMTP id 98e67ed59e1d1-30e7d4f4016mr6537241a91.6.1747422533670;
        Fri, 16 May 2025 12:08:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjCoMdR7R7xPNjV/d+MGNlVvf+FoMIYIPH77AH2OP/4hldS1ZVPlxtnh5tCoi/7JYkYDA0OQ==
X-Received: by 2002:a17:90b:1dd1:b0:30c:5255:ffd6 with SMTP id 98e67ed59e1d1-30e7d4f4016mr6537202a91.6.1747422533311;
        Fri, 16 May 2025 12:08:53 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e334fb87dsm5537527a91.47.2025.05.16.12.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 12:08:52 -0700 (PDT)
Message-ID: <7fa413b1-99ee-4f60-b458-cce2a2bca388@oss.qualcomm.com>
Date: Fri, 16 May 2025 13:08:49 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Youssef Samir
 <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kunwu Chan <chentao@kylinos.cn>,
        "Dr. David Alan Gilbert"
 <linux@treblig.org>,
        Troy Hanson <quic_thanson@quicinc.com>
Cc: kernel@collabora.com, sebastian.reichel@collabora.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Sumit Garg <sumit.garg@kernel.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
References: <20250516184952.878726-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250516184952.878726-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bkAY2LbfQy2fZ1E4kJSw6MhkMhsU-bS4
X-Proofpoint-ORIG-GUID: bkAY2LbfQy2fZ1E4kJSw6MhkMhsU-bS4
X-Authority-Analysis: v=2.4 cv=cO7gskeN c=1 sm=1 tr=0 ts=68278d46 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8 a=uZSOL5_7EVOPlFl7amgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE4OCBTYWx0ZWRfXzXRo+U32C2yt
 I29YEqcmyK5cWrji30K4bPbYLpZfJSkbVIEpRwUWqq7tOxSY1cnUVDk5tF5mdDy5uDyZugVQGMV
 QpIMY/J9NcpQcfkg21bzDII994zLqCfSU9yGEFLxqoYNMkJ9xd6antJlxyG8IxIPwQBckkX9KrC
 Dxu+zpPAuuVx3rBipfpFXA7h6jzBqaX1dx9yFe7st5LYZDcXc0BIlzDdO79VdYFRLFrYdYehn8l
 zn8cxrnu3485x5u0TZp6sCgHxG47dYf92Xo+afxFgQgQdk/i645MZHrc5ZVE0DgvNAySK5B4a9P
 6erN5pZGfbiMLjeqZzaLeCXP0pgc0TJvErNjcSYvR3rV3hLng/bsE2eKe22NK3/LqNt9CFnauhn
 um/UIlxb7ekx2KZ0p1tIjV3WMOWVQYPwdc3ljCNB12gkTuDX5ubzbm7vaDXbkocupAoPkpJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160188

On 5/16/2025 12:49 PM, Muhammad Usama Anjum wrote:
> Fix dma_direct_alloc() failure at resume time during bhie_table
> allocation because of memory pressure. There is a report where at
> resume time, the memory from the dma doesn't get allocated and MHI
> fails to re-initialize.
> 
> To fix it, don't free the memory at power down during suspend /
> hibernation. Instead, use the same allocated memory again after every
> resume / hibernation. This patch has been tested with resume and
> hibernation both.
> 
> Optimize the rddm and fbc bhie allocations. The rddm is of constant
> size for a given hardware. While the fbc_image size depends on the
> firmware. If the firmware changes, we'll free and allocate new memory
> for it. This patch is motivated from the ath12k [1] and ath11k [2]
> patches. They don't free the memory and reuse the same memory if new
> size is same. The firmware caching hasn't been implemented for the
> drivers other than in the nouveau. (The changing of firmware isn't
> tested/supported for wireless drivers. But let's follow the example
> patches here.)
> 
> [1] https://lore.kernel.org/all/20240419034034.2842-1-quic_bqiang@quicinc.com/
> [2] https://lore.kernel.org/all/20220506141448.10340-1-quic_akolli@quicinc.com/
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> Tested-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

I think we are in a good spot now.

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

