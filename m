Return-Path: <linux-wireless+bounces-12681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DC0971F6B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 18:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC621F225D3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE42165EE8;
	Mon,  9 Sep 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="fDAcWZDQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209D1758F;
	Mon,  9 Sep 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900146; cv=none; b=jXAOiWAWJEpUPD/HTL5prgrL7QUC4EJV/uRJTWCEZIw7pu0l5tVBl5aiuoDDVLhrGot2IbbGsyKXNrqsVGmPLXXLacJgmWvRdAqrSWn/+i9sEVJQpDWQrij/xsRNZn728vtgsxO7es7S2rGaIVv3ydwW1Q0oHhGdm2l7lSwuT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900146; c=relaxed/simple;
	bh=XTZTLbfkrFn8eGE+mb01dKeACFbL9fsMmu/AoZt0qjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QP4EfDmEAShukxBdft6N9ihGJo0/p/0fj8YFk1m/EL3g+SYBxOD4JxAtDHJxYAxm2UeycwqrSjcnat8cdj+CZV9ZbSAFwGKzKbh4McuwkZEn/a5CVHR691WcrdjOU9NOsQ1398fKrnamKjjPL6SEhDNtUN99LkulEJq2vhQ076o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=fDAcWZDQ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id D17AB1F920;
	Mon,  9 Sep 2024 18:42:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725900139;
	bh=F4Z0ciAphJr4eiTAbYQt1G1nPVPW+UUp+e88qVm1zN0=;
	h=Received:From:To:Subject;
	b=fDAcWZDQzEAsns2xWVsDs6vPob1bDsIm/eV4hZdYvVOJKXTspY9XLDKI1IkTqMu/C
	 fmcP6ZcFHLnWrKkR2JKImcDszcqrtross/tskIleyPU+s8N/LEJXtISgIvKvdmh48e
	 OLC8zZQjf5c5CwyruEsI8wOeRe61ct1NITqrFkQDr4Ys1PTFJZu/eMmFuIn9PBZxH4
	 xM61JFrsMHThJrSyQq1OkC4EB8TgvxiHsv5o+SSrRWUqi90f9/AcLNVzM64HKrA+4b
	 +bZUw/RdGgV0vb29UKjDByaw05bI1u2kndJ7zMCR2e+eBPftO4QAmad0bbiSxOKCzF
	 zfbzT587qZeUA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 83AAD7F94E; Mon,  9 Sep 2024 18:42:18 +0200 (CEST)
Date: Mon, 9 Sep 2024 18:42:18 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>, David Lin <yu-hao.lin@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 02/12] wifi: mwifiex: fix MAC address handling
Message-ID: <Zt8lat15eNgnPm6x@gaggiata.pivistrello.it>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-2-56e6f8e056ec@pengutronix.de>
 <20240906144036.GA45399@francesco-nb>
 <Zt6tPcCI5Ov81md8@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt6tPcCI5Ov81md8@pengutronix.de>

On Mon, Sep 09, 2024 at 10:09:33AM +0200, Sascha Hauer wrote:
> On Fri, Sep 06, 2024 at 04:40:36PM +0200, Francesco Dolcini wrote:
> > On Mon, Aug 26, 2024 at 01:01:23PM +0200, Sascha Hauer wrote:
> > > The mwifiex driver tries to derive the MAC addresses of the virtual
> > > interfaces from the permanent address by adding the bss_num of the
> > > particular interface used. It does so each time the virtual interface
> > > is changed from AP to station or the other way round. This means that
> > > the devices MAC address changes during a change_virtual_intf call which
> > > is pretty unexpected by userspace.
> > 
> > Is this the only reason for this patch or there are other reasons?
> > I'd like to understand the whole impact, to be sure the backport to
> > stable is what we want.
> > 
> > > Furthermore the driver doesn't use the permanent address to add the
> > > bss_num to, but instead the current MAC address increases each time
> > > we do a change_virtual_intf.
> > > 
> > > Fix this by initializing the MAC address once from the permanent MAC
> > > address during creation of the virtual interface and never touch it
> > > again. This also means that userspace can set a different MAC address
> > > which then stays like this forever and is not unexpectedly changed
> > > by the driver.
> > > 
> > > It is not clear how many (if any) MAC addresses after the permanent MAC
> > > address are reserved for a device, so set the locally admistered
> > > bit for all MAC addresses modified from the permanent address.
> > 
> > I wonder if we should not just use the same permanent mac address whatever
> > the virtual interface is. Do we have something similar in other wireless
> > drivers?
> 
> Yes, there are at least four driver that generate different MAC
> addresses for different vifs:

