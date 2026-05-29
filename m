Return-Path: <linux-wireless+bounces-37157-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NnRGHUcGmo+1ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37157-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:08:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 143B36099F0
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E0623015853
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 23:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C739135F60B;
	Fri, 29 May 2026 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD1sGwUJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649EF3624D3
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096039; cv=pass; b=WZUNGcoxIxlMmqjHfes8OurUgeZFH9sIIjuUNCBi3i3sDS0OR8d2KfhU2MHxt/gomotGxcaXtOVb4OiNhkszII4jD2IzIaB5iPpikmByac+mK+pF/1578Q2GM6dHSz72tmZlvo3OflkUv/6PO8rSTDEgqqdiRCNLtRvD9ZOLQr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096039; c=relaxed/simple;
	bh=T4lqJ+qev2UrFDv3spHbUxk7ugjfT1YyiO/dDeP1/2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0qlJKWbjwKTf31EwKRvryapmvuC3Io3Sd5lQAP54i/GUMrJoLzIjoOGxDCLsTGM0i4BT/u5myWPyexiODYzbTHYyyHRljvhEfSAQOxRS7GLVzCOmN1YVWcFxpvPnO1jiWfz07OIE99hGMyEbnlbl/NW7D8TF0v6DOMDXrJO0d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD1sGwUJ; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef616daf6so723651f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 16:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780096037; cv=none;
        d=google.com; s=arc-20240605;
        b=VM/+N53/KA5bD4CndIuFQP4yxRX02miOZ2bTGIRsPzjCv7E6Hs5lit4xHumXj0lnV1
         veHUbqxg51hQLGTpbc3kLLry/AEztgoL42A5oSTdxYvD7xQJS4yCY25hS5ozd8h45e1r
         A4rWNgX6vAGmNVXNSuoq1T8Nl2gE6dnxlvsVadpg9YKGeo3FLdwI2AnbzVxhYCr8QG7u
         Q4U/DG3Cn6sO42EZVRLWRo/WbH6SAA2W/oxuH1U65Nmm94dNWirkitW8uUyxCWe9CAfJ
         1A8tEYAyR3PgUSEbk098fwCpVceTjkjRx3tLlARtR0d0vsu/gBFA1aE/pdRhbwduBwYX
         6oJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KdnI05NlGA2vY0c4nAu2NplHj3lz6DRzpE4KFjFBhDw=;
        fh=kiH9BsJ+TyHZ/0f9lp96S1R8k/374lMiI4doNuDXH6k=;
        b=Pk5CmIoM3JMHKUKgleYd8alHskoSk09P+dExkIIPHjJxVR0BAynibN2jso2NL9KgNa
         MIJVtBm050la7C1b12hbXdULyzTz1+r5yxuSnpjnvWBi7zwc7nr+uxdruYDtP65LCuOE
         0BZan8Sz61zT5vzKLtEkwlH1CEo344/MtWET9qt1E30HSV/xV8gQ9eq/3leO60bKETe1
         EyZ5b2Pe5AoRRCLEk9f6IlI2WHjbyE3Lji/UmafTChzTi3T+4pX3q3Gha6+h5uxJZR6J
         DIvh7FevPhS46mJ0Lmf9lCtFWbQgKeZxAD0PHBhL0bed9Mn0S1psFSAesQt4g5sEcVfb
         Xkrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096037; x=1780700837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdnI05NlGA2vY0c4nAu2NplHj3lz6DRzpE4KFjFBhDw=;
        b=SD1sGwUJ9+438Z+32SAxRI5rDf/ndKeEQvHaakvnZ5B1JexPI4cy+Om2C1AW9caNYX
         wLEk83hESx1vsAFPz0NybSnkK0pQOJIt8YkMCWCBbOwlbrcwc88oxac05m+TTHaTBn9a
         8WOr9Q4HNe5A04Q924Cbe4IEdAblCE8FjzWSo+MWu0RW3lPkTix8lomMVaZWaFJP8+ie
         WZqcxdfMZbqo1KrOzMPYQb54vIWog5Jc8/dtMbdRl4rsuSVmn+g6CdB0u5mjBbDRtIPz
         3Rmg9BmbhzaZIMuTlCusj0sI4K4OEJCkbitVAfj0Gn2pD4CSB8zSvHd2586WmcFlyInw
         sCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096037; x=1780700837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KdnI05NlGA2vY0c4nAu2NplHj3lz6DRzpE4KFjFBhDw=;
        b=EpbvXcXnd4X+kjCs7On768at44t6b93B3Z22E4I1ukMp7dFE31a2ao4gdvTtPl0IeO
         Q7QiqItU1cwBe2c+f1J6+rNbbajsApFRma41JyjRN5ymFNTyp7gLdNpcw4nuc2jv5ZBi
         HdK7ua33Hi+PYjGGH59Nq/cGhRxH6ijOGFqEAGmlfxTXXaz4uWYCMAOocSA/hwPbFsk6
         Y8dN6n5l+uFeiz0kWv2iBysDL222z/ntd9XFskcXvamDMO1xjlWYEeEiPWtqKnb15oyC
         BzM+jJY28+Eu46XvXvJ+vE/mkBnxcN6vwShk2YYb8u9IVWyeARerwytqF0s+xDAljdFX
         bRrQ==
