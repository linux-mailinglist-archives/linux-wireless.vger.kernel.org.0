Return-Path: <linux-wireless+bounces-28291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54BC0BBCC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 04:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CC99348E76
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 03:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384B32D481F;
	Mon, 27 Oct 2025 03:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lMuX2Pm2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE952D060D
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535276; cv=none; b=aBM9TsMSvD3h9ET/uCEl86dYkcYRZfistrMjinT3QssSeu909otOkr5fUtL51VOARlQS9SMfe2edQo8LxY+D65t3vg+bbeIt6BrgLqUhRDLdJVnCBuXNHSUuVSF4OFF6YRAOG5WwDOJmN84Pfy4nbtEwG6fT3HQ5PCwWenWsNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535276; c=relaxed/simple;
	bh=q/r/uGwtluxPgBi9D0U5crTaWk7y2i0eM1Vz5AXJW6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtxwXnt5uaxL2sgu9JGeNOJqGFwHH5e0xbEKQqk9hVd+IkYWar3+vfNzmDu26ZNp+z9M4nTLDFJwzzBoSBvHBWDV2AxIC5Y1vWj93sep/NOvg2rhvmm8i/N8PQJFrj5rDKrvgeB51z4E2OswGzRcT+uetN+XjUdqI01km0/Dz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lMuX2Pm2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R0VkpN1272226
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 03:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yugFEZZSWkfP7XR6u8dKpoHfHUQdVHQorE5yF/x30Zg=; b=lMuX2Pm2XCEKxLII
	Y0U0GJIznsf56GhhrdhQecNR8kW2Q10bO8/BbX7die2CMnUeskvOFow2aawAO0Nv
	+KU9FnpTXnwi94+UhVXU1XgADAM1Uov0eJEkRO9wMRXzOaC4jJrdMgvsInZvL4Ph
	jhaBfc1gYRGpCGG/jHwUT0FWHtdymwhg+Ev8Z+uwtL0ZmzpDQvKiNFvD+lKm78qt
	prm1J+NhH4DprmFL3+JbvJD2PZRk1XxboiqeMaqDXdQs4c2nAARKlQv2xDs2gGCg
	adenta+pYejIbWu1RlMlcuw+AZDx4tlsH+rEYTja6a7iXhxVl5/Hg75PA7S5excu
	Pc7I3g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nnb34nx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 03:21:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28c58e009d1so91068915ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 20:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761535271; x=1762140071;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yugFEZZSWkfP7XR6u8dKpoHfHUQdVHQorE5yF/x30Zg=;
        b=IqZ2ohzVgtl7Jyb/zxXUfLwWJI4oJmd7lvUTM/ASqyJRiuNHlcoiXYXSUTA3qwyaBy
         AFFgkCSbGUC9X98wKAa9qevBpPs/YWxxpLqxWsqdgJx1ntzNwGPpWSOawmRgZ8EJaK/i
         YDcNjIXygbyE9OOuhV2PZAsDBoEGBN0pbTGPGtI2VSEoFLqWQgzM9eVb+lQ+FVyhy1EV
         NPlVCXoH/kYxamr0sGeqtKFTDBuYGjIYHx+DlSR7p1cqUtQq5OKHjgRA9r6EqKq6wO+T
         1C7SJj4cScQBldTDWAYCxIQryo/R5MlUjAKqpJ738wdABeM96VpM8o0bL/wPgBAoFCEp
         nh6Q==
X-Gm-Message-State: AOJu0Ywx3Nyq+Nc3bB/NhuQAUJAMLrz2Vby5pqtKa7pDqIbWl1xgYKcz
	7oqoQlZzGwckZMGD3OYFBnW/SpeBkp8hZQshEpOU06XS7+hxKYRgUm5jqEqRYP3dsP5/q0TsJpa
	uEO03QwFTSQrhsl/e7VQYe413wPan9iRFk/efhyskoGm01FceVLFr2tGyh8VttvCUxKE6OkCfgt
	hSAG1d
