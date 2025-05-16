Return-Path: <linux-wireless+bounces-23067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6E8AB97D8
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 10:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52000173D0D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 08:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EDC282E1;
	Fri, 16 May 2025 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QSacQf/D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41EA22D79D
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384805; cv=none; b=ac+Jz1tC40VmVjrHk0e6NbPPzjAfg6CChrwpljmYKBlORuexJEcKoR1O0lLvAyyYYZnAcPYBMg8P601jAAeXUNaWaQWw1NH4b0a3JOIbeFuQXPea2ChMHhTi0WYFOTkZhyI4m/n3dID/IRiIB2xrYjf4L/KJb4nMflx03OMmfD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384805; c=relaxed/simple;
	bh=D/vcx0T8Wm6d6LkYLzXU1+uYEAFhQNRD8Jt2HTPvkWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=edZVVxozt1WexAOk3U7rYxDxJNunIGDQk+F9MGDjF08D9YM9YFMSnuvN5UOGPbq7yGSiTXzX5+nXj6r5WqLcoWRix11v8uqTN+S1ax2iawmVSsrxhlYfR9vyblTOIOKvJj5Vw8rbK9z8UhAzhOLzBXaGD8S4nrI52EtI9JKTzgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QSacQf/D; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=D/vcx0T8Wm6d6LkYLzXU1+uYEAFhQNRD8Jt2HTPvkWI=;
	t=1747384804; x=1748594404; b=QSacQf/DjG27g2LTh5kRy1NqDj1ErKjLEWecME5E/O29Icw
	eO8Eg0TqmLkITUsAbd5wEAwjwcP8UlrwKJ2Jm7kmQKUMs/dCN11ORN8H29AzKfOj3yYeDdpaxUia5
	NLioSTN1zjP//VT+QenZcp+/i0/5p65/ODia+d0dV4mFP2sKMPTYS5OE1hMk9RbMOvZgYl8Ha6Fr4
	iUlWRM4J27Ftx1Dn79LOJdHM8QIpf4QM4MStcsZnHYK4hyshA5o/KThr9PD0On0LZ20XJKQen131u
	DyfoShBg0XEV0WU/SV1PHzb2RHjMTW3SHIYMtZsm8M9gshfpPNsXtPIiVIX1j/7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFqbo-0000000E7Yb-0qC6;
	Fri, 16 May 2025 10:40:00 +0200
Message-ID: <cfb672d2ed996756c6e5a7e493f161767f376b31.camel@sipsolutions.net>
Subject: Re: wireless-regdb: Wrong ETSI tranmit power without TPC
From: Johannes Berg <johannes@sipsolutions.net>
To: wens@kernel.org, Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Date: Fri, 16 May 2025 10:39:59 +0200
In-Reply-To: <424fc6a24f3af233fc70296b9995a97c2d7f9e17.camel@sipsolutions.net>
References: <aBoK6p1+F5ve1rC6@FUE-ALEWI-WINX>
		 <CAGb2v676sXN_eC9s6_2a6k2ACzf3n5jBgY_id22ruoz+Zb-Jaw@mail.gmail.com>
	 <424fc6a24f3af233fc70296b9995a97c2d7f9e17.camel@sipsolutions.net>
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

On Fri, 2025-05-16 at 10:38 +0200, Johannes Berg wrote:
>=20
> So to be _really_ precise you'd end up with 1W reduced by 3dB which of
> course _is_ precisely 27dBm since 1W is 10^30 or precisely 30 dBm.
>=20

Obviously 1W isn't 10^30, the latter is just a large number. I meant to
write

1 W is 10^(30/10) mW

johannes

