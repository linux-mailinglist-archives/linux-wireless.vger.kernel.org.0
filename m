Return-Path: <linux-wireless+bounces-34525-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMr/Omxp1mnIEwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34525-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 16:42:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC0A3BDCD9
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 16:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB9EB3009162
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3853B27CD;
	Wed,  8 Apr 2026 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHpi+jex"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396483876CA;
	Wed,  8 Apr 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659168; cv=none; b=F6rw1rsaiJEDCPGJ2oV/ViwEa0gG9V53BnecgjfSwZWrTqBhXYKM28FTJb5J0y6NZ8GA/C80Dy8swJq8JDwQOp2n/bsys+1NaJcHPNrPzfxt5rBkJtxmGvZu8ov/cjEWtqQMmHRIhjI5qZYkfxESPm1b7Yo538APgVilTKhXItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659168; c=relaxed/simple;
	bh=WDVQUSJZJti5I83uQQI0nyEhlm5REOmLdet9XTkvQCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0ZaVDvwM+7YhvrL2mZpHcqd9iwtYG6zQxXQYXuEpB86m4oHZ0a6Dl0IPk/hpWTo1wBMoR95c2YZnf6mr5rtmGzjpHa78dqkWw75iJ+xxV02Eu3NDzirgDTsSgZM/DHj569lvrvH/QZR68K9vLfVxl6JVcaEltSNHVTISKNpiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHpi+jex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09BEC19421;
	Wed,  8 Apr 2026 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775659167;
	bh=WDVQUSJZJti5I83uQQI0nyEhlm5REOmLdet9XTkvQCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHpi+jexiL4h2pCgODqOxk+UWVGUc0bqDHGxK6L3q8r0YxV9Dkn6qTHmars9/PuD5
	 YfNeoCWn+pIrfPkNRPM8mV7suXdzGboJ+Q6RwGBU0DgZUF7WFdEMbol+US8lVR8Fv+
	 fXaWksS6qNIng0tX7bfyR3LGtt4NZIp3E/DQcbfRqOuDSJMO0CbCg9hnuqA37HTV0a
	 M/PIO+mNPYw9Drj1KnhJPCaHcgf68pqWpPdIUq7iOzLs8NyIQdESDPCIy0WtKjo+Xs
	 n+ruhQ0g1BPosh8enVXXDRa2vMx/19SJEBLN2/mBLgoTkNGlIoQlNN6orbTEp2GQZ4
	 KsFWA3CE4REKw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAU3x-00000000obw-0W8c;
	Wed, 08 Apr 2026 16:39:25 +0200
Date: Wed, 8 Apr 2026 16:39:25 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Felix Fietkau <nbd@nbd.name>
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>, Stanislaw Gruszka <stf_xl@wp.pl>,
	Hin-Tak Leung <hintak.leung@gmail.com>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] wifi: drop redundant USB device references
Message-ID: <adZonQ10NQqRI4_V@hovoldconsulting.com>
References: <20260306085144.12064-1-johan@kernel.org>
 <acJL3c5J6sT59sjx@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acJL3c5J6sT59sjx@hovoldconsulting.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34525-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,toke.dk,chromium.org,dolcini.it,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 5EC0A3BDCD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 09:31:25AM +0100, Johan Hovold wrote:
> On Fri, Mar 06, 2026 at 09:51:26AM +0100, Johan Hovold wrote:
> > Driver core holds a reference to the USB interface and its parent USB
> > device while the interface is bound to a driver and there is no need to
> > take additional references unless the structures are needed after
> > disconnect.
> > 
> > Drop redundant device references to reduce cargo culting, make it easier
> > to spot drivers where an extra reference is needed, and reduce the risk
> > of memory leaks when drivers fail to release them.
> 
> > Johan Hovold (18):
> 
> >   wifi: mt76: drop redundant device reference
> >   wifi: mt76x0u: drop redundant device reference
> >   wifi: mt76x2u: drop redundant device reference
> >   wifi: mt76: mt792xu: drop redundant device reference
> >   wifi: mt7601u: drop redundant device reference
> 
> All of these are now in linux-next except for the five Mediatek fixes.
> 
> Could someone pick them up as well? Not sure which tree they'd usually
> go through.

It's been two more weeks (and these haven't shown up in linux-next) so
sending another reminder.

Can someone please pick these up for 7.1?

Johan

