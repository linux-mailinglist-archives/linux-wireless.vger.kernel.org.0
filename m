Return-Path: <linux-wireless+bounces-29573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C179CABB12
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 01:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6247F3001BD7
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 00:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85C4A0C;
	Mon,  8 Dec 2025 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7d7XWsA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0C20ED
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765152326; cv=none; b=Q840JTjKYIb62N9HZeoKHrXUIbVxpunWPUMsYHMy4nmzlAPmDC2zHCHIcVMunHLVhlB+t6+DR2lr/WELVSrExpstXGHmT1cF55UnprplR1A2xrydUUK2YQJjJ3gOTv6scT9f6n3zJ5hTM6w2vnWNjZN5RUJ2X/6chU5oUgr45hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765152326; c=relaxed/simple;
	bh=kF1RpIs85tnz0Mum9qzIvXTUhZPttSkvcmreMhDe0bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVjQRDhQexU5z8Uha1KEqhVeYQQdMnkJ3dR7zaqPHwT0xud5wyurcpdVIESBwv3Vny+C4m339QhrmU+sjsuaaCoIEPLiL88g0/9H9Jrw0Xsi8MpT9Mhc2helOwuCrYnG+5KUstTuft0ioOdMFyWE8YooivYB1RuPk5iwr3sdt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7d7XWsA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47790b080e4so23613875e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 07 Dec 2025 16:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765152323; x=1765757123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crGWNTCrIJBXutZfz1g08zhcxUbU3pl9o/ZTSXj4LR4=;
        b=L7d7XWsAJu+QYNfNMEd4db7PJe786XwKJanzJq4zwHPXDhp2Atetpf8+xp9vX3E6r5
         JW4I2oNmQx4VmsVFyNzT8fOTEoiJ0EAlzPk6iPv0RsCVigghduvHsB1KhPOU2Rttw/gR
         nGpJiCcojGRBIvOL7oElyMrtamNdhpmYTXWAj9PFMxF+8sDbnwOFM2rt/O25i5vKbfvV
         PAlY/ExztpdHx3MjrUqA1TFZhQtarE2CDeCmAALt9pe4rWvfEVHE8lSbERiSQZ/waSzH
         Gro232B8Hi84PO353U5C0Gmae90FmmvNbvqP8Bztl3Z91c91BDfJvV/y044jZZpMTB9/
         +d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765152323; x=1765757123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crGWNTCrIJBXutZfz1g08zhcxUbU3pl9o/ZTSXj4LR4=;
        b=XxgSUDndCQtR9Q8gMmVeC1LVl9c0T3W3tOraPN3dCiPxCLj3d8Dv03OMrH91BrkLIl
         FN8vVN4htHtvlcu2Vv/rK0vcx/PBAvwA7rwTJ76OH3vyXYwSTpeDWcUwwAubqI+LOUtb
         efNx8hyWjftxxm8lLvXbRLC8vKYsCzjITKo0Ft6hYwBxQNXRSNtJjPvatzJDyXZ+yp3o
         hn/grvxMuGinmlQU0o6pYIPLbjaaBe75duvXVkcj6bRDDzRfc7l3kMpipTpiRtEibnPZ
         JZMgGwh+ZNIu2VoFCKbBwZgGQcaX0b9gEcjtE98TW/FJ/7b0TJgYpWfVaAw73IuP1gC1
         Sy+g==
X-Forwarded-Encrypted: i=1; AJvYcCVDQG48zub+aHgSyoxM2l3LC+q7VR3Acl74Wd+Fwuz6TNy780YWQV9w3/ShY4oAHf4UFCYCiks+V4P16v91/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfgioqTf8Oqf9lN+Sotp1NMLGJAgrwDJcO/8Ioi0eiWAxtKaW7
	wUZ5GmJ5HvgmiKvHEpAislAUGG7guYfp2fSy7Z+bDkAAdrCbUuoK6X9w
X-Gm-Gg: ASbGncs/kSuG4jpZba8mFUfAe1yt6M7EifJeCgzuNV58H9nPt4TSWHPalA4UTh+yt9D
	3oX9c8yMJksB4kYm/1cOJSGX7zug1gvFK5ct0mxUqzFXdMuxdFn8qeyoNNA+7eLK4u86gLf53NN
	e0FrSI+GeR3cyB8g7S+5Qck9/s6ixLNdxIjeP3alsgg+hKMTrftCjdYwjKjrwhW65qYnA+0gMPt
	PUheQ1RTFJphXuBZBaVYJxLs05bnbwMWd4ZjrRasfR/ighyi0RY+IDOah3HtTA9wTjzCiuAUoff
	yOgGDG2dc7+pa9ulc5XNxuxm2NA1ui8kkXkq1ksgHw9TohBTLreEHQACw51bNNaPMtGyNFGXboE
	t0gpsnGjgtO8/EpAhG2uOAeoBeZR2GVYNrY6fBcOYoFr8vv+tR6SfSFIVerVomtAV5ggYFBkHke
	c196m2fjXkwc0eVEW/MTWq
X-Google-Smtp-Source: AGHT+IElnljE3VByHdqZRQQCN5eSGajqd6Tvz9JHksaJP8BhX7orlEgII4Jmd3VFk5TSm0OmokF2mg==
X-Received: by 2002:a05:600c:529b:b0:479:3a88:de5d with SMTP id 5b1f17b1804b1-4793a88deb1mr59110375e9.36.1765152323202;
        Sun, 07 Dec 2025 16:05:23 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479308cd87csm225552475e9.0.2025.12.07.16.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 16:05:22 -0800 (PST)
Message-ID: <f6f7cca3-0de8-4b97-9b8c-b76ba2561f0e@gmail.com>
Date: Mon, 8 Dec 2025 02:05:19 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Zenm Chen <zenmchen@gmail.com>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
 "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 linux-usb@vger.kernel.org
References: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
 <20251121111132.4435-1-zenmchen@gmail.com>
 <475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
 <c0d187d6fead4e5387db2a14129be96c@realtek.com>
 <44c9c325-14a8-4391-adce-4bbe8c68b446@gmail.com>
 <20251207001608.1f6940bf.michal.pecio@gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20251207001608.1f6940bf.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/12/2025 01:16, Michal Pecio wrote:
> Hi,
> 
>>>> I got something. In my case everything seemed fine until I
>>>> unplugged the wifi adapter. And then the system still worked for a
>>>> few minutes before it froze.
> 
> Sounds like memory corruption.
> 
>>> Zenm and I tested below changes which can also reproduce the
>>> symptom, so I wonder driver might assume urb is the first member of
>>> struct, but unfortunately I can't find that.
> 
> That's what it seems to be doing, because it uses usb_init_urb()
> on urbs embedded in some struct and then usb_free_urb().
> 
> If you look what usb_free_urb() does, it decrements refcount and
> attempts to free urb. But here urb is a member of a larger struct,
> so I guess the whole struct is freed (and this was either intentional
> or a bug that didn't happen to blow up yet).
> 
> Now a bogus address is being passed to kfree() and things go boom.
> Or at least that's my first guess after spending a few minutes.
> But that's the direction I would be looking at.
> 
> Regards,
> Michal

Ahhh, I see it now, thank you.

