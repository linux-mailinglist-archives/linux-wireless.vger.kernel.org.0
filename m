Return-Path: <linux-wireless+bounces-17336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7088A09887
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 18:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC883A0FD8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEEA213253;
	Fri, 10 Jan 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k8DEC5eX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4995212B1D
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530182; cv=none; b=srhT+OO0j100Cd02/6siIdCHmNV/uF6JIIaG+KHWyJqipuY6tU0E35pwpN3DvSxMdZE44R/GemUY8Jc9VPhrUh7UhxM0wHlzXcHrRWUs4FNKEw1ZPIM55kJBxBz2dhSHdwZwDTeG/3QvEqnurSQK/teDPJAl0iOqdw+9deuFTr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530182; c=relaxed/simple;
	bh=Ep4bsP4kJsqzTsxItBo0FUoCQxDagR6DIZ9YdHAmnRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdLjazwSbgZgV7V0AlTHEMVW+ILt8LZj0/QaDw+yGnO658SyO/zzY8zClwKfKubYlkhfecjycSBZNTfiDnOeQ4aEPe3PDLbkCpddG73Zv2DeJBKNq0Zh1LyeA5F3l4jtgUW2VTjMubbME8ymmgqeodAK4BsKka5a7tt8KNfOxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k8DEC5eX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ABEw4R029661
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 17:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lyGuBftR/dVxQ+BEAk+dbg/RI07iGAC4ZV9KJTM70mM=; b=k8DEC5eXzGoOipj4
	CMQ8kkX+eJhSB2S9MqrNg5xftPIqNH/yyg45z+G6iWQd5vkiLBNtHP1P/AGyQOb3
	PwBz5DXggZzqEEW4XSdeLqwJWsdfM9OoiFCks36H+FBAAocZWiJ+BdXkkBJrHetj
	ZYI/jWFzE4vXGxc80bja70NOEtE3k01lXzCTPdkA4dvEMKJUEKYcf2NC5KBAddlT
	YYsOHQFNWFbmK8atnPT+2Mcr3pB2PkgspQWkrDVcD/r5cKR6NjDD5b9ybTVTSvL8
	Fm28ERknyBwQ1wsaRGHFGhW20XDb99v4uDFNeO3hSco2ZlCLYc17nMzBqFyC+rVT
	e5GgPQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4432gq0yre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 17:29:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2178115051dso43508655ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 09:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736530178; x=1737134978;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyGuBftR/dVxQ+BEAk+dbg/RI07iGAC4ZV9KJTM70mM=;
        b=qChX+HElasTo22e7jPcE5fAQlAxBiaHUunulI6amgaKpIGGTAq2P9115j3q5r03pqG
         DdOw/A4cjnsR46Jr6RPeQNlwONf5c6vZLIXcSqzNLwRiJnrwkU83Jqwvc+GQI8DnxMLN
         rerbt5a38ycMnARj/XNz85O1Gsz+mDpMfquKD3f8LurR3+f4GBpXQJTIB+SNfWrSsytY
         1JounxmYKOGccl1JUipjtG00PXmwhU0sC/bMdEsVqAHIjuS7P32/hKVKUx1NwYkAt8Dd
         j+WvejPLhTbPBTU6rTtpAJrgdWSu/BnRfuaP8odw2Rct0XooMX1FhfJ0UQcVMyb+ReOx
         8Yag==
X-Gm-Message-State: AOJu0Yy1umEY46hinMQ9+VsiGXk7JqaxRizimb2/y7Zdb/KPvlTnBOiQ
	HDqr40fEcDwrIb8VI0/sP2aYenROGuNF7Au4BILQKz9RT/4fchQ7ISGqut8ggrZhydVPAF3O6RA
	/ts3GRVbZn5icJm1FEj8mrrwyWkH/1rvYkwVAMSYh0ThwZaxKHmKMbcVWYJ/l/cSW/w==
X-Gm-Gg: ASbGncurrBmpeV+VCovh6jOwjAtgsxpuxyBhArByCNGWi1Gd7sP7lbXeo/4E8i6QWta
	HXV34oSL0qmegkCLntDdIswOfumYOAHBYddAMGflzHHAkQl3BJ48T3Wjmdh1I/B5ETByvz6qLAE
	U9wHjxYhIVABU7nQcVJlDckFxmA8g3GZQ/RklhoyiGvb0yAD2jraeg6ukjILOIUEjtLvIuj31+g
	i5+pkZnv/IlIGkH64JLeIIAMz5oIBlVTdxNt5mwV8wblbDCanteAX22XkrNUCjyuHMBrrPqKqtr
	DAQJjHwFBx4jpeK5KchG6SKbqV16f8ITkLj90DauS0UzaOSW9w==
