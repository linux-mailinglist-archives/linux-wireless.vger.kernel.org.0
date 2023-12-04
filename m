Return-Path: <linux-wireless+bounces-403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C59804064
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 21:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B901C20889
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D2433094;
	Mon,  4 Dec 2023 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CT36PECD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1216C6;
	Mon,  4 Dec 2023 12:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IvcuO1hSSnoLO74Nmy5OlV/+o+qw+L0ddRc9j5Pdrsw=;
	t=1701723034; x=1702932634; b=CT36PECD5yMVg7dW6ttKWy5WxO34gZuf8tZ8YZLpO9v7gqV
	dGXGRrVlLKshihCIfetnS2kv+oH5D8nNFUgJ2zBhpktqrRVeVkZz8rvf7xCHlBIftcigZh9HlPj7e
	p6kfoY5uJk9SFdxxNUXqjBRPjZvLnldBUcFbvjBbOEE5lTiYgz/OxOyZqtDawQoiOU4l0abwyg7Rl
	JvPTmdE4TUnwYFe4m48cBpXZ2DcDVgMRQ/aBGm6faGYoAN52Fg5qvQUArrecEpcpXMCiU6gBcdeKD
	nvvnAe/pWWoiOzEJgsRPtfTYsd2Iw7FCBoVBVhCPrvJb08bNcdw5TSGud4Fr7W6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAFte-0000000FFlL-3cj6;
	Mon, 04 Dec 2023 21:50:31 +0100
Message-ID: <71d0f8424661b0d7b2c371e422416854790e477a.camel@sipsolutions.net>
Subject: Re: [PATCH AUTOSEL 4.14] wifi: cfg80211: lock wiphy mutex for
 rfkill poll
From: Johannes Berg <johannes@sipsolutions.net>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Cc: syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 04 Dec 2023 21:50:29 +0100
In-Reply-To: <20231204203735.2095033-1-sashal@kernel.org>
References: <20231204203735.2095033-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-12-04 at 15:37 -0500, Sasha Levin wrote:
>=20
> +++ b/net/wireless/core.c
> @@ -202,7 +202,9 @@ static void cfg80211_rfkill_poll(struct rfkill *rfkil=
l, void *data)
>  {
>  	struct cfg80211_registered_device *rdev =3D data;
> =20
> +	wiphy_lock(&rdev->wiphy);

This can't even _build_ on this old kernel?!

Anyway, my locking rework only went into 6.7, so this doesn't make sense
in any stable kernel, it's just not required.

johannes

