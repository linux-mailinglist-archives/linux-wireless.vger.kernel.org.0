Return-Path: <linux-wireless+bounces-17870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB0A1AA59
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 20:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8614F188CF5F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 19:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA68E1474CF;
	Thu, 23 Jan 2025 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M7rvJR3B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE03145B26
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660713; cv=none; b=BomNjOLnZK35AHPKfUWz8wRcsr3JAtKrxJoMDyKeY57FDRvYYzlS4RnfY+gwH1dZXmF/WCS52wp8jFVAWTsXsFMLRrf7l5NxZMlCwCnzCvxWfpvLrfl3ayvv5ZZQ+0+XuGkEVZ0bKHrrtiTq8gFljgbGUq4BAiy34WdVa6FbSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660713; c=relaxed/simple;
	bh=iimPEprGbjuGCWIX3TOKbcDt/bVwR034N/HwhxyDqb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET/z6fhrn14VNwjqap58Ls4WQdcuwf7J31bqiq9HhVRDR1qQh4DZbKbXmBLM55hm5kmykFjDr3gagznnaqKVeRTwnpBKpLIGVpV00MTANvpNadbK3Zz+7bkP+I0s5hkoHoixh+Gr3qmxnZfn5tG3Co07+zo4AM5J828/hlPm+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M7rvJR3B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDsI3m029645
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 19:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R+HU6Upczjepad3IS1y8A7tsL3itPbaZJ/4EX4oO7RY=; b=M7rvJR3Bkpmdp5eD
	xJTm13LeIQ4gCuAc5Hl1wVJEbIsjCpGQgr6qPqi0Wu7RE1/Coc3LrQUrWHLMpz7t
	CmVeldEKjPdvczOTSu7cU5a1GaLgSo2Y9B1yaLfww08JqXVpSLWIYWejzo45HxNo
	l0ouHqHgnkExeh5kRZkO73+t3icyHhMFf+ZNVCMMg/NvwpBDfhQSsAuwjQ3NO3TU
	n2pmUlC73TcHYUza5w4RK9pNKmcD1rVkqXw6YgDeHHDQIy1dGzR9JxPwBz6NZUc4
	5M3UjW/0ZMAExW8zgWNMaMSJmjZReppGv0+eQcsPd5QKAkQiIqrfns3v8jV87Nvl
	xKZd/A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bq2crs9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 19:31:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9da03117so3830130a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 11:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737660710; x=1738265510;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+HU6Upczjepad3IS1y8A7tsL3itPbaZJ/4EX4oO7RY=;
        b=J/br7Ukx2VIAbCnaDggBgfhK2TbYx2ZTZ43JCWX/SGGmkt1fFX/xn4Sbe4d4GO5g3r
         W9QJlzW9B4uDqA48Cir6NYJPmrj4ujWEdW6D//VnBbNR4YuFvN4CO5VsSz3Ae3nIguBx
         FN0xyAGiwWh0os7u+CwlF2heCC5zfZXwPgPBJVbre5phY+rg6X/XjB+Svp0Rw+n8lhIS
         dfvubNinsviUTRuu0lJ/T+YfyvesRWLQkoIBBa0HfwYwQBRcT3H1syI13SOrbYmscnn/
         SVnRzRI7CxmGtn6mG/V8j8P201AJ0q3IRG13epqIVao47+jhz0wakhNCX8Tky+oQykvY
         XVyg==
X-Gm-Message-State: AOJu0YyBw8j7a1yJtADY3R3pqVQh8VqcEQdPOpkfu/v+KFCtXEZha9bt
	gpMB+94DzrMXoSHqS025RBAo53CyAVi4FGB/7pg69IiL1TsGqB8YhP83erCgACfurux3hdxhlgJ
	ZXveuf4yZ5Tzmvkrn4t6rJd5W4dnbEz2cqB0jfSaKvGKYSQhMLg2+hD54lchL2Gi3/u8BS7OxiQ
	==
X-Gm-Gg: ASbGncthRKbtJOyw9ZfAFU41CQ4P1iLFuZFWmg8UCJ8Qz5HwICVFzoHAEEnVuE5vJcq
	a6kEWUVvu1O8Xh9om96o8oU1/b/rGfiJsjkFAJdDqJidppDvieLylNcPdVLlZwP4abJB+gjPJYo
	+aIUl6Qvg7sPWhm74SoByF7gpF4+cODcm9IMIb1F8tPtCPW1et278wZ72+UsM+r5ClVdDmlSGI9
	UoiGgg7i0sBftDHZOshxgV4j01An23SNiuCejpDXF4JYbnD01lyVr5KO80WfRhAunvPyff2bkss
	ETALzW+wgJMgK8GaI8BroEcxwv1J1vZfeQLrSgkcPm0bzce2f9n2Ic1/yksTRm0=
X-Received: by 2002:a17:90b:5206:b0:2ee:9d49:3aef with SMTP id 98e67ed59e1d1-2f782d4f173mr34538181a91.23.1737660710171;
        Thu, 23 Jan 2025 11:31:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXe/tgphMQH/tq3UOXXJ75lpr4kCoASmqw3v2WyjNGtlZ41FhOSs87q32O7WXoH3nRkH1A5w==
X-Received: by 2002:a17:90b:5206:b0:2ee:9d49:3aef with SMTP id 98e67ed59e1d1-2f782d4f173mr34538126a91.23.1737660709476;
        Thu, 23 Jan 2025 11:31:49 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa6a735sm93465a91.27.2025.01.23.11.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 11:31:49 -0800 (PST)
Message-ID: <e00af7e5-e906-45f0-a79e-a34078e23efd@oss.qualcomm.com>
Date: Thu, 23 Jan 2025 11:31:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/3] wifi: ath12k: report station mode transmit rate
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250115063537.35797-1-quic_lingbok@quicinc.com>
 <20250115063537.35797-2-quic_lingbok@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250115063537.35797-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9tp1S-zgPJSksq7uJtuOqW_U7f8tkJtl
X-Proofpoint-ORIG-GUID: 9tp1S-zgPJSksq7uJtuOqW_U7f8tkJtl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501230142

On 1/14/2025 10:35 PM, Lingbo Kong wrote:
> Currently, the transmit rate of "iw dev xxx station dump" command
> always show an invalid value.
> 
> To address this issue, ath12k parse the info of transmit complete
> report from firmware and indicate the transmit rate to mac80211.
> 
> This patch affects the station mode of WCN7850 and QCN9274.
> 
> After that, "iw dev xxx station dump" show the correct transmit rate.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  872 ms
>         rx bytes:       219111
>         rx packets:     1133
>         tx bytes:       53767
>         tx packets:     462
>         tx retries:     51
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      403
>         rx drop misc:   74
>         signal:         -95 dBm
>         beacon signal avg:      -18 dBm
>         tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219715