X-Gm-Gg: ASbGncvCQxHKTFyjiLk0b2lpjjwq8xrlYIfyts+vHML0akOCvgAcrZUlBhCh7p2FNvs
	iKJUJJ7RzG6r6Fg5m7RLh/SDjTUeVNk7nvu0R+2pQsUqj/QClLZLSqCvYY86AbRypj1TljWscVY
	6bviMuQ5Z9ugfC/uPCKsRy1nMCBjsLvosbyHl9fQe6c4gRckVSMCpxnFfPscgS0t9LGbyMsxKQG
	BQxq9ufbkSNJGfXXbRQY3CaI68E5wbDcfk80b6k18UZ/VQkxikhRoN5kgg1qp+o9rNrEibgYYap
	dxgKih/hP8gUEPLEc3gxgPT+Z/wM5FUlRKMxB0hCcN2RHRayqe6sWDqBQo614k7hlW3pc2T/FM9
	zWpxnTPKqWaJjoFEkRiVQzuh+aCXUJzCbu3tfz8DN+HfrP9pajN6uL1NKAquveP0NYloA22fY
X-Received: by 2002:a17:902:ce06:b0:293:11e9:192b with SMTP id d9443c01a7336-2948ba562e6mr113675665ad.42.1761535270719;
        Sun, 26 Oct 2025 20:21:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw0FVH59t3iumLkT6otArROk3B/9hZgM51dvGbVKU2gzakeUfX0AsxXZ/EDwyrQAi7j5JI0w==
X-Received: by 2002:a17:902:ce06:b0:293:11e9:192b with SMTP id d9443c01a7336-2948ba562e6mr113675395ad.42.1761535270204;
        Sun, 26 Oct 2025 20:21:10 -0700 (PDT)
Received: from [10.133.33.216] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40de4sm65243555ad.77.2025.10.26.20.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 20:21:09 -0700 (PDT)
Message-ID: <c082dabc-5ced-4eb8-9c15-0f2de678381b@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 11:21:05 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 0/9] wifi: ath12k: Modularization of peer object
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: K5Mh32rf3s5oZSkiTC0QrWMqzJMMCERt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDAyOCBTYWx0ZWRfX7MbPabn2G5ji
 fANNl/0zT5xPZQ7Gfy7zuZa6ngn0qBXWKPWQrceEnaDpKE6KkZ/So66OQejxW2d7cd3zFmGVHF4
 hZ6D/qaTOB1CqYo0nmEVePLJeAlx5U4cvrNwAB0mMJ9o6ysG1Tgp6kL4TMWycqkoyFtw79s4trX
 XMsSVyQoDEQQ7R7LICC/Blm5l8izi9Gme5ENeQmmwfFNlQMRgKD6+nyLIqkwRwNDknaYBvRsxH1
 3vTUuJEcTJC/qGtj6zxYbGBP2axOSoHrCqVwOdYuVWS+VV169PFmk2DX/lJc5aymGtYw5HInh/G
 1W0wPV0usbThV73OJD37VGoe7dqmWOOU5G4GG81foN8MaS3GhA76pHCTONudJsBSKt+iZPoVc2I
 nJdrPFR9B7CWD7lx7BxjjRhQhz8dDg==
X-Authority-Analysis: v=2.4 cv=AJoZt3K7 c=1 sm=1 tr=0 ts=68fee527 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=kNLFdMDWvYlnOyC5niMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: K5Mh32rf3s5oZSkiTC0QrWMqzJMMCERt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270028



