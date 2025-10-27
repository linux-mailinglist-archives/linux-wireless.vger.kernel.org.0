Return-Path: <linux-wireless+bounces-28293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C2BC0C16F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 08:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F4A3BC212
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB782DCBE6;
	Mon, 27 Oct 2025 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AJcDMgAG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8616B2DA775
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549619; cv=none; b=KJR5MW5SfLp6jfqXVpG4dve8NJ9pOvfAeVTRpiUQyDtjK/hk7BiczVc+wKY9bBkvk9dLQdErpk9ZIiJeUP+7Urz58mYxb0FU0pofKBKvue/ckyqPF7GXXvS6NyfMqdq+bbq+2laicVGY2LshTisH4W7rSsi7SXZFVGLk28QbX7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549619; c=relaxed/simple;
	bh=qT1QqBXi7ffPsi/bW/cfSnXkdvuGcwL210AjVjJUhqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roCCc0VccUDkMAA10JbjD5NHAflWLvFX48CTBwG76+W8HHzBcTAO660b6+MdWf/hB78ap654mTLsqPeSf46IhyKgOqWoyhQLrhX8trTqk0yv7ORSpD8B9vZcbkOjHonxM7Kkas9YpiWEzi7IuGU9no9g1LVi9bXENBkrXDRIcK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AJcDMgAG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R7JwHt2059323
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 07:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fseerEKgqzrw0vcTSs3SD7JIOJTePWS9S/GRHHk6XtM=; b=AJcDMgAGeut/Vrqd
	gF2vIoNSeQD50iy1e9rahMxBLBZX5PhhUOBUSdQplkAfeonVRUDxeqXIJ0To6U7Y
	V2Fyc+sYeU3Y5GzlxZoqZkLGpvIsAGZzTwt+gFmMFzWlfH8W7UCP0uZ0dzSZmmfS
	vGUQS78sW3yuLb/XtO/sa1t66WthXep4d8ZvPmtz4avqFLjj+KzViiajUQ+HViIV
	y8/wEe267+Ri0x9awf9SUWJ9rpVfUo+mATZ5TS63Oowu7X0YsqzX5LF0auST03H+
	piNsVxAzdcvga/LXhK39MkglhScjkU4ps+1kNPW00laLvRmerkLHH0Tah3JnSrH2
	SJfkxA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a248p801f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 07:20:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a27ade1e73so2857318b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 00:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761549616; x=1762154416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fseerEKgqzrw0vcTSs3SD7JIOJTePWS9S/GRHHk6XtM=;
        b=oMw2oM9YG29OXEdUp2WzgwD00Fp4PdozJ1Bo5jMaQkyM1QQR7p/o67Il12qDXMUn1Y
         YVYGfXZrkdOWsquKasNo7gbAqId7/8GT+/JSjAKYGNAjumHaEEdIlyk2WkHAOyAXi/Sr
         HKIZecM0krRfx7RiJeZfjPwg4WCtc1puX7A2GAMck1rXbUf3crg7mDuKYKunb5j0tIUb
         0EOBNvfLskznuGVryWvIW2r8cw2PrBphC4JaUSyGtYuctbiATHdShaSR+4DK+tY72a5Q
         L00xSfK7OFbN28cCV/7AmvfMorS5g28Gq9roWcfhCzki3/oULcDEfRcz8XA7sokLtScH
         1CCQ==
X-Gm-Message-State: AOJu0YwuFO4XCdaAIUwTPtw84OxPDTgZhbpkmXYJYYvNXSlN4Jpy7NlT
	F1xPtlnEnShxf0Aib4N/WXb/JuWpNcTw9AL13PqdSXN38fjzI2R8Hjz1GjZYVAHpudCZBfdXU4W
	wt9ZekBDST5wXQKHkdL4UM6x7KOPDHsE8VNKdz2zCNpEV9FMfkpzCd9oS2HDg4DhH796iRQ==
