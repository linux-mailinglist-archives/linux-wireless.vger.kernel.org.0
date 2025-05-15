Return-Path: <linux-wireless+bounces-22993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB46AB8224
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DFD3BE488
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 09:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD2028C00D;
	Thu, 15 May 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="mJukR+qH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315F1FAA;
	Thu, 15 May 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300251; cv=none; b=cCtkZajdEsBXtl/sWJnwmPihnPoeliPM8xjtJa8tjOZ2atmsK/vIQA6q+1wUN1P6NTpPvFaNJq5sW8/+6P2S1jy47E8sYKPagemVhKcgIuF0a8ufo5LdkBauoV20USh5mvf8rryfHrmnMfQCngHFmMINYgzOgoa9CYUgAdISS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300251; c=relaxed/simple;
	bh=JfQ7DY+3VoCkdZhZVxclfjCRSyYZYSyFpAb6mQ79suA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCHzgwKNXsGp/DiOMdItUxup5l7GMT0v8vvrPyazuilIS1yK5hoXzOMIHwOpU7nVHlnPLSn0qXh6JdCGuULiL4bt3ushYkXewTWLonmvFaMvgk6mqxfP9UDApvWgMpA6IKw0lCVRvGN3whk1gVt5ZjjGsvePIJyKPR82kwsVA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=mJukR+qH; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747300232; x=1747905032; i=spasswolf@web.de;
	bh=FA8nwZLd6fsDB/lVfJxo9+FEU+s6+zXEeLeiqLWa8YQ=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mJukR+qH8y10DckWt++QstOWuS2ejsZmdMSBH1s9j7hRCmMrkLknYyyryIaWu0pI
	 Tu6qkM+60NltTl5P4tA31pIW0Bs+RVsItTbU6XlLkNw/LupoZBoloqiu0tto2ZKCy
	 FkxUVAUXSjGGkczTuzkKixsBP8U/26qj1Zdtc4GEiRO9ZFloNWaxwGLejE3AxEVmj
	 RJ4cMO1GYsVvh1xXuND9phpIp+BL+R/7IqiFbSX8TyaBRe+1TfzpQJ1fVN0QXrPfP
	 kx0XW7CMolphgwbZNCMLKIK7n6G5XEzfQK648oV90W11s3Q6wmCEtLArarzxE4vIV
	 7/dMKJLVHn+cEfxPwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8TBM-1uJuSe0q9I-00FME9; Thu, 15
 May 2025 11:10:32 +0200
Message-ID: <ba97a2559cda1b14e0c9754523ff1152bdad90ef.camel@web.de>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Bert Karwatzki <spasswolf@web.de>
To: Johannes Berg <johannes@sipsolutions.net>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, 
 "llvm@lists.linux.dev"
	 <llvm@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-wireless@vger.kernel.org, spasswolf@web.de
Date: Thu, 15 May 2025 11:10:31 +0200
In-Reply-To: <8684a2b4bf367e2e2a97e2b52356ffe5436a8270.camel@sipsolutions.net>
References: <20250513164807.51780-1-spasswolf@web.de> <87h61ojg3g.ffs@tglx>
									 <7471a185adcc34a79c2ab8ce1e87ab922ae2232b.camel@web.de>
								 <b644ff1714731cfb652d809d4864f0d178b24a97.camel@web.de>
							 <2d8c1929bf5ab5260dacf9aa390456b3b49ce465.camel@sipsolutions.net>
						 <2cad838b39f00d93319509d2a6a77a4c42c7fa92.camel@web.de>
					 <a12c82c394e9676e32ede6b8312f821a16fef94b.camel@sipsolutions.net>
		 <f8552d41fb7eae286803b78302390614179b33b0.camel@web.de>
	 <8684a2b4bf367e2e2a97e2b52356ffe5436a8270.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AgZlPCa34X3pe/n06Id/9sUdWs6gUEY/yQGj6urQnK51V1IM2Nk
 6s+15Bkil6i161Poh0dBFPEgae44dyD7Bqb/rQh+zGKIRPj/8GDd0IfvvRQmmcjvA/icpxQ
 bW0qmmJqBqJgppYibxSlrijTkilLDysTj2yeC1Nl5spXgwFm8JdXqnCbFNCszrQE5x6r9I2
 CItDDtBz6Q51r92Or63ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m8D0S43rqss=;yAf6bsg7DVHMDDJzmC8a+Rq5aDw
 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
 23eKQTEPKQstY=

Am Donnerstag, dem 15.05.2025 um 08:30 +0200 schrieb Johannes Berg:
> On Thu, 2025-05-15 at 00:27 +0200, Bert Karwatzki wrote:
> > Am Mittwoch, dem 14.05.2025 um 20:56 +0200 schrieb Johannes Berg:
> > > >=20
> > > > I've split off the problematic piece of code into an noinline func=
tion to simplify the disassembly:
> > > >=20
> > >=20
> > > Oh and also, does it even still crash with that? :)
> >=20
> > Yes, it still crashes when compiled with clang.
>=20
> OK, just checking. :)

