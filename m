Return-Path: <linux-wireless+bounces-20008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29428A570C7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 19:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67409189B0A8
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 18:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE02459DF;
	Fri,  7 Mar 2025 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="DkWjcQAC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADC2459D8
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373402; cv=none; b=F846/oLkVOcCA++vylENOYvCU/qq/W0wL8tm72zWCakGmmTTKeWSRItULrVN7pYdi8HIZ8JWg/L7J8fJxMTc1GRkSuITyCwCFnVWuCJQ7oy+h9L8vJOiCyFIiy2WnEuSxxqT9SCdh3XJB6hgwBRRMeWU+/VU059kqgqujQG9uAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373402; c=relaxed/simple;
	bh=iY8btfX+g/V/cLT+RlidyZhd+i1kGYYOkkkl+VytfXM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=uoo6oc3rBDSSmdqysNVdc5rm5dDKsDAsOUPJmgNaZnwMGeAYeYxAYciS7jjbQlfBW79S14PdzpQYqtPY7M9gd8cTNo1uf4tBfdtW8ndRGOuIJ/uKEGP7rocr0yYyFoWclgJZv9I/erbjCpZH4mLmIGeLMr2GJrgPY58BNa0NSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=DkWjcQAC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390f5f48eafso1191982f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 07 Mar 2025 10:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1741373399; x=1741978199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iY8btfX+g/V/cLT+RlidyZhd+i1kGYYOkkkl+VytfXM=;
        b=DkWjcQAC5C0/tvdNiOQOFtyEoSV+GivWOME44KbetdV2C8s9mjk9kJMlq69hUV1xpJ
         C/d4ewKlGNRFEvIBNZRQrY+TcB4ulGj99/8idRRQmKUjj6OiQjEIsbZqa/DUCpV+vc/s
         q8tbCBHmrACDAIxxYlm+hj8K1fPoEitZbhPwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741373399; x=1741978199;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY8btfX+g/V/cLT+RlidyZhd+i1kGYYOkkkl+VytfXM=;
        b=AFqMnUD064K36LApWl5KU2uDn+pvrP+tUOGPjRUsGcq5ssCFREmQ0JIjztW+zD5zRG
         +yIaDhozycrQC1EBJ6SFRKakeGRLZTBkyNdWIdzFgFyEQRpqXJzz67J6RIOj3kGGw60q
         jUgjFpVO/c5cCgR0x6NWyonuWESU5E8/8bOXdxlDxpZKA72PpzbteMD/GGQr84umBr+O
         V/nS2vTNrReExcCVRPDDJSSzEz9N7soMRE/6wslhuc0cMAPUXQkT2ZbtxFuL/zStpp1i
         7/tyxHiGif515v/mTkzZyeF/6vLX01sNSbk+H6o60Gc1BZ5/IxIeeG9OoiBMPL4yGkhI
         jC4w==
X-Forwarded-Encrypted: i=1; AJvYcCVb0BR7xl//M8dN03GbfuXzberPx605Pos14mC5mWKWeMnvOf6ft9x1eBTSvxvvJ4nXYeq5hymQfaNqDzeD3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8saSeRzcz+S936vHrxIZ6q0qE8spsUYNrXzGMQD0HqurhmLWP
	xAmUEHJvDc6zIEMjUhO07tx3tJaFPmHJ5liAp6HXMQa7KeMW5R0DeRftNA3e4Go=
X-Gm-Gg: ASbGncsDc9EJoT3+5mkyWJ9VVinu8pGYOsOa73joDGG5twXQNPvZOiDra27mRsu+Kx8
	Qk/lvq5uITY4a1lfKnfjRDLjmkQbDHA9mMuDDSgnfTfFiD3qUsNGo5WX3wDSmQtJ+fhNPq5hhoG
	j1JjaW38PlOWjfcMCcylcgm0yL/1GLLv+U7Ik0+c+R9MnezVC5sfFvMr3H9PQGx9kq7zMiiJ8k9
	jDkHftC8O9GVj2E1imNn0SQhy85BagaYKTW3bz4a+fEjkSMG1+LEWi4vOG9IchyDfE4sUGAW7IS
	8SUas2Nn78fBRwALqf9rsLLUsM+r1p+RqvkBnIUg86THQstnyCdHdcu1mT8HsZJ+uI86SEIaQHr
	gsqkIyq06
X-Google-Smtp-Source: AGHT+IGmeOPTWjHa0Be27hfI/1kYnZp0UHx0P0R/hj81LDLYhuR4kj7WMmpAAdsX/afUuDK/xqqF5Q==
X-Received: by 2002:a5d:59a7:0:b0:391:1139:2653 with SMTP id ffacd0b85a97d-39132de145bmr3407200f8f.52.1741373399039;
        Fri, 07 Mar 2025 10:49:59 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba848sm6051474f8f.4.2025.03.07.10.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 10:49:57 -0800 (PST)
Message-ID: <efc2ee9d-5382-457f-b471-f3c44b81a190@citrix.com>
Date: Fri, 7 Mar 2025 18:49:56 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: hpa@zytor.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 akpm@linux-foundation.org, alistair@popple.id.au, andrew+netdev@lunn.ch,
 andrzej.hajda@intel.com, arend.vanspriel@broadcom.com,
 awalls@md.metrocast.net, bp@alien8.de, bpf@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 dave.hansen@linux.intel.com, davem@davemloft.net, dmitry.torokhov@gmail.com,
 dri-devel@lists.freedesktop.org, eajames@linux.ibm.com, edumazet@google.com,
 eleanor15x@gmail.com, gregkh@linuxfoundation.org, hverkuil@xs4all.nl,
 jernej.skrabec@gmail.com, jirislaby@kernel.org, jk@ozlabs.org,
 joel@jms.id.au, johannes@sipsolutions.net, jonas@kwiboo.se,
 jserv@ccns.ncku.edu.tw, kuba@kernel.org, linux-fsi@lists.ozlabs.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-serial@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux@rasmusvillemoes.dk, louis.peens@corigine.com,
 maarten.lankhorst@linux.intel.com, mchehab@kernel.org, mingo@redhat.com,
 miquel.raynal@bootlin.com, mripard@kernel.org, neil.armstrong@linaro.org,
 netdev@vger.kernel.org, oss-drivers@corigine.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com, rfoss@kernel.org, richard@nod.at,
 simona@ffwll.ch, tglx@linutronix.de, tzimmermann@suse.de, vigneshr@ti.com,
 visitorckw@gmail.com, x86@kernel.org, yury.norov@gmail.com
References: <4732F6F6-1D41-4E3F-BE24-E54489BC699C@zytor.com>
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <4732F6F6-1D41-4E3F-BE24-E54489BC699C@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> (int)true most definitely is guaranteed to be 1.

That's not technically correct any more.

GCC has introduced hardened bools that intentionally have bit patterns
other than 0 and 1.

https://gcc.gnu.org/gcc-14/changes.html

~Andrew

