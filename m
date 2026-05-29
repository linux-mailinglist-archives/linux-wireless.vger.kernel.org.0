Return-Path: <linux-wireless+bounces-37156-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGNwDGocGmo+1ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37156-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:08:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BEA6099E9
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76AD1300EEB4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 23:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1333624D3;
	Fri, 29 May 2026 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPKxcZAz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C49035F60B
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096027; cv=pass; b=W1LSKVYK+h+hfVgsj1lSbpvkXnOq9Kk+HQUvXCXJ2yIs7E/QpB/yj4iO/VO4/TWGADxZosekywyL979A1yi0SJGwPvwywqiOS7XidUt1xiXdkLIVkIhliHMvF9zSvX98Iy24EU+xbBBp0pDtUmxTR8WLupheguOQEUrFqfqESe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096027; c=relaxed/simple;
	bh=+i6oTMMi0lBQhiTZ4h1Nt2uDS9ikXNLxfxIvkhcod1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sfj5OF4w4jURH9reg4ZshuJIycQcfnu+K2kdgc7qk6ZXFvWAaGJmpUae6fPabgz0UE/bEsFH41eYiv5seusRZg3g7f41b3L/j/FjGxJphlfioQ9DplBHAy+ar0fqXbmUA0S9DUiXhjRgILHJUlIkvBAc81fb7DISSzcbl/+HL0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPKxcZAz; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ed18d8a1bso2969965f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 16:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780096025; cv=none;
        d=google.com; s=arc-20240605;
        b=cbcl6pw7S/7J4SRZVEB3jQqTpizO6hgZDBNooKewy6RBf38OfYDAJK4drdLoqt5rP+
         KM2vBan4my5XtvqTDxA7HIVy0b+cyZCRpkGMY2hhsdNQKvalbpqzS8KAmZawh9/djrfd
         YlRM/OWBUcnD7PBUK38i4eN7jNGEa/6xytTza9aGOf0OzNI0Y0I5uTWMsgwyr81yght2
         jTwEd91VFIgI6sojwX3juTAZo3ptCMY/d7kRRy6Mamm9xXXhLuTuzo69b6LMKd2znJxd
         o7X2e2kPJRVhsvmmpCY5xjvY2Mo5a3rlz0I5uv3y3+wRCvt12A0G9IpAM/0ro05pqIA6
         qp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gyWMTH84PoB99pG6TSBiMX14wjchufh2MLEX9x0gR3k=;
        fh=kiH9BsJ+TyHZ/0f9lp96S1R8k/374lMiI4doNuDXH6k=;
        b=Mbpy7EM8Zm2+awdiu2Nfp1PMfbcsVtCg9+2gJpGijE0ksJKddiBXH1SIpyuMe/ny+/
         AfsM3Artx96fT8BUvYQcnH1tX9IjOw2zz8sZJAP3/zYtXBrqrcBSuAhU+y4v6Qn4eJ/F
         kEC9wjgnW7SxoKJfu4SkMnN491VNSRdwzdmLpPxItXJlYfHGkWJTqLy6BiQE31urlDjc
         Zn09XtxTZreFjMzKYQBq2CvfN2A1f/nPDqH/Fen1igKCaW1cmxc9PmlF3s0yupW2vvOt
         VLR9bS6ldDNt5FFVItVH9QlcRNAmmOOxsgwSGJWyo+OK3H5p0lfogVgzwT0+RYiHHLUv
         +fQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096025; x=1780700825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyWMTH84PoB99pG6TSBiMX14wjchufh2MLEX9x0gR3k=;
        b=fPKxcZAzMDbEXs1Ptj/zoisR2k/MvZZhFhnnO59QM5R1Dv0SYTbb2tOp9JNuZf3ctB
         5yN4odBU215Pf815YkQnU4qv2QyfudvUAN/afBe+TjLKEcXzzMNkxdXmAR8/JaV3EoQz
         bXWGDbO7SnMf+vAJBCkWbnX6Aq+LR8kPKw+DsVFbnoQlMXG2afdnGjtWv3u+9pVqdVrV
         3cTWvhZdzpWDZ9CftBThh6trm3Jkx8KqX+KOBJxiGMsalHy/jGj7X8oJ/FgGagXJ8D3h
         tM7XKCEbNfasunNlBTS+TXgzcYaun6NoxMXsmLW29BImGlfZjxyl4eh5f24UpE/vEi52
         Yv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096025; x=1780700825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gyWMTH84PoB99pG6TSBiMX14wjchufh2MLEX9x0gR3k=;
        b=DaB838WrOJFXKtixRbZTAJ4062vbOmCDrG7Fv8E3pzaXQaoWswyW8j+sAZ8+gUbNwb
         0GBOumLMIpNeBhG3xu5FLW+t+lNUDifk35YMUSM3I3MIF5dXWthPbS1o67rFmnte/PH1
         w8YP3GYJVFCBSbTlyzhWB7Qj5zeRx3Y9N0xRaI+GDosaSYI9zTOZ+PQYwQSLWYJfDbec
         UccVNd07g7Rn77TwK1f911lQ2KlA21rkxybpbVMLPpNmmFsljN7GkF5oJXhPTpxn4y8X
         nGNOZyc+GkjicOfEFJ7f7NqOrjtP1l9GCorOM6Co23oSs14CcaYVtwgtJHClv4Tl9hHa
         7wEQ==
