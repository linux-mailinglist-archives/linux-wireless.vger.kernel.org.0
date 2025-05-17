Return-Path: <linux-wireless+bounces-23116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62964ABAC2B
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 21:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82757AE887
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AF11C6FE2;
	Sat, 17 May 2025 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="FF8gom7o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED417E4;
	Sat, 17 May 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747511388; cv=none; b=mzAGg9vMC7b+7u8C8L8roACXr01y/Q9CEzw+BnuR+M8CWTeyiMHmTEKBa8eoyMj2xjMWTu4zIzLi1MXA3Fn9ggmzF7tewrXc6Z+9opUF4ni66IYex+X1CjZHXKJVkr/xb/ErwZPL2Dh8pjhvmEToUD0D8Ox2fyR+UkUFg3vhr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747511388; c=relaxed/simple;
	bh=XQO6wQTeUm9Nlytzmcb0X/cJhPkMXeNSo25rIsazWEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YcmjM287vbb/mj+P6W00zaYo7IH4EQt29brANYCWjudgfkDaz38rG48KsC/5FLid/hDS8lES60MsZ202M61Uw+8Xfc8kl38QG/DOFcP3R4evFwlhTswqLPsFFL++Sblu9ME9bj6iPRnIHmcA7pyszfItfHaYSc++R4sla0dIleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=FF8gom7o; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747511365; x=1748116165; i=spasswolf@web.de;
	bh=Lb18E4a+wHns7EolImEwuBScFMtE4Yi7mU7s8xVLWww=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FF8gom7o1qh7VAmXnj5AFqhQGd5dmTz6liwMmKyzcGhJZO5XZQw4xbai0mCox98Y
	 bxNlCgLFo0okC1XINO3FG4HHcbELNdHV2EtaVPLvfJazfoUgBRZmITu38VHTQ4IBQ
	 K0sZybPYr2qgMOwYNoGgYvi1PNmbSZTJG5tqJmn82+9c6Dt1yHXF7xPTYZyG6lS6E
	 XtyBMrPiUBeh0KxX1GbZ0XlvLcJTVVRiM8kjfUzfDHXz3y7s+ui9ptQZYjSRqYtVa
	 Bmz1WCdPID4gAyXVRekypaOc5kscX9Ey6jpgEYZB7Av7zlFpuPx9fA5QjECN1Pife
	 c+50qol7ktuFd5n0cQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqqPN-1ulIaC2mKf-00fNVk; Sat, 17
 May 2025 21:49:25 +0200
Message-ID: <15f3633cbd08b30475d5b76c5cc9180fbf17a12f.camel@web.de>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Bert Karwatzki <spasswolf@web.de>
To: Johannes Berg <johannes@sipsolutions.net>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, 
 "llvm@lists.linux.dev"
	 <llvm@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-wireless@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>, 
	spasswolf@web.de
