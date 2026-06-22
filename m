Return-Path: <linux-wireless+bounces-37985-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GfZgHzmlOWrGvwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37985-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 23:12:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D468D6B26D1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 23:12:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=M1kqpQEa;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37985-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37985-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ABAE3014DBE
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 21:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A0367B7E;
	Mon, 22 Jun 2026 21:11:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E13659FD
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 21:11:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162709; cv=pass; b=F8Xc99UKnZyCwkN+IpRr9L/gqeohyORQ9RiHU3LEcBTO76/LBXAH3IGuIo5Dz9Vmwwfndxzly02aSeDNaaEOood42JTYCA6WDhNAsZjLSBrKL40wa3Lm7NMr7+L3IHY9Jrke38ZXdjidodaSC2o/c3JlIMfZ8qsOIKLMJSPboJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162709; c=relaxed/simple;
	bh=gM9b1MCsa1vuN8M9yH2NthRBzmFzaQzwXUOD81TlikE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWhHGmcok9mk7r3zet6FvWQf0+/5KvwBNCb2pxL68rEfSJAWqCCbfDBaWXtvPGKgRFVTL79bk05ekUBCwndWzwb2o1vE99IcxI3DGrp8A7pQSY75lqz4nBCO/pVBGlUv8Ez9L7q8zOsUZ9heVFhWXpBjIuhskb9Nx1MFxR4xZIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1kqpQEa; arc=pass smtp.client-ip=209.85.218.54
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c08922c23ebso587459566b.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 14:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782162705; cv=none;
        d=google.com; s=arc-20240605;
        b=ftFwYOL6fq0FTJn3tqkHQmfxKYPafErCzsUb9rhz0LOwMZ6fskgUq0HNiBmMhSIcIJ
         aEBKScmXJce/qHAjUiGxId37W4+riupiAMKOpXpFcBjZuEsCZnD6upOJn101aoIGV4fo
         bx+3XHRKeb4FLx4fO6P9X1ikFRZNKovxn7Oj5z1VdXBrVzLrk3A+SBPoRtN7TcHGTat5
         s9q5rLc4VNUIb0hsZt5t3GUR+YKQZL4oc+mWcOvtdsuzsH/nsCjI0Ii6Ab0foLKR8XFU
         vRhZvalkS6xQT1mXpfv22DaunrwYrEveFDYM8J0vX81lShea//alqEFQ32BlAPkL2hCM
         HqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tzbbEpZYbYIxkM4QatnjlAlHtsBuQVIj+hM6AfYe1U8=;
        fh=K6TQ0ieQzbYcGx1rNlac8CcGXOwkRILvYvsgyajPNEk=;
        b=YSvx/ukP8s3inBIvwAFEmpN24zl+XJldJoCuWIjPzQyOvXLfSwFUaswC8zNsIDEMwb
         QHYu0XmEQlGhi79rHZULGGfovjZMrUI8DJhQQzHZmb2qB0WIf3DrHDrt+ZofVeZKViAH
         Ld0xusK5YnqjMEa22diV0Ktm7+i+fwaVocKVMFYK4BMfCqw23YT3rImx5XBBDqB4vhVl
         6TrrcwkcvIFys2yZ+guAzgnRbwa1zAmlFCSvcO/X8NzmMkRmIC1XMtwR4P9h4B5j/Xjo
         PQkuv+/lm8G0ahOjGTrEbP0rYiprQ+sHop3dgRJ5UbgpwnnZvH12v1iKPxwmgXePNu50
         93GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782162705; x=1782767505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzbbEpZYbYIxkM4QatnjlAlHtsBuQVIj+hM6AfYe1U8=;
        b=M1kqpQEal/4Og9xZGeCGNcsixylt0PQypKd8lpEX0BQA90gHFu73Vt8HrbcCbzKmUl
         QErA8A+ySiqKWawvpK6IST+TJFx5/2ip/k/xo1ARzXA80FotwO7SBt+JA/zaE0KHvXNx
         mywU21xruelqMyMkoGJ0hYqTjzkP1AtUp06tFou4yZ8M2+P09px7ZuKtvHrdyVheR97m
         /63hfI9YnPT59eq6qpVbslnka2zg2tEYBWtfx5hho07t7n586GK8A2pJiJyBnX+x5e4a
         x3uUHpHzswXqVJcbsgEqWlBD2z8ujAsLEBrAgwMt3b6a7sQv57JTiBtccsAtb8YBN1xD
         3CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782162705; x=1782767505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tzbbEpZYbYIxkM4QatnjlAlHtsBuQVIj+hM6AfYe1U8=;
        b=Z7sEj9B/QBV2rNfXNZecmxtxzWbymb9m7poElesjueb1FprRLhXsiRVySPADkLCUi3
         iEK2RAOmQfRBnH2AHxgZCdGFQIImVBLlDWDmH0iDjCYcfybs/YSdB+4q95drJ5/NlMBh
         1KzqT/l0wnfJ8XPi+Ph1mAxLdFk/KrBuDGFAaZR3gVx0ugCAZpGeJZRnqN+P+WTQjMl0
         cT8dW9cbHFHa+ic83YBpDq9NbK0YpbGGugG9Kgj6z4iBkvldkABscLFNO5UGbv98dIyb
         Q3DKFW5+08w0YcFrn9XjkI7mt0wEaMOEzJe2K5l0bIn90kUS0WhgZ82dmQNrtfO8k/R8
         IlUA==
