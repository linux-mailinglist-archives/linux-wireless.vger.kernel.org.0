Return-Path: <linux-wireless+bounces-26454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3463EB2BD42
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 11:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D87188ECA3
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 09:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FC531A068;
	Tue, 19 Aug 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="msrFK4Ro"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0A31A054
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595288; cv=none; b=f5OP7JXjC3BX6kExvpDVmRjh36RNzd1vgNpdYI9rt5CFeLjLCLH1ux2IL8Qo18CEfhxmFQkj3jnmiP/3+hu8L29gJ/tMQ2QMpC2jX4sk8V2JRwMFpGv/HamAPQQJzlFn7Ygf2PJ+8GUo9Hp5RkJVoOofD2KJdjMBMWN8EwPr8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595288; c=relaxed/simple;
	bh=0jmiH6kpZzOWCrEpa3YgJuDHODp5nvFroYBZh4Xq3Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6PYMbJAtGqhnK59HGD3ZMu27wNa8Mlm9RQS+4vVr0OZvmcr1DfkC8OYSM0Yw//oxZOszwQh08hdvAadgK7mcxVvHiWgq0xatAwrjNL/Tb1vMLeVXopW6FBRyfxvoZ7uNb2rJDOxecqJHJgVI72A+TUm/O/RGecvVm5VPr9jeZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=msrFK4Ro; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90XVa023326
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 09:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KlJCbxiJKbGRGD1t4zE54FkwtVH9D8pRHGO5Xqy7uKM=; b=msrFK4RoFCZod9t3
	7BGSr8S3M5EYZoy33HZijMuv3jk15iuK6j6J/tL9GqczAX+mrNMPU3HNjo82QkVA
	5kb5QEKBktH+MEhc/YO3x7olZsRLoXTKpn7GVeJjyU3GQgFtln0Zd/I87sEZaW+n
	PetaRMHpwiniWjZiqiz2VHKpx7y7mtbPnBOtjifrAZUdiS1JdoS/837hMtX/LL7t
	EBDYCHyGx3K9dSpESgUbZpZnMPVeMZ+CF9/VSk2v52Ti5Qm3eNCd0071ujoENKwv
	zgCzimPJVHQtqfrk1LQtNYZLPrPtX7nUiBDtpluZLPvHkQub1iPSrnnnkSF6+7rg
	+jMZMQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m62vjwp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 09:21:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4750376ca8so879765a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 02:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595285; x=1756200085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlJCbxiJKbGRGD1t4zE54FkwtVH9D8pRHGO5Xqy7uKM=;
        b=rv4OxKjVGHd9FKwZ3FQaERf+1QSpYWLjVE1xgtjoAitklZ3TGBMCkr0ynZCnj31HOj
         3mZpg0sm46qIo6NvJIxO04yX6IaOW8iTO54j0HQUCZ/Q2C4qeqAKxAgar/YFC4sRH7LD
         3BDHH/WWSyEG6gUpGV/sS7i7COigiDQTsVk787t/5cATFszvqr0gtkXBOu7Cq0oIgqSE
         Kqa1qqx6Bs3phIic2JVXl0tbRaoFxSQZ7HQy0h0ZdzMRtc96l+PyhvkASPsvM+fqRjNC
         n3pwUwG0GqflRfdk2D6CP4QnGok2CAqPtM0iQD1gHHVDBgO8MioH+H40xMTBmX2LGoeu
         1GYw==
X-Forwarded-Encrypted: i=1; AJvYcCUhYul5EUBsduSDQLFaXwin06EfvnLtO4iTtnfGrl02rs91Fyu3YS0y/Y9WoJRNBnWSJS2n7h3pPRDYlrkM9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMzvC/otN8Z2Umu3qZZ7MCy0HZE+mKTCjEJHAGhRDTNJfQzG92
	ovCBTKt28rhMHHdhOxULfrGkrkqYfhNiCzpWvY2/rnjoVD+i5ZjZWngotL/WDkPf+egloMEuX+3
	3MT8nlrC+fxxhs3R4kmpJkLWYYSewvLnAXPus0HdQ/qFWA5L2lMeg2FGaU5zkaX6snrQgxQ==
