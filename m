Return-Path: <linux-wireless+bounces-2250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5CB8329DC
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 14:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F92F2848FA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B0E51C3D;
	Fri, 19 Jan 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxOw+oUA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6B51C50
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669242; cv=none; b=fEFA5QxHyBFs2bBbVj/1kNxztOaHcdlabJdKaQWSfkW1tsqTWAHnh3GbTb0PxP+bzmV24kj3NmXr6tPpW0xRju3Hx0zizd6Z/zBjd1Hz6oKUuxgVeTf1XrGN5wfxiNDPVmpqNG2yg08cNVNbxbXmVlKjOr63sGwpgkC7GbZj8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669242; c=relaxed/simple;
	bh=mdBmJE5htP6mGHoqmVAD72lO+X8fEp+UZKSDLsltcRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nr+iPGzNd2pAaD+2L4dDDrmNd21dhdEAb9boiqn0fQ3kshtNTZL0mnkyDceBtEw7zLgtyzJWtSKG457QV+Hafvn1gU/Jdq4k1kvV5Unjmr+WCZmGdgX8wKLIqvaatAJlKAQYdmNUodaSm96P+FHdAOiJnAirTZivYw3J8mhoQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxOw+oUA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so74246666b.0
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 05:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705669238; x=1706274038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siajBaaFqK44x1k/dWoEneNkoHYdap1//tkVoA2vxzc=;
        b=VxOw+oUAKbBN8lU/5XhYBzp2UcOx2nZnAuJLuenUd1XeSQhQmA9i96F0PGLuBaz1fT
         Td5G2sxberu8BHY6fpFbSS1zjfRaBiwCR8Q3Yznt17H+20DA8XkrephHgZDWznosxIps
         6twPmxUPfQ+FodJVj7/+lUhNMDLnCAEwGKOajEeLZ8kghTXEzEHvcmt0dK2c6yfT8P+a
         +GZbr7cppQbB+XrDi0OgyBDYKzbgU2jFp6qcTi2Cgo+4tOyHT3yGgw7xOJ2rIiA5aUvE
         wNSLIhmq/uSTxeXLMSR5YfrSCTPIFUGyqYt7Lp4ehi7ORVTtA6+trNDmxWXQy41S+y5Y
         4rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705669238; x=1706274038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siajBaaFqK44x1k/dWoEneNkoHYdap1//tkVoA2vxzc=;
        b=cGS/6UPzcPmFY000CI5rvN60NsWPwX9YaUshcg7GGLCIrrCDu73nfTQvoSZedMUnGt
         lWxGHyaFwWVTDVONv89RfAYo/oSjO1ZNxnXIvRLjfInVf+R6jcFCERO7JPs2j1d5j2PZ
         49IgHVa7hMPqfOCX6vUFwlr9woiLPppXkHMw7pI6rWfZGKwmWce84/wkZ+GmOIezcLn3
         BPWBSxZi61Yo5+Nh3xNbPrB4LPbQODGzGIN29K3VHIKdGns7wnaz2/7UrCPJTL97v/ro
         PUdn8zsOqnsqV7YRieo6gy+/NlqUIrd9q3hYiEGzpAQizRk+cUiVx0SQx3d+n1DHPC/h
         GKwQ==
X-Gm-Message-State: AOJu0YxI7Jf8orwRG7hPN2SDJi/PIhkcPiJ+jaI59n95fBXAwUSpXZav
	0/NDofZPI7Lid9+B6teXoVMMCaw6a86adKLbKQzb876J2cd8C1scXvaDXoGUqVf7tGAvigIUup3
	aJXEdZbqqVI31Z/zpDe4R9/8nhms=
X-Google-Smtp-Source: AGHT+IEQ1BqWJ+lTrBmjsBDQf4pc86I2Zj/8lsICSt1zZdDCtTmggLXlX5TemcpbuMaFraoNhuIS+PQqLeRnofyL8eE=
X-Received: by 2002:a17:906:84f:b0:a28:fa55:3597 with SMTP id
 f15-20020a170906084f00b00a28fa553597mr1237981ejd.98.1705669238281; Fri, 19
 Jan 2024 05:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230803052238.12147-1-rauji.raut@gmail.com> <20230803052238.12147-2-rauji.raut@gmail.com>
 <f739cc15-dade-4f69-a17a-30242026c099@broadcom.com> <202401181217.1D75C32E@keescook>
In-Reply-To: <202401181217.1D75C32E@keescook>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Fri, 19 Jan 2024 14:00:26 +0100
Message-ID: <CAKXUXMzjGbO0U0pko1rg9=q3j6xS5rbzmLnMPeT3g9fMhBr0hw@mail.gmail.com>
Subject: Re: [PATCH v2] brcmfmac: replace one-element array with
 flexible-array member
To: Kees Cook <keescook@chromium.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, Atul Raut <rauji.raut@gmail.com>, 
	aspriel@gmail.com, franky.lin@broadcom.com, kvalo@kernel.org, 
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 9:20=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Jan 18, 2024 at 02:53:28PM +0100, Arend van Spriel wrote:
> > + Kees
> >
> > On 8/3/2023 7:22 AM, Atul Raut wrote:
> > > One-element arrays are obsolete, and flexible
> > > array members have taken their place. So, in
> > > struct cca_stats_n_flags, replace the one-element
> > > array with a flexible-array member.
> > >
> > > This fixes warnings such as:
> > > ./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:119:6-9=
: WARNING use flexible-array member instead (https://www.kernel.org/doc/htm=
l/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> >
> > I think this correct, but maybe Kees can give definitive answer here.
> >
> > > Signed-off-by: Atul Raut <rauji.raut@gmail.com>
> > > ---
> > >   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg8021=
1.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > > index de8a2e27f49c..fff32e54833d 100644
> > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > > @@ -116,7 +116,7 @@ struct brcmf_dump_survey {
> > >   struct cca_stats_n_flags {
> > >     u32 msrmnt_time; /* Time for Measurement (msec) */
> > >     u32 msrmnt_done; /* flag set when measurement complete */
> > > -   char buf[1];
> > > +   char buf[];
> > >   };
> > >   struct cca_msrmnt_query {
>
> Normally a [1] -> [] conversion needs some details in the commit log
> about why this is safe (since it runs the risk of changing sizeof(struct
> cca_stats_n_flags). In this case, there's only a single user of the
> struct, and nothing about its use depends on its size:
>
> #define BRCMF_DCMD_MEDLEN       1536
> ...
>         struct cca_stats_n_flags *results;
>         char *buf;
>         ...
>         buf =3D kzalloc(sizeof(char) * BRCMF_DCMD_MEDLEN, GFP_KERNEL);
>         ...
>         results =3D (struct cca_stats_n_flags *)(buf);
>         ...
>                 brcmf_parse_dump_obss(results->buf, survey);
>
> So, the allocation size is big enough for the struct, and nothing
> depends on the struct size.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>

As the linux-kernel-mentees mailing list is in CC, I assume that Atul
is a linux-kernel mentee. In that case, it is certainly reasonable and
at least of educational value for Atul to take Kees' explanation and
add this to the patch's commit message in his own words. Then, with
that, submit a PATCH v3.


Lukas

