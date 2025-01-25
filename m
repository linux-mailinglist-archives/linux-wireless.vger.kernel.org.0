Return-Path: <linux-wireless+bounces-17922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64136A1C105
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 06:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9896A169828
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 05:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79371205AC3;
	Sat, 25 Jan 2025 05:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EZ2d3eiW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74782582
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 05:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737782623; cv=none; b=EqTAZ7S/vwECN6yIHs+lDL8oZ2PQq7n1pzAGakNuCXxEXPTK/NdbJCfF/Sb/wHpE5mOG0UgNQgepTJ0vTnyilr8NKt+Z7hpc6gx3Tf7HU6YOgMz9TryahcIo2SO2aEZMKdeib7RCPk+y11oquORqECXGzZOA+kVbYWKX+fDTlS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737782623; c=relaxed/simple;
	bh=snmfqZWChXeHPiqoQhvdcJgNyHyXRR4Rphf9EIqor4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsOUrsIu4aY981Drv6BkwljnsKURd8tj7T7sUNR1WsPflbQ+7MZxsaqt0/iMQ4odVej1M3SguJON71GpSzICWczODFeXzJab4Mv0trGequ4p7TmPHAYOHCj6+XoDemMmvzoTR0T4kKdETiRI1xlOjUWEJB3ZOaLoMjfi0kYpqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EZ2d3eiW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50P4sdxM004554
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 05:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D1vE66wPRFswKFvuicyFGC0mSxtAlHJNXTigP24pTC8=; b=EZ2d3eiWAo2O5FnQ
	uSaU9l6M4n/hInEh5b6ivenwuBWuB2PBQyUdVex78wgtY6uc4bXCK3nhm4yKuVzb
	AiTCnEClzOVtkXsQfUiQeEQqSvtXwUwCAsDRlrfY38f9YzC+RhJDAKYZ8lz9G0SW
	R7CQpgVv0K7TgBugSVlX59w2cyim/PT+cgRI7ym7mzqySxsQGXUxovJwBjIymGbN
	/7GVweqCcgrzyegQGl2ke7dbTYegJ72ci6aOrh0kQoSMhCtuvznehMO8zR4TBHml
	sd2gIUHWo8+PYMiWiPd4JbrPJy4gtVB9PU93sN9v9dJEzQFY/KHMRkMW4wNQ/1sx
	Y+DO+w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs3eg1jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 05:23:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21640607349so65958555ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 21:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737782620; x=1738387420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1vE66wPRFswKFvuicyFGC0mSxtAlHJNXTigP24pTC8=;
        b=YeA03RFtC75ie/COUrOgoX1SvJMzGkRR6DjKX56lAW+29dpOOEScIQUPpaySBvET+u
         IgD+iHTmDW71ASmGRmZ55Sw8mOtCBT8NKpMqDHGA4XPKo1xcf9VVHJXBclAm87+eomKn
         zYkUfl1DwdvsiVZ7NXXRPOBC8P2pZo/UVIbVmNkfLEj5x5k9aln0rUvlP6gSIklwcNwo
         VcKyWV8ovTWMhE4AGUB2VR+iun5KLC744lWAz8J6gcaLrODUSkkBWM3OMaZLwj8KwdXM
         uvT+UIq/3LP+V/62EdYOvB4MKgDp/ckexvpXkUYWAnvcpN77NbVtKpz+oQUgwui2mqSj
         LJvw==
X-Gm-Message-State: AOJu0YzyMafa+NdcNOwv3FZOsVDWaQjXokFHqYs+Og1O3kF2UFdqPT90
	QUtyRjfEDQrvWIZVCvnXV8W+2wmPexfrPxMpjWMXJexSJ3VqU3aX/VhEnRYSYaa7WT5NPNIdUQn
	jIMjT1NUG11XdDoGi0XT0AE4Qkl6SNG+jYnV+Mb5a1b9E0HT3xxpMQNJKxxsQswlPSw==
