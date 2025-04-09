Return-Path: <linux-wireless+bounces-21308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D625A81E44
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 09:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318474613C1
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 07:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5EE259CB8;
	Wed,  9 Apr 2025 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gPPIi7VD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3927F1A7262
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183700; cv=none; b=RizUBB3srI/fhU6Xfc1yLtJ6DPEv9kNqXI8zgAu/IuRPXQ0x9AyTSsL8Oc1Onoxs01jY7NxyG5ekSObROfPejR+9PbeULWyXPoFAC9Z0OGopmxEqVR+IdrM0NnKOLy+kPUoBrF48waqkSELAnOIBk4oujAgfFOu7f/apYvsYRTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183700; c=relaxed/simple;
	bh=/Rfg3nwZxjufFgHPZpNG+Me7xz/eLZD2GZ5A4rBVv2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J63B2IJCngAtjwzvZhvkCydqGFqL3lAWnmYWTuPxpQeKudlko4ggtv/Vh71v/+dxI3waq9Z9qAFoZUSISID6raC9SC6lJi81rw3K2UsDXqqo2w8XyX1j3jEPdzM/QQcfD75nQY8K7+uZQpQ/gtVsoM23ZlHID4SO+Tb/lKV/1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gPPIi7VD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYveE015731
	for <linux-wireless@vger.kernel.org>; Wed, 9 Apr 2025 07:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vdRg2WZJaSV+G3gYMD9b8c8M4t/mejGstBus0eqmC24=; b=gPPIi7VDx1VioIYl
	Rgx6ihiXSYb2sxx97kukHTzweWy00TjeTnroVQrHeSAdasb9WkzxCc+1aw5diHVz
	i1FoEruCjAx00KmB3wsq8dhgimprymbW73MZhUxtT0C5sxU/UrzfhTR7FgYTrnvg
	972kkAxYyNxlV8nYv9bJ747IDklIb6MxWsERJ5kVtwkQI7XwPoZr0fA53z1tqThj
	uROWt1R8GqZiRZQU+dfYEaIP/y56jWqslhJB/Xo2v2FuGC0hnELKzZOyIyDfjhYP
	yWDRBs2Aug1sU0lSRHlkPnB4f2DYvymlzpellnQX5LWcUUJ/g8fLpSAfb3gcuW2h
	VAGtIg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2tf79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 07:28:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2241ae15dcbso75951205ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 00:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744183697; x=1744788497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdRg2WZJaSV+G3gYMD9b8c8M4t/mejGstBus0eqmC24=;
        b=sG63tNS259UhS3NZ8wdSAJsr2cPrPTi5lLvmgaUbV2F52prKL+NRB+aHYjEeFsryl2
         6+N5FG/KVyJXK0jHjte/5vQ4W/yrqdWcjT9LDujtltqQf9ALaNQeyftyrtWxWVV5C9Cv
         MJ+1vytg7S/nGiCxF6iW/w6akX2YJ1fSISH9iYcEYhqr+L974+32NDVmt3Crnakoby5S
         OL8XFlyNh9lU6A36Fgq/eDCD9FYuk2LHXyiuvgLSs9bu8yaE7xH9Behm2JaBXfApdPUq
         wwUHZrn+BYWTDXyeV72G677dsnmT4TVpwiUM8W83mGHnVenV0MtPSE8uNZ1+KsO9Dpfd
         fyHQ==
X-Gm-Message-State: AOJu0YwwMx8ykwtEvPMd6WeSVl97p1w7Co7bHaon9Xy1gTJNvnvYoHRB
	4g0D0s4MZQz2tocMldL6HQkJllq/Q9KdHaFDErhYrt9k/VoM44sccyOrSFBOTddoIU3ir7Ydrmp
	hOGwS0eCRofVQ0sJPHgtIYzacZ5HeH4meJ2MQj/RNJjK4kukckodkUYkdN14UvjFw6g==
X-Gm-Gg: ASbGncuKB6hNTsZjynr0tsASJif0ZQ+uiHvN7LVel0FFbXKSaV6a3t9x19Ko5OFuhCN
	bFJC3ZqSVpjdt9f8csqoUXW824F+T9RuAl3RXbwcGEZq2QlL+So7feiHIPmOd47n8rkzqrwwaFS
	zSADWRH7oGx5JwPHtBCrI2P7UkuudsizvrVfA0r6RRdC3QAl2rMlDXN1VW06BfMxJ8/ogyy0nym
	H5qtXj16Fdirj3wHUY3OB7qULvWEBDO0401VL4SU/Q8xGbDk31QZ0cA0oXmtv1RGsQyft2/l+JE
	KPCc4jV7EOyKSxYQmJ7TsBn6x7lTkpB/QyCWq4WPLp8fQlRvoijeIA==
X-Received: by 2002:a17:902:ccc9:b0:224:255b:c92e with SMTP id d9443c01a7336-22ac3f2db39mr23747365ad.3.1744183697256;
        Wed, 09 Apr 2025 00:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyPWcXw2pW4F3zG9g2x1upc4P+xWNuWYHU/j4YdWOlZ05n9OFYdxS/3HwW187PAKJikXobPQ==
X-Received: by 2002:a17:902:ccc9:b0:224:255b:c92e with SMTP id d9443c01a7336-22ac3f2db39mr23747125ad.3.1744183696876;
        Wed, 09 Apr 2025 00:28:16 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d4677asm629295b3a.55.2025.04.09.00.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 00:28:16 -0700 (PDT)
Message-ID: <94bfb5b1-6a24-9d70-9f35-1fdbfa1a113c@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 12:58:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 1/2] wifi: ath12k: Resolve multicast packet drop
 by populating key_cipher in ath12k_install_key()
Content-Language: en-US
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250403082207.3323938-1-aaradhana.sahu@oss.qualcomm.com>
 <20250403082207.3323938-2-aaradhana.sahu@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250403082207.3323938-2-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hivgnTBP5d3GcrnrXZ_TVkcPl0Q_f9Vh
X-Proofpoint-GUID: hivgnTBP5d3GcrnrXZ_TVkcPl0Q_f9Vh
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f62192 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=YvOhKeZPiAD0BIR_EI8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=860 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090033



On 4/3/2025 1:52 PM, Aaradhana Sahu wrote:
> Currently, the key_cipher in the ath12k_vif structure, which represents the
> group cipher of the MLD AP, is populated when the link address matches the
> ieee80211_vif address within ath12k_install_key().
> 
> However, in MLD AP, the link address and ieee80211_vif address can differ.
> Due to this key_cipher is not populated and multicast packets don't get the
> correct cipher information and resulting multicast packets drop.
> 
> To fix this, compare the link address with the arvif->bssid instead of the
> ieee80211_vif address.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 3dd2c68f206ef ("wifi: ath12k: prepare vif data structure for MLO handling")
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

