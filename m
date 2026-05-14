Return-Path: <linux-wireless+bounces-36437-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPvJBL1SBmqnigIAu9opvQ
	(envelope-from <linux-wireless+bounces-36437-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 00:54:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D766547982
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 00:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2ECE3020A62
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 22:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F4633689B;
	Thu, 14 May 2026 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nx5FoWJv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kdmChSeL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B13CF970
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799289; cv=none; b=Dg6DYF4Rjqqmy7SW7kt2VArv532h2Ttrd58kbiJDB+gvwzFvCxcHKNSLYkRPAxGI09WsFxNqTBrWEDmsbp5u7ZdRsyd/gLgOKMj6lbk1PzvGxIDDojgKeA3c+4sV46NeHFVPwlwpHiwsI9GND/enH1r0qVgdKcPxx6fEhZcSOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799289; c=relaxed/simple;
	bh=7pcu30mhmwKQgnuLcNvcTinjtLncCTeM6Bfvrq5FRBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKxETbV+T7Uqmp4XVNV3VFB+qwbWN+Rc6PBxOZ/2GAkfv6Xu0CT3BSQ5J72pntLaiXyI1Oa4yEC0EGKy0aUj8zBwNFoD+b63s0cJA6AzFMfWjRpmCg0fcv3n59ft1TTF0HVTKGRExQAPNix9dxAYDduNFAdOGXh6ijcOfBzS1Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nx5FoWJv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kdmChSeL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIq5uT3514759
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 22:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MpHjBeDGHzNDOy9dbVQ2YOk7VWW2/RGBa4Tmtno8w1k=; b=Nx5FoWJvd5v89gZM
	48c8IU7tmuw3OcJM4gr0WF9gTq98/wF9hZ5SYkbulVprYU4V67F263wDBeUmxTYu
	m3CfzV0CKmQ408Rfo9YEyib1wVdwgZRpkrhKOqTZDVw8U601wM3vMFWIlAxyFPOa
	N26Ytij/r03rJQoI3k2cUZ3AnyLF3riblfIsqybx0pbw0FUTSPtQWEsIJbLk4uob
	pMFovlkSFQeCyJ+Uus50+ZZjQmN97Sicrfv/f+qU70qaYh8VNBzcFdGD5F6t5cfc
	GJOwqX3rzI/pdzx3cB0HtPA4WUM66aLP716hzWcpXjKUaQaSKkCYmO2QA2GWlkhW
	Odel6w==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1v8p26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 22:54:46 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-132d5ad9c32so10281980c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778799285; x=1779404085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpHjBeDGHzNDOy9dbVQ2YOk7VWW2/RGBa4Tmtno8w1k=;
        b=kdmChSeLNClZGDfAd2cK2o1B5K2iqQHucKHaO7IFkjQ/2MoQg5wj2R+c+Uose34RUh
         MZjr8Mk5oWvDufD+IyhOC6ARK4cD4IQc1eJMD+OZa4uS1r8fiFzwh5JBuJU39mhIlMY5
         yDEvmIp4LYIaVXBmNZWL9eRWkLVL35rXRGft+0bTekWcgFP1aDzZJ5JuB1YQ0Z/m188Q
         WlogzsG8289sN/HKW+xLbq0zpqI3gKxAEp26gYWM0IGt7GtNe8tOA16nME1bTjhlOPG2
         QuNP4vtk6DFWjAtovibPYbNqThksXPFYej5xNBt6SJiUMRvC2eDP8hY5wIII9dNrNuGU
         bHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778799285; x=1779404085;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpHjBeDGHzNDOy9dbVQ2YOk7VWW2/RGBa4Tmtno8w1k=;
        b=ptd8ti/FaNRqb31KmSx3iGU6ztjG9abLds3DBJqVy3EDkZYwvbpKRwxb9nF0vi1ppT
         sl62FSWFE4bGfPGqoq8SnthMAotml7ypoJA+IiJj0VA06S/NuxebNGguz1lps3vqulWc
         fVOxCVlyB1oKHB0Fi7Su0dI7N5ctkHyXQspCir8klpYU7o4H3E89TTE8IYqRjxG+XcxV
         jCb0AQp9TupWvCca0rVReBef8rdQ9DXueNOBAv30oaLgxs5oh85rp//j3gD+6kWYxZ+R
         Fq9y8q66xxoranIv6+BoiyT549eJYEz9Lf3XnuYD6Hei1/Gz0u8qzxkwFuZGoWjhnpld
         AGZQ==
X-Forwarded-Encrypted: i=1; AFNElJ82hTvjAWsQKGmOcwOQ2D1kKZhvyFNcTrhRtJuWtd7OqRj05UmrEM1ul/z3vwVSMWAc4JxIN7z3gP7h9Ev8wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqlwTlMGCA75Xllx4QdMNQKSTGzsvpDTCQS9OuBiX1f/zADEbM
	tb9iseb21lCOU/Xo16ARnj7Y61B4YabAIU6Radjsw5xsEwpe9n68Yc8syP6KHbYarkH9g+OzEJG
	GZXzqWBtWQ7fzHOmZAcrWAv7RoEf6p1Y66lXVIIcLgP5tV+tBNf9j1YMFjGR+DxERJJZsTQ==
X-Gm-Gg: Acq92OHbLs2YA5a+P/+qYyljO2aS407E9pOFnGqQ0g98tYauVW2Ajys0lbAayaCsyGU
	/1A19nzIetDBdvCMpTfEaJ4dL4HmP0PHanQiRl2OQDKHaiwPIhDnAssNH7Y5H62TEn4iw2BZFTP
	seQm5BTmmK6p4VbtiRF870+Nuyiuxk4Q78NkKqKnbmev1gjK9ZOFsRoui8k0lMIvJyq7QX8ztgu
	oCM4z3+mPrBAXAgwsbG9TKGdc39hk71TC+HwaYG05Yr1AVieWL+IKj6Q8JyhhCIlftirObou2Vl
	PEJHCd4fkogpqHuBO63Lkp7MjnZYBiRwWMeKfpc9hMz9JxjcsOlgfFV/AZ0J9UV2DaMt1hRDh9E
	Nh0kBjWSDBQm+0bu1egfafZvqvCHfCIqMD7E4e7rIrsW9/YFuPvxynaLYShwyKEw3jlnjp5VEV8
	tG2nSnNfarV9L+owae7er5eTBA
X-Received: by 2002:a05:7300:8b95:b0:2f2:5c68:5052 with SMTP id 5a478bee46e88-3039817fe1fmr697854eec.13.1778799285239;
        Thu, 14 May 2026 15:54:45 -0700 (PDT)
X-Received: by 2002:a05:7300:8b95:b0:2f2:5c68:5052 with SMTP id 5a478bee46e88-3039817fe1fmr697835eec.13.1778799284735;
        Thu, 14 May 2026 15:54:44 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294500a97sm5423975eec.9.2026.05.14.15.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 15:54:43 -0700 (PDT)
Message-ID: <930c0363-74e2-41dc-9aae-2af431ae441d@oss.qualcomm.com>
Date: Thu, 14 May 2026 15:54:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Add two missing Lenovo IDs to the quirk
 table
To: Kyle Farnung <kfarnung@gmail.com>,
        =?UTF-8?Q?Santiago_Ruano_Rinc=C3=B3n?= <santiagorr@riseup.net>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        kfarnung@outlook.com, Mark Pearson <mpearson-lenovo@squebb.ca>,
        koike@igalia.com
References: <20260506200249.317690-1-santiagorr@riseup.net>
 <45f1c979-ea8d-4118-8551-eff93966b4e1@oss.qualcomm.com>
 <CAOPSVF29ofKi8fpmJxuq9F5uQXHe4RrFvGb2V-odGMNA77NWXw@mail.gmail.com>
 <agS7fr8mDI9TLpvh@voleno>
 <CAOPSVF2xwpR63MmngbG06_wPtQe2tOoVe87fanzXGRHBeJGYUA@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAOPSVF2xwpR63MmngbG06_wPtQe2tOoVe87fanzXGRHBeJGYUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIyNCBTYWx0ZWRfX8IOKwwJ5+jZT
 FpQ4Hn0kC/lNYH+EsLsRrmDXocpiRThaCIpNASzfl1YqlDY/wMHs/rswQtKV+yfyq0HZzyCkAde
 Lt2v+qYwMMofuTiLzbL7Pszyn1OCDMkyJ9fBSgS8K+oU4bzeYe2Mcv0MP5lmfgjAMiUUOn9JCo2
 cBAAlJWx5KEAXFUwTo8oJoH/XRtcNAymqknnWbBG12yj5jFEh9EmjPTpFRjw3IobzLJuHj6Wipx
 xPEJm6WX2CYLWksmiaW8dtMziQ50mWTmS43g6128AGKgoxxos3zFQroPStk2rZvmDo2X+Bumqlz
 ZoFvLFubDjeY/7Ah05UehxWdsO7nNyi+Gspnhun7KAVm68hPz36PgYWPhXuaZv0Db9RE4D+AfT0
 vWBbGVp4vj4+o0G65t7LCXdkDSfWI6Y2lcvocEKEdOTrFSIfrbUuiKCUW53aurovmj9DFJsLQd3
 qFUtW2qI2DJnhUc9mBA==
X-Proofpoint-GUID: oZqJbZ0l7vLyCrBU16L1lid1oP3Tln2a
X-Proofpoint-ORIG-GUID: oZqJbZ0l7vLyCrBU16L1lid1oP3Tln2a
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a0652b6 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=xNf9USuDAAAA:8 a=bBqXziUQAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=nagzklUHWQTCT_ILTRoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=BjKv_IHbNJvPKzgot4uq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_06,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140224
X-Rspamd-Queue-Id: 6D766547982
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,outlook.com,squebb.ca,igalia.com];
	TAGGED_FROM(0.00)[bounces-36437-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,riseup.net];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riseup.net:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/13/2026 10:01 PM, Kyle Farnung wrote:
