Return-Path: <linux-wireless+bounces-21587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE36A8AED3
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 06:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AD517B705
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 04:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC65227B9C;
	Wed, 16 Apr 2025 04:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="otYQoEz3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD62DFA49
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744776598; cv=none; b=YlT56Z3SftzOwel8rFGI+bTVQVlkWCEBPDnCm3oDAU+gAdHvUR6Xq09BMbMDo5GI1J6+9dqayblMDcGqHgnbDJlOGlda3a8rGDVVC0UaN+7MR2C2FUX8JhH0Z6Bf75j6rA10cDN2LLHAFYzv7CjavLNARAO2o8UjddMc1qM4ZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744776598; c=relaxed/simple;
	bh=2FOlnoQ10Czy+Pj44FT5IqJx2+4hIws93qNiWgLMExc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+wyb8oHeepIHD3K6DUJSDnoxpEFFRz9ZdnWMnf5mwvMW3KBTsmn+rWYLQ7srz9JAAsLe1/HhxKbEIBxDUHmCgpuxP2VKYi2hvpjbj0KjEtHu2oVfZiWFWhKOcBKDrsrpHWjU60aJMMFv+HeaAm+LTzYtfnzx+SeJQkNQGOu4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=otYQoEz3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FITPfc012483
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uWPEkmma4e919v7Fo7yYcsZdAb8gLvstwZg1mAkXsEI=; b=otYQoEz3g7Hryyjs
	7fjLEV2eakQPVEvdPT6egfTDCJm2oNrqvX0A8qdi5nNSv51HCtG6zzSqHDvDlrzT
	JnPUqnodLbm+GBd5GvXdrKTqe8vEItiByIt3G5X6Es59yzRcpaaVdviuBlwtvZvz
	QlEhQTQpbnZynlYfIwVkFM+2nw7ZuYkpwz1Pjv/cekkr0b/PEM9YhBp4haG1Aea4
	8gfBCU0PBePHhYacR55GVB1gUsIL+dULLIrqM7FaJHZuhbf6Ro6qrQwbB9DRzs7h
	wDpYKORO7p14qq3Lx4dTAn/jXo6B23rj41oDMtGhXzjYWKkJvoUJEx1WbtL54ca+
	UaGYEQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydhqag1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:09:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-224192ff68bso57465265ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 21:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744776594; x=1745381394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWPEkmma4e919v7Fo7yYcsZdAb8gLvstwZg1mAkXsEI=;
        b=tu6ErDBAgAMrJKwHLgg1IUBJ0YGPNV8dtMpdR0oUAmWMONG16HlHzIx/hI3mljehXg
         GVv+K6fSesY7TsgLgyD1TRg/jWFTBrY3McRns+TwcS+WVG6liaOEoBYvEOS7QvKUx1cF
         JBezjOXUB5p7Gzhd2G0vRI59YdE7RNI5jIEMq4bZzzjrfg+VNtJxlfcSCpx2k8Mt1DK8
         BIRQeVTrFFbEpLnSqF/3LGEhqOf2ALUb5xVmOB/fY1MzKScYtzZRoLCjM4X6A3TOAIIg
         vR43rt9A0xJZzEjvXHQX3a5325eNrhvKispT3SmUk702DxRpjdZxpmunG+5SLPExnlBJ
         va8w==
X-Gm-Message-State: AOJu0YwOBsgQAhIIU8Sju9SoG4dg8dlsRTcp+bIc1MSxo9ts9PNt+GXo
	w2MghuIfGxP/pYe9gQd/2D/Tl9YETKm/CM8G4EUr/9leSnyAoJj0Rmuq4L4D3+UKp963yVQL0VZ
	5GLDcF6br1hPR8ceTJ6loeUhTQXSF4yn/3aV7g1CP3rHGN2xeJNC8CVJ8pbIfcCYQjg==
X-Gm-Gg: ASbGncvxME1AWSq49Hv/1daDbzub+PqPHOjIeXFSXKazlwh6Ppw+QrB+bRCGwLRbO7M
	FTRk3a2Q6sdJWTkRpVonX5TfLIka6usHtbAUY2cjHaqg8TNaLhWUsglexppVqJ448/1ia7o9wsV
	odf/Q6Jpgv1Ihn3ckltnT8hdQ+gK/F1O9jpjZ9NVjooyK2TToHUmW2QhHgBhUrzBxAEZlufpeaX
	WPMS4uVz+HNAJaB/WhAjSRuWjJtBKz7r6rN+zECTU8B0paj4BKrH7oA2AOzmWgK/fXU0aJKcJed
	RxoaDSsMF0VmAJxSSGyJ661G6/mc+wtzdI9G5PBBOdlsfIETfJ1Lsw==
