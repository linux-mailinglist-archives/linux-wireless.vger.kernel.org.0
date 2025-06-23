Return-Path: <linux-wireless+bounces-24365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1BFAE47BF
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 17:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C3A1882574
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525BE1A42C4;
	Mon, 23 Jun 2025 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="muv1LrfI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054B24BC09
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690855; cv=none; b=AwwRhyHPkJCxA6Hx+1hXsS0A1HWeCOwLlXqRrMbnHzBsjgiVdsWkqRT51RLIh3GJdm9r3Ad0Jw9ja80QYGcJJHgAOu3Kin34aefSZKQZpAIYLEBtHl8o3siv4NBAYabN3C0o+S6bRgvWY046ykaC+h8emB606mSigPP0b0UBGG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690855; c=relaxed/simple;
	bh=IeITghrJP4iPSsALB9poQfKO0wZfiG/sVqffHWQCkRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BjwRGupP8MDT7T+GWfnkFgaJ6j86F9m5grz9nHlVY9YLIsORq47fjgFuJutbWV/yHh0ckVzCLCSLpdpJbrmUdZsPFhIwIB746cf8M2cPVkgKYCLXF/K+FgSKeI43oWKLlQBabgt5j+jPZfboP7DD4S2rrywvQtL3Pv3SLRuZRa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=muv1LrfI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9UApT022368
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 15:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jSlSLiXE9ML5oVRqrkn0OwhaNJ+Eurdiuji/Hh4dp2A=; b=muv1LrfI6fQfE/9N
	bU4Ebn3xwqoNrav6Ntazr9z+L3QR9eeaVAlZuJyO2ZshGr7/cVVrOtnpaePK4rHl
	CxTsCbxNlyj+9E+Fo/YZa4S947mMa3BC5JzypOt5fYsSekqczVIYTnVgDkm1j89h
	77EZQCYiVJNt/+spruq+ySYXEm9OZ/1tPo69VAwyxV/GbaXD9hwsqTEUxpzlUy9m
	IRQht1z1zUQfmTWL2T+8OnSqTquljQvx8X3uiNQV8QnvE2fKdKCtcz/oKEYGktjh
	ctKXjJSUSh5T2lIQYFbpshob1qWDcmGkpxQGaz6YhR7lBfns8K+P9pZ1CNVrtCeg
	zFZUBw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b3rwws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 15:00:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3138e671316so3786940a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 08:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690851; x=1751295651;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSlSLiXE9ML5oVRqrkn0OwhaNJ+Eurdiuji/Hh4dp2A=;
        b=Rckd7IFWulVsgHy3WUxzXa7S1ZNMoxyxIAdPy02YNJGlDM2jxjSIsWKNqgimPWioUf
         4sa27dav7uYMs1nIjq59UIp/0JkKeuTIHTxby3uEwoQa2jfJHkG8zrQoctnV4x851b51
         /oAunFTE8SRRzS/D+CSmX2Oq+AnqTrVkIkoskzKxB4d05edQE7pGAykTajXF0gX4R1pK
         fNv7KGqjWQkDNCeGGofQlkPUKgxiHy1mErRIo1CneIKG0nH5dZF+4XKwoDKUUHCRmBYW
         W/n+NkAgOHAE01iMXa+5MpZzX1QW+PWDnwFjI99mWe5lM9M68x6MlFt+zliua+Lco2Fq
         HZqw==
X-Gm-Message-State: AOJu0YwZK3PDO0ByKFI8EetDCgs93x9mTIdGs50Nj3fTvEh70ymYpHsf
	rK3B73iQNwm7w3lxFEK0zMBmow/p35e3kp3EPbckmK3JCLC5J6oAC9HeYV2XaxEj06EsuD96Uop
	WbTJEzES6UeTDMbZJhq0Q9qaUib5BnUhSI8mcdqL82ZSDU0PuEzaXawUtCyRzwE9jag3C1g==
X-Gm-Gg: ASbGncvjYepCXN64/ALk/EL+M3n0ZLZMmfTcjS70lYVtUv+VPcPSWyRctwutbbqJXrT
	/FU45fptqN+o2ldOnj81R4BRbXEKdZz5vHQKL/RaBDSfX0OuIwHGrxG+cmkJsnbg7uKSl5sWjqK
	HAwn8WDkG55+bwigLAaegL9q42GpVh4RV5faY+5MqrLxKYiw/j4+j+677niHcOBKveSOt+pXtst
	bgFz8WiRBmauGZr/zhAK1fuwHCmlwoyM/pqiYEmlSoRiirLMYWu/pccG7OFpLvDmSv2N0xmjwsx
	HE3ECepxpgg/I8596sWEpvlDvwVPY5Vze/D11PbfiuVvpdED+ezCfJTudheZ7NfwZhlAWRHpmYl
	rFg==
