Return-Path: <linux-wireless+bounces-29565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 008F5CAAF33
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Dec 2025 00:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4761230093BE
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 23:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647C29346F;
	Sat,  6 Dec 2025 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWROfoyf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B39273D6C
	for <linux-wireless@vger.kernel.org>; Sat,  6 Dec 2025 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765062977; cv=none; b=QsjCLwRuceLGK1pnsAQTpOpdwd5ZRpKdl0kj1zbAnYHe9bxOZkmN0kHXHYruN80Q/0a4YjIj44D8WjnGAHB6iTdgRHdAxxU51pNaNjSWBQZwO+q5vGBthUOGf99eqbcFYwP514B5cr5aurSBm+Eb2IkWfwsMLsPLGCIZ7o/Szfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765062977; c=relaxed/simple;
	bh=sHzfrNNc5TiZOJevop9wIz2ZjtFwVDhSUdmNHa4qp1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRDtzNgvN52yo6xepsxHXcIpvJqfrafzBfLX/OucTb3R6BPw0cv8wn8JZqG16SmCC+6YzePmkHV+hS1TnB5f2UJmI42SmZceIoVHaTM4Z0iEqar4sYYdt4MHowMc2v9Kg9X4O6KkeeS2beI4SAy4ymILozVbFhXGYrXy48HMLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWROfoyf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so5959213a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Dec 2025 15:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765062974; x=1765667774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHzfrNNc5TiZOJevop9wIz2ZjtFwVDhSUdmNHa4qp1A=;
        b=QWROfoyfmqank1B+D60sDDmaEuEAVyHbQtxPsmnTIO7yt5Qm6yN/ofZ//wxV8MeAbQ
         f7vDFIupR7utaEgv6OGp099coRnwsIRUIQxU+SjTPlBddcuMpJCugLpV95PQIYwYpVvT
         zX9qxdM7kQOVpQtrEGnv5HWX606CAbwBBv1GWTK1eMbzl+HbtMy8oOJ/P12SBVwbm+8C
         8vwowt+Cn+tvRZgJdnZ1WTjCZr2grpVN8S0eG87IUkpTyFKW3rTE2n33jpIQ/5HNBDq7
         wyqv8sJ90BXokOsDJksJTxabCFagcvc7Tt21Y8cypQpVZvEJDR4ZAuEOgeFTgkkEzNRA
         bphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765062974; x=1765667774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sHzfrNNc5TiZOJevop9wIz2ZjtFwVDhSUdmNHa4qp1A=;
        b=Tm9vmIWvNdEsBqO8h2oVVnjXsikFnmTRgUl+Pfv9H7icZOFvg81xV2R4j+w16C5urJ
         sG6kcPC44oBRVHrrmgHGsu/xXJc6PTN34ol2Bm8kQ6rLBJzmFegGrsFJgYZZBDJLa0O8
         nGZn4t052DADTknjrAgfPyqPu1++ihmj4ViV1hYhe1orG4u5sQ9pTxINLQIDErPhsHZ9
         RNsRanpIjXy2hm5GCB2rRwpVbnWeVoB0aN7FKTyM+sR+Xuj7qSQHQoVaoB2s2NvM3yRr
         rHyf6dsbGp8cv66NTTgoNYuJpIN4zWGWiG3BBXuhn7d7tqHOE4ruCTlTOICzwnj6D2b9
         fEnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLvk1nMQhnJe4JTztY15sfoJL81EBAyBjmGNcGwOSI5smbR0BOU0j5XUbFtvADUY5t/HkJQsTNkygrJ4FzqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKWlppGAk5lMwhcZLE1kU39zkCXebJTBpDnR5M+TXgH28Kwr9v
	6UKyXf3M5EqDHbNobRwRvbszqjFZe5RbfAKsymBH0tznE58zjcCZ1Ew8
X-Gm-Gg: ASbGncsAY04ZO4SJK8jWI4Up03bfiJg0Q41Irev6RHfnMnB4q56MQX5E1h8G4s4q0F/
	N5UcUeHhjomgjZWbgYzMrHQkjlFKv5cCjnIGK8l5U9gTFdQVuRA3IzgUI1WdUQ7cO5MUtpioPPs
	o/UNELgIHEw6lmPVMWL8XqcXpQ6tGxoIB5lxPlcELZqcCXKqa1sJwzb3YHSIR11tj3EdPBn2OM0
	dWs0c8zeo41jovUh2KlupX3pwWNyu3SYKB69Z/7MQh8ZAHEi51jwKd8wv5ICe5OE8Xk3Rk6SCse
	VRk/N9fzLMtkxJn7FS6LcZW5I4LbLIBovaldNeZYffObeRPQs9/RgreEijTV9kxJceCSh8xNrU4
	qKAwKj43+TqgsoLbRG4HN/YUgxczXL7nqzIA1yoTxxzMshX5vJZNBCKlnD5Egp4Waj77+qHDInH
	74WL7n7wc/e3xTxlCj7+lvAIA=
X-Google-Smtp-Source: AGHT+IHtKFCmYVxjR1we6OXMVDfxzf8n+wwXaLbAzbV2+PkWV7ti0OR445B6RzpBr5bddwpvBpKOcw==
X-Received: by 2002:a17:907:6ea4:b0:b7a:101:f86c with SMTP id a640c23a62f3a-b7a242be758mr391922566b.10.1765062973847;
        Sat, 06 Dec 2025 15:16:13 -0800 (PST)
Received: from foxbook (bfg212.neoplus.adsl.tpnet.pl. [83.28.44.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4459378sm754765966b.6.2025.12.06.15.16.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 06 Dec 2025 15:16:13 -0800 (PST)
Date: Sun, 7 Dec 2025 00:16:08 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Zenm Chen <zenmchen@gmail.com>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>, "Jes.Sorensen@gmail.com"
 <Jes.Sorensen@gmail.com>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <20251207001608.1f6940bf.michal.pecio@gmail.com>
In-Reply-To: <44c9c325-14a8-4391-adce-4bbe8c68b446@gmail.com>
References: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
	<20251121111132.4435-1-zenmchen@gmail.com>
	<475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
	<c0d187d6fead4e5387db2a14129be96c@realtek.com>
	<44c9c325-14a8-4391-adce-4bbe8c68b446@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> >> I got something. In my case everything seemed fine until I
> >> unplugged the wifi adapter. And then the system still worked for a
> >> few minutes before it froze.

Sounds like memory corruption.

> > Zenm and I tested below changes which can also reproduce the
> > symptom, so I wonder driver might assume urb is the first member of
> > struct, but unfortunately I can't find that.

That's what it seems to be doing, because it uses usb_init_urb()
on urbs embedded in some struct and then usb_free_urb().

If you look what usb_free_urb() does, it decrements refcount and
attempts to free urb. But here urb is a member of a larger struct,
so I guess the whole struct is freed (and this was either intentional
or a bug that didn't happen to blow up yet).

Now a bogus address is being passed to kfree() and things go boom.
Or at least that's my first guess after spending a few minutes.
But that's the direction I would be looking at.

Regards,
Michal

