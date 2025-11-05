Return-Path: <linux-wireless+bounces-28631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF04C36C5C
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 17:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8679188913B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86C2C08B0;
	Wed,  5 Nov 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R+at9QTk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="en8D6r8q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE732D3A80
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360841; cv=none; b=JpA8S/7gOyg+UmNOMTJv/uFd0oaj1tKjkNOs3HgQwgILrCzSPoZKtwEidi5oX/Fbbz+TE3rcY3LSeYqme6Q0WHwQg5FNoCdrqCJFhyqmN5L27TX/UsMWMAA583NWwx5VaAgyz+EHYJRqRGZCP6PgYQGfxdiVgoeamFeUOLQwvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360841; c=relaxed/simple;
	bh=5WT4F+q0ApacVZYFiKRD3paH1wG2irerI9GTXm+KLwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsK7DKE/lgAmBoO+CVOJJzXVGABdvlYQc3wzxj1edQZ+ot872Idh0Od++CAdzjCBXlJHgjvgpmCySbO/A1TW/FK2l6n1LA9HPNvUM7iLJ5X6I5H3sJRHBJwjc+g60RI4/pc4Va7lxUoXfFRDf2Q4gprpjztcWZMlsgPNtvyrruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R+at9QTk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=en8D6r8q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5G7OOe159433
	for <linux-wireless@vger.kernel.org>; Wed, 5 Nov 2025 16:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LjtlWHiWbnGMu11mOm3DmagPhKzWAbM1CNPMgeHvHzI=; b=R+at9QTk+ZZd7Ltz
	LUmqO9ouKQydIIefxVD2d+KI8XSUep2nNv9mUxRy1bocCaDhcH79aqZNE6wVljpP
	wG8CJMC4J6SXb+92Ff9/6Czxne9WOEW45IXb0om3lYXLUFKlUrB+x7QfRb/SlFEO
	cPdefAAQfiPiegjCh0CIcLnUL+v3LY4DvFOyzqemb2kL2T18BsfKYUGYft3iy7IQ
	/EpBrNl7ZrGq+T0xymAqZmxdakLVCdjF5TP+5ZPjjmTH+/0x8dZmh0UEQgSyHWSZ
	96PJddmBlX9JBG74LLroYrVbigybN55gMaw6lanNBC1Aa415Aj6Aq02FfVNDSeJw
	DMCs5g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a82mt1gpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 16:40:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-295395cedafso626165ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 08:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762360838; x=1762965638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjtlWHiWbnGMu11mOm3DmagPhKzWAbM1CNPMgeHvHzI=;
        b=en8D6r8qad1GFtx3NNHHKrZHhBjzOhfthrJhgwGyAkSnrBtcq1Ybb0tnQlSYX5njwi
         eJ+rHAnbQWbEayV4xpYTSsbMSCIDu2ibaLN7wllYrdOmUJw2NXHqlY4jNPbraxbTJHyV
         g0q+S32VBGPmXhHMSGUIejAVEQjThzUctxEOEsz/kgG+iEr9Vm2DW0LZu1+yx7l7MNIf
         tYmI6+hHlZ0Ari0hSmCU+GbA06wQZd4eNLVy/VPsYB2YQVL+yYYJB1fanQam+eLA3BSB
         hmXyt+8d5M8DjbONIFve9Oa0jSULteA4Q/6fIKBURn51v2NV9vgfQtRklOsnZbkYMof8
         Hw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360838; x=1762965638;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjtlWHiWbnGMu11mOm3DmagPhKzWAbM1CNPMgeHvHzI=;
        b=ZaTRLoToyFpEv7PMcF8qptJPtm/BFZ4z9TzQlWVBs0J1BwvrSTbNW0HaD5/kCDgJUG
         nij9OBnsD1xF4w2sKdaJoQX152iVDoE1pzvkOe/BSDYITvnDUZb8oN2N0yorgHvi/MMr
         HecyfFADahApDydBA4OGy+uT5q/jZd0mv4DVKWik2lZR23mh5NkbMp7uqr90rLRs82LL
         qC6sHFm2ZTtknEghXh9FW+VpssX1RrXDVcU299Wez8ewK7UspoYFFvyPxOSGb0vLDc0L
         PG16E9pIJIScoflT83/8jtQ8l6iYP6i+LNZgsvUwEOfvFcjj3F4jmd+rBwsNZDUsOrUM
         AOPg==
