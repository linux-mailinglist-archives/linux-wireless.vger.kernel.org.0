Return-Path: <linux-wireless+bounces-20890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1256CA72C82
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 10:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97AB3B50AA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3A620B21A;
	Thu, 27 Mar 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="UplFAUBB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BE946BF;
	Thu, 27 Mar 2025 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068005; cv=none; b=r0XBesJt1S5PX2XptubXv/FrJLcL61VNmI+tKzw6afxjUjVUjCAMpMx+rn3Llsi10mJ3Nih9ME8pcsH9nY4LRynRbcN14W6VWR08Mf9e1TzMEIausWMz3o4R0+hLEZu4xvDpyi1G3qHTIZaBZmXx3qeaQ1YKvYNIA3D1Jm9qhaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068005; c=relaxed/simple;
	bh=YNClJrH/6e1Dbh2WpS6rrVYn/ndunKC5gv1xJfe069U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN1FNZK64cU5VD+nz/LFnGzXSHXE5LDTf2x4BkS5YTe2ZE/rXDJyp8+3oT3ZFEJK1WRAOLBPcH64UNe0HZ1XMpLwbhG3IC4qx1pvsmnAiXfmKWXFehmmc79to2hYHQMaHHBBdyZw/k3bgwGuD867YMAKxy1Fr+wdwr4E82pA6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=UplFAUBB; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 59BF41FAC7;
	Thu, 27 Mar 2025 10:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1743067998;
	bh=78GL+QiKQ+5E/NSdfh6mkzgQppQMhSIUOSmEkzEVLQ8=;
	h=Received:From:To:Subject;
	b=UplFAUBBAPfNrEvetkl/PyOlSxnXjzZFTFe7zuyx9KmaKYN3joFaCEkxSTb4/oXkk
	 6RpSbFxaRKYctavYUh5c4C7JEO1Z41/xfuMDFHvLFKG4L25jmtHcWHod3dsa0jnCQR
	 Ci4ogRLz00JVzVBggVFS8SoquZUv1kDrc+qtU4EZHtfUfWsdk+yWulZ3lh6S6PCKes
	 jAbITEiXHe8Wjt9mTvSZa5d+y5MbX2w0rKdvBSYs7Aeh9WGhYSEy9NUPK+9wwXcWOT
	 d81EmE7DBsuVRY3ndM9n8dz1YuHctEivTd845XSfw8YYA8s7eQhm+R3JUvmoAoOu1E
	 Ig+LONXHoidoA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 045E37F9D6; Thu, 27 Mar 2025 10:33:17 +0100 (CET)
Date: Thu, 27 Mar 2025 10:33:17 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH do not merge 4/4] wifi: mwifiex: add iw61x support
Message-ID: <Z-UbXduYmx2i0kxz@gaggiata.pivistrello.it>
References: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
 <20250326-mwifiex-iw61x-v1-4-ff875ed35efc@pengutronix.de>
 <Z-Pxx983jcb0GTtg@gaggiata.pivistrello.it>
 <Z-QHG0fyM8wRy2FH@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-QHG0fyM8wRy2FH@pengutronix.de>

On Wed, Mar 26, 2025 at 02:54:35PM +0100, Sascha Hauer wrote:
> On Wed, Mar 26, 2025 at 01:23:35PM +0100, Francesco Dolcini wrote:
> > On Wed, Mar 26, 2025 at 01:18:34PM +0100, Sascha Hauer wrote:
> > > This adds iw61x aka SD9177 support to the mwifiex driver. It is named
> > > SD9177 in the downstream driver, I deliberately chose the NXP name in
> > > the driver.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/net/wireless/marvell/mwifiex/sdio.c | 79 +++++++++++++++++++++++++++++
> > >  drivers/net/wireless/marvell/mwifiex/sdio.h |  3 ++
> > >  include/linux/mmc/sdio_ids.h                |  3 ++
> > >  3 files changed, 85 insertions(+)
> > > 
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > index cbcb5674b8036..7b4045a40df57 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > 
> > ...
> > 
> > > @@ -3212,3 +3289,5 @@ MODULE_FIRMWARE(SD8978_SDIOUART_FW_NAME);
> > >  MODULE_FIRMWARE(SD8987_DEFAULT_FW_NAME);
> > >  MODULE_FIRMWARE(SD8997_DEFAULT_FW_NAME);
> > >  MODULE_FIRMWARE(SD8997_SDIOUART_FW_NAME);
> > > +MODULE_FIRMWARE(IW612_DEFAULT_FW_NAME);
> > > +MODULE_FIRMWARE(IW612_SDIOUART_FW_NAME);
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
> > > index 65d142286c46e..97759456314b0 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/sdio.h
> > > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
> > > @@ -29,6 +29,9 @@
> > >  #define SD8987_DEFAULT_FW_NAME "mrvl/sd8987_uapsta.bin"
> > >  #define SD8997_DEFAULT_FW_NAME "mrvl/sdsd8997_combo_v4.bin"
> > >  #define SD8997_SDIOUART_FW_NAME "mrvl/sdiouart8997_combo_v4.bin"
> > > +#define IW612_DEFAULT_FW_NAME "nxp/sdsd_nw61x.bin"
> > > +#define IW612_SDIOUART_FW_NAME "nxp/sd_w61x.bin"
> > 
> > Is there a way to have BT over SDIO with iw61x? I was sure only sd-uart was
> > possible.
> 
> The communication to the Bluetooth module indeed is UART only.
> 
> I think nxp/sdsd_nw61x.bin contains firmwares for both the WiFi and
> Bluetooth chip. When using this you can use the Bluetooth UART directly
> without uploading a separate Bluetooth firmware.
> 
> nxp/sd_w61x.bin only contains the WiFi firmware, so you have to
> upload a separate Bluetooth firmware over the UART interface.

If that the case what you did here is not correct.

The 2 firmware files here are used file depending on the BT host interface used
on the Wi-Fi/BT chip, and this is read from some strapping register. See commit
255ca28a659d ("mwifiex: Select firmware based on strapping").

BTW, this name sdsd_nw61x.bin is confusing, I would have expected this to be
something like sduart_nw61x.bin.

Francesco


