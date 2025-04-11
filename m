Return-Path: <linux-wireless+bounces-21445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE39A85DFB
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A2D188E062
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA881372;
	Fri, 11 Apr 2025 12:57:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD312367D4
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376272; cv=none; b=FgUPL6BsltqY4vzlsNiMRfnWiBHjN5mcFPsDkhVutX5XGjmne78pGesELPQ7hqx8dB/AmHyDsf0wWVewOIli0tMOQCgZ3H0eW6ZdoT/YDjZw08QtCMMwigw9M5gXKQNylYFZLeRm8Eimx9Ho7LaPnr0pH4TF872nrosJ0et+nvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376272; c=relaxed/simple;
	bh=LQKOCWyQX+lu6GEisO5U8La28x9X0NK43vOcDfrEYLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3847wEZffBSFnw8D++oRmFxhqVt7cQyZRalgBsR98Ya9qZefng3Q8FRJVCgaBZy1QbBLjGU797JqRTXIJ1D3PgZJjT1svImZtli3cZY85zeOA70HdXx6GP8Vu9O+5PrQPESMCFLXGJKlmJmtarOsUfldhD6exBoAp39F0aVFhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1u3Dx5-0000GB-Ah; Fri, 11 Apr 2025 14:57:47 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1u3Dx5-004R2J-06;
	Fri, 11 Apr 2025 14:57:47 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1u3Dx4-00CGid-2y;
	Fri, 11 Apr 2025 14:57:46 +0200
Date: Fri, 11 Apr 2025 14:57:46 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>, linux-wireless@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] wifi: mwifiex: drop asynchronous init waiting code
Message-ID: <Z_kRypMxpCT_Ecie@pengutronix.de>
References: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>
 <20250410-mwifiex-drop-asynchronous-init-v1-3-6a212fa9185e@pengutronix.de>
 <20250411084954.GA24608@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411084954.GA24608@francesco-nb>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Fri, Apr 11, 2025 at 10:49:54AM +0200, Francesco Dolcini wrote:
> On Thu, Apr 10, 2025 at 12:28:45PM +0200, Sascha Hauer wrote:
> > Historically all commands sent to the mwifiex driver have been
> > asynchronous. The different commands sent during driver initialization
> > have been queued at once and only the final command has been waited
> > for being ready before finally starting the driver.
> > 
> > This has been changed in 7bff9c974e1a ("mwifiex: send firmware
> > initialization commands synchronously").
> 
> > With this the initialization is finished once the last
> > mwifiex_send_cmd_sync() (now mwifiex_send_cmd()) has returned.
> 
> Just for me, the rename/refactor happened in commit fa0ecbb9905d
> ("mwifiex: remove global variable cmd_wait_q_required"), in v3.14.
> 
> 
> > This makes all the code used to wait for the last initialization
> > command to be finished unnecessary, so it's removed in this patch.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/cmdevt.c  | 16 ----------------
> >  drivers/net/wireless/marvell/mwifiex/init.c    |  5 +++--
> >  drivers/net/wireless/marvell/mwifiex/main.c    | 12 ++----------
> >  drivers/net/wireless/marvell/mwifiex/main.h    |  6 ------
> >  drivers/net/wireless/marvell/mwifiex/sta_cmd.c |  4 ----
> >  drivers/net/wireless/marvell/mwifiex/util.c    | 18 ------------------
> >  6 files changed, 5 insertions(+), 56 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> > index 5573e2ded72f2..c07857c49a713 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> > @@ -900,18 +900,6 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
> >  		ret = mwifiex_process_sta_cmdresp(priv, cmdresp_no, resp);
> >  	}
> >  
> > -	/* Check init command response */
> > -	if (adapter->hw_status == MWIFIEX_HW_STATUS_INITIALIZING) {
> 
> What about the code path from mwifiex_add_card()?
> 
> mwifiex_add_card()
>  -> hw_status = MWIFIEX_HW_STATUS_INITIALIZING
>  -> mwifiex_init_hw_fw(adapter, true))
>    -> request_firmware_nowait(..., mwifiex_fw_dpc)
> 
> mwifiex_fw_dpc()
>  ...
>      -> mwifiex_init_fw()
>        -> adapter->hw_status = MWIFIEX_HW_STATUS_READY  
> 
> mwifiex_fw_dpc() is called asynchronously, is everything as safe as
> before, here?

Yes, mwifiex_fw_dpc() is called asynchronously, but the first change in
my patch is in mwifiex_init_fw() which is already called asynchronously,
so my patch doesn't really change anything here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

