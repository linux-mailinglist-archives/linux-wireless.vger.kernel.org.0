Return-Path: <linux-wireless+bounces-15941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ADE9E60AB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 23:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0198F2810D2
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 22:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96717E019;
	Thu,  5 Dec 2024 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JRR7eB5P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF7D1CBEA4
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437965; cv=none; b=sAXECz1ko2FegCH7vtWRxgMpn1kWgLFjYLDgUv6s2Wm7wqY6K82AB112Y6/j6MYO5LsLr7FiEb2rW6g9qqVASZ1hNiHhs9LMEwBU4fjmVaZdLJWCFpBsDrD+ou3KQJpfcyu4ZVC7MROlr08v/KfZbMXaEC3MAvrsxJF/MJTYqvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437965; c=relaxed/simple;
	bh=g7u1afjnFSCp7ivjMCXlkWBvT0u/i4Rs1av0EERxVu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7hloJwU05X6UHGBKeZG+iYbZUSdpvMefX/sGIyb/xCk5dw+4AVJpoTaIRjRRYF155FR3oVdLJ0SqhEsyQOmWUq6w2s4UbYPQsgCgy2EVmiw7hgB4Xg2+JKkPsQiNSF9pNVE+hIHpapj5VWJO5Kxq06nz9mjykueDj5Zk2tar34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JRR7eB5P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5HaOqs004679
	for <linux-wireless@vger.kernel.org>; Thu, 5 Dec 2024 22:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0e1bTbhjTFtuWpEFbKoBhTRv3CFncrtzX/YC5Pf9ppk=; b=JRR7eB5PmCwtL/0p
	23DBVlC9Fj3fmY4LKZvIxro1BRMeTz/tTwYck5BasMiruuFuEOfVgxpvbjQQ5EvG
	t8d0PXmyf1ug2cv+gcqeqP/0smuE87dE8eu/RAHXS0ZwQNZgbsTNJxSgNyeoN+m+
	eC9IzvmAeHU9s7YD8sstZVTMXJ2RcClLKjdL8qt+i5QKUI1qbyOXB0tK3i9rcEhJ
	gnoQyKGSXpq31uFdsm4KeWRlbDkYidn+RyXqlwCW1hJUuKquivzpBqfFgdP1ELDm
	UuyKIiYO70/wz39I6infcLCluSUuN/ciU5uXx/K82kBzLlCEo1WbcfD2dHhg+qTC
	9eP90w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ba141vwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Dec 2024 22:32:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-215b1900fc4so13258555ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Dec 2024 14:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733437960; x=1734042760;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0e1bTbhjTFtuWpEFbKoBhTRv3CFncrtzX/YC5Pf9ppk=;
        b=xDDFcin9dGQmhCDrJaR/Q4FX/xF9KmQipzgZgZJPR8fWcbCrprI17fD1a6VHUYzKyJ
         W1NyMnaFE5YECKBlMcsYF8kqAZNBqUcKlQJfytLaQCnPpO8JkyOcbXLGMj3nzNdkbwGl
         79eNxSnNzRvdkDLi+8lleXBEjAr7PYdzSB25w8RwTHCbWiX0mEsuvuWSsNJuMIhAjjXD
         VNX9qe/vSpLU+W4Xo1X6IaT8UhRhA2q+6MYw7TqK38aU08TiySEE/D7NrgJKJSrdDjqa
         khfov0pbdY/Sv1Rav4fM0QrPHwVetUS1aIbfiXLufLkKkBrBhsUAVJXUPwQuCpKjkTDB
         Hm1w==
X-Gm-Message-State: AOJu0YzOWqmy+C6uCW25Pe5sNSWXtyZdHuicc101UeU7bMBvlKnkYOBp
	F5mTY5lBsWNIwnLWBrusvr686pZpYikwbDRGqU6xoA2gKtuw6eV9WtAUXIqjcRaEJ1wDmFrvIKg
	eXAxz5xWJVJpjtSTSOX/5pWVci7ip06hnevvafqj7QpGc+ZkRWjGunFGUpDOMV1Km2kxgcSMdxg
	==
X-Gm-Gg: ASbGncs88gad+l0TNVocSAORgfm8KFnLWxOJFlTFJbArvmdqTN3Nku4N16r1CFcDdWL
	d2/pJ5aXKsoYsA42RrDL4Pkukif1jz8NP1lQiIZW8hqIvAhspctuD9Dmg6MhraIibS0KTfuDCSC
	uej1vbQNGSlHVW1WRCPlv63iNKvgOogcuxtlSGRtRUGRuEaHY9hsqJlstfCwKosx22Ot+SN8uAN
	hh4VKuVxDTAd03qLi3xehNWfp5kTu5jgsfUPfnwRxjzyHV9om+TBg5/HiPMo/kYCPUWds9ET2qQ
	KhsAG1gYkCgXHhNi2mi0lGrnTh1lCVMfK/FCNfkNQLc=
X-Received: by 2002:a17:902:dace:b0:215:a81b:c182 with SMTP id d9443c01a7336-21614d1f66fmr9072925ad.10.1733437960194;
        Thu, 05 Dec 2024 14:32:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+w9ugOjksQ0jD0qhmABqfm+EgIpCZBAlIbqh/xwne5sVCEYcKQ0/MYVNEstfHDR1DJHkB5A==
X-Received: by 2002:a17:902:dace:b0:215:a81b:c182 with SMTP id d9443c01a7336-21614d1f66fmr9072655ad.10.1733437959827;
        Thu, 05 Dec 2024 14:32:39 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21614df8dc6sm1323715ad.65.2024.12.05.14.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 14:32:39 -0800 (PST)
Message-ID: <88e0116c-778f-4861-8751-b30a09d3d2b4@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 14:32:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] wifi: ath12k: rename mlo_capable_flags to
 single_chip_mlo_supp
To: Kalle Valo <kvalo@kernel.org>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20241204163216.433795-1-kvalo@kernel.org>
 <20241204163216.433795-3-kvalo@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241204163216.433795-3-kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mF7vvW8m9uAEOTbbyl5ztl0XvzF_8G8r
X-Proofpoint-ORIG-GUID: mF7vvW8m9uAEOTbbyl5ztl0XvzF_8G8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050166

On 12/4/2024 8:32 AM, Kalle Valo wrote:
> From: Aditya Kumar Singh <quic_adisi@quicinc.com>
> 
> At present, the mlo_capable_flags in ath12k_base is used to indicate whether
> the chip supports inter (QCN9274) or intra (WCN7850) chip MLO. However, it’s
> possible that the chip supports neither, especially with older firmware
> versions. Additionally, if intra chip MLO is not supported, inter chip MLO will
> also be non-functional. Therefore, having two separate flags for this is
> unnecessary.
> 
> Therefore, rename this flag to single_chip_mlo_supp. At the same time convert
> it into a bool data type. Also, get rid of the enums defined earlier.
> 
> For the QCN9274 family of chipsets, this will be set only when firmware
> advertises the support during the QMI exchange.
> 
> For the WCN7850 family of chipsets, since the event is not supported,
> assumption is made that single chip MLO is supported.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Kalle, this patch is missing your SOB.
Please reply with the tag and I'll fix in 'pending'

> ---



