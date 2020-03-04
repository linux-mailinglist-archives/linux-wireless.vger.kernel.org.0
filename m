Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EACB178D10
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 10:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgCDJGW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 04:06:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:55143 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgCDJGW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 04:06:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 01:06:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; 
   d="scan'208";a="274593146"
Received: from mtosmanx-mobl.amr.corp.intel.com ([10.249.254.162])
  by fmsmga002.fm.intel.com with ESMTP; 04 Mar 2020 01:06:19 -0800
Message-ID: <b80b1af73554cb9d76d9814be40c61265c283cbf.camel@intel.com>
Subject: Re: [PATCH v2 5.5] iwlwifi: mvm: Do not require PHY_SKU NVM section
 for 3168 devices
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "dmoulding@me.com" <dmoulding@me.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linuxwifi <linuxwifi@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>
Date:   Wed, 04 Mar 2020 11:06:18 +0200
In-Reply-To: <eb6c6e1ff0e1c8c6b202e534262778a729923bc6.camel@intel.com>
References: <20200128093107.9740-1-dmoulding@me.com>
         <20200211162450.2493-1-dmoulding@me.com>
         <87d0ajx3r2.fsf@tynnyri.adurom.net>
         <eb6c6e1ff0e1c8c6b202e534262778a729923bc6.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-02-13 at 07:39 +0000, Grumbach, Emmanuel wrote:
> Hi Kalle and Dan,
> 
> On Wed, 2020-02-12 at 16:46 +0200, Kalle Valo wrote:
> > Dan Moulding <dmoulding@me.com> writes:
> > 
> > > This is just a friendly reminder that this patch has been
> > > submitted,
> > > for what looks like a fairly major regression in iwlwifi that
> > > impacts
> > > (as far as I can tell) *all* 3168 devices. The regression is in the
> > > v5.5.x series and was for a while back-ported to the stable trees,
> > > but
> > > luckily was noticed before the releases were made.
> > > 
> > > There are at least a few bug reports for this regression:
> > > 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=206329
> > > https://bugs.gentoo.org/706810
> > > https://lkml.org/lkml/2020/2/7/811
> > > https://bbs.archlinux.org/viewtopic.php?id=252603
> > > 
> > > The Gentoo maintainers have already applied this patch to their
> > > Linux
> > > sources and marked their bug report "fixed". But it would be really
> > > nice if we could get this regression fixed in the next stable
> > > v5.5.x
> > > release.
> > 
> > I'll queue this directly to wireless-drivers. Intel folks, are you ok
> > with this?
> > 
> 
> The only person who really understand what goes on here is Luca, he is
> also the one who touched this area I think. Luca is OOO and should be
> back next week I believe.
> The patch looks sane and it fixes issues for people, so go ahead and
> merge it please. If Luca wants to make changes on top of this, he can
> ask to do those changes on top of that patch.

Thanks for the fix, discussions and merging while I was away! This
indeed looks correct and I'll take this patch to our internal tree now
to align it with the upstream code.

I guess this should be sent to stable v5.5 as well.  Dan, would you
like to do that?

--
Cheers,
Luca.