X-Gm-Message-State: AOJu0YzWbcYYjnmEO0ofYdGhnrUcxPBfFlchlf331s89ez9rfzRtUomL
	TPQTZ0vaLZJlrlrBoX3oFSXyEDfL5Y3dZoepwR9oGZBsd6eFOp1A4aQK55zw/dErrNdpCQdGaZX
	iAqWnGvvzt/cvpyAOW3kVVQXy2lskbvJbgjiD0DecMqfeEfMRRS3dLL8irebrsh4jqLhXvQ==
X-Gm-Gg: ASbGnctjZnZQZ6ur5X7C5fKWTqLa3HMFGs3RyD1tNllp0IreXCvQfsMkeVcJ8y8fIsC
	rXH3OMqdbfJ0Qk679HXo5GZ5NF/3KcCr44/JRvHyb2Sd0jacZZlrbmTgdNmiEC/kCeRZbsos18m
	wt/Cn0W4xVBp6c+8gfeMEBLv9pMJq0g9mCUB9SMhA79TOZsttWzOUoVuB+2U6Oc8vzD+/S2ejE7
	dso9B5HLHI0OQ5qJx+HNZoHLaZGOw7bVuIGJkCjyll5NMOoYCM5fymkcP8dIcz+LDbg3TmZZw1K
	jnUfV8yVDUbFNun2vidJ26LaOSe9NV8LGok/JCr9BbYMDblaJ66DDeW76Zoc+iWMbln57KQfq1C
	7BZc1cWWWjBt7S50b3M6PwoY5dN29HRofaBfaHVi0yEBCgIlgxf55z3ioIpo=
X-Received: by 2002:a17:903:4b4b:b0:27e:ed58:25e5 with SMTP id d9443c01a7336-2962adb71ebmr56662775ad.24.1762360838121;
        Wed, 05 Nov 2025 08:40:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU1wG7SrVOBifVyXvrQxlQrZHZnlL6f9/iHFaManIM7EnVoItZT5bj+dLM5Z8QOBMAYBb3XQ==
X-Received: by 2002:a17:903:4b4b:b0:27e:ed58:25e5 with SMTP id d9443c01a7336-2962adb71ebmr56662495ad.24.1762360837619;
        Wed, 05 Nov 2025 08:40:37 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096dbe4sm220375ad.11.2025.11.05.08.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:40:37 -0800 (PST)
Message-ID: <86231f5d-2774-43ee-bc67-ccabdfe5af69@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 08:40:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath11k: zero init info->status in
 wmi_process_mgmt_tx_comp()
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Nicolas Escande <nico.escande@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251104083957.717825-1-nico.escande@gmail.com>
 <3393053a-7f6f-c7f8-51c2-60b9a4577808@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3393053a-7f6f-c7f8-51c2-60b9a4577808@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyOSBTYWx0ZWRfXz6uUUtsolmNV
 t6rJKrgxfSfkOXxaRgeDhsAO+SutkqvLyHF6gwUrjg23KTa/8PFqV7wfaX2ftZhed5ojvyYEkNK
 ft7G/qISWMM6ZzyvKmlEl87/J9fSZiFnZ19dJ8paYsEYqeE2HzrXYvyUHLTKuwZmCuY1WLIm4Gi
 8EM+J5IZlFY1TC/LH2e5AN2eLW55ooC1m6csLVXjPXbhGOTSSN7mCuhttUNljQXHk6gk4BKqpAz
 eiLRRdkdIycMY2+5XP0q8uPQI1t3ODd0z9grBPHhHeI2Y4E+a69ioiuxmdQ7O3kb5e0W1teq4RZ
 HzjqtGlRuSO5cVzmZInP7UBdtlLqnT91hCr1A60TfXtIXjprvAMl75Qpik94Zhvn/qMc3m9k+g4
 XNInIkb9UJ1fwUNlq9f2goVKSXb3iA==
X-Proofpoint-GUID: AJKj7pnKA939gkuN7uuDzqCRt__aEKMf
X-Authority-Analysis: v=2.4 cv=LLtrgZW9 c=1 sm=1 tr=0 ts=690b7e07 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=fv_0YGrm1KOP24S4G1cA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: AJKj7pnKA939gkuN7uuDzqCRt__aEKMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050129

On 11/5/2025 7:53 AM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 11/4/2025 2:09 PM, Nicolas Escande wrote:
>> When reporting tx completion using ieee80211_tx_status_xxx() familly of
> 
> nit: s/familly/family

I'll fix this in 'pending'


