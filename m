Return-Path: <linux-wireless+bounces-7766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554808C80E9
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 08:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10211282E4A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C721B134BF;
	Fri, 17 May 2024 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tk+gIjdr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B4A134A6;
	Fri, 17 May 2024 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715927135; cv=none; b=CDC+OMVSYHrEjggq5ct3byF/0CdJYcx3dBbjRj+2ntJeCtDvO2eNYoiM0boo9iBaS8KnMgZ4SDUHF/STHvdb8HzwRMoYcM2NIEq8eaLcSqGmkRl/iafQIZ5jaoKBx/ApGSy2HL7d9zKWmZvVnPrQE4ZcnoViz7eIzNXQ4OrQAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715927135; c=relaxed/simple;
	bh=qt28qpGihbsLNTy0QXcH6ifyS6+qu1VlVPg9r03RQhY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yoto5i5D+3PU4geFUPi1iG+Y0m1VIdZQ7+m/70HpksE81gSOipgozfIFwhHMkyxKgjoXbYvsBEDrs5s8M0b8g+UUqYd6BckJyOo2QRpljqdecci3kSv9hGTTNA3HakZRxdZXWqY9fldqDJMZBbTMMXLWzOGXcoAfWwFo/v25x1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tk+gIjdr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qt28qpGihbsLNTy0QXcH6ifyS6+qu1VlVPg9r03RQhY=;
	t=1715927132; x=1717136732; b=tk+gIjdrr8g9u5ZUUYdHSRIKOd4JG17w4s2NoFRnogztVV8
	S0z2JARR68+V3lgZQMwqEV6BV94SQiGHcBEaBo0axNfx7WXFf3i2jYS2L3tw2uNaEEuHJkDVUMpN9
	xtkZNLERmiwppVIegzpN4Cbr6f/3593ecjYD0ukSmZP8yXNDwvrFXZ1AJS9u+8FtFQcZK1Xbz7hZ7
	0Fx/B11q+/jiy3h6ESPl1Ldz3PAKI6W0EGDz7TpLRkMSYOC9XRD3mBlFG5GSkJue0JHn3EowTprP9
	aeX5ujB0cKzkWn1y3cEkg4Tvmd1HOrUVQi8xdALnCMIqHAHFpxZFhn4txBm0OGAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s7r1p-0000000AVQj-3PVg;
	Fri, 17 May 2024 08:25:18 +0200
Message-ID: <e2363a1ca932cf1534f9f006e6cf4f30a8c7a0cd.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: mac80211: Avoid address calculations via out
 of bounds array indexing
From: Johannes Berg <johannes@sipsolutions.net>
To: Kenton Groombridge <concord@gentoo.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, keescook@chromium.org, 
 linux-hardening@vger.kernel.org
Date: Fri, 17 May 2024 08:25:16 +0200
In-Reply-To: <20240517002352.12717-1-concord@gentoo.org>
References: <20240517002352.12717-1-concord@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-05-16 at 20:23 -0400, Kenton Groombridge wrote:
> req->n_channels must be set before req->channels[] can be used.
> Additionally, memory addresses after the "channels" array need to be
> calculated from the allocation base ("request") instead of the first
> "out of bounds" index of "channels" to avoid a runtime bounds check
> warning.

Thanks. Can you please drop the cfg80211 parts from this to match the
subject, the code there is broken in other ways too, I have a fix for
all of that:
https://patchwork.kernel.org/project/linux-wireless/patch/20240510113738.41=
90692ef4ee.I0cb19188be17a8abd029805e3373c0a7777c214c@changeid/

johannes


