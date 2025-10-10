Return-Path: <linux-wireless+bounces-27926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA94BCB5F7
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 03:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E58D34E0F95
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 01:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483EF282F5;
	Fri, 10 Oct 2025 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="od3g4e15"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E953DDC5
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061090; cv=none; b=Tr2X5EavZ/fSjQmqoKJrSly0CZr6iwwscrBNhxbc0eorkruQDUg2bbDcs/RXh6FXABHkgLoUWAgOeG7QnzLS8LJy5Pr7L8WPG8tDkAAwYaNaWKmggsG8xSyfz2r4Hw8smTvfTw0lFwENwJaAG0YprOoRH1727fnRKBQ97pms3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061090; c=relaxed/simple;
	bh=zWhlU1yZsj4S4Fwbq9U2ingjZHELoDe3zXrWU3815FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHUWFqHVMJlmvZnpx6xoZl95/goAlLbckO4cSW/LBqvB5WfzX/bmgLfL6gPt6RK8BYE3edtZISk9bd8qC/KDUNM1tYVdfYSKy/sdt1LGiGieeCfmFFzuZErMdKyVkv+/CMlUBMEjWqYt3xVp39LGaJw/VL99sKXzdrV33oCVpyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=od3g4e15; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EK2Xg029764
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 01:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l0qcepBGkZWG2U8Oj/qywTV50xBofD4KJeUorYpisCA=; b=od3g4e15FbxQBWqO
	bMTIxlPj30IznaXTmIu4aT043x+hVUrYGSxbM9kkcT+kAVROm9aKvC3Qn0zjp5PE
	v90XxVthIVfYy2gwTImTKGvllwclw8VP8ooKaZ3Sv5WthvPV4eEPOzv8IuYxbz2U
	RsT7Ud6IcO+42JbiFWbbRYueebvd9IYgvXbjIm0iXwSdX2IgQfbp0IGwi35XE72z
	cDbQ8r0DtnFgPoU3d16h591y7G8ORD/m2dEeTkaM5wWWjzLM+e6rf04h2K0ZkF09
	Z20XLD23kFfQcmw7NX5GHGHFLkdQZxZJWpf/PYJ1DsKwSoQ4t/PogBQV6TBHHbSG
	cqdhGA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nctgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 01:51:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28a5b8b12bbso57492285ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Oct 2025 18:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760061086; x=1760665886;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0qcepBGkZWG2U8Oj/qywTV50xBofD4KJeUorYpisCA=;
        b=MVQkRMqOq6n5rdxvVbudQ1QZdXu+BMU6cNPlLHaHezrRIcwspc/lfvnATDYViXl8jQ
         xlwNow/WrFRi9G/B0M6r//w9cI31fbu9l59WPAWe1r/7qc0EjKM9kUIUQGFI60qx7gtu
         aOuI7REif6WJvNAQXLuiAx+fU1iDJrZUS00RIRE0ox1Iwv8Y+4velLYK8XjvmdyyFClE
         ghNFVJHH1HgCYdj6DdIJ0+T3P+LLbEA65IifDhQeHj+5CCq/moBffnSUAbWO+fHVryDi
         lSdsysvbjbaygYNo2QHg+VppXCVSGRked1YPno6eWlR503x5tdUFLroKWWxiU1zgfcuZ
         q8zw==
X-Gm-Message-State: AOJu0YzBqvcacWlqcH/eG45BzPgAA5JxW++W83RxAfe2NAob6eUIu6CW
	Fjkou7U3evQ4HlpcYU/z6v1Iso2mx2PPlycPY1PvQjDkBRQK22HV0VW68hzdhnEeEIgIGvMUmVU
	pbkflz5DtDVYsAXkmo0PwW8Q02L1q9yEOcUoZGwj90bzcVmvBKNr5jFnm1X9uESQUMr3TCw==
X-Gm-Gg: ASbGnctjx+3XnA87Yn452jgHdoXgeW/jHi6HMJvGH5lc1tF/nIrAdN7qytvkldzTzx6
	X6nLnOYy/B6i70YEIuHpRvlOQqxfGujyxI799NNQYe9GfDZbJ25fWoVhLpOkZ3ERAxJMvsVvpyq
	yb38xp0xDSSE0fdZyT9X6w5+5zLPBFYDg55y+vZ0eP4LzfYqGTpuHSL2nOEs6Tx0ZRxpw60oY7D
	i6GwQDdXrb4bghD9/F8e81b8T+76qWHQp4HERx0PYFW7/4MW7rKQBVEQ+z8sDwhZwFC2dvT/1l7
	seNIwcYW1wdgXgwtNyLFCttQBT0ECRYwRICE3CiX6wGfhep/hE9JB38oKi0ul1S/Cf97ArEpJik
	e515g8N8Y8VR6VDjksF+3bXPdLCm50aYRyoH8rg==
