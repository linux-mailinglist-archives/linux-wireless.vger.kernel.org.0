Return-Path: <linux-wireless+bounces-8881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC5D905330
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 15:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7D15B22D29
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 13:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E717799B;
	Wed, 12 Jun 2024 13:04:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C328176AD4
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197452; cv=none; b=ERzJXXvR0nMY/Bh3If//7VSSLiiVRZ2DUH75r2H98hM2nFthmvf5XtJUgF7b+Fjoicpk0VKigin3wh9W4FBu8WzUbmCAC9mKArgaoSbo9LRu4OvOheApdIZolObk/cWdMc6SJ+EgHhjIkb+9J1l281auabrUwrby1USh9H5z8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197452; c=relaxed/simple;
	bh=OsXaaGOBhD19JYLTP3o3NcrZQzURqDDVdkeF/tStYCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es/bRt0NnymIic8xH4/SwQu76QzdMm4sB/zrKqvVsuOBafVOeZrCkWIbIQJQYbDCrPexPCEvaOeDm0IlK+ui+X6u1xgdjcU3BRTVPp92+Ciwj32/jI7eS8rpeKKqKiHi1mQFJp2ogzzH2GWa7YTptGCVKfwNbwUi1Men0xoowhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sHNdu-0007qM-Bf; Wed, 12 Jun 2024 15:03:58 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sHNdt-001nHG-F9; Wed, 12 Jun 2024 15:03:57 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sHNdt-006Yzr-1D;
	Wed, 12 Jun 2024 15:03:57 +0200
Date: Wed, 12 Jun 2024 15:03:57 +0200
From: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"yu-hao.lin@nxp.com" <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: increase max_num_akm_suites
Message-ID: <ZmmcvUM9mjBSf7-6@pengutronix.de>
References: <20240530130156.1651174-1-s.hauer@pengutronix.de>
 <171767674666.2401308.2539321240473169281.kvalo@kernel.org>
 <Zmaq-4whltVgrzCz@pengutronix.de>
 <bd519d27dbe5c239d621072f96f67e371e552a74.camel@toradex.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd519d27dbe5c239d621072f96f67e371e552a74.camel@toradex.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Jun 11, 2024 at 01:12:26PM +0000, Marcel Ziswiler wrote:
> Hi Sascha
> 
> On Mon, 2024-06-10 at 09:27 +0200, Sascha Hauer wrote:
> > On Thu, Jun 06, 2024 at 12:25:48PM +0000, Kalle Valo wrote:
> > > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > 
> > > > The maximum number of AKM suites will be set to two if not specified by
> > > > the driver. Set it to CFG80211_MAX_NUM_AKM_SUITES to let userspace
> > > > specify up to ten AKM suites in the akm_suites array.
> > > > 
> > > > Without only the first two AKM suites will be used, further ones are
> > > > ignored.
> > > > 
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > I assume you that you have also tested this on a real device, right?
> > 
> > Sure. It was tested with a MAYA-W161-00B module from u-blox with a IW416
> > chipset.
> > 
> > BTW I haven't mentioned this, but It fixes the same problem as mentioned here:
> > 
> > https://lore.kernel.org/linux-kernel/20240523081428.2852276-1-s.hauer@pengutronix.de/T/
> 
> As we are also using the IW416 albeit from the MAYA-W160-00B module on our Verdin AM62, we were wondering about
> the exact use case this patch helps solving. Could you reveal some more details around this? Thanks!

You'll need this patch once wpa_supplicant specifies more than two akm
suites in the key_mgmt (in AP mode).

With the current mainline driver using NetworkManager to setup a hotspot
with:

nmcli device wifi hotspot con-name leica ssid mywifi band bg password hallo123

NetworkManager ends up setting the key_mgmt option to 'WPA-PSK WPA-PSK-SHA256'.
These are two entries and this works fine.

However, when the patches adding host mlme support are applied (see
https://lore.kernel.org/lkml/Zk6TklTIbxZxIWyb@google.com/T/),
NetworkManager will set key_mgmt to 'WPA-PSK WPA-PSK-SHA256 SAE'. These
are three entries and thus exceed the current array size of two. The
effect is that SAE is ignored by the driver and SAE is not enabled in
the device.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

