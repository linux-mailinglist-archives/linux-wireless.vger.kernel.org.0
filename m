Return-Path: <linux-wireless+bounces-18743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4E8A30458
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 08:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB413A493E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B61D63F7;
	Tue, 11 Feb 2025 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NCQwdfh1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26BC1EB9F4
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258474; cv=none; b=YS813gsSjWS+3ZdfzTzM8y8J8wb5PUf34JHjbzHwXVSBXpppblnA0BuKX3riuieoTFzMmjkeKybkyWAewTU8RDnTRdI7doRhqsW9Qq6+gYqlMQshOWNkLPmxGgSY4zsTzAXL0XSDa56+S+09Ay3TNWygRfV47bQqQrVM9J0UXto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258474; c=relaxed/simple;
	bh=m1vFAUnpKuGAPLXoYWkXBNobUGY6dUt1RKuYmjwnCpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSnxPU1nge+++vX96E2k/9OX9Hkrofx5o2X6yoLmDWLZTcKoSInYX7v2JkCojjewwQ8OSnM9O+9atI8wj9cyK59kBaXAw2rHbI9PEXoRgnQBJP0DpraK78W1XiBbS76W/xX2SNrmeAHzmXuyqeqUTKCdhUKewcV5gDSfu76Bv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NCQwdfh1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B3fM2Y012444
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t+jjW3WqoDWb9MDSfylbdf32Lvi1zB6j1m3AVmlkAhM=; b=NCQwdfh1by8NZcFM
	X2SY0hLKTOjMF2YaiHzAKMC1SKdrDhyqm0CkfwlKt8d1P3frVHBBuJ9lalo4uyVn
	+3hE6VRRJCYcLN8aVWN/RYD/NEp4Iq9Vgei6OeTCpXPIKlf4SsCpOXLJhV1AG2O7
	1xyvrIyNcIwrOZhlnQVFaaPb21Z2OX5gCBlLS/Uq8e0jFEZnn7qPs0tl9OT57kmJ
	iRUJ2bTIJkp6YDSv/EERwtzjXAReijwA+H9329BSTf9Xb6y+jy9b6pZlqiM+G3RO
	q1x3pvNy0002JvuVInn9a6A77VsV1wqYpdx7SCUQPzfJ2dTWfIi0Mmt2CjYJE719
	bAZ9Ew==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qxv3rf73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:21:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fa32e4044bso7399613a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 23:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739258471; x=1739863271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+jjW3WqoDWb9MDSfylbdf32Lvi1zB6j1m3AVmlkAhM=;
        b=QO5BagR2uETS+sw9WZEgt4Cs/svkvdB3Qx+PSXGHuwZ3jM69Rl1dBijLmjg2qMHh3e
         pl+dK0cifH8odahx3mwmumo1sInYDsf+5+3gOcZNqKDHW0AnuYMm6G0d8wobwGNXYQhO
         Zt4Ag909ozWuAlFTPJxNXU6S7oLMOTanEODUGD+3+dc3OkShabwQ2Lw0ei3HYZmcac/Z
         ykUJ440Jo6f4LNi3/ev7FwcgAMFnijXx5zwbgfsNJVamxAJ4a373j0bN8XZyOzF+5Uy2
         qu62HeMTbjAQbFBVYS6KejaPT0nLX5GLlXhkw+ICzUXRcjHSIJ1WZQORTg4rvgbhE4br
         Zsfw==
X-Gm-Message-State: AOJu0Yy6x3AxGPiql8M3kuBf78AGgrtTIn5KTAaGc5/iju0Ic0l66dJ0
	6rWn6z6navxLQQWdV+3Fr4hlu8Rf4rRl+oBhEfDyfKLJgOfWlAURv2hRHqN2CZSshuszQonCDFy
	2YMEY56lZe54AXimq5i2y7iHBB/j7pRyE4delBrZfCJmSY2h1zS8IxJ8Ziv2j1yLdlmbzkgnQgA
	==
