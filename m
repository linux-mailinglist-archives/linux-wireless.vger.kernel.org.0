Return-Path: <linux-wireless+bounces-22939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C30AB6D1C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04ABC188BB16
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7317E18BB8E;
	Wed, 14 May 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="tz44HVin"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52122615;
	Wed, 14 May 2025 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230403; cv=none; b=HZ5oP7SkEmfzcXDjxr5mmWw+/8pCOgmAzbrW6VEtV6yZhN0SR3vXb4AzWv6WHbGUEv/KjVlf9sYSHvDEdYJ218hkPqMgyOt48qTcsQD9cR9DAga2ocO9/cQWcnbXkj5Q0jJJRB8X27+ofsU42vvjezO4TZTYzdsnorUrNNINVGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230403; c=relaxed/simple;
	bh=rK8crzKNsT9l/5ZEsMIGnF+i2H4Z59zJPO5cKuaMaIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=btSqxQC9MvlCtxaXc8G7OXB847hH3TXebPU6d5j+I4D8R8XXo3TB4k1qYoOztmcY/yi2lBa89i2FU4WY30vz4nBqW0E48nXApQH9+nt5tKFCzHzH3rz2JZoQCMCAJ2avUplTW7xO7SKjeo6vAHPAOeNyyQNX45iRoCU9AT2YPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=tz44HVin; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747230377; x=1747835177; i=spasswolf@web.de;
	bh=+TQ+F6UqZ2YyIp8s6fLPHLaOot28CRqH0fegWBi2AcU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tz44HVinuJs8Y0QCguGTcvOE6R4NTA1Um5IgeTSe2IbclTbby/seD4xFTQIF/UPF
	 +gJVWxQBCBQnHKWT7aNMZtHQAKawEt0ECtvSWQleOJZ7NjRIiwEPRSg1XxUYkWSod
	 fBM1LjE2mKPOIh0WbKJqi9o4Bcjvfb7B3AHdV5qFeMc1hmG3Nxx9fT90cY8dMbG3K
	 GrlDsYQdyyZ1qzPPnfjzoH+HxOkHCoZi4+VWplVejhpvEhiDdQtGHMKaq3zg2TKkm
	 9fTXyTUxZ0/EfF68iilZPxFiOrzIK6YUH+y19th78D95cEeKnn3omYclL/TEaxSBy
	 Py5ZAVMsyL/8XpVR0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3oz4-1uxA6a2ooC-017frE; Wed, 14
 May 2025 15:46:16 +0200
Message-ID: <2cad838b39f00d93319509d2a6a77a4c42c7fa92.camel@web.de>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Bert Karwatzki <spasswolf@web.de>
To: Johannes Berg <johannes@sipsolutions.net>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, 
 "llvm@lists.linux.dev"
	 <llvm@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-wireless@vger.kernel.org, spasswolf@web.de
Date: Wed, 14 May 2025 15:46:15 +0200
In-Reply-To: <2d8c1929bf5ab5260dacf9aa390456b3b49ce465.camel@sipsolutions.net>
References: <20250513164807.51780-1-spasswolf@web.de> <87h61ojg3g.ffs@tglx>
			 <7471a185adcc34a79c2ab8ce1e87ab922ae2232b.camel@web.de>
		 <b644ff1714731cfb652d809d4864f0d178b24a97.camel@web.de>
	 <2d8c1929bf5ab5260dacf9aa390456b3b49ce465.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4L5PY97agYt03K0vBnhFzdRDh8ErKa43ybp1GTTY66Ule2AeLa2
 0jHVEqUH4dVxJMQSaL+tWSYe/PWJ+iHibjgVqe3o97BbGfjT29rRPJb0UtCqB6OQzAZHPSj
 OZQ2TmjXkXcczcW1F8Peor0XT08y5x1D/Tmx0kCI8nlJaJF6WgYIH258twbcPQtBDNnWJ1l
 XjByS6l3XDp+MmLNrDoLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IkS5GNLRGpw=;DEAgzj28aTuoYCOarQcylnT0Vt+
 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

