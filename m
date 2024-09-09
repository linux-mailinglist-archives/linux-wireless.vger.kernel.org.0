Return-Path: <linux-wireless+bounces-12641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 427ED97114B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 10:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A86F3B22E33
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 08:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91E51B14E1;
	Mon,  9 Sep 2024 08:09:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033811B1439
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869381; cv=none; b=sid4XaGqSuR/U1T1YDQ7OywyQNUKpJcn0NHDZV++GDCQY5631FnkTi/vDT2qFLkmG2Q4K7y7lH02IJgB/rEykW4MDQit1JN1WtCb4wTIf/e6fTFzsEAk1UvcEsDTQqA4sM4PStHlk+ku9ZK3aTMkuQ4Rayw1djx1AHswPCmrGVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869381; c=relaxed/simple;
	bh=1SrsKOmljKg1dqS9QP+GyyaTXlt3wvv/Srb1oslrWE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UawqrFjA16ZX21T8htgCECdveYaiDXUzamOdT5srThWW6iIBwkeKQN4rMjxA72x63Dz3PlrDv9d6CYbixsFgtvL27ENx5k/ruEojRzWnSPyzRnUtlMHIv3sH4smmnxyxkvVM7oY2IKby849ji0RW83/sysekxsHpRDMGAHStsUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1snZSo-00062r-7P; Mon, 09 Sep 2024 10:09:34 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1snZSn-006bZL-Ea; Mon, 09 Sep 2024 10:09:33 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1snZSn-00Fcqb-17;
	Mon, 09 Sep 2024 10:09:33 +0200
Date: Mon, 9 Sep 2024 10:09:33 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/12] wifi: mwifiex: fix MAC address handling
Message-ID: <Zt6tPcCI5Ov81md8@pengutronix.de>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-2-56e6f8e056ec@pengutronix.de>
 <20240906144036.GA45399@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906144036.GA45399@francesco-nb>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Fri, Sep 06, 2024 at 04:40:36PM +0200, Francesco Dolcini wrote:
> On Mon, Aug 26, 2024 at 01:01:23PM +0200, Sascha Hauer wrote:
> > The mwifiex driver tries to derive the MAC addresses of the virtual
> > interfaces from the permanent address by adding the bss_num of the
> > particular interface used. It does so each time the virtual interface
> > is changed from AP to station or the other way round. This means that
> > the devices MAC address changes during a change_virtual_intf call which
> > is pretty unexpected by userspace.
> 
> Is this the only reason for this patch or there are other reasons?
> I'd like to understand the whole impact, to be sure the backport to
> stable is what we want.
> 
> > Furthermore the driver doesn't use the permanent address to add the
> > bss_num to, but instead the current MAC address increases each time
> > we do a change_virtual_intf.
> > 
> > Fix this by initializing the MAC address once from the permanent MAC
> > address during creation of the virtual interface and never touch it
> > again. This also means that userspace can set a different MAC address
> > which then stays like this forever and is not unexpectedly changed
> > by the driver.
> > 
> > It is not clear how many (if any) MAC addresses after the permanent MAC
> > address are reserved for a device, so set the locally admistered
> > bit for all MAC addresses modified from the permanent address.
> 
> I wonder if we should not just use the same permanent mac address whatever
> the virtual interface is. Do we have something similar in other wireless
> drivers?

Yes, there are at least four driver that generate different MAC
addresses for different vifs:

drivers/net/wireless/ath/ath6kl/cfg80211.c:3816
drivers/net/wireless/ath/wil6210/cfg80211.c:732
drivers/net/wireless/microchip/wilc1000/netdev.c:983
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:606

(line numbers match 6.11-rc6):

For the mac80211 based drivers there are also tricks played to use
unique MAC addresses in ieee80211_assign_perm_addr().

For reference in mwifiex setting different MAC addresses for different
interfaces goes down to:

| commit 864164683678e27c931b5909c72a001b1b943f36
| Author: Xinming Hu <huxm@marvell.com>
| Date:   Tue Feb 13 14:10:15 2018 +0800
| 
|     mwifiex: set different mac address for interfaces with same bss type
| 
|     Multiple interfaces with same bss type could affect each other if
|     they are sharing the same mac address. In this patch, different
|     mac address is assigned to new interface which have same bss type
|     with exist interfaces.
| 
|     Signed-off-by: Xinming Hu <huxm@marvell.com>
|     Signed-off-by: Kalle Valo <kvalo@codeaurora.org>


