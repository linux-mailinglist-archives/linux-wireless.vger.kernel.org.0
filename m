Return-Path: <linux-wireless+bounces-36213-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPaUFXOcAWqTgQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36213-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 11:08:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A4750A9B3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 11:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BAD730237C4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6B23BBA04;
	Mon, 11 May 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbifbjfE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2CF3C9438
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489899; cv=pass; b=gISDwFs2XsSoJM75uE6+gEmj5al2rDxJXQbivPL1gJ91F2qykj9sd9rO56YT1/xOo6QBLGTzHtPMdlP3tztlY25oeV1LCkoDHTCdBSA0+NoPGFgb8vfvo0PFnDt+XcZ8WK983G2Gjo6+f6b3ncppGw7TsOYnViUvHGCppI/QEUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489899; c=relaxed/simple;
	bh=eLKnpciB7Qd+hgl1JW7vfjb5aHyWKug0O6V3BC2folE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iT/JIxg1YrLDQprQRiUqJFcumKovpsEbe5ckt4QJc7vn/+mlgpBGyHQbnBKM+2eLaauBRm3t+pKIiWeuo3reGhUC8+RLRKT7q8SdAdSgS3u+fwDppIHqUwWObqlZ7lIxxWX55b2xT/O7kmM+VjIvrcmK9XjudUsw3+hOQqTSIY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbifbjfE; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b150559bso31142095e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 01:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778489896; cv=none;
        d=google.com; s=arc-20240605;
        b=VDYrIiiGWBXcvaWCjIIJoNBoIN6mz/fbyW5wI+J9t6Sh+0tQE3ILhV7Qi2ZEgoKKeR
         C1rKj4OYlck/XibEqqPxn/m2BD8XXeQJCVWHgxZSXV/pJTIf9QLJFjGAGxHPnn9xur2/
         UBKX3QGyOVSDIOJzY5wy5US8TnF00UTG0g8R62UGC+ekQ8OkrlTEbQSQZrIp/iFYULFW
         yQM2kxMLMsEIK1MKaG8xReY7Y9ownZi76F0ew7puFMdAKGzs4wax0UC7anbhl1nH6+u0
         zCqvMW/J9WxIRP7+LNNVVuKmtfJoUeVws6A78U8QMP0ZT7FBjRxQBi/mj9EJiRU2kIpS
         vC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=azn/NSLn0BnsUm6Ly/kYoa1KZWOFIsStyNt2O/IjY80=;
        fh=kiH9BsJ+TyHZ/0f9lp96S1R8k/374lMiI4doNuDXH6k=;
        b=EsIyXCIuCLG+I2cDgnDDNkZVB1lA+WydM42xbgPGXkh8N/AP97+XLuoP1K1gW0X2Qg
         OSOm/WU0HW4cFV82LXuiF5WWW0r9l4Sqlzj/A8MEIoVG1hK0EnICHVQykia17e4eT08A
         Ca1qw194caOnSaXBN8LYAixnlsmsaSpDGPMQx8FolLDAAmFQLj8dHf71cUpNQjdfoLIm
         TydwEmrGzvCexY+Hzreew/liblg92TyR+m1yj3XoPjgo+pPW19WNlytH60JYzRAkfb+K
         aPhS2Y9k7xsFT//3kl1A2dpdjQPGSpyHSn8PUrU1v8bXLknNQt2pLF/OFHg6owE8TDW5
         1YAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489896; x=1779094696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azn/NSLn0BnsUm6Ly/kYoa1KZWOFIsStyNt2O/IjY80=;
        b=UbifbjfEx9O0O5lwT8RKN8rOnKeucSqqTL0UVn72jJ6B6v01NIw1lCvtJxQ/BuSi+I
         1liC7DiU6dxyfF/HVI+N88SoGmpLWLhqiqrm9vtko3Ivjhr5QcwaAOuKigRvw30bWe3w
         hKGvl/p15ot6C9dsAnvnewk8mAYzAOxVgUsshCxryyE9lNMnIpatUAP73rkcsxgaZDvY
         hBTTwzq2fYZhJF34lnkkXFgk5HPZdiyeCLnAaysR0OTE5puIFJHsOa5Q6BxmuMYBRB9M
         fpdGF70ax9KA9fPxQsDmXLBD68O/d+JGeS2Et2mwN/cTjFnBxXUpVHabG9LzQwXqE/DG
         K+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489896; x=1779094696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=azn/NSLn0BnsUm6Ly/kYoa1KZWOFIsStyNt2O/IjY80=;
        b=Ya3TudNUslevBjEsjQFv9wB59B9rE3BtyYdYrgV+te8GpeekgFFQqy9zfYJfijg+bE
         3E2NKuHYjT0+/zyJ9hh9U1+ESCOU4JFhy1bErRSAnIB/pafF75I5XFcwlnLL3mXAkjxR
         j1fQxVl9wPb/l8SikvzoQXMNkqSS16s/MzBTIe66OMcBz9ALnMTinYB2xVOSSHU0IzXA
         uDxdRXws720XjI56GFnDwYIs0MHX3Y9Yu0izULNG0BCk4o3sis9Ko00Gc0bAKCf83Qb7
         iffT0d0NVTIJb/VteWSDYKh/snShrJOcyZxtAp2urdJ12rDuC5mreJORw0nLDv/dvvL0
         r2TA==
X-Gm-Message-State: AOJu0YwHy4PXDj3Dsx07KGVLpVadF621RL2NumXRFKqzoZFd/ZBwBwQq
	N++VyiUzh4EnRHvK+CYh10LiEvQLkRhEjFkV/jD2y6CMYHJyl7AueKTDJIggmXD9Fm0VZDlInPD
	BokyDAYEmrefxqRN1Z2JDar9q4UyOXWvI7fyQ
