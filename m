Return-Path: <linux-wireless+bounces-17451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D835CA0ED91
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 01:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FF0168E1F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 00:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D3229B0;
	Tue, 14 Jan 2025 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kbTWHQNf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562C1C01
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736813190; cv=none; b=XJkJ0gxtzg2dVmC2EUyCvVcBsKzJYfmPfHD6+P55xoZNgbk21ntvVXqehta6Vj5IZ903EDoFzae8aqmK2DgAjW5pMAVR2WSWJpUN4uIpbbNbjfeZwr7Ssc9ES18gwhzN8SS7haN8hhnS3DPkaaEuQj/r1yo9NlrY4CRpoEAuMHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736813190; c=relaxed/simple;
	bh=/2gYQern9NBPERaM2hWB+nU7Mn4IqCFyqXrXgrcgTaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIqxVcrzbfXTFx+N0g7TZzZ81Hof1YN/XRHLsUnp6vzHHgmhSnQrZRy6YCfcPhJRkP3c38KX7JXbIyDao4vWtAukS5qc+lFHTzRfQT2ubSBKcPk0qxPM/OV6BfFY37yVfEpuM/5tlz4CN6h/O5aF/Nvwyby6EOqzBwuWeWHEPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kbTWHQNf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DH3jj1020156
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 00:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BHaEVCu+3HHhE2W6C5rbU7x6fz74XS1o5EJDqqpOKxE=; b=kbTWHQNfkFtIkPD6
	bYDRJXbvC1Ewp1EU1/63tmxmHwAsBsyr3G/zCdRMIwJr8btshWlJQUu5R6VXD3bb
	YEIFypcWYH4NzFLmDhZhsO00rGcpsV2BEvEhPxYGe4DnUNCrx1XxFzcgOmQiSsZx
	0dNf2V1aqZb7e1TYJ67444fyFxkruUs6aNdASaWuqfz5oKnwpR9/jSXFJk+YnvfO
	A8Mq4CRcVxL4dpftGoMroP/Afed8re/goi0nG5HwRcLi52opxY//xuKgX5eeR8bi
	1jP8gdbm/vccjqqVJmXgxwaOQqARfshXh+dWwFCi5X6b1qEhWAeNS08y+4JdZfO6
	X643XQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4456wa8uxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 00:06:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166855029eso89629005ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 16:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736813185; x=1737417985;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHaEVCu+3HHhE2W6C5rbU7x6fz74XS1o5EJDqqpOKxE=;
        b=UBFBh/TQjvUM+A8avHcGbxqNDZuCVYMC6JHylhlqHFzbBxvIWuRGeQ4i1YC7Mx79E9
         WHOamPBy/be5v1IgTCudIwa4hNB8gFyjRKWcH4dqBvvEuV9JBzrnIwDKBR1U94c3Fbp8
         eiM3rzBYvi7codvUdRe9Hrsl23PDCnvu8RKbDiq1kX1XxbnhbJFjeYJBB5CehUX+TZDd
         WGGyhYj7D2JbbT2kPBJU4SJAD2H1jxNBHTV2kq94WSuJxlJflM4T5IwlRttbGyzyoX8+
         xO1PAiKsz15hmB6+idwH7T1ql/fqkE+2UAvbC/O8fnJOi7Z5q9vxZvC03t9EtBlJdh3T
         xXJA==
X-Gm-Message-State: AOJu0Yy3xKIW0ESJgC6gSWBROfBmGDlwtah1V45q4oNadgXfQQWqjZBt
	uBMkQEMmvM6slwy8mBejSqkOnWsfh3sbWsZXl1wjxIXMqy8pDAqf7BU86cYpLH8QPGoQV62b+/0
	r+EkiHMkSRygTPFh89L+tmJrnnn3j+CAHRElC/bJYxhzI/WFU5rmjNjNC5RqtZa0hrmSdWppNIw
	==