Ok, fine for me. It seems like there is some real use case requiring to have
different MAC addresses for each virtual interface, and given that mwifiex is
already like that, we should keep it that way.

It would be interesting to know from NXP if they do provide some guidance on
this topic to whoever is using their chips or the reality is what you
implemented here that we cannot assume anything on how many MAC addresses are
available is just the way it is.

David?

> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  drivers/net/wireless/marvell/mwifiex/cfg80211.c |  4 +-
> > >  drivers/net/wireless/marvell/mwifiex/init.c     |  1 -
> > >  drivers/net/wireless/marvell/mwifiex/main.c     | 54 ++++++++++++-------------
> > >  drivers/net/wireless/marvell/mwifiex/main.h     |  5 ++-
> > >  4 files changed, 30 insertions(+), 34 deletions(-)
> > > 
> > ...
> > 
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> > > index 96d1f6039fbca..46acddd03ffd1 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/main.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> > > @@ -971,34 +971,16 @@ mwifiex_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
> > >  }
> > >  
> > >  int mwifiex_set_mac_address(struct mwifiex_private *priv,
> > > -			    struct net_device *dev, bool external,
> > > -			    u8 *new_mac)
> > > +			    struct net_device *dev, u8 *new_mac)
> > >  {
> > >  	int ret;
> > > -	u64 mac_addr, old_mac_addr;
> > > +	u64 old_mac_addr;
> > >  
> > > -	old_mac_addr = ether_addr_to_u64(priv->curr_addr);
> > > +	netdev_info(dev, "%s: old: %pM new: %pM\n", __func__, priv->curr_addr, new_mac);
> > >  
> > > -	if (external) {
> > > -		mac_addr = ether_addr_to_u64(new_mac);
> > > -	} else {
> > > -		/* Internal mac address change */
> > > -		if (priv->bss_type == MWIFIEX_BSS_TYPE_ANY)
> > > -			return -EOPNOTSUPP;
> > this was the only usage of MWIFIEX_BSS_TYPE_ANY, correct? Did it had any
> > reason before?
> 
> I haven't found a path to get here with priv->bss_type ==
> MWIFIEX_BSS_TYPE_ANY. This function is called from

Ok, so maybe we can kill the MWIFIEX_BSS_TYPE_ANY in this patch also?

> > > @@ -1364,10 +1366,6 @@ void mwifiex_init_priv_params(struct mwifiex_private *priv,
> > >  	priv->assocresp_idx = MWIFIEX_AUTO_IDX_MASK;
> > >  	priv->gen_idx = MWIFIEX_AUTO_IDX_MASK;
> > >  	priv->num_tx_timeout = 0;
> > > -	if (is_valid_ether_addr(dev->dev_addr))
> > > -		ether_addr_copy(priv->curr_addr, dev->dev_addr);
> > > -	else
> > > -		ether_addr_copy(priv->curr_addr, priv->adapter->perm_addr);
> > 
> > With this change, when mfg_mode is true, priv->curr_addr will be not
> > initialized. Wanted?
> 
> Not wanted, just me being ignorant. Let's have a look:
> 
> priv->adapter->perm_addr is initialized in the response handling of the
> HostCmd_CMD_GET_HW_SPEC command. This command is only issued when
> mfg_mode is false, so in mfg mode priv->adapter->perm_addr will be the
> zero address.
> 
> The only documentation we have for mfg_mode is:
> 
> manufacturing mode enable:1, disable:0
> 
> I don't know what this really is about, but I could imagine that this
> is for initial factory bringup when the chip is not parametrized and thus
> doesn't have a permanent MAC address yet.

Not sure even myself, but I would advise to not break it.

Francesco


