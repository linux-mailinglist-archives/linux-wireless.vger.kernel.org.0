Return-Path: <linux-wireless+bounces-20740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ECFA6D50F
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 08:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C1616B271
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 07:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12BC1DE3AD;
	Mon, 24 Mar 2025 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cnWdNtdS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1718D65E
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801176; cv=none; b=hBz0D/+tZ4bsxTdjCGDPO73DHUIk0QL2zwnZpj0h0HXsda9G+Rl4baQ+Vx4VKfVP/vSEqEQgzFHax+pysnUEfr0XT48WmYjfH3eyjp+x4QMTp4CRGL2bKctMsc0+oSx8uso1PCBJqIcQ85hU1UhbfRErHH562JkeBFQbc47llB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801176; c=relaxed/simple;
	bh=VUSpqpmOLf3nFPtgNXkhEgYQD8R3nFy+ZdiXVF2gJ04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkdhR4BVO/3GZeZbLImKHtrJCki3r5p6kZoesigKBw2Seu6Q8YX03//TK3BmpUCW5q0pFKjlzXMCFdQu+sJ14piC+CP6IwQQS8tmO5CHBXi2ScwNrlOsqAmy0S4UkGrqnqH0B32apMcJSXKC+nY/QkS1Q9PMgT3nyrlNSGL0C9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cnWdNtdS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6c26p026220
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 07:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lR5ea+C2yLZfOeE/kBJES7M3KF97P1A35OVYH5oVxns=; b=cnWdNtdSQYIbD214
	bzLpuHNqZ5XmHjAW/gLIo0zgtHnw6ZwyUW1C/kodpvFJyZmF04Me5OQ3YPxqbrQa
	t0lpRIKCFoxa02SNu9g/iEnWgrBL4twq4nRfAxsD6Tmt+PjRxBvuelGEIAu7eez/
	GPxDw1b/9ZbpQraIJsZYTjR6/56zeI5HRrrmTz7LRoUZeau8mwGNdcR/KBorxK0Y
	2Gzu2UmH5kWVckb4yHaRPnGk9ShnF/g1//iZDWChogcRRmFRLB1XgWbTnyBYx++N
	j7yV8fseHxPWbAIYoMGa65hgo7U2yQ/iN97T6lN6kZmRBpgq9ab6aCBW+H+O4RGo
	VMVgNQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79kh6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 07:26:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso11056580a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 00:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742801172; x=1743405972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lR5ea+C2yLZfOeE/kBJES7M3KF97P1A35OVYH5oVxns=;
        b=vIrmpjxM585AIw0qbEPL8AL/6aZaR4Tv0rryWEKfDEJwV9VdHuV+KvRjYgAk1yYCUu
         RWr/owl8Faouq+9mt1YFopxlXkAMNb0IUb389jcjLuJhXmSDxQiC3mYN87VHUQl9Erpg
         TtCrARaVQ7AYu7yzrBq7aKVyFaIwqRwbe8ERDGLRzsb4Vq7P1cVHDwiPPSgzcAJxehwc
         epgiB9owV+KvysF2pP/+x6TGRxTZkaxLH5mrErGyudRtO591d93ZMX5kGD+CuNuWf7jY
         O1t+o4jky58atVXPVwtyPWSAwQSNJKKQfDAitqs1kPV7/4wiMbO3N0GM8/SVR4aparAS
         TXjA==
X-Gm-Message-State: AOJu0YyHBv6bre+C+p/6PurouzPniEXMo6CDrxZRxeP+DoIiteZrLAx1
	pvyHbOAsM4yY6loLHhtbTqoXl0pXjxVLP1cmjZIAA/UFtnlQZI8CWbF50GLV9PFKWWgEdBuPXYR
	vk94c0fyI27PWZJ+MkDjmwOEuRxyE92VNCr8I/jxaHhn1K+9M3H17JoKCDGKeoQ7hUg==
X-Gm-Gg: ASbGnctPrF6l6ui/FaSOo2uMINrVakWJSYDDnKl8CPSHnQg5MNf80o+zJvJMW1IB6ev
	/5xLFtNZ5jhhAusKeaUsmk+oJ3mdO3/CmKEne1onpef5IGcLjS0G+NnhsjTAFJC/baU2+LiUr71
	8B1AEiAz7HMS60PdkmJcOQj1SMbdZtC80A/4ZfSNzEDxPsxIHhJ9OvR4568fPDmd2cTG+EpJTA2
	XG4kk9TpD/gK4It8FVkIo0Y8SZXqrZfpuJ7LMk4Cix3o3da6UrorWgAqtsk7+loR12CS2+ygvbx
	9d/WECcMe6XdbREL3hEIZjqcDPGUGx/J1MfVeqeLP/U2gs1FUPa4RRKYV9veVT0=
X-Received: by 2002:a17:90b:350f:b0:2ff:7c2d:6ff3 with SMTP id 98e67ed59e1d1-303100222fdmr17145929a91.35.1742801171736;
        Mon, 24 Mar 2025 00:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOux8H1C/P8FvbfQViLsF5tSDzG91ByVRPbahiDPOqTskebo61TG8MwkLo3FPddFwJrxCxDQ==
X-Received: by 2002:a17:90b:350f:b0:2ff:7c2d:6ff3 with SMTP id 98e67ed59e1d1-303100222fdmr17145900a91.35.1742801171205;
        Mon, 24 Mar 2025 00:26:11 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.235.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf589fbcsm11397233a91.12.2025.03.24.00.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 00:26:10 -0700 (PDT)
Message-ID: <5e293e8e-33d8-9a5a-0b32-929d2790b01a@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 12:56:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v11 10/10] wifi: ath12k: add monitor interface support on
 QCN9274
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <quic_ppranees@quicinc.com>
References: <20250324062518.2752822-1-quic_periyasa@quicinc.com>
 <20250324062518.2752822-11-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250324062518.2752822-11-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QWwXlXtxfOBa4wy98eAfnyKdhgNatrp6
X-Proofpoint-ORIG-GUID: QWwXlXtxfOBa4wy98eAfnyKdhgNatrp6
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67e10915 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=P3F+j+0UjHwaDtf4GQVMUw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xH0xcr9_mYJ7sMi6Wl4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=898 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240053



On 3/24/2025 11:55 AM, Karthikeyan Periyasamy wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> Currently, the monitor interface is not supported. To support the monitor
> interface, configure the monitor vdev state identifier, configure the HTT
> filter setup, subscribe the mac80211 NO_VIRTUAL_MONITOR feature, remove
> the VIRTUAL_MONITOR handler procedures since align to NO_VIRTUAL_MONITOR
> feature and prevent monitor interface to transmit packet. Therefore, add
> these procedures to add monitor interface support and enable the monitor
> interface support on the QCN9274 platform through the hardware parameter.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

