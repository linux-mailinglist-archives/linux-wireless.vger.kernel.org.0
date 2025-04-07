Return-Path: <linux-wireless+bounces-21198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B58A7DEBE
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 15:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CC71799A6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539AD253B7C;
	Mon,  7 Apr 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REW3fMHY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A338221F25;
	Mon,  7 Apr 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031666; cv=none; b=KW6OHomLDhgGbgbJtNIZ4CsiS8ZmfUsIVGTCrO49B2nQpj0bUyGlpfoaSh9i4tXnVPI0G/Anw6kjdQ6b6prU5p5+H+5HZmSYj5n6ubJiC4BC0gshW0z1wQ0T6/TI951+krhTeit/5H/McnJv3o4qLb2LSFg7n4Eh0qiJejW5Y5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031666; c=relaxed/simple;
	bh=esDg0xM8Y4ZazYNOozgp2f4DIAuNinwrUVDRw26qrTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJGAYI8i1H9/iC8Zhi8/Fmai295Tw9UdTxswm6JNlBPHQvnM475Rah49CujQ2X2bpzvjPJRTWqHZRoW/cmsqGjBYZgIx74q8AROOBeKlfXkhzByV4BzKkMhp/fzbUkyBIYG5yAb6nWPa0B4UpKzZDb4lzeSJng2YrRK2QyUGNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REW3fMHY; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso8303196a12.2;
        Mon, 07 Apr 2025 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744031662; x=1744636462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XK/v/TJL7lqRfnZivx0jdbKyv53Azw09B9p+I3AQ/Ec=;
        b=REW3fMHYyj1/VT8lCDkqt9UzODHsPzTdy98PnW5DrZFuDazfK/5AYzbdddDDLA9kPE
         8SX57J0cEFPfYW+GApJCNMqDk6k2ALZutAwvfGfpFmIJtr4vQ8xVxfSnin8/75nkvbq0
         XsfiwrVc3+yf9PCj+qN0Nm7Isq1WYE1xihzxSX7bQ6G1Z5n6fW+go1Tnneq7SMGOW89r
         6nv//J1ywL2f3oPCNWOB0IvkIxLiMNXSZbPLQHReTB1BNfjdzmT0VAA3Lg8zV7Moctld
         AX3P/kKgTe8Y3jdNJwVBnwW9QKO05zB4h/JZXCs723+gVmVXZrf6lR8LLH8fZvSRuxgD
         W1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744031662; x=1744636462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XK/v/TJL7lqRfnZivx0jdbKyv53Azw09B9p+I3AQ/Ec=;
        b=Q9gQhFsZs6YvZn/QSoIz0/nGqkGMLSxl5WTEJU8YcxeNPB59byrGC81oADphBGWhJe
         drvWMFMxMqzqDwj1D3v90rkqCKZ3XDQrXDctiP5Hx6xj0XDjnFhUzyogDCzSoU4BHjLj
         TWppa9bO/KLBjg5D89PjVqMBhsrDWNtF6whRhjaJGUdL8HHX0a9H33lVM27+5TODBkW5
         vahkqD7wzjOGRqG5cIKrMAV8nmlUNJQuJA2g0FRu+tt3k22e1rB2OS1Ze4VAyLNxjscy
         FBCKp0tORLZ3jAlxeO4WD+BuGFyNqXTy44iZEvcL3Pmx1ye2Cq8Zd0z0HpA5t/nmIyS5
         W8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVudyRro9/cfFVuOySR57zROFooSsgtXlGHmdlPtsNDP91nZW+14cm9MS4jvCHJG9sNvH2NIOU5lBitvfT0@vger.kernel.org, AJvYcCXBQ1UUmxQY7+mBYtYuF1KVYDY2DlBnB3nZxp7F47wOlrZX6He4kLXM0AvT5sZKzgezTuYPoOrdxmj5@vger.kernel.org, AJvYcCXKnTusncr8/rfEmK3CxGCMfk55obrPnEIHMY7JIh09jui7l5hdji7XChID+gTvzu0gnuAjZJ5ytIEk9afaB58=@vger.kernel.org, AJvYcCXP4NteRk/pDmg6fxXQg+xSYsT9gl7l95B+It8tOrfg5LR4W+/LPVZbn4NuSZEnhZ2cu1HEyt48lkde@vger.kernel.org
X-Gm-Message-State: AOJu0YxwSYSqDVoL3h9cei2UzYVpuVUkoIrVW+ltb8kZ5QzbOxd3nbn5
	W8O5N1bBwcH9RwvoPs+7mYvmaZCWeeEGHszA7xLSxHapxlOln+7S
X-Gm-Gg: ASbGncsHcMma4wXtajpZX51vf6xKmy84zivLJtDdpIsFGem5SZYZMOan9tT13vyD7NY
	0z+kxzkq37gsLO9g2Et3FCmVIb5FfTwJT0T2fZve35Mfv+xngM13NhtCAhPdZOLqIyYr5hwxn+P
	APhPz6TlDhR3te+0Bth3g2H+tMUVoNYbCK7z0/CpfkypuSuVRkDCFgGk4LnKfDRR5K9Wni0KjCr
	Nz9DAOCpNdCx2l89n6UYEc8UzuypX/CpiuQkW57zV72BR9YzuOm0wAgxLFQgSeR6YmLur0rbgSF
	HYSMhX0+bHXuYl39RBZLYD1j5jEb6swB1NpOycOovb2Rn7stWoCewg==
X-Google-Smtp-Source: AGHT+IGyLMeKGLNiZ6Bg9P49yXVeovF9kmluZgH6/6aFqrvUlJiRGJhqFJ/Y75psCo1iDeFB0shdwA==
X-Received: by 2002:a05:6402:524b:b0:5e6:17db:898d with SMTP id 4fb4d7f45d1cf-5f0b3b65971mr8088772a12.2.1744031662359;
        Mon, 07 Apr 2025 06:14:22 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087f07baasm6732801a12.37.2025.04.07.06.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 06:14:22 -0700 (PDT)
Message-ID: <60b16a26-8c88-47bf-8b59-cab8dc25d2db@gmail.com>
Date: Mon, 7 Apr 2025 16:14:17 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Onboard USB device support for RTL8188 2.4GHz USB
 WiFi module
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?J=2E_Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>, Matthias Kaehlcke <mka@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jes Sorensen <Jes.Sorensen@gmail.com>, linux-wireless@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250403-rtl-onboard-v1-0-10ca9a6a4ee0@posteo.net>
 <14513d89-1ee3-4d90-bd26-1d761714a8a9@gmail.com> <Z_OvWwunajTcg9TJ@probook>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <Z_OvWwunajTcg9TJ@probook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/04/2025 13:56, J. Neuschäfer wrote:
> On Mon, Apr 07, 2025 at 01:37:17AM +0300, Bitterblue Smith wrote:
>> On 03/04/2025 17:07, J. Neuschäfer via B4 Relay wrote:
>>> This patchset adds rtl8188 (usbbda,179) to the onboard_usb_dev driver.
>>
>> RTL8188 could mean at least five different chips (C, E, F, G).
>> Should you use a more specific name like RTL8188EU?
> 
> Yes, that's a good point.
> 
> I'm not completely sure which name to pick, though:
> 
>  - The chip is marked RTL8188ETV (see photo[1])
>  - The RTL8XXXU driver reports it as RTL8188EU
> 

Both is good.

> 
> Best regards,
> J. Neuschäfer
> 
> 
> [1]: https://c3voc.de/gallery/misc/fernsehfee/92QVxQl.jpg.html