On 10/25/2025 2:15 AM, Ripan Deuri wrote:
> struct ath12k_sta has an array of struct ath12k_link_sta wherein each index
> represents one link of the connected station.
> 
> For each ath12k_link_sta, there is a corresponding data path peer which is
> represented by struct ath12k_peer.
> 
> Diagrammatic view of the station is a below:
> 
>         ath12k_sta
>             |
>             |-> ath12k_link_sta <--> ath12k_peer
>             |
>             |-> ath12k_link_sta <--> ath12k_peer
>             |
>             |-> ath12k_link_sta <--> ath12k_peer
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
>         ath12k_dp_peer
>                |
>                |-> ath12k_dp_link_peer
>                |
>                |-> ath12k_dp_link_peer
>                |
>                |-> ath12k_dp_link_peer
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
>             Control Path                            Data Path
>         -------------------------------------------------------------------
>         ath12k_sta                            ath12k_dp_peer
>             |                                       |
>             |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer
>             |                                       |
>             |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer
>             |                                       |
>             |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer
> 
> To achieve this, following set of changes are done in this patch series:
> 1. Refactor functions present in file peer.c in such a way to retain functions
>    operating on ath12k_link_sta in peer.c and move functions operating on
>    ath12k_peer to dp_peer.c
> 2. Rename ath12k_peer to ath12k_dp_link_peer and change find APIs
>    correspondingly
> 3. Add hash table for ath12k_link_sta in ath12k_base
> 4. Move peer linked list from ath12k_base to ath12k_dp
> 5. Add hash table for ath12k_dp_link_peer in ath12k_dp
> 6. Define ath12k_dp_peer structure and APIs for creation and deletion
> 7. APIs for assign and unassignment of ath12k_dp_link_peer to ath12k_dp_peer
> 8. Use ath12k_dp_peer in per packet Tx and Rx path
> ---
> Harsh Kumar Bijlani (8):
>   wifi: ath12k: Move DP related functions from peer.c to dp_peer.c file
>   wifi: ath12k: Rename ath12k_peer to ath12k_dp_link_peer
>   wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base
>   wifi: ath12k: Move ath12k_dp_link_peer list from ath12k_base to
>     ath12k_dp
>   wifi: ath12k: Add hash table for ath12k_dp_link_peer
>   wifi: ath12k: Define ath12k_dp_peer structure & APIs for create &
>     delete
>   wifi: ath12k: Attach and detach ath12k_dp_link_peer to ath12k_dp_peer
>   wifi: ath12k: Use ath12k_dp_peer in per packet Tx & Rx paths
> 
> Ripan Deuri (1):
>   wifi: ath12k: Add lockdep warn for RCU
> 
>  drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>  drivers/net/wireless/ath/ath12k/core.c        |  12 +-
>  drivers/net/wireless/ath/ath12k/core.h        |  17 +-
>  drivers/net/wireless/ath/ath12k/dp.c          |  48 +-
>  drivers/net/wireless/ath/ath12k/dp.h          |  17 +-
>  drivers/net/wireless/ath/ath12k/dp_cmn.h      |  28 +-
>  drivers/net/wireless/ath/ath12k/dp_htt.c      |  44 +-
>  drivers/net/wireless/ath/ath12k/dp_mon.c      |  30 +-
>  drivers/net/wireless/ath/ath12k/dp_peer.c     | 627 ++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/dp_peer.h     | 125 ++++
>  drivers/net/wireless/ath/ath12k/dp_rx.c       | 151 +++--
>  drivers/net/wireless/ath/ath12k/dp_rx.h       |  19 +-
>  drivers/net/wireless/ath/ath12k/mac.c         | 381 ++++++++---
>  drivers/net/wireless/ath/ath12k/mac.h         |   1 +
>  drivers/net/wireless/ath/ath12k/peer.c        | 439 +++++-------
>  drivers/net/wireless/ath/ath12k/peer.h        | 112 +---
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  47 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   6 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  24 +-
>  .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |   5 +-
>  .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   1 +
>  drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  19 +-
>  drivers/net/wireless/ath/ath12k/wmi.c         |  14 +-
>  23 files changed, 1504 insertions(+), 664 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.h
> 
> 
> base-commit: 25122460e7f96864a80b59ffe6c953911516d3b3

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


