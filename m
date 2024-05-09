Return-Path: <linux-wireless+bounces-7383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1918C0D42
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 11:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0671F23698
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D1214A4D6;
	Thu,  9 May 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="l0Nfxtls"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC0F1494D9;
	Thu,  9 May 2024 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245936; cv=none; b=KahqqbdyBTRTHVpwxtCR7uySlmMBq9vWax42kkkOIQEjrU4+V5dnYWNWDWGcXpt3w9ynUY6wWcuRSsGJsiFDBD8fh3n7cHQ6ETjKeeIdB1U5Dvx//6mEkL6SsxOxNRPT41ciqisxDRCdw2RgLGqBQAqNGi3VN6OKrwCGGimcY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245936; c=relaxed/simple;
	bh=tIrasCcyV33AYR5O1egEtEOiQXsAZNYT11I2V7GFPPw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iwd7eRXuHMYy1rjgJdDrpCasT3pYmzumWfGztioOPYU2rvEb5SsUVv9WKXC0E5cuoVHbtRLE7eTpcW4oTRHQwUXUu0pVuo7PGNo7NYjLVq1Bv43HCzhxDJeeF3049e7VQUoyDLC9O51X4pQ/UEm1dYWDEVN8JO0jB85uHGCyBJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=l0Nfxtls; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yfHOQBr6dYYpRW7k8Z7MK8HKsShTr3RZAMKrgndv9oc=;
	t=1715245933; x=1716455533; b=l0NfxtlsCjeSF7DbWgNMVjegulwCTZ/o6ysRh408+PoJC3Z
	BfgJKmeAfsAWmC+4YyMAzKvNZj9ubk2JqgCcrBEnFlVGAcSFJiifXMQ+nS9iqdsihnKxFqF2SaIi6
	QLhNDzR6XGauqrq7MLySwOgaOUC9YzgTdoktCNGMs4yYAtGzvOTJEmWX1YIk/Y6wgLgLAkbrWCjA8
	HtvNkBEe/3nr/a94T/rkdguSc37T2Fg7lfVpEkyEyshwNWoYgZ4Yuu0wSHakOMfWQmIRybXallySR
	YnNb4aHN4C7H0dFBLQS2MyUPtNzpcFkfsb8rgOuUqUhAxXghraBaZPrmRhULIwtg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s4zRq-0000000CuiJ-3TvE;
	Thu, 09 May 2024 10:48:19 +0200
Message-ID: <12b6ac611c1a44b4eadbb1316636b7268ab66a50.camel@sipsolutions.net>
Subject: Re: Fwd: UBSAN: array-index-out-of-bounds in net/wireless/nl80211.c
 and net/mac80211/scan.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>, 
 Linux Wireless <linux-wireless@vger.kernel.org>
Cc: Jouni Malinen <jouni.malinen@atheros.com>, "John W. Linville"
 <linville@tuxdriver.com>, Kalle Valo <kvalo@kernel.org>, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Jannik =?ISO-8859-1?Q?Gl=FCckert?=
 <jannik.glueckert@gmail.com>
Date: Thu, 09 May 2024 10:48:17 +0200
In-Reply-To: <ZjwTyGqcey0HXxTT@archie.me>
References: <ZjwTyGqcey0HXxTT@archie.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-05-09 at 07:07 +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> Jannik Gl=C3=BCckert <jannik.glueckert@gmail.com> reported on Bugzilla ar=
ray index
> out-of-bounds catched by ubsan along with full kernel trace dump (see
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218810):
>=20
> > I am seeing multiple array-index-out-of-bounds related to `ieee80211_ch=
annel[]` iteration.
> >=20
> > This is with a Mediatek MT7921 chipset.
> > I have only tested with kernel 6.8.9, but I don't see any channel index=
 related fixes in master.
> >=20
> > This was discovered as part of Gentoo Hardened enabling CONFIG_UBSAN_AR=
RAY_BOUNDS
> >=20
> >=20
> > [  106.194465] UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys=
-kernel/gentoo-kernel-6.8.9/work/linux-6.8/net/wireless/nl80211.c:9203:29
> > [  106.195063] index 42 is out of range for type 'struct ieee80211_chan=
nel *[]'

> > [  106.200924] UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys=
-kernel/gentoo-kernel-6.8.9/work/linux-6.8/net/wireless/nl80211.c:9252:5
> > [  106.200926] index 0 is out of range for type 'struct ieee80211_chann=
el *[]'

At least one of these should be fixed by
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commi=
t/?id=3D838c7b8f1f278404d9d684c34a8cb26dc41aaaa1

> > [  106.201036] UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys=
-kernel/gentoo-kernel-6.8.9/work/linux-6.8/net/mac80211/scan.c:364:4
> > [  106.201037] index 0 is out of range for type 'struct ieee80211_chann=
el *[]'

No idea about that one. Send patches.

(Seriously. If you're running with bleeding edge toolchains that pretty
much nobody has yet, send patches.)

johannes


