Return-Path: <linux-wireless+bounces-27179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD537B4AD1B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 14:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E461188C438
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3597D32BF40;
	Tue,  9 Sep 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="trduvV8S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3F1990A7;
	Tue,  9 Sep 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419266; cv=none; b=Ndkytqad6vpGoGJOgY1tVTCf8+BYTZKgKKF6N6YZghTiZIu/+G6SobF4Q029a9yoDfRaeH0w56rUACTWwyJPLlFAYoHbs46N8OnTIqkUXnIJ6ZdRvilySM+NtzC2uVsK2FMONp8F85kPxVHdmJ3NuJLPfgAnFUD1ziUUltCnV6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419266; c=relaxed/simple;
	bh=GsRw9kcoqC0RweQ17HhBaWV8BGWXyQ0tiZcO3Mpi2bM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r1CVx0YntQqMEGjSiY7+bozY/1HHQvhTrNn5bcge+g3aj3MX42K/hYT4mj0gsWMZfcxHwF2YXIC+pB11afBCcfBjFkuTDBz3kBOoLlmM2GXBq/sML51GdEcMx8Yc2Ee4yalO83tCTovZVsI/AE75FPVY2BdT9s6/cZ36co2ok6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=trduvV8S; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GsRw9kcoqC0RweQ17HhBaWV8BGWXyQ0tiZcO3Mpi2bM=;
	t=1757419263; x=1758628863; b=trduvV8SN1ymoYOq31qNKqp9Kip85OQRevWiw23owiuHwya
	+gupfSZoX/uJ47bXf9i88u5LhotNrYsMtSI4R7abXRSy1f08TxpnsywPvJmZBjiZYQtf3/Fb77wLV
	3jkDg6OVYY2WPDL4hZJ+xV26qK9hmu4CvA7Lv1XfxQ1NJ9NuhjWxm2943MGXagAUD+z96PNzHCiy5
	5/+sZMB0ASzmCziYkFrV7rozXKY/A3UbFSkmmSU9dicnAJ2sdk1cVvXvP+UTURmOhRCIndfQ6fGry
	nUZgW428Xe4pubE6e1buG5LXGDLIwJ2ID1Jr0bW1JuwLCIP2W0phZl99HkMP/DkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvx1v-0000000AEYk-3AwV;
	Tue, 09 Sep 2025 14:01:00 +0200
Message-ID: <c536fa6aa022e50fb849b84cc33443ade7f53930.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Fix page fault in
 __cfg80211_connect_result()
From: Johannes Berg <johannes@sipsolutions.net>
To: James Guan <guan_yufei@163.com>
Cc: kuba@kernel.org, kuniyu@google.com, shaw.leon@gmail.com,
 kees@kernel.org, 	linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 09 Sep 2025 14:00:59 +0200
In-Reply-To: <20250909063213.1055024-1-guan_yufei@163.com>
References: <20250909063213.1055024-1-guan_yufei@163.com>
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

On Tue, 2025-09-09 at 14:32 +0800, James Guan wrote:
> When I attempted to connect to a virt_wifi device using iw on 6.17-rc5,
> a page fault occurred in __cfg80211_connect_result(), preventing successf=
ul
> connection.
>=20
> The page fault is triggered because virt_wifi_connect_complete() sets
> requested_bss to NULL when no BSSID is specified.
>=20
> This patch fixes the bug by adding a check for a NULL connected_addr
> before calling ether_addr_copy() in __cfg80211_connect_result().

That might fix the bug, but it makes no sense to have a connection
without an address of the AP that you connected to ...

johannes

