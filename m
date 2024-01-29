Return-Path: <linux-wireless+bounces-2693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F538412BE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89EC1C24856
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143A246A0;
	Mon, 29 Jan 2024 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ix0/jIxO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9201314A82
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554324; cv=none; b=OdL1ONYhGlwdR6WrcweuKDmg2Jj3BRnRkZxJqsDIZCNA5c+jKPLY3F+b93u08n7ODgiSvPTdXUvc7f7G1dRRzzBbMti57ApLI5xUTw+OBjpnEuynR/Q1N5sB3sWQ2wkKIyyFc2MCBvPGzTnRvFgphmdGAU9E9nvosQwI6f//7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554324; c=relaxed/simple;
	bh=ceVf9GYyBqqrULEGj9F/teCIajmWFcbbONWCtlLAiDg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C3W2F7Em3hoPfRpD4d01HEs5I2vmTdaT7KRoLM87msRX/hlYIkcHCmjz6FsR1bY49Bm6T2Ema9f+ia4OOBdVPrXrXia2dV1bNS3bDex8QTkDLlvrt2rS5gtsX2SGp0SXXHqvGa7ohxHc0rvX1ZpM3T9Rmej3kdIRpC+b1h+fAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ix0/jIxO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=419VDm5qMNVMx78c9ZmkX/eUl4HzGObjh3OvL6MWEFA=;
	t=1706554322; x=1707763922; b=ix0/jIxOq9faVyYkJUe2Z0D3rci99pzqMj6myAJ6eY079Xf
	lUAuI1NPOMgDWoFoFHhDNRMz7k2GTj1mH2CRstTMuAQkP2Zoh48GR6kHgtX1xZOuaDSX1u7qdLJ9k
	cHQukGNQB79oTB77MGKAPYZMH5DeXZmIL/j16j4ez94XCmE32G9BOELXdcZYQVrjJHnan+36MepVC
	wbnSGeeA4tABd0j9AxO2haYacI0aDRCXUg+9lxx7p2iuUPxExNU7JOxPRiBt8V781MOSL/9kuhQZ9
	+NMTQatu3lwzRxr/QmZtbDctKAlkKVDAVIh6kO8OplpGSI7XNsjzOSa31wlaCjTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWjg-00000004zcq-0HZY
	for linux-wireless@vger.kernel.org;
	Mon, 29 Jan 2024 19:52:00 +0100
Message-ID: <7e0c33a964ad9c0b569c5363e2d5b70210154a52.camel@sipsolutions.net>
Subject: Re: [PATCH 00/15] wifi: support wider-BW OFDMA and fix puncturing
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Mon, 29 Jan 2024 19:51:59 +0100
In-Reply-To: <20240129184108.49639-17-johannes@sipsolutions.net>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
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

On Mon, 2024-01-29 at 19:34 +0100, Johannes Berg wrote:
>=20
> As part of the refactoring to more clearly determine both local
> and AP mode (HT/VHT/HE/EHT) and channel configuration, this makes
> mac80211 a bit more strict:
>  - no longer accept channel switch when the mode changes
>  - no longer use e.g. VHT if the HT channel inside of it
>    occupies the wrong spot (e.g. center 40 MHz inside 80 MHz)
>  - don't use EHT with bad puncturing (punctured subchannels
>    cover subchannels that are used by HE)
>=20
> Hopefully these things won't really break anything outside of
> a handful of hostapd tests seem misconfigured (e.g
>=20

Err, sorry.

The tests that are broken are mostly because of the first bullet, and we
had fixed this by:
https://lists.infradead.org/pipermail/hostap/2023-December/042218.html
but (IMHO) the justification was bad - I'd still think it's weird to
switch off e.g. EHT completely during CSA, and certainly mac80211 makes
no attempt at tracking this and reacting to it (e.g. updating rate
control to disable EHT rates), which is why I did the change to not
accept it, and disconnect (which should lead to reconnect).

The EHT puncturing tests are broken because of the last bullet, and I
had fixed that in a patch I just sent to the list, but due to the second
bullet those tests are _still_ failing, and I'm not right now sure why.
But I think we can agree that the second and third bullet changes are
reasonable, and the tests need updating.

johannes

