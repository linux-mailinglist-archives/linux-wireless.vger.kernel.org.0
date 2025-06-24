Return-Path: <linux-wireless+bounces-24422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C2CAE63BC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 13:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164444A12E6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 11:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1922288538;
	Tue, 24 Jun 2025 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="a2PQwmjn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5101F3B9E
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765246; cv=none; b=WbKnZdTSAul/EBf0ft7+uA8ftACuwV2pDsNuUDRH4gMt+MqjjtDvj3TeCvJL4wH1rjXxXoFZTq6CktAoPKgHRZlabcg085veBg9fbBZKJe86m2PH+Z7wpi3X7TRgMRzUN7E+MuUogAML7L8UXh1pTu5fB7HbB32MD7iEqBfOQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765246; c=relaxed/simple;
	bh=zvinYU9B1ZgrNHjRhHC0X8jo9fgCUmx4Wmw7LLQKTF8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uyc4vp2Vky+PkoUsGha34QQuKZgWUNMt7KIxG3jwAZ/+nZRE93c+dDA9w6nLJiq0suz9mgnUnCIKblqh1zEVjNqVERZ79k57SOeMixmEMF56nOv7s1HYsfgP5ecq+QWjo6szH+BCItiC6DII8NtxmLrg0VBS4JS3aS/RfCeW97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=a2PQwmjn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IiW1Y6nq6J0mDP49jBUoaV5f/M9C0ZQ7msa0aa8i1e0=;
	t=1750765245; x=1751974845; b=a2PQwmjnsi95+xBuaVzsOUxmzKN5eYtU5kgQqTyBKVyQF6r
	0gX6dpLq5tuKOJ4zKUUOvcq7n6BibyJ/YV88ZV26EgKwP9sOJKdv+ynkYeZDXxzc7o6AXFweTj7Oj
	z9H8IGaJc0fgU4JUm9viikUa/Ctt8Mg6NaagjdRuQril00jbMwUlPnpZU7UHYVViddoXNJT6oPIRl
	WjrtJ2SqQ3h6ViMM5PQfC0e0f6syeeK8RwnNntxVt46YXODLZJtxIzWVet+XS91qyo43UZTpdGA15
	cU62pUwgV85PAu6SIbDAERE3l8Ztd5BtqmWrrEr0De/ZLmVn4oAbDiEbPThTK0Pg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uU214-00000008nNP-07go;
	Tue, 24 Jun 2025 13:40:42 +0200
Message-ID: <ae46cc4ffc3ec8c776f70c4c61031d82ffdc4be0.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v10 00/10] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 24 Jun 2025 13:40:41 +0200
In-Reply-To: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
References: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-05-28 at 11:14 +0530, Sarika Sharma wrote:
> Current implementation of NL80211_CMD_GET_STATION does not work
> for multi-link operation(MLO) since in case of MLO only deflink
> (or one of the links) is considered and not all links.
>=20
> Hence, add the link_sinfo structure to provide infrastructure
> for link-level station statistics for multi-link operation(MLO).
>=20
> Additionally, accumulated stats for MLO are included in a concise
> manner to provide a comprehensive overview of the ML stations.
>=20
> V10:
>  - Add WARN_ON_ONCE(!link_sinfo), if valid links.
>  - Fixed kernel doc error.
>  - Corrected logic for setting sinfo->valid_links only if memory is
>    allocated for link_sinfo.
>=20

I'm going to apply this because we're at v10 and I'm losing track of all
the changes etc., but while looking through it now, here are a couple of
things I think you/we should still change:

 - We already require a call to allocate TID stats, I think it'd make
   sense to also do that for link stats, instead of allocating _all_ of
   them always. The cfg80211_link_sinfo_alloc_tid_stats() could go away
   in favour of cfg80211_sinfo_allocate_link() that gets an argument
   'bool tidstats' to allocate (or not) TID stats with it

 - I still don't like patch 7, I think that should be a WARN_ON_ONCE or
   so and the producers shouldn't be creating that in the first place,
   otherwise reading the mac80211 code is misleading since you don't
   even get that data. Also the producers shouldn't even _have_ valid
   data for these values.

 - What about TX statistics, we still have these patches:
   https://lore.kernel.org/linux-wireless/20241218232519.3156080-1-greearb@=
candelatech.com/
   which is still needed, right?

johannes