Date: Sat, 17 May 2025 21:49:24 +0200
In-Reply-To: <388bbc4c805ce029bbd08010fd30405494f998a9.camel@web.de>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bt1lOAv4WI5hqOQFiWb3ZC+bVp8gF2UaYVCHfz2fzBXt7i/Ohea
 vYObJ/ByVi7U9KEBFF+fzCJb5ce4bw6B1MZi0t5l1hLSNyqoMcQxwpD7InALo1fg1zA07+T
 LbToAZ664Xs2gMZx7au8pyDxA03TVIBvpKdjgWUOWKoBjNdqkozGhQReBdhtVUBoykkU222
 kx9eUINYIXz6kk/f7C0dw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SwbBK1cvTd0=;v0aqcMWx0B8dsC9qBH78chfqcEA
 tRLJaYBXiGStsti1iDV/8q/M2ZwJoRTejeCVMFpcyb1vTJWvb93csJ7boSqu+CMLD8KPbKHb4
 pCe+itgvcFMwE6Rq0qnNDR/6Eq9iL8IaUTIHtI6b1eTnWbwbgYnQyc4siZRzGuZw4Alj8fbvA
 lXfB9EN37u/zlNPSxdy8T5Oy8XWq9qONHlYzQllY0vH3ftx5ORJOtb1Vbt0yomDWYpzcu2FWC
 RKXWxgOiOQror+iG2BLHASq3iU+TzKB4rtIfXVVLH3pZlWHDzz7vh7vtq6gq5Mvpt72qgFw/v
 8hSUBBj11uhW/3LQnI6PR9FMPSd2la6JwW/t9wXo86r71OYZVoLG6EbyqfwdtFLiwcx93vRSj
 UCs+K70CGVYlsGa9XxMAfT16Uw/v2FpGrefBn95b3T2hZjlQGqnX73Z1XWFTyjPEoM19nZyoT
 BaVwbJSjjoWEqtyrZOvfD7HepP6IT/n7OhcOE1ywxkIkOI5F5kvjYccsi3gTgBrrH2yDT9Vfd
 14aLj4jrU3w1t4zMDWRMB57UCSzZar0//Ejmw/T66kxMQbRWPH8QnoxvJxR2tEbgP1RRocLaL
 48ng1f8dV+uD0F9rn0Hl2EtQgJPbLpEOQjth8+BneXBg8SyOQrfJgCXwFpwaaait876scDMYJ
 LOzyLXi0fKKQXq0Ns/vQKHNp3hcqkMJi3IjS2aIcUlJeT0d4BXLatRNbIwFYz6GRuJBSfNUVW
 rTOP3IC8pqMxrYlMIB0FVrWVx3vFoZ+3/a+E0QaDNdAE520IRejQf4HTpach4s4OnxB9TT/g+
 lHGDrrwz+E86shfX6eKPLY6JKNd9gXMjQyzbOgFMrwg6AcUWOq7zW5QI3ExNNDo8AdKe4ZtiO
 ymEEozIU2XqJXv9wAN81JVTtG1gZ6nfof4XbBleizIwwUlMgVIT+81Pyi4k28ilA0jeL2z8/t
 PYd39PD95hsI2xO19R/b8RqW9BS64krHAQJ5wbsy48G+tn5GexAQRyJHcmBYMGMIBHiMJL1CW
 TkxCf3a3nNIMcFyH7od3BVPeN4/zNzD/SOZfPwFV+694eCEH6D7swLOTNHtCAfqBDCB5F0WAi
 pMVnyhL80KIVfZYJji9ahCd0BHBbfJzDlywr/LdpZjEhiYa6l56Z51fZBX7O+8c0nJBod6QD3
 O4omJv9Q00wWJlrs1GpCadHrSfUXVB16MlScI/l0mtJJCXpHqSG5+w5mBuI6dbD3VrWHx+nWj
 Uej5eoy3Io/zQ2PNwNUgGFgpHD6QaENrUsp8HxqqbVlaI6COE5sC4beNhfpUtyJpurNhK4vai
 rA4bAT9O9w5iu2ubAu9VSjo16Ufmu45btVg+VwtcL7ycw+PySQ5rio/4AQTzz5dfqZ8PMCRDa
 hkY+MRD6hPk63N3rANsvi9WYrxDN/xziez3Zpdzoo9vQIwcF10p6BY8yH+CljkTM35WGgBe1a
 PQBk9EKYwgUoK8p1v8LpADKVZwKs1WZqJrAgrBfTyAejCd6OYDfNVIis878c6NQMnoS1GWwoX
 jL1GR6judiO8r3RX+XBB9GKQ7DugnACvmJOAVCzmlSBX5A3FOHA5t0WehsCpJUHicmHx0jJND
 Akfuyz4XnBJmUINyuP91ttaqZoh0SGDSIIRXBJ8ghTgAdPNN6zQOgAr6BApn7v5ZTbR4zfsUG
 U4e1TXpc19YaI/QuE7/V9EDNuRMWNAF8oOVdPUB7DYE+h1VM8qcJBhTWmQB16xbpLwdXfZRhm
 e7aCWQBDvCj3pAd+IM3jcW8fSqONlTAMAx1xR5XTeV0lJJ/jmbl8Uw0mH1M9tMVnFsjL1AAEW
 JHz4L/xl69WyJhZR4TDZWypShr/kck2DztW+lxrRXWXFBMVw9fmXx1bVpuTTIrmNoAAjA/inA
 ibU6VOtbSwfI9HrUzR4J0dEdHTN5LRuUVTHI1MsiJJbIyqWJaCTvrrGdO3d+Op4PEfYRhsTT2
 7Gue6Xko3ICMJeO3DTNfHxFiUHfOkU2mrJ6ZO7oYlkTAj8TaxUhLYO2H5OLfk0BKtFGRQbroB
 RHcvV2XsjRqgx+IwLp1m94LKvMuVjbvgyLNUk0GtlR3z7aNw2lKKAC+cYYwUCxL64y8Sc7vN9
 o/wNYIasYkOzsjzMPKGJQugGhOAB/xO2HuTrPQ74Ns8nm5vvHZM/D7qnRoVpnK7Kgw9PmD9Cl
 AVBw//omdWd0VA+vS+1oK+J83LzEOMi6QRBnFCaCqZEAjn2v13J6JXgf5g3A1mCMCu96H4mO3
 HypwAZqfHuKSziE25Pd15lt2tvxXECtO6pQRtuQNaKNN3B9OCJIT4iFpJNivm/aB/kiak0Tp7
 g9/LGc1kaJBwaEYKAd2FROwdCWHFcoA3hNCDPW0ps0vHLFYvZ+0Mj0ykfqKvusO36kaxHWUV8
 msApphYDOogXy71S/I0BLa/CtIT2i4wKUBB9yQZ/EMcrhdvs65ngKc5kWY4GtGVjESgDsXnw2
 1dOCYFq5vGvBd0k+z5wDjBHUWWd+KRjvc1l6T15fK65Xi5hpDLgeHvtQOugpyMA74hiuqwte3
 l21zmCG2V9Uo/hgJph7kYkDtsaITbmGe9J0nw+pBjROJCnJ+NTh3nmzIF1vlqAlfu9+ru40CR
 UIasvDD34Ce3+qVfvUGPOOvbIII3++SYmLEDV8dAzcx9NT5byH6mfRU9WjxUegO50QJppXdSv
 uGb/VP51IKlivhcs94WqrCCyc8K71cZOJrQ3XyOVT9aw7vpyLvL7Cu0jhJyF2DRuD84cxJQPV
 8PHk9zgxHyXrE2/X25frf+WTbkY1CLxnYkJwPx2ny4RuzAK3uYWYIAJTkk9z1Z6B7r1XZOq8j
 TM8YHFzY+mlyOXDaxfWYPe7fRcaAK40+vxpHHs+LGRpVHjYedMbnC9WkH8BaacVDCh2pJwRQG
 VKuG7UJQiv1CZYIC+hexa0DGvBHXzz/GqUkqEHgW5MI2aL/K/Xf3wn3FWDyhuRh50nbWldxtT
 qylaQCjua3AofBdrLAwdtzIBf5gAXL04q5mjBEMl93EYrC/DY9y2msodAwPnbKb3yCXOH6ejm
 dzAF+VZ5moBtqZU0h+wxLLIoI9TEaGlbeZldfYANSe4

