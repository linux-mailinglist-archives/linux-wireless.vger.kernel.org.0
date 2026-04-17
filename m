Return-Path: <linux-wireless+bounces-34960-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGPnMmec4mmx8AAAu9opvQ
	(envelope-from <linux-wireless+bounces-34960-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 22:47:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DDC41E903
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 22:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7007D301CED3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 20:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876D432BF5C;
	Fri, 17 Apr 2026 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbXiJ/es"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC352264C7
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776458839; cv=pass; b=l53Xpk/oi1zHgAbOwPf73uBPhe/dAooP2BCyQ6W3piU9QPIiXVIj7SnJuMdb5MEQdpheUJZuM5M3rFp+ENdRy00urF0itvyZsVHv9ZOxSxJfrIvJE5wMrnhpQ0ypRywcrj/jV3XFDt4r9Vkpse1nk71MNwI5Ku+gIvpX2j5D1V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776458839; c=relaxed/simple;
	bh=fkLn4MUAb/1CdcaVVBNrvFmjlYd3Xzh5v+4UhL/ncyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UySOXdh7JPiLLNI64+jjieQxLoFXIYjvm5TcLDf1Bj1mR4XGiwJSNSa0aqauz1F99c8yJgczkqjByQK4F0Gw9EhzHF5EK3JaDinXDruIxQovZzl6GXFcFIS05lwxu1byP9Bdvs5u/1iA0YtJAGRUn1Ya0ATsm6y6Nn+fmCaTYRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbXiJ/es; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9c6680aaf8so174592066b.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776458835; cv=none;
        d=google.com; s=arc-20240605;
        b=Z2tIIjj/fBsq7dM6eqB0uP25Uh6y/AiuspgXmUXMndt4ErDgRrO6mNf+ZHvCShMKjg
         CUgzAZI1LJ3pgYPumdtFdR6y7KWZXFUbA6C2dCucQcYKBPqLhtJYjELBh0/H4jCEDBm+
         gZZZodmoS/OuEV+OhaGCvpE4Sr+Pqgg9ymqODwqB3FE9Zy1c//SCex/5MVLRPW8w5mwS
         tQJVj1fmFQle7FroT2BxP4DR3dHWnvB3gu7/Mnxk0OOYIaxbN/KWY/WAYTz749DcmvCW
         raq+9Oll7i9es5UrK56OCmUIEmEiSiYjMeAxmubNcnBU0TY1oy2GfcoHjEF3pkls6MId
         55Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/YDtpkD+GmNdsxlX7i3/rbUlU6XEg9qRnletGPADEbY=;
        fh=HeLoDOuFf5mHKuKPpjZUnN4I/jOvL3RcLClOicUUC4w=;
        b=JPUByBBCYTgkqOgG+SuLumzfcfB+O3QO0ECksGnfMNoAOYqJMZF4iBb3u3aYswMRzw
         bIfqDpI9e7RfoiZL8I1KHI7uVj277ZNWXKSTa3QSPS0fx3zfO0xA8nYjIog/rVpksLV4
         6n1lhyzprj0sezrggk2PV08mQybKjL61pzuWPI6KO3S2xXA93uRuRUlDAlvzPZuikgMz
         GqGiSWYK22h+v206EWAWChrYVtyIznsnzFrqNo8qVloXNRVKvDYiVMicr3yB1R8tON6A
         UxqPoep17Rmjj0bovGjeEeXnKBBz57ktDFB1wUwKV2L47n/PFlfaxK+hnc5k2e+Fu756
         XhZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776458835; x=1777063635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YDtpkD+GmNdsxlX7i3/rbUlU6XEg9qRnletGPADEbY=;
        b=GbXiJ/esnCKHAbWkSn9h21NxnG9FojIjvFm9idZEecoEdRkR4JLZzoVG5PWgU5HY9a
         jqyboMSZ/bpUdsKl+4o9w4nhfZYRupIXklWVHg25fcJUiBZ4kcUSM4Kp9tK8qegT1Sae
         4zCWrwZba8RKKp0Xo1aeBLglNWAELP+amHdB9aPnOgkZYr5Cd+0aUGjWYNo/xILH86e7
         gQ2aQtIMg0Rx4WhkI+4Kbw6DwXEUrv11lyRnQFzMBmhgFpVrFCSUn6d0m54grhrpp7nR
         hqclj+0XOkJK/OAtM92W/8d0f5annVF+YL0mMYywPKQSbWv/nTOqn7Yla9ElynIOtBZ4
         txkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776458835; x=1777063635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/YDtpkD+GmNdsxlX7i3/rbUlU6XEg9qRnletGPADEbY=;
        b=KGUwJp1NErAjtBi2whr49OgDUKAULODYuueKQgjqSmmqXXAX+8E7QyM+cPIPJwpth6
         zE7x897COSJHhtYL1wJFNIPnU01Nl4itOMmYsVuz9aBrdL2N7trAD+X+dMmTpY2FtDn0
         7vP0OWwFMnJ2zF2VdOVVDkCYnw5XdymFbjuzJzZhUz/BK4YDRTkc8L0KaSvdi1RY7gwV
         5NDSmKRE/aFPpGFnMpf977q0I9iMgY37s8pbUzMBEKaN5WChuRFsNGxYT/udUBhOZizu
         i9yhzilthl6ghmFAKywXbX58wso18+kJL5nnNazHOm3QzPxV7nm0BeznPKx4sKtb09XW
         rkVQ==
X-Gm-Message-State: AOJu0YzORJ+LaM8u4ciAbgD7Jzx/cS/HyjxpapNr6rwu8+b2XVAVzK7J
	Gqcy6ANqzqqhPVOf5h+TtNVqLq4f1/k96eAoVHEYrs7LIvfB+xlusMhybfJzIJnzD9daJ5WHIGe
	Byp0xWdLdW4Jzuw42soNWpiEEBbZL1KI=
X-Gm-Gg: AeBDiesDjJ7q50dFBpA8osaZOb83Hau7lZV1JbxtVrD43Fk2FRq5t5FBEl7u3JD0arb
	6N4ooHGc3BzrTT3Uip/qb0OVlmCZ8eL2E4WG9ymnsOLt7s6J+z6Z0OS3KRFtQsallvcbE5e+718
	JPy475tR+SFcEl9AjZqWpxAWku70qTyw2t0LDT6tkvMdA5+MUxl8iDagnerbgAgbjvt9HgmvgWH
	cr0OJtnpmiI0nI89QmmzikYoAVhvr/Wau6aUfgGv3NP1UGsYsCzX/pP8FnGLChxhtgwJ/o3JByv
	2XtOceSV4Siri4+37sfBvtsqnvW/j+AZbGGbOpqURjS+zKBdKk0Mk9KudcW6hCAXaHo7MT+jcHs
	6tMcDzR0iJRMD0qXF
X-Received: by 2002:a17:907:3d02:b0:ba4:8ecb:7d69 with SMTP id
 a640c23a62f3a-ba48ecb824amr199874966b.13.1776458834892; Fri, 17 Apr 2026
 13:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331233238.23527-1-rosenp@gmail.com> <a612564e-7338-430a-b7d8-8276adb45b05@broadcom.com>
In-Reply-To: <a612564e-7338-430a-b7d8-8276adb45b05@broadcom.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 17 Apr 2026 13:47:03 -0700
X-Gm-Features: AQROBzCNC8Wra5fJSWY11x4yLjA-7doLAGoTcu93dmmZhzp8sgQDeMKM48XVbyc
Message-ID: <CAKxU2N8yEfv0RG9Owb0W8PtmbDSzYunxUJzQo0v8Gvbw2PCBgA@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: brcm80211: change current_bss to a FAM
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, 
	"open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS" <brcm80211@lists.linux.dev>, 
	"open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS" <brcm80211-dev-list.pdl@broadcom.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34960-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 08DDC41E903
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 12:15=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 01/04/2026 01:32, Rosen Penev wrote:
> > Change to a single allocation with kzalloc_flex and remove some
> > boilerplate.
> >
> > Done as a FAM instead of value to keep -> usage in codebase.
>
> I get it and it looks a bit like a trick, but....
Used in many places in the kernel:

git grep kzalloc_flex | grep ,\ 1 | wc -l
33
git grep struct_size | grep 1\) | wc -l
99
>
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   .../broadcom/brcm80211/brcmsmac/main.c        | 32 ++----------------=
-
> >   .../broadcom/brcm80211/brcmsmac/main.h        |  2 +-
> >   2 files changed, 3 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/=
drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> > index c7eaf160e1fa..4f57d64b1dd3 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> > @@ -418,21 +418,12 @@ static int brcms_chspec_bw(u16 chanspec)
> >       return BRCMS_10_MHZ;
> >   }
> >
> > -static void brcms_c_bsscfg_mfree(struct brcms_bss_cfg *cfg)
> > -{
> > -     if (cfg =3D=3D NULL)
> > -             return;
> > -
> > -     kfree(cfg->current_bss);
> > -     kfree(cfg);
> > -}
> > -
>
> ... it does clearly give some code reduction.
>
> >   static void brcms_c_detach_mfree(struct brcms_c_info *wlc)
> >   {
> >       if (wlc =3D=3D NULL)
> >               return;
> >
> > -     brcms_c_bsscfg_mfree(wlc->bsscfg);
> > +     kfree(wlc->bsscfg);
> >       kfree(wlc->pub);
> >       kfree(wlc->modulecb);
> >       kfree(wlc->default_bss);
>
> [...]
>
> > @@ -527,7 +499,7 @@ brcms_c_attach_malloc(uint unit, uint *err, uint de=
vid)
> >               goto fail;
> >       }
> >
> > -     wlc->bsscfg =3D brcms_c_bsscfg_malloc(unit);
> > +     wlc->bsscfg =3D kzalloc_flex(*wlc->bsscfg, current_bss, 1, GFP_AT=
OMIC);
> >       if (wlc->bsscfg =3D=3D NULL) {
> >               *err =3D 1011;
> >               goto fail;
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h b/=
drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
> > index b7ca0d9891c4..e9cbb95a5a17 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
> > @@ -614,7 +614,7 @@ struct brcms_bss_cfg {
> >       u8 SSID_len;
> >       u8 SSID[IEEE80211_MAX_SSID_LEN];
> >       u8 BSSID[ETH_ALEN];
> > -     struct brcms_bss_info *current_bss;
> > +     struct brcms_bss_info current_bss[];
>
> It does feel icky to use a flex array for 1:1 object relation. It seems
> the lifetime of both objects is exactly the same so I would consider
> using the value instead of FAM. It would give the same code reduction,
> but making the patch slightly larger.
>
> main.c: kfree(cfg->current_bss);
> main.c: cfg->current_bss =3D kzalloc_obj(*cfg->current_bss, GFP_ATOMIC);
> main.c: if (cfg->current_bss =3D=3D NULL)
> main.c:                 wlc->bsscfg->current_bss->chanspec =3D chanspec;
> main.c:         rs =3D &wlc->bsscfg->current_bss->rateset;
> main.c:                 mcsset_bss =3D wlc->bsscfg->current_bss;
> main.c:         bi =3D wlc->bsscfg->current_bss->beacon_period << 10;
>
> So it is used in just 4 places not counting the first 3 hits for obvious
> reasons. Not too much effort to use value here so please do that.
Sure. Will send when the merge window opens.
>
> Regards,
> Arend

