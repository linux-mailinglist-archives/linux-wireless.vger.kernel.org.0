Return-Path: <linux-wireless+bounces-19599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F005A49FCD
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 18:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D79164F94
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 17:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7749D2755E3;
	Fri, 28 Feb 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RvaEOCPP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A44274255
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762458; cv=none; b=kCr/IMKbBJHpw7NQ1iXoWLuCFHJB2DUAUFGVd+RFEgJyzlpp4t+rA4YkjPLlvukLllhZGCgjXkLgFby2sc+HJGuilwd7n5wtG6baUtC6kkCuUFZlxqBYWK1P1i/Qy02IjmnI+andbbl+fNHTFgz9DJv9Ypie5Ez9soS7sTG74No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762458; c=relaxed/simple;
	bh=C2fZ4SBsHF3j7jycBO4AvxzSaVFIR8J5mdhIZvJyKWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBdIaMNl0AixSIV7VTRL8e2a7P0l2c5tcNHQRhmrgzJy6KjgHdtCeqglw94y/O20h7xpzBEfDMcqEc1A7RDRHDxcNKpJm1XXJY+AgCFrx8e/Tkfw3J8gjj2qgvN9e6Wt4o3twFQNi5pHEHlc0I1RYE95sHDQdOm3jVdV49dWxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RvaEOCPP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXMqg018966
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 17:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w03EvNkmgGsEYw7MVxLcdlGbwxuHVUXTAOgcgpkzv4M=; b=RvaEOCPP2CqdlTEx
	YmICOPsvT8qDNLF/rY03JeVucRCUWDlDCxk7VMqdR/MKLLqCZsXsFSL8pXs/Stjb
	w5jSTiS2EyM84aqSeEzjMizz7qfRwGIeg1FmaGj7JZyuVWRX8TxniWWNJvO3RjhD
	8ElwnNl6jLWk+jaPWohPyzmyv6zBsONiYpv24Sbz6EjcZTeGBZMbx4R2fKJHyYo9
	hYidZ4SEDB37DSwiYfUsvCgS8rPQMej4jDRRKVXyBzEscxw42QyGjjf7BoeY3AgQ
	OzsV7NQq5fbl9FNt/8gIDR4JyhTDu/5rqc3aSeoT6YcxpnOHWotPJwyMdFaFrI2I
	MKSSug==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prna0g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 17:07:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fea1685337so4332334a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 09:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762454; x=1741367254;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w03EvNkmgGsEYw7MVxLcdlGbwxuHVUXTAOgcgpkzv4M=;
        b=CN0hsqT4L1hzcfObYryDzxu/PAcJMVBjuzIoagFVOPFgewFkPQbSp6MB5kttGQrbw5
         FrvzqEU6A52CN6mbv5qNN4b2Bgxbw0J/erCGT4WxWnD0WhXdhRUAndELzQLqveJRstvw
         OgHCtX6EPhfLnNtIUKjROlI3TKtDwXC8qZgGWRaa51ywX3yAEoO423eb+lTBwUudAmK8
         rztte7x5QjZScvfCuPLeRkDaZ5+2DuXnV0GlmWwzygLOR1dlqK02KkJmU/P+m4Z+NdkR
         PsY262Z3utEtv58fkDZJKhw97kFWSpwN624PmBwlJidOoEYEl+UAde5EqEdJZ6SpJr/u
         U7Jg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Wwaq5zEcUrkoiUxp8YdyxwUO3aTwc4MPO6DCIUFedTQA0X9A9LasarS7CqiJTJNQm2pQ/fT4ALsCLg1KzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJECbJIqSC8pGrzLfDF2XDeK2GbPjERvg7RaT3VGKK36i2kcH0
	fQRlySGNnuK/Gj+STxLd6nAFCIr07MiXY+XTFCkunbmjj35pRbinGURa32Ob3pM34ay+w48o6pK
	c1Hhd9TUjsBK2eFSLmaMQ1mLTEqjhv4ifF9TD0Rq5Kh/xg1AxQgRWNq24xwfDt3UTiA==
X-Gm-Gg: ASbGncuoZDKUXVX/lMEVViZJ4OqHKA7ekg4grr1UPDaiWZsQkWlsxQEhrkYJkXrlYe2
	aPh39eUfO4Pk/+y9Hbu5BgW8wN5NBO9exnH24bt8haXJilJ6Y2R4ZVcZtNq7kCSPNEijFCuPJMy
	dV5Cfl0TZXflusx2uBOMT1Q1opHAlmxLAGDoNxMRhfqpjOwrVvaX9/HGxPjzjgi089GuRNJLKP+
	GGML4F/Por+KFM+U+Itcn+M8CP9Bnn12IlsJR/iOVjbL8H2S73WGbkI+CLUN6YPurdWAdazsrQN
	ZHPR3ZEqhB1rdHYT6g6Lvd+Ns6dcQzztkP9zQNs8EZHAugsnMMcNU/LVQASZMMCqcKzbQaUf2FV
	Uo4WcDswR
X-Received: by 2002:a17:90b:1e51:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2feba92bfc9mr7182352a91.14.1740762454209;
        Fri, 28 Feb 2025 09:07:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4woKH6wlCEHEAUo+YddSp5Hk9b4m/JxWUHwlF3vZcka5jmfSVtvgX0c8jPPD9KSmBmIjhjw==
X-Received: by 2002:a17:90b:1e51:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2feba92bfc9mr7182301a91.14.1740762453739;
        Fri, 28 Feb 2025 09:07:33 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea679dc51sm4036250a91.21.2025.02.28.09.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 09:07:33 -0800 (PST)
Message-ID: <1f8fa248-c18a-4bb9-b995-0961f7f3fa37@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 09:07:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k: WCN6855: possible ring buffer corruption
To: Johan Hovold <johan@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
References: <Zh6b-38tGGXo-ee7@hovoldconsulting.com>
 <Z8Gr-IMD-UZTU-X5@hovoldconsulting.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <Z8Gr-IMD-UZTU-X5@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DC7w-vsd2uNYI4mdNM4Xf0E6uOHLCZ3z
X-Proofpoint-GUID: DC7w-vsd2uNYI4mdNM4Xf0E6uOHLCZ3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=964
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280124

On 2/28/2025 4:28 AM, Johan Hovold wrote:
> Hi Jeff,
> 
> The ath11k ring-buffer corruption issue is hurting some users of the
> Lenovo ThinkPad X13s quite bad so I promised to try to escalate this
> with you and Qualcomm.

I've escalated this with the development team.

/jeff

