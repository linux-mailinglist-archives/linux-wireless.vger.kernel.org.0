Return-Path: <linux-wireless+bounces-12810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A397639E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 09:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A7D1F223CC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A23119005A;
	Thu, 12 Sep 2024 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="lwHuO5VF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D1018F2DD;
	Thu, 12 Sep 2024 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127751; cv=none; b=sKaILYCUiH3NKhTvQsKibgwNb1Zm51dgVfu/K7W+aJ0xzb3GwFYgk86ZqA4SwbTQqrdK8elZVXDKLUIpCzKCSe6rWCRG5FB1QxdQelowUanLZ+26IvXrN9iIUAHtikiY5oalMFU3MjysHn6dA8F9XcNNdkoqSDPnW4E+xQI4i48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127751; c=relaxed/simple;
	bh=geQClFwtO0lCzq0Y87bCnCJe57wFziYtELiZh01kHOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di2ZsavbOaqhQ47fAjNXII5/YBtm3FEnT55d9UP9UUw+RBqcN/UXMDgt5yQnCqU/2ky0sO710cpyTcXZuXwUFQ5mI3E1/SUopZp5s1WRZ3Ebq5MZhnFr/OHJqq/CCPaR5vq+53Z79kWouqdOZTXP2qpX1/iTTn5t9f3UYCUHtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=lwHuO5VF; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id ABF291FA77;
	Thu, 12 Sep 2024 09:55:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1726127742;
	bh=Zpan6h8bj7INMZCVkmwOZr4mGjpE/WUD3f0onl1Rr/A=;
	h=Received:From:To:Subject;
	b=lwHuO5VFejDaGOgB7aHV9BllQWWCeqURUTQ0n84XS0pKrY6ktj9GMT6WKojZgn3Bk
	 /PqC1ZYtkr1G6U6IGlX21TsxVG68JSweov0r9PH3At3FsGsjXrJ40OhMH5avhoU/LA
	 7oHaiqqoNFAGFY17o2sVgIhJub3RFRkLNNUg1yQ1MV2OzaCyl7TEwkUVwMAlHIxVZw
	 h7GyTHq6XON9FjZJble885BjHFOprVEvcxiQKsjWYjYiErR0cMPTF5za6eiWIDs+4w
	 5erCSws8yHOYNviY3L4m+FSEHIb3MkyMHzkiUF4TUvORRY4x5vWTt6V08KQLj79Kw9
	 CYo38U+oyGLJw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 4B27B7F96B; Thu, 12 Sep 2024 09:55:42 +0200 (CEST)
Date: Thu, 12 Sep 2024 09:55:42 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS
 mode
Message-ID: <ZuKefqVotHmOywvF@gaggiata.pivistrello.it>
References: <20240830080719.826142-1-yu-hao.lin@nxp.com>
 <ZuFjtc70r6CGbzcW@gaggiata.pivistrello.it>
 <PA4PR04MB96389DD6C8EC3903CEF01EFFD1642@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96389DD6C8EC3903CEF01EFFD1642@PA4PR04MB9638.eurprd04.prod.outlook.com>

On Thu, Sep 12, 2024 at 02:22:09AM +0000, David Lin wrote:
> > From: Francesco Dolcini <francesco@dolcini.it>
> > Sent: Wednesday, September 11, 2024 5:33 PM
> > To: David Lin <yu-hao.lin@nxp.com>; l.stach@pengutronix.de
> > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> > Hsieh <tsung-hsien.hsieh@nxp.com>
> > Subject: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS mode
> > 
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> > 
> > 
> > +Lucas (in case he missed this patch)
> > 
> > On Fri, Aug 30, 2024 at 04:07:19PM +0800, David Lin wrote:
> > > Firmware crashes when AP works on a DFS channel and radar detection
> > occurs.
> > > This patch fixes the issue, also add "fake_radar_detect" entry to
> > > mimic radar detection for testing purpose.
> > 
> > Do we want such kind of "fake" code in the driver?
> > 
> > I do not agree that we mix an actual bug fix with additional testing code, and if
> > I understand correctly the commit message this is what we are doing here.
> > 
> 
> This file can be used to test this patch on other chips without really radar
> detection from HW.

please move the fake test code to a separate patch so that it can be discussed
separetely from the actual fix

> > > --- a/drivers/net/wireless/marvell/mwifiex/11h.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/11h.c

...

> > > +
> > > +     if (priv->uap_stop_tx) {
> > > +             if (!netif_carrier_ok(priv->netdev))
> > 
> > is this if needed? why? can't you just call netif_carrier_on() in every case?
> 
> If netif_carrier_ok(), there is no need to call netif_carrier_on().

yes, ok. this I know. But it seems not needed, and one line less of code is
better than having one additional useless line of code.

My question is, is it required to have it? for what reason? My undestanding
is that you should just remove it, but maybe I am missing something.

> > > +                     netif_carrier_on(priv->netdev);
> > 
> > 
> > > +             mwifiex_wake_up_net_dev_queue(priv->netdev, adapter);
> > > +             priv->uap_stop_tx = false;
> > > +     }
> > >  }

