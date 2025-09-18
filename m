Return-Path: <linux-wireless+bounces-27469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34366B834EE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 09:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31CD1C24435
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A22E2EFC;
	Thu, 18 Sep 2025 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FHjaeckp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9C2248B0
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180305; cv=none; b=XN54zkRQfRqvi0/piCyTLAsYt1NdDVRc9AD5ehDNQ8NinVBKvz3TnCHR2KzcIJqTE3PPlPWcAzLjOQBqG+sOgIvnUdNvq49GyYf+B0VnfsgpNogKAeJVV0M2GDKW18qIP1ILkgUfkffmw9IcdtKyA3uuqIgNGBMEX+UYd6moPAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180305; c=relaxed/simple;
	bh=JNGTD1nP+KN4gozMclNMxgRF7nTYjU8dohepiXZ2TRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpwBzbja+gsmLNePCLTPubBaU1Y9Vzib7Rn+xEtd+4O1xXboJx3D0fRAHdZ7uDg7UTPpH2d7uwfs8fANs7fgWtVl5aptiWIf8cJGTkFKco8rfVo6a2EM06fuQfhGREypZkkuOKVMGimtS30MpaqpOTJvNj1Ra1ETC/Y5KNOBZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FHjaeckp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6Q1Mt030267
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ue+pVaOAYmIBOaB8cArSGaKhQNAputzlAr9Z6ULW9DM=; b=FHjaeckpIOa/vF1P
	ZiClZ09QlfV0arE/nH8dx0BF2IdS7sJWMTuOXqcIFUDT5Zkn492mTXqgIkl1saos
	dYj3iOeJBnGxbudjBSy/ckECGJ/TgHukswN8sB18+vWlNuCedE0XIA9gvt4RjLcv
	20NhFf6EQ/8/jD1chjs36r/dGntekHH1CUEvG0tvUZdyJ8JbzvloQYPCbquf4ZwZ
	jDTCC4LRT05PVexxt3WCr71KKt1jBI5Ct+0ZOC+IL8CmKzVHo+ZYqKgEdTxqPxKj
	8iKUuWLhE3XIKfP6N++dO0DEKiuXekBmMljNYn7P7q490Xj1AD8bV0vd3UanRy4s
	r6AeEQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1jbaph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:25:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b52047b3f21so466073a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 00:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758180301; x=1758785101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue+pVaOAYmIBOaB8cArSGaKhQNAputzlAr9Z6ULW9DM=;
        b=qAWX4RbA7d2xBowbDTfs2jJPWRn3BHzBvWqF5pApoqI6ZZaYbWgEyrhWS1pGOvm76D
         pIkMuTIl6p6p51KP5gyMCXP3QThDbGqn3h2cdtK057LZhZJqImAjes/4HxABVepBqjEB
         ToiAgZl6Z8m9QnrqqjtPbora5KsmDLQJpSyFIDoy3v9+B+MrV0Dn00PTS7wSUtEN+vKX
         UD6KmmwqpmhX0olwZfcMSll8lSrugveI7LQO9gi/DKdGE+nmWhHdt1YJv6CRboaCH/0w
         x/VR/xBtcyQmG7ntJFOWzgWIz2lxe8oCv6wHgkblBVGCyY5XwDVZoVe1wKxch377XLlN
         cgrQ==
X-Gm-Message-State: AOJu0YwFrWAMn6KW0XzmaUK3TM7kI/vex4cSy3COWxL7XiT5+2P4EPoM
	xJ4rHVXL6CPN9JR0dH/GpfqfjMi1ktBOheQtyj/xyuBIVRjQUGsLiWlizObSfNv/KVzCXr6rWQK
	gMdU+8SdA2lEUnQgyaxqseHq3jH1EqPL7JNbu6yZ135QIDIB/cyV3s37jhRUw+kyDTkN5zWaXki
	hVyQ==
