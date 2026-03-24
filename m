Return-Path: <linux-wireless+bounces-33767-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNtuG7hQwmnNbgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33767-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 09:52:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF613050E0
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 09:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 005BC3051143
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A035F3D6CBA;
	Tue, 24 Mar 2026 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSTjXfxN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB63D6CA2;
	Tue, 24 Mar 2026 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341912; cv=none; b=Rq//TCDG1ecVblE7Q5nwq+HbjHfjguyQjXiF6tV8+1ozN/2k2kb4gaK26a6WG2tSup0YYqmVKtcMZT+sEI6fjooEOEyrs3Y0hTaJhrBRCSf3mBhkuGUJGncELtdXatPi2ICE8/L9133/U6vltlbV3sgegYGSJPVXi9EV/GSzCTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341912; c=relaxed/simple;
	bh=goMkGC7BolvvE8+pUGBAzX/lhVatTopqaC3j1nsm1Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plusgyP8+FehPjFYl6jOXx/Ek+PMbNT90qX37WT65h3+9ZTQ2KmFgGZEejizXjmSYv4UL4bjQiwlcMFbR52GtS9WzI7lXsmY/s8WJEQyGMZVgUpbUlL8NXoj1qGdA9eZnQ8Rr98/sx2uzKSJm2vFgVnfmw3cD9/MIXZ+tJAV4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSTjXfxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9259C19424;
	Tue, 24 Mar 2026 08:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774341911;
	bh=goMkGC7BolvvE8+pUGBAzX/lhVatTopqaC3j1nsm1Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSTjXfxNWd5zJBYeTLHp9rxIe/dbWQxQfASoZYJClBDVrXG4sHbJMdpLhsMdSPuS5
	 +jmsKdy7bnhc3V/S7JuZe2WE4oUA2hQKE5fiRKgbC2eiEDFtR2knJk7CY+/4u5+a49
	 0f1ySzA+HbydlAID8Yk4SfJXVSHseFuvzWLGGpNDk0nrWq/9Sk6/Xz+9qgP0bq1rzF
	 3ww+Niqra3R8b60JiTMyNa8nTv1tV6sRrpWHfIQ8LAWzp9s+gEQ1NlkkUzTbgPVnsk
	 jS36aMlw17Llm9j4+ZDCKV1uW4UXNBc0ayX6tocQXawUB4YR7ezQHD+0m3q5fPbACI
	 aR7thkDgUhTFA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4xNt-00000003nBl-1Fam;
	Tue, 24 Mar 2026 09:45:09 +0100
Date: Tue, 24 Mar 2026 09:45:09 +0100
From: Johan Hovold <johan@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] wifi: drop redundant USB device references
Message-ID: <acJPFZ9ysArtg5aM@hovoldconsulting.com>
References: <20260306085144.12064-1-johan@kernel.org>
 <acJL3c5J6sT59sjx@hovoldconsulting.com>
 <923278a6deae44f4bec8bc2ede1022a1@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <923278a6deae44f4bec8bc2ede1022a1@realtek.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,toke.dk,chromium.org,dolcini.it,nbd.name,mediatek.com,wp.pl,gmail.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33767-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EBF613050E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 08:40:10AM +0000, Ping-Ke Shih wrote:
> Johan Hovold <johan@kernel.org> wrote:
> > On Fri, Mar 06, 2026 at 09:51:26AM +0100, Johan Hovold wrote:
> > > Driver core holds a reference to the USB interface and its parent USB
> > > device while the interface is bound to a driver and there is no need to
> > > take additional references unless the structures are needed after
> > > disconnect.
> > >
> > > Drop redundant device references to reduce cargo culting, make it easier
> > > to spot drivers where an extra reference is needed, and reduce the risk
> > > of memory leaks when drivers fail to release them.
> > 
> > > Johan Hovold (18):
> > 
> > >   wifi: mt76: drop redundant device reference
> > >   wifi: mt76x0u: drop redundant device reference
> > >   wifi: mt76x2u: drop redundant device reference
> > >   wifi: mt76: mt792xu: drop redundant device reference
> > >   wifi: mt7601u: drop redundant device reference
> > 
> > All of these are now in linux-next except for the five Mediatek fixes.
> > 
> > Could someone pick them up as well? Not sure which tree they'd usually
> > go through.
> 
>   wifi: rtl818x: drop redundant device reference
>   wifi: rtl8xxxu: drop redundant device reference
>   wifi: rtw88: fix device leak on probe failure
> 
> Realtek WiFi got merged into my tree (not in linux-next yet), and I plan to
> send pull-request to wireless tree before 7.1 merge window. 

Yes, sorry, I forgot to mention that. I got a message about these having
been picked up so I didn't include them in the list above. Thanks.

Johan

