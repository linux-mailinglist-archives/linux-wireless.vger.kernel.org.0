Return-Path: <linux-wireless+bounces-18632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FC8A2C2BF
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4557A6728
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3AA1E9B3E;
	Fri,  7 Feb 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UbHnSJNA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DB21E5B9F
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738931362; cv=none; b=Tu5A7Ac/u514lQKc3hGQYXyYWIeRgUANjMGwz3HHqELx7XiN/KPl65wjWzGZpKP17BUFjG0yhSWlu7IOm9qRkJ/9D+ZoSQoetdKfYqOKYUdyYM1xwqAW39TjN1QcEEcn9/9F0PqnK6oDaUS+1fv4Gj2ICyuri9ysxb0Vdvs/lZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738931362; c=relaxed/simple;
	bh=DVf2JLUrvY7Jl//PcUs2RaArPMW+N1ZbH+ZTGsq15aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5IMUtJ3EqV7qdZfF7pMiRypVPWRIFliC1kNG9dfyt9S6xKpTNybOpsFPb80hg8I04xPzkSOEAaNoAZgNkMAtzuTQU0XLrwQ7yRUwcXdua3UqX+MBvDSnesnIwQAT4exhN3oa2efv/oo2eQM1RrVswNp6wng6qd9+yhcfdhub3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UbHnSJNA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517B6Vxr016987
	for <linux-wireless@vger.kernel.org>; Fri, 7 Feb 2025 12:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p1ydYqdxUaQdR84ztrvdijLhSPF6ft9fgqrdmrqBnDg=; b=UbHnSJNAW/9Y4DMQ
	nKYHo3EeCnaJi4XId5b4lKFS7Tg4qdGs8x73nG+8EyDwE9HaVf6yxmLDEUYw90Ac
	eNk22Xi190dMKAVh2fcuSqWE/+vCMzHmedMDmFKeQSODIdfi/eHTq1p/Zqh6NOyh
	UYgxT/U7ni/mF/xK9JXxTRUwq3hWFCB+aW0Q1IoF5AWX3IsC419AfcMWsQBsmcPD
	0UbwSXsq9aA3W1XDIPZr1NFHm8t39JVUsXLc8je+jA4t8Y6t2UeaFsBAO/+I7Ysc
	grEaqR08w4aAHrVBuo3VJxyaZ8xLAXnpBr6E/jSGwnm67J4AtYEW/NIjlk7BpNTq
	t0nv4g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44nh0w06nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 12:29:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f5538a2356so4384468a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 04:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738931359; x=1739536159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1ydYqdxUaQdR84ztrvdijLhSPF6ft9fgqrdmrqBnDg=;
        b=TfvOeXG1HLlUSAmULI0E8w+HnfhfwA399sQkJ9W4gAMauAya1D3XXXywnt/FmRzXvk
         1POZg+RmY7ENLpHxUGlmkT9BI/2vr2eZ3XLRBORuMORveuIAbnI2fhRbsThpFdDKcwil
         4SJdW9DnjLb9QYAEm9jlE1YUpIK2YvA7+YscZFXYHRkH10qrWVPaK3eNbA7dyKASWMiG
         dRvfFFqtQhK8BcERLdDwzb3hvtBu6ZYvdQK2uvlxB8Ledqz2AjomYyAZy03SOR2MTqsq
         qTRKD/jORhI4IaG9/NV/0d8OBT+d1DJtXp82mp0vC9s2crHlvKG9iZL3WZWIHs5Wg0uL
         xBiQ==
X-Gm-Message-State: AOJu0Yy+On0dMnWucgjJOxkXYqSH8zJLoiNTRoReBJ3ZsBM+y5uI3OhT
	ZkXAT5OAdXhLAEk6WNl5Su0cDhLc+U4jd/uNaipzHgNGZN5UDDoeZgR+5tmbh9mjaSXjvHTJBzR
	wF1PoUzhXzhKfmvSyLEJUhbiH6ZJfs9AdwmkebkgZ6KwU2P/9cC/6CqoA9vz+VRKfKFtmMO501Q
	==
X-Gm-Gg: ASbGncs0AkSgsrBsOBGsWu8JJ1ajE717nHbRvGzrBp1Y1qmA31lEXnldg6JDsb8h82M
	Va9f+8n4CXX58CNpYwzsWxgX7CHnR4DqHpp25+E9MYdbVp8t8fkulHNK2+x8TiLcn6d7Ramc/Rp
	V7T1rLvGkKdIbl+mK4hbR02w6ETNiWFD6xbWeOSj/nGShV/U/p+yhuM2HEYCKF0siajCUd16NPM
	ZfFF8T3dUq8ghNp0WPL9CcpmXEJifg+uP8ATscq/LR8HgTbHVpcNTtABNGEsPYG54bo3QXjfejQ
	aNPawipbSJOE09zwl4FlCkV55lwIn83h2Ne0pnvdwSwqVlg4X98BhA==
X-Received: by 2002:a17:90b:4b0b:b0:2ee:c04a:4276 with SMTP id 98e67ed59e1d1-2fa23f550d5mr3969759a91.5.1738931359203;
        Fri, 07 Feb 2025 04:29:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMxgmlLbEWVbPgyaes/sOvd2b2YCpqqs/A9FAGdUJJ5nIjSP5Nr+2vmEqU0y759wPN5Y7OMQ==
X-Received: by 2002:a17:90b:4b0b:b0:2ee:c04a:4276 with SMTP id 98e67ed59e1d1-2fa23f550d5mr3969729a91.5.1738931358769;
        Fri, 07 Feb 2025 04:29:18 -0800 (PST)
Received: from [192.168.225.142] ([157.48.120.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09b3e83esm3196336a91.38.2025.02.07.04.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 04:29:18 -0800 (PST)
Message-ID: <206a56d7-af6e-4fd5-c51f-43e38cdcdd19@oss.qualcomm.com>
Date: Fri, 7 Feb 2025 17:59:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] wifi: ath12k: Remove dependency on
 single_chip_mlo_support for mlo_capable flag
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250207050327.360987-1-quic_aarasahu@quicinc.com>
 <20250207050327.360987-3-quic_aarasahu@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250207050327.360987-3-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FoR8c7FVHpFyOW_kjYrgggreU9B3Tu04
X-Proofpoint-ORIG-GUID: FoR8c7FVHpFyOW_kjYrgggreU9B3Tu04
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=798 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070096



On 2/7/2025 10:33 AM, Aaradhana Sahu wrote:
> The mlo_capable flag in structure ath12k_hw_group indicate that a device
> is capable of operating in multi-link mode. Currently this is enabled
> based on single_chip_mlo_support advertised by the firmware within
> ath12k_qmi_phy_cap_send().
> 
> Since the firmware advertises multi-link operation (MLO) support through
> the ATH12K_FW_FEATURE_MLO feature in firmware-2.bin, there is no need to
> rely on the QMI phy capability (single_chip_mlo_support). Therefore remove
> the dependency on single_chip_mlo_support to set mlo_capable flag.
> 
> Below is the impact on single split-phy PCI device with and without this
> patch:
> 
> Note: This patch does not change the existing behavior of the single
> split-phy PCI device.
> 
> 1. Driver without this patch + firmware with single_chip_mlo_support
>      as false: MLO is not enabled.
> 2. Driver without this patch + firmware with single_chip_mlo_support
>      as true: MLO works fine.
> 3. Driver with this patch + firmware with single_chip_mlo_support as
>      false: MLO is not enabled.
> 4. Driver with this patch + firmware with single_chip_mlo_support as
>      true: MLO works fine.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>


Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

