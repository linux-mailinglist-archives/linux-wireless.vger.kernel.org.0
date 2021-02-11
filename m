Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A8B319470
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 21:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhBKU0k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 15:26:40 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45620 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231818AbhBKU0T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 15:26:19 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1lAIWk-004DF2-5Y; Thu, 11 Feb 2021 22:25:26 +0200
Message-ID: <841a853821eb13029ec23b9d877ff0210c8e46b3.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 11 Feb 2021 22:25:25 +0200
In-Reply-To: <87sg62shgk.fsf@codeaurora.org>
References: <iwlwifi.20210211015026.289084803334.Ie234805047df3be84f4235f9dafaf4cdecf0db9a@changeid>
         <87sg62shgk.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v2] iwlwifi: pnvm: implement reading PNVM from UEFI
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-02-11 at 18:21 +0200, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > We now support fetching the PNVM data from a UEFI variable.  Add the
> > code to read this variable first and use it.  If it's not available,
> > we fall back to reading the data from the filesystem, as before.
> > 
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> [...]
> 
> > --- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
> > @@ -10,6 +10,7 @@
> >  #include "fw/api/commands.h"
> >  #include "fw/api/nvm-reg.h"
> >  #include "fw/api/alive.h"
> > +#include <linux/efi.h>
> >  
> > 
> > 
> > 
> >  struct iwl_pnvm_section {
> >  	__le32 offset;
> > @@ -219,6 +220,88 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
> >  	return -ENOENT;
> >  }
> >  
> > 
> > 
> > 
> > +/*
> > + * This is known to be broken on v4.19 and to work on v5.4.  Until we
> > + * figure out why this is the case and how to make it work, simply
> > + * disable the feature in old kernels.
> > + */
> > +#if defined(CONFIG_EFI)
> 
> The comment doesn't really make sense anymore, can you send a followupb
> patch to remove it? No need to change the tag because of this.

Ugh, sorry about that.  I just saw that the version check had slipped
in and fixed it quickly at 2am, so I could still send you the pull-req
before going to sleep...

I'll send a patch removing this now.

--
Cheers,
Luca.

