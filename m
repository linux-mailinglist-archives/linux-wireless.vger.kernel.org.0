Return-Path: <linux-wireless+bounces-23122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D87ABB07D
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 16:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4923B6D39
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 14:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F0D1DFCB;
	Sun, 18 May 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="LbvN3XxN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9159117E0;
	Sun, 18 May 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747577727; cv=none; b=c5TXuuEBA+QeD/031PQTlV9QOqOeEr5ilaL0UnURXdNMI2zzKHRxGrme7ZcBfsZQL11RcLhSM0A0UaNzOpIAZcqTbY/ILMZr7Zl0XPdFAFoLgqxDof8lW9j3dBgP4+mV0aZCHUkLI/PW5TPGiNgX04HMmkQ6FdXHXixGDsopiiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747577727; c=relaxed/simple;
	bh=LflfMs4kZfyIaOpvYpEL7j7y/XFZTDR6tLznMnAA9TY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JXBO5wlYtYCkWka3fbOBv2HsTUflYF9yZqroLZ1hDMOjEZxDWCwHyvioImF2LSmb7QZkLJuBO2bPieT7ymiz1A4+BT+D9AczSKzyVAa45bem8ANox7KbhWGPe1Ri1yIq4O/GNNRdp+zIV2D2kJ+nvC7eLMGrvwTLpyN0alkIvZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=LbvN3XxN; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747577716; x=1748182516; i=spasswolf@web.de;
	bh=4P970Ww1wQlpjtEwgPCOhxGQejBo5QPYjplL6xeKDUE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LbvN3XxNWuFomoENwWHR91okJ+mdJqqQYT4LATaTiWGsdrEpSWQKLV8yvFrSODH8
	 T9pCRw5ZRVYRiCCGvhOTW9KMvatghBahay+Vdzu1IS05xlj981tOtM7gSNc+Ee3sC
	 9xlJdvcTZjP8ERyxTwgF6t0VGBuyYysRf/0Lpy4h01RKYgbqtb1T+pj6a9m4g9ael
	 iLLLuzMU8cmFoJyrxL894vadepkTCCKeBNm1elF9ibgjN9S1avWDgEPnemUQa10Ow
	 ghuAF0aHzz6oG5DaCLtmiZxrpfUGIrlcd5FiaHJpLgan1FYFla2EHe8BnfVrTVu4X
	 ZHxbQiAEEzfWcQOR5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MG994-1uB8TX489E-00HQKR; Sun, 18
 May 2025 16:15:16 +0200
Message-ID: <c343c12be42195aaeeb572ddc76ed41369904d79.camel@web.de>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Bert Karwatzki <spasswolf@web.de>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "linux-next@vger.kernel.org"	 <linux-next@vger.kernel.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>,  Thomas Gleixner
 <tglx@linutronix.de>, linux-wireless@vger.kernel.org, spasswolf@web.de
Date: Sun, 18 May 2025 16:15:15 +0200
In-Reply-To: <8274d78a82cded2fc4459fad8c2db6a1b51d7891.camel@web.de>
References: <20250513164807.51780-1-spasswolf@web.de> <87h61ojg3g.ffs@tglx>
						 <7471a185adcc34a79c2ab8ce1e87ab922ae2232b.camel@web.de>
						 <b644ff1714731cfb652d809d4864f0d178b24a97.camel@web.de>
						 <2d8c1929bf5ab5260dacf9aa390456b3b49ce465.camel@sipsolutions.net>
						 <2cad838b39f00d93319509d2a6a77a4c42c7fa92.camel@web.de>
						 <a12c82c394e9676e32ede6b8312f821a16fef94b.camel@sipsolutions.net>
						 <f8552d41fb7eae286803b78302390614179b33b0.camel@web.de>
						 <8684a2b4bf367e2e2a97e2b52356ffe5436a8270.camel@sipsolutions.net>
						 <ba97a2559cda1b14e0c9754523ff1152bdad90ef.camel@web.de>
						 <63cc1dbf07bde2c9d14e1f86ce2c2ce26a2a9936.camel@web.de>
						 <388bbc4c805ce029bbd08010fd30405494f998a9.camel@web.de>
						 <15f3633cbd08b30475d5b76c5cc9180fbf17a12f.camel@web.de>
						 <CAL+tcoA3d-EdoGjei7aeyuA3zmj955uYkXf1wCAUy8iP3BxUjg@mail.gmail.com>
		 <4a893f88b6892502a5f7a61bcfc806a271a730a9.camel@web.de>
	 <8274d78a82cded2fc4459fad8c2db6a1b51d7891.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6/W3o9/69jiBstG5IgTUm2bU/gHbBGkvmzm16uRePmKtn+e1ZKb
 kddw4SGPSx6JF4GkHC6mSSxXPFIq+Mk5EwsO3IqugNAekCr0JlpTfRvPMyOck+kl4pDpz8K
 BQb4VufsMDAIQCJ7afjMtwUwTqgi+H2g99KIVgK4LvSkCOPnKEz3xFMp0z0te55jcblgJH6
 b0zPzLsrEwaqY7hxsMycg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R74Ki1q73ak=;52YpObM764MIRXYye+oOYC0ocax
 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

