Return-Path: <linux-wireless+bounces-20937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E951A74D77
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 16:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B403A5663
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBBD1C8FCE;
	Fri, 28 Mar 2025 15:10:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46DE1A9B5D
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174637; cv=none; b=X1RyrOMp4AcUmXad2fj/u1MGDWIABKW8Uu4PR/moN63UEt4EXLMTUg9jOOgO/5wtxbyAiLiybZYYyvdnNzKtiMcsODUsNjIrRsI9CqbT2xMsO++1BKsFjI5xhzGFr8SeyZpZ1Op87qOPYs8MgzbssNiJMfLotPLQbO2fY8fie1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174637; c=relaxed/simple;
	bh=vREaxluqoOJihcdAvEAhXC/frbBK3xAmj2NukVk8Crg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uns6VMY9KZEB2NcAtOnen0um+8/FLhTitR+C1Qiymd0v1uAsA+NmApe2eNfV/tsVo2V2I8576dHSDEPDppJJQ4isrQgmg1d+aQWMbNLyobjKUS5yeI2b7CvnfBm0cGoeNr3rg2yrklFNB60rIsCaPU/pSbLwr000/wdICY6GjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1tyBLq-0008Mo-2i; Fri, 28 Mar 2025 16:10:30 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tyBLp-0027Nq-2e;
	Fri, 28 Mar 2025 16:10:29 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tyBLp-003sBp-2I;
	Fri, 28 Mar 2025 16:10:29 +0100
Date: Fri, 28 Mar 2025 16:10:29 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH do not merge 4/4] wifi: mwifiex: add iw61x support
Message-ID: <Z-a75VNI9liliHz1@pengutronix.de>
References: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
 <20250326-mwifiex-iw61x-v1-4-ff875ed35efc@pengutronix.de>
 <Z-Pxx983jcb0GTtg@gaggiata.pivistrello.it>
 <Z-QHG0fyM8wRy2FH@pengutronix.de>
 <Z-UbXduYmx2i0kxz@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-UbXduYmx2i0kxz@gaggiata.pivistrello.it>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Thu, Mar 27, 2025 at 10:33:17AM +0100, Francesco Dolcini wrote:
> On Wed, Mar 26, 2025 at 02:54:35PM +0100, Sascha Hauer wrote:
> > On Wed, Mar 26, 2025 at 01:23:35PM +0100, Francesco Dolcini wrote:
> > > On Wed, Mar 26, 2025 at 01:18:34PM +0100, Sascha Hauer wrote:
> > > > This adds iw61x aka SD9177 support to the mwifiex driver. It is named
> > > > SD9177 in the downstream driver, I deliberately chose the NXP name in
> > > > the driver.
> > > > 
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > >  drivers/net/wireless/marvell/mwifiex/sdio.c | 79 +++++++++++++++++++++++++++++
> > > >  drivers/net/wireless/marvell/mwifiex/sdio.h |  3 ++
> > > >  include/linux/mmc/sdio_ids.h                |  3 ++
> > > >  3 files changed, 85 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > > index cbcb5674b8036..7b4045a40df57 100644
> > > > --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > 
> > > ...
> > > 
> > > > @@ -3212,3 +3289,5 @@ MODULE_FIRMWARE(SD8978_SDIOUART_FW_NAME);
> > > >  MODULE_FIRMWARE(SD8987_DEFAULT_FW_NAME);
> > > >  MODULE_FIRMWARE(SD8997_DEFAULT_FW_NAME);
> > > >  MODULE_FIRMWARE(SD8997_SDIOUART_FW_NAME);
> > > > +MODULE_FIRMWARE(IW612_DEFAULT_FW_NAME);
> > > > +MODULE_FIRMWARE(IW612_SDIOUART_FW_NAME);
> > > > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
> > > > index 65d142286c46e..97759456314b0 100644
> > > > --- a/drivers/net/wireless/marvell/mwifiex/sdio.h
> > > > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
> > > > @@ -29,6 +29,9 @@
> > > >  #define SD8987_DEFAULT_FW_NAME "mrvl/sd8987_uapsta.bin"
> > > >  #define SD8997_DEFAULT_FW_NAME "mrvl/sdsd8997_combo_v4.bin"
> > > >  #define SD8997_SDIOUART_FW_NAME "mrvl/sdiouart8997_combo_v4.bin"
> > > > +#define IW612_DEFAULT_FW_NAME "nxp/sdsd_nw61x.bin"
> > > > +#define IW612_SDIOUART_FW_NAME "nxp/sd_w61x.bin"
> > > 
> > > Is there a way to have BT over SDIO with iw61x? I was sure only sd-uart was
> > > possible.
> > 
> > The communication to the Bluetooth module indeed is UART only.
> > 
> > I think nxp/sdsd_nw61x.bin contains firmwares for both the WiFi and
> > Bluetooth chip. When using this you can use the Bluetooth UART directly
> > without uploading a separate Bluetooth firmware.
> > 
> > nxp/sd_w61x.bin only contains the WiFi firmware, so you have to
> > upload a separate Bluetooth firmware over the UART interface.
> 
> If that the case what you did here is not correct.
> 
> The 2 firmware files here are used file depending on the BT host interface used
> on the Wi-Fi/BT chip, and this is read from some strapping register. See commit
> 255ca28a659d ("mwifiex: Select firmware based on strapping").
> 
> BTW, this name sdsd_nw61x.bin is confusing, I would have expected this to be
> something like sduart_nw61x.bin.

You are right, there seem to be some things mixed up. I'll have a look
into it for the next round.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

