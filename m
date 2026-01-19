Return-Path: <linux-wireless+bounces-30948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7203DD3A2B0
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 10:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E3313060A75
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C954352953;
	Mon, 19 Jan 2026 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tyshM0Ke"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062BD3502A1;
	Mon, 19 Jan 2026 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814199; cv=none; b=Aiif9uQ1KPqmBHkmgIPincXT7PLWwM+Mc5HZcExkoQ2hxwr3LrF2lFGDAfkyPwstC3ujpL+9ssdbml1cp6K7OQn3/lFKzcUBi5DJtP+BErXqi+OhcFf64ZTOuQlJoiEBXJcEW4NsbLJ12jPHkPuFYAZy4qQNXvhNXDEWgtDzyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814199; c=relaxed/simple;
	bh=qI2Ohpg8npT1EmYrIcDlLaFm2nqAz2Jvcs6dbDFlUlk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K/Lpc/HSRWPiNhz88GdWqBMkO+RqyRMZdvNzP5B9T6vAqHck7JEno8d5iXLMOudG5M4mXTRdYa5BzMo39P+qt3MsbG2UaG59GWOL8+uOMtCmK7S+vxfkCUdnN4E/VvdT6zzC5zWLIf3juSvg2XGwBKOVwEGDvDldbCMMEUvHHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tyshM0Ke; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qI2Ohpg8npT1EmYrIcDlLaFm2nqAz2Jvcs6dbDFlUlk=;
	t=1768814198; x=1770023798; b=tyshM0KeFEpvSzcZv3h3E9WgkAtKTMWB6t/qm9lx3q+jqHx
	QyunDT3WgV2dOenvfrsxRPlB+o7z0YjDOprXtPwJ7A5t1JPLHvSUwoXCzkC32nyMfNoJUsCHQHAF0
	F5Ev2nF2xBHl9Hs+bxScXEp9rwEwTYE2TJ7JBwLrAMaRAgDMUYvl3A9+mbQ78W82O2c053I3POBJK
	fhgXTvka6Si1EsjSI6thBAwNMOTg/eTyCDmgVwa+dzGvy+fyOCSpLK4LNakZywNwi/HgkPRXOzgfQ
	HZskEzqFcnAvlOQJKWqd1AVxa5oGhkDQn1OJS0aq0Rzrz36qeRFDmge1fqQIZiXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vhlND-0000000FpD8-2kga;
	Mon, 19 Jan 2026 10:16:35 +0100
Message-ID: <0a7ae8fb2ccd37ff64d6f45089e46ff3f95fcc67.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
From: Johannes Berg <johannes@sipsolutions.net>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org
Date: Mon, 19 Jan 2026 10:16:35 +0100
In-Reply-To: <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com> (sfid-20260112_164714_040401_1B7336B9)
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
	 <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
	 (sfid-20260112_164714_040401_1B7336B9)
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

On Mon, 2026-01-12 at 16:46 +0100, Uwe Kleine-K=C3=B6nig wrote:
> To prepare sdio drivers to migrate away from struct device_driver::shutdo=
wn
> (and then eventually remove that callback) create a serdev driver shutdow=
n
> callback and migration code to keep the existing behaviour. Note this
> introduces a warning for each driver that isn't converted yet to that
> callback at register time.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Ulf, could you send an ACK for taking this through wireless?

Thanks,
johannes

