Return-Path: <linux-wireless+bounces-19837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CB4A5417A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 04:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6703AB652
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 03:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA6C19CCEA;
	Thu,  6 Mar 2025 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WebLRMYi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAA7EF09
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 03:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741233292; cv=none; b=jVtIiC0OUT7myYxCyCY369o4Dxz/Vnbkub1KgOop4p5MKMnwQHYXt/SApxXTpHqAhlu37vU433S7SVIXBVJweLAEG3NftP17eLZBgm4xg51rPDUj3jsoeaJVdTz5YJyC6J8WgB1SZt57yop9qFWCsmR4pDZW5HCf8T36rIxxWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741233292; c=relaxed/simple;
	bh=gK6PoeLsGO+Auc46xWPQ8Vw6lIha/f1al2HF/4g9bLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9FlDb+hXKBIVRqBMq87fivSrkmDUsuCdo+ZSWuXiYw60kGjZCG2rctZhquabPgE7p6LKno6z8L6LfC9e8NS1dCf6/0Rf8WuuKIDZeIazAfsub7OEc1DH7iBe/Qge63R8ptTlCh64DiubA/h/4dXesG/CB4hg8JgpaxgltIqAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WebLRMYi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525Kwjhp023685
	for <linux-wireless@vger.kernel.org>; Thu, 6 Mar 2025 03:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VMj+XM3Z7JH4+lFd4b2GenYlhhOZHTCBQd8J2A+tk1w=; b=WebLRMYitnfl+Si4
	FxnOil3mxGXKTb6d+s9nWOzg9pwMBNmAkbyYJFdcfWhtvkBC5I2HQiBsTy7Bei29
	VDeE/M7QOlJT5zzwacaQOVfgCx2wKDpI1x/IP5rjYwMMKT2jXMweeZB7KHr18YS0
	1bF6aVoC+Xe75pKeeVPJn/IeY96sWBLAgEmBVrJcrCiivFM9Nd/8ktPr2PeKMIxw
	IRY8jwMacGhUGpjh/gL+NrGk3nCJMye0MiimmMg6C+vvnnwBKKLqIga4xGmW0ewS
	0O6WVMoSC0lgQjRjx1vBPGGnYNQPFbvotpkv3AhFxQgIIcHWHL7flqFzMmDMypdJ
	IM77dw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t7pkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 03:54:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2235a1f8aadso3966305ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 05 Mar 2025 19:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741233288; x=1741838088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMj+XM3Z7JH4+lFd4b2GenYlhhOZHTCBQd8J2A+tk1w=;
        b=nSW5vcxIZSPMjd9+978OZRW1KFS2xSmXseIAh0XcraBtcuUMHQIEPfgC2pkGrqFLm5
         UrrNecxjYZtwc9Ax16fRl4DjZIl4L5MRJ2xEUZVU9WhS3bDwUW6lY5NFUGCwu59mDepF
         pDViu1EQf+tY5AiKO1ar830PTP+C134bbYMi8ZbvP/+7vGKVeN0FI5mX688BWNCA1SR9
         WHBTG86ivRhJuY0AmtK1H66jnLomVtZaoSjwRvfvSzcVyt4t7iWV7AQpKtgQWANt2o4S
         Zhw4OGWVsJYGKA3xlfWM2BobWBQPK7vwjamwRtqYVb7PBgOXcMyfPLSTrhDO1uUxBv2W
         ihvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCujogdFZYGggdNND0IjlzFkxUkClotW39CBMuUYZ3mJH4tCtXZuOALfhhk5jd9pgja00kHL/x1vsc1Yfi+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8e/OlDf3AnOexxJ38b0hyJReTo/i5nT7RGXUH3kTsL0OGlmP
	7+jGZdrEy2BZfa7x11DIvrGCVIlXjLV3BMPM4owCefamj0E/diknXIw7CgaCN/OxyC3zqDmt9Mh
	WlT1XZGlMtr6yM4lUg1wL/490HInS41XbXfWZzpTpMEcqMqmHvwlKJXIVZncVTrnTyA==
X-Gm-Gg: ASbGnctPPGC9jw9uqHMdvRDGvZXdsVTD4EzA7ZkOIITljG9NPjczGoK0Xj1+zC0orhW
	bR3gnZFKkbghSydrDzxPUhYbkImfTvqBBYPIGmSfwWPnyenjXgP9OHpKsDYGe8PelhyVy9lsSgr
	t4zohHbZXwsKGYG7ZGAarN9B85vns3FBLHcWqWsScPpo43l3ItKlcZEz7om/WzjfcrP4ZKdQq26
	OOVZX7siVRnOvSgTeaD0zQGZ91iqeW1phpVoD0H1pqYjpG7HNjFYj+Z0KX4JlWIS3ybi6jFQVXE
	NPvfeOTO5njOP3QFKwAVac+80IWcYu3jGQotYxCrPq1r1IZGT13977dKtw==
X-Received: by 2002:a17:902:ec90:b0:221:7343:80f5 with SMTP id d9443c01a7336-223f1d8430bmr93073245ad.53.1741233288036;
        Wed, 05 Mar 2025 19:54:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrogsGcvQe4xJVpBUgNzk/PrC3/Ys140YEy4yJBQknm/w4HVahaHFJ7/Au++I8Of0gIUxgkg==
X-Received: by 2002:a17:902:ec90:b0:221:7343:80f5 with SMTP id d9443c01a7336-223f1d8430bmr93072865ad.53.1741233287636;
        Wed, 05 Mar 2025 19:54:47 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f7fasm2054525ad.115.2025.03.05.19.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 19:54:47 -0800 (PST)
Message-ID: <4ed9eebf-3470-0cdc-498f-ec4811b909a4@oss.qualcomm.com>
Date: Thu, 6 Mar 2025 09:24:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v9 13/13] wifi: ath12k: enable ath12k AHB support
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20250305185501.2400888-1-quic_rajkbhag@quicinc.com>
 <20250305185501.2400888-14-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250305185501.2400888-14-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I/ufRMgg c=1 sm=1 tr=0 ts=67c91c89 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=w_ZfqNI5J2udKohul8UA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6Cv6__7hiSzBrPoeeQ81zYC1-Uy0Hw0q
X-Proofpoint-ORIG-GUID: 6Cv6__7hiSzBrPoeeQ81zYC1-Uy0Hw0q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_02,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=719 impostorscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060025



On 3/6/2025 12:25 AM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Currently only PCI devices are supported in Ath12k driver. Refactor
> Ath12k module_init and module_exit to include Ath12k AHB support.
> 
> Add Ath12k AHB support in Kconfig with dependency on Remoteproc
> driver. Ath12k AHB support relies on remoteproc driver for firmware
> download, power up/down etc.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

