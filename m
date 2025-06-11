Return-Path: <linux-wireless+bounces-23987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF283AD55B9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 14:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7A61BC3695
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B0627E7F0;
	Wed, 11 Jun 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+FE1Y4L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B127FD7E
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645477; cv=none; b=VEshfZnTAvaIZjxV3VzTYKc4Ew3x9vNSfQYBbUYgnR0rAm7KVu29Pc0O5auROEd5zzWRw2hn8SMlAkS4yA1SUXBJFF9rzijIHClG5Sd03u12qXtdBSo/dlvk1Aqf7OuUSSNCMg6Lo2N52RogE/MrkmRrbfajbygqzVWKoIovov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645477; c=relaxed/simple;
	bh=N15WjYZh9zLHOd5EXWKe6oFGkNk5YRdrD9gGPdCvDCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSVj9BinRdDRQ2SIjnOO3SHjQx8n76zBq04BMImC+wjGzNGdHH1AN/xp9eY4EYWZZr+088STwAzJWT+wKtMhiBY4ZNY2+gye/1TN6c3X1ZQut1tmq57D9B49fn5u2fgyxSsbJffyHooErnAyIRsXR4I5M2VIXTPFEFlulyXCvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+FE1Y4L; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad51ba0af48so176765466b.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749645474; x=1750250274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOXeYQ67MJKyIBb8UNaIQyZgXOV3VN582lWGBgx+72o=;
        b=j+FE1Y4LweAmJtzC/z+6aaD9gHRptmS5D+R5UH+/rpik+NUFw0HswqU/a2/naWaXea
         CL5y9Yx1Kj+LScIxAFnVzR/eYKuEb7pe2A5UHgDj+ZXFs03f/t3A3qSUWR87Ih0A1NtN
         tnAZiEowATbZ5z0DUx1pOF+chb/aNeAt8CiadQTspPxQluZHHy0jguDy+GzpiUolS3yh
         qGVrcqzlkVkr+Okz3QkYCF1A1kjzkD79i5Qm+vsOWLAE+yS3sdzVu6dME0BR5MhE7yq1
         qWtjzVWDB73y9rYWpDthA2QgF+01vWkMPQ2Ugq5M66fpBE+TYR9fscao/S0NjpLmzeZ1
         A0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749645474; x=1750250274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOXeYQ67MJKyIBb8UNaIQyZgXOV3VN582lWGBgx+72o=;
        b=ecTkuJ7MZ8thg1CKLKQIraX3UvHh29HMxvND10W/YZ1MTZC4rNXkZV4uLv8VXJAeUF
         CEuJmzIbCgVcLUhHzceQeb+yUjSDVRVK6xj8flTQsaiiyCdqQvAaEsBgaGRsTsShYMNm
         ZGs4ND2YjfPbjdm+1x7bwxe4YB7uIqZ+O0dt7e7suSDrhjbJtuPyhe3T9W0kLZrGY9eJ
         Bkyt7Jt+wr/qHn1Dd2C5NEi+JDkVYJnwyipyZnJherXqkiW93SPsQn0kurZ+HHs7kt8B
         g0LAgNX/9qN88+iBhqYYKHYwD1lcs0lU/rZ9+C+zHTRno/qkuVkZiUn+An6iuOoD0cve
         Lu2g==
X-Forwarded-Encrypted: i=1; AJvYcCW7/rVQUC4RgJ8FiP0BewAJqbost0UVM0iTysg+Tz8lkA2wIqQhTGcGt7qoZBy4sl7HEGReqc3ACfwN7oRYCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlJ5zazw5oZkVI21hKKg+RAtgUjS8gtZmYmiHCnmNYligD9YQ
	zBRFGLID6Oy5iMVaeQPCZr4WeV/3XHSTuvwy8qLMy4z/sTvf07ioF1RmR+8LdQ==
X-Gm-Gg: ASbGncuE5OyZAWeXlUrsVm43QbRkBnCQbjeJzD3uo4cPwl55NoXnrVY/A2QDYI9dZQG
	SOu8pbLk+aszZE8tkPjS0LGJPl5q7PSR1APWf9kBI+94M2rz6MXQXZ5fLSajKfKGpRK2p9qOPmp
	0A5IUA1Mwc8qVOErOq8+OWAa5snOpKGV3Kgc9qCL8HTFcaKnbxfZJBJRoAxWMzTUm2fFrdTXmtP
	oDUSbHQfKAQt2gYjc/c2l7QF3C5CTyvuK3DQF7JxXEVil/mGYvDR9AuFqSV+uYsmyl0JQpZJ5Hy
	n6ovblcbLoXQNcJZRht5fFW6j8sW0LjoklPRXSqOffraxsVRTfiwrbViMiKM4smqCkG0QQ==
X-Google-Smtp-Source: AGHT+IHHW+D0ougV5xir+6/KUgrN2c375InXtK1X/YNGb9P+kmswRlnqPox8eAbXSjO5ZlB2QjfMVw==
X-Received: by 2002:a17:907:3f0a:b0:adb:3fb8:27f9 with SMTP id a640c23a62f3a-ade899fd6bbmr285978566b.25.1749645474014;
        Wed, 11 Jun 2025 05:37:54 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc776ffsm872906766b.152.2025.06.11.05.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:37:53 -0700 (PDT)
Message-ID: <0d712ef0-ea93-4825-8a4c-45f9d7f9e8d9@gmail.com>
Date: Wed, 11 Jun 2025 15:37:51 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 14/14] wifi: rtw89: Enable the new USB modules
To: Ping-Ke Shih <pkshih@realtek.com>, kernel test robot <lkp@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
 "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
References: <663044d3-0816-4b1b-874d-776835e774e9@gmail.com>
 <202506101956.cNXM2Qvb-lkp@intel.com>
 <b8690413-059d-4330-992b-36a7af10aa30@gmail.com>
 <01eb10716bdb4241a012d378d1f7b67d@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <01eb10716bdb4241a012d378d1f7b67d@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2025 03:32, Ping-Ke Shih wrote:
>>>
>>>>> drivers/net/wireless/realtek/rtw89/rtw8851b.c:523:47: error: use of undeclared identifier
>> 'B_AX_SOP_EDSWR'
>>>      523 |                 rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_SOP_EDSWR);
>>>          |                                                             ^
>>>    1 error generated.
>>>
>> Oops, I'll add that to reg.h in v3.
> 
> The NAPI also reported the same things [1] [2].
> 
> Not sure if you will send v3 right away. If so, I will ignore v2. 
> 
> [1] http://wifibot.sipsolutions.net/results/969980/14111187/build_32bit/stderr
> [2] https://patchwork.kernel.org/project/linux-wireless/list/?series=969980
> 

I would prefer to wait for your review. Is that okay?

