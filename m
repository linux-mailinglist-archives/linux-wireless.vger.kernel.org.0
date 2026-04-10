Return-Path: <linux-wireless+bounces-34621-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGyvEEcd2WmLmQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34621-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 17:54:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3923D9D74
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 17:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22ED2318A392
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53CF3D9DC9;
	Fri, 10 Apr 2026 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="cs+zJ0r8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F53DB628
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835133; cv=pass; b=ckSskFvQgBYOy5a32qY+KI1RBLBF1g6ARHs0k2CaahW0sFukJ+SCrm7gBaIwLWePbjrMKxUV1x2KknMWtezTV+iUoSMPmO45m4GO6M1tYXBKyJdmJKhJQPf5454zcC5CrETbMC3WOFqoUiC+nGvZuK6Ck7MyxAwpDjcTmCSgDoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835133; c=relaxed/simple;
	bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQEcVluRzq/5194PqeO3Fq4KS1hdM8QQklAzH6EXvmELEJOkk/1IUrKU/qYvXcFoet0d7se4RccrkB3GE7w5l5NDLSDXahzDWE1z8wKbl6vuv4Rsp5wqhp1cDf/GG8hjmUgB7vhWZJOYcUSC97IsNhhQLdRZektrrlB+M938yqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=cs+zJ0r8; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c1a170a50so2014865c88.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 08:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775835131; cv=none;
        d=google.com; s=arc-20240605;
        b=HP92vS/hBkyeoAE8IUsUkBmr5sKo/TuEYBYsjCBVdJXWMs6T/KNUi2lOsMc2L4y6lf
         B6du+MtES4o/Wc3ONs6RTu4ztGASEwGT5Yl6eIXaU/xzbEum8uvxAsJZ+aAdnZF6isD5
         fs9ZmkNFdifMYc58Nj3+QIgNsQ6X7i/TwEZ0lkH9nUjBxTXG0x+9NcKnxiQV3H6YzEpE
         L7Rud7Icyr55WVfQAIW5GKGzEuXQNOKVBbHCV+eh+eZYAqV+nDhOHqVhBJzsIXRLD36O
         tnmsW1KLHJinW1YFlKzZh4GX7nqYoN7ksLEStc8eJuuRxkqFZlRTT+TvkmVUTGhTfthJ
         CDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        fh=ljti4LoNxzUCzfAM8k4xCd5/FThKQFWxA0B6B7Zf44w=;
        b=BH0ANL6MBEGTTJecXr2rdyBt5wE0oU9H9vwFe6VLW28BtEPpnF4wq8gCARNf77bevf
         v2SxYKb8pVDHMGqa9v6YTBEGzHLamAY+94WLDiRONsc2UbiwCnZj/vEOsQ7y2MYq3jv3
         LpY4t3mIVBzPlQmRnjnB0jhCOyi8wynLXP4y1M7sBKDD8YaHErzj/6Ci6RE85yqnNMQT
         F5moqJMxhah+LDekOnwzLNnPQgGp1wf5NIHowHOEwKrJmd8g64bSxALDx8UqOve8yKlb
         z1vwKXpwwQ8pBTSlwrkWWj2dO7GJ/n5DSkbgl5bNe4PhQLbXtS7XK1BPQYvCVk6nqwEO
         RMOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1775835131; x=1776439931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=cs+zJ0r8E1VxbeERL/6orYDfRzBNN0xV+FBDuuOmam2/EuHZ7scxaUctzZ3REo2LBr
         KdQSu4tLtUeUQ/Am7PGmtjXBLQ/7knpdVClf5erC+tpkhYxe59BfVvuW88STHDIDr49T
         TpKPrBeobAalm+DfnxseCj+mCeyPg4AFXq4Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835131; x=1776439931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=UqHJp6Y3Rq5YgMXug+uhRQxQ3yp99eBajqjUcoKcI9xnMCUl5cUe3J1IQas+yxXJ3/
         tlo+A2PQyvWPY4yDjDjKjujLmuBxFVYVuAJAhp4O3MDJsSKfLN/CsEACoClTdgGOkU2n
         6WQOx2w2l1DDZ4Zr2Flvk9du+HL2qfCal7hP1xGxvNxf2bzLZKKEAKErb3jkoRGBBi0U
         YYZxN/tM++UgHIUkLDcgJhfMmnHZotq54OawC3UoUCldKMzRpovlnj6bjJrA++W9sNXr
         KkDmN1thgksNv1mACy9YFRdPcgDypwM7UHbfdQwjT3X9JspTbQ21VHbfVfvaH+qhfIwP
         kc+g==
X-Forwarded-Encrypted: i=1; AJvYcCWvQT7UJBN60NoX36QkYqH4SJBa73fOkHI4lbZQViMrbNQNdVfBfup5mV/Hqa6C3LwdVuEf/4yc6ywpHS+OSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3CA+5r2bvEZE/eiaFXO13Qb8KOdePdlPzx51g0sTAJ+kNkHL
	xeu32RszxD+uVnCzVR/15yRHKli6KbT7Z8mQ/Rc6LDj7m7lRiXiaZSxM0KvB8ORjlcXvTVkJCoX
	v0qX6a1EcW5rDmfllaEqVuPElTjcudshrtQzrrN0IQA==
X-Gm-Gg: AeBDietMRuX/v81iey1uNPwLEhF42I0sEnlpPwK2xvrcZGPtOxlctVEJaUR3wTtpvvw
	DqLyLo9ZG2GnhgdWhqwal+qkcAwkrtQxYWyuM/Y2yND+kdvTwAsvftmBcRyQnj5reDlIKyalAPa
	yf22eo3WaIOIrRpOatqIrzn1llWwGiIiucz90kdWLDK64kXTbOehQYGMtVr5Wn5Vwjl77my6Ric
	GVOOK+vfJ4mKrCXHPqyIhHVs0cqQU7Cwg/6FG19AsSt1+ezDQbcMAjKFSUjHz81ao9yR4m+yQF1
	KaG9
X-Received: by 2002:a05:7022:6097:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-12c34f069f8mr2159203c88.34.1775835130696; Fri, 10 Apr 2026
 08:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 11 Apr 2026 00:31:59 +0900
X-Gm-Features: AQROBzAnX-XEClLFV-qWYFUzCuq4P43sNZviESiWFI1yCPXm2VtVZ2QkaUGJoPY
Message-ID: <CAFr9PXk7qK8-2JWrrfgXHoS9JWTRL+WobLjmAesyCE9VLL8ZyQ@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[0x0f.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[0x0f.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34621-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[0x0f.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@0x0f.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-m68k.org,lists.linux-m68k.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0x0f.com:dkim,mail.gmail.com:mid,thingy.jp:email]
X-Rspamd-Queue-Id: EA3923D9D74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

On Fri, 10 Apr 2026 at 21:39, Thomas Gleixner <tglx@kernel.org> wrote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.

I have built and booted this on my Amiga 4000 and it apparently still
works so FWIW:

Tested-by: Daniel Palmer <daniel@thingy.jp>