X-Received: by 2002:a17:903:3c6c:b0:269:9719:fffd with SMTP id d9443c01a7336-290273567e5mr119796915ad.1.1760061086516;
        Thu, 09 Oct 2025 18:51:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbma8sFB3PEmlzHKGHW3FHLP5QcsPnM0ZrTS3vBJAlJtkIEneHrxamRbwItWq7kIrY7tYwMQ==
X-Received: by 2002:a17:903:3c6c:b0:269:9719:fffd with SMTP id d9443c01a7336-290273567e5mr119796515ad.1.1760061086017;
        Thu, 09 Oct 2025 18:51:26 -0700 (PDT)
Received: from [10.133.33.228] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e43d60sm41361945ad.58.2025.10.09.18.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 18:51:25 -0700 (PDT)
Message-ID: <09cec070-8e40-4395-a1e1-28d93ce5a960@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 09:51:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next V17 0/2] wifi: ath12k: fix TX and RX MCS
 configurations in VHT and HE modes
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Baochen Qiang <quic_bqiang@quicinc.com>
References: <20251009211656.2386085-1-quic_pradeepc@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251009211656.2386085-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e8669f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=4rw4-q-ApGJKCmb_CVsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: iNY55rNhc5hirYGdaFAy2grCwBMbYYX0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXy9erk13O8YYk
 ZY5bXNg14ag92WjJYQdsCISibOpq8l71iAfRROpzPu6mrllML5tpRgXUzGaumn91vlG2eDEi717
 PHLYKNjm28YStJkJWRhXiSz7zlzHFjKWQneWSG5kkQHE6x84mKGhYkpUbyCN5K37yOTSZUmpc7N
 3mHTXvrCf163QN5RJ2BBGcSN6N5fKXl6LOGrdhDmHdgqrLi/PjUXN0G+a3F0tQfhwOd2waHFVV2
 8N4Lp0ocDB2gExh6uwt9cpD/kwYhJUUw3f5bIWkoS5ka88TSQwPTBKhAtYzxlg581rkdQia5JlO
 VnNPMrpyBxePEQkdyolVqzguhltlaAmzI73166sn7uXAnQbLN/m3yr6SbEI2VM0GVFm6P7tik3m
 YQUovYEO8q8iXuQt8Cz80Ua6cdRt6Q==
X-Proofpoint-GUID: iNY55rNhc5hirYGdaFAy2grCwBMbYYX0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/10/2025 5:16 AM, Pradeep Kumar Chitrapu wrote:
> This is revision version for patch:
> https://patchwork.kernel.org/project/linux-wireless/patch/20250701010408.1257201-6-quic_pradeepc@quicinc.com/
> 
> changes in v17:
>  - fix spelling in description.
>  - change wmi.c wmi.h copy right per guidelines.
>  - fix missing recalculation of v for TX MCS 160 in patch 2/2.
> 
> changes in v16:
>  - remove patches in series which hare accepted already
>    https://patchwork.kernel.org/project/linux-wireless/list/?series=977538&state=*
>  - Fix review comment on last revision https://patchwork.kernel.org/project/linux-wireless/patch/20250701010408.1257201-6-quic_pradeepc@quicinc.com/
>  - Add similar VHT related changes into separate patch.
> 
> Baochen Qiang (1):
>   wifi: ath12k: fix VHT MCS assignment
> 
> Pradeep Kumar Chitrapu (1):
>   wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
> 
>  drivers/net/wireless/ath/ath12k/mac.c | 12 +++++-------
>  drivers/net/wireless/ath/ath12k/wmi.c | 11 +++++++----
>  drivers/net/wireless/ath/ath12k/wmi.h |  2 ++
>  3 files changed, 14 insertions(+), 11 deletions(-)
> 
> 
> base-commit: 94aced6ed9e2630bae0b5631e384a5302c4b6783

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