X-Gm-Gg: ASbGncuYkRIRviSeRXio2W87u6z5E4r+Dx036SvYSnYMxybgwR60BcoMpss4vkaRzZt
	cjr29IRmfSvaXfe9o/vYgysRVicxSu73c4CJAAkQa6wK1wRLrlHjO/up/UsI6vR+QZnaLzy7fyN
	D4DNRTMcpzcKZMutpZOCCXxv1USA3nu47iTeZ33F6PTxYw0DhPswOOixzNxxBTCz4zpHfpKHoI9
	4bEwSg/yV6zwai6trzHIGZGerghH9HCb2v40+sv4snu8JQ3lKX5+c6fi1tb135PxDnyzxktdTQ0
	XRloalWTEowjiEa8Ctmb5hjktp4G92JF0VJmWtCWbxKL8wUSMgSJuGGYFUdwGTsELIZTwQJbFxB
	OYqrpsOFJ/fAf
X-Received: by 2002:a17:903:4b47:b0:243:3fe:4294 with SMTP id d9443c01a7336-245e02d5107mr24136835ad.12.1755595284557;
        Tue, 19 Aug 2025 02:21:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3mirU7iAl50GXTUGoqZomYHrb0Rj52+kFhbDwTJbx+QjqCieMTG//px0XqTrubDvgQSl5UQ==
X-Received: by 2002:a17:903:4b47:b0:243:3fe:4294 with SMTP id d9443c01a7336-245e02d5107mr24136525ad.12.1755595284039;
        Tue, 19 Aug 2025 02:21:24 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.241.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cadf96fsm103719455ad.41.2025.08.19.02.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 02:21:22 -0700 (PDT)
Message-ID: <0bd40ba8-5082-68f5-f458-b1417e0498c5@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 14:51:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: ath12k: REO status on PPC does not work
Content-Language: en-US
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
 <d6f0b64f-1764-41cd-a7c5-fb34d034ace2@oss.qualcomm.com>
 <aKQg5vLUplzMUMlU@FUE-ALEWI-WINX>
 <ff8287fc-7122-42e7-b6ab-550576b5d599@oss.qualcomm.com>
 <aKQxcfbDYOWTa36J@FUE-ALEWI-WINX>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <aKQxcfbDYOWTa36J@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzOSBTYWx0ZWRfX+vH/4IJkJ8m9
 DcQadviIB2NSGjvvfzbXLK7GbjcWhKUtYua9RVM6LzUTeX3otLl3+3/hMuG2E4Wr40cZRp9YQDj
 ZTLEkl+CGFDBDPBSXuXNzYm+1akNOtGEBgRi/hOjAouUZGTNAgsH0udRYTOid/3VwvFapHnpJPS
 VYSZuErAizvpixmR9bFZnJJ4ZyyQxs2judfVmKCk1TR0gQQoLBalabNT96d4U/rxuw3Y9XsX3Gv
 lUcYyfuEhr8bzrsZ15n4t8Vc3mnzvQ4VNgiX44IX4onVA/VUAmDJv42St5FbSklId0bOACKrz2F
 CXTahH6o5dBuj4/DzUnT/kyLEzT3zdO1T3BbmGtE/hTCj91guHC4hleeCOUeDczY3N9uCdP9IG9
 U5p8Xhmb
X-Proofpoint-GUID: T28LAXd0cJ6zn20mgKQu2ir-TbryMwXp
X-Authority-Analysis: v=2.4 cv=A4tsP7WG c=1 sm=1 tr=0 ts=68a44215 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Rf9vIqvc/XsATUXPJpzL2g==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=PnzfZYhc_8HIFXI2AzwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: T28LAXd0cJ6zn20mgKQu2ir-TbryMwXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180139



