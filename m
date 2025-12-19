Return-Path: <linux-wireless+bounces-29982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F6CD1A24
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E013011755
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 19:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF257339B3C;
	Fri, 19 Dec 2025 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgqvxHys"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A033DEDF
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172427; cv=none; b=Jxr3m5MDsftghR8FXTikL+F9jInV0HOXXs9xOOo6SN3rOAeRnPu/nPWVWyG6rvEY3kUcUtwmxFdGibaoLRFbd+teI+YL+qm7TQVx17Kn5ie9uAN+hxBZDsqA7KVoE3TDmmuAHf+ysVvLQ2G/XSHxMVD69FttLi9abjWXknU9D8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172427; c=relaxed/simple;
	bh=k8mZy/7yVU2Ufqg1SNQ09M+d2/3IpCiWvdHzzLcqN/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+NxROo+J1EHwt0k/GxNeU4DMbU6Fjj7uj/06pTz4DAz8LhbgBHAAP/Kqw0JEsVc7Adqb1AKkk49aF5ajnsFxTIT1m+Y5OwzAWgrZOL4OkoKmjqj3JbU2DHiBMRg6kkBTzCi11UU7uxHXlbxFvUV9WKqwPtvRiiBxtikO/a8+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgqvxHys; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47774d3536dso17822325e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 11:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766172424; x=1766777224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kxkkJnPi9GBxxRfQSUamkMaS41d/etdoL+kweUhQKE=;
        b=dgqvxHyscE8x5odAA7E78z5K7MNsroQg+/L9I/uZ9yWC24/bjxq70etDClDf4FCLk0
         qqmhy6JyjnLKZIijjALs5CzjUtBa+pLkMJQMsYNfThiW62tD5qNoA5Teikg+IJxRPqbC
         jnrKPFHjSq5LC/ybxe2LpyzD5y0RCfyN4I5OimlmV1CI8SGKDjW9qCf3yMjbngP1mQPV
         DeAt3Lr0DPx0FVjBkFX33r38fLqrVCAqyTzKXp9TN5bs/Pg84iKaqrvJ3yY7oi5vBbZL
         tHX9lXv9XBFe+ycMNpP4oBPbjRB/cW7pqxKnFRyunBYAcGcNZnL5W1FocrqVwvbkdfd7
         uHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766172424; x=1766777224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kxkkJnPi9GBxxRfQSUamkMaS41d/etdoL+kweUhQKE=;
        b=YUV//QDIW1/RZtElqlotlH0flJ5Z0ChFBxi4ofvJ8guIZc3S9ilueM1UMAwnhRl392
         02n6dukjTYLk4mSjFtjsEzIgAv0mS/QAsD80A84jeGzuqk3OaFYjx1bZq5dHCC/RqmvS
         ar21Lj0EywIX46Q0cHz0qeRrCp2NOaYY7JFrpGw3uRoHLarO5tRgQEuEdD7QUiZWKA/9
         0ZGsooZ1pCYu8pyig+X6xUpsxYsrIW8f9uJQHIKHjqbJeyS3HOdWwfrqS97c42/L60Np
         TXxP3PRZfu+7sTYUicYPeLPqtJlOvLf6yfZ4b/xJ04LepDO7YOxP2ODg44Bcje7gT6CK
         B9qA==
X-Forwarded-Encrypted: i=1; AJvYcCW3ivDVAYTzkRT8eCswcTqIELPWsGGvBVSXFyOX54Vwc5rEKDb38vbjYAZvtOA3wrxa6wKjoRyGeO2JX+g/8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGdmJe6GqM0GDmYeM/igZG24t+4osGVONdDGPHxNP7L6g3PoK
	OssOiK/aDNWaBDWrjGqHB73xUa0yOhwlTq+wgBQ2LkbjXGA6hzdph4Yj
X-Gm-Gg: AY/fxX4kP18WRl5GcKkSiu2/f5se3JnQkt5Dzdy62uQe5qopNw0Kyk2g3myPej1EBhh
	V5PbTCMiAAVt1lWQfV5p/nVtfx23NXwUQxlyUezUXodcuaYavs5iu6Nf0zibtaX7J8Q6IqvSJNo
	PZAuem18VLz2jcQVJzfkrEE9LIHERLF6SQuVK9D+YTW+ktofEQa323BIBElBYwNPJQwU4USRQ4C
	E7t0iJ2+tbktWZjk057j5lV/DxbQ0Une/APaJ0Cj9P9d36BrDFR9fvhzXeAoCkYTnCEF4izaeG3
	2QbsTkjao7FEiYH6folAwH6VSMLLwaAI/XX2o9G8xX8Ykka81vdgQF6D5gG6hBkCHFGZUYhM52H
	P1KJNutFtDMGuVbQFUCzR5dFGc2ZI5KM9KDRvV2t53g/OdjlzXxL7RvObKxUymBDxu1DDdl33Wv
	u2tN2V9V1Wg0VjYstY7DZ3aFAYEDBsoUdzwDxyJiMEQIOuOB/3CaitnHXQPjuY8s/aGGjRQPHqS
	meahK7M
X-Google-Smtp-Source: AGHT+IHqqrUl2vSl0/wNfOnsIYZIIhJ1dpHJbH2MQVzIZ0EaTbpy5rMArQU7ewGjw++aIHXKYVdtyg==
X-Received: by 2002:a05:600c:4f08:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-47d18b83218mr39401345e9.1.1766172423809;
        Fri, 19 Dec 2025 11:27:03 -0800 (PST)
Received: from [192.168.1.10] (92.40.201.212.threembb.co.uk. [92.40.201.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193e329asm57197755e9.15.2025.12.19.11.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 11:27:03 -0800 (PST)
Message-ID: <d4a87f75-92a3-4c09-9f9c-e906f0b7ae70@gmail.com>
Date: Fri, 19 Dec 2025 19:27:01 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: Add support for Surface Pro 11
To: Krzysztof Kozlowski <krzk@kernel.org>, jerome.debretagne@gmail.com,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, ath12k@lists.infradead.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com>
 <20251218-surface-sp11-for-next-v4-5-7bcf83c1504a@gmail.com>
 <de00f21e-7fc7-4caa-93ec-afbcc5d9e12d@kernel.org>
Content-Language: en-GB
From: Dale Whinham <daleyo@gmail.com>
In-Reply-To: <de00f21e-7fc7-4caa-93ec-afbcc5d9e12d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/12/2025 17:47, Krzysztof Kozlowski wrote:
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> 
> How exactly is this copyrighted by Qualcomm? I don't think Qualcomm ever
> prepared DTS for this, so can you point us to the original work?

As mentioned in the commit message, this device is very similar to 
Microsoft Romulus (Surface Laptop 7).

Its associated device tree (x1e80100-microsoft-romulus.dtsi) was used as 
a starting point for SP11, and so I felt it would be courteous to keep 
the original copyright notice there.

If this isn't appropriate, then that's fair enough and we can remove it.

-- 
Best regards,
Dale