X-Gm-Message-State: AOJu0Yz3PxpkyjEjUT/179pQ5I3VGeB0Iz/n31MdF1iI75GfDupJ34WM
	YGMfMDhHKwF04kSI9iD+QyGTY8KlXfOrck2nKtSXG9NsqxNdvI/pbQwFEdeyp/dNZhIF/Cv3J60
	zcFh0spCcyxXFWqvkNHvGd4nEf1Uwi8Y=
X-Gm-Gg: Acq92OEmcSWN+8uRB9x5IbkZL8lSZ+WP/gMI+FFwmp+EGcWhlYGCP0Pdz72VXzOZUOx
	rJoexyvDBCKA4NoFR2IBsQIiG0r79hfzRlzcavQzV6jjiYIOYOEpF4YNd77XLruwAY/rVX3Byjx
	ZSl+PqFsWw3U9GAH48zyHVlQxviL7AkVR5t3ssDTO0kWMSEXv/dftJpqXlFn+gSFWvArZ6JBUE4
	avn1lt8PNOkyOxjovJQeHxgUVQX+qYg4i0mJG2NbcyKEe06B8rsBSDuiCeecrt+FFy9komnnZI0
	mugYmwLGVYNMEvyJNcm+waHi0eLJ3N8=
X-Received: by 2002:adf:f14b:0:b0:441:1e41:194 with SMTP id
 ffacd0b85a97d-45ef6b235c4mr2343605f8f.17.1780096036619; Fri, 29 May 2026
 16:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521225842.31815-1-masashi.honma@gmail.com>
 <20260521225842.31815-6-masashi.honma@gmail.com> <244b27052cbfd1f922132f2f3c5a16d6b25b0450.camel@sipsolutions.net>
In-Reply-To: <244b27052cbfd1f922132f2f3c5a16d6b25b0450.camel@sipsolutions.net>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sat, 30 May 2026 08:07:05 +0900
X-Gm-Features: AVHnY4IlKcYEUljVVxrP2o4EbNihYXcFh2bUgGBEo08M12K5onXjC6YXJnEvOck
Message-ID: <CAFk-A4nRzsHdVc=WAjKN1GfjOAKRLNoTPJ5_e=t6F9qrHz_jBA@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] wifi: mac80211: Fix PERR frame processing
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37157-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 143B36099F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fixed as well.

2026=E5=B9=B45=E6=9C=8828=E6=97=A5(=E6=9C=A8) 17:12 Johannes Berg <johannes=
@sipsolutions.net>:
>
> On Fri, 2026-05-22 at 07:58 +0900, Masashi Honma wrote:
> >
> > +/* IEEE Std 802.11-2016 9.4.2.115 PERR element */
> > +static inline bool ieee80211_mesh_perr_size_ok(const u8 *pos, u8 elen)
> > +{
> > +     struct ieee80211_mesh_hwmp_perr *perr_elem =3D (void *)pos;
> > +     u8 number_of_dst;
> > +     u8 needed;
> > +     const u8 *start;
> > +     int i;
> > +
> > +     start =3D pos;
> > +     needed =3D sizeof(struct ieee80211_mesh_hwmp_perr);
> > +     pos +=3D sizeof(struct ieee80211_mesh_hwmp_perr);
> > +
> > +     /* Check if the element contains number of dst */
> > +     if (elen < needed)
> > +             return false;
> > +
> > +     number_of_dst =3D perr_elem->number_of_dst;
> > +     if (number_of_dst < 1 || number_of_dst > 19)
> > +             return false;
>
> Same here, though I didn't double-check this one; if we just go to 'int'
> or 'unsigned int' for 'needed', it's not necessary to even have this.
>
> > +
> > +     for (i =3D 0; i < number_of_dst; i++) {
> > +             struct ieee80211_mesh_hwmp_perr_dst *perr_dst =3D
> > +                     &perr_elem->dsts[i];
> > +             u8 dst_len;
> > +
> > +             /* Check if the element contains flags */
> > +             if (elen < pos - start + 1)
> > +                     return false;
>
> that comment seems a bit misleading. I figured out what you mean, but
> IMHO it'd be more obvious if you wrote it as
>
>         for (...) {
>                 struct _perr_dst *perr_dst;
>                 u8 dst_len;
>
>                 if (elen < pos - start + sizeof(*perr_dst))
>                         return false;
>
> > +             dst_len =3D sizeof(struct ieee80211_mesh_hwmp_perr_dst) +
> > +                       ((perr_dst->flags & AE_F) ? ETH_ALEN : 0)
> > +                       /* Destination External Address */ +
> > +                       2 /* Reason Code */;
> > +             needed +=3D dst_len;
> > +             pos +=3D dst_len;
>
> and technically that pos+=3D could be UB, so it should be
>
>                 if (elen < pos - start + dst_len)
>                         return false;
>                 pos +=3D dst_len;
>
> > +             /* Right now we do not support AE (Address Extension) */
> > +             for (i =3D 0; i < perr_elem->number_of_dst; i++)
> > +                     if (perr_elem->dsts[i].flags & AE_F)
> > +                             goto free;
>
> This code will need to change based on what I commented on patch 3 wrt.
> the variable members, although we only really use [0] and allow for a
> single entry anyway ...
>
> Probably should have an inline that returns struct
> ieee80211_mesh_hwmp_perr_dst based on the index, and then have
> ieee80211_mesh_hwmp_perr_get_rcode() work on that pointer instead of the
> element and index.
>
>
> Thanks for sticking with this, it already looks really nice!
>
> johannes

