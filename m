Return-Path: <linux-wireless+bounces-30726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5CCD16ACC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 06:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 464DC3036AF1
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 05:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB95530DD30;
	Tue, 13 Jan 2026 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AS6YNNIY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D2CtA6G7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A530DD1E
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768281117; cv=none; b=YoQ6C4xN0cNwShDD1/q/rXiBlV5Bfj9yiukVyG11+7U22nKn/RjCBkdiiApvYN2WHYbkjMlzB7lTHU4RE7mc8PYb31/Ozw39LGekX01HzMVoJWtaVT5sK/uIFjsnPej+r03rprgCPNsRKrF2hk6C3WSHYL5cmhvsxwCEuuSs5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768281117; c=relaxed/simple;
	bh=9V9BGKP6AS0DETGTTCUehL6WmOt1VhhODbQTAcza4VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjEYg7rffupgvHjyBMXnrIV+P1SOnajFLp3yALkD4h9K2zdRuSl8qKWOf7uQJy25c+qvwE7aeU945S4rMfFuCv+Z35H9lPL+88B8aVpQbe4Z5llmCGtixMyR/hYSpso+iyYDrvomEBw7r8L0C8gvgyu93DPZJvy4YxCgJoaH0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AS6YNNIY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D2CtA6G7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CN5TYx177668
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 05:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8Aa1nzw7+y1VhWnN/zEX2SxtNWQMkYil7Jbl8sY8zM0=; b=AS6YNNIYdvySE3rd
	Tcw277XPOUzmx0lf3yLMTJ4ZDlCjt+/iF/bMwPSnjC9YmsM2j8Usuk8HuOKQAhOw
	j/HhaJQn/utnEv+YbcLKEojorZpr2DHzwnYNMNIIxKPOZ21b7ksChU1ddmtj6xvn
	yUNBNUG30g6tg7qJd5XALOMjx51MlhKET93BEliJU8GSj0Tmj5DiN+/+K1Ye2Nqo
	q8ZxMmRe+vMvPA+xCE5AXehvHnLL703ghEEROVSiLOUSKA5FFFJ/AJkQHgcLIRw6
	4CHBXWddDgSixFW9mNOab45jz4ZWD2OIhTwEVtqVK/lNsTzxAc6ywDeRVxSknbpR
	IoknCA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn52f1uka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 05:11:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a08cbeb87eso80855245ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 21:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768281115; x=1768885915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Aa1nzw7+y1VhWnN/zEX2SxtNWQMkYil7Jbl8sY8zM0=;
        b=D2CtA6G7RDoYEnp0Tl7/BaWnu3f3EByBkzO2/hujx0Wz7Kq+qY13PaXILXIOLBEQLO
         CLKbZg3HD+r27kmkNQs5eLLJPQ/KJXUxK3hflj+jvV0BKgqAyysUUYqNnHEnzZJVpG9U
         utxXtk343VNjR6cH/s+EM08eK4QTHiA4tpc9HMFj/xntVwc6p1TglH57WzUgFGr+/Muv
         ofbvHg9ra9WutMM3IsepsG/ffaOc3FD78yrLz6X7ckiqK9XDVIk6pYEhmmzUY22VDEIV
         QqUHM7JIwrYdB5GeH0q7N9UNOWx3E6tF6fb6ENfdDDy7Cbq6fTOKZWRg918bRvn8Cf6Q
         mMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768281115; x=1768885915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Aa1nzw7+y1VhWnN/zEX2SxtNWQMkYil7Jbl8sY8zM0=;
        b=CUfTjriS5Q8W3B7x2ZdZVnU2rtJ1eWbYr9Wo2qSVwSxDvCPHaJ1IQQP7nyc2UUs8f5
         Q09GD0i52O2axBZhfHdzV0Xi97D55AIgE/u5R2ZAUN3FA/GON5EJOPi0xHnMS16QngKw
         Hp0g/d7MTpLfQyu5LnhsW1VVtyY22WmQvrzvuUI1V0U19/t55yRNb8H3KuSH3itEwbmc
         gPnDmiyqE7brwmv5nrXPXgLmjJKG5AFJgV0lEclG2YOCntoiElZ7KfCgGOUg4kQ6iaeq
         P3/+OEew9M2bIcvgvSSq0DI9AuGIRSqip08T8hIYRg9Y3cTpyjPhwzGZ2fKq0tT21d6c
         wTKw==
X-Gm-Message-State: AOJu0YxQDfMWLsEtKNCLIxBzjpM7vly0K4VNaLTUM11iPAZZp7P2Yk1B
	ttKhXJjkhT50Celg7T5bqIM1kwIuZvCz9cCg8GNcgDkqeSngHPT1Io9hWG9ZnJQAsLEFd51VNzK
	Fhbd/gMgBhqd6ITHGBWTG4leo2rVFmOwJiL9MaCJ27BOqQkUrULW1ZScg6ZhPev+7qjWeugJ0Bz
	a6HQ==