Am Samstag, dem 17.05.2025 um 13:34 +0200 schrieb Bert Karwatzki:
> Am Freitag, dem 16.05.2025 um 20:19 +0200 schrieb Bert Karwatzki:
> > I've added a debugging statement:
> >=20
> > diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> > index 3bd5ee0995fe..853493eca4f5 100644
> > --- a/net/mac80211/tx.c
> > +++ b/net/mac80211/tx.c
> > @@ -4586,7 +4586,11 @@ static noinline void ieee80211_8023_xmit_clang_=
debug_helper(struct sk_buff *skb,
> >                                                             struct iee=
e80211_local *local,
> >                                                             struct iee=
e80211_tx_info *info)
> >  {
> > -       if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS)))=
 {
> > +       if (unlikely(skb->sk && ((skb_shinfo(skb)->tx_flags & SKBTX_WI=
FI_STATUS) ||
> > +                               sock_flag(skb->sk, SOCK_WIFI_STATUS)))=
) {
> > +               if ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ^ =
sock_flag(skb->sk, SOCK_WIFI_STATUS))
> > +                       printk(KERN_INFO "%s: skb_shinfo(skb)->tx_flag=
s & SKBTX_WIFI_STATUS =3D %u sock_flag(skb->sk,
> > SOCK_WIFI_STATUS) =3D %u\n",
> > +                                       __func__, (skb_shinfo(skb)->tx=
_flags & SKBTX_WIFI_STATUS), sock_flag(skb->sk,
> > SOCK_WIFI_STATUS));
> >                 info->status_data =3D ieee80211_store_ack_skb(local, s=
kb,
> >                                                             &info->fla=
gs, NULL);
> >                 if (info->status_data)
> >=20
> > This gives the following logoutput (and a lockup), indicating that soc=
k_flag(skb->sk, SOCK_WIFI_STATUS) and
> > (skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) are actually NOT equiv=
alent (when compiled with clang and
> > PREEMPT_RT=3Dy)
>=20
> I've added more debugging output:
>=20
> diff --git a/include/net/sock.h b/include/net/sock.h
> index e223102337c7..e13560b5b7a8 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2735,8 +2735,10 @@ static inline void _sock_tx_timestamp(struct sock=
 *sk,
>  				*tskey =3D atomic_inc_return(&sk->sk_tskey) - 1;
>  		}
>  	}
> -	if (unlikely(sock_flag(sk, SOCK_WIFI_STATUS)))
> +	if (unlikely(sock_flag(sk, SOCK_WIFI_STATUS))) {
> +		printk(KERN_INFO "%s: setting SKBTX_WIFI_STATUS for sk =3D %px\n", __=
func__, sk);
>  		*tx_flags |=3D SKBTX_WIFI_STATUS;
> +	}
>  }
> =20
>  static inline void sock_tx_timestamp(struct sock *sk,
> diff --git a/net/core/sock.c b/net/core/sock.c
> index e02a78538e3e..f6589ad5ba36 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1548,6 +1548,7 @@ int sk_setsockopt(struct sock *sk, int level, int =
optname,
>  		break;
> =20
>  	case SO_WIFI_STATUS:
> +		printk(KERN_INFO "%s: setting SOCK_WIFI_STATUS to %u for sk =3D %px\n=
", __func__, valbool, sk);
>  		sock_valbool_flag(sk, SOCK_WIFI_STATUS, valbool);
>  		break;
> =20
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 853493eca4f5..eee2f80949c6 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -4588,9 +4588,12 @@ static noinline void ieee80211_8023_xmit_clang_de=
bug_helper(struct sk_buff *skb,
>  {
>  	if (unlikely(skb->sk && ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATU=
S) ||
>  				sock_flag(skb->sk, SOCK_WIFI_STATUS)))) {
> -		if ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ^ sock_flag(skb->=
sk, SOCK_WIFI_STATUS))
> +		if ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ^ sock_flag(skb->=
sk, SOCK_WIFI_STATUS)) {
>  			printk(KERN_INFO "%s: skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =
=3D %u sock_flag(skb->sk, SOCK_WIFI_STATUS) =3D %u\n",
>  					__func__, (skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS), sock_fl=
ag(skb->sk, SOCK_WIFI_STATUS));
> +			printk(KERN_INFO "%s: skb->sk =3D %px skb->sk->sk_flags =3D 0x%lx\n"=
, __func__, skb->sk, skb->sk->sk_flags);
> +			return; // This should make this case non-fatal.
> +		}
>  		info->status_data =3D ieee80211_store_ack_skb(local, skb,
>  							    &info->flags, NULL);
>  		if (info->status_data)
>=20
>=20
>=20
> This gives after ~15min uptime
>=20
> [  189.337797] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_sh=
info(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI=
_STATUS) =3D 1
> [  189.337803] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->s=
k =3D ffff8c1b798c4e00 skb->sk->sk_flags =3D 0xffffffffb4efe640
> [  191.325256] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_sh=
info(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI=
_STATUS) =3D 1
> [  191.325259] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->s=
k =3D ffff8c1b798c5a00 skb->sk->sk_flags =3D 0xffffffffb4efe640
> [  257.591831] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_sh=
info(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI=
_STATUS) =3D 1
> [  257.591844] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->s=
k =3D ffff8c1baf3bca00 skb->sk->sk_flags =3D 0xffffffffb4efe640
> [  301.786963] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_sh=
info(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI=
_STATUS) =3D 1
> [  301.786967] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->s=
k =3D ffff8c1c1bc40100 skb->sk->sk_flags =3D 0xffffffffb4efe640
> [  302.780881] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_sh=
info(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI=
_STATUS) =3D 1
> [  302.780884] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->s=
k =3D ffff8c1a44cf6000 skb->sk->sk_flags =3D 0xffffffffb4efe640
> [  482.792298] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_sh=
info(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI=
_STATUS) =3D 1
> [  482.792304] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->s=
k =3D ffff8c1da0f4de00 skb->sk->sk_flags =3D 0xffffffffb4efe640
> [  482.806144] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_sh=
info(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI=
_STATUS) =3D 1
> [  482.806148] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->s=
k =3D ffff8c1da0f4c500 skb->sk->sk_flags =3D 0xffffffffb4efe640
> [  482.817280] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_sh=
info(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI=
_STATUS) =3D 1
> [  482.817284] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->s=
k =3D ffff8c1da0f4df00 skb->sk->sk_flags =3D 0xffffffffb4efe640
> [  552.327291] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_sh=
info(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI=
_STATUS) =3D 1
> [  552.327295] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->s=
k =3D ffff8c1da0f4de00 skb->sk->sk_flags =3D 0xffffffffb4efe640
> [  916.971599] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb_sh=
info(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI=
_STATUS) =3D 1
> [  916.971607] [    T576] ieee80211_8023_xmit_clang_debug_helper: skb->s=
k =3D ffff8c1a62834000 skb->sk->sk_flags =3D 0xffffffffb4efe640
>=20
> The printk()s in sk_set_sockopt() and _sock_tx_timestamp() are not calle=
d at all so the flag=C2=A0
> SOCK_WIFI_STATUS is actually nevers set! What is printed when printing s=
kb->sk->sk_flags looks
> suspiciously like a pointer, and as sk_flags is actually a member of a u=
nion in struct sock_common
> it seems clang is using sk_flags for one of the other union members here
>=20
> struct sock_common {
> [...]
> 	union {
> 		unsigned long	skc_flags;
> 		struct sock	*skc_listener; /* request_sock */
> 		struct inet_timewait_death_row *skc_tw_dr; /* inet_timewait_sock */
> 	};
> [...]
> }
>=20
> Bert Karwatzki

I added even more debugging output and found out why commit 76a853f86c97 (=
" wifi: free=C2=A0
SKBTX_WIFI_STATUS skb tx_flags flag") does not work.

diff --git a/include/net/sock.h b/include/net/sock.h
index e13560b5b7a8..6e1291d2e5a1 100644
=2D-- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2738,6 +2738,8 @@ static inline void _sock_tx_timestamp(struct sock *s=
k,
 	if (unlikely(sock_flag(sk, SOCK_WIFI_STATUS))) {
 		printk(KERN_INFO "%s: setting SKBTX_WIFI_STATUS for sk =3D %px\n", __fu=
nc__, sk);
 		*tx_flags |=3D SKBTX_WIFI_STATUS;
+	} else {
+		printk(KERN_INFO "%s: NOT setting SKBTX_WIFI_STATUS for sk =3D %px\n", =
__func__, sk);
 	}
 }
=20
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_so=
ck.c
index 20915895bdaa..4913b09c0617 100644
=2D-- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -912,6 +912,7 @@ reqsk_alloc_noprof(const struct request_sock_ops *ops,=
 struct sock *sk_listener,
 			return NULL;
 		}
 		req->rsk_listener =3D sk_listener;
+		printk(KERN_INFO "%s: sk_listener =3D %px\n", __func__, sk_listener);
 	}
 	req->rsk_ops =3D ops;
 	req_to_sk(req)->sk_prot =3D sk_listener->sk_prot;
@@ -986,6 +987,7 @@ static struct request_sock *inet_reqsk_clone(struct re=
quest_sock *req,
 	nreq_sk->sk_incoming_cpu =3D req_sk->sk_incoming_cpu;
=20
 	nreq->rsk_listener =3D sk;
+	printk(KERN_INFO "%s: rsk_listener =3D%px\n", __func__, sk);
=20
 	/* We need not acquire fastopenq->lock
 	 * because the child socket is locked in inet_csk_listen_stop().
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 67efe9501581..1a3108ec7503 100644
=2D-- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -190,6 +190,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struc=
t sock *sk,
 		const struct inet_sock *inet =3D inet_sk(sk);
=20
 		tw->tw_dr	    =3D dr;
+		printk(KERN_INFO "%s: sk =3D %px tw_dr =3D %px\n", __func__, sk, dr);
 		/* Give us an identity. */
 		tw->tw_daddr	    =3D inet->inet_daddr;
 		tw->tw_rcv_saddr    =3D inet->inet_rcv_saddr;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index eee2f80949c6..227b86427e06 100644
=2D-- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4586,6 +4586,8 @@ static noinline void ieee80211_8023_xmit_clang_debug=
_helper(struct sk_buff *skb,
 							    struct ieee80211_local *local,
 							    struct ieee80211_tx_info *info)
 {
+	if (skb->sk)
+		printk(KERN_INFO "%s: skb->sk =3D %px skb->sk->sk_flags =3D 0x%lx\n", _=
_func__, skb->sk, skb->sk->sk_flags);
 	if (unlikely(skb->sk && ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)=
 ||
 				sock_flag(skb->sk, SOCK_WIFI_STATUS)))) {
 		if ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ^ sock_flag(skb->sk=
, SOCK_WIFI_STATUS)) {


This monitor the value of skb->sk->sk_flags not only in the error case but=
 in all cases, and also monitors
the places where the other members of the sk_flags union are set. The erro=
r occurs when at the start
of ieee80211_8023_xmit_clang_debug_helper() sk_flags is not actually the s=
kc_flags member of the union
but insted is skc_tw_dr which is only interpreted is flags.
 So why does it work with gcc but fail with clang? sock_flag(skb->sk, SOCK=
_WIFI_STATUS) test bit 19 of=C2=A0
skb->sk->sk_flags=C2=A0

Here are the important snippets of debug output:

clang:
[  T575] ieee80211_8023_xmit_clang_debug_helper: skb->sk =3D ffff8f1bebba4=
300 skb->sk->sk_flags =3D 0xffffffffa16fe640

Here test_bit(0xffffffffa16fe640, SOCK_WIFI_STATUS) is 1.

gcc:
[  T600] ieee80211_8023_xmit_clang_debug_helper: skb->sk =3D ffff8d3506bec=
700 skb->sk->sk_flags =3D 0xffffffff93d40100
Here test_bit(0xffffffff93d40100, SOCK_WIFI_STATUS) is 0.

So that this works with gcc just seems like luck. I've not yet test why it=
 works with clang when PREEMPT_RT is not
enabled but my guess is that in that case we have a tw_dr pointer which fa=
ils the test_bit().

Bert Karwatzki