Am Sonntag, dem 18.05.2025 um 14:43 +0200 schrieb Bert Karwatzki:
> Am Sonntag, dem 18.05.2025 um 14:12 +0200 schrieb Bert Karwatzki:
> > > > >=20
> >=20
> > I even tried this version of your patch, to keep the offset of skc_ref=
cnt at 128,
> > but it doesn't  work, either.
> >=20
> > commit fca84c5cde713be480544a64ed6680afc3319670
> > Author: Bert Karwatzki <spasswolf@web.de>
> > Date:   Sun May 18 13:32:36 2025 +0200
> >=20
> >     include: net: sock: move skc_flags out of the union
> >    =20
> >     Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> >=20
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 3e15d7105ad2..e73929a4da6e 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -195,7 +195,6 @@ struct sock_common {
> >  	 * for different kind of 'sockets'
> >  	 */
> >  	union {
> > -		unsigned long	skc_flags;
> >  		struct sock	*skc_listener; /* request_sock */
> >  		struct inet_timewait_death_row *skc_tw_dr; /* inet_timewait_sock */
> >  	};
> > @@ -221,6 +220,9 @@ struct sock_common {
> >  	};
> > =20
> >  	refcount_t		skc_refcnt;
> > +
> > +	/* place skc_flags here to keep offset(struct sock, sk_refcnt) =3D=
=3D 128 */
> > +	unsigned long	skc_flags;
> >  	/* private: */
> >  	int                     skc_dontcopy_end[0];
> >  	union {
> >=20
>=20
> In the patch above I accidently put skc_flags in the part of struct sock=
_common
> which does not get copied, but putting it below skc_dontcopy_end[0] does=
 not work,
> either:
>=20
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 3e15d7105ad2..6d69753a205a 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -195,7 +195,6 @@ struct sock_common {
>          * for different kind of 'sockets'
>          */
>         union {
> -               unsigned long   skc_flags;
>                 struct sock     *skc_listener; /* request_sock */
>                 struct inet_timewait_death_row *skc_tw_dr; /* inet_timew=
ait_sock */
>         };
> @@ -221,8 +220,12 @@ struct sock_common {
>         };
> =20
>         refcount_t              skc_refcnt;
> +
>         /* private: */
>         int                     skc_dontcopy_end[0];
> +       /* place skc_flags here to keep offset(struct sock, sk_refcnt) =
=3D=3D 128=20
> +        * Also place it below skc_dontcopy_end[0] */
> +       unsigned long   skc_flags;
>         union {
>                 u32             skc_rxhash;
>                 u32             skc_window_clamp;
>=20
> This locks up as usual.
>=20
> Bert Karwatzki

So I did some more monitoring and found that even though skc_flags is remo=
ved from the union
it can take strange values, e.g.:

Here the value is not even a pointer (perhaps unitialized memory?):
[  T572] ieee80211_8023_xmit_clang_debug_helper: skb->sk =3D ffff88fc2abf4=
cc0 skb->sk->sk_flags =3D 0xa00f7fe57b16f7e1
These could be pointers, but as pointers would only be aligned to a 2-byte=
 boundary ...
[  T572] ieee80211_8023_xmit_clang_debug_helper: skb->sk =3D ffff88fbd0bd3=
210 skb->sk->sk_flags =3D 0xffffc0f1c62dcc4e
[  T572] ieee80211_8023_xmit_clang_debug_helper: skb->sk =3D ffff88fbd0bd3=
210 skb->sk->sk_flags =3D 0xffffc0f1c62dcc4e

Bert Karwatzki


