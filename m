Return-Path: <linux-wireless+bounces-18091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E440A212C2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 20:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0241188AAF8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833151DFD89;
	Tue, 28 Jan 2025 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="T/oicrGK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E31E98E8;
	Tue, 28 Jan 2025 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738093969; cv=none; b=nX040kHUNuYte0b1n/BXZVW0tF2RghzeUDx8fgpxXTXWfYhAJq2sSxU5Cf6JQAPpd1DIr2r7qJlKEeVJAsJ8G5JPCz20fKJNV4B8a2TGY6sp6m79B87KcltV+JtRd5f/Rt9JTi7vPJ21TU/WtuW//noT2kFNgiOYBU9NfrNYMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738093969; c=relaxed/simple;
	bh=PWEPEure7HQrZ8dG6/eksnkSIECXu/YVLkemgDQyGWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVQIKIfPkA6+GwaUKqpj9L7qUJTaJnu12PA6q4GCZwlFscgL1lxD1XSfD6b8bVXvvLtnr6vIYVK70sDCMs+cw3386gVzhKW/ubgEB8KaMOC1Zv9I5nhnKiP79qs36xUA9/i/orF45aJ/mU1pnNc1sP5A34fMLSyqryT0ZSj9/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=T/oicrGK; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=POa/3lE2bVxXraVtVR+/qivi/O1cJzPp9IuhNQHVelQ=; b=T/oicrGKemoDyV7p
	vwlw6q6WUAkU/+2K2HBDXkPNGibsmnnnGcW05pLI4ix6m9VwBeymaX8iYmPnfCDnA8icvJjf9Iz/T
	lgVbhWlbMlublQFAgOVMDrGMAx/LD8kztrqjiM4w4sQu9vY/BscQ9LMD39r85MUKFTegaP+v6zqkw
	MZM1vme4VDt3Qi3py0Uszy7diJpiEr9L+0YlCB+ZpEsl54/7e20RaldOY/94RP8AUuHlwJvW6+Vy2
	H7FA8UnJq0+Bq8hfBmKrSqxe3ZJaTXMC5jCZ+dsv9mNG+644iNod+/0I0b8vYi+swyaP4iZANXkLR
	TPmIe9wgInNaYzZ5mg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tcrdZ-00CXSz-0g;
	Tue, 28 Jan 2025 19:52:41 +0000
Date: Tue, 28 Jan 2025 19:52:41 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] iwlwifi: Cleaning up deadcode
Message-ID: <Z5k1iYBT0wTT86uw@gallifrey>
References: <20241223013202.340180-1-linux@treblig.org>
 <Z5kly5whELp8h1k3@gallifrey>
 <MW5PR11MB5810E64A405DBCE4F472A253A3EF2@MW5PR11MB5810.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5810E64A405DBCE4F472A253A3EF2@MW5PR11MB5810.namprd11.prod.outlook.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 19:52:28 up 265 days,  7:06,  1 user,  load average: 0.05, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Korenblit, Miriam Rachel (miriam.rachel.korenblit@intel.com) wrote:
> 
> 
> > -----Original Message-----
> > From: Dr. David Alan Gilbert <linux@treblig.org>
> > Sent: Tuesday, 28 January 2025 20:46
> > To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>;
> > kvalo@kernel.org; linux-wireless@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 0/6] iwlwifi: Cleaning up deadcode
> > 
> > * linux@treblig.org (linux@treblig.org) wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >
> > > Hi,
> > >   This is a collection of removal of functions that have been used for
> > > more than a few years.
> > >
> > >   There are also a handful of string and one structure removal that
> > > are just left overs from a recent commit.
> > >
> > > They're all entire function/structure/string removal.
> > >
> > > Build tested only.
> > >
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> > A gentle ping on this just-pre-christmas set please.
> > Thanks!
> > 
> > Dave
> > 
> > >
> > >
> > > Dr. David Alan Gilbert (6):
> > >   iwlwifi: Remove unused iwl_rx_ant_restriction
> > >   iwlwifi: Remove unused iwl_mvm_rx_missed_vap_notif
> > >   iwlwifi: Remove unused iwl_mvm_ftm_*_add_pasn_sta functions
> > >   iwlwifi: Remove unused iwl_mvm_ftm_add_pasn_sta
> > >   iwlwifi: Remove unused iwl_bz_name
> > >   iwlwifi: Remove old device data
> > >
> > >  .../net/wireless/intel/iwlwifi/cfg/22000.c    |   1 -
> > >  .../net/wireless/intel/iwlwifi/cfg/ax210.c    |   8 --
> > >  drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   1 -
> > >  drivers/net/wireless/intel/iwlwifi/dvm/tt.c   |  11 --
> > >  drivers/net/wireless/intel/iwlwifi/dvm/tt.h   |   1 -
> > >  .../net/wireless/intel/iwlwifi/iwl-config.h   |   4 -
> > >  .../intel/iwlwifi/mvm/ftm-initiator.c         | 101 ------------------
> > >  .../intel/iwlwifi/mvm/ftm-responder.c         |  86 ---------------
> > >  .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  23 ----
> > > drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  12 ---
> > > drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  61 -----------
> > >  drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   4 -
> > >  12 files changed, 313 deletions(-)
> > >
> > > --
> > > 2.47.1
> > >
> > --
> >  -----Open up your eyes, open up your mind, open up your code -------
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
> 
> 
> Acked-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Thanks!

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