X-Gm-Gg: ASbGncuM1YJ/hveMza9IGZyT3DkPbMgupryPFB7ZJJfL5jLWxAIROHagJWBIsJGy1fC
	pLWtbFM8xy4rE0xoBn5QdN00vZvGTnW7S0Xifk/U/AN4QkTsGorucy6qgnGUfU8AE45UTnrDdMf
	GfiZ1Op3G+ymSp7IQ5kH3XcM086gv5FWsVn/byM6uN8kDcLmI4x6HWRDJ3pEj4uC52AYBuWr9Ew
	YVIi+376vgToIqvWg8QN0KQYPcHolvBDQYibZedRDI06UxCnOR1P6kNdShqQa4k1WgKO7jMIObR
	D2cCD6+SGXuefEqSk8d4FtGVjcefmp/aZPHKCPqywfJ9kWUDlne/rLTC/40Oh2ldAp9/opFqb4T
	4ruqqwZ+DfudmGUImNjBy6NHl5KsiUWKO8zg5MNEFyToJ
X-Received: by 2002:a05:6a21:339f:b0:32d:b924:efdc with SMTP id adf61e73a8af0-33dead4c184mr14454784637.36.1761549616089;
        Mon, 27 Oct 2025 00:20:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0X8mJy5YWdQz2Yc8elWfoJ5MDivNok1CbxKfg+gEBCPZps6FV7o9YJmJHkmQ76O1g6CMvNg==
X-Received: by 2002:a05:6a21:339f:b0:32d:b924:efdc with SMTP id adf61e73a8af0-33dead4c184mr14454747637.36.1761549615520;
        Mon, 27 Oct 2025 00:20:15 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71288857c6sm6187911a12.18.2025.10.27.00.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 00:20:15 -0700 (PDT)
Message-ID: <ea8f8013-7f38-9255-4383-ad112ab79372@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 12:50:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath12k-ng 0/9] wifi: ath12k: Modularization of peer object
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zvzg6t7G c=1 sm=1 tr=0 ts=68ff1d30 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=XqnS_aCHDDeeCFjmF_sA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA2NiBTYWx0ZWRfX4FSbMhD1oHCH
 pB1rmkm2uZyu1X0aNGP+YCTdHKwmXZX73Uhjg7pS7UdJQtPDdPmxvaTWhhFwAcl6nl6PQU6RB2z
 AzBc0o9f1ZHcm0IA4luD4UaH3m7bhusubiDn1vMWITfOd8NXtroey0ZhA3weYR7isF5A3mt+paE
 cwG6+kZ1y8zTk2ghtrG9m7XBjRLo4lVll9SKn45ipdZuJK+hUX/I09w87P55OQYNPYCJb2B2I3v
 RVPTtuEm+zLNx4wgfFpPjPHv94umThGjNQPdIOU1Yal3T12n1V+fCZolhY5s8AxHgLvbVygtVPH
 uVIJhpW0ubQI2ICE1fjt6epVVHS81J6jBPv9a1o0Fm67dV05EIE6TblGa6Lt1DomD/Az3RMlcZg
 dVlTvzLafoV0uLuJMlkTnBTIeFqEyg==
X-Proofpoint-ORIG-GUID: ik24TBVWFmCtC8w1CFtKaWSgPMl_DMNR
X-Proofpoint-GUID: ik24TBVWFmCtC8w1CFtKaWSgPMl_DMNR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270066



