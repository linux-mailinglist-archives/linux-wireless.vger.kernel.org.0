Return-Path: <linux-wireless+bounces-11838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8C95CA5E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 12:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D923F1F21A2A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 10:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6347149C40;
	Fri, 23 Aug 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BtJzsV7d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A0214B084
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408439; cv=none; b=SKtH66jJvkjlxrg49G5VEk9ZHF6RMT/Y42MnfbDBSQ0FgBMJ3+37GaK5lLnLARKNuYX8is+WwWuNYawa1i7f/g+hNwjyAQMFtZwqUx2xJriC4pb5EFqWv2NCVnl+qNK1w60WKPJrPNNjapp9m8c5wOGcb123AghnWh643ahdDHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408439; c=relaxed/simple;
	bh=zWwcI95JzAc6cGtUIgEjU4iRCYAdyrQm+86TxOQVmlI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PcKkQvKLCZtWlwHulPVjWEQOx0sY67hgNIM8lyIF9AUBhb48Cm/o4js9VFgR7uiCtzqjxfh502iAWBo7kEcuN5jOC3MiqMne7IGAB8wxzsXJKtfl9p/G76JSE63E6EO/CQz1WfEkYYKZfVIfWtVMp7NKx5CDBHgVTaOlOKpQRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BtJzsV7d; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zWwcI95JzAc6cGtUIgEjU4iRCYAdyrQm+86TxOQVmlI=;
	t=1724408438; x=1725618038; b=BtJzsV7dgZ9gqN1/iKmC3BPhyd5s2XZQl2oFGweDhYBoPxK
	KlWGNdGEvv5qKYUE6vQeiQyAjbMzsN4P4L/Astmv1UE2maWLjp/YzlLezWN95DvBcoaZrYi9kb802
	kFjWesbtv28Nym35dJL2qENVN74AWGaVdMA9Wjkn0Pfl4+WfexsctzsVX2SwZcHhPjHbQODnSjauj
	QkZXQKE3soZ2XXxJDk5jxG/V9u4R57Nj1KSIqMgwRSlTEU7GdVN1k3iFF1n5lEs+FXdSC03DezL8T
	d1GQKgGdpIgIcvoptUqF+9mJmqO4p7W5WMvdrBrBri5+eYyvI5MY9Hl9Qlhuvjkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1shRPH-0000000FQis-0cUY;
	Fri, 23 Aug 2024 12:20:35 +0200
Message-ID: <163ebbf7c79d6aece2744be84d88264555f352e9.camel@sipsolutions.net>
Subject: Re: [RFC 5/6] wifi: mac80211: support per-radio filter flags
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Fri, 23 Aug 2024 12:20:34 +0200
In-Reply-To: <7a871d4d2ce7adafb14cf971c1fdeb9cd01a4169.1722885720.git-series.nbd@nbd.name>
References: 
	<cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
	 <7a871d4d2ce7adafb14cf971c1fdeb9cd01a4169.1722885720.git-series.nbd@nbd.name>
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

On Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
> This allows drivers to improve filtering of unwanted packets when using
> different combinations of filter/monitor settings on radios.
>=20

Here, it would seem to make more sense to simply give the necessary per-
interface information to the driver? Drivers likely have more
restrictions and will need less complex data structures (or just
iteration) to figure out what's eventually needed for each hw etc.

Some drivers might anyway even have different filters per interface,
even if they're operating on the same channel.

johannes

