Return-Path: <linux-wireless+bounces-10931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E975A947645
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956EF1F21FF5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 07:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1672F149C79;
	Mon,  5 Aug 2024 07:37:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20C149C6A
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843424; cv=none; b=QBFCyIbF++9Hzss1ZjcGx+T1UBd3HsS8SQ8BO+Qji47j9Z3bPHV0c3mQCtpfNBcviZ17foNQJFjaYRpd/7Yi4rP2nWatuT9GsvTQ9FTe5pNTbZX/pKk75dxZEJK7qspHXIKbrth+3UhHz3mttPf/eU1AqdBvDjVo8cksIkYGMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843424; c=relaxed/simple;
	bh=ZDCH0MsOIW5acnq6//DJ0jeEXhTquVaL3h+Uok16Er8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7wOGbPq5P43AXF/ZCuxm+3V1VVFWkNDHFqMZoeZQUZQFgTxv+MVcYwqIaP1AtzWWS9nOevvPnjeCkDEs1yMWDDlXrDBxRmySpYuX7txAUFaXcv9t9GyaeIWMkFkwkid/rBL8s0y2gl1bGWi2YId7rngFOVV/V1xXsha9957GSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sasH3-0003dK-CG; Mon, 05 Aug 2024 09:36:57 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sasH2-004ekJ-Jl; Mon, 05 Aug 2024 09:36:56 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sasH2-002x7E-1c;
	Mon, 05 Aug 2024 09:36:56 +0200
Date: Mon, 5 Aug 2024 09:36:56 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v3 1/3] wifi: mwifiex: simplify WPA flags setting
Message-ID: <ZrCBGA29KbqkTgJU@pengutronix.de>
References: <20240723-mwifiex-wpa-psk-sha256-v3-1-025168a91da1@pengutronix.de>
 <172276187336.2804131.2752806886332298409.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172276187336.2804131.2752806886332298409.kvalo@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Sun, Aug 04, 2024 at 08:57:54AM +0000, Kalle Valo wrote:
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > The WPA flags setting only depends on the wpa_versions bitfield and not
> > on the AKM suite, so move it out of the switch/case to simplify the code
> > a bit. Also set bss_config->protocol to zero explicitly. This is done
> > only to make the code clearer, bss_config has been zero alloced by the
> > caller, so should be zero already. No functional change intended.
> > 
> > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > Acked-by: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> There were conflicts on wireless-next, please rebase.

Thanks for noting. Just sent out a v4.

I realized the host-mlme patches are merged in wireless-next. I had them
in my tree anyway already, so the necessary changes looked all familiar.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

