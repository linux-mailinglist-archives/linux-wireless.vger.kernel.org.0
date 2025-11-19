Return-Path: <linux-wireless+bounces-29117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA8C6CBE6
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 05:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 181EA3597D3
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 04:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCE22FF156;
	Wed, 19 Nov 2025 04:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KrA+NpPw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BM2UaKvL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A055D2147E6
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 04:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763526661; cv=none; b=M2fkyu63R938u8RkAcicTwjgEQPMEEwqf6yo3k3y7Ka2ydjS0dtXXesabRTRe8R3FXQjvGr0fI09H3QJUUuZ8UoGB8tsvbHsYZNULqPbYbNftDocN3Ra4qk4puLZ7GoB4uJWOoauJypX9QiUR36S26tuZ/VNB7dt0yvDwaCkwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763526661; c=relaxed/simple;
	bh=vOwxM3Slj1Kq2/zU9NXLMFhEyQ6eOXQEk4WAzXfVbAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLQntNXtjeYBnbRXc2FSmLp0bToAk4BHvJrrrW8nmnzl5I8u8FmJ1vN9jjg3JdJmz5Vln+eDUoW3D1Rdv0nV3iTnTwEBuXIyOsCyBTyK+b++LCxl3MbmyZcxeddbWSlaRhzegRA30JYc436E0kVS8Oqgxc/rpRiN5m4t6h3GYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KrA+NpPw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BM2UaKvL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ2Rv2l2755669
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 04:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CpOQmT8J3EsyDEVDiu5/ZLBm5w7Agm3o05e/oikIxe8=; b=KrA+NpPwm4xGu7Cy
	JPexUd3X45d7bc53HFixB/DcBXlLYVUzxRn9zvu6j7ShP//jRGeVh2Oh5hces/la
	TeV2YkWFnC0U7nIwlmH6+79yLiP1d8BHD2fo6gpK6iWd3SO4DfyuTNJ7noVMT+/z
	VtFIZGnw+R0EofCBYVQ83HTi4YOa5TBDy4VRDfDUoIezEIo2DKtaLB/dmUSo94F1
	jDxZ+/tftIEZOvntk5jfkwLXeeQJxdCuUZPvx06/Y+YArIqsHVOYW2FYOnw4Syq+
	qdyTzWUaYC8ZE10j4QcBN+a6J+bLmvmI4/LMV9fYrKfe94WvtQT4VrLVmhmMqZjc
	yBIsPw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agnkj35b7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 04:30:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b471737e673so10546877a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 20:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763526656; x=1764131456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpOQmT8J3EsyDEVDiu5/ZLBm5w7Agm3o05e/oikIxe8=;
        b=BM2UaKvL2x4X2ZxjtAlPkEOd6syjB1ER3E1FbXDVfybjsOQ3vo1pKUqZJLUhEJlch2
         CC1o/jVR5CHQJ7ZTrLFhG7dZbhsu72e4H+YDNFavg2wP6DvrNJslWNvYk6tSrOxbqlCb
         Z99wqGZHftWd5BCNSLD3KMIwn87AkEJahy383hxFPV5yltTE6v/vOao1vyMmjJ5DEhaS
         RFIUoBAtpQKMx8yTtE+ha8n3/Mk9A36w4VG6/ei6dXddyi17A5ZFvmCZfiYV8teAsOkX
         Jhj38QwyCeM+wWjRj7aQokui2zb7fMLHiaFNqTr/48F8ltvJnn5Rzy44Old0tVTL0ZbX
         MqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763526656; x=1764131456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpOQmT8J3EsyDEVDiu5/ZLBm5w7Agm3o05e/oikIxe8=;
        b=f0T8ax8IPGWiL4AC+n2djvBQyq7voSEH9RUsK5wzyoSwrfzUmSwxieGKKUlJGKb2Yv
         4W9Ra7VnqE9d9NovQnC7VgW6r0f7py7vgGLfEcL2VOj9/lRpTlbc03Gbj5MLuVWRTHBf
         Oo43ldt0duFAu1PACQlFVye73fAvO8Yd94UPhpaP1AV7qB2MPsDKsog01E3rni9FRAvS
         DtPMfupLkbVsvRIe6JTHTWNnWlq7lkPbgtCPPIlm+0+3uS31MacqlPpceW68nKAKTATz
         5n1mpcs+7NDeMdwTX3jMlQDgyJfJ3yjvrab0h7+oZxtinyMW9S06RdxwPaVy0m0PZl0H
         Fpfw==
X-Gm-Message-State: AOJu0YwHv8bKaQNLL/B6g2BSGIIvd4ItO8nWTF+g5O24xprfxEq0ZQYQ
	DlHot/DRk1zNfSIki+3R63kA5rFjmmZiOlr8ifRKhyWeu9Acmr0vHSwS7FTFIVH+LAtQ5Uih6/r
	ytaXkG7X12ZVXAFes7ej4lMaUWvzzAlWHycU8IjhOsG7dhQhEO18bWMdhTurQabCcHHx9AA==
