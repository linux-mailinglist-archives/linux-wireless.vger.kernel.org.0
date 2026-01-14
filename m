Return-Path: <linux-wireless+bounces-30830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF2FD20FC9
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 20:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1132B3008148
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 19:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370122DA759;
	Wed, 14 Jan 2026 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8xwDycM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c/GLTUH4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36B62BE64A
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418122; cv=none; b=jh0q70lHs0I0mF11N+n9+Zv6MH+vVzqGrES5WWkrPMI34ijv32YZUiZnMbaHm4m5NYxBE7Bo3b7C6J8fPfFE0JBLJZfB4O1vk+UBI8aUZlCace5/Smy8lUWvotg8MmaP8aAyZDPcfgZ2SrQy+S5aLwIvq90QYNtONBm0grhJBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418122; c=relaxed/simple;
	bh=O8HXYIHiNI0B79CEq8ZDt2nG02lI+oj0o65Z7exj6/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRFlPFG/mHRGXvy6aEaogR5x3sJfRYcdreoNuf/xwEbuhzG5/FvK1yAovCbDW0qqTL4mDOooxPRrRONQ2918gBDWm+zCkEfeUpkn/S7UQlJUMW5Vum+kBrwXd/HdW/fj0WAIBnaZ0lcZ+tl0ZDe4LNyKAHqaIDC0eYkkww821qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8xwDycM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c/GLTUH4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EEB6K52497475
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 19:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6nKyRDWYXLhKOGSTl0Nwo0SBmlE3o0buBJ8etCeq/b0=; b=l8xwDycMnqpMA5po
	dawf3cXzZB8UT4nI5+01JfeWnCUG8WJTOTx15fPd78vya0VGizSbIO1MAodKNQtx
	qE+RsqDGq1/bF5+eEEqlSXBDmAwBO4PbAWBLYvcUp9KrXgmw71bvsh0set4k7MNH
	BHRsZmcaJrm5rnzlk4KEpeCKWMpxwf5Gk/SwvpvCqyjOGCelqb7cIDP6jwezPUzb
	sWpyvbjun3jILObeqGiZc2V1I14oYU48/Viq7y6Cy1sbPBRVnWBddFq1S8td15pz
	0ZiM1r8yT7hsVtdN6IzPWMjMDVtcqc8tI/1gVMgyLSGr8nvqSjs0UBfdiuJe5SDp
	j8lDnw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp16x3t90-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 19:15:19 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1219f27037fso523288c88.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768418119; x=1769022919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nKyRDWYXLhKOGSTl0Nwo0SBmlE3o0buBJ8etCeq/b0=;
        b=c/GLTUH4A3IK6w9MFgOHc6sCx0jQonymb5WD365LYGUdDPJU8Is85PxUW9HXb/GKdB
         KWfMu8A6N0EUP8ynjpOm5rADcVkn7ehozK8AYewH2drdrBhHoR7nFfWO6bowL4opwJr3
         2BS4bUqn3eoPoyTgz77HGca+aTks3WXjzzMoeHf5iY4HkwDcS7BdLlpTLtCG315M4h9U
         ogdSIIlI4e++dqGhFHIIv5sxy8qy8Xfc6V+fDMGbpG2PWbd63tuPq/PViOGQYXONCU7n
         jFtWmFLHzmLMvMOrgVOAiqqTQ8O+iESJovQ3J7ZZU4he/aNRax1kx+Aj+uvJCsdQK/Cw
         oisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768418119; x=1769022919;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nKyRDWYXLhKOGSTl0Nwo0SBmlE3o0buBJ8etCeq/b0=;
        b=jBTUeUkpvSAQSQrQh6I6Tyje6R+5MfxeC9AHvOe/E/yKZheNjKe8jHnxwY0IbdLQC1
         CuWP8ocIxvwDS7M+mU2WfPbBvV9E4VGTECh/wMNtg8FMV/Apy1Tawtb8OEMcz1swFxFC
         dP6zzWMgoBVj5GrlG13RW1jKxOXqv+PP0NRskRxtk2VsKMY4FVVL+59Eai0KQwc2heI0
         6jwFndX+bbtlhehMn9dK9EGyUJi7jbELZ6niSvxSS0LSxndgcvPVShQXe/0TSH3IQ72Q
         uu6TmNKOMTjrnLUpiVTTd9dpX2VPUosQ8xnkPJc4QvlQmHlg0NW6vVR+kKyRJrUO43xL
         ifHw==
X-Gm-Message-State: AOJu0YzFWuH6arZXTnJxxTzkHmwIGFEZjzUWGbe2mnGSEHg685Io+nPT
	wsnfzVVHyEXeTH+pHar11udiiJjYn/D2JWfPxvTJYZO1C9PzUDkVcUAc5Nk4XFglcNdFKK6VM0Y
	NRRKIdnzkqr+ke09vrAJ5QkRlv/C/UClvAJ68nMymi8dgbm+/9FavaVPN2cLEYjb5iNzpxQ==
X-Gm-Gg: AY/fxX57CPhsoJbfLsytBtqv1yXQPNczKjw7myzElUmXr29n61zXQR096dh2keu2AhX
	7YSNqcfuBq6JoQbi3Hr6TgjUzdkmXgMzMJPVmie/wUvluHMRnCkONx/NyRJqoybrbGKXMRvp33+
	keHYb84s5Yrv/Q/S9j/EnTO6nDl/0UNE9EJnaBKGEHHeufqmv4mL5/OCWBmIG83HpL7zOB5xGrn
	rJDpToxfUS4lpEsd5MbEsADUT55dxwAsyrn8qeoE8NhEoAVjPlV/RElaRC4rnezIbywdy2CdD9o
	TjMOV3PI2U3nTzqhi7VPEGST47z0HGzt8ph3LWYoJ05jxe0Q3fiUllb3bY1bVUFgteu5Ln7uWzQ
	5njcpZsOhf7DFfQD8zUePykd6y0nhAaF535lRx+2hfhNuG3npU16jhq/sgRrmzwIpk51x5w==