X-Received: by 2002:a05:6a00:124a:b0:725:eb85:f802 with SMTP id d2e1a72fcca58-72d21f7f072mr15849270b3a.2.1736530177786;
        Fri, 10 Jan 2025 09:29:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt/J3AXNv5RP0AhLtV1XPz9FEzbX8OGNy/tVKhZaDPesiTzJ8XymACzJ8gqVMsrSrVFIjxPg==
X-Received: by 2002:a05:6a00:124a:b0:725:eb85:f802 with SMTP id d2e1a72fcca58-72d21f7f072mr15849239b3a.2.1736530177282;
        Fri, 10 Jan 2025 09:29:37 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658c4bsm1836573b3a.100.2025.01.10.09.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 09:29:37 -0800 (PST)
Message-ID: <9c8ab4a3-eae1-458c-a47b-66b4475aa3ba@oss.qualcomm.com>
Date: Fri, 10 Jan 2025 09:29:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/3] wifi: ath12k: report station mode stats
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250110064848.790733-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250110064848.790733-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kUFwKk5XCBtKHizcPOv4ta5H86Meovdj
X-Proofpoint-ORIG-GUID: kUFwKk5XCBtKHizcPOv4ta5H86Meovdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100135

On 1/9/2025 10:48 PM, Lingbo Kong wrote:
> Currently, the transmit rate, the receive rate and signal strength of "iw
> dev xxx station dump" always show an invalid value.
> 
> This is because ath12k has no logic to handle this relevant information.
> 
> To solve this issue, ath12k parses the information passed by the firmware
> and passes it to mac80211.
> 
> After that, "iw dev xxx station dump" show the correct value.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  600 ms
>         rx bytes:       4642228
>         rx packets:     23796
>         tx bytes:       933967
>         tx packets:     8761
>         tx retries:     66
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      8925
>         rx drop misc:   191
>         signal:         -20 dBm
>         beacon signal avg:      -18 dBm
>         tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>         tx duration:    0 us
>         rx bitrate:     1801.4 MBit/s 80MHz EHT-MCS 11 EHT-NSS 3 EHT-GI 0
>         rx duration:    0 us
> 
> v9:
> 1.rebase to dbe50a7420e2
> 
> v8:
> 1.rebase to 09fa3b6974a1
> 
> v7:
> 1.use switch statement
> 2.use guard(mutex)(&ah->hw_mutex)
> 3.use info0 = le32_to_cpu(desc->rate_stats.info0) and then use u32_get_bits() everywhere
> 4.replace time with time_left
> 
> v6:
> 1.rebase against wifi: ath12k: prepare sta data structure for MLO handling
> 
> v5:
> 1.use ieee80211_find_sta_by_ifaddr() to avoid using base_lock
> 
> v4:
> 1.rebase ath-pending-202404181533
> 2.change ATH12K_EHT_MCS_MAX from 13 to 15
> 
> v3:
> 1.change wmi_vdev_stats_event to wmi_vdev_stats_params
> 
> v2:
> 1.change copyright
> 2.change name according Naming conventions for structures
> 
> Lingbo Kong (3):
>   wifi: ath12k: report station mode transmit rate
>   wifi: ath12k: report station mode receive rate for IEEE 802.11be
>   wifi: ath12k: report station mode signal strength
> 
>  drivers/net/wireless/ath/ath12k/core.h    |   5 +
>  drivers/net/wireless/ath/ath12k/dp_rx.c   |  20 +++-
>  drivers/net/wireless/ath/ath12k/dp_rx.h   |   3 +
>  drivers/net/wireless/ath/ath12k/dp_tx.c   | 139 +++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/hal_rx.h  |   3 +
>  drivers/net/wireless/ath/ath12k/hal_tx.h  |   7 +-
>  drivers/net/wireless/ath/ath12k/mac.c     | 138 ++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.h     |   3 +
>  drivers/net/wireless/ath/ath12k/rx_desc.h |   3 +
>  drivers/net/wireless/ath/ath12k/wmi.c     | 132 ++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h     |  48 ++++++++

Since you are rebasing in 2025, you need to update copyrights:
* drivers/net/wireless/ath/ath12k/core.h copyright missing 2025
* drivers/net/wireless/ath/ath12k/dp_rx.c copyright missing 2025
* drivers/net/wireless/ath/ath12k/dp_rx.h copyright missing 2025
* drivers/net/wireless/ath/ath12k/dp_tx.c copyright missing 2025
* drivers/net/wireless/ath/ath12k/hal_rx.h copyright missing 2025
* drivers/net/wireless/ath/ath12k/hal_tx.h copyright missing 2025
* drivers/net/wireless/ath/ath12k/mac.c copyright missing 2025
* drivers/net/wireless/ath/ath12k/mac.h copyright missing 2025
* drivers/net/wireless/ath/ath12k/rx_desc.h copyright missing 2025
* drivers/net/wireless/ath/ath12k/wmi.c copyright missing 2025
* drivers/net/wireless/ath/ath12k/wmi.h copyright missing 2025


