Return-Path: <linux-wireless+bounces-1902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA86282D33D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 04:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E621F2127D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D0317CB;
	Mon, 15 Jan 2024 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahTqahsf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C115BB
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-598a5448ef5so2765526eaf.0
        for <linux-wireless@vger.kernel.org>; Sun, 14 Jan 2024 19:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705288261; x=1705893061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=V5Wna+AY+r5ruhbNQlqeAQyD1C19p12/fuVq+SYcxfU=;
        b=ahTqahsf8bmp04upsc5TE/2ldwTGY1LmSAC9BYpo1J7Mk+O20o7uGBGYQ1CcNKd3QZ
         Su8Xd3ea9nPyhfomAt1c82/tiWbcpdzAZTGiIr+eOSWFv8XpXB3f4ERJSp0LRP1NVtVY
         tFpqt+JcT4VXKyaGj9DE6sEpKk82aOK0yRV3X/HuuVinMkJXa7SLLsaqeV7B+omYPwnh
         kA9gtOWtRLXClpVqxty3qzGIJlzaNAUnIg/bF0UZBV20P8wvDnGkM1u1RNKIN9p7oShv
         fxWojUJg7Wp0zYpuF/k0XCXDFt4IqMT567iMcD5qwtKj+NFRTMWc24JWoU6D1VroT1Wr
         wiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705288261; x=1705893061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5Wna+AY+r5ruhbNQlqeAQyD1C19p12/fuVq+SYcxfU=;
        b=pYa0uLASSzmMujpz8Y1XSnAZ3T8FfUNOuRhfdqyPnZypLg/SY2ATonfESLaEDYOSjv
         d5yqImKU5Y9avVbOXwc/KpsFytV5smaAtM4ULu8vWldIXlAj085FdS6pzR+B5vQZoAPm
         2+cff6WNTSF3HqC7TPhjOKyi/83/TMzQ4cl9PjwUc+epdC4ff+Ul2ByLp3u1qekKUZSj
         /ilOzpqW8IAAyvpg5es5R6VJixisvY0PQCmpmmp7j26aXy6BPVauKExriaD47lPFRr1K
         f7VzMeiQoLItoO5VoIEfO0z8v8NtkgjY0RcwYW1udJ3x0QUFLZc9nrmC9Jfkr5AaSap7
         wdyQ==
X-Gm-Message-State: AOJu0Yzq/EasXqTrlVeEJmCOotzAG2R3+kJJyAKYH0xyuCQSchEZF3e2
	Q0pnx9fVQraUZ4rgRMQjsTU=
X-Google-Smtp-Source: AGHT+IG2yX4UQwq81KhhwbtQsBoOkXz15iTZk8izicHmdeQ5esRMA4+Q/72R5jhc3IQKTyrghZeN8Q==
X-Received: by 2002:a05:6808:188f:b0:3bd:713b:b36d with SMTP id bi15-20020a056808188f00b003bd713bb36dmr3180439oib.112.1705288260643;
        Sun, 14 Jan 2024 19:11:00 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id w11-20020a056808090b00b003bb7fd5686asm1252790oih.23.2024.01.14.19.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 19:11:00 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <730e72cd-eb47-47f6-8690-1f74e1615dbe@lwfinger.net>
Date: Sun, 14 Jan 2024 21:10:56 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtlwifi: Speed up firmware loading for USB
Content-Language: en-US
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <0d262acd-4f94-41c2-8d15-83486aeb976b@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <0d262acd-4f94-41c2-8d15-83486aeb976b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/12/24 13:51, Bitterblue Smith wrote:
> Currently it takes almost 6 seconds to upload the firmware for RTL8192CU
> (and 11 seconds for RTL8192DU). That's because the firmware is uploaded
> one byte at a time.
> 
> Also, after plugging the device, the firmware gets uploaded three times
> before a connection to the AP is established.
> 
> Maybe this is fine for most users, but when testing changes to the
> driver it's really annoying to wait so long.
> 
> Speed up the firmware upload by writing chunks of 64 bytes at a time.
> This way it takes about 110 ms for RTL8192CU (and about 210 ms for
> RTL8192DU).
> 
> PCI devices could upload it in chunks of 4 bytes, but I don't have any
> to test and commit 89d32c9071aa ("rtlwifi: Download firmware as bytes
> rather than as dwords") decided otherwise anyway.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---

Tested OK on a BE ppc32 installation.

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>


