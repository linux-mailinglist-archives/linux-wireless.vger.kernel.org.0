Return-Path: <linux-wireless+bounces-4917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B83880283
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 17:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B00D1F24CFE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ECF1774A;
	Tue, 19 Mar 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdpSAX2T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7F125CB
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866333; cv=none; b=Vsr0EayOVRDUUeJtukAlJOiwsoXkwOPfCFaXLFpxCTFcFEZb92lxg9D5zKf0fTdShyJz1FVHSECafIlW+aSu+h41qfpD3/Ywye82azNu6N9sqwSAvX/Sr5kmfEa4tJt5EgDoQLL8L3sicWGAqQ1DLsoqP+i17CHMvWIw59fUpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866333; c=relaxed/simple;
	bh=aAi67wLDvGqmCDm3j6z309vAQ4m6QIRSA6C/2+b/5UM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ntWWZdv3yMN1DbL33HpMYDNykT/TRLlJRbgVwoU7jbtMxgyDsh+ZOTd7/BQemJaJ6kDtxvx+GuMPXPUy0eH+6yVYe7takn9mVK5JFKRTsXKMWhZptjU2/NCSS4h0Si6n6nXKzfggxu3Fj6Tv1asnb4uSqQ5dEoZqwe0pnx3GjpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdpSAX2T; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44665605f3so651003966b.2
        for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710866331; x=1711471131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Coh92asNhvqnl7QJ84fdbZhF3Lx5qSOXzOJUxw74MmY=;
        b=NdpSAX2TYHssb1ug+r0sR4z/JF0AHlG8V/L7wvALzdsBfzbsuJuXFKaEN3veRU01li
         uBL32EWJZ1YlwxQVJXnQKWytE+LluJ7lMq6iFdtKcuHdYR7XLeH3XVwnFqCsi7ZKc4aE
         VviWU/rLSxNted4ZTQUS2eHfDWpLKEvBcTArLRyg5MevUjVFrvyJWFEpxib6j3Y37WEb
         cflHicK+Qlws/thgMHGs9vT8BFZBXSnDQYwqgbXQEbVj6qUWDEMS60n5z6zo/iTOLLGc
         XZFPSREcqaatLdhpZmMjqTfHVPEXXVgjn1kwf5A0iZ+kiYYD/uapV33SNsKmw91NkQqq
         7e+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866331; x=1711471131;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Coh92asNhvqnl7QJ84fdbZhF3Lx5qSOXzOJUxw74MmY=;
        b=oR1ycDO9rjygUKo6l+LJRzc+X5GWZWeI/7j48z/JrhzXKjPWR16fWT5juocb6a6lj+
         THq4pn8+/0iWPGJq9msbk199xL6eIE5umcxcOalviVQgbWAl9xkr0aaQhI/FF12dtlH3
         4MQQvdAbdpJKQdrhaSU8KfJra0AgIvYcH0+qQ1mdHf1xemEqDzWwa6gRLaGe2AO7Jkzm
         147FWznqc4xNf5sPB/CofbGMlky2L5yTX/T/02ix9ZIwDWMz2ncJW5Y9DbQ/0udfOQos
         zyTX9Q/tXukuNgA+jOCxm2kdZl2QVo+6gt0Zg2VzQZTP5y/BBYZ5UDZy6ic4jt2hbtu2
         mPIA==
X-Forwarded-Encrypted: i=1; AJvYcCUrESST5x0Jnk40gdAAJ9a5lry5Xl2g712vl+yPcAC9mWSZFhbv0etthrZC/d1MJRWQTVScmHfKdmEM0pq3RAWlLZl3DgMD6VfAUQ07Suo=
X-Gm-Message-State: AOJu0YyX12thp5GcJBJeJb2hlfb/jjy2xZe9zTLwL7VfJonfEc0dAj4S
	UQuZ2t1uQdBi8clmLiG4m+VvdMqh1JGa/1r/rjFbti3mhN9YxjEQ
X-Google-Smtp-Source: AGHT+IFUNuMNz8vsZNUEB+CjCmWiQTa+G8rgbkoankkoWpcYmnPKQ/JGEfVpl36O83B4gAuFkefyug==
X-Received: by 2002:a17:906:358f:b0:a46:d6c0:a483 with SMTP id o15-20020a170906358f00b00a46d6c0a483mr2185020ejb.15.1710866330435;
        Tue, 19 Mar 2024 09:38:50 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id hg9-20020a1709072cc900b00a46aef32642sm3538008ejc.170.2024.03.19.09.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:38:50 -0700 (PDT)
Message-ID: <0f140fa3-8183-4406-b341-65018fb129e4@gmail.com>
Date: Tue, 19 Mar 2024 18:38:47 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v2 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
To: Zenm Chen <zenmchen@gmail.com>
Cc: Larry.Finger@lwfinger.net, chewitt@libreelec.tv,
 linux-wireless@vger.kernel.org, pkshih@realtek.com, s.l-h@gmx.de
References: <68f0042c-675d-4919-b001-680c6b1c1cdf@gmail.com>
 <20240319080800.2994-1-zenmchen@gmail.com>
Content-Language: en-US
In-Reply-To: <20240319080800.2994-1-zenmchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 10:08, Zenm Chen wrote:
> Hi,
> 
> Thanks for this nice work. Please consider adding support for 
> D-Link DWA-151 rev A1 (VID=0x2001, PID=0x330c), thanks!
> 
> ref:
> https://deviwiki.com/wiki/D-Link_DWA-151_rev_A1
> https://techinfodepot.shoutwiki.com/wiki/D-Link_DWA-151_rev_A1
> 

Sure, I will add it.

