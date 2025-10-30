Return-Path: <linux-wireless+bounces-28414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E2C21BD8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 19:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 933BB4EB67F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91DC1A9FB4;
	Thu, 30 Oct 2025 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CsJLpYV6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d/RUqlv3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4838D1C695
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848235; cv=none; b=Gnw3Z2BWVz+SqvburtQWzZwEYNmN174zmqgia7dBWRmvXO+X3KB4By4zRqdcK0Q5kj2TIlAUfb4cxSk3dGiITLDRaflYP6EdGQFYjr/j/WONbmYM+prtHYUzImztm0NUC0yABXXiyJ1uC3G+sB/AZ+C8NY0IDlIphN/24TBOL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848235; c=relaxed/simple;
	bh=kg2axgcnpW6DqaCJznMnqgUT9/KOPAXong7uCAh4+yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWFBZKFrBGOaZRLCnHskFwp6YEYoRM7aE58bjDXLGa36kWeHd1JGS6h4WxtRJZ7jycEu3p80mARxC97kc0qYe+qCryOf2HakI12m2tBDRHHEHWDqHUeEW/jQPbsqgfKi13pZJ/wZ8eamRLPK3+23IKNRWUDfM8OFB8Dd1m4xn24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CsJLpYV6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d/RUqlv3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UI1f603509310
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 18:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ukOAiwegom4AE2DEzGWyvCrTZUu6l9n/cjr5gBCddxQ=; b=CsJLpYV65PXyyhOW
	stK5fWK5ToutD6M5bdb0sn6ErWtTB7MZ4ojsH8d/38UtqQPcujj7WVDgLmG/h07X
	8ybW1fOj7hXBQNDksBbJH0byMlxyoeGUK8JYBTh8gmL6Hwxrk5VYT6KtMP83e1f9
	9OmIKmq3+LalMUeLDd//R/quGXGmRoTxGQZHQFqNLHIA2cW448QBlp93+pRp3z9C
	AotsvEB7NQwCgNf4Hogb+oKi0vrdM0V5BhbgJDz2T2SSmY65UKyk9CK0O5ExPcDO
	o37aysexbFrO4aZhLYOh9i33xRTQ9TiRQ6Xwvdl4HqZ/iasEWXMsszVN9rR/D0St
	I2iCZA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45cdhhsg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 18:17:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26e4fcc744dso8822275ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761848233; x=1762453033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukOAiwegom4AE2DEzGWyvCrTZUu6l9n/cjr5gBCddxQ=;
        b=d/RUqlv3e1kRHwBR1eA8BsIVkaQaqisPX4cE6m5VN4wswe/KAKCp9coJx6iAdMZti3
         X4atolyjAwLPWxZ+GSOs33Vr7jf0cc+LtrLt87jh67dbAbLQZmyXxsnLiAg1vMJcNQ0S
         RyM0svEzYxOm01BGMXdPcmWwqIL9OxPYWSDq/+BaqZthMCqlgaFsKGG+EExHJmrcTlQB
         cFewzgkaJecBRMTb2omsivKGycRM7enALPcp8sd6yaXZour7qgTnjiO3SY4Xlr6iUEtq
         wWVb9IdthB/cf9egnbyzanfLabD0rhJwSLOdxNl8XLuFfgHlU0ocIt0KYYUM7kjuKwpM
         w14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848233; x=1762453033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukOAiwegom4AE2DEzGWyvCrTZUu6l9n/cjr5gBCddxQ=;
        b=HR+5flmbVMFTgVAq2wveWPeEfEgtqNG5ZF11MGpJWMKijt1pPKYrb6RFCl26RYYiPs
         5lHkwdrPRoTyQThctijgIXs0U3lVG9gheeRvnNW1OxIVXDHZmos3ngDNpszzIM3hIR/a
         mk9svDUSWwRy4dgvHXsNY7GGy2+cJN3fKuYj/4ykWISkcZI8rwlXPvIYxavynqZ4gEBx
         CFwBFoN+u24iYhYWsZfJivAs5AHyIh6Cb9b3tR6vlx4hTzP4h6prR+ScA6XAqvqTbbDj
         7p3rGkjp9csSO87ihcHopkiBb2Cac8PyB/6TZvWmkcN9aiEi36i0DkMjnyBulOppJ0p8
         RgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCy4YEjaz+LsfxS7Bm3iaacePzgkZ9VGb/YVo3JlK8MoXpXuz8U+63xVmVuh4F/rQP42mwKO1FN+gqnLKp8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWImgvXgwmzmBoogtYRInpHSHBMNZgVytdO4gGSp5osZR1kTR2
	q+qR4yXNxZFCyYBkqSEHzs/f33evZYKUyBBji8dke99e3QoEA7bn3JAerxOzPbHCHm2RHonjlsp
	Y38zQxittuG6SUZbxjvI7bvVGadbTjB0ov4oH8bhPdGMMRX+TI29jhcvZ54Bd7zMlIRAvlQ==