X-Received: by 2002:a17:902:ea06:b0:224:216e:332f with SMTP id d9443c01a7336-22c35985b76mr5316255ad.48.1744776593818;
        Tue, 15 Apr 2025 21:09:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBhkelHgI83PIttWeBMPxd6pmY0OjAfrGUcozBkqmgnCpV3zVjhV96f5VroGDLfyseFjm6ug==
X-Received: by 2002:a17:902:ea06:b0:224:216e:332f with SMTP id d9443c01a7336-22c35985b76mr5316025ad.48.1744776593454;
        Tue, 15 Apr 2025 21:09:53 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f1035sm9369218b3a.114.2025.04.15.21.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 21:09:53 -0700 (PDT)
Message-ID: <e789aa3d-ab12-ed19-0d58-012004e365d1@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 09:39:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 2/3] wifi: ath12k: Fix frequency range in driver
Content-Language: en-US
To: Rajat Soni <quic_rajson@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20250408042128.720263-1-quic_rajson@quicinc.com>
 <20250408042128.720263-3-quic_rajson@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250408042128.720263-3-quic_rajson@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hLfhYQNtS1ZDfTonUNY5RD2mHrfkj8Hb
X-Authority-Analysis: v=2.4 cv=C7DpyRP+ c=1 sm=1 tr=0 ts=67ff2d93 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=-MRtn_aAFlfTcB5G1b8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: hLfhYQNtS1ZDfTonUNY5RD2mHrfkj8Hb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160031



On 4/8/2025 9:51 AM, Rajat Soni wrote:
> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 
> During the initial WMI exchange, the firmware updates the
> hardware-supported start and end frequencies in the
> ath12k_wmi_hal_reg_capabilities_ext_arg structure. These frequencies,
> being hardware-supported, may not always align with the current
> regulatory operating frequencies. When operating as multiple grouped
> hardwares under a single wiphy, the driver advertises these values
> directly to the upper layer in the per-radio frequency range,
> which can be misleading.
> 
> Sample output snippet from iw phyX info command -
> 
> [..]
> Supported wiphy radios:
>            * Idx 0:
>                    Frequency Range: 2312 MHz - 2732 MHz
> 		 [..]
> 
>            * Idx 1:
>                    Frequency Range: 5150 MHz - 5330 MHz
> 		 [..]
> [..]
> 
> The frequency range displayed above is incorrect because the driver
> directly advertises the hardware-supported values to the upper layer.
> 
> The driver is aware of the current operating regulatory rules, and
> hence it can use this information to determine the final operating
> start and end frequencies.
> 
> To resolve this issue, add support to store the start and end
> frequencies received during the regulatory update event.
> Then, intersect these with the hardware-supported start and
> end frequencies, and finally, advertise the intersected values to the
> upper layer.
> 
> Sample output snippet from iw phyX info command after the fix -
> 
> [..]
> Supported wiphy radios:
>            * Idx 0:
>                    Frequency Range: 2402 MHz - 2472 MHz
> 		 [..]
> 
>            * Idx 1:
>                    Frequency Range: 5170 MHz - 5330 MHz
> 		 [..]
> [..]
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> Co-developed-by: Rajat Soni <quic_rajson@quicinc.com>
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.h |  9 ++++++
>   drivers/net/wireless/ath/ath12k/mac.c  | 39 ++++++++++++++++++--------
>   drivers/net/wireless/ath/ath12k/reg.c  | 13 +++++++++
>   3 files changed, 49 insertions(+), 12 deletions(-)
> 

You may need to rebase the series

Applying: wifi: ath12k: Add helper function ath12k_mac_update_freq_range()
Applying: wifi: ath12k: Fix frequency range in driver
error: patch failed: drivers/net/wireless/ath/ath12k/core.h:1122
error: drivers/net/wireless/ath/ath12k/core.h: patch does not apply
Patch failed at 0002 wifi: ath12k: Fix frequency range in driver