On 10/24/2025 11:45 PM, Ripan Deuri wrote:
> struct ath12k_sta has an array of struct ath12k_link_sta wherein each index
> represents one link of the connected station.
> 
> For each ath12k_link_sta, there is a corresponding data path peer which is
> represented by struct ath12k_peer.
> 
> Diagrammatic view of the station is a below:
> 
>          ath12k_sta
>              |
>              |-> ath12k_link_sta <--> ath12k_peer
>              |
>              |-> ath12k_link_sta <--> ath12k_peer
>              |
>              |-> ath12k_link_sta <--> ath12k_peer
> 
> Currently, in control path, ath12k_link_sta and ath12k_peer are used
> interchangeably, while the data path makes use of ath12k_peer only.
> 
> With ath12k next-generation driver framework, in order to have a clean
> segregation between control and data path, the plan is to use ath12k_link_sta
> only for control path operations.
> 
> Station view for the data path is revamped as below:
> 
>          ath12k_dp_peer
>                 |
>                 |-> ath12k_dp_link_peer
>                 |
>                 |-> ath12k_dp_link_peer
>                 |
>                 |-> ath12k_dp_link_peer
> 
> where:
> ath12k_dp_peer is newly introduced structure and represents the data path
> version of corresponding ath12k_sta.
> 
> This ath12k_dp_peer contains the fields used in the per packet Tx Rx paths
> applicable across all the links and maintains an array of ath12k_dp_link_peer.
> Per packet Tx and Rx path operates on ath12k_dp_peer. This ath12k_dp_peer is a
> standalone new object and has back pointer reference to ieee80211_sta.
> 
> ath12k_peer has been renamed to ath12k_dp_link_peer and the fields which
> are common across all the links are moved to ath12k_dp_peer. ath12k_dp_link_peer
> contains the fields specific to a link and these are mostly for statistics and
> monitor usage.
> 
> Final view of station is shown below:
> 
>              Control Path                            Data Path
>          -------------------------------------------------------------------
>          ath12k_sta                            ath12k_dp_peer
>              |                                       |
>              |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer
>              |                                       |
>              |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer
>              |                                       |
>              |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer
> 
> To achieve this, following set of changes are done in this patch series:
> 1. Refactor functions present in file peer.c in such a way to retain functions
>     operating on ath12k_link_sta in peer.c and move functions operating on
>     ath12k_peer to dp_peer.c
> 2. Rename ath12k_peer to ath12k_dp_link_peer and change find APIs
>     correspondingly
> 3. Add hash table for ath12k_link_sta in ath12k_base
> 4. Move peer linked list from ath12k_base to ath12k_dp
> 5. Add hash table for ath12k_dp_link_peer in ath12k_dp
> 6. Define ath12k_dp_peer structure and APIs for creation and deletion
> 7. APIs for assign and unassignment of ath12k_dp_link_peer to ath12k_dp_peer
> 8. Use ath12k_dp_peer in per packet Tx and Rx path
> ---
> Harsh Kumar Bijlani (8):
>    wifi: ath12k: Move DP related functions from peer.c to dp_peer.c file
>    wifi: ath12k: Rename ath12k_peer to ath12k_dp_link_peer
>    wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base
>    wifi: ath12k: Move ath12k_dp_link_peer list from ath12k_base to
>      ath12k_dp
>    wifi: ath12k: Add hash table for ath12k_dp_link_peer
>    wifi: ath12k: Define ath12k_dp_peer structure & APIs for create &
>      delete
>    wifi: ath12k: Attach and detach ath12k_dp_link_peer to ath12k_dp_peer
>    wifi: ath12k: Use ath12k_dp_peer in per packet Tx & Rx paths
> 
> Ripan Deuri (1):
>    wifi: ath12k: Add lockdep warn for RCU
> 
>   drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>   drivers/net/wireless/ath/ath12k/core.c        |  12 +-
>   drivers/net/wireless/ath/ath12k/core.h        |  17 +-
>   drivers/net/wireless/ath/ath12k/dp.c          |  48 +-
>   drivers/net/wireless/ath/ath12k/dp.h          |  17 +-
>   drivers/net/wireless/ath/ath12k/dp_cmn.h      |  28 +-
>   drivers/net/wireless/ath/ath12k/dp_htt.c      |  44 +-
>   drivers/net/wireless/ath/ath12k/dp_mon.c      |  30 +-
>   drivers/net/wireless/ath/ath12k/dp_peer.c     | 627 ++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/dp_peer.h     | 125 ++++
>   drivers/net/wireless/ath/ath12k/dp_rx.c       | 151 +++--
>   drivers/net/wireless/ath/ath12k/dp_rx.h       |  19 +-
>   drivers/net/wireless/ath/ath12k/mac.c         | 381 ++++++++---
>   drivers/net/wireless/ath/ath12k/mac.h         |   1 +
>   drivers/net/wireless/ath/ath12k/peer.c        | 439 +++++-------
>   drivers/net/wireless/ath/ath12k/peer.h        | 112 +---
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  47 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   6 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  24 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |   5 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   1 +
>   drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  19 +-
>   drivers/net/wireless/ath/ath12k/wmi.c         |  14 +-
>   23 files changed, 1504 insertions(+), 664 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.h
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

