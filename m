Return-Path: <linux-wireless+bounces-10113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6692B49D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 12:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06912856B2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A93312E1F1;
	Tue,  9 Jul 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AsUHgypZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D33148FED
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519321; cv=none; b=Y8AlPHEDKO356CBWCcljhBpnnuobSa83s8wQESbJmhQQ0xKHYBflLWCu5IIBwC0lG9mfKpd6cKpkbX7RHnMw6toAWQTpuSPqXAh+NslPX09K6buYT1s4K5bXvlzUMI9ORubArXKI+b9y4vC04N9J4n6iv2VJ0GC2V+xUfVFO47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519321; c=relaxed/simple;
	bh=mKw/X3rakTLwl7xlKQB6vLe7abnjXvv1D9OQhTF2yTE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g0ID2ZqEuKTXOO/upNCxGSngj/v7S+rz9+vDFO6ytkWGu5z3BemVrT9TLn+Dv/zYKovUCBV32hFz5Qe0GoJ4SZP1hUcQvEusW6dXApJnKK3d3HBCfhfGR45vkIN+pq2D6D64SJ+BJWbrAwS2C1qymkdl6LQ5T1qMFXsgRh2uNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AsUHgypZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mKw/X3rakTLwl7xlKQB6vLe7abnjXvv1D9OQhTF2yTE=;
	t=1720519295; x=1721728895; b=AsUHgypZcZbVgzSqUBp4FIsahAUkxfq1G0DvDKwsQoCNSx7
	/NKFynlKvxIYttzC8UY9VLJOUvRn6Hllwqd5YxVsqSIuf3Locxnoraio5xJwkwusQbtak/hhQt9d1
	fPblgSItzaAKLdRzyscHqmGe3r8iXVLmgjmVr+IqwtCKWrWh39jS88y7b4wFB+Yz5lZlFRV2ZaKN2
	RxRgmgXlbQf4kx57acvZYdMijVm/2dnkF8abfvdhr4UpI8S7hCkIsoQA3rg42P48XyUJWwN5l2Rrm
	qAfzxUT13m3pHM/YOHxII3+JOief2yD2j3k/eyHP3ijWh/nskv17vEaw4AH+RMXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sR7f1-0000000E06O-3W8b;
	Tue, 09 Jul 2024 12:01:24 +0200
Message-ID: <8253112ae7680260f7c396edb40a65b9ba491763.camel@sipsolutions.net>
Subject: Re: [PATCH v2 8/9] wifi: mac80211: handle
 ieee80211_radar_detected() for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 09 Jul 2024 12:01:22 +0200
In-Reply-To: <fb93e262-d250-4d19-84dc-28cf893d4a21@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
	 <20240626045216.3754013-9-quic_adisi@quicinc.com>
	 <9cf07d0861d6c8ee8a2004361a37a3ebb9860ea9.camel@sipsolutions.net>
	 <8079de14-ef9d-454f-862f-704dac821ee3@quicinc.com>
	 <3ad1b0c648ce1757a06fceafc371d7b8d14fff33.camel@sipsolutions.net>
	 <03731b8e-16f7-4ca0-a720-c41c296efa23@quicinc.com>
	 <fb93e262-d250-4d19-84dc-28cf893d4a21@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-07-09 at 14:24 +0530, Aditya Kumar Singh wrote:
>=20
> So, I was trying as discussed above but I see concurrency issue now.
>=20
> In order to mark or let's say to iterate over *all* ctxs (in case NULL=
=20
> is passed by driver), that part of code ideally should be under wiphy=20
> lock right? But ieee80211_radar_detected() is called in an interrupt=20
> context. Hence, can not take wiphy lock there :(

Not necessarily, ieee80211_iter_chan_contexts_atomic() also iterates
with RCU protection, for example.

johannes

