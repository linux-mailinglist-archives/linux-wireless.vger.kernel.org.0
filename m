Return-Path: <linux-wireless+bounces-18957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A5A35AD3
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 10:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73305188443F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96590245029;
	Fri, 14 Feb 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hlnjwVag"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26F422D7A3;
	Fri, 14 Feb 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526672; cv=none; b=lBNj4Punfdc7NLwUYBhgwqEvqrvVgNVsv3BD7i3DOCYefAx7C1J1/SdU2nUrXOLLFGAbF7v8UvyrPOAr6mscVXusznqoLSJEISQcezKOcMJXkL65mQ6VgCDnwvEU91l43emS6+5kziltsrv1YH8aCDPnJdssHu8ccxVM/NiP8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526672; c=relaxed/simple;
	bh=0ljqkkvPMjt89Plm5FVW13hb2JKBJSlP4wsUOkHb2CU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jFtiZNPe3nARm5ZT9dmNC3BJMeqr7mXTp/Khjg6Hioitm3/gKkwlrGbBcAO0fgz3IQFxAIozzB0P3LjYtXsPuAs0/ZT4H/JssQBQjjyaG+bnU2GAUm9PjCDjd6rJsb5VEDGxid2h2MiAjE8UiWNBCWX7A2jAAV7Hy7UsDTyiFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hlnjwVag; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=x9ZZzvHk2TN4NuoUgSp0fpU2hQ1B8WaMdLF7eMb7v60=;
	t=1739526671; x=1740736271; b=hlnjwVagZTt92nLFUfcmIEGECMk3ui0ycPhzvvf6o1AiFi/
	NS5HzFWbKb9cUNJ+CpCAaDFOsBROvWNgfxseU2ZwvSvDBXGDmohpWiyBXrZgDoF039kvgTDIDrukl
	SYeA8JiepFM4R2Il+pLDIBZ3+jOjTYGw1fTpnkVB+Hx2boYh59e3P5n7GX8DYxZRPuUjQE+5Ho3Mt
	NZpsTkvg+OTISqWwy+j6lGb5eKh3/OQtvd1yaTH1ACaO27hpc6hiJGN3DdEwhsKvjahtcBI2Ryy6l
	kulKVEPMFDc3s7IyBZtZcw2ZTtOZ5xJOTxOXz8vk69jsAPNu150fAoG8ils2Xx4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tisLh-0000000EQ5I-2RZS;
	Fri, 14 Feb 2025 10:51:06 +0100
Message-ID: <3f259b89ab1d2c37f6449a21608c48d1ee4bc542.camel@sipsolutions.net>
Subject: Re: [linux-next:master] [wifi] be22179cfb:
 hwsim.monitor_iface_multi_bss.fail
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <alexander@wetzel-home.de>, kernel test robot
	 <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-wireless@vger.kernel.org
Date: Fri, 14 Feb 2025 10:51:04 +0100
In-Reply-To: <ae3d7e06-2ce0-443b-9de9-9b3e814f4deb@wetzel-home.de>
References: <202502141548.e1f3f465-lkp@intel.com>
	 <ae3d7e06-2ce0-443b-9de9-9b3e814f4deb@wetzel-home.de>
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

On Fri, 2025-02-14 at 10:49 +0100, Alexander Wetzel wrote:
> > in testcase: hwsim
> > version: hwsim-x86_64-c8c7d56a3-1_20250209
> > with following parameters:
> >=20
> > 	test: monitor_iface_multi_bss
>=20
> I was expecting something like that:-)
>=20
> Cooked monitor interfaces were required for hostapd versions less than=
=20
> 1.0 (released May 2012) for running an AP. Starting with v1.0 hostapd=20
> prefers the cfg80211/nl80211 API, while still be able to use the old one.
>=20
> This patch here now drops cooked monitor interface support, preventing=
=20
> hostapd to be able to use the old cooked monitor method.
>=20
> Any kernel with this patch must fail this and any other test using=20
> cooked monitor mode (driver_params =3D "use_monitor=3D1").

I already sent patches to hostap to fix all that up and clean out the
code, so it'll be fixed in time.

johannes

