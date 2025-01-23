Return-Path: <linux-wireless+bounces-17872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BEEA1AAE8
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 21:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671F97A17C3
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 20:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83CF18872D;
	Thu, 23 Jan 2025 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZnXs6VbG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E11ADC73
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663078; cv=none; b=LsnhG552MkY4Nq6tH7YwfUdAIkVkryW2Mz05NxFliQnXTKYYshaUJ58K0A4IcfPAjQRQR/l2Lb58Kh3d8nHXrJlOF8nCEOsGsh+il7GIa5017zyqZ+ndRSrIIyauw/RnrsSFzyt1TSaUf3jeLQFn/r9s0E3MSBNUryAa7B2C4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663078; c=relaxed/simple;
	bh=JX9ZrBMPqJUxgUVTK4WCNTypAWYcqwW2Z00P9ip6734=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IelHPIBviT5od62G9I6FYudciMaR3E5DKzm3uLtRa0fJBNJ64LMMFFgtQJymWut7EGanYwv2Dgu+eBI7v+57OD51YHmaq1LYXHJojM6K6D5ckckcgJv/4bTQjT0pUkzhs5SEikQyAfim4BICFL4YhG/1JAe0+Vmc7OmT4BgCnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZnXs6VbG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NFoRHj021301
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 20:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KHvSd1WT3SBkG9tz2wQb2UbWB64CD0js5I+DnfBw1Hc=; b=ZnXs6VbGViuqi7E1
	rrxkSp8hZSJgg2AocP2sknSnJ3qwe5g5O9wAIx4o85rHI850Gz1VY1YQgdI/ifGn
	PhIytD4zMnqF9p7uswkk6wlyh0o/YOnBvzoBj2s7Zmbgrw0DsinSMK1dol8TBA4r
	Hmx+Xuo260cA6C/P/thC9t70wz3Mad/1zNVfldzC++5V9X32gtiMhTtni44P9P2r
	yayzEejOJ25Y30l2viq0f4zIfSY50JfvLSvLLk+kC2CDcbgOsjPu0843ezkchlkW
	9UVUbFqUeGBgobjYj6jRS7Dvu/Zdm2LY2ifnx7QT7GS4LtN4SITroGqyvlsTTNwj
	SwKeAg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44brs0gjvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 20:11:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216717543b7so33117015ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 12:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737663075; x=1738267875;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHvSd1WT3SBkG9tz2wQb2UbWB64CD0js5I+DnfBw1Hc=;
        b=lDag5JDSACc+w5FiMKMLP6W4sWpCQEdna9PNsIkEVlLpyK8uU6xeXd44SazoGWlBh4
         3xpRJA/RZxUOni2P1A91nx0Xu6O4Qu0G4ZSkjYbJGOd8otlG3YG5sUjMeCTFZP2DOCN+
         H1BHTse1dwGdLGbikpw96P6mpHCeK1Zr+jSxMNNmGM8X9XKhs1lZySMYwD3kk4511AQO
         l0repX9Nbz9613H/WtimFxcWXm7Upn8czeza0H+DzNGH1I94LkQi7RTzmg/SJq7Ec7TQ
         a3JG/64pUklVmut8hHYDXJqlQX+xsa1an4/1+fPNRF6uZI5P1LAS/owsOPlwS8Zs4hZl
         VwjA==
X-Gm-Message-State: AOJu0Yw3rkRJq4dl8Y9XIuf9jfJQruzSYvU8rG/ExkiXRmHiWQXlGZXT
	pYI7kcVSG3gSKO8tvrj6EhhZxwDGPGMVJMS6b8yyhJacTLOYQBvBP5UyFQHi6CIx8jp/CiKvl+L
	kmSRGN6dr/8Wg9hg4ldfhpbb6ZLqn5FZJBHsmREcsdO7q9FP/B5V1jzEJ/RQWUeWjGjvrXuIymw
	==
X-Gm-Gg: ASbGnctz1zk03Ep4vFNl/sGHVj2fnVplnJd83KRi6Tdm+n3tRlpTTft4L1pqOCFUFfS
	d32ZnHTraHhHMa0UR2K8QCc8hyOaQt4JoK1B0o7ijanNacEg3EU3zYwZETTpXhx097IEia/CYda
	Yk8SvQDr+kK376Vfe4qTPh0aoMGu8FOkkEdnlCOn4xHlWVSbhpLrubsCSZdtE0Nl7iWFg+cpbaZ
	gSkRZkhI3RM0dWwLWiC76GFo1/8DXoDKdXn5G1vpXu6B/aVBiQbvJuNmoAE5co4YHLGei9U+KfS
	JNcbp9K/vqOiBqh9y7zYhNmZQrimqItj2HbE8whzmmOF8IJ2zv5/2O1YCytxVuY=
X-Received: by 2002:a17:902:d4d2:b0:215:620f:8de4 with SMTP id d9443c01a7336-21c352de109mr426076345ad.2.1737663074785;
        Thu, 23 Jan 2025 12:11:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDxKcJEKy6x66XnF0OrNGHZ2Y0FB/BHCUKMrM/Y50SzSlM4B/qgSrvMNHPA2HcDQe/GBAZPQ==
X-Received: by 2002:a17:902:d4d2:b0:215:620f:8de4 with SMTP id d9443c01a7336-21c352de109mr426075965ad.2.1737663074321;
        Thu, 23 Jan 2025 12:11:14 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414edb3sm2861555ad.202.2025.01.23.12.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 12:11:14 -0800 (PST)
Message-ID: <076fa04b-b2e4-4831-86a9-bff21b8dc5fb@oss.qualcomm.com>
Date: Thu, 23 Jan 2025 12:11:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] wifi: ath12k: report station mode signal strength
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250115063537.35797-1-quic_lingbok@quicinc.com>
 <20250115063537.35797-4-quic_lingbok@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250115063537.35797-4-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ch85kcfJsTu8P0xK2HU29f7RtLhdOfFB
X-Proofpoint-GUID: Ch85kcfJsTu8P0xK2HU29f7RtLhdOfFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230146

On 1/14/2025 10:35 PM, Lingbo Kong wrote:
> Currently, the signal strength of "iw dev xxx station dump" always show an
> invalid value.
> 
> This is because signal strength is only set in ath12k_mgmt_rx_event()
> function, and not set for received data packet. So, change to get signal
> from firmware and report to mac80211.
> 
> After that, "iw dev xxx station dump" show the correct signal strength.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  36 ms
>         rx bytes:       61571
>         rx packets:     336
>         tx bytes:       28204
>         tx packets:     205
>         tx retries:     49
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      83
>         rx drop misc:   66
>         signal:         -24 dBm
>         beacon signal avg:      -22 dBm
> 
> For WCN7850, the firmware supports db2dbm, so not need to add noise floor.
> For QCN9274, the firmware not support db2dbm, so need to add noise floor.
> 
> This patch affects the station mode of WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

FYI this patch did not apply cleanly to ath/main

* Applying v10_20250115_quic_lingbok_wifi_ath12k_report_station_mode_stats.mbx 
Applying: wifi: ath12k: report station mode transmit rate
Applying: wifi: ath12k: report station mode receive rate for IEEE 802.11be
Applying: wifi: ath12k: report station mode signal strength
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
Patch failed at 0003 wifi: ath12k: report station mode signal strength

My trivial fixup in the pending branch:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=a94d6e4db20fa42180d576207de8d5e2f5533823