X-Gm-Message-State: AOJu0YxpnwHhDviwNeVQR8eXLUb2RLQJoUPQ6JGaFfNzYTsCiW3dPdsO
	jRgOs5evjlS4LNtz0jl4/+N4z3KX/XhuYCJfK4u1n2DyUzELaPL3WLCEFhGrsgINlbA6uKQlIbj
	0A9VWcIbb6pLRfoklk9iEhD1ebEsncy0=
X-Gm-Gg: AfdE7cnVrp5mFGcGm4jKBFyOun+yQKsKOnLKsbEXcLAifkaddJ4reuAugNAmWCHTjcD
	EG9Fe/oI0Cl6xbbrJPFogccuVHUjETkmoOxy/0v9xOo+zDxfByBRR6F+pl7JNpEo0fAXexiZ4Dh
	cgwwli7e6/5DBc2s/LwauvP+9Vw525j5feqmDwhMqf/2mUNAEmXKGljfqFpF6suO+sko+cgKfFO
	A6/Lu9rXyt1GaYW/b+tyf5IPhCcazYGR0he/vvUB3KrPwWxEg0nxjybl98Vn4f2F7IH2nQ+fu4j
	LX01khhFfNT0a4OIgHPeI6WGbCn7rChi6DRLs4/nA2Vj3ubN3QktJdw/t6nfFElpwE/djEt/CS7
	iLfX6CrOXd4DNJEWA705cBy2y6JIhehuwCKG0Trg+AIozd3ZLvCLjK8nmIA==
X-Received: by 2002:a17:907:6d11:b0:c06:3267:4483 with SMTP id
 a640c23a62f3a-c0b62741b59mr683781066b.36.1782162705229; Mon, 22 Jun 2026
 14:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619175210.5348-1-rosenp@gmail.com> <87se6eeqwn.fsf@toke.dk>
In-Reply-To: <87se6eeqwn.fsf@toke.dk>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 22 Jun 2026 14:11:34 -0700
X-Gm-Features: AVVi8Ce7gMPi78XwXehrIR7K4R9bs478er_TaeKXGBPz_-ouxv3Gh0jdP_Uy5LI
Message-ID: <CAKxU2N-bku8uZJ2nqtXb5nMhaPpxYnHqefNBj=WWe6HeKRaBXA@mail.gmail.com>
Subject: Re: [PATCHv2 ath-next] wifi: ath9k: mark static arrays as const
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:toke@toke.dk,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37985-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D468D6B26D1

On Mon, Jun 22, 2026 at 4:49=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Rosen Penev <rosenp@gmail.com> writes:
>
> > PN9Data is a read-only lookup table and is never modified.  Adding cons=
t
> > lets the compiler place it in .rodata and prevents accidental writes.
> >
> > Use the same treatment for bits_per_symbol. It's not modified either.
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> Again, which actual bug are you fixing here?
Patches are required to be bugfixes?
>
> -Toke

