Return-Path: <linux-wireless+bounces-35122-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPf9Dvs952no5QEAu9opvQ
	(envelope-from <linux-wireless+bounces-35122-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 11:06:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 924334389B4
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 11:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 062C93055806
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 08:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051D9331203;
	Tue, 21 Apr 2026 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K/sozY+9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB039C000;
	Tue, 21 Apr 2026 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761963; cv=none; b=V6AJzd0JzDV3AHF3M7Ee5eIWTVcue4Kxq9t9k+X/uKo0nFMTH0FyLjO5LTHvBBqoj+a01xdyUpSwn/17aeVlAjc2L0QTm4VsXngEzP43AQVTHzcGkx4m2n+O/v6R2eQPermsLvP/73qRYgAlmtimEwzQSQMCi421qJHkD28pJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761963; c=relaxed/simple;
	bh=J1XYr9r2Q9xuv3Vej9XTSXH7J6VkMPzH3/V08F/9nAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qwxe2j+UoKNUedK+XoS7/MwP30E/sLtpkmPi3oBW+6wQJXJsK9AYiqs4PquvrE/f404jt2/M9ug04bW/o9rvhLevoJAMqJPXuad3ndnyZdT+fWcLv3PNl1tKmdEpjWgORpqW95awnJBXBQS7mW6vhhIKhMgtRMlQDKeTTGrQzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K/sozY+9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=J1XYr9r2Q9xuv3Vej9XTSXH7J6VkMPzH3/V08F/9nAA=;
	t=1776761962; x=1777971562; b=K/sozY+9GBJhIHKMcqSdVb8fbcwCXqQI9+P99GLHirCdzZG
	RWJxhQPwpI61dkR8Kuztdl9RUYLySbhrHoZF9cq+s41/Pr1mcG7cOgvN5ykbpvh+BjRFVxoN3ojwK
	nUGJHjVhMeNh4yLcrCgij9wrRAJkT+Y3VM73twTNbFz0MZa3Tv0aLRyqB+I7j9hrnGxCy7N7YIDmv
	zWW+dKM0S4FF9x/NGL7StfKZYqszoBtBujLGRTKjgfqbPy+5D6j7/W8whQrxPzhq6iqhHRuMG/el/
	V7YmNOVXH5nNeAHOM+pXlE00vTIwcSOk+vHfwXQ3o6izKp37BRxBqkCED1fFuhzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wF6wj-00000004kyw-3B8o;
	Tue, 21 Apr 2026 10:59:05 +0200
Message-ID: <2d6e902083d693cdbb15fc62c6bf92db34fc734a.camel@sipsolutions.net>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
From: Johannes Berg <johannes@sipsolutions.net>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= "(The Capable Hub)"	
 <u.kleine-koenig@baylibre.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, "Christian A. Ehrhardt"	
 <christian.ehrhardt@codasip.com>, linux-mmc@vger.kernel.org, Greg
 Kroah-Hartman	 <gregkh@linuxfoundation.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, 	linux-kernel@vger.kernel.org, Marcel
 Holtmann <marcel@holtmann.org>, 	linux-bluetooth@vger.kernel.org, Matthias
 Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org, Ping-Ke Shih	 <pkshih@realtek.com>,
 linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,  Lorenzo
 Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne
 Chen <shayne.chen@mediatek.com>,  Sean Wang <sean.wang@mediatek.com>, Brian
 Norris <briannorris@chromium.org>, Francesco Dolcini	
 <francesco@dolcini.it>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 21 Apr 2026 10:59:04 +0200
In-Reply-To: <aecu1ixyHP2hQvgE@monoceros>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
	 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
	 <aeaMkfk_1t98e7SU@monoceros>
	 <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
	 <aecu1ixyHP2hQvgE@monoceros>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35122-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,codasip.com,vger.kernel.org,linuxfoundation.org,sang-engineering.com,holtmann.org,gmail.com,collabora.com,lists.infradead.org,realtek.com,nbd.name,mediatek.com,chromium.org,dolcini.it,linux.intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,renesas];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 924334389B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-21 at 10:12 +0200, Uwe Kleine-K=C3=B6nig (The Capable Hub)
wrote:
> >=20
> > We only received 1-3 of the 6:
> >=20
> > https://patchwork.kernel.org/project/bluetooth/list/?series=3D1082520
> >=20
> > Or is this on purpose, and we should consider the set complete?
>=20
> The remaining patches are for wifi. My expectation was that they go in
> via wifi+netdev once the first patch is in their base. But of course I'm
> open for maintainer coordination to let the series go in in less steps
> than I expected. If that helps I can also create an immutable branch,
> but I have no urge here, so if only the first patch goes in during the
> next merge window, I won't have problems to keep track of the remaining
> bits.

It's probably better for everything all around, including the various
automations that test patch series, if you just flip a coin, send these
to either BT or WiFi, and then resend the others later :)

All assuming we get an ACK from whoever is responsible for patch 1 to
merge it through some other tree :)

johannes

