Return-Path: <linux-wireless+bounces-20152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C417A5BC0E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 10:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA43172A81
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 09:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7819A22B5A8;
	Tue, 11 Mar 2025 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Kx1LbNKc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A3226177;
	Tue, 11 Mar 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685144; cv=none; b=iuzP3edgLt9+cyPvQxioepQ045SSC0zOrWHoifx1r/rUFl3mZ5wKQq15+cMAhU4iDOFM+cjCwHLo2mb17u/bXVB+sRAOheykc+kT+UfN3/z/VtTVh/tmbs26CVqEkt9VhOUd+FWfel0kHmJDR1RPLZ8tEequ8AEiOA9u0iP8/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685144; c=relaxed/simple;
	bh=jVA0botF/7UpaHDHr2fUbl6zp4iOX2aREWoTuBm1Q34=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKWveViwo1Krh8VSqEV4MoPXxp3hFjlqeMM96EPhF0fS1yrAPmaOODFARWtsDVR7ReUZMDz/Kz1NlWuH482ReEGpe2wFenIPtgtzCwK63ZBNKguiW0JFaUao60ed+CJhaTJF4/z5uClOSVI6Jvs5Yo5mS8ze9HHXVQwDgt+B69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Kx1LbNKc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=38XthFMU8LX6ecctMEDvh0zBZBH4c/+JYLRIrlgjMLo=;
	t=1741685142; x=1742894742; b=Kx1LbNKcCmt4Rjb1S4OqFL7SEMRDdqurfDNz6Pue5GUELpB
	pgAN8SPiKegWDIbASptbzSChgB9hYGEbJktWN9IRzivsCHnEKO6+OTmwXgJUymAnDmbDgqlGFfS78
	beY9TS5Fnk+W0oipXdp5G+Eb2pOe5ql/UoPZ1r3gksDbExPw6O/CV4gokMABHoQrGDecWiVFiZ9M+
	mURTbXvObHiBA7NKp+/8p5RxNIetWsSqp+uVsrw7x9D0m6MY1u/yvuqNTXOEKBWGIi0RyDfxuCaZe
	mqtNPmnLG1HrpXkARM4brPOONLZUtMLkJqY0T12vkPSX/uHxsphGLoFCtTnnFnTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1trvrN-00000007lXx-3rWn;
	Tue, 11 Mar 2025 10:25:14 +0100
Message-ID: <12b44f58b339aa92f1b17fb7b33e30a920aad86c.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Add __nonstring annotations for
 unterminated strings
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <kees@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,  Julia Lawall
 <Julia.Lawall@inria.fr>, En-Wei Wu <en-wei.wu@canonical.com>, Shaul
 Triebitz	 <shaul.triebitz@intel.com>, Alexander Wetzel
 <alexander@wetzel-home.de>,  Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, kernel test robot <lkp@intel.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, 	linux-kernel@vger.kernel.org, 
	syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com, 
	linux-hardening@vger.kernel.org
Date: Tue, 11 Mar 2025 10:25:10 +0100
In-Reply-To: <20250310222318.work.395-kees@kernel.org>
References: <20250310222318.work.395-kees@kernel.org>
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

On Mon, 2025-03-10 at 15:23 -0700, Kees Cook wrote:
>=20
>  drivers/net/wireless/virtual/virt_wifi.c     | 2 +-
>  drivers/net/wireless/zydas/zd1211rw/zd_mac.c | 2 +-
>=20

That's not mac80211?

Also, I have no idea how you came up with the CC list but it seems
excessive. :)

johannes

