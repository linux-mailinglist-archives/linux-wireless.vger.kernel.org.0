Return-Path: <linux-wireless+bounces-60-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821157F7A7E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 18:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BF31C208B7
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F662420D;
	Fri, 24 Nov 2023 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wFkjBfit"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB63A1718
	for <linux-wireless@vger.kernel.org>; Fri, 24 Nov 2023 09:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WNoD89qGwLzNSjDgM6xaCrjt5Baga6tTZowmVPzed5c=;
	t=1700847347; x=1702056947; b=wFkjBfitE2WAAMDS0W+qtIvPnirN9Bwki/lsEZJ9TsG4LO8
	0RSg5AmlpJcoKN2CpTGajqbSD0jgJ7wOzRqkOtkQzhpTv4JFq0CzCdGiZxfFUPmmW/UyX7EIdzDG1
	OzydW7tiL2bMGg8X/1MC2wI7fIEJd7Z9kunF3gk7sZB1bOCGf5L/b3vnxdCabH4jg5vCWwXV15dbJ
	FbCczTM7iSRW0RjfNt7xyopzNbwLFZI6wVbpx31KwsgqLZ3I6Lvcgi1+TJ3vwez6B3JNMwz6QBc1N
	4iOB7c6U+kWl2opAHH55vUGZolgfA8bLxCs8tytGuFXe15UskLKrViBMNFH9Tqvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6a5g-00000002hEP-1q7Z;
	Fri, 24 Nov 2023 18:35:44 +0100
Message-ID: <bc97ce4621415537ce181b23a6f07a4eda385f6f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Rename bssid to peer_addr in
 cfg80211_pmksa
From: Johannes Berg <johannes@sipsolutions.net>
To: Anuj Khera <quic_akhera@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 24 Nov 2023 18:35:43 +0100
In-Reply-To: <20231120062450.8023-1-quic_akhera@quicinc.com>
References: <20231120062450.8023-1-quic_akhera@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-11-20 at 11:54 +0530, Anuj Khera wrote:
> The cfg80211_pmksa structure uses bssid member to store
> the PMKSA for a BSS in Station mode. Change the name of
> structure member bssid to peer_addr so that same member
> can be used to store the PMKSA for a station in AP mode
> using station MAC address.
>=20
> Signed-off-by: Anuj Khera <quic_akhera@quicinc.com>
> ---

Please tag your patches with a version, and document the changes between
them.

>   *
> - * @bssid: The AP's BSSID (may be %NULL).
> + * @peer_addr: The AP's BSSID (may be %NULL) in case of Station mode. Th=
e STA's
> + *      mac address (may be %NULL) in case of AP mode.
>=20

"MAC address", I guess?

And the "may be %NULL" really makes zero sense in AP mode, who are you
going to have the entry for?!

It barely even makes sense in client mode.

johannes

