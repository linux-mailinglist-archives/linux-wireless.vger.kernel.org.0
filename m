Return-Path: <linux-wireless+bounces-21171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19BDA7CE42
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 15:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813A73A633E
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F98F1A3163;
	Sun,  6 Apr 2025 13:54:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308DB1A08B5;
	Sun,  6 Apr 2025 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743947671; cv=none; b=qLSCajMCRDsznoMRh+ZZDxqrMbeRS5dQfJJ0QinfuQAD/qa5fFWVH9dZA9txdsd3pWsVbquBlc1cyC5+0GHqc5DDvmSLoDfUIfmquqBF1X+/I3zU09XQqoqttdqJ1lgMCFFFbYjJ+POGXrl2DOt0CAC9NzcynzciJsRiP3qKUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743947671; c=relaxed/simple;
	bh=lj34e65Bv3wYeMSXJWTA50O/ZNHYr1A9EK7ERDF0Aqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDI4uhhDEzFauI9kt+DR5QTCRCcPig5+qxtmH/FjyuVwaSkDFRDgw9ktIMykvmQA2VhLXBKYoPxL0XdJYaWhCf/fDS/eyFC0pFf5yTjVL6dZEkZsEeNO8LqTzFck0Jib2W9Gfo9nNrcDISBBkQChigGN5OxAGBvezofW0EhUOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4DEEA2C0526E;
	Sun,  6 Apr 2025 15:54:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0CAEF30E6F; Sun,  6 Apr 2025 15:54:26 +0200 (CEST)
Date: Sun, 6 Apr 2025 15:54:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"Berg, Benjamin" <benjamin.berg@intel.com>,
	"Anjaneyulu, Pagadala Yesu" <pagadala.yesu.anjaneyulu@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iwlwifi: mld: fix building with CONFIG_PM_SLEEP disabled
Message-ID: <Z_KHkknIxQWzXhry@wunner.de>
References: <20250325084340.378724-1-arnd@kernel.org>
 <MW5PR11MB58106D6BC6403845C330C7AAA3A22@MW5PR11MB5810.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB58106D6BC6403845C330C7AAA3A22@MW5PR11MB5810.namprd11.prod.outlook.com>

On Sun, Mar 30, 2025 at 04:49:38AM +0000, Korenblit, Miriam Rachel wrote:
> > From: Arnd Bergmann <arnd@kernel.org>
> > Sent: Tuesday, 25 March 2025 10:44
> > 
> > The newly added driver causes multiple build problems when CONFIG_PM_SLEEP
> > is disabled:
[...]
> > --- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
> > @@ -501,7 +501,7 @@ int iwl_mld_mac80211_start(struct ieee80211_hw *hw)
> >  		iwl_mld_restart_cleanup(mld);
> >  	}
> > 
> > -	if (!in_d3 || ret) {
> > +	if (!in_d3) {
> 
> Then where do you handle the in_d3 && ret case?

That seems to be a valid objection, yet Arnd's patch is now
commit 44605365f935 in wireless.git:

https://git.kernel.org/wireless/wireless/c/44605365f935

I'm proposing this v2:

https://lore.kernel.org/r/f435bd9c8186176ffa12fd3650fac71cacdeebe1.1743946314.git.lukas@wunner.de/

If wireless.git/main is a rebasing branch, consider replacing the
above-linked commit with the new version.  If it is not a rebasing
branch, let me know and I'll send a patch reinstating only the ret
in the if-condition.

Thanks,

Lukas

