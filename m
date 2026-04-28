Return-Path: <linux-wireless+bounces-35486-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIX1I36V8GnnVAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35486-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 13:09:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 058914835C3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 13:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BD0B3113649
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 10:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EE83F9F47;
	Tue, 28 Apr 2026 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnXstZmN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8D3F9F3A
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373028; cv=none; b=VmpqixU/f8cPkL7b42fxzOY+60RSjPSDXvP/6hFVWVBdgMwm8Fh1cf5ara374p96i14vF/wJMRhTjxnDroMq2xoK1kSBsiSQ5b44E1/85qRKs0U+QutFmBgJFZakIv8SG9zAaLQuMzNKu9r2Ilvuefy7qVaVsohcMPP2juriid8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373028; c=relaxed/simple;
	bh=Txo9jXdDRugPyX7qmDybQ2dYpzzLy0YS2OMMBLInikE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnHlNfVc10way5r92TlpbwLIsVdVrSF4rtrPwdmzFTy8a32/kL6NsRw85idOPfrCQp2nrIsi84H3eT6IujgFvBkdnRRTdOItApXAaQcwU33m+5rzB7BBetuaLoux1685EIygrFLaJdWU5G01P9l71JCM9QAWyTIShpIJPFfWK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnXstZmN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so60193095e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777373025; x=1777977825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKtRqSF01B3I4gaZJfxuG2QF2TOpMdK++wbIpuZOUFw=;
        b=OnXstZmN7ww1Q4bhga8AwQWndl6j+ndOBx2NRQaG/ke7OEbOxNum8W/rv6iVgWWpsP
         q3CqBLQEPXY6iz2D7jDqte1G8jU5tZRYGnO5sYLmLOYq0HhrVh8lUNG2Pa+PTDRUbBj8
         yXvz1CKuvbjoMO/5hlzvifIjmBs1huNuA2I2nkMOI0UGUJStbkpc26sEi5r1jR65caUI
         rKz1BFO0+/M/uhxlM+PjQdZhsnYgbUuAwIfTbMeQZ7QefPDTYw6nsVY264kH03ze1LtD
         lTRdJn7H0otmTRynmseltG+hfSWaQ6x3nMXcRRDxxFzlXhbdE1cKgLGYcmyphB1lBzLY
         ZXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777373025; x=1777977825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hKtRqSF01B3I4gaZJfxuG2QF2TOpMdK++wbIpuZOUFw=;
        b=XJAdyqZuVklJzxj41cEosERHpUewNeRUhb9qPv0/kClA04+y/qrcpbPLuzGHx76ifp
         sj27lTu3ILiVs1QTFeLMV60TEHUltKhlZIZRD9fqtGZSTJ6yZw3GSYCl5bWuhFFc4q2p
         sa2A1cha+7/FRFyCjKRsWRq+IilLtbtvcchA3pjjhyVOn5iny0r1zdUBWS83xg/wkw9w
         T6Kc17L8egX0MEGuvgsqTpgh/DEYWXZ9chPSLfLw+uWNig5vhfxpuXVJPfQjG9OLIVq6
         o+SwMJ89pWRw7HKQLG+iKqGgvD/dfM9M1Zo9RKj1khqeTipqR01gwA2fR1+ZarIM5xKU
         LnnA==
X-Forwarded-Encrypted: i=1; AFNElJ/B9CHntpBZlwDb8d/4CIVpnOjWbxnroP1nWKGNDWLPkBXML0H+PJKpVAtVfrWSImjR09ZisReCOXOcSdRoZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Va4WRWffRbfRw0ENDzrJ9Ia0arIi83wUL9wmQ2Wm70nJB5hP
	Nyoy18s6r03PRWEr+yhg+4sfa+HOUulY1Qwdpb5YxgEvCBp7INk7Dvw3
X-Gm-Gg: AeBDiesn36/TZtKXnEwrrNTnaUKI9BTlbaJBlLLRI75rphNIyPFS+KCVoIxub2IAPow
	zxZ5UGWpEi6V7C515qIhWtdudNVtnl7WmwQSRaGhIF2eIvwQDBgDCtM25xVO75gdTqxCY0hPgXC
	UB5R/LjcstGfU1b0RmHnkshy+LtePznOSXlBiJuNhduvvntiZUSXcPhqeqs+1F8TyIVChLJ7ZkH
	VXp/PkMuaRhtjUrV2miJvEitKvH9glF4v7ud8zolIwDDYFad5d31rO/YfE6e+ImeOHCI+pJAgaA
	TSOiCEcYedC6Bd1dtytcgAh7uAWHMMhaqplHhKXhDVCikNhvfQzx5QZbs9rTfYrTGcmKRioSt4J
	YPE6dS14ZjyvYT51Ms4Ms2TcFS369D2MNiPcHzL/AsGzlldoDz4SIDLoZvX1hKP8wa6RAgrY4+y
	ARcWs8cToOBioTtuxqaeeHngsCaLoBrumuo+dleva6QxwZ85OUgz1A9AgxFFlcpEx35dQ7pZHHs
	6o=
X-Received: by 2002:a05:600c:a08b:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48a78a536acmr28625155e9.14.1777373024680;
        Tue, 28 Apr 2026 03:43:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77af28e6sm41696855e9.6.2026.04.28.03.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 03:43:44 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:43:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yury Norov <ynorov@nvidia.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Johannes Berg <johannes@sipsolutions.net>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Ping-Ke Shih
 <pkshih@realtek.com>, Richard Cochran <richardcochran@gmail.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Hans de Goede <hansg@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Salah Triki <salah.triki@gmail.com>, Achim
 Gratz <Achim.Gratz@stromeko.de>, Ben Collins <bcollins@watter.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 7/9] wifi: rtw89: switch to using FIELD_GET_SIGNED()
Message-ID: <20260428114342.0d674fd8@pumpkin>
In-Reply-To: <afBdXj_9r25Ssnz6@ashevche-desk.local>
References: <20260427214127.406067-1-ynorov@nvidia.com>
	<20260427214127.406067-8-ynorov@nvidia.com>
	<afBdXj_9r25Ssnz6@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 058914835C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35486-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,sipsolutions.net,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]

On Tue, 28 Apr 2026 10:10:22 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Apr 27, 2026 at 05:41:24PM -0400, Yury Norov wrote:
> > Switch from sign_extend32(FIELD_GET()) to the dedicated
> > FIELD_GET_SIGNED() and don't calculate the fields length explicitly.  
> 
> ...
> 
> >  	for (i = 0; i < ADDC_T_AVG; i++) {
> >  		tmp = rtw89_phy_read32_mask(rtwdev, R_DBG32_D, MASKDWORD);
> > -		dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> > -		dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> > +		dc_re += FIELD_GET_SIGNED(0xfff000, tmp);
> > +		dc_im += FIELD_GET_SIGNED(0xfff, tmp);  
> 
> In the same driver the GENMASK() is being used, why not  doing it here while at it?

To me those bit masks look more readable than the GENMASK() calls would be.

	David

> 
> >  	}  
> 
> ...
> 
> >  	for (i = 0; i < ADDC_T_AVG; i++) {
> >  		tmp = rtw89_phy_read32_mask(rtwdev, R_DBG32_D, MASKDWORD);
> > -		dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> > -		dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> > +		dc_re += FIELD_GET_SIGNED(0xfff000, tmp);
> > +		dc_im += FIELD_GET_SIGNED(0xfff, tmp);
> >  	}  
> 
> Ditto, and it even looks like the same piece repeating twice in different
> compilation units of the same driver...
> 


