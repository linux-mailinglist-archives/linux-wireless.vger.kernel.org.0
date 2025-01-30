Return-Path: <linux-wireless+bounces-18232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC242A2365C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 22:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9FB18866C8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 21:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11D1EF09C;
	Thu, 30 Jan 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Te2avAFI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888321482E1;
	Thu, 30 Jan 2025 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271603; cv=none; b=bJS158E5Uq3Zkfud984c0V5GWIzI8iDWXAvINHM94m+aq3ilzqI04xddp9I0WXgYhNKICiscEO7nZE+D+iifvdF8nS2R40Ss3iIzxTjF+o214NG3WppmxiEJLq/UF2/CiWuQBQSevKtCcoX6Hn0bHHczAB3dZ6Cd3fTfv/cMTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271603; c=relaxed/simple;
	bh=GX4xYuXDevv2ccW6nS1G33S+5+WkoXuAQbeugMn5myE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IE91PSLBwln+L1ARQCQc8EmDQPH0DnfoLoHMar4c5VVSjlhffAKg2OXruyZtuKOlTwPCFi3/bhiTVA1/RqsO0iAgHazW1/bz3ZUF2MBUNkoBT2wOuucNRilefUPizfZO+F0+tSGLxjaXez3g25ecP3bpBJHBpDT6EHbSise8Z3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Te2avAFI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GX4xYuXDevv2ccW6nS1G33S+5+WkoXuAQbeugMn5myE=;
	t=1738271601; x=1739481201; b=Te2avAFIgSoX8OnHsQucu9+phAds/sxTDmVLcfK5x42E2+F
	mYlQQdiH90SdYWBPO7oN8Y/CQLXXyLPM5WRI0IEaGJPwon/AxGfpDtdQ74TBD+vXSk0/fjRsgS4Kw
	PciRrtR0DM0IG2NCylscrgRt97b426Zm318kcXEGIXRuALaikkSDiHweE1DXQvYakToplh9LLnNef
	f7LaOEHvGnOzbT/NUdoRnRMzw/DkmynWMaT7q+XSCxxsynxEloEStZD5go2PBkfFhC+90W2Dx2Pw+
	Tmmlm52caJlAS83YvT8/+bNMehEarLt+CHLAVx1X9TjLyGwb59URF1ZY/N27CNfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tdbqd-0000000FKUL-2hHg;
	Thu, 30 Jan 2025 22:13:15 +0100
Message-ID: <49fe46c6a158873cdc6593b0d5630b62a59ed059.camel@sipsolutions.net>
Subject: Re: [lvc-project] [PATCH] wifi: nl80211: override all other flags
 if MONITOR_FLAG_COOK_FRAMES is set
From: Johannes Berg <johannes@sipsolutions.net>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>, 
	lvc-project@linuxtesting.org, Michael Wu <flamingice@sourmilk.net>, 
	linux-wireless@vger.kernel.org, "John W. Linville"
 <linville@tuxdriver.com>, 	linux-kernel@vger.kernel.org, 
	syzbot+2e5c1e55b9e5c28a3da7@syzkaller.appspotmail.com
Date: Thu, 30 Jan 2025 22:13:14 +0100
In-Reply-To: <fhgill32gd3ugmd23oxnyvvqqfd3feu4zv3ecrkubeyqhwnb2h@pkflwiezmsp2>
References: <20250130123432.4534-1-v.shevtsov@mt-integration.ru>
	 <14c5edc71a74049c49d51960249b0aefc77208be.camel@sipsolutions.net>
	 <fhgill32gd3ugmd23oxnyvvqqfd3feu4zv3ecrkubeyqhwnb2h@pkflwiezmsp2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-01-30 at 22:23 +0300, Fedor Pchelkin wrote:
>=20
> Do you suggest rejecting to set MONITOR_FLAG_COOK_FRAMES overall?

No and yes :)

No for the context of this patch. Yes in general.

> Wouldn't it break existing userspace, especially in context of systems
> running old stable kernels where the patch is also needed?
>=20
> There is still some usage of this flag in hostap [1].

Theoretically, but I just commented on that here:

https://lore.kernel.org/r/a49e58998553c45953a30243ad1957c06ce6db8c.camel@si=
psolutions.net

tl;dr: only ancient hostapd versions will actually _use_ it, and they
have to fall into a relatively narrow range (April 2009 - Dec 2011.)

> Or your suggestion is to explicitly reject setting MONITOR_FLAG_COOK_FRAM=
ES
> only when it is passed combined with some other flags which it is
> incompatible with?

Yes.

> Btw, the fragment [2] says the cooked flag overrides the other ones.
> But it was written a long time ago so many things have changed I guess.

Indeed, that doesn't really make sense (certainly not any longer.)

> [1]: https://w1.fi/cgit/hostap/tree/src/drivers/driver_nl80211.c#n6209

And that was almost certainly the only user that ever existed, and can
only set the flag by itself.

johannes

