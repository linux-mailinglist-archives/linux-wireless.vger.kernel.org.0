Return-Path: <linux-wireless+bounces-17924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAD4A1C116
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 06:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF803A22AB
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 05:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2820765D;
	Sat, 25 Jan 2025 05:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FPI7eKjS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059C7206F06
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 05:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737782849; cv=none; b=qAV0zKAP0UecqXopk0EweP+a63GtOcNPOaSIWMKKgWc+Z4MmAJpf3fMTv4jtnsEamlzAcEVeuD7g/ohyRDyT2IXTtOGrFHjAHcM3CTjWnokCor1Kav+WtSmiHwwa2tDf1aazAMgdB71BLwmlHqDMCtUStoWKo0W9JJ7Helu1D+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737782849; c=relaxed/simple;
	bh=4W6ODc8z9B6QuteH3atOK2Z/mx21iaxps2dMZVhpAfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkqnqjxFNTrtJFU3AyHAUzX7Uwx3BJHX0Jy6FBVbxHGNGXSa+xFSa8SX8DU0G4QkjbdCIql+iOC8IjonVcNT6mHA5E+Y6HCT3/yIIEA+VG0aGJZTZgxHvz944PUVCAmPH4VufxZ5rqF2EwRxCChr4kiOMxJuWUqdG96aAN1Qrq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FPI7eKjS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50P4mNCt014136
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 05:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2KxAlIlTN5tW2PBBCeWxdNPXxY7BHWSF4JL49sTdJkQ=; b=FPI7eKjS+tjk7v9V
	+GETgnNJLtECBAT0O1DJHhAdUXtWTgDf8nCt1AnQhXTVMi1whbDnoyzR74NmmQw6
	TjGQYgNRsXE1wzhj79gQoHauK98lRohOjFOprjnLpmiM7zzmU5X3lbJAgqZP9+P6
	P04RYmKuIbO636kDlG/0osvQGvSl3b+ToY6q8YB0BfTBxJ/CTXfGTBt5DF629pEm
	P4xnyDZNVcxGUEq+Z7ZVblGYR7fIrEF18dVwcszOj7A9f3rVgRWikis7bji90Wfa
	ZBV9nqp4nTkMxchtpXiRqktKOCaM9lmVKeGgn2bXvYtPu0j8Qsc7GVO1qP5x9V5o
	dQSdKw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs8781dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 05:27:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2178115051dso52863075ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 21:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737782846; x=1738387646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KxAlIlTN5tW2PBBCeWxdNPXxY7BHWSF4JL49sTdJkQ=;
        b=BP1AhYHol44cjEpxpxObUYw4YX1CS+Z/Lf9yKVeLmz0aHFA5r6m5rZCrtdUIhmOxtp
         lVdATIirJ9XwkyXuT5DgmU2gahRPxFWAG/Z5U7uCNPqna0IAZYkyD5IKyptZrmhS8ubZ
         JbpLYDPq0Bp3w/c2mXRaqHocS+p3tetyvkvQ46vW2ZBgixGBq8F5wDtQVRVln4aqkeqx
         fedESnTr3482zpCPM1tBk1aPC9teqW0m3z7qKBxV0p2xgluD6G2iV7P4qzGl+tmDZAYf
         bFE1QTyYKI+RcfGUTf1TcDuoVQ5th7fxAQa3fv3XhNu3K52VpR2MGIE7pRus9b5GjbQq
         cj+Q==
X-Gm-Message-State: AOJu0YxMaO87YEFpZIo2WwZcZQYG1D3Uif93iz1i4ywveE8eB4QjKoKe
	7Ds4HXOMai7h124qV3Rmh3wEmR3wNfMzfa8a+lbvcWmcPlXZwJ0ix+txTOiae0Hu1+ylSuiDcbW
	r5jukoLKwBvVGhFagVmaSKI5FyOdi2iehTj+WBMHDZmNTHhP79BYAq0RmBX7Tdsl0WA==