Am Mittwoch, dem 14.05.2025 um 12:23 +0200 schrieb Johannes Berg:
> + linux-wireless
>=20
> On Wed, 2025-05-14 at 09:32 +0000, Bert Karwatzki wrote:
>=20
> > Then I reapplied commit 76a853f86c97 hunk by hunk and found the one hu=
nk that
> > causes the problem:
> >=20
> > diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> > index 3e751dd3ae7b..63df21228029 100644
> > --- a/net/mac80211/tx.c
> > +++ b/net/mac80211/tx.c
> > @@ -4648,8 +4648,7 @@ static void ieee80211_8023_xmit(struct
> > ieee80211_sub_if_data *sdata,
> >                         memcpy(IEEE80211_SKB_CB(seg), info, sizeof(*in=
fo));
> >         }
> >=20
> > -       if (unlikely(skb->sk &&
> > -                    skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
> > +       if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS)))=
 {
> >                 info->status_data =3D ieee80211_store_ack_skb(local, s=
kb,
> >                                                             &info->fla=
gs, NULL);
> >                 if (info->status_data)
>=20
> I think it crashed later on the status, but this inserts the skb into
> the IDR so the status can pick it up to return the status and afaict
> _that's_ where it crashed.
>=20
> Still I don't really know what could go wrong? The (copied) skb should
> still have been keeping the socket alive.
>=20
> > This is enough to cause a kernel panic when compiled with clang (clang=
-19.1.7
> > from debian sid). Compiling the same kernel with gcc (gcc-14.2.0 from =
debian
> > sid) shows no problem.
>=20
> Right, even stranger. But I can't even say you should look at this place
> (which inserts) or the other (which takes it out again and crashed) to
> compare the code :-/
>=20
>=20
> johannes

I've split off the problematic piece of code into an noinline function to =
simplify the disassembly:

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 20de6e6b0929..075e012d9992 100644
=2D-- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4582,7 +4582,19 @@ static bool ieee80211_tx_8023(struct ieee80211_sub_=
if_data *sdata,
 	return ret;
 }
=20
-static noinline void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sd=
ata,
+static noinline void ieee80211_8023_xmit_clang_debug_helper(struct sk_buf=
f *skb,
+							    struct ieee80211_local *local,
+							    struct ieee80211_tx_info *info)
+{
+	if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))) {
+		info->status_data =3D ieee80211_store_ack_skb(local, skb,
+							    &info->flags, NULL);
+		if (info->status_data)
+			info->status_data_idr =3D 1;
+	}
+}
+
+static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 				struct net_device *dev, struct sta_info *sta,
 				struct ieee80211_key *key, struct sk_buff *skb)
 {
@@ -4648,12 +4660,7 @@ static noinline void ieee80211_8023_xmit(struct iee=
e80211_sub_if_data *sdata,
 			memcpy(IEEE80211_SKB_CB(seg), info, sizeof(*info));
 	}
=20
-	if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))) {
-		info->status_data =3D ieee80211_store_ack_skb(local, skb,
-							    &info->flags, NULL);
-		if (info->status_data)
-			info->status_data_idr =3D 1;
-	}
+	ieee80211_8023_xmit_clang_debug_helper(skb, local, info);
=20
 	dev_sw_netstats_tx_add(dev, skbs, len);
 	sta->deflink.tx_stats.packets[queue] +=3D skbs;

This shows the the behaviour as the old code, i.e. kernel panic when compi=
led with clang(-19.1.7), no problem when
compiled with gcc(-14.2.0).

When compiled with clang the disassembly of the function is (from objdump =
-d)

000000000000a260 <ieee80211_8023_xmit_clang_debug_helper>:
    a260:	48 8b 47 18          	mov    0x18(%rdi),%rax
    a264:	48 85 c0             	test   %rax,%rax
    a267:	74 0c                	je     a275 <ieee80211_8023_xmit_clang_deb=
ug_helper+0x15>
    a269:	53                   	push   %rbx
    a26a:	48 f7 40 60 00 00 08 	testq  $0x80000,0x60(%rax)
    a271:	00=20
    a272:	75 07                	jne    a27b <ieee80211_8023_xmit_clang_deb=
ug_helper+0x1b>
    a274:	5b                   	pop    %rbx
    a275:	2e e9 00 00 00 00    	cs jmp a27b <ieee80211_8023_xmit_clang_deb=
