Return-Path: <linux-wireless+bounces-35275-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH/cI3R762npNAAAu9opvQ
	(envelope-from <linux-wireless+bounces-35275-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 16:17:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6F8460152
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A12F93007491
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB36C3DBD7A;
	Fri, 24 Apr 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aujSue9d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8A3DA7C2
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040242; cv=pass; b=nZfRnAqilYlfd9IsdNDZwkdnyht0CMUveFBn19RP5qNay1fA0PaiAWHzQu7ysNGj8KOpve89udmLWrZngLvFyee2miCQ32VjX/7Os5Q5+gJtquGFQ3FV1zSJrgPjaOGtq5P0xLMtRijiLpvw2B7fFqZ+MVa9fI7NXYrq2HhQ35w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040242; c=relaxed/simple;
	bh=JVJy+nXdugt4xD+J83pQi2aCdw7maFhtvnyAdoRkUro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCK3ygRMb8GTrr2xQfGEQm2aLmtKeTkra+YQCz2g0vd2Qrg3U65O40rPt4H4ediS0tzc0CFPcd7QJOCd/CMdZJCNfwQo9RtVEXJIPEWcfP/CH7iLgIBNWD9qiBnr/hDEif4ci93biEvU8sXh1neNhePTdKcQpMpQMBTESDLSzA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aujSue9d; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4042fe53946so3510486fac.3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 07:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777040240; cv=none;
        d=google.com; s=arc-20240605;
        b=lr4HvffT7KGjvjUvnblodR9jNMkpO1KRAHHz0PdAzEzxP0zUEarObDZlZMM9iUSrO6
         cTdY4UMIZ6DzAmjvqzra7wS9tO/Jwxp5asfdX3HnbNLyD3kPmtzPx+xqbQwQ59m6qxQy
         iMzVKoa08rttq92QczQX8U06+amIQvxK7ZqqedoUawHzE+qJOeQs//n7Sa0npDZIqok9
         gj00qVj/BKieXq6JTgLGtVmWPaMu6HdqXLRi/60+exX2CTagC9hCE6o3dd6HUDGiL2fG
         o3o3rnVQNbKe2jtMyM00sowkXWL49tqXWLNM0SAbH1u6br7T/1asVqFaZ2sKGpmkDlfO
         9Jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JVJy+nXdugt4xD+J83pQi2aCdw7maFhtvnyAdoRkUro=;
        fh=7NBKQagzY/vC6vOaxUJNvCGKtZhiYfAWVqAfWr4ZmLU=;
        b=dZstXdTSpBSyq/0gzpTbCl/NYZKf8C+ZQiSRltjjaDA5MWdFxEYDqmrAz+zm8drIP0
         ayv7JYZskvrRCUDo53MEt99UAU75/tPKFJdbHoA9xwyqNKFuBUPP0eUyyCG64ytns6VH
         kdzDtBA5BchEBLNi5F5X+lT2YyQmxSwq9oSC+/ywlVGulanXT7BU39+IbM8ro0IF+sRR
         U6VQaQ4P7rqvewOnw16xi1rXN94fdpU+X4guA6FOraJAFnot4OykkP2SbwNkdCWt4eLT
         D5MCCqZBbPSNFCa7YyaIiqBrzLhceDJFPsUALIbQWzO/HCI+l/Xo6uhxoNDIjglnfDWy
         aUnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777040240; x=1777645040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVJy+nXdugt4xD+J83pQi2aCdw7maFhtvnyAdoRkUro=;
        b=aujSue9do2S5FZgUPDfgY1kZNvlfaq/8utYXTtGnaX/z/rF7xUxxK+tgp29Y8Nk2Md
         BPGg6mTFjQmOLkw24OBuuoHFMmLhyyakDJb37jA5UN63Om1zfUbTSHStOrm5LSvDBq0P
         wSqeCnn7JvwxIMB1hCderLThLonb+unwKoLdUu1yczSSvZ+WLILKx/cyBm7At65A1s5m
         jeIfB0fYMJyRC+f5xzbR7f16tjIMHG2sCFN//De1/TDM/jpvhUjT8Me4vgdAFbzgV+uJ
         9iZg6gazsdyNdkfpZTy3eeXKHxulqflnbofstWdtv9Y036cS05+TEMMPvGaXuDwQh2E9
         kx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777040240; x=1777645040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVJy+nXdugt4xD+J83pQi2aCdw7maFhtvnyAdoRkUro=;
        b=rwJ9q+h70AFB3zs4wt6nhFdnlvCyrsauP8zShP6R+mKLngzSrk/8IasLGGnZ4KCOuu
         IxwiWX+Z5d+Ek3ljnZNJAKI1OIrPGh8IkPoGH2QSSVU/vy2b935vTYOYuJqMMYYgByeL
         b2g24rhdTxU3Bz4fN11aLTvjwp7ZY7oG5t0QS3SLehmkN+mhYwqWB0WPpzUfkzkzdv02
         nJhm7tKWKQ7EMRVUCfw0N5Qn1c/J0+2nM880dHwz7+Yxz2JdnGiDRK/8SehsHBwv0YND
         QdtMb/lx+HqOOnQIaEsLDWap/bcNqrDPDugCZhfpuDmwgzY9A438WgYycQ0cJjt5shTr
         Hxhw==
X-Forwarded-Encrypted: i=1; AFNElJ9wtjPiu4fgitQ8DL5413IxHs1wQges7EwD1pra5vM9mY/VdyYlOhkAgkxz//xBWqfK80SAzEg1NJvqSKo1Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1OxzoFeIuNtuKNlxCbwA/VfF9kFku6LGES8THe+IN+iFQi7t
	aAPP0e34E7xlrSV3rBHsLVo/D1bxDC+Y57nA6g2rWmdlOaCwNw69e8O9w5VRg8R9EenWk8a3itU
	uMafAHDewVvp5hcvWeLWVAk/dooNXj4M=
X-Gm-Gg: AeBDieugs0dc9j0H/G1seP6bWZ3L2pL6t/E0R/nTfr5PySFKJmNe02Rwj7macpRGcgv
	vFm8VvTApSxE6UVaE5AIppGdyR8lpMwYWcyZuVc9YZbnA4e3BQONSNwENRvsyU43iv8wTJx41cn
	XgTXFFmei+sph8sN+5gMGl4UT/9GZihpcjt/6ooGqufE4KyXiiYjx/9tt08DwRz88ADgHzP/8Fw
	0OKp70Z5Njlctv8KugowvhhhXz7M/qPrJohvHTPH/PVmaJDRXw6c7naoHT6gC4SXz3j60sQXN5m
	efetiH4UdqhD299HHdw=
X-Received: by 2002:a05:6870:ec86:b0:42f:cd67:2b84 with SMTP id
 586e51a60fabf-42fcd675157mr6569859fac.9.1777040240077; Fri, 24 Apr 2026
 07:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com>
 <20260424120807.25005-1-brite.airgeddon@gmail.com> <9f7df38831598001ac6cd79ab4fb95b4b6e042fd.camel@sipsolutions.net>
In-Reply-To: <9f7df38831598001ac6cd79ab4fb95b4b6e042fd.camel@sipsolutions.net>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Fri, 24 Apr 2026 16:17:11 +0200
X-Gm-Features: AQROBzCiGQ9MNzvUQgmsOAF6TO5N4ZOZBZVCyKpjKoIGZJ9NhsHqPIW861F562o
Message-ID: <CA+bbHrUaOJgW0ZKjA5n8bnBE4wdynV9XXiyzXWxfX7NEmMZ0_g@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: restore monitor injection when coexisting
 with another VIF
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Brite <brite.airgeddon@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, fjhhz1997@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3A6F8460152
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35275-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sipsolutions.net:email]