X-Gm-Message-State: AOJu0YwODbkqpkMZkpQFYucob/bTua05vnqKFd68b3I3Z1H3e5Gg4atI
	iGhH5OIwpLl93BjCJBVw6z67mxdj1RYp4LwxZ7BAPn0u90ydJZCzuWm4EY1yHGkRvBEOh2b67k5
	3KvtHkbH8RENkZJwY0k7EDTarG/liBc6ayw==
X-Gm-Gg: Acq92OG5YPQDKDlwFbqHBPzWB9f5hUGrOPDMtVE+NCMCrsShthN7FEhBg4sIsF0pn+B
	HTD2MFYcyNjYmNJ3qnlX4SRJt5Qns9zj5Tp8mCcEvcw9dVAI+nzpNJhOkiXcZJf+fsGTgEEP/jn
	anSI5M7nQWHftZEa5KY7Qs5iZQrpI44d/C0+lgVOyxTPbwSJ1tA7QJXCxqoNMRbxfO45O6ZfyLB
	YZkmitBKkvBcRGXRifdfP2ZtKjek0TQwfF+hwMJbUEnlruc83i6gxWsopWKLReiSITz5Abmylv/
	W8W/FWk7kk1ZUi5SnxIaHQ31No+ZuHI=
X-Received: by 2002:a05:6000:41f9:b0:45e:93d6:359b with SMTP id
 ffacd0b85a97d-45ef6b2254amr2850165f8f.9.1780096024736; Fri, 29 May 2026
 16:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521225842.31815-1-masashi.honma@gmail.com>
 <20260521225842.31815-4-masashi.honma@gmail.com> <f268572dbc71a4941523c510349207afb3fbe34c.camel@sipsolutions.net>
In-Reply-To: <f268572dbc71a4941523c510349207afb3fbe34c.camel@sipsolutions.net>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sat, 30 May 2026 08:06:53 +0900
X-Gm-Features: AVHnY4KK2k6d7B9s0sJnF31zq4LxYy_xowQVAiZqNV1eRjqBcTrKJzRMA3lBwEM
Message-ID: <CAFk-A4ntcNWj741tqYT8m82HrrbDxvd4ahiSKqgvs65weq+-9w@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] wifi: mac80211: Fix overread in PREQ frame processing
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
	TAGGED_FROM(0.00)[bounces-37156-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: E2BEA6099E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yes, fixed.

2026=E5=B9=B45=E6=9C=8828=E6=97=A5(=E6=9C=A8) 17:04 Johannes Berg <johannes=
@sipsolutions.net>:
>
> On Fri, 2026-05-22 at 07:58 +0900, Masashi Honma wrote:
> >
> > +/* IEEE Std 802.11-2016 9.4.2.113 PREQ element */
> > +static inline bool ieee80211_mesh_preq_size_ok(const u8 *pos, u8 elen)
> > +{
> > +     struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =3D
> > +             ieee80211_mesh_hwmp_preq_get_bottom(pos);
> > +     u8 target_count;
> > +     u8 needed;
> > +
> > +     /* Check if the element contains flags */
> > +     if (elen < 1)
> > +             return false;
> > +
> > +     /* Check if the element contains target_count */
> > +     needed =3D sizeof(struct ieee80211_mesh_hwmp_preq_top) +
> > +              (ieee80211_mesh_preq_prep_ae_enabled(pos) ? ETH_ALEN : 0=
)
> > +              /* Originator External Address */ +
> > +              sizeof(struct ieee80211_mesh_hwmp_preq_bottom);
> > +     if (elen < needed)
> > +             return false;
> > +
> > +     target_count =3D preq_elem_bottom->target_count;
> > +     if (target_count < 1 || target_count > 20)
> > +             return false;
>
> While this is correct now, I think it's perhaps too tricky ...
>
> The reason it's correct is that needed starts out with at most
> sizeof(top) + ETH_ALEN + sizeof(bottom) =3D=3D 17 + 6 + 9 =3D=3D 32, targ=
et
> sizeof is 11, so 20*11+32 =3D=3D 252 and cannot overflow.
>
> But I think it'd be far simpler to declare "needed" simply as 'int',
> then even with target_count =3D=3D 255 and whatever else happened before
> cannot overflow, the elen=3D=3Dneeded check will promote to int and refus=
e a
> bad target_count implicitly instead of needing to do so explicitly to
> avoid the integer overflow.
>
> johannes

