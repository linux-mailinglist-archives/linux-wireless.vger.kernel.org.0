Return-Path: <linux-wireless+bounces-21919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D2A98D6C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D30F7A4BC0
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651E127F751;
	Wed, 23 Apr 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="e0KNbBIt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612327F739;
	Wed, 23 Apr 2025 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419354; cv=none; b=VAdRCkV7LltFIh+RRe5D6gLmJAjHVVRX9K9UDvlj6iWADZBcLRmC3Y3Mn6WSL4I7wO12CiFWrkHzjdbbtpR6kfp98emL2a7+2Y4S8OjqxekcVj+GHDnXTUJChCF+elGYyu7Iof9SoXvHivIXl0IyoBwpsEAWr2at/CR3Lo16ueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419354; c=relaxed/simple;
	bh=vwxAWQTi9Y0WTKETG0R7OlHjGBeP8e6NtBdiui/TOtY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TEKq7BRR8aCULjiOug4d2qsOR4W760IMzt+fHxKh57DZTtkiPqdtI7sXAvHPdiX2pKGV/grMNu9rcvhXE4ykrlM/LiOWcQBvN35h6cdZKxW1rhfOWRXECgtQw60D813VR5QtKlpbd+KJX7B0euwiYkWGpIWjqBJOz1/9ztYkmN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=e0KNbBIt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vwxAWQTi9Y0WTKETG0R7OlHjGBeP8e6NtBdiui/TOtY=;
	t=1745419352; x=1746628952; b=e0KNbBItdIdjNC2ZDCKFR1vrTN61Xe1pk76YYgZcnWgPz7X
	iQWPCgAgGdsFo9P7lYpY1u+w18+5kPdDab2wyK0XTpl6nxg6D0a+CV+Ek/3Ah0/GGGa1ytdDwwB1G
	CMrmrKyns1bbmlhhjXUG2KSBySth1U/C/O2eIo/Fgwu84ypY3g5b0VbWJGhGpvNpseVKvUCpMnSNB
	eAh2aip7ynlszN+0uDToQLDNE+D/jVrJtlGltLvG9gqvsellHzF2QlzTLqunDWXVifRz99Eqt8EIu
	8YPug7WGdBXm8D+dHqJHQ77NDh0QrXHxbsWTRg+M7jIkeSPLgKFWthCQrrjiRq4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7bIy-0000000Eknu-2CVg;
	Wed, 23 Apr 2025 16:42:28 +0200
Message-ID: <0f2108af922f17a371b33b94226e64e6e308c7ec.camel@sipsolutions.net>
Subject: Re: [PATCH iw,v2 3/3] iw: fix EHT capabilities on Big Endian
 platforms
From: Johannes Berg <johannes@sipsolutions.net>
To: Aleksander Jan Bajkowski <olek2@wp.pl>, ilan.peer@intel.com, 
	christopher.a.wills@intel.com, slakkavalli@datto.com, john@phrozen.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Apr 2025 16:42:27 +0200
In-Reply-To: <20250405184807.701728-4-olek2@wp.pl>
References: <20250405184807.701728-1-olek2@wp.pl>
	 <20250405184807.701728-4-olek2@wp.pl>
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

On Sat, 2025-04-05 at 20:48 +0200, Aleksander Jan Bajkowski wrote:
> IE fields are encoded in Little Endian and are not correctly
> printed on Big Endian platforms.
>=20

I applied some other patches, and this didn't apply any more. Please
rebase and resend.

I did apply the other two.

johannes

