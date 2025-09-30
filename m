Return-Path: <linux-wireless+bounces-27752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717B0BAD34D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069EA7A777D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E11D63D8;
	Tue, 30 Sep 2025 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JKk+gxh7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9391B4236
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242919; cv=none; b=ViMpVnqL9yWuVfijI374wOczEmhNtltTmJNQbBTJ1fZq8iS2ljrTmnLfb/O48C27FMXsrTaxfWwSjT439wSKOoSRgalCkNeOiHPKWZhVqtXxwfe1dHTzSDp7jLrLl7btONI2vyeLYVPNc9NG/vTJhanufrJN6bz/xwSf8xSo2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242919; c=relaxed/simple;
	bh=T44Q+A+NXVpaUyF9McD48ycjPHjUWj6+/FpypSXQ5xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCGPvgt6gXqWOpv4llCXpeyeQR+UbpfveDblqq5avdt3ZrxP5gxZBzdvjgo6SC+xtuvlwiC4PN5oztsE2ZrC/+rdCe4DiOcs6msHWVEJXGYEgnMs7/HhsTFoyCD3z2OwiAFIhd6/eYSnTYyUGHn7yfOaJLjjzGCDf6v1cIa40xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JKk+gxh7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UC3CNL017533
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 14:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BUYOMDB9EkEFadf2JHO2eigkdoLDTAIOZ93jCOeSXbY=; b=JKk+gxh7wEwDRTsA
	fJh+SJ1ZcP1TK06O+lY/z0pHCj/I7jND6Uy+AMQ1YhcfoX/3/3N0V/XC0nUk3j0s
	oU+a2kCtFYBt2ujmyeb3brY7TuhkJhTV5jWHTrDVIYSU49xzRnGOGe2QZkx/hX16
	Ksmzi1k2kRCjOUl8+i6Ro8C3NEKb6dk961V2MDOZ9fDcBNKlqdVYj5RR69JbwEcY
	7gEjUlB/Xumc/jx0SdRGW+JOC9eK7PRhAitHgf1M01NcYmA5KUrHNNmYH2j1Sj3R
	qoHkb+rLhcD53/EluPAt5av06oRDatqpQHpyCK5eCMNajR5qdK/ZWk1O2Ru08FrY
	uxPQrg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tscsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 14:35:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso5162075b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 07:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242915; x=1759847715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUYOMDB9EkEFadf2JHO2eigkdoLDTAIOZ93jCOeSXbY=;
        b=b5sTrS3tO7DLkZyWSZmRV8nYqdhuha4KMdIQeI4iO6C8gabaZVU5XNt+xIdd9uTOx0
         GcHBCr1NwZtgi6IOHiHQg4sgRcII2puy0lFgWHr5inBPzkM+lqwiCSqNdMCwg1auLdAN
         Em50ldn0ErygWu8CPMAD2GaPWRt2RIwkwroq2DJZLJWd3NWjWGHNLAUNca1lI1eI1whv
         wTnyyAkHWezUgcwQPSpxf5Kd8ZgRVDg4/gNj2aUQziBX6UuG4KX+mgDbM4g8rqLU5s5O
         DdYa2tTlB524TEHfugk/5OCXiE+Qmmnd5Z6+fdaWunsqGqppafmHo1BaTbUkHSMnAFbS
         kXeg==
X-Gm-Message-State: AOJu0YzthBZsnJYRum0FFm8VE5sMBCAlQ9DvkPlHkZh3aWXRFbOWLfNk
	1Jt8PQjy87IDJHdnfFkC99bMbCAdUL1ghoCKxPFcvW6sIFretJWN+xSzw/3DVYnoTlcE8Y4k2pb
	Bb5x2hqD5fCzschTNOpSLkwitVthhalird8ucXY6TfkRtPGWqYX1mjT2byrp2eSLKniAjpZz1Dh
	Gi0A==
X-Gm-Gg: ASbGnct/rGoX51wxq6mKW7tJg8QEHp8QgNos+Myv83gsG7dyMsKkMN1lSeXreoWyXd1
	ocnxg2iEL4MGwDxVEBtNtd2Kloc/LLdKI0lxlHezJ/AT3bnDfBuYB9/NHBnHUZGvmfQhbggwqfy
	0T/f600FRDfiq3o4ZK8Tr1U7KQnowNHrqCf40yrjMup8+IpaX+jMqAcyujhJnQ0GGd5KwHOk9EW
	b1Nz51pP7CDKQwHTbsAXsL1CfXxfdTdudBEISZYHEvDf9s5C9KQ/V7e9qv3HzBlS3pOWLpcqg2l
	uQWE78vpQ5nsSSZKXV42pbbIdtPfBG3meAOqoQetkvL7ChtFyxyTGNBS7CGaceFnQZaTmjliw78
	2m5XG/1KDN30nl73ZkJQ=
X-Received: by 2002:a05:6a00:21c1:b0:77b:943e:7615 with SMTP id d2e1a72fcca58-780fce9a50emr19078502b3a.16.1759242914909;
        Tue, 30 Sep 2025 07:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERPg5ZJRk8dz0ph328bRiAAwJg2g4EB7GzvUxmIyjNu0bbkfh2u3peHgOnyQ/TEKb1iV+ZMA==
X-Received: by 2002:a05:6a00:21c1:b0:77b:943e:7615 with SMTP id d2e1a72fcca58-780fce9a50emr19078462b3a.16.1759242914342;
        Tue, 30 Sep 2025 07:35:14 -0700 (PDT)
