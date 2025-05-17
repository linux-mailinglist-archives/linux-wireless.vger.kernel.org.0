Return-Path: <linux-wireless+bounces-23110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C31ABA9C2
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 13:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC14E17F018
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8917B1DE8B2;
	Sat, 17 May 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Ju/0/GQP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D830175A5;
	Sat, 17 May 2025 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747481999; cv=none; b=nVPMej7wT6j4LGL5VZ5tux7AWVx8hWSFIyuDgaatfKAqeSeh9NvDHQFL/TTlWNte3fCtss6TdsuNqFVdaSNO2ts9bdE22YMGK4dwPbpIVnyLa+3prrudQ0qO02n/j8/06bgLAHmdNFJEXkeQTfhWum8XmeE2DXFJvT9+2pPiL1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747481999; c=relaxed/simple;
	bh=x9WQu15a0CvTyQ8NsF9ruE7Lf/UN/ZhXRTmMwm/a6PY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AFBgFEaxSCjiREspKQ+TkaEKYXb0l7i76PnHF4CmHpZqnMzd8S6hlsZVuAn2obu7FGstryY50oYr/eDc44HLCxOhupUvvnOIecrmy4HbVNgE+qssPRBpWIDvpMUCvm5nCUYNs2iTs2rkgSrbdrvGKNZOHf9Yffua0PLjN8F0r3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Ju/0/GQP; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747481994; x=1748086794; i=spasswolf@web.de;
	bh=dadCyju+xeEXAIQZEjZo1Bn+Q8HMZfWwnjstkoQkIAE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ju/0/GQPdcZKlTWykEYMeKBopCyQe1heX//tlvqwM1TBs+B0g2eNP8vD1QbRjSpp
	 wRN50+ry0S+5AUq1T6V/yGsM47QhEeaTTNAz4SNJmt8FrWPNOh7sdKT9sehrnJXpk
	 66V+MlZaZbQ/PixLxztWhvCsHSZsNQxCGBuK/3eqazETAXtUHxcTu+/DOc74+9ZZ6
	 uWcqeFGqf1Yg+c51crkpBLbs0WoLGt7DZWJXWgxOToWmcCIKtzQXGnylB/AAbcrSY
	 u71A0e+PhDrXRdpi0Lr9fBznMwU8VeUqBBYnUCGS+FcdBLcNbTMVSx/miLIQI2jWN
	 XvvhpGmE8P0pLYe3HQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzaR-1ut9WT3pev-00ZRKw; Sat, 17
 May 2025 13:34:12 +0200
Message-ID: <388bbc4c805ce029bbd08010fd30405494f998a9.camel@web.de>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Bert Karwatzki <spasswolf@web.de>
To: Johannes Berg <johannes@sipsolutions.net>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, 
 "llvm@lists.linux.dev"
	 <llvm@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-wireless@vger.kernel.org, spasswolf@web.de
Date: Sat, 17 May 2025 13:34:11 +0200
In-Reply-To: <63cc1dbf07bde2c9d14e1f86ce2c2ce26a2a9936.camel@web.de>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FRNQgOtzobnROA3s8DGrFucmEyfVDKJjuc6RLbOVOfy7sPFxp/G
 7rLq/rpK50GzlZXa2J1tFEpdhnJ+qYCUtrNGLD5sUhbDv6P7Mx3kIF9zP1+z9xCAbzopePZ
 9ETT62spdHptQBQI6k5sFz3Yv7qlyOOVIUbAiSqINEcCmrHq01YbmOTir5+/ol1hZ71mAlv
 E3/as/pKvRSOZZDwx6omw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7S99yhmRzFw=;mvRHAxULsAeb+4kppsYuyjcoyd6
 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

Am Freitag, dem 16.05.2025 um 20:19 +0200 schrieb Bert Karwatzki:
> I've added a debugging statement:
>=20
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 3bd5ee0995fe..853493eca4f5 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -4586,7 +4586,11 @@ static noinline void ieee80211_8023_xmit_clang_de=
bug_helper(struct sk_buff *skb,
>                                                             struct ieee8=
0211_local *local,
>                                                             struct ieee8=
0211_tx_info *info)
>  {
> -       if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))) {
> +       if (unlikely(skb->sk && ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI=
_STATUS) ||
> +                               sock_flag(skb->sk, SOCK_WIFI_STATUS)))) =
{
> +               if ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ^ so=
ck_flag(skb->sk, SOCK_WIFI_STATUS))
> +                       printk(KERN_INFO "%s: skb_shinfo(skb)->tx_flags =
& SKBTX_WIFI_STATUS =3D %u sock_flag(skb->sk,
> SOCK_WIFI_STATUS) =3D %u\n",
> +                                       __func__, (skb_shinfo(skb)->tx_f=
lags & SKBTX_WIFI_STATUS), sock_flag(skb->sk,
> SOCK_WIFI_STATUS));
>                 info->status_data =3D ieee80211_store_ack_skb(local, skb=
,
>                                                             &info->flags=
, NULL);
>                 if (info->status_data)
>=20
> This gives the following logoutput (and a lockup), indicating that sock_=
flag(skb->sk, SOCK_WIFI_STATUS) and
> (skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) are actually NOT equival=
ent (when compiled with clang and
> PREEMPT_RT=3Dy)

