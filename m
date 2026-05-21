Return-Path: <linux-wireless+bounces-36750-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLIDJGXLDmovCQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36750-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:07:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD4B5A1E6B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 515D030859D9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E44323392E;
	Thu, 21 May 2026 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ38PF30"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16292FFDE1
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353718; cv=pass; b=Zjj6GvGy0o/f4N+wawuEkqujkoZC2lZYcx6W4ssq14JWCfvmN/74qxTWMtr4chq1tQwMFlgmY3n9vE+YQhRRiWsqYbxFY5t9UMvOs0r6+fX+547UbiJ2wkMlu6t+SWjH3+2bPqRWixj3ZMPDJCjTTl1azKYk2JiFWHs4srX/T8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353718; c=relaxed/simple;
	bh=pvVMGINsqk4H56XbbsHXn/OxXqWM+H4yKwPJB77OB3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5h0ek1+0tbS6Lf7duoGwnD8k3Tcdl6tuYD/dB2bdA8HpOKf2Goe8L6vLTyJZt8a1ythvY5eASh1VoBb6bA5cGy+s+paybFH6tyjjmBk2sdHrbBNam70U193hJLRALSU8T3hULzz/OULoOnrXdMEdyqBiXCG37kXetW003e9khM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ38PF30; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-449de065cb3so5448095f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 01:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779353715; cv=none;
        d=google.com; s=arc-20240605;
        b=g1CdhDJ6VOBdum1sFFzq6Yz/K0zZLpJh7EFFIjBNhwKOEWGikzrNfGP/n7EvGkQxRc
         +YJFtTLfOBBtyAoiN1mXg1vxgC2ctpJzfLutrVPfI1HBfdrUsUmC8iERkyFy6xosKQKC
         G/u+5lDm+eosIcblfJICoNmR5NrqT3j1LSK6qxRM51Ua2SGwq1VZ4RRwvYD1TpoSXNLi
         GkBujG84B18OS5C7e3H7e3dOW6WFuoZjyh/hp+3RZxbxBctf2bWYhE8e6rxHXieYe0sO
         97Lzc5bRd3HallfYrbfEDmcEc90dRJdL4sCXBGxdgx0vd+RlX9tARadmpTsKC4RrmIHw
         QLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xTpqoApsG71hyFgSKpeYprCRd5QzWsB9xrg7jVWmFpU=;
        fh=kiH9BsJ+TyHZ/0f9lp96S1R8k/374lMiI4doNuDXH6k=;
        b=Ym2gXR5VwVWfx90k8cLQsyDKo19qJRA5mS0/Upz7RNkUWx76Uw23kgnwp4EjQ5Z2IZ
         bhKvJMqvBiYM6np9mel5DVDok4fqQsXjV2U9LasTC/6KXYN602bBKGABMP8NnCmzKjXV
         6Ews6U1F8H8EkVfOHYwrjIs/aoowbcKWmY6Ph5BLzGllbe5zd2mX/Y/fJkKPeU8jUvrC
         FSlfNB2U5VpsppgGSdScjXkNw9ECH1D3tP0kEKiSrxbBOWSMxwH8y0XX4ZURQ1T2AKr4
         zeZ8TQfVDkJq34mDEgHQVUY3aCI7ZTeGkZ6plD0VxSfzrKS7LrYTAW/hnarZT5VQDOPz
         cqoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779353715; x=1779958515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTpqoApsG71hyFgSKpeYprCRd5QzWsB9xrg7jVWmFpU=;
        b=BZ38PF30C/7ZesyxXj8qJI7heBblfRsujyvZqitOaDNSd2Agcv0vvNQif7ttmSiHPA
         1kuB386U5NeKyJIWVQCA64QUdFEASgZlDeWK9jZ8nZDIXCgThfTG8fmqLg1dALInOGZR
         MsSoA15qalylznv3aiEZ167UtRIzqnscs+4NR6Wp64kJh0BeMCSSVaho63CPJFfxlqlr
         V1PPM2wAZeoEJydirmmH2xwYgozddYjdLXmYEwz1o9L9+J2pl8mqLjoSUSK08G9ljD8B
         rcznKw6dTXVoOYsHSqiNMNt1dWmp2uRN3zitO+E4zEr6UgC5xNCaDn2XgX+enrWf8t3x
         43Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353715; x=1779958515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xTpqoApsG71hyFgSKpeYprCRd5QzWsB9xrg7jVWmFpU=;
        b=HIwzTf/kj7ooGvuTEV89WOevlmeF6YQ0M9DPl+eXZfgVG+ui5cQAsxovKQA8Vywhzk
         QlNVwgQZKI4vWDnM3/qxzRRKgKxIURlT4HdVsnVemKkx3+f0WKCDltAaQ2OTAE38m47O
         /b5rE4ht2BgLidpFmqP9dUjfFGULIkN/RpPd/GJBTsn1STmlVFpKeVDWgnI7V38Utjk9
         VCb3899dWrSLN9j8vaJ/jRzMma09H5EyVvZDIuT65pS5ooyLPoNynIDi8UiFoOGGG71E
         B8aHEQy/UiLdqQq+xaglCSsXPli8E9nX3Y4cmUG04SYviLYLLbzTjiDlkhMACwYqHcUi
         4gOw==