Received: from [192.168.225.142] ([157.48.120.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b23736sm14083548b3a.51.2025.09.30.07.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 07:35:14 -0700 (PDT)
Message-ID: <d0f8650e-1e65-3c9f-7906-507ae08bdebb@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 20:05:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath12k-ng v4 0/6] wifi: ath12k: Modularization of objects
 for Next Generation Driver
Content-Language: en-US
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250930131005.2884253-1-quic_rdeuri@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250930131005.2884253-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX1zvfAoI7U0Uk
 kgZdit8KhLUHoqdnmrwpNENNNAnfdSYaAAU3oMPQvfXSkgKF037ZsPU4lwt779w65AyMWW4ps5J
 7eX+NRBWwL8iTGWLyYkqOvkRyOIee3QEoLqTFQmfRc1ixLp6lHF8G7a1YhSlNbD1E91dC7xrzoD
 0GQK06Ymt7atn8R/VMRKX7m+uZ7xV0fJbq11ny/7bODJCDl6etm9DsJFaXUlhoG9HgxvymYySaA
 t2h0zb+Y2hyzkyS5ldxYHz0UjSsRJwrUkA6XQCWB3ROCSUb+EIcErqBh8n7O4g0wXnOk3PlEq/3
 lTDE0nVD74SCvWxrz0kgvBqKVoOQ9fcI4HUhE6dG1Wx/C/cKsMdt8uNNRY9ByWi513Xx7HYXDRC
 AsHt00YLepam9VlS7mkA0piACIGGFQ==
X-Proofpoint-GUID: o_Z59Nj1Bqc3celKvh0_gXVyxktmqeMz
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68dbeaa4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=3dlviFq7DiuaNFQpTVE66g==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=RLL8ftfnos28qhovEkQA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: o_Z59Nj1Bqc3celKvh0_gXVyxktmqeMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029



On 9/30/2025 6:39 PM, Ripan Deuri wrote:
> The primary purpose of the patches in this series is modularization of
> object structures along with their allocation and initialization APIs.
> 
> Patches in this series are made to achieve the following:
> 1. Modularization of device object to have a separate DP object in order
>     to support chipsets of different hardware architectures
> 2. Refactor hardware group and vif structures to optimize data
>     path operations for future extensions
> 3. Add framework to support architecture specific interrupt handling and
>     ieee80211_ops registration
> 
> These changes are intended to provide a base framework for the data path,
> allowing the data path to remain flexible for future extensions in Next
> Generation driver development.
> ---
> Changes in v4:
>       - Use ath12k_dp_vif_to_dp_link_vif() in patch 6/6
> Changes in v3:
>       - Use dp arch ops to invoke arch specific service srng handler
> Changes in v2:
>       - Invoke ext irq setup/cleanup from dp device alloc/free to fix
>       suspend and resume call trace for wcn7850 in patch 5/6
> ---
> Harsh Kumar Bijlani (1):
>    wifi: ath12k: Refactor ath12k_vif structure
> 
> Ripan Deuri (5):
>    wifi: ath12k: Convert ath12k_dp member in ath12k_base to pointer
>    wifi: ath12k: Support arch-specific DP device allocation
>    wifi: ath12k: Rearrange DP fields in ath12k_hw_group struct
>    wifi: ath12k: Add framework for hardware specific ieee80211_ops
>      registration
>    wifi: ath12k: Add framework for hardware specific DP interrupt handler
> 
>   drivers/net/wireless/ath/ath12k/ahb.c         |  22 +-
>   drivers/net/wireless/ath/ath12k/ahb.h         |   4 +-
>   drivers/net/wireless/ath/ath12k/cmn_defs.h    |  19 +
>   drivers/net/wireless/ath/ath12k/core.c        |  19 +-
>   drivers/net/wireless/ath/ath12k/core.h        |  39 +-
>   drivers/net/wireless/ath/ath12k/debugfs.c     |   3 +-
>   drivers/net/wireless/ath/ath12k/debugfs_sta.c |   3 +-
>   drivers/net/wireless/ath/ath12k/dp.c          | 145 +++++---
>   drivers/net/wireless/ath/ath12k/dp.h          |  32 +-
>   drivers/net/wireless/ath/ath12k/dp_cmn.h      |  50 +++
>   drivers/net/wireless/ath/ath12k/dp_htt.c      |  22 +-
>   drivers/net/wireless/ath/ath12k/dp_mon.c      |  15 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.c       |  20 +-
>   drivers/net/wireless/ath/ath12k/mac.c         | 339 +++++++++---------
>   drivers/net/wireless/ath/ath12k/mac.h         | 131 ++++++-
>   drivers/net/wireless/ath/ath12k/pci.c         |  23 +-
>   drivers/net/wireless/ath/ath12k/pci.h         |   4 +-
>   drivers/net/wireless/ath/ath12k/peer.c        |  10 +-
>   drivers/net/wireless/ath/ath12k/testmode.c    |   3 +-
>   drivers/net/wireless/ath/ath12k/wifi7/ahb.c   |   4 +
>   drivers/net/wireless/ath/ath12k/wifi7/core.c  |  24 ++
>   drivers/net/wireless/ath/ath12k/wifi7/core.h  |  11 +
>   drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  40 ++-
>   drivers/net/wireless/ath/ath12k/wifi7/dp.h    |   9 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  88 +++--
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  29 +-
>   drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  62 ++++
>   drivers/net/wireless/ath/ath12k/wifi7/pci.c   |   4 +
>   drivers/net/wireless/ath/ath12k/wmi.c         |   5 +-
>   drivers/net/wireless/ath/ath12k/wmi.h         |   5 +-
>   drivers/net/wireless/ath/ath12k/wow.c         |   5 +-
>   31 files changed, 849 insertions(+), 340 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath12k/cmn_defs.h
>   create mode 100644 drivers/net/wireless/ath/ath12k/dp_cmn.h
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/core.h
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