X-Gm-Gg: AY/fxX6Fjosov4rK8i036bQ3+Ko1o2J8K+alQYF49ei0g7sK/cNMjc47pDwbYy+L8Gy
	owwCAJNOsdVCgsJerVSMma5rtAKYlLIExOBkvTBdmZ5eUmVIpsvGx1vgrUetIUOJNOtFREcSwU0
	NN9vCaJGH2MeJg/6pRRaTxqLfnb1D7Wv0dNIH+w2q+bLNeQGGqcsh+lGSrKGyHN4tVX/FvN0O8L
	/6QTcDy/ChCJ45/sc0XavAvikELBQnJ9D87WDp5M9L5bedChgynUzBzK7U4goY0yT3qO36TyHAQ
	et7BxxMnCCLPIsI0mSt4znK+YasKKLGQvFizwPGquYZTWYWtFi2c8wMTNxs+kf66A6lHBshBiTP
	U0gU2EO+OsNNnsCuXY/rhVsUk0NNr21bjVTOCHmiAoCTHQAfzo6jbOew=
X-Received: by 2002:a05:6a20:1581:b0:363:b975:2d80 with SMTP id adf61e73a8af0-3898f8444c6mr19052322637.13.1768281114875;
        Mon, 12 Jan 2026 21:11:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyu1wWxLwbxsyrgbviogjx6rC4x2l3qjNLqxuWz5zVR/HUw0RClylu0/Rx6Hkd/3pvPl8hFQ==
X-Received: by 2002:a05:6a20:1581:b0:363:b975:2d80 with SMTP id adf61e73a8af0-3898f8444c6mr19052300637.13.1768281114419;
        Mon, 12 Jan 2026 21:11:54 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f6d3sm18763026a12.9.2026.01.12.21.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 21:11:54 -0800 (PST)
Message-ID: <c258e1df-491b-4622-99a5-a276eb6c8fa9@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 10:41:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: Fix scan state stuck in
 ABORTING after cancel_remain_on_channel
To: Yingying Tang <yingying.tang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com
References: <20260112115516.2144219-1-yingying.tang@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260112115516.2144219-1-yingying.tang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA0MCBTYWx0ZWRfX4BLRXFbDzpC6
 d58vqlqN8Eu1BTEM3+sNnvQ3LFFqD0qGJbYWJXZuhnpRWSu6xHn2Bqtew0pU8rncZuxMIbFcfkY
 ZCxAsnLWJPLHFJKLJExTNd0brmNjllp0Vxub5ELKyNlD5bSmQDvIxQzIkBJB+U2inP/sU3Hu59k
 nqIDIvSHppa0SYp5uCwhvEYDsAE3kaloCNSS7YXE8XXlc9eGxcvPlH7wIVz36WeIkYll4aJ66Hk
 3IhbdSfBAT4F/dXN0PfjNnCDTDwAiAJeSeRaXKbSUNQ/b+ZF4fiLrcwy+3g+9pcuCXTojCbSu1x
 2bhLLhdt4OtmOuCRi8jUJFJv0OOFhDC9xQULSHNW+gVQyxSrsn9tLMGJ1tHpKmWhQUVsHlM9OaC
 Sjun6ocH3QYtJufTWkqC8r+sqsreJ/usl/Yuh95F5PNElzGi24baWdkmaHI0GS7cz5bo1DY4EWW
 7/WzGXJx6q6/tIWrp3A==
X-Authority-Analysis: v=2.4 cv=TcCbdBQh c=1 sm=1 tr=0 ts=6965d41b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KdEc0S3GmNI-KGd16cMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: tVi8p-XMvglSErisRIYRkuVPPH1zSPoW
X-Proofpoint-ORIG-GUID: tVi8p-XMvglSErisRIYRkuVPPH1zSPoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130040



On 1/12/2026 5:25 PM, Yingying Tang wrote:
> Scan finish workqueue was introduced in __ath12k_mac_scan_finish() by [1].
> 
> During ath12k_mac_op_cancel_remain_on_channel(), scan state is set to
> ABORTING and should be reset to IDLE in the queued work. However,
> wiphy_work_cancel() is called before exiting
> ath12k_mac_op_cancel_remain_on_channel(), which prevents the work
> from running and leaves the state in ABORTING. This blocks all
> subsequent scan requests.
> 
> Replace wiphy_work_cancel() with wiphy_work_flush() to ensure the
> queued work runs and scan state is reset to IDLE.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 3863f014ad23 ("wifi: ath12k: symmetrize scan vdev creation and deletion during HW scan") # [1]
> Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