> On Wed, May 13, 2026 at 10:57 AM Santiago Ruano Rincón
> <santiagorr@riseup.net> wrote:
>>
>> El 12/05/26 a las 20:30, Kyle Farnung escribió:
>>> On Tue, May 12, 2026 at 5:03 PM Jeff Johnson
>>> <jeff.johnson@oss.qualcomm.com> wrote:
>>>>
>>>> On 5/6/2026 12:54 PM, Santiago Ruano Rincón wrote:
>>>>> Commit 0eb002c93c3b4 ("wifi: ath11k: Add missing platform IDs for quirk
>>>>> table") added some Lenovo platform IDs to the quirk table to address a
>>>>> wakeup from suspend issue [1].  However, at least P14s Gen 5 AMD, as
>>>>> reported by Kyle Farnung [2], and P14s Gen 3 AMD are missing in the
>>>>> table.  This commit adds the two corresponding Lenovo version IDs for
>>>>> each.
>>>>>
>>>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
>>>>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=219196#c23
>>>>>
>>>>> Tested-on: P14s G3 AMD running 7.0.3.
>>>>>
>>>>> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
>>>>> Co-authored-by: Kyle Farnung <kfarnung@gmail.com>
>>>>
>>>> This is not a standard Linux kernel commit tag.
>>>> Co-developed-by: could be used, but I'd need a Signed-off-by: from Kyle
>>>>
>>>> Kyle, if you'd like these added please reply with both a Co-developed-by and
>>>> a Signed-off-by tag
>>>
>>> I re-tested the bug behavior on the v7.0.4 tag and found that I'm not able
>>> to reproduce it on my device. I put the device to sleep and then unplugged
>>> and replugged power; it never woke up until I intentionally woke it.
>>>
>>> Based on discussion in [3], I narrowed my issue with wi-fi disassociation
>>> on wake to a suspect commit [4]. I'm developing a patch that clears the rdp
>>> and wrp buffers during wake to clear out any stale state in the LMAC rings.
>>> I'll submit that once I'm done testing it.
>>>
>>> Santiago: Are you seeing the sleep/wake bug from [1] or something similar
>>> to what I was seeing around disconnections on wake?
>>
>> I was seeing wifi issues after wake-up, including disassociations, as
>> described at https://bugs.debian.org/1132343.
> 
> Thanks for the confirmation. I went ahead and submitted a patch for the
> suspected SRNG restart issue in [5].
> 
> For my P14s Gen 5 AMD, I don't think the PM quirk is the right fix at
> this point, so please don't include the 21ME/21MF IDs on my account for
> now. This new patch seems like a better match for the disassociation
> issue I was seeing after resume.

Based upon this I'm dropping this patch.

Santiago, if Kyle's patch doesn't fix your problem feel free to resubmit
adding just the quirks needed by your machine.

/jeff