X-Gm-Gg: ASbGncuQCU0fD41c4ee8vDOWngtselj+6vyHxXsRjyqLlW3V4fMHWO8cPGd0SbBA5yN
	iS0m1CGhMT98tV5Dgr6rFH1XyX+eyZyIG9VhBcW92y4vXN+sLU/kWUPkQeO0/bzbryy8C1iVbD5
	yWi1o3SaHYkYUZNNGmu/GpqyzgBTf4QoqKeFTzydi1DaqHvze/C+axWgQ9MeM6S83vj6IaKwGTX
	nuReA5Ep+qGYFv8OFbrRGopvDDkI3mBhrHAOMHONZwkZ4TorXiwSlINxqFLMcHshXmb6TLi+dgD
	pQnboHzM4S+hh4UHz53P1ZJjH2FQQxaDM1LwSV5jmz57Vk40LThSIMX+YBBBfv9v2FBFMZKE4kK
	1Sj2OOgrRgQDgaeLHjW2SebNJ8iy0iftQw/wT4BCfmpO8vV4sKiY=
X-Received: by 2002:a17:903:3c23:b0:294:7048:643 with SMTP id d9443c01a7336-2951a3981fcmr9783675ad.15.1761848232671;
        Thu, 30 Oct 2025 11:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLtTmQxZPJXadN3yxRt1WMDsinLARvPN+Zc4Ke3Ur2NA0AUQYwVjva0B1WQ9P3HPSMFkp6xA==
X-Received: by 2002:a17:903:3c23:b0:294:7048:643 with SMTP id d9443c01a7336-2951a3981fcmr9783085ad.15.1761848232055;
        Thu, 30 Oct 2025 11:17:12 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.207.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4b0csm192683585ad.10.2025.10.30.11.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 11:17:11 -0700 (PDT)
Message-ID: <3a06ddc1-39ad-1192-e44b-0dbaa1352f76@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 23:47:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next 0/6] wifi: ath11k: Add single shot/periodic CFR
 capture support
Content-Language: en-US
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nMmnMUkgMdFN2FUPXATKQBdUlLKzXT7d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MiBTYWx0ZWRfX6ziyZjPA+bin
 VhOi1T7ufzOoGIOLYH3Iq+LlUOd9kd1d6lAPECeJY7petffGSibXj+AwoM78xV4cTEQ5Wm0Z3UI
 8XFtGk4yZRBB3rtcAFXZUVp0gBZl/RpejNnk/iy51OD9LeeqUPAQm030d/1ervcDYYdLwS3CRP4
 KEPL0VZDEZsjbuXZgejA/WtMFsB/KfLoVRfxM15Tz9CjSkMpJS5rR8oKvc5ybD4LQncdHu7xYo9
 UMBoTUXmahq1KmZQlHjKewErmcPwUadiyjli8PnbyO7bjDkiVKWWWPNlTqV36YODsFuiSkhAb/z
 9dCAiaDviggpABH1dUF+AsVBiQz11UqHT/4tSkuHYVYKfwnUpMcFhjhn0FoyGOulDoTTSKxek33
 UqAq93H6rVOdcPcD65juBpzLDD0GKA==
