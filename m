Return-Path: <linux-wireless+bounces-16324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928B59EF97D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 18:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BAB28BC85
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D028222D6A;
	Thu, 12 Dec 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i+pX6Nr2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B421421C
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025872; cv=none; b=RziVSGLDJwuAH1rBZxJy4/sQUj/Zt+1F6X8CdY/IxEdR46RApEAtXL/SSJKCajdcZfikNRnuVuUD6OOKS9adVn83Fikvh/9JgXpBZUt/IZBWHxArdpEB3tUGW/y7QUpWQ0K7B/Lv9TLVpQWItuE0NoLNspVyBDd8syjiBSMxdf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025872; c=relaxed/simple;
	bh=8d1CMsRfUWEnvWhx/xRqMX4ev4W4N7Ekj70gC6SUeQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQtwy1yGvXg3MzcUf4VUpC3/4Z7oGWHqmKTlA+OpTA3lv0lf2l1S/avqbM2mUpVzTOr0WUByAwMRXas4SIU5YKPcLAUF2FgjfnO3tFuLJ98apGxuS6Xzkzva47c7qkRAJ2WxS2qaXChF5BEs7a+ItRtr4qDsxxHD4mxXkaUtk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i+pX6Nr2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCDI2Dm002014
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 17:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d/Jv1vc2gsYsMdlLp4D9+fe7WyEROnGpSv61ypMLHJU=; b=i+pX6Nr2rHHvGCjY
	YACfCl2LsNuc2GnZTGOCmHIozkPsA/Qf8SHgiUXO0guJVyt+Rwz+8f/Q7LJ+ORLP
	Bb9JQkhBkK6vRfGylByUwSniJCt6lqENh48Lt7OWKsCaQ7V/2Ztym5g+WhDSfsBT
	/P1+N2bhHal9kqRmhnXYmDBYssX3fIDGVnJOGHnCXmVZ2FNbukFduXOuvaxq06IR
	WC9saJQX1pgRnn8jQABiaUfy3K+9VC7iG3xY/2tYE/2mLAIQ7NMCDcaLfv9Q7w9p
	BkoaQQKP+fGx2FZg60d0frkoEfDk7FD2wVuUkjKGu8iWAys0ZOF+PBqvnaAKnm6z
	XAY5lg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40ktsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 17:51:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21640607349so11232725ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 09:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734025869; x=1734630669;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/Jv1vc2gsYsMdlLp4D9+fe7WyEROnGpSv61ypMLHJU=;
        b=UauCP/REJYroMqMp6NnIFheQ0essjVVpEpvSL8qMGerAEkFng12T+t0DMINOf7M1ij
         txJEwfIjxnwPklP1dCDreUCvCpiFQePALUVwcn9BQZ8gTdO2HBAHEI1wuJI5fNSdqFXm
         Tyh7rLOr2IWBxGWK53wQ31L323XWEZBZy0izp/j+mLKFniPjHq4Hf5ZYVIs5iMmSk/LI
         ftGahX+7T5DglJByw+GBTGJzG9h88pSmt3ltsqEFEafQvX5FLDr37C8LtsnB3GvThoVa
         Uyum8P7c8asYW+H3v8HEh/Z5rPy85E5dj7N13WuvbyZQKk3zL/gRmiNdRfjLFcbZQWVS
         L6QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEiq9xonpSWcJKTlah2izqzrUcXtuhyIstiHxJWe1dZkQIvYdl69K/yRVJYEqe//Z82ErcCaPAnly//BJmmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmNsHuZLs+3lVJZFj2bLrdnuv992Prhnff2O2G1bjNxcieH9J
	x/T8VSFMlTh3MjrQ9ZzOrsTXXe8kiFMBjPUD1tUkwOrudoZM26c6ii9kRv4zanhYd6ohojf4fR0
	8Ua8optaaxzph9m48uwNOe7aYh/K5+FjXEve74X/Er0LnHB8+Yu7gXrbfUV5Qz8hOIl7rG5jccQ
	==
X-Gm-Gg: ASbGnctkYvgKhvrWfyrjheBF0I7J6UecKQyceZQiAiweugFQiesotu9lWINTX2XpQz/
	Rv5v4MFAdaLvHzImMtMWVyWboAAHTMLsjoSHKz8oOGKD7+SnVdfZoZ8fIXEuLYBn/cnRqnJ17AA
	54nPBwuf/yNjfpeFkdBJp+RVkqijFbSkcoIWM6M+4EH1trd0LlRzbYbNgpOzwdr/PDk8qxxVW45
	PIWDqFOCYTG+8KoTQ29RT/j/BP3a3hxsUSQ1kJOyf3E03gjVKqvyWQWLLSaDW9wTk3OWw/ZOv27
	caSC5dNB/3DX46qR+JagmwE1R4xT7mYeU2S/HL3a7QSQaNJUQA==
X-Received: by 2002:a17:902:e882:b0:216:6c77:7bbb with SMTP id d9443c01a7336-2178ae6fb8fmr66257535ad.17.1734025869210;
        Thu, 12 Dec 2024 09:51:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsfTRZMlR3OeCYRFbEgDdM7Wjv4fWBG376wW6arwrK9P4ZUwOmufNbI8IvLWEqo6PfdZNr0w==
X-Received: by 2002:a17:902:e882:b0:216:6c77:7bbb with SMTP id d9443c01a7336-2178ae6fb8fmr66257235ad.17.1734025868877;
        Thu, 12 Dec 2024 09:51:08 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3f0b5sm125923045ad.20.2024.12.12.09.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 09:51:08 -0800 (PST)
Message-ID: <27cc63e7-1a63-4ba5-8c7a-12a78ad6d9fa@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 09:51:06 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] wifi: ath11k: Convert timeouts to
 secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
 <20241212-netdev-converge-secs-to-jiffies-v4-2-6dac97a6d6ab@linux.microsoft.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241212-netdev-converge-secs-to-jiffies-v4-2-6dac97a6d6ab@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vMyAeUVRgEPFe5bdj45Npa0HBfRiYPXD
X-Proofpoint-ORIG-GUID: vMyAeUVRgEPFe5bdj45Npa0HBfRiYPXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=773 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120128

On 12/12/2024 9:33 AM, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> 
> secs_to_jiffies(). As the value here is a multiple of 1000, use
> 
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> 
> 

something is wrong with your patch since it introduces a blank line after each
line.

Also if you want the ath11k patch to be taken separately, it goes through the
ath tree, not the net tree.

/jeff



