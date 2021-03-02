Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB232AFB0
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Mar 2021 04:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhCCA2G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Mar 2021 19:28:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448614AbhCBPHa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Mar 2021 10:07:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0220E64F31;
        Tue,  2 Mar 2021 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614696906;
        bh=8It4yP7aeowMnxrRjMp2VuO3oZ/kpVFvOz2t0EfqsLI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cJviZO4CmzYCEFaTgFTU1n0fOKlFhyAC9Sb9iQlOW8un8OszNwLsc+5T6uVi7L7sS
         KiegQBH3npHiSHLSUDx72vwgeju9bK6ss2NjV8prGv6J40SsO+d4f3uvy4MWIIm9rD
         QsHZyXTiJSdc/qkUocY/84iCAxLFsPSK3C+v6OU5o2SiShm1FjAHhvHhOst5Sj8Vd9
         X+HdQndb7DuYD6FmVsUNb/2HFMqk+KChELcqtYF/ANkp2SIn91s9iA+P6rOa5NhlJQ
         fxHs8Ic6nPL92Hg//aqOlxhH3XlpeLrG03IPtjwHt0ZKKF0JfCzDIS+0BZxWjOtz6w
         CRaTepHP7AqfA==
Date:   Tue, 2 Mar 2021 15:55:02 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
cc:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iwlwifi: don't call netif_napi_add() with rxq->lock
 held (was Re: Lockdep warning in iwl_pcie_rx_handle())
In-Reply-To: <87blc192cz.fsf@codeaurora.org>
Message-ID: <nycvar.YFH.7.76.2103021554160.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103012136570.12405@cbobk.fhfr.pm> <2db8f779b4b37d4498cfeaed77d5ede54e429a6e.camel@sipsolutions.net> <nycvar.YFH.7.76.2103021025410.12405@cbobk.fhfr.pm> <nycvar.YFH.7.76.2103021134060.12405@cbobk.fhfr.pm>
 <7de7aa19e5ea8a856cce4193ebb3c31b4ef78ca7.camel@intel.com> <87blc192cz.fsf@codeaurora.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2 Mar 2021, Kalle Valo wrote:

> > Thanks, Jiri! Let's take your patch since you already sent it out.
> >
> > Kalle, can you please take this directly to wireless-drivers.git?
> >
> > Acked-by: Luca Coelho <luciano.coelho@intel.com>
> 
> Ok but I don't see this either in patchwork or lore, hopefully it shows
> up later.

Not sure about patchwork, but vger had hiccup (again) earlier today, 
everything depending on the ML traffic is probably slower.

lore has it now though: 

	https://lore.kernel.org/lkml/nycvar.YFH.7.76.2103021134060.12405@cbobk.fhfr.pm/

Thanks,

-- 
Jiri Kosina
SUSE Labs

