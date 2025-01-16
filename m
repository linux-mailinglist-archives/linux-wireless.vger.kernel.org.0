Return-Path: <linux-wireless+bounces-17609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFB8A14104
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 18:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22F016B0B7
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E68A137930;
	Thu, 16 Jan 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mc0ckj2M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4724A7C6
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049312; cv=none; b=aCHiG2BLkew6Dp7LDpNczdU2k/FgCFHOgLJUr2KYo1zVIJGHwzM1geLU0kitNxaIvSH/TEnz6sGRuptvrI2dWNcUcqJs+IZ3dWv0seYt3vQ/As8xrPLYmGLhSZLK6tPmqKkKH7GmQjbYZ8XvQfiqt6a67PpGga1e2oOAsDSC0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049312; c=relaxed/simple;
	bh=hcU+IMaTttVSkI+sn4n6ctwhhMnxmLtZoPaQzLXO8Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AatvIMUD/YgBfPmKcTHjB1P6bEMDrpkunPnZZbwFQPZg5bjKnX26myOea175HBdBj3dBPbKe7YpeA2hGL15EY9NuPMPuob/ax0p2J+Rec0T1GJ2hDBO9ObUhRfxhueIItOKk9BS5+mVLUcB4MbH71WSvTYvwHuUvI4WOuD0QzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mc0ckj2M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBbgww030634
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 17:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	opn57RLjiYC4vaH6kef4xarF9kBz3Kyd8u0WF27Szls=; b=mc0ckj2MbNbmoERe
	re/i+awVrSoqmRs7izaISnfYRC1EtExpttF1n9wtNUr9vhA96cZpPuhUUJBcl1rb
	i83/zt7m86CWDuof+yVCtXVRQbsE1nR2qyc8zTjd5O4o2DV/KBoBbMLC3kyM5M57
	ohJAR2gNr76W7+vze57MtHrQOBtLzxyOfXJ3U6DyxQdo5FOWjJOFZkWWHJpkQH3N
	r6tVMME3FChFuafHh/HhCIStjtg91r7XDUUHeKGCaS5Ujueqma/jbwobN8hOPHtd
	+qLBEnVuVnHJy+8kGxFVvaKn2J+P1Kx/9YC9d0QcOyefytJKQsE7tMG10SJf6SSS
	i3YuCA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4471de8wjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 17:41:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2163c2f32fdso33670905ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 09:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737049307; x=1737654107;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opn57RLjiYC4vaH6kef4xarF9kBz3Kyd8u0WF27Szls=;
        b=xDvQe3dQ6Gpu+edzqZ+EQk3SSspfq0x1EZhIso3syOZfjr6qn8gQzQHC9OKpNL+sib
         KuCf+oVo2jDR9Huh3/Gluc/D1Wax3zzSPONjXRlpPLbJLzblyv//65SWZ70LzRQHAAb8
         rKRusyjxf/KnfNgKm8SPW7Fr/UX7rFf0oFaENRmmkz5yp0jqTY3/NUG1pVlMWjkgoR7Q
         4Xvp6yxALJjjZ+3mYRrWLkc5GKxkbu97BYLWAbK6SD4OHtsfZqcoYCzmDqrDxHZ1xc2J
         Q6CP6ER6uzBnKuPjIuzUniVzudTJH6mlJylvlcZsyDMrdyR/RYHlTS+XxlxnRijeJyWW
         yQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCUKN5nFxttuGEnmppCKv2YWubinKosw90DjUVNQcwlqMolrtZ71erq/iuYxBZb/0r5jsQqSqryKWi7T0ZbZgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtI+qKafKJ3HWiJVqiDYR5wN/dIZy2qx3cUp0QlwHOHrO1/IPb
	l6ulFue1WNyWsS7Kb0VK4pSM3CqPHSqB7O3YJ2YQJaKE9r6wFbJmBLexKcZMP+fEG76Nodp54B8
	4WE1m8rq6NveUPlxklw7jlVV+AOQlUGw9ssZKDW5KLfLpum2q3DDzplTdfScPzWTRTHrDeH/DyA
	==
X-Gm-Gg: ASbGncuebxhz+bWSewWgjzCoUMe10ft+mBdswkp5gX9Z6FPkzMzVbCG4qazODbnQ96D
	x0A9+e2Lp+rBd1iJrh0GWlS4aQ9GAp2zKTJRPWmOrrBqfWDUYsjqrte9wzCOHiEyEFnx69PQ6sq
	9oR4W38kIThRHUCr7HiB/JXL5KwoMneZz1XBnyT4fdxlzDIUm6TM5lrcVNlSJWILnc1T0J0QJWF
	TJ2wZhM7ahlAIhecBtvdoigmcvxekPaBnSJRYpYt4qPD/xuSgpY/LxbkoTHbrF1hm1TMHXdJ1wS
	6r38t0n0Ivwee3UNRqWQiC1DOn+lnGyrYbXAvH/rJRa2/1ufug==
X-Received: by 2002:a17:90b:534b:b0:2ee:d193:f3d5 with SMTP id 98e67ed59e1d1-2f548e9f9f7mr51169099a91.7.1737049307517;
        Thu, 16 Jan 2025 09:41:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTZmqbkdB2U98yVrBAtGzwuKeE+gYdGQwpfbTSc1y0NszIbuKPBglOSG8ppte7nU4Edv+/yQ==
X-Received: by 2002:a17:90b:534b:b0:2ee:d193:f3d5 with SMTP id 98e67ed59e1d1-2f548e9f9f7mr51169073a91.7.1737049307162;
        Thu, 16 Jan 2025 09:41:47 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77614d9b0sm435300a91.18.2025.01.16.09.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 09:41:46 -0800 (PST)
Message-ID: <2d82eedb-9773-4a0d-bb81-f1a449136694@oss.qualcomm.com>
Date: Thu, 16 Jan 2025 09:41:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath9k: use unsigned long for activity check
 timestamp
To: Kalle Valo <kvalo@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org
References: <20250115171750.259917-1-dmantipov@yandex.ru>
 <20250115171750.259917-2-dmantipov@yandex.ru> <87tt9zm2e0.fsf@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87tt9zm2e0.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tjP-5IN6rmPfbBNRb5b5LnUu7MvmfWXS
X-Proofpoint-ORIG-GUID: tjP-5IN6rmPfbBNRb5b5LnUu7MvmfWXS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_07,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=807 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160132

On 1/16/2025 3:20 AM, Kalle Valo wrote:
> Dmitry Antipov <dmantipov@yandex.ru> writes:
> 
>> Since 'rx_active_check_time' of 'struct ath_softc' is in jiffies,
>> prefer 'unsigned long' over 'u32' to avoid possible truncation in
>> 'ath_hw_rx_inactive_check()'. Found with clang's -Wshorten-64-to-32,
>> compile tested only.
>>
>> Fixes: b5f871ab4913 ("wifi: ath9k: Add RX inactivity detection and reset chip when it occurs")
>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> 
> I don't think this should have a Fixes either. Jeff, can you remove
> these during commit?
> 
ACK