X-Gm-Gg: ASbGncuxtORwNKCiM4lwFQzI77GAsYunT9XyXaQXRLgQspzx0OZmDqSqD97jV1yVKKs
	KTxix0lWhDNKypgZ4I4x6XE/LRUVdIxLE7f11hIeRlVgMVK0HM5F3rknJsOBidBMHZRnq8P3Ucc
	Z/IxAFMMp7yrBp1jcLjibPbeunXcEogXV7di11OI/yS+CxsE+NpTGgx6tKcwHGjImSX1Nv4/mhC
	o8EtJGosypayJYN9dm3i2h+r0Wg/z0p93FOX8pjj8amxM0CJT1SKMK07vK2DSb+MALVbfCazZqa
	RL5n9A+ZZUdYXTTje+OL381+MNuL+j4sDddrYxyYmqpMticxa6oWV4cevTRCETZ6//xpx5ZVZ2a
	IxVygfJGLqSqYe7g8hvGqR7XXv51KTk1ny4JZghdafSLk90pDygRf7dk=
X-Received: by 2002:a05:6a20:394a:b0:334:a11e:6bed with SMTP id adf61e73a8af0-35ba1c93c28mr23433630637.29.1763526655664;
        Tue, 18 Nov 2025 20:30:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqvnlKNYrTT3W3dusgRQKlWabD4+oZueu/nzfzKdIecWx4tRyVqe4leh0DWSVeMus+8J1WjA==
X-Received: by 2002:a05:6a20:394a:b0:334:a11e:6bed with SMTP id adf61e73a8af0-35ba1c93c28mr23433594637.29.1763526655200;
        Tue, 18 Nov 2025 20:30:55 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e7f2sm17902485b3a.57.2025.11.18.20.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 20:30:54 -0800 (PST)
Message-ID: <bcb98743-47b3-2aa6-85b8-1b485e8d5658@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 10:00:51 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath12k-ng] wifi: ath12k: move firmware stats request
 outside of atomic context
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20251119-ath12k-ng-sleep-in-atomic-v1-1-5d1a726597db@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251119-ath12k-ng-sleep-in-atomic-v1-1-5d1a726597db@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: h33ElV7mbg50flBTS0x1YLA1KatTol4Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDAzMiBTYWx0ZWRfX9brlGbqPUGZ8
 xurI/qu6eI3tM32yNYZg3hXpd/9XxWOGwOkiWg6mV8kTqyh0kZbqyg/mkye+dD2UmtpRRmdfWDr
 lTDwUTSeKd/pz47UutXWE/K3o4LtDyP1yZ0svpmAh3p/N4BIChsXziV1xaLGH6uGbUxD/Gpd5En
 dcRrRxzr+6ASIbVQn8a3/95SlffWtX+lNWqyzKUG0cw4RMjSRTrIXOOUhgE45LS26PHHZO/QQSY
 fGr2BnPEmusD0zY4yUS4eYwhkSywHKVvsii9eaat0Z6LiVCFuiwBNdGa3ydQfQul4skVqHtvxFT
 3rNdc9dwoFiENVMAvj3S3pspgMuH2wGL9LZWkIq7YwqAPmjHSDMGcRLAPsXRm/j0kttJPGIzLt5
 UL6bGbY5+VB0Qrvy9xwHHooxCtIo1g==
X-Authority-Analysis: v=2.4 cv=cs+WUl4i c=1 sm=1 tr=0 ts=691d4801 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OAyIG4kq6eV51QKt1ZkA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: h33ElV7mbg50flBTS0x1YLA1KatTol4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190032



On 11/19/2025 7:54 AM, Baochen Qiang wrote:
> In ath12k_mac_op_link_sta_statistics(), the atomic context scope
> introduced by dp_lock also covers firmware stats request. Since that
> request could block, below issue is hit:
> 
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:575
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6866, name: iw
> preempt_count: 201, expected: 0
> RCU nest depth: 0, expected: 0
> 3 locks held by iw/6866:
>   #0:[...]
>   #1:[...]
>   #2: ffff9748f43230c8 (&dp->dp_lock){+.-.}-{3:3}, at:
> ath12k_mac_op_link_sta_statistics+0xc6/0x380 [ath12k]
> Preemption disabled at:
> [<ffffffffc0349656>] ath12k_mac_op_link_sta_statistics+0xc6/0x380 [ath12k]
> Call Trace:
>   <TASK>
>   show_stack
>   dump_stack_lvl
>   dump_stack
>   __might_resched.cold
>   __might_sleep
>   __mutex_lock
>   mutex_lock_nested
>   ath12k_mac_get_fw_stats
>   ath12k_mac_op_link_sta_statistics
>   </TASK>
> 
> Since firmware stats request doesn't require protection from dp_lock, move
> it outside to fix this issue.
> 
> While moving, also refine that code hunk to make function parameters get
> populated when really necessary.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

