Return-Path: <linux-wireless+bounces-27472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FEFB83649
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 09:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FF662198B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DD72E8897;
	Thu, 18 Sep 2025 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M+0a7Q7R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61C2E7635
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181727; cv=none; b=rZUpaeFbxdp9SGGmDTgWR91IGHXLrF7qduLgMCr5GakeqljM6GiWKebzl/OKR4jNvDkfteRe1k8tT5juNstqf3ORZqmBl4lGUaM+66Fk0oRTRmma7ZK94mJEihL5XXby0JrrkhF1mT+7b8+xD+osM9nTdOKFR5e5u6cR9uA3z88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181727; c=relaxed/simple;
	bh=1KTi+kS02AnAJpOO8413ZkHL4tBKui+eP/xbcL1wYC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gzf+G1SkkMOQdZaSZSu1qo7PXhhtZjAu/aOQkOlpebs4pD3T393EPkfcdCZ2gpjduLKNfu50MLlmcd7uR+xgdsTqJ9fx6agEs5U9fN+jMD2L+sdUd+jdYTb+mYr5ts3vDrVkBVEahngVlVqCRM3nvVPg+MkxDs9TLQnVzj4nrYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M+0a7Q7R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6eVrC031000
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FRPWTQoR8hA7x6PFpW61s8iJ3hsYQG3RiIDz2KF195Q=; b=M+0a7Q7Rb3CT/WlM
	lIMol5XExUQQwdwlOAZ6YP5/vKhI2mWZm7v1Cm5GEixnxJ3tiLslB+MST99XZJu+
	Y1mFgr06d7JRuP4hRy9akg/JPb+9GfV3STWS8rHgSQawqndDBi06ZB5zgzCrFk+U
	/YkIAhy4+jf7U+vvfl8c9T3jdUmXIapRSrDnbrWB1p+wFW1LYGpwfx/ohLEwE4e9
	9VnEh84i8Ac1NiPtFwZPzLPzjShZRmW85iKI3XyJgL9lTUkjnnt+8fyCUeKklOb6
	BJE9CBNqrgNqImcqMxcKBt8P05Rtha/HUoPep6VaIwdR04W1kqCUFDp0MGSbGVz/
	cxzyTQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy0wcn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:48:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54d0ffd16eso506158a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 00:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181723; x=1758786523;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRPWTQoR8hA7x6PFpW61s8iJ3hsYQG3RiIDz2KF195Q=;
        b=o+Bxsbl9P+m5h/Tnw/yTMC1RWwmBiEhBxeqR71vu6h+euBeDXlOX7l/C9ZZLomY61+
         jRozofPuM369xf5cYJnP5xgIE3JnbejgYeptH0VFRSDdjQ17lgsMQ/VoALiF1YUFrjei
         OdsypUQd8Bun2FIQkA88kKrFS36Kx7XL4gSnFM7o7miNBgaeRIQy+Yvy8N+hbt/z4L8e
         mXiZCjcvsKuLYx3JAV8awiQWUe98j7LGuW7pmx0a3Nn4auiTgHFPXDYGBmHee0H+PwuK
         rN7cHkNplf1JgltbEIA8tE39JlcWXSxzRkAIk94pcuWV+Tr1pvX0YJd+dnV91s/OQ5NR
         oqWw==
X-Gm-Message-State: AOJu0YwIEjhFs9OLMSTKWXgoFLhMXVwGe4ADG2fESn/7D+bZ1VNYU6b2
	Z5QplQpzJLMPH6k/2VrmW+r6DLV5U7oFY5EFpver7xhB8aPUCaonqNukJ35c3i7FiK1RzwQqw1P
	3u//hP17TtdF2KwneBkFqfYx+Np1vaASj76NeP2NyY53WBKmprKl3dJhBNv7OH3f97Q2Tza08qq
	jLiWkV