X-Received: by 2002:a17:90b:510b:b0:311:abba:53b6 with SMTP id 98e67ed59e1d1-3159f51aac2mr17078285a91.14.1750690851270;
        Mon, 23 Jun 2025 08:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGdABP063Vlk5OVUgONkfYW+i6XNH2ryukyv215HD7e7TxM3SjPrhrNyrPInpcakQhC9K4cA==
X-Received: by 2002:a17:90b:510b:b0:311:abba:53b6 with SMTP id 98e67ed59e1d1-3159f51aac2mr17078205a91.14.1750690850497;
        Mon, 23 Jun 2025 08:00:50 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a318733sm10835361a91.38.2025.06.23.08.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:00:50 -0700 (PDT)
Message-ID: <500a10c9-c56e-4192-818e-8e07ef6c51f4@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 08:00:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: use real noise floor value
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
References: <20250528-support_real_noise_floor-v1-0-04507bd3bc76@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250528-support_real_noise_floor-v1-0-04507bd3bc76@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5MCBTYWx0ZWRfX7ZD4n5AjZ59s
 spCry97vNozwPvLIL2Osl2mMTo+tJte+bpgAyb2N9IzF6onOqCBHi3eFf5dAaU1SvVTH7cyQitX
 JioAiYQPJIG2le6Il3DmG5ajFkk6vio+jhUiDnfgZkQk0UyBkAgV2EGOXNzmLPn56vqQsBsb5gv
 bh8KPL/3GEYy8XNoGuUf5f0K6PfaNoiNoDbTNN+YMUPLnvQ3ryPCFqDYxJk5XSlU1Tl9BLVpPMJ
 aOPyHej1Xknr5dMdp2L34V+NoMdkZiDtcpNV+/inwUQM+ghBGlIwmAjlUe5PMKksRFoYWNZD0Pg
 H1Qj/MqunnOjFQOK7J8hSiVaeoH8EgWCzp7TROnt+r5wgA9u2Ie5xe7DseRudLS4o9nuDQPwQ0s
 nVtqjK5V2hEbNwe9Iuwbwr42CkTNNrvWGocZLXbtUsfY4v3w59hWF2xO3P+JhtQ4UhcUOyOD
X-Proofpoint-ORIG-GUID: 8x3vqZF9IPhS6ihFGqvAzXzTmr0BCrv1
X-Proofpoint-GUID: 8x3vqZF9IPhS6ihFGqvAzXzTmr0BCrv1
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=68596c24 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=ksen3YYlDcNkJCCezrIA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230090

On 5/28/2025 4:23 AM, Aditya Kumar Singh wrote:
> At present, the ATH12K_DEFAULT_NOISE_FLOOR (-95) is used to calculate RSSI
> value, providing an estimated noise floor value. Consequently, the RSSI
> value is also approximate. This works but however, using actual noise floor
> value will enable the reporting of the true RSSI value.
> 
> The firmware possesses the necessary data to determine the actual noise
> floor. This data is provided to the host via the WMI event
> WMI_PDEV_RSSI_DBM_CONVERSION_PARAMS_INFO_EVENTID, which includes the
> runtime parameters needed for calculating the real noise floor in dBm. This
> event is triggered by the firmware during channel changes, temperature
> offset adjustments, and hardware chainmask modifications.
> 
> Add support to handle and parse this WMI event. Use the received values to
> calculate and store the noise floor value and use at the required places.
> 
> ---
> Raj Kumar Bhagat (2):
>       wifi: ath12k: handle WMI event for real noise floor calculation
>       wifi: ath12k: use real noise floor instead of default value
> 
>  drivers/net/wireless/ath/ath12k/core.h   |  17 +++
>  drivers/net/wireless/ath/ath12k/dp_mon.c |   7 +-
>  drivers/net/wireless/ath/ath12k/dp_tx.c  |  20 ++-
>  drivers/net/wireless/ath/ath12k/mac.c    |  14 +-
>  drivers/net/wireless/ath/ath12k/wmi.c    | 233 ++++++++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.h    |  42 ++++++
>  6 files changed, 324 insertions(+), 9 deletions(-)
> ---
> base-commit: 3d933084a072fd5fb5da54c06a017abc0412c86f
> change-id: 20250513-support_real_noise_floor-205986936cd3

This series no longer applies cleanly on ath/main, please rebase

Applying: wifi: ath12k: handle WMI event for real noise floor calculation
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/core.h
M       drivers/net/wireless/ath/ath12k/mac.c
M       drivers/net/wireless/ath/ath12k/wmi.c
M       drivers/net/wireless/ath/ath12k/wmi.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/wmi.h
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/wmi.h
Auto-merging drivers/net/wireless/ath/ath12k/wmi.c
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
Auto-merging drivers/net/wireless/ath/ath12k/core.h
Recorded preimage for 'drivers/net/wireless/ath/ath12k/wmi.h'
error: Failed to merge in the changes.
Patch failed at 0001 wifi: ath12k: handle WMI event for real noise floor calculation

/jeff

