Return-Path: <linux-wireless+bounces-31017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF388D3C5CC
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 11:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F583749C49
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9343D2FE2;
	Tue, 20 Jan 2026 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uD/2eMjE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971023D7D73;
	Tue, 20 Jan 2026 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904964; cv=none; b=Mh08wlW8Lv7N2HhpsSBtdXvZrSkt8/oJZzGDz1d8odS54uFmmYI5bCMJX0jxKYIzi05AVGqZRSK4yj5qHCk+UevQL3IF6CB2IhOHgCHNPNh8dg4oclo80Rin/TgTNoC+EF4PKmmOPX3U7J39JBtdSS2LCgcqSijfjnbKFJ8QcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904964; c=relaxed/simple;
	bh=dNjJ9BTo9hkfegYpdM7F3eNNFh+MOmTlbyHa3NowPMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2y/0oA3F1Dgsgz5AObde8SbamU2glmdUhzscAAdvhEv9wxHPz+pT3tKG2ilzxnN8KytvLb+LZUassMEQt1Hq1GqRclyErSzq/hddwp91Q65cfCSq/z2tTB2gJ4rxiIMU0HGYU1ELx5LGu5NcXNJBG1wkDKWNvpEmWtw+coWAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uD/2eMjE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dNjJ9BTo9hkfegYpdM7F3eNNFh+MOmTlbyHa3NowPMY=;
	t=1768904962; x=1770114562; b=uD/2eMjEcbp1z+P8CkZYyU61LYYEz7F5xW4rB+qxJnOR1F4
	OAzmp7V/xpSzcPLpalRK3evtQJnk+dEQMmzg0RYNEhdb5TicmBqZeQbCsgUnkyZZUUXNshVusv46i
	DF4WC1aLzmmaMumRwrJ8aw2aBUnISLdZ8yzLSUukh1x+9iukZXl9n6RNRElE9Rls5oL8XB8GfPYkS
	jdeDgsVJ6zpCAK1QgDU1AzqXRBRH7uQG2CC2OKCcYqXkdVGspCwYkr+3AgmSiGW6IKO/U4zUfw23L
	+z1KaBF51UpDaT1UflMpw93AbhPaLx84QD101uiY3rCcvioU/3EJ77LpwW1gPRag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vi8z9-0000000Gkdf-1aaG;
	Tue, 20 Jan 2026 11:29:19 +0100
Message-ID: <55737e5864d4f6bf66b9827832a2b981c1529e97.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
From: Johannes Berg <johannes@sipsolutions.net>
To: Ulf Hansson <ulf.hansson@linaro.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Date: Tue, 20 Jan 2026 11:29:18 +0100
In-Reply-To: <CAPDyKFrinbj0QdL4rAP7zCvcnc6kGRQDTbiq1H0nRd+-B+HWnw@mail.gmail.com> (sfid-20260120_112749_071466_3438B9E1)
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
	 <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
	 <CAPDyKFrinbj0QdL4rAP7zCvcnc6kGRQDTbiq1H0nRd+-B+HWnw@mail.gmail.com>
	 (sfid-20260120_112749_071466_3438B9E1)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-01-20 at 11:27 +0100, Ulf Hansson wrote:
> On Mon, 12 Jan 2026 at 16:47, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >=20
> > To prepare sdio drivers to migrate away from struct device_driver::shut=
down
> > (and then eventually remove that callback) create a serdev driver shutd=
own
> > callback and migration code to keep the existing behaviour. Note this
> > introduces a warning for each driver that isn't converted yet to that
> > callback at register time.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>=20
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> Johannes, please pick this via your tree. And sorry for the delay in
> reviewing this!

Will do, no worries at all, thanks!

johannes