X-Gm-Gg: ASbGncvgFT9K0R+SqbO/0kbYRwWHpYEWhWJB4h27m0XbZQ6frmIQ3RIjMb/4drx7ogN
	jht/41axGytO/uvwczKHqkMedS7RqFh6dpHPxsTOAbvA4p7X0nVrEksR9OVzADcgDNH/Rrg9OaB
	hmijJuZ1QbM9bPMpEz+ECYEjQg8arTfGXZ7D+pIJX2LaJaM9GzTECFhLB0MMsUCMOtHsqOK5+aH
	XpyfCiS/0/vxbzBNrYVLwMuhebWL8p1EpdlGLkNg6xDBAEyA0GR+Spwher6mRtD7rWQd0ZMxuQ7
	MnzlyHK8/4Y7oBKj24jfBiryS6x5J0NkCHoFd5pLCVzhbdSLz15dE1icfoEw8ms8unbCNdjdWt0
	YFmKuIBj2whtdg6bofhUM+5/kw7gzp/Iu2Euo
X-Received: by 2002:a05:6a20:258d:b0:250:1407:50a1 with SMTP id adf61e73a8af0-27a977f5dc1mr7095507637.24.1758181723377;
        Thu, 18 Sep 2025 00:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfes/PqpkoFNGiZuENNGJlcSWQenzs1s+gQ7ULGGFIo1R3OTFx77erXs2zC8ULBAY9qHNoxA==
X-Received: by 2002:a05:6a20:258d:b0:250:1407:50a1 with SMTP id adf61e73a8af0-27a977f5dc1mr7095475637.24.1758181722948;
        Thu, 18 Sep 2025 00:48:42 -0700 (PDT)
Received: from [10.133.33.30] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc341236sm1525892b3a.38.2025.09.18.00.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 00:48:42 -0700 (PDT)
Message-ID: <80b711b3-5060-4e0f-94e1-cb1daff00f99@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 15:48:37 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: Add support to handle
 inactivity STA kickout event
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1yLGZVloZ6OyU-VM-wywJGRLoQxMglCd
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cbb95c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=o4nd2XIhPPp7Sg7KCEwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 1yLGZVloZ6OyU-VM-wywJGRLoQxMglCd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX90XIJ9suW2pu
 D1H1nrjI8PnRKEfp2N6FQWM4nMPiAp7t4QmplptPrfbtW6UrGaiGpO90av004WsDXQY6NJAr/sc
 B/hVRUfdmBDuninTdrH6+VpV0ye8JRyATx1PW4GW5zx88/qAKFJVSd9qmoJNlttzXw7dKiWcfe8
 EokCbWFqqnAjTjXi/+z9P0qPOOKQjG/cJVThMmBmR5Wn/gOgO/0MxJieccJeeAjQLl98TLZIrC/
 EtrJbfJ6Prx/nTH35L9Cqp980EKoOl27QIVabKqMQeuliwAWsYKLshSQdejL4Rt9otPOse95HQe
 WtSmIzoVuigtXJSUwIyuTcSom/laRsrIObIbiuFgpvgmZV4700wwXOcPHkb4y+oLKUD7K6nxjbc
 b7EzoynM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/12/2025 7:17 PM, Maharaja Kennadyrajan wrote:
> In this patch series, enhance the WMI_PEER_STA_KICKOUT event by adding
> support for reporting the kickout reason and RSSI value.
> All reason codes are handled by reporting low ACKs, and will be leveraged
> in the future.
> 
> Add support to handle the peer non-AP STA kickout event for the reason
> inactivity.
> 
> Currently, the ath12k_mac_handle_beacon_miss() does not handle MLO non-AP
> STA. Hence, add support to handle the MLO non-AP support.
> 
> Arulanbu Balusamy (1):
>   wifi: ath12k: Add support to handle reason inactivity STA kickout
>     event for QCN9274/IPQ5332
> 
> Maharaja Kennadyrajan (2):
>   wifi: ath12k: enhance the WMI_PEER_STA_KICKOUT event with reasons and
>     RSSI reporting
>   wifi: ath12k: Extend beacon miss handling for MLO non-AP STA
> 
>  drivers/net/wireless/ath/ath12k/mac.c | 24 +++--------
>  drivers/net/wireless/ath/ath12k/mac.h |  3 +-
>  drivers/net/wireless/ath/ath12k/wmi.c | 60 ++++++++++++++++++++-------
>  drivers/net/wireless/ath/ath12k/wmi.h | 15 +++++++
>  4 files changed, 66 insertions(+), 36 deletions(-)
> 
> 
> base-commit: d9104cec3e8fe4b458b74709853231385779001f

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

