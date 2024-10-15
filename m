Return-Path: <linux-wireless+bounces-13950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BD99DE89
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 08:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C7E1F24E64
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 06:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79068189F2D;
	Tue, 15 Oct 2024 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XPGMrMwh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56C189BBF
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974195; cv=none; b=szJd0naQblr2Kviaj6Xjd0DdQMERDrIAUyAWBmfpczL9BxRMx4XdeXl1BvgTEUXrG3syRTXnOSF1Y0WEEAYU5pGc7BYBomUKI/kBrLJXEAFEjHB5UFl+eez9bGq+JZpeGY7qKoYiqga2bAeUBaKmwYFWxzUaKzWaOfZTUseedK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974195; c=relaxed/simple;
	bh=gRX0+AQnxxJrCY3jifivvXNdobZqCKZKM/LUmGu/96k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dloy+oEnZrmTBg6jKGvT2BjjjSaBRMu3WoLIFSLiDM9/UTLzzyCxvVn0TFc3Kl+tTcg+b8ZFr4GIIzHYphG/bB9DvVk9LNZXhYEatbZxoGu9SdJEs4UlBzzoxp3AMYqhPC8XKwqNCBu7CZq0JGYhMpDAzv1sfuow+NbKvmRFp1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XPGMrMwh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gRX0+AQnxxJrCY3jifivvXNdobZqCKZKM/LUmGu/96k=;
	t=1728974193; x=1730183793; b=XPGMrMwhce6T6pcqjwQYTN+O48A49aOBYYvn460QXASNOfw
	U2TQWUIk4XTfnlvScOZ/VpZ4iTBukbGQZ5WshiwgUnf8befMt772w/QwLaL0LLzJhsd6oIdsjYjK3
	GrB/E1ZUAMqu9n1WUoO1/lAbip0mDH6LMi6JK4y6iCz4XswHOiz1Q4EqqPX+LEFQP7RYC08yoX4Ue
	v1D0rUyT+DeFNwRGr7E2GYjdiJZqqbREdqWhNV2xmUwwiozXWPzLPwmCeYSB9mgcrTXu4ap3pFHKu
	J2MQ6QjCRWf2PEZOcRe5/VeBRL83G1poBHYGqcWMk+UOUzj5NkwXRHFTqJmg2yhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t0bAP-0000000BYCl-00Ll;
	Tue, 15 Oct 2024 08:36:25 +0200
Message-ID: <2d4bc83dffef3b773312aa08d55bb310f2dcead9.camel@sipsolutions.net>
Subject: Re: [PATCH v1 wl-next 1/3] wifi: wext: Move wext_nlevents to
 net->gen[].
From: Johannes Berg <johannes@sipsolutions.net>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Kuniyuki Iwashima
	 <kuni1840@gmail.com>, linux-wireless@vger.kernel.org
Date: Tue, 15 Oct 2024 08:36:24 +0200
In-Reply-To: <20241014205543.94787-2-kuniyu@amazon.com>
References: <20241014205543.94787-1-kuniyu@amazon.com>
	 <20241014205543.94787-2-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-10-14 at 13:55 -0700, Kuniyuki Iwashima wrote:
> CONFIG_WEXT_CORE cannot be built as a module

Isn't that precisely an argument for _not_ using net->gen[] with all the
additional dynamic allocations that implies? I'm not really against
doing this, but it does make the third patch more complex, requiring the
new wext_net->net pointer, and given allocations (rounded up) will take
more space - for something always present - than just going with the
existing scheme?

What's the reason to use net->gen[]?

johannes


