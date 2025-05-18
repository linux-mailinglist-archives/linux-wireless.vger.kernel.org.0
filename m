Return-Path: <linux-wireless+bounces-23121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2F7ABB03F
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 14:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AC91898E38
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0CB218EB7;
	Sun, 18 May 2025 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="f+lhaUz+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2A35280;
	Sun, 18 May 2025 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747572216; cv=none; b=rfzGKn6aRvkVUVEa/QG9ysZyjmtVrPmhN/+zXmsc0YBZ+GEiomDyjCiriCIfjNkU2MO/IiJo+R4q84Qm2YLNj+eT3ZaPDT1wBLGrBRIs/C5q8jwF8gjwL5hP+xGWhBT/vsWwQ/QC+VX6zUb+GysGObgt47tjGJFAP1paPvw9auY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747572216; c=relaxed/simple;
	bh=7JUQ2UcIy6SQhXOyB8UQbTkc11cIPQDpMVMq+5ZYRf0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/KwmfQ3dq18KnB8vsQvinwbn8LAg586fUqMaH+tkKL2luxY04S4/9bV6+Qu3+iwUCCAgNiqEz7Kc5hTd1rSNZ+o2hr1T+fNYBioIAmwkzVp0tw3KmHjw5eAboYqWW+xuzsa5yaBXZRLXVvVJVYyWTmZddjf98793pHskfL6m4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=f+lhaUz+; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747572211; x=1748177011; i=spasswolf@web.de;
	bh=x2KnT8H6GISVhLU1V3XQF8JEkcuzVF2Lg4CkY+V2wG8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f+lhaUz+PoEiSUXRU7f5S5L13fpCyeyPaVCZEKCqY88mUPpu6kIDGi+pLVwNX1y5
	 3WUdhFTxFOptEPF2faF4ZDR5L8GFzUPzVSNJPMagpmv0+TeN6gR839juE9tythSbJ
	 HfL0IbliP5S44Rlm5OO8UznKjEBmJ/GoqwKSSdoQ9DxR76wAqQy8RcdyPa6UBCPGQ
	 C//imn3iabEFfpCyFffdIfqCQFQCNA0vdBJi48Ox1mt16L9JqaoT3sDxVhSkbrJDv
	 4tAiQuc303DV7Gj5BoqITmjGN/Enwgmsp82ds5IRSOFtAgIWS0tzop4oOq1ujs2DO
	 +NoEcnbhHm+Vxcbhng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjxeO-1uejla4Blw-00neN3; Sun, 18
 May 2025 14:43:31 +0200
Message-ID: <8274d78a82cded2fc4459fad8c2db6a1b51d7891.camel@web.de>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Bert Karwatzki <spasswolf@web.de>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "linux-next@vger.kernel.org"	 <linux-next@vger.kernel.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>,  Thomas Gleixner
 <tglx@linutronix.de>, linux-wireless@vger.kernel.org, spasswolf@web.de
Date: Sun, 18 May 2025 14:43:30 +0200
In-Reply-To: <4a893f88b6892502a5f7a61bcfc806a271a730a9.camel@web.de>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9HPoeT2yuKY2hHr9baIP5ubn6Hc3C1jfquoP1UHMGsCyAU5v24o
 UHsnJMSaB9JNMORJq6ymaYyfMDkZJZp1rk3lN8J3IPNuYFJY7QZS7ynZj7lI4eaP6LfY3sy
 xrWg+UdWt61PCqaycXYhOdwCOe8Na+qy+ZYKkpbOe9lufDAUU/BsB0LTjVm7We2OzryzwEo
 omv2zHoMvtqXobRfQtIxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2W4pB8mRyCs=;8RJWhMmk/RLYWtS4KyeMvxbzZfi
 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

Am Sonntag, dem 18.05.2025 um 14:12 +0200 schrieb Bert Karwatzki:
> > > >=20
>=20
> I even tried this version of your patch, to keep the offset of skc_refcn=
t at 128,
> but it doesn't  work, either.
>=20
> commit fca84c5cde713be480544a64ed6680afc3319670
> Author: Bert Karwatzki <spasswolf@web.de>
> Date:   Sun May 18 13:32:36 2025 +0200
>=20
>     include: net: sock: move skc_flags out of the union
>    =20
>     Signed-off-by: Bert Karwatzki <spasswolf@web.de>
>=20
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 3e15d7105ad2..e73929a4da6e 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -195,7 +195,6 @@ struct sock_common {
>  	 * for different kind of 'sockets'
>  	 */
>  	union {
> -		unsigned long	skc_flags;
>  		struct sock	*skc_listener; /* request_sock */
>  		struct inet_timewait_death_row *skc_tw_dr; /* inet_timewait_sock */
>  	};
> @@ -221,6 +220,9 @@ struct sock_common {
>  	};
> =20
>  	refcount_t		skc_refcnt;
> +
> +	/* place skc_flags here to keep offset(struct sock, sk_refcnt) =3D=3D =
128 */
> +	unsigned long	skc_flags;
>  	/* private: */
>  	int                     skc_dontcopy_end[0];
>  	union {
>=20

In the patch above I accidently put skc_flags in the part of struct sock_c=
ommon
which does not get copied, but putting it below skc_dontcopy_end[0] does n=
ot work,
either:

diff --git a/include/net/sock.h b/include/net/sock.h
index 3e15d7105ad2..6d69753a205a 100644
=2D-- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -195,7 +195,6 @@ struct sock_common {
         * for different kind of 'sockets'
         */
        union {
-               unsigned long   skc_flags;
                struct sock     *skc_listener; /* request_sock */
                struct inet_timewait_death_row *skc_tw_dr; /* inet_timewai=
t_sock */
        };
@@ -221,8 +220,12 @@ struct sock_common {
        };
=20
        refcount_t              skc_refcnt;
+
        /* private: */
        int                     skc_dontcopy_end[0];
+       /* place skc_flags here to keep offset(struct sock, sk_refcnt) =3D=
=3D 128=20
+        * Also place it below skc_dontcopy_end[0] */
+       unsigned long   skc_flags;
        union {
                u32             skc_rxhash;
                u32             skc_window_clamp;

This locks up as usual.

Bert Karwatzki

