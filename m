Return-Path: <linux-wireless+bounces-32520-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDv7KxqQqWni/gAAu9opvQ
	(envelope-from <linux-wireless+bounces-32520-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:15:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5867F2131DB
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C9E73046AA0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AD7175A79;
	Thu,  5 Mar 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If21Ar/J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693D3A1CD;
	Thu,  5 Mar 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720151; cv=none; b=M5w5q8tSmwoyn0LoTcfzdvafs+Uj5A9h/5jT01+lU9pVb3IYYYuGe1nR1qlkWft42Bx6ohIhyag8jdbsHziAF4WxWkBlMHwNBvZMu+p9qhtFKafJLqzLFVh/G95MIBXDF8rdSXvc18+RzEbjXeCykPO48uyGQb8KMmHEMBARcPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720151; c=relaxed/simple;
	bh=kLWb8VZ+IMnJVdrAXVM1cp3XVDC6P/pyuL00CU9cNh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA8iPFQiAc7wcWrJGSiDvwbrVYliCXxCrVKX80GzQ0LL+32Me4lgWwcdFZccRuKhi/wgrx71t6jKPEy34+UFMm+vN1YEHcFs/uT7chqzyX1nbJXsM6nYnamAvB2dtaC97JJjxen7ohrLDJcq8r81s96YyTDgZkQm1WT//ODkjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If21Ar/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8762FC116C6;
	Thu,  5 Mar 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772720150;
	bh=kLWb8VZ+IMnJVdrAXVM1cp3XVDC6P/pyuL00CU9cNh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=If21Ar/Jhy7PHBtlIIgl5FkbElMU2v+aeeoIy35PuaIvpFzxNu7HK+tQgYOujMzRQ
	 ndQC8HslP+oJ17/lkt3V8HPj2/gS6kSCYb7NiJH1a+2G8Uvgn3ept55O+tAH/FWdeE
	 CltJ1dehHI+MJSzuvGJVKAHRX+daWIy/6bGSJd6+2slpMGPj9jgct55n6E4dBWVr3v
	 wrmvrqDOgQfmcyemQ0g+Xu90oyb42Cgi44w2nxcaZKBOTgu9efxf0k2CzIBgTkAXHl
	 W2MEOK6Y3Lqj7wFGmwcGRGDv4VLlVE4LAIkjBTLGXveqTF1vSGGcfP140N1Tdd6bva
	 DW33Ww3rgQoOQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy9UR-000000001Sf-3y17;
	Thu, 05 Mar 2026 15:15:47 +0100
Date: Thu, 5 Mar 2026 15:15:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Hin-Tak Leung <hintak.leung@gmail.com>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] wifi: rt2x00: drop redundant device reference
Message-ID: <aamQE558h7XK4JME@hovoldconsulting.com>
References: <20260305110713.17725-1-johan@kernel.org>
 <20260305110713.17725-11-johan@kernel.org>
 <20260305133755.GA75655@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305133755.GA75655@wp.pl>
X-Rspamd-Queue-Id: 5867F2131DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32520-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,harvard.edu:email,hovoldconsulting.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 02:37:55PM +0100, Stanislaw Gruszka wrote:
> On Thu, Mar 05, 2026 at 12:07:10PM +0100, Johan Hovold wrote:
> > Driver core holds a reference to the USB interface and its parent USB
> > device while the interface is bound to a driver and there is no need to
> > take additional references unless the structures are needed after
> > disconnect.
> > 
> > Drop the redundant device reference to reduce cargo culting, make it
> 
> Getting the reference in probe() and drop it in disconnect() was not a cargo cult.
> That was requirement from usb_get_dev() comment, that later it was changed
> by below commit:
> 
> commit f6a9a2d64dd168b7d71076c0e6b2be7db7cb7399
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Fri Feb 25 09:38:25 2022 -0500
> 
>     USB: core: Update kerneldoc for usb_get_dev() and usb_get_intf()
> 
>     The kerneldoc for usb_get_dev() and usb_get_intf() says that drivers
>     should always refcount the references they hold for the usb_device or
>     usb_interface structure, respectively.  But this is an overstatement:
>     In many cases drivers do not access these references after they have
>     been unbound, and in such cases refcounting is unnecessary.
> 
>     This patch updates the kerneldoc for the two routines, explaining when
>     a driver does not need to increment and decrement the refcount.  This
>     should help dispel misconceptions which might otherwise afflict
>     programmers new to the USB subsystem.

Yeah, the documentation indeed was misleading for a very long time. That
reference comment even predates the driver model.

Many authors base their work on existing drivers so we still get new
ones that take such references even after the docs were amended.

Johan