X-Gm-Gg: ASbGncskx3sEwwChGlQ5MIxHwsIQwUoT7iIyiRysfKpgOlMn0CGmVUIbbndt66XWn78
	Ld/ZqN2D9T3ENb9XSmcHzMm8H7+bbfRix+XGlktxJ/Je+OGnsXNMPbW7zoIEe9FoNzmfZWwqitM
	awgluf45dmOQPui1KB1A53BjT5IFDVne+stxd86s84CxxBj4uJV4RSSO2Ltwcnr1cxMYlNVpu0g
	pk2Xa5oq8WziUJAF24dpdgsSvN6lhpMHkIlh4Bwp7/+2n10GtkQRmDovOrz0JWz34RRfweK70Sl
	DiXk+olwiXM0MRvdjYwCSt8HxEnSKdE2lqASv14QZv8Lcmam8Q==
X-Received: by 2002:a17:902:d2c6:b0:216:2426:767f with SMTP id d9443c01a7336-21a83ffc1f1mr362870585ad.49.1736813185630;
        Mon, 13 Jan 2025 16:06:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFOJq7QCju1bWdgGa50MldRyGj9kA62UD2hyG+Sdq9KUeBR7F8PwyNHHgpukfp2QRN18L3Iw==
X-Received: by 2002:a17:902:d2c6:b0:216:2426:767f with SMTP id d9443c01a7336-21a83ffc1f1mr362870195ad.49.1736813185226;
        Mon, 13 Jan 2025 16:06:25 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21bbddsm58060835ad.130.2025.01.13.16.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 16:06:24 -0800 (PST)
Message-ID: <dad05b94-05f7-4aa9-8271-d74dd743a748@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 16:06:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] wifi: ath12k: Factory test mode support
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250110111845.2920741-1-quic_aarasahu@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250110111845.2920741-1-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cjICCv1Pwqfx6yO-HG28gFYQyIUtsopz
X-Proofpoint-ORIG-GUID: cjICCv1Pwqfx6yO-HG28gFYQyIUtsopz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130189

On 1/10/2025 3:18 AM, Aaradhana Sahu wrote:
> Device is booted in factory test mode for calibration.
> The commands are sent from userspace application, which
> is sent to firmware using wmi commands. Firmware sends
> the response to driver as wmi events and driver sends
> these events to the application via netlink message.
> 
> Also added changes related to correct pdev id access for
> fw test cmd.
> 
> Aaradhana Sahu (5):
>   wifi: ath: create common testmode_i.h file for ath drivers
>   wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>   wifi: ath12k: add factory test mode support
>   wifi: ath12k: Fill pdev id for fw test cmd
>   wifi: ath12k: Disable MLO in Factory Test Mode
> 
> ---
> v8:
>   -Included change for assigning seg_hdr.pdev_id.
>   -Moved if block to start of ath12k_core_hw_group_set_mlo_capable()
> v7:
>   -Updated copyright
>   -Moved ath12k_ftm_check in ath12k_core_hw_group_set_mlo_capable()
> v6:
>   -Rebased on ToT
>   -Updated copyright
>   -Added patch[5/5]
> v5:
>   -Updated copyright
>   -Fixed line length within 90 char
> v4:
>   -Rebased on latest ToT
> v3:
>   -Rebased on latest ToT
>   -Updated Tested-on Tag
>   -Removed second parameter of ath12k_core_start()
>   -Updated copyright
> v2:
>   -Rebased on latest ath ToT
> ---
> 
>  drivers/net/wireless/ath/ath11k/testmode.c    |  80 ++--
>  drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>  drivers/net/wireless/ath/ath12k/core.c        |  30 +-
>  drivers/net/wireless/ath/ath12k/core.h        |  13 +-
>  drivers/net/wireless/ath/ath12k/debug.h       |   3 +-
>  drivers/net/wireless/ath/ath12k/dp.c          |   5 +-
>  drivers/net/wireless/ath/ath12k/mac.c         |  17 +-
>  drivers/net/wireless/ath/ath12k/pci.c         |   3 +-
>  drivers/net/wireless/ath/ath12k/testmode.c    | 395 ++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
>  drivers/net/wireless/ath/ath12k/wmi.c         |  41 +-
>  drivers/net/wireless/ath/ath12k/wmi.h         |  23 +-
>  drivers/net/wireless/ath/ath12k/wow.c         |   3 +-
>  .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
>  14 files changed, 623 insertions(+), 85 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>  rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
> 
> 
> base-commit: dbe50a7420e22954c747e79e72df2750d795ea77

I wanted to pull this into the pending branch, but it conflicts with a patch
already there. Can you rebase against ath/master-pending?