I've added more debugging output:

diff --git a/include/net/sock.h b/include/net/sock.h
index e223102337c7..e13560b5b7a8 100644
=2D-- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2735,8 +2735,10 @@ static inline void _sock_tx_timestamp(struct sock *=
sk,
 				*tskey =3D atomic_inc_return(&sk->sk_tskey) - 1;
 		}
 	}
-	if (unlikely(sock_flag(sk, SOCK_WIFI_STATUS)))
+	if (unlikely(sock_flag(sk, SOCK_WIFI_STATUS))) {
+		printk(KERN_INFO "%s: setting SKBTX_WIFI_STATUS for sk =3D %px\n", __fu=
nc__, sk);
 		*tx_flags |=3D SKBTX_WIFI_STATUS;
+	}
 }
=20
 static inline void sock_tx_timestamp(struct sock *sk,
diff --git a/net/core/sock.c b/net/core/sock.c
index e02a78538e3e..f6589ad5ba36 100644
=2D-- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1548,6 +1548,7 @@ int sk_setsockopt(struct sock *sk, int level, int op=
tname,
 		break;
=20
 	case SO_WIFI_STATUS:
+		printk(KERN_INFO "%s: setting SOCK_WIFI_STATUS to %u for sk =3D %px\n",=
 __func__, valbool, sk);
 		sock_valbool_flag(sk, SOCK_WIFI_STATUS, valbool);
 		break;
=20
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 853493eca4f5..eee2f80949c6 100644
=2D-- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4588,9 +4588,12 @@ static noinline void ieee80211_8023_xmit_clang_debu=
g_helper(struct sk_buff *skb,
 {
 	if (unlikely(skb->sk && ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)=
 ||
 				sock_flag(skb->sk, SOCK_WIFI_STATUS)))) {
-		if ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ^ sock_flag(skb->sk=
, SOCK_WIFI_STATUS))
+		if ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ^ sock_flag(skb->sk=
, SOCK_WIFI_STATUS)) {
 			printk(KERN_INFO "%s: skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =
=3D %u sock_flag(skb->sk, SOCK_WIFI_STATUS) =3D %u\n",
 					__func__, (skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS), sock_flag=
(skb->sk, SOCK_WIFI_STATUS));
+			printk(KERN_INFO "%s: skb->sk =3D %px skb->sk->sk_flags =3D 0x%lx\n", =
__func__, skb->sk, skb->sk->sk_flags);
+			return; // This should make this case non-fatal.
+		}
 		info->status_data =3D ieee80211_store_ack_skb(local, skb,
 							    &info->flags, NULL);
 		if (info->status_data)



This gives after ~15min uptime

[  189.337797] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_shin=
fo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI_S=
TATUS) =3D 1
[  189.337803] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8c1b798c4e00 skb->sk->sk_flags =3D 0xffffffffb4efe640
[  191.325256] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_shin=
fo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI_S=
TATUS) =3D 1
[  191.325259] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8c1b798c5a00 skb->sk->sk_flags =3D 0xffffffffb4efe640
[  257.591831] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_shin=
fo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI_S=
TATUS) =3D 1
[  257.591844] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8c1baf3bca00 skb->sk->sk_flags =3D 0xffffffffb4efe640
[  301.786963] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_shin=
fo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI_S=
TATUS) =3D 1
[  301.786967] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8c1c1bc40100 skb->sk->sk_flags =3D 0xffffffffb4efe640
[  302.780881] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_shin=
fo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI_S=
TATUS) =3D 1
[  302.780884] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8c1a44cf6000 skb->sk->sk_flags =3D 0xffffffffb4efe640
[  482.792298] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_shin=
fo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI_S=
TATUS) =3D 1
[  482.792304] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8c1da0f4de00 skb->sk->sk_flags =3D 0xffffffffb4efe640
[  482.806144] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_shin=
fo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI_S=
TATUS) =3D 1
[  482.806148] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8c1da0f4c500 skb->sk->sk_flags =3D 0xffffffffb4efe640
[  482.817280] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_shin=
fo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI_S=
TATUS) =3D 1
[  482.817284] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8c1da0f4df00 skb->sk->sk_flags =3D 0xffffffffb4efe640
[  552.327291] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_shin=
fo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI_S=
TATUS) =3D 1
[  552.327295] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8c1da0f4de00 skb->sk->sk_flags =3D 0xffffffffb4efe640
[  916.971599] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_shin=
fo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI_S=
TATUS) =3D 1
[  916.971607] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->sk =
=3D ffff8c1a62834000 skb->sk->sk_flags =3D 0xffffffffb4efe640

The printk()s in sk_set_sockopt() and _sock_tx_timestamp() are not called =
at all so the flag=C2=A0
SOCK_WIFI_STATUS is actually nevers set! What is printed when printing skb=
->sk->sk_flags looks
suspiciously like a pointer, and as sk_flags is actually a member of a uni=
on in struct sock_common
it seems clang is using sk_flags for one of the other union members here

struct sock_common {
[...]
	union {
		unsigned long	skc_flags;
		struct sock	*skc_listener; /* request_sock */
		struct inet_timewait_death_row *skc_tw_dr; /* inet_timewait_sock */
	};
[...]
}

Bert Karwatzki