On 8/19/2025 1:40 PM, Alexander Wilhelm wrote:
> Am Tue, Aug 19, 2025 at 03:26:34PM +0800 schrieb Baochen Qiang:
>>
>>
>> On 8/19/2025 2:59 PM, Alexander Wilhelm wrote:
>>> Am Tue, Aug 19, 2025 at 02:38:38PM +0800 schrieb Baochen Qiang:
>>>>
>>>>
>>>> On 8/15/2025 4:13 PM, Alexander Wilhelm wrote:
>>>>> Hello devs,
>>>>>
>>>>> I'm currently working on getting the 'ath12k' driver running on a big endian
>>>>> PowerPC platform and have encountered the following issue.
>>>>>
>>>>> In the function 'ath12k_dp_rx_process_reo_status', the REO status is determined
>>>>> by inspecting memory that the hardware has previously written via DMA.
>>>>> Specifically, during the call to 'ath12k_hal_srng_access_begin', the driver
>>>>> reads the value of 'hp_addr' for the destination ring (in my case, always with
>>>>> ID 21). On the big endian platform, this value is consistently 0, which prevents
>>>>> the REO status from being updated.
>>>>
>>>> This does not seem an endian issue to me, because either of them we should get a value
>>>> other than 0.
>>>
>>> Really? I always assumed the value remains 0 until the firmware writes something
>>> to memory and moves the head pointer of the SRNG ring buffer. By the way, I've
>>
>> correct!
>>
>>> already implemented the missing endianness conversions for reading from and
>>> writing to ring buffer pointers like this one:
>>>
>>>      hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);
>>
>> I was actually meaning that, when hp get updated by firmware, either with or without
>> le32_to_cpu conversion, we should get a value other than 0.
>>
>> So in your cause I am suspecting that hardware/firmware has never sent any REO status to
>> host.
> 
> Yes, I see it the same way.
> 
>>>>> Interestingly, DMA read/write accesses work fine for other rings, just not for
>>>>> this one. What makes the REO status ring so special? I couldn’t find anything in
>>>>> the initialization routine that would explain the difference.
>>>>>
>>>>> Could anyone give me a hint on what I should be looking for?
>>>>>
>>>>>
>>>> What hardware are you using? WCN7850 or QCN9274?
>>>
>>> I'm using QCN9274-based dualmac modules.
>>
>> sure
>>
>>>>
>>> Best regards
>>> Alexander Wilhelm
>>
>> so did you see any obvious issue?
> 
> For example, in the function 'ath12k_dp_rx_peer_tid_delete', the function
> 'ath12k_dp_reo_cmd_send' is called, which in turn registers the function
> 'ath12k_dp_rx_tid_del_func' as a callback. On PowerPC, this callback function is
> never invoked, which eventually leads to the following error:
> 
>      ath12k_pci 0002:01:00.0: failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid 15 (-105)
>      ath12k_pci 0002:01:00.0: failed to update rx tid queue, tid 0 (-105)
>      ath12k_pci 0002:01:00.0: failed to update reo for rx tid 0
>      ath12k_pci 0002:01:00.0: failed to setup rx tid -105
>      ath12k_pci 0002:01:00.0: pdev idx 0 unable to perform ampdu action 0 ret -105
> 
> My investigations have shown that a cache flush is supposed to happen at some
> point, e.g. after a timeout or when a threshold of 64 is reached. Since this
> does not happen, I encounter errors after the 127th 'cmd_num'. This callback
> function should actually be called from the 'reo_cmd_list' within the function
> 'ath12k_dp_rx_process_reo_status'. However, this does not happen because the
> pointer is always 0.
> 
> I hope I was able to explain clearly what I was able to trace. Please correct me
> if any of my assumptions are wrong.

Your understanding is mostly correct. it is also possible that there may be something
missing in REO_CMD ring (setup and cmd_send) which shows symptom like this in
REO_STATUS ring processing. If other src and dst rings are working fine,
REO_CMD/STATUS rings also are expected to work. Pls check src and dst ring
setup path once again.

Vasanth

