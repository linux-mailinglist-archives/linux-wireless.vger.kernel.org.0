Return-Path: <linux-wireless+bounces-20838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A817A7153C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 12:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450DE18946EE
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 11:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DB419F495;
	Wed, 26 Mar 2025 10:59:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CBA22F01
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986792; cv=none; b=Jg+sR5gNQQdIKNMFhahrsY9R+KocGcUP7zqAr8m1vl5czHiTsIbDsMBsURm1urlx1nlq5TathiiNt3T00iiSeQx1ZLaD8dpwl77POj7eeSac7QacezMDhvKRPFGoPFe108YmSNPHLYw2Qv713x6a8YXFv1MxhMlyFq9tBTmpyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986792; c=relaxed/simple;
	bh=kkjqnVRPCV2DoxeCh4E7Xz9+T1Pv3W2b8jvWw3szNfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNe4LrViaV5Z8+kif3cfeatFylIsMDOsIYwjdfvXoAVc4Bu2Mf50+rQ1uoYIOVM4b34RJgZoe3OZPNwOvB3D6wsE43tHlaVsQtYZ6eFwvZ8b3vxL2cHNJvuDoEIxbT26Qz9SExmL+ooiBUdz9YIhtYvhXWrR7hBph4wX/GAYbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1txOU5-0003ci-0J; Wed, 26 Mar 2025 11:59:45 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1txOU3-001jWl-1t;
	Wed, 26 Mar 2025 11:59:44 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1txOU3-0005SN-2v;
	Wed, 26 Mar 2025 11:59:43 +0100
Date: Wed, 26 Mar 2025 11:59:43 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de
Subject: Re: [PATCH wireless-next v5 10/10] wifi: mwifiex: drop asynchronous
 init waiting code
Message-ID: <Z-PeH1ChtvvYPE7_@pengutronix.de>
References: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>
 <20250324-mwifiex-cleanup-1-v5-10-1128a2be02af@pengutronix.de>
 <Z-MtVj4NpcLuZxJv@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-MtVj4NpcLuZxJv@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Hi Brian,

On Tue, Mar 25, 2025 at 03:25:26PM -0700, Brian Norris wrote:
> Hi Sascha,
> 
> On Mon, Mar 24, 2025 at 02:24:11PM +0100, Sascha Hauer wrote:
> > Historically all commands sent to the mwifiex driver have been
> > asynchronous. The different commands sent during driver initialization
> > have been queued at once and only the final command has been waited
> > for being ready before finally starting the driver.
> > 
> > This has been changed in 7bff9c974e1a ("mwifiex: send firmware
> > initialization commands synchronously"). With this the initialization
> > is finished once the last mwifiex_send_cmd_sync() (now
> > mwifiex_send_cmd()) has returned. This makes all the code used to
> > wait for the last initialization command to be finished unnecessary,
> > so it's removed in this patch.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> There are a few things that confuse me in here. See below.
> 
> > ---
> >  drivers/net/wireless/marvell/mwifiex/cmdevt.c  | 16 ----------------
> >  drivers/net/wireless/marvell/mwifiex/init.c    | 18 +++++-------------
> >  drivers/net/wireless/marvell/mwifiex/main.c    | 25 +++----------------------
> >  drivers/net/wireless/marvell/mwifiex/main.h    |  6 ------
> >  drivers/net/wireless/marvell/mwifiex/sta_cmd.c |  6 ------
> >  drivers/net/wireless/marvell/mwifiex/util.c    | 18 ------------------
> >  6 files changed, 8 insertions(+), 81 deletions(-)
> > 
> ...
> > diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
> > index 8b61e45cd6678..fc58ca1a60ca8 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/init.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/init.c
> > @@ -487,7 +487,6 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
> >  	int ret;
> >  	struct mwifiex_private *priv;
> >  	u8 i, first_sta = true;
> > -	int is_cmd_pend_q_empty;
> >  
> >  	adapter->hw_status = MWIFIEX_HW_STATUS_INITIALIZING;
> >  
> > @@ -509,7 +508,6 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
> >  	}
> >  	if (adapter->mfg_mode) {
> >  		adapter->hw_status = MWIFIEX_HW_STATUS_READY;
> > -		ret = -EINPROGRESS;
> 
> Why are you dropping this line? To be fair, I'm not sure I understand
> all the manufacturing-mode support anyway, but I equally don't
> understand why you're dropping this.

Short version: This change is correct. I started a lengthy explanation
why I did this, but realized that it's better to split this patch
further up to make it more clear. I'll create a new series from this
patch.

> 
> >  	} else {
> >  		for (i = 0; i < adapter->priv_num; i++) {
> >  			ret = mwifiex_sta_init_cmd(adapter->priv[i],
> > @@ -521,18 +519,12 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
> >  		}
> >  	}
> >  
> > -	spin_lock_bh(&adapter->cmd_pending_q_lock);
> > -	is_cmd_pend_q_empty = list_empty(&adapter->cmd_pending_q);
> 
> I believe your reasoning around the synchronous command logic, but would
> it help to include any sort of fail-safe here for the future? Something
> like:
> 
> 	WARN_ON(!list_empty(&adapter->cmd_pending_q));
> 
> ? Or am I being overly cautious?

mwifiex_init_fw() might be called from some obscure firmware command
time out path, so let's add it just to be sure. Better safe than sorry.

> 
> > -	spin_unlock_bh(&adapter->cmd_pending_q_lock);
> > -	if (!is_cmd_pend_q_empty) {
> > -		/* Send the first command in queue and return */
> > -		if (mwifiex_main_process(adapter) != -1)
> > -			ret = -EINPROGRESS;
> 
> You need to update the function comments now that you're dropping this.

Will do.

> > diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> > index f2e9f582ae818..199a8e52e5b16 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> > @@ -2418,11 +2418,5 @@ int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
> >  	ret = mwifiex_send_cmd(priv, HostCmd_CMD_11N_CFG,
> >  			       HostCmd_ACT_GEN_SET, 0, &tx_cfg, true);
> >  
> > -	if (init) {
> 
> The 'init' function parameter is no longer used. Can you drop it from
> the function signature?

Good point. I'll make an extra patch from this though to not further
obfuscate this patch.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