X-Gm-Message-State: AOJu0YyJimSbWWC8UN/dtwd73Rxqhu55CAcpnC7e97VDhi3tQCliH0er
	6rSv0l0oK5nPaoiBCTPeBXNJGdTbVFrAyiVX90yNrqBosH8ezxyg35jPZI0niIkXDVesIBEFARb
	tu7uMa2VPk3inp/uZmR8i2rOy6/KHYQY=
X-Gm-Gg: Acq92OH66ukQF4BxqZnDoU0ma2pKaspjk/apW+v9j5RPzO1PW0m44uu3Zyvlk4DmnbJ
	htwHAu7kr6iEoqE9XgVMlMX3glGaDm2Dd/8KR32tAjLWuDHpo4crA3+FEp1KTLaJabnTTLd10qR
	EfZ48JXvxkepn3KKwekDEHKQOabH/xnO2nlkGndSwJa/DY5xYIc6IEeQw+c5CxuUChF/TzbdKTV
	1oke5f2SYrX1eYohWkrv5mvbdWB+tlB5dfM7jfcsiQueF1r7rBrasMSjoZitgVebTAe6HayvsoA
	bGE8YbZ5te8PaXA=
X-Received: by 2002:a05:6000:2c05:b0:43d:309b:9c4f with SMTP id
 ffacd0b85a97d-45ea38cd4d7mr3243607f8f.6.1779353715333; Thu, 21 May 2026
 01:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515233839.86829-1-masashi.honma@gmail.com>
 <20260515233839.86829-4-masashi.honma@gmail.com> <530aec47e907fce393bcb789516becf3a2102a97.camel@sipsolutions.net>
In-Reply-To: <530aec47e907fce393bcb789516becf3a2102a97.camel@sipsolutions.net>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Thu, 21 May 2026 17:55:03 +0900
X-Gm-Features: AVHnY4I5z23K3Pi7EPC_ve0nfcD59vtY3yhIiv6LxBIFzzajBhiS-RdZwYu5myg
Message-ID: <CAFk-A4nkVwpwveJpENz+GH3aPdQqPSFVav81MtQeg3-8N3AJ8Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] wifi: mac80211: Fix overread in PREQ frame processing
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36750-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 0AD4B5A1E6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you, I really need to use LLM to write comment :)

2026=E5=B9=B45=E6=9C=8820=E6=97=A5(=E6=B0=B4) 20:15 Johannes Berg <johannes=
@sipsolutions.net>:
>
> On Sat, 2026-05-16 at 08:38 +0900, Masashi Honma wrote:
> >
> > +             /* Right now we only supports 1 target */
>
> nit: "support"
>
> johannes