X-Gm-Gg: ASbGncsOTL/1o4otnxXXWOO/BIS3Sg01if6SKlIZ4kpzMXh/UGAqfqaGKN31dUDT/GK
	XykEWtl17mREiVhkQCmfOZcANyw4RCZeQnSlzvaH95XsQH6ASaxY21YABdz5QSkraf2stTBOUkO
	3PzHBTXo7h4GzJvXCAfDvWgJfuX/aQD2xbgdWU2OEIX4OQ2qME6jUj3BBYwLo104yO3PU66augm
	Qj035D1vBt+WHr/0tptbpBvuZhiEVR1SLYsPhFD5byP8iZI/BSWwWXTpf3rhuGhDouhR0xvnRmM
	2hDyeaHBwPcwzYJ+s9o3rOrUi25keBBId26xaLAj7w==
X-Received: by 2002:a05:6a20:9190:b0:1e1:afa9:d39b with SMTP id adf61e73a8af0-1eb2144d760mr58569290637.7.1737782846125;
        Fri, 24 Jan 2025 21:27:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaSY+UeSNQL5fnUwi85JsWps1wE3/+J9w411GaYp0W0+wqoHuvsswwyv/6i/D/p8PqiRhYZg==
X-Received: by 2002:a05:6a20:9190:b0:1e1:afa9:d39b with SMTP id adf61e73a8af0-1eb2144d760mr58569264637.7.1737782845732;
        Fri, 24 Jan 2025 21:27:25 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6d234fsm2871300b3a.77.2025.01.24.21.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 21:27:25 -0800 (PST)
Message-ID: <b64b7d12-67ab-4424-aefa-f1c95b32040f@oss.qualcomm.com>
Date: Sat, 25 Jan 2025 10:57:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath12k: Request pdev stats from firmware
To: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250124185330.1244585-1-ramya.gnanasekar@oss.qualcomm.com>
 <20250124185330.1244585-4-ramya.gnanasekar@oss.qualcomm.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250124185330.1244585-4-ramya.gnanasekar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DhEs3d3Gr4M_XknSrBYZSP4E9oXYeob8
X-Proofpoint-ORIG-GUID: DhEs3d3Gr4M_XknSrBYZSP4E9oXYeob8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_02,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501250035

On 1/25/25 00:23, Ramya Gnanasekar wrote:
> Add support to request pdev stats from firmware through WMI and
> print the information
> 
> Sample Output:
> -------------
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/fw_stats/pdev_stats
> 
>               ath12k PDEV stats
>               =================
> 
>             Channel noise floor        -85
>                Channel TX power        126
>                  TX frame count          0
>                  RX frame count       8637
>                  RX clear count      37424
>                     Cycle count    4372024
>                 PHY error count          0
>                  soc drop count          0
> 
>            ath12k PDEV TX stats
>            ====================
> 
>              HTT cookies queued          0
>               HTT cookies disp.          0
>                     MSDU queued          0
>                     MPDU queued          0
>                   MSDUs dropped          0
>                    Local enqued          0
>                     Local freed          0
>                       HW queued          0
>                    PPDUs reaped          0
>                   Num underruns          0
>                   PPDUs cleaned          0
>                  MPDUs requeued          0
>               Excessive retries          0
>                         HW rate          0
>             Sched self triggers          0
>       Dropped due to SW retries          0
>         Illegal rate phy errors          0
>          PDEV continuous xretry          0
>                      TX timeout          9
>                     PDEV resets          0
>   Stateless TIDs alloc failures          0
>                    PHY underrun          0
>    MPDU is more than txop limit          0
> 
>            ath12k PDEV RX stats
>            ====================
> 
>           Mid PPDU route change          0
>         Tot. number of statuses          0
>          Extra frags on rings 0          0
>          Extra frags on rings 1          0
>          Extra frags on rings 2          0
>          Extra frags on rings 3          0
>          MSDUs delivered to HTT          0
>          MPDUs delivered to HTT          0
>        MSDUs delivered to stack          0
>        MPDUs delivered to stack          0
>                 Oversized AMSUs          0
>                      PHY errors          0
>                PHY errors drops          0
>     MPDU errors (FCS, MIC, ENC)          0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Ramya Gnanasekar<ramya.gnanasekar@oss.qualcomm.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

