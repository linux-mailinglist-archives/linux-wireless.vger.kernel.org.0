Return-Path: <linux-wireless+bounces-15710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6DE9D95EC
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 12:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A1E281251
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081611B6CEB;
	Tue, 26 Nov 2024 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SulycnfQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A47DA68
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618932; cv=none; b=RgE9EccBrWnUippteLqINSGu4eL5mAb2qNjbI06sXucCHKhuSgx3vqmbPjkOxcC8VpezSWfLjOZYX7UApuaMYZEuJ5CXkbmb4U0AD+okQTxy569b4HwMYLRTY2AW1XfnIRtgHQH6Q63dIwadkqgBB80GcEVC7rOUHvOznSK122k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618932; c=relaxed/simple;
	bh=T4C+3nl3eof/XS79hZq3xaCp4pTUojcLDFnIrRYu0/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WM9vla2GyJ24xrkEj1C6ZzHWB2xlKciy5kvlwMG/f331m70IsVOeq6y16JP6TED85YlXgvAAyy9tScwpTQqYfIfSXDC/ug6jLezq+tE1V0thaTj89XTouh054BcBVdQCrTVgok1WCuZ8sSKbpCM1j9Zs7a73lw0rwIRlqX6G6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SulycnfQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-466929d6013so17900381cf.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 03:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732618930; x=1733223730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JIGO2V+Aknmyl0rZGfpcAHDpHftic2KCLqbM/fdPnyM=;
        b=SulycnfQRiv3RBXtTwWquxi8M0koe9wHGBYPiDXI+AYk3EBSqlzHe6UTaUty6onA+L
         5nbczOOK00SjNp8y4yacWzNfFIaPTcQAa92cEHlIGNYYHLPSyDPA3/e5V9NDwLUL467+
         au1fgX4s2YPURRbH1PLyizovTW4YPJ3Z5q2BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732618930; x=1733223730;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIGO2V+Aknmyl0rZGfpcAHDpHftic2KCLqbM/fdPnyM=;
        b=OPcNWWKuWwW9U8njRoK7Asr3rq5rICr2wmnDVvKO2yudTRQo/KeuYkfltqex/chPsv
         Fht1bELnHnV7yrDDnJ0NZuUkt50JOgmMtGCK1tol3bjpUudP0XstQkbfJzp1BmAokZUA
         FbkhO3hya5jj0vKuiF+nmk6vbjei71iI674U6FynrG98DP0S3OXMzEM45UoNObT2uS/8
         eiloz5lVNihkNImg+hAAbjOpjzb1v4vp0WRcGXSLuML2NQy+tWiBZuW/+7zzLKdzEAp4
         mv874Bw/M4+5rvEj/e4EDyr+sixa2Aiu6jUdenJYyLImOVcKmd8dEya3419taHqdqqRY
         7z7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVToFFokoZeZnZcrIomklEO/bg8rthqDro54bANPIYYRliRGykAnZ+5gPr3IXLMvDBVV+2GivVIi7L81Tu8Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUr78ZqdqfVyllC9saHEyeMy9xppXiW92T0wcxgbCgyUGE7Rf
	BmS46wENsJRZlMIXB35l9Q/vPBf1JQd7OGAMhWNHg7+O+EikBBUgQKXXOb/oXw==
X-Gm-Gg: ASbGncupxIwDIwfcuVI29pQANK+bD10fZnrld01L8LCAEjfSIKnjLaw4p94o1xd+DhU
	Zt7VS9qiy1wq+4WtCe7a+N8A3fX6VmcUvBwyyeh6ONjMLPrsfKU5vABPmxQf0xLgWFGAtPYfXar
	gut6QF5UOaM7WM99SffLURvMI5WiBDUN1wptslydGyO9yzI0REQDmaUabt/ZMLotInHlnjYDPGl
	ZV0Q0eiCM9nNIV+A6iupUjFs0vNN1oPsFzMBGhL/mTbLRGoab/4DFXIWHU9xS1kzdfeTCq60c9B
	jg==
X-Google-Smtp-Source: AGHT+IH/jmDmkC5DmQu93LOAi/DuOAb8/CmK3ri34pbBtJjGk1j15AJ391d/foqyb5jZPRXF6oKrJA==
X-Received: by 2002:a05:622a:2294:b0:464:b81c:3171 with SMTP id d75a77b69052e-4653d52263bmr219566121cf.6.1732618930095;
        Tue, 26 Nov 2024 03:02:10 -0800 (PST)
Received: from [10.176.68.139] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46689cca8dcsm28855701cf.77.2024.11.26.03.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 03:02:09 -0800 (PST)
Message-ID: <be2f054e-5ff8-4fcb-ad50-0dc0d5c03bf5@broadcom.com>
Date: Tue, 26 Nov 2024 12:02:05 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: remove misleading log messages
To: Alex Shumsky <alexthreed@gmail.com>, linux-wireless@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kalle Valo <kvalo@kernel.org>,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241122180435.1637479-1-alexthreed@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20241122180435.1637479-1-alexthreed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/2024 7:04 PM, Alex Shumsky wrote:
> Currently when debug info enabled, dmesg spammed every few minutes with
> misleading messages like:
>    brcmf_netdev_start_xmit phy0-sta0: insufficient headroom (0)
> 
> Do not log this when headroom is actually sufficient.

Thanks for your patch. The message may be misleading, but it is actually 
information that we need to cow the packet. The zero value indicates 
that this is needed because skb_header_cloned(skb) is true. So it is 
still useful in my opinion. If you want to make the message less 
misleading for that case I would be happy to ack the patch.

Regards,
Arend

