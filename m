Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20594371C0
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 08:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhJVGaX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 02:30:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56956 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229545AbhJVGaW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 02:30:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mdo26-000beQ-MB; Fri, 22 Oct 2021 09:28:04 +0300
Message-ID: <046ac89a534549b46f33a73dd36c9e8231e87223.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 22 Oct 2021 09:28:01 +0300
In-Reply-To: <877deawz2y.fsf@codeaurora.org>
References: <20210820110318.260751-1-luca@coelho.fi>
         <iwlwifi.20210820140104.b5c7c6613634.I53b8d9fb194b88070a0df6613f7f57668ea0eaf8@changeid>
         <87y28usxl0.fsf@codeaurora.org>
         <3be8a0e1cbe82e0c4b55b00c7e7fe06d8014aa71.camel@coelho.fi>
         <877deawz2y.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 08/12] iwlwifi: export DHC framework and add first
 public entry, twt_setup
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-10-18 at 10:51 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > On Sat, 2021-08-21 at 17:04 +0300, Kalle Valo wrote:
> > > Luca Coelho <luca@coelho.fi> writes:
> > > 
> > > > From: Luca Coelho <luciano.coelho@intel.com>
> > > > 
> > > > Export the debug host command framework and add the twt_setup entry.
> > > > This will allow external parties to use these debugging features.
> > > > More entries can be added later on.
> > > > 
> > > > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > > 
> > > [...]
> > > 
> > > > --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> > > > +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> > > > @@ -92,6 +92,12 @@ config IWLWIFI_BCAST_FILTERING
> > > >  	  If unsure, don't enable this option, as some programs might
> > > >  	  expect incoming broadcasts for their normal operations.
> > > >  
> > > > 
> > > > +config IWLWIFI_DHC
> > > > +	bool "Enable debug host commands"
> > > > +	help
> > > > +	  This option enables the debug host command API.  It's used
> > > > +	  for debugging and validation purposes.
> > > > +
> > > 
> > > Why a new Kconfig option? Those should not be added lightly.
> > 
> > This is a debugging feature that is not really needed in production
> > kernels, so we prefer to allow it to be removed so we don't waste
> > resources.
> 
> What resources exactly? I would say if the admin or distro maintainer
> wants to save on resources he will disable IWLWIFI_DEBUGFS. Why do we
> need to have multiple Kconfig options for iwlwifi debugfs interface?
> 
> > We're publishing this for a few reasons:
> > 
> > 1. it will help prevent rebasing mistakes when sending patches upstream
> > from our internal tree, because a lot of this code is spread around the
> > driver;
> > 
> > 2. in some occasions, we may ask advanced users to enable it so we can
> > get more data and run more tests in case of tricky bugs;
> > 
> > 3. for the specific case of twt_setup, this allows running some TWT
> > test scenarios with our driver that wouldn't be easily available
> > otherwise.
> 
> Sure, I understand all that. The better debug features we have in
> upstream the better. But I don't understand why a new Kconfig option is
> needed for DHC feature.
> 
> > Is it okay to keep it?
> 
> In the past Linus has stated his dislike of adding pointless Kconfig
> options, with which I strongly agree, and to me it looks like
> IWLWIFI_DHC is exactly that. So I'm very hesitant about this.

Okay, fair enough.  I'll hold this back now, rework it without the
Kconfig option and send it again in the future.

Thanks for the comments!

--
Cheers,
Luca.
