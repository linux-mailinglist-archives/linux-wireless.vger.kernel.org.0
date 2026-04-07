Return-Path: <linux-wireless+bounces-34450-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIGjHiS41GnQwgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34450-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 09:54:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5A63AB007
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 09:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 508993008A6F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C687B3A2575;
	Tue,  7 Apr 2026 07:54:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184773947BE
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548449; cv=none; b=NNrKmnlgWjV3LsNsQtqQMKd1wUfq3+Mj5FzLf/si1pRueMiDut2eQ2YBzbHlMC+KsGyquEZLKT65XCNvnqT4NEID39XlZxo/ADeJg9w3oqxE8ZkdFIQWlsXNUC6Y/NGgv3yDlRp6AxmCFWkcgq1U3BwMOvKrg/0ODkukmT9qQak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548449; c=relaxed/simple;
	bh=SA/Y5UMtIwiNf8LjDXzXrP512qUvnjOQr7Ac3bRFAlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVf06LzfxdHUdNk/tQx2dfPF3vljJ8jL4UdCQGUs3amsUukUi/AgTiWXnVDKv1PhKWKrXDvpiOvvZSRJxLJnJENmVjWnDBkRke8h6880FV5hFtkrsk/FZOWJ5RzXMyfPsfJ6Foe72CZmjVRmOfMzagD4S5o7s36jxoqOZ8X21X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56d924c7183so4638766e0c.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 00:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775548447; x=1776153247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3vsOW+B7OYhYNMzQrQ+wQqHziPohNJv5TXUjsSUv1w=;
        b=ogSiQJzj+BnOIOyyX10WSs8Hqn1XpxZWCIPbXAN6yBAJsgMbaVneI5IoA+4ADgWIHF
         3/Moo7PiEQL7mBKjHHuwgAlZ7KM/YvNhLOP/wlHN3AbHHsEPTWNScro8dFOXdQnEaBXo
         m4MjXEzX82At0REHIeI05DwyXoymuln5pBHn7Uuf/M9SoSp7/hvIrMSNeip2zsbCoXD4
         RXPb1Nqv+fhM+WAp6O82Xalr+5LDPbmoNY9yiR1xPrQfOksquJoDd2O8sfmwrQLbJkIf
         NlwWFpr1rjuMCkp0Jgij230bNADQyd6KsedO31s+ffw7cKAOdJrtRquALCsYP54wd3sv
         eJbA==
X-Forwarded-Encrypted: i=1; AJvYcCUOsedI9vq/Sk9KkTXlySLnk/rlZhPPGDITVbb3F6gdUIFFX5m6XFRpBOt8Qn5/1vDiex2Sogl6s48iAx647A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAVmG9J8Aa5UMSe4kbDahV1INQEdnkDqhp2rNLr802ixPg83Er
	7b9EayG3g4H6fjBdHaPp3/YkrzLTIiVWGn6zVoz8Mepjg6LPXui8A2NNX7LxkA9f
X-Gm-Gg: AeBDieuoS6YeolHRyFmeHrCJ8dqO0jiaDS7fLBiCpO4BeI945QoIK10I4QpyRTnggNm
	Crl3twp0AkZLCZhaJ1doFaJ+A5R+3w4pCKDWPdTchwkDfLAEOGfVfMzfUX3TmSfn57G3YE5Z7hX
	iaGLaTmnXs+QnVVqrWq6HOojzXZXm9oQS2kS5JYBkhNu8sWj1+CBxYbiGjCQalf8vpHTaixcTLb
	pc8sdce8NIsRQtrC3GWmng0p3WbVMc5tnBC/Ni95uxb//BP8/T4yuD+ZlGquydLBRU5Qs0am9Uy
	qqf1vt3Nri1UGur5c/074H1SMkmJ+pfaUA2cNsm59kPtk6Z9WqGoapMWtwoP6iQfz8FhZhQbKOH
	Iud+C260cNeSYC2rpHEunYlWfPRxTxOPeSeRSaSokxquIu1xQ4Rjr7GhN/6btorNigbI8s0VnAa
	8NS5uyS0eoCv3BIeFMOBxlyMKRcAMgrUmJp0rS4QGY07sBZ9pITVJ4f0ys+VgVfuuL4pBBo/0=
X-Received: by 2002:a05:6122:45a7:b0:56a:e3c7:7ed7 with SMTP id 71dfb90a1353d-56d9f1976eemr5586627e0c.6.1775548447038;
        Tue, 07 Apr 2026 00:54:07 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9ba826f6sm18160714e0c.2.2026.04.07.00.54.06
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 00:54:06 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-605b3b6c4dcso2150368137.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 00:54:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGJQyfd9/By+Cg832isgha3p0F5qU1J29dE9vSJoTziIe/erGGrN8X6u1g7WS0laq22L9VURmTe/y0+efg7Q==@vger.kernel.org
X-Received: by 2002:a05:6102:94d:b0:600:3b3e:681a with SMTP id
 ada2fe7eead31-6058a87fc66mr6244649137.14.1775548446384; Tue, 07 Apr 2026
 00:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405052734.130368-1-ebiggers@kernel.org> <20260405052734.130368-7-ebiggers@kernel.org>
In-Reply-To: <20260405052734.130368-7-ebiggers@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Apr 2026 09:53:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVnC_NPH5Co--5-SCLw17hZWkq-_iz3cWhi6e6oA0iP0Q@mail.gmail.com>
X-Gm-Features: AQROBzAPn-cRMgXtKdvZnIrCSa0iIYxaxI0VYJSdnntVWbMPtn_Xq2rko4RLhk8
Message-ID: <CAMuHMdVnC_NPH5Co--5-SCLw17hZWkq-_iz3cWhi6e6oA0iP0Q@mail.gmail.com>
Subject: Re: [PATCH wireless-next 6/6] crypto: Remove michael_mic from
 crypto_shash API
To: Eric Biggers <ebiggers@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34450-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.948];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CF5A63AB007
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 5 Apr 2026 at 07:32, Eric Biggers <ebiggers@kernel.org> wrote:
> Remove the "michael_mic" crypto_shash algorithm, since it's no longer
> used.  Its only users were wireless drivers, which have now been
> converted to use the michael_mic() function instead.
>
> It makes sense that no other users ever appeared: Michael MIC is an
> insecure algorithm that is specific to WPA TKIP, which itself was an
> interim security solution to replace the broken WEP standard.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

>  arch/m68k/configs/amiga_defconfig           |   1 -
>  arch/m68k/configs/apollo_defconfig          |   1 -
>  arch/m68k/configs/atari_defconfig           |   1 -
>  arch/m68k/configs/bvme6000_defconfig        |   1 -
>  arch/m68k/configs/hp300_defconfig           |   1 -
>  arch/m68k/configs/mac_defconfig             |   1 -
>  arch/m68k/configs/multi_defconfig           |   1 -
>  arch/m68k/configs/mvme147_defconfig         |   1 -
>  arch/m68k/configs/mvme16x_defconfig         |   1 -
>  arch/m68k/configs/q40_defconfig             |   1 -
>  arch/m68k/configs/sun3_defconfig            |   1 -
>  arch/m68k/configs/sun3x_defconfig           |   1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

(although these would be removed during next defconfig refresh anyway)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