Dropping? Do you mean it will not be taken into consideration?

I tested this patch thoroughly, and it works very well. I am well
aware that kernel developers are reluctant to accept anything created
by AI or LLMs, of course. But please, I think you should review the
approach and perhaps use the idea to implement it in the way you think
is most appropriate.

Brite has put a lot of effort and time into this, and both he and I
have spent a great deal of time testing everything. It has been tested
as he describes on kernel 7.0 and on the backported versions. Side
effects have been addressed, and everything is finally working well.

All we ask is that it be taken into consideration for adding a
solution upstream.

I already have a .deb package that works for me on the Linux
distribution I use, but it would be wonderful to provide a fix to the
whole community so it works for everyone. Please, I kindly ask that
you take some time to review it.

Thanks so much, as always. Kind regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El vie, 24 abr 2026 a las 15:55, Johannes Berg
(<johannes@sipsolutions.net>) escribi=C3=B3:
>
> On Sat, 2026-04-25 at 00:08 +1200, Brite wrote:
> >
> > Earlier attempts on this thread addressed the same bug but had side
> > effects - notably full VM freezes during the airgeddon evil-twin flow,
> > reported by =C3=93scar in the thread. This patch takes a different appr=
oach
> > and has not exhibited those side effects across the tested configuratio=
ns.
> >
>
> I don't believe that all this complexity is necessary, and the code
> changes have are fairly clearly LLM-created w/o such disclosures.
> Dropping.
>
> johannes

