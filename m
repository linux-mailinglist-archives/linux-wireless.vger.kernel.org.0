Return-Path: <linux-wireless+bounces-21185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1ABA7D4FD
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 09:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9673AFCDA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 07:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856154642D;
	Mon,  7 Apr 2025 07:09:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423533CA
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009750; cv=none; b=afsMp2L23VK+JuC+XHQjFUY5xCUN6PE/eSlt3oSN1iQHwCmR2fPMzNel1KwVP+CYg5bMkPcBIQeNQpxJNjo1B0yFdy5nwQM1ZKbmnUCBINLMauvpiwhPKTILYAHT0BSOPvhNGNIXv21T158ETKF+DGrqiANT+CGg5PqNaYYyEpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009750; c=relaxed/simple;
	bh=qUUPi11QdxzMvXgtzAM7bmvDvJ4NA9tMTlh4DHCL0Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OX5F4sgmzDTSowi5aFMSWUNKMTXinTlVWVHIwite9L7zXoki0OcuKRyGsKDvWUY0RaSC6bEJXXKVAcithS/HhBjFGT4XmtL3A4lk5XTDivShhW0mejQh+RI3wUPewpXLI109l0r0so5771iz4+f988xYqgrjlSCxvtvRZpwnieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 8A9EF2C05250;
	Mon,  7 Apr 2025 09:08:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C406532448; Mon,  7 Apr 2025 09:09:03 +0200 (CEST)
Date: Mon, 7 Apr 2025 09:09:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "Berg, Johannes" <johannes.berg@intel.com>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"Berg, Benjamin" <benjamin.berg@intel.com>,
	"Ben Shimol, Yedidya" <yedidya.ben.shimol@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Stern, Avraham" <avraham.stern@intel.com>,
	"Gabay, Daniel" <daniel.gabay@intel.com>,
	"Anjaneyulu, Pagadala Yesu" <pagadala.yesu.anjaneyulu@intel.com>,
	"Triebitz, Shaul" <shaul.triebitz@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: iwlwifi: mld: fix building with CONFIG_PM_SLEEP
 disabled
Message-ID: <Z_N6D9t5PV6ptXUN@wunner.de>
References: <f435bd9c8186176ffa12fd3650fac71cacdeebe1.1743946314.git.lukas@wunner.de>
 <MW5PR11MB581086E3DEFC1D6710892E68A3AA2@MW5PR11MB5810.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB581086E3DEFC1D6710892E68A3AA2@MW5PR11MB5810.namprd11.prod.outlook.com>

On Mon, Apr 07, 2025 at 06:42:47AM +0000, Korenblit, Miriam Rachel wrote:
> > From: Lukas Wunner <lukas@wunner.de>
> > Sent: Sunday, 6 April 2025 16:44
[...]
> > --- a/drivers/net/wireless/intel/iwlwifi/mld/d3.h
> > +++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.h
> > @@ -34,6 +34,7 @@ struct iwl_mld_wowlan_data {
> >  	struct iwl_mld_rekey_data rekey_data;
> >  };
> > 
> > +#ifdef CONFIG_PM_SLEEP
> >  int iwl_mld_no_wowlan_resume(struct iwl_mld *mld);  int
> > iwl_mld_no_wowlan_suspend(struct iwl_mld *mld);  int
> > iwl_mld_wowlan_suspend(struct iwl_mld *mld, @@ -47,5 +48,8 @@ void
> > iwl_mld_ipv6_addr_change(struct ieee80211_hw *hw,
> >  			      struct ieee80211_vif *vif,
> >  			      struct inet6_dev *idev);
> >  #endif
> > +#else
> > +static inline int iwl_mld_no_wowlan_suspend(struct iwl_mld *mld) {
> > +return 0;
> 
> You are not supposed to get to this function not under the ifdef.
> So if you do, I'd return an error value, not 0?

No.  This code section of iwl_mld_mac80211_stop()...

	/* if the suspend flow fails the fw is in error. Stop it here, and it
	 * will be started upon wakeup
	 */
	if (!suspend || iwl_mld_no_wowlan_suspend(mld))
		iwl_mld_stop_fw(mld);

...would unconditionally call iwl_mld_stop_fw() if the empty inline stub
of iwl_mld_no_wowlan_suspend() returned an error value.

That doesn't seem to be the desired behavior here, judging by the code
comment:  Apparently iwl_mld_stop_fw() is only supposed to be called
if the firmware "is in error".  So returning 0 is very much intentional.

Thanks,

Lukas