X-Gm-Gg: ASbGncuk5AYTdtT85/7+SWj8P/+hW4mkFelsvKMxeUHnQucgb4H0+/OKYHU4HuHyGfA
	FlMq6AWDVQi7d1N5UAmv4GdgR6NL3Rt2ouYpwgvMjT2zaxndYrLHalcfdrpaMv/4vYPmpTOLOQ6
	KQOiEd+l4W4vEGGBGsL0TFHPjb1C8pHLOOtmbVXey/+lqEyLIGUXt9XWhYn716rXOIW1G6Yf4az
	9Ph9Qx4elSG4jkWYgSy5bRcH1aWW1uaTWeWDRA+1KBaW/STovjvgZC//HxjRAwGPU8Rj4jaA3G9
	MS7D8tdT5AR0JsSL93/H6/zdGyWlKyBlGB7azZdN9Q==
X-Received: by 2002:a17:902:f544:b0:215:e98c:c5bc with SMTP id d9443c01a7336-21c3563a33cmr578829015ad.48.1737782619712;
        Fri, 24 Jan 2025 21:23:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9YAuBKKEADfPUnFCxF82oRXgcOvIEtHq5ZFZoFbRx2v4FPiVB9rtGj9QuhhepZQ+JaXDyFA==
X-Received: by 2002:a17:902:f544:b0:215:e98c:c5bc with SMTP id d9443c01a7336-21c3563a33cmr578828765ad.48.1737782619361;
        Fri, 24 Jan 2025 21:23:39 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea3ba3sm25041175ad.58.2025.01.24.21.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 21:23:39 -0800 (PST)
Message-ID: <cb3fc64a-322a-492a-ade3-c3ba86074a64@oss.qualcomm.com>
Date: Sat, 25 Jan 2025 10:53:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath12k: Request vdev stats from firmware
To: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250124185330.1244585-1-ramya.gnanasekar@oss.qualcomm.com>
 <20250124185330.1244585-2-ramya.gnanasekar@oss.qualcomm.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250124185330.1244585-2-ramya.gnanasekar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: L2Clp0nvidst8m1b4PLKfY9ihUjEIURA
X-Proofpoint-GUID: L2Clp0nvidst8m1b4PLKfY9ihUjEIURA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_02,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=830 lowpriorityscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501250034

On 1/25/25 00:23, Ramya Gnanasekar wrote:
> Add support to request and print vdev stats from firmware through WMI.
> 
> Sample output:
> -------------
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/fw_stats/vdev_stats
> 
>               ath12k VDEV stats
>               =================
> 
>                         VDEV ID 0
>                VDEV MAC address 00:03:7f:6c:9c:1a
>                      beacon snr 96
>                        data snr 255
>                   num rx frames 0
>                    num rts fail 0
>                 num rts success 0
>                      num rx err 0
>                  num rx discard 0
>                num tx not acked 0
>              num tx frames [00] 0
>              num tx frames [01] 0
>              num tx frames [02] 0
>              num tx frames [03] 2
>      num tx frames retries [00] 0
>      num tx frames retries [01] 0
>      num tx frames retries [02] 0
>      num tx frames retries [03] 0
>     num tx frames failures [00] 0
>     num tx frames failures [01] 0
>     num tx frames failures [02] 0
>     num tx frames failures [03] 0
>            tx rate history [00] 0x00000000
>            tx rate history [01] 0x00000000
>            tx rate history [02] 0x00000000
>            tx rate history [03] 0x00000000
>            tx rate history [04] 0x00000000
>            tx rate history [05] 0x00000000
>            tx rate history [06] 0x00000000
>            tx rate history [07] 0x00000000
>            tx rate history [08] 0x00000000
>            tx rate history [09] 0x00000000
>        beacon rssi history [00] 0
>        beacon rssi history [01] 0
>        beacon rssi history [02] 0
>        beacon rssi history [03] 0
>        beacon rssi history [04] 0
>        beacon rssi history [05] 0
>        beacon rssi history [06] 0
>        beacon rssi history [07] 0
>        beacon rssi history [08] 0
>        beacon rssi history [09] 0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Ramya Gnanasekar<ramya.gnanasekar@oss.qualcomm.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