X-Gm-Gg: Acq92OHsRmVeyr84w3MJB8RFS7dHCFfzQ5niHvAGgq4EG2Vr4Tyxs/wFSwBiH2YiYVH
	1+V/TKE6Nn6P/XyPuUHD24iXcWtIUXX6mY3DjO5s63FTxebbFFVuH3nnZu1Cb/reMsbGzvepdvm
	a1odkyKnwCdDFZds9xLJ3eJNGXcjkC6S85Hj8VwrlNaC7ze40tlBXPlZ7Sa/58c+yWB/woTXgUI
	71YHRm+6fk5T0s5p+qMynS8iYQ+RrfV8e/MCz8B7j87bzhA1kzkAUfB1Cx+FEGPA9zgVDZpCgWz
	+D6mpq6RprXudW0Y6+P1
X-Received: by 2002:a05:600c:45d0:b0:488:7ff6:1f75 with SMTP id
 5b1f17b1804b1-48e707f821dmr142589435e9.21.1778489895860; Mon, 11 May 2026
 01:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db11380dfbe7fff538a1a052fdfc5905202981a4.camel@sipsolutions.net>
 <20260509234143.101237-1-masashi.honma@gmail.com> <ecb7aef2f18cc7c04817be155017a54a45fa579e.camel@sipsolutions.net>
In-Reply-To: <ecb7aef2f18cc7c04817be155017a54a45fa579e.camel@sipsolutions.net>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Mon, 11 May 2026 17:58:04 +0900
X-Gm-Features: AVHnY4KCbwTyAJ_R0_If2RXTHP5yhaFD7PT4GBTSdBljAjzIpzjKMDwjsZdejGk
Message-ID: <CAFk-A4mD=tKHMp8qqAvrsFZjmJHsA1sBe9Wmmn=qEacNMxTH_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] Fix overread in PREQ frame processing
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E4A4750A9B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36213-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

Thank you for your reviews!

> Please send new versions with a version tag ('v2' in the subject etc.),

Yes. I used --subject-prefix incorrectly, so I will correct it from next ti=
me.

> and not in the old thread, that just messes up the threads.

Yes.

> Ideally tag which tree these should go to, though I think given the many =
other
> things I'll put this into wireless-next anyway, unless you strongly feel
> it needs to be in wireless?

I'm happy to put this into wireless-next.

> Also, please use appropriate "wifi: mac80211: " prefix in the subject.

Yes.

> This isn't really right since u32_field_get() exists only within
> mesh_hwmp.c ... it's probably better to modernise all this while at it:

Ah, yes. Both the build and tests passed, so I overlooked it.

> and restructure the code accordingly?
> Anyway, I dunno. Maybe we should just go with your original patch for
> now. Maybe I'm also asking more of you than others because you have an
> LLM to help ;-)

If it is not urgent, I would like to proceed with the requested restructuri=
ng.
Actually, I only used the LLM to find potential vulnerabilities, and I wrot=
e
the code myself :)

2026=E5=B9=B45=E6=9C=8811=E6=97=A5(=E6=9C=88) 16:47 Johannes Berg <johannes=
@sipsolutions.net>:
>
> Hi,
>
> Please send new versions with a version tag ('v2' in the subject etc.),
> and not in the old thread, that just messes up the threads. Ideally tag
> which tree these should go to, though I think given the many other
> things I'll put this into wireless-next anyway, unless you strongly feel
> it needs to be in wireless?
>
> Also, please use appropriate "wifi: mac80211: " prefix in the subject.
>
> > +#define PREQ_IE_PREQ_ID(x)   u32_field_get(x, 3, 0)
>
> This isn't really right since u32_field_get() exists only within
> mesh_hwmp.c ... it's probably better to modernise all this while at it:
>
> #define IEEE80211_MESH_HWMP_FLAGS_AE    0x40
>
> struct ieee80211_mesh_hwmp_target {
>         u8 flags;
>         u8 addr[ETH_ALEN];
>         __le32 sn;
> } __packed;
>
> struct ieee80211_mesh_hwmp_element {
>         u8 flags;
>         u8 hopcount;
>         u8 ttl;
>         __le32 preq_id;
>         u8 orig_addr[ETH_ALEN];
>         __le32 orig_sn;
>
>         /* optional AE, lifetime, metric, target */
>         u8 variable[];
> } __packed;
>
> and then some inlines like
>
> static inline const struct ieee80211_mesh_hwmp_target *
> ieee80211_mesh_hwmp_get_target(const struct ieee80211_mesh_hwmp_element *=
elem)
> {
>         int offs =3D 8; // seems wrong
>
>         if (elem->flags & IEEE80211_MESH_HWMP_FLAGS_AE)
>                 offs +=3D ETH_ALEN;
>
>         return (const void *)&elem->variable[offs];
> }
>
> static inline u32
> ieee80211_mesh_hwmp_get_lifetime(const struct ieee80211_mesh_hwmp_element=
 *elem)
> {
>         int offs =3D FIXME; // not sure
>
>         if (elem->flags & IEEE80211_MESH_HWMP_FLAGS_AE)
>                 offs +=3D ETH_ALEN;
>
>         return (const void *)&elem->variable[offs];
> }
>
> and restructure the code accordingly?
>
> Anyway, I dunno. Maybe we should just go with your original patch for
> now. Maybe I'm also asking more of you than others because you have an
> LLM to help ;-)
>
> johannes