X-Proofpoint-ORIG-GUID: nMmnMUkgMdFN2FUPXATKQBdUlLKzXT7d
X-Authority-Analysis: v=2.4 cv=ItUTsb/g c=1 sm=1 tr=0 ts=6903aba9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=CMr6UP9dfYAYc02HN5pMZg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=dwuvWDSKMyNAM4JwnMMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300152



On 10/30/2025 10:01 AM, Yu Zhang(Yuriy) wrote:
> To enable/disable cfr feature use command,
> 
> echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr
> 
> where, val: 0 to disable CFR and 1 to enable CFR.
> 
> To enable CFR capture for associated peers,
> 
> echo "<val> <bw> <periodicity> <method>"
>   >
> /sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_capture
> 
> val: 0 - stop CFR capture
>       1 - start CFR capture
> bw: CFR capture bandwidth
>       0 - 20MHZ
>       1 - 40MHZ
>       2 - 80MHZ
> Periodicity: Periodicity at which hardware is expceted to collect CFR
> dump.
>       0 - single shot capture.
>       non zero - for Periodic captures (value should be multiple of 10
> ms)
> method: Method used by hardware to collect the CFR dump.
>       0 - from the ACKs of QOS NULL packets.
> 
> To enable CFR capture for unassociated clients,
> 
> echo “<mac address> <val> <periodicity>”
>   > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc
> 
> Mac address: mac address of the client.
> Val: 0 - start CFR capture
>       1 – stop CFR capture
> Periodicity: Periodicity at which hardware is expceted to collect CFR
> dump.
>       0 - single shot capture.
>       non zero - for Periodic captures (value should be multiple of 10
> ms)
> 
> To collect the cfr dump,
> cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin
> 
> Previous link:
> https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com/
> 
> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> ---
> Venkateswara Naralasetty (6):
>    wifi: ath11k: Add initialization and deinitialization sequence for CFR
>      module
>    wifi: ath11k: Register debugfs for CFR configuration
>    wifi: ath11k: Add support unassociated client CFR
>    wifi: ath11k: Register relayfs entries for CFR dump
>    wifi: ath11k: Register DBR event handler for CFR data
>    wifi: ath11k: Register handler for CFR capture event
> 
>   drivers/net/wireless/ath/ath11k/Kconfig       |  11 +
>   drivers/net/wireless/ath/ath11k/Makefile      |   1 +
>   drivers/net/wireless/ath/ath11k/cfr.c         | 991 ++++++++++++++++++
>   drivers/net/wireless/ath/ath11k/cfr.h         | 301 ++++++
>   drivers/net/wireless/ath/ath11k/core.c        |  41 +-
>   drivers/net/wireless/ath/ath11k/core.h        |  19 +-
>   drivers/net/wireless/ath/ath11k/dbring.c      |  50 +-
>   drivers/net/wireless/ath/ath11k/dbring.h      |   8 +-
>   drivers/net/wireless/ath/ath11k/debug.h       |   8 +-
>   drivers/net/wireless/ath/ath11k/debugfs_sta.c | 143 ++-
>   drivers/net/wireless/ath/ath11k/hal.c         |   3 +-
>   drivers/net/wireless/ath/ath11k/hw.h          |   5 +-
>   drivers/net/wireless/ath/ath11k/mac.c         |  17 +-
>   drivers/net/wireless/ath/ath11k/wmi.c         | 147 ++-
>   drivers/net/wireless/ath/ath11k/wmi.h         |  97 +-
>   15 files changed, 1816 insertions(+), 26 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
>   create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