> 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/net/wireless/marvell/mwifiex/cfg80211.c |  4 +-
> >  drivers/net/wireless/marvell/mwifiex/init.c     |  1 -
> >  drivers/net/wireless/marvell/mwifiex/main.c     | 54 ++++++++++++-------------
> >  drivers/net/wireless/marvell/mwifiex/main.h     |  5 ++-
> >  4 files changed, 30 insertions(+), 34 deletions(-)
> > 
> ...
> 
> > diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> > index 96d1f6039fbca..46acddd03ffd1 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/main.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> > @@ -971,34 +971,16 @@ mwifiex_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  }
> >  
> >  int mwifiex_set_mac_address(struct mwifiex_private *priv,
> > -			    struct net_device *dev, bool external,
> > -			    u8 *new_mac)
> > +			    struct net_device *dev, u8 *new_mac)
> >  {
> >  	int ret;
> > -	u64 mac_addr, old_mac_addr;
> > +	u64 old_mac_addr;
> >  
> > -	old_mac_addr = ether_addr_to_u64(priv->curr_addr);
> > +	netdev_info(dev, "%s: old: %pM new: %pM\n", __func__, priv->curr_addr, new_mac);
> >  
> > -	if (external) {
> > -		mac_addr = ether_addr_to_u64(new_mac);
> > -	} else {
> > -		/* Internal mac address change */
> > -		if (priv->bss_type == MWIFIEX_BSS_TYPE_ANY)
> > -			return -EOPNOTSUPP;
> this was the only usage of MWIFIEX_BSS_TYPE_ANY, correct? Did it had any
> reason before?

I haven't found a path to get here with priv->bss_type ==
MWIFIEX_BSS_TYPE_ANY. This function is called from
mwifiex_init_new_priv_params() and mwifiex_add_virtual_intf(). Both
functions set priv->bss_type to something else or bail out with an error
before calling mwifiex_set_mac_address(). It's also called from the
ndo_set_mac_address method, but for a registered net device the bss_type
should also be set to something meaningful.

> 
> > -
> > -		mac_addr = old_mac_addr;
> > -
> > -		if (priv->bss_type == MWIFIEX_BSS_TYPE_P2P) {
> > -			mac_addr |= BIT_ULL(MWIFIEX_MAC_LOCAL_ADMIN_BIT);
> > -			mac_addr += priv->bss_num;
> > -		} else if (priv->adapter->priv[0] != priv) {
> > -			/* Set mac address based on bss_type/bss_num */
> > -			mac_addr ^= BIT_ULL(priv->bss_type + 8);
> > -			mac_addr += priv->bss_num;
> > -		}
> > -	}
> > +	old_mac_addr = ether_addr_to_u64(priv->curr_addr);
> >  
> > -	u64_to_ether_addr(mac_addr, priv->curr_addr);
> > +	ether_addr_copy(priv->curr_addr, new_mac);
> >  
> >  	/* Send request to firmware */
> >  	ret = mwifiex_send_cmd(priv, HostCmd_CMD_802_11_MAC_ADDRESS,
> > @@ -1015,6 +997,26 @@ int mwifiex_set_mac_address(struct mwifiex_private *priv,
> >  	return 0;
> >  }
> >  
> > +int mwifiex_set_default_mac_address(struct mwifiex_private *priv,
> > +				    struct net_device *dev)
> > +{
> > +	int priv_num;
> > +	u8 mac[ETH_ALEN];
> > +
> > +	ether_addr_copy(mac, priv->adapter->perm_addr);
> > +
> > +	for (priv_num = 0; priv_num < priv->adapter->priv_num; priv_num++)
> > +		if (priv == priv->adapter->priv[priv_num])
> > +			break;
> > +
> > +	if (priv_num) {
> > +		eth_addr_add(mac, priv_num);
> > +		mac[0] |= 0x2;
> > +	}
> 
> Please see my concern on this in the beginning of the email.
> 
> > @@ -1364,10 +1366,6 @@ void mwifiex_init_priv_params(struct mwifiex_private *priv,
> >  	priv->assocresp_idx = MWIFIEX_AUTO_IDX_MASK;
> >  	priv->gen_idx = MWIFIEX_AUTO_IDX_MASK;
> >  	priv->num_tx_timeout = 0;
> > -	if (is_valid_ether_addr(dev->dev_addr))
> > -		ether_addr_copy(priv->curr_addr, dev->dev_addr);
> > -	else
> > -		ether_addr_copy(priv->curr_addr, priv->adapter->perm_addr);
> 
> With this change, when mfg_mode is true, priv->curr_addr will be not
> initialized. Wanted?

Not wanted, just me being ignorant. Let's have a look:

priv->adapter->perm_addr is initialized in the response handling of the
HostCmd_CMD_GET_HW_SPEC command. This command is only issued when
mfg_mode is false, so in mfg mode priv->adapter->perm_addr will be the
zero address.

The only documentation we have for mfg_mode is:

manufacturing mode enable:1, disable:0

I don't know what this really is about, but I could imagine that this
is for initial factory bringup when the chip is not parametrized and thus
doesn't have a permanent MAC address yet.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

