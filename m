Return-Path: <linux-wireless+bounces-23377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A077AC3392
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 11:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1737F175D66
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 09:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5571145B3E;
	Sun, 25 May 2025 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QifVlM9f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4178D5661
	for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748166376; cv=none; b=LxTe473xcIt6fdxl1GkPT03hssFZm70JTSqegyNvftyqZOWj5ln1nYsHjcNPqJupNSYQADYFx+d37vTgk7sNS8x0+hUPlE6xyu7gX4qCDpC/TvoX8+sQe3LiiD308vz8Fm+MYdmNjFaIwR2yHRpnNZEh5o0NYRkmWRA2Ibq4qRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748166376; c=relaxed/simple;
	bh=0wBEbtMo/dEu6nPciUlVjZNzC2evI6460OinFgAKdw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5Wx4BNEKsOjjdkkgwktM089sHTyMa2B0QM8BwT7CDDbc4WDrlfBFZ/K4E2I/DKGaM5o7l78n9lorxkoVMn/szqgZeN88wopb3hsllFFXmhHWVioO/BVX281TBV2HKGqP5iicgcVqJUv54t+6eRPPOxMZZf4IPZUmQ9z0v3+fu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QifVlM9f; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b26f67f10ddso674293a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748166374; x=1748771174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkhLq12mNLSL/Sq/6LO2cG6p6ELKgDsmz2OzqCO1eug=;
        b=QifVlM9fKxNHts/3XOknAFoT0Bi3KhA3UKyB0niuatI2ireC9RyUTt8FPWV/42hH0f
         +49mIOejvor4io3sL2KPG8fDLiKaazLCRq2C1KGf6I1HaTQ4YXtgMttcXG2dis9BYguY
         AfPka8DY/g8n7an70Iki0m0ZBOL8JBev0DFO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748166374; x=1748771174;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkhLq12mNLSL/Sq/6LO2cG6p6ELKgDsmz2OzqCO1eug=;
        b=Vt5zOm/c7JDnn/eC5/tERtbY2ashygzUG+Z+tb7YXxJzugCGUxmgmlB6b5vCHIh9Sh
         gLRMfWq8+G5GLSRub2ShTYhMOiM2DKZ5TrycB6CJbNE40dMm0JJUl9pTF3HjpoEa80hj
         yO9J1kR77o4CsQYKu/z34Kl2KriPCssmLNTzlFEjBNhsujZS02cKqAiuWgM6N8CPslU2
         bFTfuk0X1GcQtLbnQsKdOB2DWPjRJjRD3WKbDTUUMPKCm6+QULRYlCYSRHjnNqXuVIXE
         ifHArzGP9b6RTxdJMzTn1CNnT1La/F+mYVkGkQxsl7YUcnNz17wi0s+/cyHoxzDULUYq
         Qlmg==
X-Forwarded-Encrypted: i=1; AJvYcCVoMjckmUuFYiCrmJhuTCP8EBHcvxLQ7HCka77UpQ5f+vXSldmsvWY3t2t5HwVkmKC90PAfKMslg/CCmA7YYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yynd6JtLTkVqVad6U49orZoDzIAiMl76CKsV1Ei6jrDtxFZGLvw
	+egdO3geg37kz8j8h7fj7beHqMSCy7K5WVuujL0s8ZZoitc8QpK/IuLIFAVgTZulmQ==
X-Gm-Gg: ASbGnctMd9GJhfccJV4pZu6xUQrj5AXbx1r8Oc32ByhnTUVwPD8NQFK3HZRmnXDDcC8
	F8qKFAH3HAD2INtw4EKJ3LSX+OS3B4Az2rt9Lxfynz5oqb3+BKfENYPRS5HmRIIhKcoIO8uqTz8
	1CjsfQikTlKkD+485HXJ4txn2nv1B4+P+EI7q7ORFAKW7LLPckAhvu72xySH4RtY887orHwqE4f
	+Yhn7s/GjccVo5x85pAuHcXHIj2qqI4/ti5bbcbVecK2krnxxO4lqdFdWCD3Z3DbhXBAIGNH8i5
	bK2KuAwdbdRLnYq9I+gs7mWoCwrXyJHNQdHkTY4jskh40Iv8EQoE5pXRffp4cDptKSSOOW2P32e
	gM2Xh2RZzNcthiR8ko3tZ+1mbULs=
X-Google-Smtp-Source: AGHT+IE3q12SpAvKuhj56MU4kYk8HQwHIwtih366RTgP5l+dGpIGx36fkbIQBu9uzwUgmvexa9pscQ==
X-Received: by 2002:a17:902:e544:b0:22f:a4aa:b82b with SMTP id d9443c01a7336-23414f62af9mr94275775ad.21.1748166374404;
        Sun, 25 May 2025 02:46:14 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23429f0c98esm16039725ad.47.2025.05.25.02.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 02:46:13 -0700 (PDT)
Message-ID: <70444507-ff51-437f-baaf-d2d5377adaef@broadcom.com>
Date: Sun, 25 May 2025 11:46:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 0/4] wifi: brcmfmac: external auth
 support for Infineon devices
To: Tim Harvey <tharvey@gateworks.com>
Cc: brcm80211@lists.linux.dev, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>, hostap@lists.infradead.org
References: <CAJ+vNU2pLJd696Fc_98arrzs8QK70HfstPrZv6zVJm3G13REHQ@mail.gmail.com>
 <196d7901068.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAJ+vNU009QSwYopCFzZtwDNXDBppx7L4v_ZKtmNZ=5ep7trOSA@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAJ+vNU009QSwYopCFzZtwDNXDBppx7L4v_ZKtmNZ=5ep7trOSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/2025 1:38 AM, Tim Harvey wrote:
> Yes, I'm using hostapd for AP and wpa_supplicant for STA and now I'm
> thinking this is likely an issue with one of them and not the brcmfmac
> driver although there are always relationships between hostap and the
> drivers so it's hard to say. With more testing I've found that the
> issue does not occur all the time... in fact it was difficult to make
> it occur again.
> 
> Here is some more context:
> - board: imx8mm-venice-gw73xx
> - device: Ezurio Sterling LWB5+ (SDIO single-antenna using CYW4373E)

So you have two identical device running with brcmfmac driver and one is 
playing the role of AP and the other STA. Is that correct?

Regards,
Arend

