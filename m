Return-Path: <linux-wireless+bounces-2785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F7841C61
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 08:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E553B23908
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 07:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558EE44377;
	Tue, 30 Jan 2024 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qCrmUfDj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F853E05;
	Tue, 30 Jan 2024 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598827; cv=none; b=befWVA4IwjUPbZ9GxWFQMELJUq7KHaFQpUzrBXychtjd/9EVMnN2okK7YAGsROWoRUqlO+yJRyi10chbF2z0mMRikdVRmrfGSWYZj7tX1v5AdNMo1XfxDRSkmFaocdQk5R+R7dBrj3B4mX9QZaIetyzNitFlEIiDocycorjhaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598827; c=relaxed/simple;
	bh=16lxKNqIr7pmqD88HsCEfd8ADT6yVniQoxBbtMWESYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hM0I1f0cQkSlec4+sc4OFt6QeRLHP4BsjAEBSeOvrofdHvLKtxXEmsv+sU5DgAmvaB6jABOXUHuTlteImIk0EaMtMvqpMTdwvkNYAIbovG2ver/etdr+qUZo8CK/eyZEYkZMaPXsrgFmgDEz8Ygywouu5L9NLIes3gtJg6sNI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qCrmUfDj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QxOKgSrQIwaxWzl51HsbjSfzRpY/WG0SpR5AK2CGItU=;
	t=1706598823; x=1707808423; b=qCrmUfDj8IRBNZpN0jKU6OuwsAtC7rDLVj/1r1s4xUSOQxD
	/fgxLWfnXjzGgKJovFsoPqNeiaQF1FmujfjUTn3eoWhBVQfYphkUVBotSDsok+VT1zesaxYSgL2qC
	RDKmHAUFiFNuXFjjPeY+wOk/L1bZpgc9QDrb9bc+6SoItEZHwwlCv5TVSDHebLHI1EOEAn6TPXqTJ
	8sSVxiVfeGEK0AGmosxfWPsX5ZeuBopQQMydenzWTU5uEJOlpFk3GBVNzNV8C4kAwbHmr3iRDb5HS
	1IG3pwDyAQklLPZ3s/AIecgKFHDQ7dZNZfahN/i+sdJjkGurhE/9sVnHSD9UNe7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUiJO-00000005uED-0Vr5;
	Tue, 30 Jan 2024 08:13:38 +0100
Message-ID: <933555b38708daa673a88953a196914424de611a.camel@sipsolutions.net>
Subject: Re: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into
 chandef
From: Johannes Berg <johannes@sipsolutions.net>
To: kernel test robot <lkp@intel.com>, linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Date: Tue, 30 Jan 2024 08:13:37 +0100
In-Reply-To: <202401301417.rknKsCyo-lkp@intel.com>
References: 
	<20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
	 <202401301417.rknKsCyo-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-30 at 14:45 +0800, kernel test robot wrote:
>=20
> All errors (new ones prefixed by >>):
>=20
> > > drivers/net/wireless/ath/ath12k/mac.c:2771:16: error: use of undeclar=
ed identifier 'BSS_CHANGED_EHT_PUNCTURING'
>     2771 |         if (changed & BSS_CHANGED_EHT_PUNCTURING)
>          |                       ^
> > > drivers/net/wireless/ath/ath12k/mac.c:2772:31: error: no member named=
 'eht_puncturing' in 'struct ieee80211_bss_conf'
>     2772 |                 arvif->punct_bitmap =3D info->eht_puncturing;
>          |                                       ~~~~  ^
>    drivers/net/wireless/ath/ath12k/mac.c:6374:35: error: no member named =
'eht_puncturing' in 'struct ieee80211_bss_conf'
>     6374 |         arvif->punct_bitmap =3D link_conf->eht_puncturing;
>          |                               ~~~~~~~~~  ^
>    3 errors generated.
>=20

Not sure why my build test didn't catch that (probably .config issues),
but yes ... I clearly forgot that. Will fix.

johannes

