Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7933D3F866F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbhHZL1K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 07:27:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33146 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242022AbhHZL07 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 07:26:59 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJDWG-002VQo-19; Thu, 26 Aug 2021 14:26:08 +0300
Message-ID: <a58ee2748eaecfa708faac00658c05fed3fcd4a3.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 14:26:03 +0300
In-Reply-To: <3be8a0e1cbe82e0c4b55b00c7e7fe06d8014aa71.camel@coelho.fi>
References: <20210820110318.260751-1-luca@coelho.fi>
         <iwlwifi.20210820140104.b5c7c6613634.I53b8d9fb194b88070a0df6613f7f57668ea0eaf8@changeid>
         <87y28usxl0.fsf@codeaurora.org>
         <3be8a0e1cbe82e0c4b55b00c7e7fe06d8014aa71.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 08/12] iwlwifi: export DHC framework and add first
 public entry, twt_setup
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-08-23 at 11:57 +0300, Luca Coelho wrote:
> On Sat, 2021-08-21 at 17:04 +0300, Kalle Valo wrote:
> > Luca Coelho <luca@coelho.fi> writes:
> > 
> > > From: Luca Coelho <luciano.coelho@intel.com>
> > > 
> > > Export the debug host command framework and add the twt_setup entry.
> > > This will allow external parties to use these debugging features.
> > > More entries can be added later on.
> > > 
> > > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > 
> > [...]
> > 
> > > --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> > > +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> > > @@ -92,6 +92,12 @@ config IWLWIFI_BCAST_FILTERING
> > >  	  If unsure, don't enable this option, as some programs might
> > >  	  expect incoming broadcasts for their normal operations.
> > >  
> > > 
> > > +config IWLWIFI_DHC
> > > +	bool "Enable debug host commands"
> > > +	help
> > > +	  This option enables the debug host command API.  It's used
> > > +	  for debugging and validation purposes.
> > > +
> > 
> > Why a new Kconfig option? Those should not be added lightly.
> 
> This is a debugging feature that is not really needed in production
> kernels, so we prefer to allow it to be removed so we don't waste
> resources.
> 
> We're publishing this for a few reasons:
> 
> 1. it will help prevent rebasing mistakes when sending patches upstream
> from our internal tree, because a lot of this code is spread around the
> driver;
> 
> 2. in some occasions, we may ask advanced users to enable it so we can
> get more data and run more tests in case of tricky bugs;
> 
> 3. for the specific case of twt_setup, this allows running some TWT
> test scenarios with our driver that wouldn't be easily available
> otherwise.
> 
> Is it okay to keep it?

Johannes suggested to add "if EXPERT" here, so I'm going to do that and
resend.

--
Cheers,
Luca.

