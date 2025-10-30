Return-Path: <linux-wireless+bounces-28411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 128DEC21523
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 17:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F01188E547
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54329238C3A;
	Thu, 30 Oct 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cSe2Seep";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z7/WSydZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B42E0B44
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843123; cv=none; b=SdwEXNlQ3YFuNftm0X7o5EDt77vai0E7EzrMZL5x6kMJ+qfQyG9CFMN3sURAjH7MJZkDAHjDNBcC/uIYZzFEUV/8FHNmOIxvbRQeaGwvqMNA5Uw3lwN3ctmnZamvP+ldb54zJW7kSUNSbfAXEpbSES2u2jcY+Mms3Nvrwuwnrt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843123; c=relaxed/simple;
	bh=WCbV9anZkjQV2F1a1RMkE4pj/O/wmh2KEvpHOgGcEM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0Z4hwOIQpBSH9XwHHOJBpvTtyuAB/hXSCQ9aJcDs+O9bzmQrWWWCZ9kIE1vns6EH/vRhj1n5rjh8Th8K0r8kGM8RFwtjN33okp8ZxroFMOMPlg+HIzasiZKgVInlsB6/h68KpcDj5odvh9fEfGACtALD9CEobUvnxAelZI9s+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cSe2Seep; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z7/WSydZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9PDvd3508813
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 16:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eZz41aEdKXKG9rGqSCE2bhjgFPPDtAOM+JviEVYKqx0=; b=cSe2SeeptTJAo4lV
	7r1J4sQZKIdU1SlzwiaZJcg2iLDPL5tMjeY5YWtRf/VjLDaqT58YCoSCZu2MDAPY
	mRZuKBfAQUtpxWGDiyZYL1YmZi9OsrCMLlreR2wyhZtSOUuSXj8/exV/TIb84BV9
	BbklknSX7MIVDkRAQsFqIvoZsiWY8dMWXKWDDNDUhjOHTPjCLzAVrOj0C/ivwFJh
	ErYtrqN4ZFMWibqz8gK/IoNbix9f3agNblOHjN9eQfcG3R6VSdtupH/bweObrf10
	FpLJvaWb9V8zMhCTb4lwEMNefoGObb1Z8r1EhM/y9Fv4KgG0BaeNTIBpJUA6IIMs
	Zco9bQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45cdh992-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 16:51:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290ab8f5af6so12879925ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761843119; x=1762447919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZz41aEdKXKG9rGqSCE2bhjgFPPDtAOM+JviEVYKqx0=;
        b=Z7/WSydZaPldgIW8kRpg9Xcme5nvzguwCMIqt5SMUgohUhlZVQ9grx8YmcfRmQ8ZoK
         Lm8W34locksX/wWMLidTdQo/jv7kANFFaFxp6RXUo917I29fFHZtGjsO22mluzT+w72p
         VjigpmdVxIDptMUp3+fhxvZcK+Hx4mUlHyPaeLw72fzk21uaDseukAkyU9vhdC7/u/s3
         7FW/xqf+2so8hwIsOgM81r7Q57kHtoZC1/uXpi2L15eFjX5XR3a2yigEk9eJkgK4wkyx
         /dhgov0E1h0FmkK0dGnVT7yJE7jOOHOzMOkqleHV5e051RaxnD1C7dKGmg1yidsdGsHX
         JUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843119; x=1762447919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZz41aEdKXKG9rGqSCE2bhjgFPPDtAOM+JviEVYKqx0=;
        b=IObhXGGLQ4NN9ZKBfUPJ0Bsad7IcGdA/eyu9cYgJr5WtDN1pjgSDOM/fwdU4p9M70q
         ZjgSrx8plbzj0qbV+YkL2MegLaMHd2JzbPPXxDfvqWu0xq1guoB2XagU8zs1oiwuQX15
         DM0iFY71EBi5ExerjgHf9vHlAY5tYyS+rlK2CUjAIVH56nhnT2o4qMh6zV9CD2b7Xy75
         1unpIGn16P1TBjxBx+5oOSqSZ7r4rVYbuQ+qie3CWELIvFyVr/Uo2VMB3zQFZH3U9V82
         I/YpnKe5TX4RjoZJSwNcntxBAA39nE8ObfSoW/2zGBwKxX4asEj+w++HyMocrtVO7SSi
         rwLA==
X-Gm-Message-State: AOJu0YwDAcaya7SuU0QJUI9n0yz44vNEQgRdhmSV4muaqXvQ8mnn1s4c
	AAqrjq8MtZWJ+pvC8E7JLa+JCVnGArOc1TURgEiMWVNaWEozIPxgYy2FMVzeUOgCvxm8/6O0/Jr
	wYszpQgfhH9L5B+KecydDLV1oelUKM/WjfttePaK0GHAn5dA3eTINpu48Qg3Hq5qqEIrd+3BC2d
	cK4w==