X-Gm-Gg: ASbGnctdCJnlNiPlAXdoNo1c6VUeS7Kb8x5CwkCNUjJ65GD8j/fXXPLSZzdcX8By62V
	43ZsLZ36XKQ7yTKLT8+sDnA88atexxj22M4kWf/U3Zoh+jL2O9zajiHIK83odTr3VKtoRs+ArwN
	DOQFhrY58nzg7MG7rG64M93A25DdyBhUQxVQiKdzpBVthbvC9LouCVgBtcDzZmScJiwiQkMJRLc
	3N++/XzoPAPm0+d1BWzKLPRTcmZ3G8Ph0aAIvpTc6p29jsKwXeC+/5IwicHHe5ilG4BbKi22etK
	nCi6kKmhlbSGbbCLTOzAtLXP/yauv/ouQRZPnlbHkQOv1/sdbMb14qn6GXJe2uxOC6nu1Ii660Y
	42ivZ/w==
X-Received: by 2002:a05:6a21:3393:b0:249:c440:9b39 with SMTP id adf61e73a8af0-27ab06e41d8mr7636350637.54.1758180301590;
        Thu, 18 Sep 2025 00:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9sa0L3R0ncN3Jc2SZiMG6nwOJATnPz6XVx4l276ZxLWmOpVYIHpMBxMwzAetN8OkABmjWug==
X-Received: by 2002:a05:6a21:3393:b0:249:c440:9b39 with SMTP id adf61e73a8af0-27ab06e41d8mr7636321637.54.1758180301201;
        Thu, 18 Sep 2025 00:25:01 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff38eaf1sm1479952a12.24.2025.09.18.00.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 00:25:00 -0700 (PDT)
Message-ID: <8bf63e27-57e9-fe60-698a-9207b5136c04@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:54:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next V4] wifi: ath12k: report station mode per-chain
 signal strength
Content-Language: en-US
To: Lingbo Kong <lingbo.kong@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250812030044.688-1-quic_lingbok@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250812030044.688-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SHIzhIXqAPMNOkyZVL0SxnVQrwThMR9T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX9julBrc5iHl0
 aj/d0HHCJAouH4jjaEHr2RkzBM5lpXHBYZxzDur3fZM9UFRQOD7dsGslfLIazXp/yCd3DG2pZh4
 SequM88EAh9NfLWvMBbVCfKma+zyuZhe8loH37sSd+3BOYx/T0FbYafOWd+qKAIhIC/E3Ct+OiV
 aPW9pykK6UJ5Ud7GyC6OdcSjMj21UgbtF4oES7Ll8y2XPtjyYuZulDw8AVky7YtmL7MPEnIXD9Q
 Nr+TxjtbysUI4Nb6zhgvmZVREbpsWQEz6OLCDEULVtCX34hsjK53tFmPLFqDyt9odIzcYTN0iEI
 hVktR0m6t85c3lX+EXhlBcovfpRk9iyxD+g6caOnF/canVVzSUQ0PJxpYfSL+L6/u5ZHBwOJMIf
 N8So+TaJ
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cbb3cf cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pN-lpjZd9i1dOjWOSwIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: SHIzhIXqAPMNOkyZVL0SxnVQrwThMR9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110



On 8/12/2025 8:30 AM, Lingbo Kong wrote:
> From: Lingbo Kong <lingbo.kong@oss.qualcomm.com>
> 
> Currently, command “iw wlan0 station dump” does not show per-chain signal
> strength.
> 
> This is because ath12k does not handle the num_per_chain_rssi and
> rssi_avg_beacon reported by firmware to ath12k.
> 
> To address this, update ath12k to send WMI_REQUEST_STATS_CMDID with the
> flag WMI_REQUEST_RSSI_PER_CHAIN_STAT to the firmware. Then, add logic to
> handle num_per_chain_rssi and rssi_avg_beacon in the
> ath12k_wmi_tlv_fw_stats_parse(), and assign the resulting per-chain signal
> strength to the chain_signal of struct station_info.
> 
> After that, "iw dev xxx station dump" shows the correct per-chain signal
> strength.
> Such as:
> 
> Station AA:BB:CC:DD:EE:FF (on wlan0)
>          inactive time:  212 ms
>          rx bytes:       10398
>          rx packets:     64
>          tx bytes:       4362
>          tx packets:     33
>          tx retries:     49
>          tx failed:      0
>          beacon loss:    0
>          beacon rx:      14
>          rx drop misc:   16
>          signal:         -45 [-51, -46] dBm
>          beacon signal avg:      -44 dBm
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219751
> Signed-off-by: Lingbo Kong <lingbo.kong@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