ug_helper+0x1b>
    a27b:	48 89 f8             	mov    %rdi,%rax
    a27e:	48 89 f7             	mov    %rsi,%rdi
    a281:	48 89 c6             	mov    %rax,%rsi
    a284:	48 89 d3             	mov    %rdx,%rbx
    a287:	31 c9                	xor    %ecx,%ecx
    a289:	e8 02 ff ff ff       	call   a190 <ieee80211_store_ack_skb>
    a28e:	25 ff 1f 00 00       	and    $0x1fff,%eax
    a293:	89 c2                	mov    %eax,%edx
    a295:	b9 0f 00 fe ff       	mov    $0xfffe000f,%ecx
    a29a:	23 4b 04             	and    0x4(%rbx),%ecx
    a29d:	c1 e2 04             	shl    $0x4,%edx
    a2a0:	09 d1                	or     %edx,%ecx
    a2a2:	89 4b 04             	mov    %ecx,0x4(%rbx)
    a2a5:	85 c0                	test   %eax,%eax
    a2a7:	74 cb                	je     a274 <ieee80211_8023_xmit_clang_deb=
ug_helper+0x14>
    a2a9:	83 c9 08             	or     $0x8,%ecx
    a2ac:	89 4b 04             	mov    %ecx,0x4(%rbx)
    a2af:	eb c3                	jmp    a274 <ieee80211_8023_xmit_clang_deb=
ug_helper+0x14>
    a2b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw=
 0x0(%rax,%rax,1)
    a2b8:	0f 1f 84 00 00 00 00=20
    a2bf:	00=20

When compiled with gcc the disassembly is

00000000000010e0 <ieee80211_8023_xmit_clang_debug_helper>:
    10e0:	48 8b 4f 18          	mov    0x18(%rdi),%rcx
    10e4:	48 89 f8             	mov    %rdi,%rax
    10e7:	48 85 c9             	test   %rcx,%rcx
    10ea:	75 05                	jne    10f1 <ieee80211_8023_xmit_clang_deb=
ug_helper+0x11>
    10ec:	e9 00 00 00 00       	jmp    10f1 <ieee80211_8023_xmit_clang_deb=
ug_helper+0x11>
    10f1:	48 8b 49 60          	mov    0x60(%rcx),%rcx
    10f5:	f7 c1 00 00 08 00    	test   $0x80000,%ecx
    10fb:	74 ef                	je     10ec <ieee80211_8023_xmit_clang_deb=
ug_helper+0xc>
    10fd:	48 83 ec 08          	sub    $0x8,%rsp
    1101:	48 89 f7             	mov    %rsi,%rdi
    1104:	31 c9                	xor    %ecx,%ecx
    1106:	48 89 c6             	mov    %rax,%rsi
    1109:	48 89 14 24          	mov    %rdx,(%rsp)
    110d:	e8 ce f8 ff ff       	call   9e0 <ieee80211_store_ack_skb>
    1112:	48 8b 14 24          	mov    (%rsp),%rdx
    1116:	89 c1                	mov    %eax,%ecx
    1118:	8b 42 04             	mov    0x4(%rdx),%eax
    111b:	81 e1 ff 1f 00 00    	and    $0x1fff,%ecx
    1121:	c1 e1 04             	shl    $0x4,%ecx
    1124:	25 0f 00 fe ff       	and    $0xfffe000f,%eax
    1129:	09 c8                	or     %ecx,%eax
    112b:	89 42 04             	mov    %eax,0x4(%rdx)
    112e:	a9 f0 ff 01 00       	test   $0x1fff0,%eax
    1133:	74 04                	je     1139 <ieee80211_8023_xmit_clang_deb=
ug_helper+0x59>
    1135:	80 4a 04 08          	orb    $0x8,0x4(%rdx)
    1139:	48 83 c4 08          	add    $0x8,%rsp
    113d:	e9 00 00 00 00       	jmp    1142 <ieee80211_8023_xmit_clang_deb=
ug_helper+0x62>
    1142:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1149:	00 00 00 00=20
    114d:	0f 1f 00             	nopl   (%rax)
    1150:	90                   	nop
    1151:	90                   	nop
    1152:	90                   	nop
    1153:	90                   	nop
    1154:	90                   	nop
    1155:	90                   	nop
    1156:	90                   	nop
    1157:	90                   	nop
    1158:	90                   	nop
    1159:	90                   	nop
    115a:	90                   	nop
    115b:	90                   	nop
    115c:	90                   	nop
    115d:	90                   	nop
    115e:	90                   	nop
    115f:	90                   	nop


I've not yet taken a closer look, but perhaps the error is obvious
for some one else.

Bert Karwatzki


