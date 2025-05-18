Return-Path: <linux-wireless+bounces-23124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6262ABB08A
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 16:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21715176B2B
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 14:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1921CC58;
	Sun, 18 May 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="ZTM+cxGj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4A28F4;
	Sun, 18 May 2025 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747579341; cv=none; b=nhg/Wvx4YMCbWr2YV9Ysdxoecq3caIQH8cinlrTGBNBMZT3yjcaqUWrMibEwbTQd0GLnO6Yh/+QeuPmRRtGWsUZFTI9ywAbCsVHlLFkHnV6e8jdKoq6yGsipQWokXT02AdAq69rEjA987KNd5IqCo4rCSp/VotX4iJNbmKJqlq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747579341; c=relaxed/simple;
	bh=Ut8EwUqtPjQD4rmnuOMvHHrThOVEu5mZhLB2ZqBsAZA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IS1TI+aLXhi/MmglijMnm+UjznVvCrnBipwR/+W2bjKcGmw1Hjq5/q1eFZ30U5tnh5f15R2nZ1l/8vqlFc0cRD74hE8FBfp5FqPNNc0QNIECZzVpADowTHudDf5E5U7MkGZMGJvc6WglJvmXgKFFNkbPuvlllKhaquXh3AHPOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=ZTM+cxGj; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747579309; x=1748184109; i=spasswolf@web.de;
	bh=FzQ/xJlPO34OSpH1n5KOP67Kbs4N7Wsz9/T2Tugql2k=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZTM+cxGjJBjhgUugYZsyTTAVN6saqOZiPFwWPw6vtPCXQmFRrvVfJChq+LA8+Bv/
	 hu7hMxTYxFyUNejSU/45lTzpjcMqkKzebpl3JxNGZt66OrJCNbRddC8+Pj8TDDfoZ
	 e1K8VKBckcfNXrNRga+7tHlKLrU3jq4Ft5sA8eeeMYPKc/UxQwODlUx53JwCncXD/
	 5C+AAlQnmXsqEjcq5jpnt+0B6ZIQ1r1rtLAuYCVnqRdWtLJAECnpKSOAlaB+rUCHS
	 vxf7bUTXWp2gRuf9F+tuv8ArE4c8/dbxSVjrdaA60cikfh+mVEXEFB29HlvLWRHzf
	 bRnSXRtOBo3LApT9Zg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFauo-1uBg3f25wk-009NA3; Sun, 18
 May 2025 16:41:49 +0200
Message-ID: <f109986d1c25c794f7f6a470722f1ea878d10b33.camel@web.de>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Bert Karwatzki <spasswolf@web.de>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "linux-next@vger.kernel.org"	 <linux-next@vger.kernel.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>,  Thomas Gleixner
 <tglx@linutronix.de>, linux-wireless@vger.kernel.org, spasswolf@web.de
Date: Sun, 18 May 2025 16:41:48 +0200
In-Reply-To: <c343c12be42195aaeeb572ddc76ed41369904d79.camel@web.de>
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
	 <c343c12be42195aaeeb572ddc76ed41369904d79.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q+qjQzVHU4gEfmdIz04GoCanD6yX01GPxXHzWZfBCgvGParuaDm
 2f1xzC8P7ONxkAv5uqGxhqZJqjQ1H3HRdpEz6Ih3CPtktlpX0a7ipFL+/MNNDbrlywGGNhp
 fCZ1kfYWg9sbgyfeeEJsXRIxtel2QcYLBRz6XMxMeq5fHYamF40IHrPtBDfL7BI3wIeDvxJ
 fTXsVl6mRRB+Zp+DOoIOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3SSlWQ/INcA=;pyT2FlT6818JQaRS5o7zO2drY2X
 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

