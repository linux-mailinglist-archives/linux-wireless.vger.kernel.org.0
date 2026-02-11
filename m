Return-Path: <linux-wireless+bounces-31735-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIzSHilSjGmukgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31735-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 10:55:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8271230A3
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 10:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2D6B309C1BC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2872F6192;
	Wed, 11 Feb 2026 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XlYu8ERp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DB366813
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770803553; cv=pass; b=qShZqcRpdj+QtxTKsYBZmfvG+41PZX4VYmMcid09qv/z6ZTDO6bAI4nIbnl0breqU4R1Z8edg1BjyGtzx7b0XstQYzjQ64V6kuZoAXidTMJ8v15/o6GStBxgiYI2QsprJC2Dr+fA6nDItbSB6SfxdeOHWBCGCZLpkJ2kes6h3cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770803553; c=relaxed/simple;
	bh=FNM7+dqYol6CvwW/AICqCR+k1WexBtc5up187PR4V6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8mS2JndMNxnmkoNKZYvfnRJzkG7ulQMCexmEnnHWBPI5HlGVgjCVBSSYhxMkhdHoFQI4fHcuKnPVGGeB71671nGWnw7vh19jwdQ1vmFxzkwGrO8uMhEizNfMYxfY7pRYq7oFYQs9ss3mJ+NWIwDxRa4+N/rmSJ2RtF2LXPFGsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XlYu8ERp; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b6c89d302so6445976e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 01:52:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770803550; cv=none;
        d=google.com; s=arc-20240605;
        b=LWlnmtWO3YQGanGqJ9ou0KX4WGzEPh9iRfv5l6Y1JyOwXG0TZFELOwl2QdS2YDVczD
         oM3uXTpUYOOJwu0ZqSxUcnZ8wN/tgbnqpmHhh1YOcuuaEgEUSXfJx0R9p2YqD3V2H298
         iyeD8acJoi/tsP1Gm52CIntAJcrnU0Q+o2qkq8TxXaKVLdLz0WIQX1tvKud0OVeEmHXG
         VmlABZTJ/mY/vzWcBeFIByp3SG2jnD4o+1pgJBKDbIjFfPuwlKgLrCPKdYfaYxPftGZF
         ZAMm9oWt6BlyzZOySMfB8Q7NdKIZFvQRW07Q54AzGHDXJjRZITV2AUXmgLD/p0IjPpSa
         z6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNM7+dqYol6CvwW/AICqCR+k1WexBtc5up187PR4V6U=;
        fh=+NV54Nhkq9z2GgxFtP38XeneTsIizJa69GODAcfPmsE=;
        b=GSPzOS+BfZdoRWtPwlhioq2suVkDWfM9mNRednEeqsEC6VcyTYMi0g8KtpiHo0qu5C
         Abb3ZUD7J3G4S/6LMhiRgWZcOamVjoLdtaMmYggq1gRA1F6jY9NwSiqF/lCMaglaS8Om
         6Be+h+0D1UtD7KV6ZoLw5X0Q68BonXaVhR3dbqAsex4vZjP4Y1l2pES7V9bSv0wBsvEU
         i65kaLXR693yykX8doV0NdII3T5Gqlw4+aK8UNFSBxKYxQDr3iQvNA+sTuVwTILBopFW
         NGndxlBKtJ8lYzU/kISSBnU20gQNBOAYBak3OUTwIpRGJYnmPdEEzN3mqItcoXP3T15m
         fMVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770803550; x=1771408350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNM7+dqYol6CvwW/AICqCR+k1WexBtc5up187PR4V6U=;
        b=XlYu8ERpoebH6RfOEkEYN+jqjxYMUZKwzUA96SYwReqDBUgkEms1YtM2wvPkWIZ/Sx
         U83t9Y4nX/N3x7of6a70e4R04QZ7TLZk9W7QkPUl+FCgmuTFs12l8YIrPEMg4XJBivDI
         Q8s+JVUQphPjVYVor03N4gE0ntixqH/fMjcRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770803550; x=1771408350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FNM7+dqYol6CvwW/AICqCR+k1WexBtc5up187PR4V6U=;
        b=Fn4swmXrXhdA2IoWtA+Ig/aUvmqvFn89knlC5dCp15ed4Sd/KtzdarvjudoDgc2FqO
         y8QVyhjhrCu3Vkq/fVp25tpjSt8C6KjmsbA8Mo7p6qnnqDy20l22z8K59Uo3emg/PeEj
         Cb5lu9SJHUxLJ8z2HmWaJtsVZC62TMzEH+l5djw9ZECkiZha4SeSlMLz65bxxW+BRlgb
         0NvINo3uMTToj+LKZQOeCa1z13qLo8Q4ZJACv5+u1ge6virA+rb4PlWdXgUkfOJPY9Qv
         etNgJ8FC+KxRnm5o3RmmvJqQrO/6c3ZbgxD+K9MD96GxdU6DYLydETyl3Kz89SbPigBZ
         HY9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6rvFWtosGoVYWgjBptgsyeXOsQjJM/3+KiGt8TZsyDsjIgfVxVZ+VZWGItOXOafgeWp8PxTzmD+LRcU7Qkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzydPW5V3vNiA577jW0ZWbEklCE6PLTnS86sAC8V0029Ym6ehq2
	VX3dYqnbxR3Xvo4bZeZNCT+Nj9m3vkReiCkgCqYJW0LXsCHhLcFTmX7pfLIEIb7Tj4K1JuAOlmf
	s8Tzoyj9ys8JmrxMeth1PqCvdraEoxrfodjXgzcSx3eiUKv60sNwsAw==