To be more precise I need clang AND PREEMPT_RT=3Dy to get a crash.

>=20
> FWIW, I'm not convinced at all that the code you were looking at is
> really the problem. The crash (see below) is happening on the status
> side. Of course it cannot crash on the status side if on the TX side we
> never enter anything into the IDR data structure, and never tag the SKB
> to look up in the IDR and therefore never try to create the status
> report on the status side.

After looking at the backtrace I'm also no longer conviced that piece of c=
ode is
the problem.

>=20
> Basically what happens is this:
>=20
> - on TX, if we have a socket requesting status, create a copy of the
>   SKB, put it into the IDR, and put the IDR index into the original
>   skb->cb
> - then transmit the original skb, of course
> - on TX status report from the driver, see if the skb->cb is tagged with
>   the IDR value, if so, report the copy of the SKB back to the socket
>   with the status information
>=20
> (The reason we need to make a copy is that the SKB could be encrypted or
> otherwise modified in flight, and we don't want to undo that, rather
> keeping a copy for the report.)
>=20
> >  [  267.339591][  T575] BUG: unable to handle page fault for address: =
ffffffff51e080b0
> >  [  267.339598][  T575] #PF: supervisor write access in kernel mode
> >  [  267.339602][  T575] #PF: error_code(0x0002) - not-present page
> >  [  267.339606][  T575] PGD f1cc3c067 P4D f1cc3c067 PUD 0=20
> >  [  267.339613][  T575] Oops: Oops: 0002 [#1] SMP NOPTI
> >  [  267.339622][  T575] CPU: 0 UID: 0 PID: 575 Comm: napi/phy0-0 Not t=
ainted
> > 6.15.0-rc6-next-20250513-llvm-00009-gec34cd07a425 #968 PREEMPT_{RT,(fu=
ll)}=20
> >  [  267.339629][  T575] Hardware name: Micro-Star International Co., L=
td. Alpha
> > 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> >  [  267.339632][  T575] RIP: 0010:queued_spin_lock_slowpath+0x120/0x1c=
0
> ...
> > [  267.339692][  T575] Call Trace:
> >  [  267.339701][  T575]  <TASK>
> >  [  267.339705][  T575]  _raw_spin_lock_irqsave+0x57/0x60
> >  [  267.339714][  T575]  rt_spin_lock+0x73/0xa0
> >  [  267.339720][  T575]  sock_queue_err_skb+0xdc/0x140
> >  [  267.339727][  T575]  skb_complete_wifi_ack+0xa9/0x120
> >  [  267.339737][  T575]  ieee80211_report_used_skb+0x541/0x6e0 [mac802=
11]
> >  [  267.339799][  T575]  ? srso_alias_return_thunk+0x5/0xfbef5
> >  [  267.339804][  T575]  ? start_dl_timer+0xcf/0x110
> >  [  267.339814][  T575]  ieee80211_tx_status_ext+0x3b3/0x870 [mac80211=
]
> >  [  267.339851][  T575]  ? raw_spin_rq_lock_nested+0x15/0x80
> >  [  267.339862][  T575]  ? srso_alias_return_thunk+0x5/0xfbef5
> >  [  267.339866][  T575]  ? rt_spin_lock+0x3d/0xa0
> >  [  267.339873][  T575]  ? mt76_tx_status_unlock+0x38/0x230 [mt76]
> >  [  267.339886][  T575]  mt76_tx_status_unlock+0x1e0/0x230 [mt76]
>=20
> Yeah so that's the crash on the status report as explained above, it
> kind of looks almost like the skb->sk was freed and somehow invalid now?
> But I don't see a general issue here (will keep digging), and how come
> it only shows up with clang?
>=20
> Since it reproduces pretty reliably, maybe you could do with KASAN?
>=20

I'm currently doing a testrun with KASAN enabled, test is running ~1h so f=
ar
(without KASAN the max time to a crash was about 10min), so KASAN is proba=
bly
killing the bug (there are no messages from KASAN in dmesg).

> Also could be interesting - what userspace are you running with wifi?
> What tool is even setting up the wifi status? If you don't really know
> maybe just put WARN_ON(1) into net/core/sock.s where SO_WIFI_STATUS is
> written (sk_setsockopt).
>
> johannes

For the recording these backtraces I disabled wifi just after booting (it
usually takes ~5s to connect here) with network manager (nmcli)(from debia=
n sid
(last updated on 20250511, before I encountered this bug))
$ nmcli radio wifi off
then I set up the netconsole and reenabled wifi and waited for the crash
$ nmcli radio wifi on

Bert Karwatzki