Am Sonntag, dem 18.05.2025 um 16:15 +0200 schrieb Bert Karwatzki:
> Am Sonntag, dem 18.05.2025 um 14:43 +0200 schrieb Bert Karwatzki:
> > Am Sonntag, dem 18.05.2025 um 14:12 +0200 schrieb Bert Karwatzki:
> > > > > >=20
> > >=20
> > > I even tried this version of your patch, to keep the offset of skc_r=
efcnt at 128,
> > > but it doesn't  work, either.
> > >=20
> > > commit fca84c5cde713be480544a64ed6680afc3319670
> > > Author: Bert Karwatzki <spasswolf@web.de>
> > > Date:   Sun May 18 13:32:36 2025 +0200
> > >=20
> > >     include: net: sock: move skc_flags out of the union
> > >    =20
> > >     Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > >=20
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 3e15d7105ad2..e73929a4da6e 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -195,7 +195,6 @@ struct sock_common {
> > >  	 * for different kind of 'sockets'
> > >  	 */
> > >  	union {
> > > -		unsigned long	skc_flags;
> > >  		struct sock	*skc_listener; /* request_sock */
> > >  		struct inet_timewait_death_row *skc_tw_dr; /* inet_timewait_sock =
*/
> > >  	};
> > > @@ -221,6 +220,9 @@ struct sock_common {
> > >  	};
> > > =20
> > >  	refcount_t		skc_refcnt;
> > > +
> > > +	/* place skc_flags here to keep offset(struct sock, sk_refcnt) =3D=
=3D 128 */
> > > +	unsigned long	skc_flags;
> > >  	/* private: */
> > >  	int                     skc_dontcopy_end[0];
> > >  	union {
> > >=20
> >=20
> > In the patch above I accidently put skc_flags in the part of struct so=
ck_common
> > which does not get copied, but putting it below skc_dontcopy_end[0] do=
es not work,
> > either:
> >=20
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 3e15d7105ad2..6d69753a205a 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -195,7 +195,6 @@ struct sock_common {
> >          * for different kind of 'sockets'
> >          */
> >         union {
> > -               unsigned long   skc_flags;
> >                 struct sock     *skc_listener; /* request_sock */
> >                 struct inet_timewait_death_row *skc_tw_dr; /* inet_tim=
ewait_sock */
> >         };
> > @@ -221,8 +220,12 @@ struct sock_common {
> >         };
> > =20
> >         refcount_t              skc_refcnt;
> > +
> >         /* private: */
> >         int                     skc_dontcopy_end[0];
> > +       /* place skc_flags here to keep offset(struct sock, sk_refcnt)=
 =3D=3D 128=20
> > +        * Also place it below skc_dontcopy_end[0] */
> > +       unsigned long   skc_flags;
> >         union {
> >                 u32             skc_rxhash;
> >                 u32             skc_window_clamp;
> >=20
> > This locks up as usual.
> >=20
> > Bert Karwatzki
>=20
> So I did some more monitoring and found that even though skc_flags is re=
moved from the union
> it can take strange values, e.g.:
>=20
> Here the value is not even a pointer (perhaps unitialized memory?):
> [  T572] ieee80211_8023_xmit_clang_debug_helper: skb->sk =3D ffff88fc2ab=
f4cc0 skb->sk->sk_flags =3D 0xa00f7fe57b16f7e1
> These could be pointers, but as pointers would only be aligned to a 2-by=
te boundary ...
> [  T572] ieee80211_8023_xmit_clang_debug_helper: skb->sk =3D ffff88fbd0b=
d3210 skb->sk->sk_flags =3D 0xffffc0f1c62dcc4e
> [  T572] ieee80211_8023_xmit_clang_debug_helper: skb->sk =3D ffff88fbd0b=
d3210 skb->sk->sk_flags =3D 0xffffc0f1c62dcc4e
>=20
> Bert Karwatzki

I tried to set sk_flags to 0 in sk_prot_alloc() like this:

commit 269f21266477e74321e32e0b022dda8e98785589 (HEAD -> clang_panic)
Author: Bert Karwatzki <spasswolf@web.de>
Date:   Sun May 18 16:28:39 2025 +0200

    net: core: sock: set initial sk_flags to 0 in sk_prot_alloc()
   =20
    Signed-off-by: Bert Karwatzki <spasswolf@web.de>

diff --git a/net/core/sock.c b/net/core/sock.c
index f6589ad5ba36..acaa39ad18be 100644
=2D-- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2216,6 +2216,7 @@ static struct sock *sk_prot_alloc(struct proto *prot=
, gfp_t priority,
                        goto out_free_sec;
        }
=20
+       sk->sk_flags =3D 0;
        return sk;
=20
 out_free_sec:

But that didn't work:
[   13.832282] [    T579] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8962805faee0 skb->sk->sk_flags =3D 0x4472000044f00000
[...]
[  124.165094] [    T579] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff896280760550 skb->sk->sk_flags =3D 0x726f2e65746f7571
[...]
[  185.138202] [    T579] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8960c78b7a90 skb->sk->sk_flags =3D 0x8000000000000025
[...]
[  290.623998] [    T579] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8961936b7870 skb->sk->sk_flags =3D 0xffff8961936b78f0

Bert Karwatzki