X-Received: by 2002:a05:7022:6197:b0:123:34f5:bb02 with SMTP id a92af1059eb24-12336a35184mr4292766c88.20.1768418118721;
        Wed, 14 Jan 2026 11:15:18 -0800 (PST)
X-Received: by 2002:a05:7022:6197:b0:123:34f5:bb02 with SMTP id a92af1059eb24-12336a35184mr4292714c88.20.1768418118017;
        Wed, 14 Jan 2026 11:15:18 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1233693c619sm3331263c88.7.2026.01.14.11.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 11:15:17 -0800 (PST)
Message-ID: <63ff0362-4ee4-4f13-a212-dc1351eefe08@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 11:15:16 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DESIGN RFC v3] AP Architecture for Wi-Fi-8 Multi-AP Coordination
 (MAPC)
To: Johannes Berg <johannes@sipsolutions.net>,
        Abhishek Rajkapur Suryawanshi <abhishek.suryawanshi@oss.qualcomm.com>,
        ath12k@lists.infradead.org, hostap@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <653a4207-38f8-408c-8067-c4960c11a71f@oss.qualcomm.com>
 <05381371a41f154058429f0a1079204c4a454f45.camel@sipsolutions.net>
 <59cec65b29ded381c85d1be943d88e956a4b7e74.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <59cec65b29ded381c85d1be943d88e956a4b7e74.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CkxF8ANe04wdkG4oOJs_FGqKYve04GH-
X-Proofpoint-ORIG-GUID: CkxF8ANe04wdkG4oOJs_FGqKYve04GH-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE2MCBTYWx0ZWRfX/HtKvbBQ71oA
 94NLeui0Y9xVZ11+eBO3l/y0UKp3cYR/c5iKFK41y6ngOWGcmxFoAajcaOy5iq1USRqmkCtubUV
 lNL8DUokqgYKevVm78ZRKfdhbgy/WDekvoufiXJNBLTWUc14HW4DL0vwM8a+PR6AUxWZc2l4f8h
 /WMycc4VGcIHPzJjjT4BOVv4UKTEvHPXtV23/NiGl9EzftWoflS2+UWAWj6RYziXzZxVuVfD0eH
 b8Uhqd9xcaH8o0m2wBGmBp5fv3yKWEYkVqAzGF6q7+wrBIFiZoahB+UsAssNPlo4+zaNK/JbEN+
 JUQN1NqEcFlVboVKC9vmvw+cD1Hr8tJ0Fb77Rtc6Q5UOy4OIxbaOmhX4R34nyZTEM/JIBytdg6j
 JLhCqas7HMpqsyLkiyIuIhHCUgbWs4B8EOYqgR6pwGctt6KoDuOz/khc6JM2zft7HijrKD79H4m
 tlz3qJoNSn01wgdNdRw==
X-Authority-Analysis: v=2.4 cv=JvT8bc4C c=1 sm=1 tr=0 ts=6967eb47 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=qCjLGQ0mDaV0PH0PGrMA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140160

On 1/12/2026 11:18 AM, Johannes Berg wrote:
> On Mon, 2026-01-12 at 20:12 +0100, Johannes Berg wrote:
>>
>> Why do you always want to let firmware be in control of everything?
>> Seems at least for some of this you'd really want the upper layers to
>> control it for purposes of coordination? How does the FW even know which
>> other AP it can coordinate with, isn't that something a network
>> controller would determine?
> 
> A less generous reading of this could be: you guys want everything to be
> controlled by FW, so you don't have to open-source it in hostapd. Now
> you realize oops, don't really want to do all the security handshake in
> FW, so we need to ask hostapd and then we need keys and stations and all
> this stuff. So let's build something nobody else can use, upstream it
> and we get the best of both worlds - others will maintain the mac80211
> code for us anyway.
> 
> Am I wrong? Is there a technical reason for not simply doing MAPC
> discovery/agreement negotiation etc. in hostapd as well, based on
> driver/hw/fw capabilities, and then you don't need all these strange
> "triggered by firmware" flows?

My perception is that Qualcomm would love for all the Wi-Fi 8 functionality to
be in userspace and nl/cfg/mac80211 since then there would be no code
maintenance overhead on our part -- just you and the userspace maintainers.
But there are concerns about latency, and internal consensus is that some
aspects of this functionality has to be handled in firmware (or even hardware)
in order to meet customer KPIs. This comes from our history of supporting
large-scale deployments of APs, and the expectations of how Wi-Fi 8 will make
things better. That is why we are posting design RFCs, so that you, as well as
engineers from other vendors, can review our proposals and give your feedback
and counter-proposals. We want to avoid developing what might be an
architecturally pure design that doesn't actually meet customer needs.

And apologies for the "firehose" of both design and code, but we have a desire
to ship Wi-Fi 8 products using upstream code. I've passed along information
that you want our engineering team to focus on the base NPCA patches so that
there is the appropriate foundation. But in parallel we do also hope there is
engagement from other vendors on the Design RFCs we are posting. Our goal is
to upstream as much AP functionality as you can absorb.

/jeff

