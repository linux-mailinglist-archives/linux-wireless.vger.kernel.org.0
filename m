Return-Path: <linux-wireless+bounces-19660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF93A4AD33
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 19:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00A918942B9
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 18:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB401BBBFD;
	Sat,  1 Mar 2025 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="osXgXLC9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D340157A6B
	for <linux-wireless@vger.kernel.org>; Sat,  1 Mar 2025 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740852168; cv=none; b=jk7hqR9eVCxaPXkx23/aOfZDqkLYvBj2oAcwwcyGva7ckj04WqBaLzNI4nlriwrc7dAZ2S4qFWy8HSmlqOqfFVVZgxN2o9LUvas2g2nwYkI8dDOTuKigusgJdZTGCtPYee6kV/iZ4r03dOg44IIbFz7kgJyuilfe/kuIS72jJhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740852168; c=relaxed/simple;
	bh=PMZphVDkAF5aPMon3qh5vtfYZi7nELusLHYh4ZNi3yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfNiNCtGUTxXNZVGlzXWTCS143oKPwY1v9SuWPvt6Hy0bp7g+h76cajRKOtIltkEXPRmsQAnJmPig+4mz+mtE+4EAnKc1d6T1ty2PHZ4DSEDYApWxpVlj1jzLyefkjfUyh4ISWNq30ztu1ua12Dx09IAhn82xXLacKwTTzmBhJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=osXgXLC9; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 15599 invoked from network); 1 Mar 2025 19:02:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1740852161; bh=72eOQ/MqtKm4OU9kul9+dWtDYSCW8AaG4vLVBVfVUzs=;
          h=From:To:Cc:Subject;
          b=osXgXLC9pJX8RfrLXisZ8+LebRpXM+m9zvsTerBwTA7JyQOodLGIBZjLpJzi1mMqF
           TqO+SF0hTyeR60ieHyM2m4nNQv7nxH+mAuJg5REGofU1BTYF3z/6PFDuKOAXQCm3G+
           ytYrfSOvhqzRpJbW97mx4NWpg5T8dulhrS9mhhqbEoOjMjQR8Dxqg6/6/tJ7gDcm/R
           FH3TlHnB3eeO2xuRdnwFeJ6bMMrxcq57IpKoZnjdL2Z9PFqXWW1hirIzYZPXjeX0Pj
           yTOlqidswEh3PNGcnb7AKznqPXEcZ4U43sOnYqKVIQ8Cs8l8MJKaufc0HP7lei2eNc
           EoC0vtyg1B0+A==
Received: from 89-64-0-97.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.0.97])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <arnd@arndb.de>; 1 Mar 2025 19:02:41 +0100
Date: Sat, 1 Mar 2025 19:02:40 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
	linux <linux@treblig.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] iwlegacy: don't warn for unused variables with
 DEBUG_FS=n
Message-ID: <20250301180240.GA61229@wp.pl>
References: <20250225145359.1126786-1-arnd@kernel.org>
 <20250301122834.GA55739@wp.pl>
 <994e4827-0e16-4e05-be7c-1ca7a86e4daf@app.fastmail.com>
 <20250301133652.GA60453@wp.pl>
 <7e472cbe-bf29-432b-93da-d1fc87630939@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e472cbe-bf29-432b-93da-d1fc87630939@app.fastmail.com>
X-WP-MailID: 31fa1973e68bfed795e2c0e3bcfcda2b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [oaOU]                               

On Sat, Mar 01, 2025 at 02:49:38PM +0100, Arnd Bergmann wrote:
> On Sat, Mar 1, 2025, at 14:36, Stanislaw Gruszka wrote:
> > On Sat, Mar 01, 2025 at 01:38:16PM +0100, Arnd Bergmann wrote:
> >> On Sat, Mar 1, 2025, at 13:28, Stanislaw Gruszka wrote:
> >> > On Tue, Feb 25, 2025 at 03:53:53PM +0100, Arnd Bergmann wrote:
> >> >
> >> > But then the code will be compiled for !CONFIG_MAC80211_DEBUGFS
> >> > case, it does compile for me:
> >> >
> >> > -  22475	   1160	      0	  23635	   
> >> > 5c53	drivers/net/wireless/intel/iwlegacy/4965-rs.o
> >> > +  23008	   1168	      0	  24176	   
> >> > 5e70	drivers/net/wireless/intel/iwlegacy/4965-rs.o
> >> 
> >> Very strange, this really shouldn't happen. Which symbols
> >> exactly do you see the compiler fail to drop with my patch,
> >
> > nm 4965-rs.o diffrence before and after patch:
> 
> >  00000000000000dd t il4965_rs_alloc_sta.cold
> > -0000000000001810 t il4965_rs_collect_tx_data.isra.0
> > -00000000000012b0 t il4965_rs_fill_link_cmd
> > -0000000000000495 t il4965_rs_fill_link_cmd.cold
> > +0000000000001850 t il4965_rs_collect_tx_data.isra.0
> > +0000000000000e90 t il4965_rs_dbgfs_set_mcs.isra.0
> > +00000000000002f6 t il4965_rs_dbgfs_set_mcs.isra.0.cold
> > +0000000000001340 t il4965_rs_fill_link_cmd
> > +0000000000000518 t il4965_rs_fill_link_cmd.cold
> >  00000000000002a0 t il4965_rs_free
> 
> Ah, so the debugfs files get eliminated, but
> il4965_rs_dbgfs_set_mcs() does not.
> 
> I think this should do it:
> 
> --- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> @@ -2495,6 +2495,9 @@ il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
>         u8 valid_tx_ant;
>         u8 ant_sel_tx;
>  
> +       if (!IS_ENABLED(CONFIG_MAC80211_DEBUGFS))
> +               return;
> +
>         il = lq_sta->drv;
>         valid_tx_ant = il->hw_params.valid_tx_ant;
>         if (lq_sta->dbg_fixed_rate) {
> 
> or possibly il4965_rs_dbgfs_set_mcs() can stay in the #ifdef
> if you prefer.

I'm ok with this solution. The size stays the same with above
change.

Regards
Stanislaw


