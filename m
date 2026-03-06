Return-Path: <linux-wireless+bounces-32589-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOtHNtmLqml0TQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32589-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:10:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E387A21CE09
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB3A6300C7FD
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0230F808;
	Fri,  6 Mar 2026 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fvl6EEes"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50832248861;
	Fri,  6 Mar 2026 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784596; cv=none; b=BBGYM16kUf2uy/Pa3+3A0V+PMj9+jX0FYboGV5CeaEftHtVIX8jTW5j5fBdCEN2Yzx23dJZmIWO5L1/QPXRUcPGjYbCpqAPNeOJecnIIYdaJMZgBGEsjBHTsLjROu3KmOKKTvsWLnD3moDC+QIDP/+AioBUFXZiFgmixTXA+L4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784596; c=relaxed/simple;
	bh=7NxsDfsuUwNiSa+LOeVnlo/grQUWXwOwpB+OFYuuFuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKyJyYwV0qR4I1ZIdg0pcBLz2HWosLxUc323ys/m3p3omcU3aozQ5HeD0Y7+ebuBL2QGUYyJAg4xWemdceE7unA2w3iMG5cVFxvOgBHoz/jr9WwV5sUEwBx3mPJZcvZUhjqq8KzKic1oQxrfR2rmJ8OdF9RyQftlrb9YdAXuwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fvl6EEes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B60C4CEF7;
	Fri,  6 Mar 2026 08:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772784596;
	bh=7NxsDfsuUwNiSa+LOeVnlo/grQUWXwOwpB+OFYuuFuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fvl6EEesAQfTI61TJFKx+BU9fT1i6qOC7AoMNItjTASkOiDVx3t2em5kctpX3qZ02
	 hGq9nE3h6bmCnLcHHe31i6rD2JA4HY9BYBkdJwbi6ZRl3XL3hp5HsTL+Rr6dxYrPjE
	 tDYrlSeVtrrVUHPz6DSj8Dz6u46uBtAaaHjDivFpBN8vEo+sFF3EV42KODAbvgVD2u
	 NKp6XMxVy0Drw/je3t43B3Q5XhhYOtPsECy6evTZ8xByWzTXIWktvy7q0Wb96VPJyN
	 fMMjEXy+CDiqtXBGBORYoNO/TUObaiR3zRi3S/eTBCw6ztDlpkFf143JqROhx9X67X
	 CgCRWLT/6kV9A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyQFt-000000008IG-1bsd;
	Fri, 06 Mar 2026 09:09:53 +0100
Date: Fri, 6 Mar 2026 09:09:53 +0100
From: Johan Hovold <johan@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>, Stanislaw Gruszka <stf_xl@wp.pl>,
	Hin-Tak Leung <hintak.leung@gmail.com>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/13] wifi: drop redundant USB device references
Message-ID: <aaqL0RdwEjWWjECk@hovoldconsulting.com>
References: <20260305110713.17725-1-johan@kernel.org>
 <0c75afbbe7bb419cab648f94191fe47f@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c75afbbe7bb419cab648f94191fe47f@realtek.com>
X-Rspamd-Queue-Id: E387A21CE09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,wp.pl,gmail.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-32589-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 01:40:31AM +0000, Ping-Ke Shih wrote:
> // +Cc Greg
> 
> Hi Johan,
> 
> Johan Hovold <johan@kernel.org> wrote:
> 
> [...]
> 
> >  drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |  4 ----
> >  drivers/net/wireless/realtek/rtl8xxxu/core.c       | 11 +++--------
> >  drivers/net/wireless/realtek/rtlwifi/usb.c         |  4 ----
> 
> Acked to changes of these Realtek WiFi drivers. But I'd like to know why
> rtw88/rtw89 aren't included in this patchset?

I used a more specific grep pattern to catch driver releasing references
in disconnect() and therefore missed a few that dropped the reference in
helper functions (or used non-standard names for their disconnect
function such as ath10k, I see now).

> Greg sent a patch [1] to
> correct error path of USB probe for rtw88. In the discussion, he also
> mentioned the simplest way is to drop usb_get_dev()/usb_put_dev() like
> this patchset does. Will you share patches for rtw88/rtw89? I so, I'd
> drop Greg's patch and apply yours.
> 
> [1] https://lore.kernel.org/linux-wireless/2026022333-periscope-unusual-f0a0@gregkh/

Sure, I can include rtw88 (and ath10k and ath6kl) in a v2.

Do you really prefer replacing Greg's fix or shall I send an incremental
patch on top?

Johan