X-Gm-Gg: ASbGncspQul4uYj2dXA51S7tKOQwH9HYdpbd5JEWOFnq3IqL5bdkKibIw1BliKnm+2U
	3xxnE+4U33yCQYVTTHwvyYYjJ1awUM3vbGx5NS4pSF7RsVJahW01HEkK6S4+0YGEN9336oodZzJ
	ru8xWvnIj+Tec5Mn67c9wJpEqpjSBk/P0S85hrwMTBwR5HsH53Gk+TAHkmBLFrUJD0ijWeu8ZsE
	KPMT9PxDo3xOAaO/BQSQ9K6j8JyS+8tW/f6SXr/OdkOLXgOvu8w82MYhAcJ1B1rHd6ZNkAMCvsl
	+/Cd0cf9I74BTgzngXFNLHYhBTtSiLR99XmGfM9k+21D3OJ8Ocqp8OldnD8z7XaRvSxS5HAQZOH
	5igmvWF/0ca6eniGfd2/ZTuOTTFwfrSDFpO8KQvOal7Hs1oE3Cuo=
X-Received: by 2002:a17:903:1ca:b0:276:305b:14a7 with SMTP id d9443c01a7336-2951a4d8340mr5105975ad.33.1761843118791;
        Thu, 30 Oct 2025 09:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR9LgXr8czIv65FYwiMZ5GG7V0UqUQKtKjDM4xNrkLZJSnVNHhApxPf7or4gwmqERQek4oyA==
X-Received: by 2002:a17:903:1ca:b0:276:305b:14a7 with SMTP id d9443c01a7336-2951a4d8340mr5105585ad.33.1761843118126;
        Thu, 30 Oct 2025 09:51:58 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.207.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-294f34bd8e6sm31144515ad.105.2025.10.30.09.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 09:51:57 -0700 (PDT)
Message-ID: <8a1d7118-bc51-247a-87bc-d8dd6c669e65@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 22:21:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next 0/6] wifi: ath12k: Add support for EHT fixed rate
Content-Language: en-US
To: Muna Sinada <muna.sinada@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251024001928.257356-1-muna.sinada@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251024001928.257356-1-muna.sinada@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yT81k-oDz-X6gJbtuhKzaMpJCDK70CJF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEzOSBTYWx0ZWRfX1tjFgPYREzEM
 /R4dMEa8zRZ0MefQDlQqU/gI8buR2QJNzdE8Tnucquc/Ytu8TTnGOjpyZS2u0gWigd/98Tj+uFO
 cPzLqKI2zM68IHlKp055EImblGE8bJ7fGPDxhhj1VxGkYz5DxH+3J1HyDP//kNwiOUPmahTDrdg
 yCeLjwlcZ4AV/gzzMhEc7EXLnmcj5puvYS4ag4hQ4U4wWqap4qQX2RpVAInmeZQmeuWgaVvF6gS
 m0ceUjNt/Zb/T/nsU4nrYQIlTtxIbjqLRVaaYHJHANf0rvmJNDTtdojxvwrNkIU7ijlljrpE01R
 6yUJ+u+bAgXCYMp3Vw6HiogtEcEhPG2lL2HviErNKojUyk8N8qmI+1PKO1RkH4NGIJApv+sE8no
 6L3Ex3qwT3iFLsYnDZCBxeIxun0fwQ==
X-Proofpoint-ORIG-GUID: yT81k-oDz-X6gJbtuhKzaMpJCDK70CJF
X-Authority-Analysis: v=2.4 cv=ItUTsb/g c=1 sm=1 tr=0 ts=690397af cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=CMr6UP9dfYAYc02HN5pMZg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=w0vWegmNwKWFXUhCgOMA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300139



On 10/24/2025 5:49 AM, Muna Sinada wrote:
> Add support for setting EHT fixed rate for mcs, nss, GI and LTF.
> 
> Before adding EHT fixed rate support, generalize GI and LTF setting
> functions to allow additional modes besides HE to utilize the
> functions.
> 
> ---
> Muna Sinada (6):
>    wifi: ath12k: generalize GI and LTF fixed rate functions
>    wifi: ath12k: add EHT rate handling to existing set rate functions
>    wifi: ath12k: Add EHT MCS/NSS rates to Peer Assoc
>    wifi: ath12k: Add EHT fixed GI/LTF
>    wifi: ath12k: add EHT rates to ath12k_mac_op_set_bitrate_mask()
>    wifi: ath12k: Set EHT fixed rates for associated STAs
> 
>   drivers/net/wireless/ath/ath12k/mac.c | 579 +++++++++++++++++++++-----
>   drivers/net/wireless/ath/ath12k/mac.h |  14 +-
>   drivers/net/wireless/ath/ath12k/wmi.h |  13 +-
>   3 files changed, 504 insertions(+), 102 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