X-Gm-Gg: AZuq6aKHryCAqgbkvq4Mp2YcIzMaZAp1djU90MSAf852dOOhh3LyxuBxDYu8qIxsZ4U
	LgaHWPYl5I6xBWPYo+V+WGonmbemgy26E2j5Sjl0Kkfc8x07Kx9paW167FuGPNoai6Xux/53tSf
	HGHrh2/20f4zpqWNTHrGmzRM7oFZ9S2Ibl1VAEsgzvwr5eVqGUFem33FQlnhKm3IPtK2YVjUEBP
	4ZFjNvUfswUbX5xLc1CLJychE7pzDBIYARA/oI6xqVlUAuuvcataH4Ndvox4StkicVjZKZYko8S
	2zMWOXVJMfmOlGVH4IBs3z9KA9xQ0CNbZveb
X-Received: by 2002:a05:6512:2244:b0:59e:523:ddc9 with SMTP id
 2adb3069b0e04-59e5e0805ebmr522191e87.46.1770803549951; Wed, 11 Feb 2026
 01:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770746444.git.ryder.lee@mediatek.com>
 <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
 <20260211-miniature-chital-of-plenty-1a71df@quoll> <bd4da0a8522db2991ec0844233efe068323c2578.camel@mediatek.com>
 <b00c8c18-930b-4cb9-975d-b15118bfc854@kernel.org> <0dceffe2e1344830c12bc1f6516d13c7bb488b99.camel@mediatek.com>
 <23561f00-9f3f-4d4d-81ae-aab9958bd797@kernel.org> <0572bd6e56ca872e285729ccd4c2201517b66e18.camel@mediatek.com>
 <388e874d-d9ff-43f2-b010-ca7ac29aa065@kernel.org> <0c7b854e342e2047fbc9fc8e8fd80b67a6ec2bec.camel@mediatek.com>
In-Reply-To: <0c7b854e342e2047fbc9fc8e8fd80b67a6ec2bec.camel@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 11 Feb 2026 17:52:18 +0800
X-Gm-Features: AZwV_Qjfx5xbtiM_CvuB9ceKCwswDittQ1fUg0ke-_sxFS_qlXIG8TKjT0xy2K0
Message-ID: <CAGXv+5E=REdz0g8rfi7+KvyC7jLXO0q=yjan3mMTGtxe0NgCDQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
To: Ryder Lee <Ryder.Lee@mediatek.com>
Cc: "krzk@kernel.org" <krzk@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31735-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenst@chromium.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EC8271230A3
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 5:19=E2=80=AFPM Ryder Lee <Ryder.Lee@mediatek.com> =
wrote:
>
> On Wed, 2026-02-11 at 10:08 +0100, Krzysztof Kozlowski wrote:
> > On 11/02/2026 09:59, Ryder Lee wrote:
> > > On Wed, 2026-02-11 at 09:41 +0100, Krzysztof Kozlowski wrote:
> > > > On 11/02/2026 09:33, Ryder Lee wrote:
> > > > > > > > Why this cannot be a schema?
> > > > > > > >
> > > > > > > >
> > > > > > > Well, actually, it's already a schema. This is just an
> > > > > > > expanded
> > > > > >
> > > > > > Where exactly?
> > > > > >
> > > > >
> > > > > How 1T1ss is used across different generations is what my
> > > > > example
> > > > > above
> > > > > was talking about.
> > > >
> > > > Where exactly it is already a schema? Please point me line
> > > > encoding
> > > > this.
> > > >
> > > >
> > > line 243 paths-ru
> > > line 261 paths-ru-bf
> >
> > I do not see there anything like you wrote here. You just list all of
> > them, no device constraints.
> >
> > Best regards,
> > Krzysztof
> >
>
> The original schema is a broad description. Now a reviewer want me to
> describe the differences for various connected devices, but I don=E2=80=
=99t
> know how to add a compatible string for PCIe, USB, or even SDIO devices
> for their constraints. So I used the driver=E2=80=99s generation name... =
can I
> just write =E2=80=9Cmt7996=E2=80=9D? Or do I need a complete and meaningf=
ul compatible
> string?

You can fill in the PCI or USB IDs as the compatible string.

See for example
- Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
- Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
- Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml

There's no equivalent for SDIO, so they just have separate compatibles.
The bcm4329-fmac binding also has examples of these.

If the hardware has something like a chip ID register, then you can
have a common fallback string. At the extreme end of this is the ARM
Mali bindings, which just have one compatible string for the core GPU
as the fallback, and per platform/SoC compatibles to cover the glue
layer:

- Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml


ChenYu

> Or maybe there=E2=80=99s no need to change the documentation at all and j=
ust
> let the driver handle it, so we don=E2=80=99t have to discuss these detai=
ls.
>
> Ryder