X-Gm-Gg: ASbGncuz/zgQKt0ZgvBYxkXivbhWy98lOzfyslUXpnfR+Ds+F/3mGVoaJ1gerZU4YQ8
	6pavQyga48yb9Z2OUV4Xbdf1963VDd3dMbep7K/YZ50SlFqh0XJe2VvzFfSo9DFcnbRV9fXqt1Z
	pY9Rp7AlkFq9MV6tti50u2KoqPmyifJal7KfIRe3y6Wnp/25VmNlQOBMIkOp6aFf41NR2h/WtyP
	3Bo3G7Xfg7CCLCYXrDzUzrSzKPKfB2M4GAXh9JvjWZbnlIJIvedh8BNPckUhDgRJ9BAUJP6gpdJ
	yh7OruHAN7tRhG7qvhWREZzD5fX8TH1ScKqsyTlM3iN4wOun4HZi
X-Received: by 2002:a05:6a00:1d93:b0:730:8386:6078 with SMTP id d2e1a72fcca58-7308386710emr14738061b3a.0.1739258470778;
        Mon, 10 Feb 2025 23:21:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH617Du0ucAbP7NRGAkG9YEimea9eu9q+jpDKLAuf7hxUGMxob3doHRVhKpa8lI/PoD5UJZhQ==
X-Received: by 2002:a05:6a00:1d93:b0:730:8386:6078 with SMTP id d2e1a72fcca58-7308386710emr14738016b3a.0.1739258470280;
        Mon, 10 Feb 2025 23:21:10 -0800 (PST)
Received: from [192.168.225.142] ([157.48.123.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048e20c32sm8993694b3a.170.2025.02.10.23.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 23:21:09 -0800 (PST)
Message-ID: <7927663a-5ea2-6fda-cea9-eb19ed8661ee@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 12:51:02 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/2] wifi: ath11k: add srng->lock for ath11k_hal_srng_*
 in monitor mode
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20241219110531.2096-1-quic_kangyang@quicinc.com>
 <20241219110531.2096-3-quic_kangyang@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20241219110531.2096-3-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2NE9H-HTM8ZwEEOplVBU86Wu0DvG8Vok
X-Proofpoint-ORIG-GUID: 2NE9H-HTM8ZwEEOplVBU86Wu0DvG8Vok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_03,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=859
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502110043



On 12/19/2024 4:35 PM, Kang Yang wrote:
> ath11k_hal_srng_* should be used with srng->lock to protect srng data.
> 
> For ath11k_dp_rx_mon_dest_process() and ath11k_dp_full_mon_process_rx(),
> they use ath11k_hal_srng_* for many times but never call srng->lock.
> 
> So when running (full) monitor mode, warning will occur:
> RIP: 0010:ath11k_hal_srng_dst_peek+0x18/0x30 [ath11k]
> Call Trace:
>   ? ath11k_hal_srng_dst_peek+0x18/0x30 [ath11k]
>   ath11k_dp_rx_process_mon_status+0xc45/0x1190 [ath11k]
>   ? idr_alloc_u32+0x97/0xd0
>   ath11k_dp_rx_process_mon_rings+0x32a/0x550 [ath11k]
>   ath11k_dp_service_srng+0x289/0x5a0 [ath11k]
>   ath11k_pcic_ext_grp_napi_poll+0x30/0xd0 [ath11k]
>   __napi_poll+0x30/0x1f0
>   net_rx_action+0x198/0x320
>   __do_softirq+0xdd/0x319
> 
> So add srng->lock for them to avoid such warnings.
> 
> Inorder to fetch the srng->lock, should change srng's definition from
> 'void' to 'struct hal_srng'. And initialize them elsewhere to prevent
> one line of code from being too long. This is consistent with other ring
> process functions, such as ath11k_dp_process_rx().
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

