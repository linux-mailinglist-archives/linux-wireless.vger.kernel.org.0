Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6381449EA5E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 19:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiA0SaD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 13:30:03 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37814 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234767AbiA0SaC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 13:30:02 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nD9Wy-0001eb-03;
        Thu, 27 Jan 2022 20:30:01 +0200
Message-ID: <9e0bd67fb408a4a0262ff094314039b900d035a3.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lenb@kernel.org,
        johannes@sipsolutions.net
Date:   Thu, 27 Jan 2022 20:29:59 +0200
In-Reply-To: <86458042c4dfcaa6aa971c9ec37f1cc77fd95cfe.camel@coelho.fi>
References: <iwlwifi.20220113104217.0ae07c2712dc.I14e2985bfd7ddd8a8d83eb1869b800c0e7f30db4@changeid>
         <87bl0fud2z.fsf@kernel.org>
         <86458042c4dfcaa6aa971c9ec37f1cc77fd95cfe.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] iwlwifi: mvm: check if SAR GEO is supported before
 sending command
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-01-13 at 14:09 +0200, Luca Coelho wrote:
> On Thu, 2022-01-13 at 12:47 +0200, Kalle Valo wrote:
> > Luca Coelho <luca@coelho.fi> writes:
> > 
> > > From: Luca Coelho <luciano.coelho@intel.com>
> > > 
> > > Older hardware, for instance 3160, do not support SAR GEO offsets.  We
> > > used to check for support before sending the command, but when moving
> > > the command to the init phase, we lost the check.  This causes a
> > > failure when initializing HW that do not support this command.
> > > 
> > > Fix that by adding a check before sending the command.  Additionally,
> > > fix the caller so that it checks for the return value of the
> > > iwl_mvm_sar_geo_init() function, which it was ignoring.
> > > 
> > > Fixes: db700bc35703 ("iwlwifi: mvm: check if SAR GEO is supported before sending command")
> > 
> > $ git show db700bc35703
> > fatal: ambiguous argument 'db700bc35703': unknown revision or path not in the working tree.
> > 
> > No need to resend because of this, if you can provide the commit id I
> > can fix the tag.
> 
> Oops, sorry, I added the tag to my own commit...
> 
> This is the correct one:
> 
> Fixes: 78a19d5285d9 ("iwlwifi: mvm: Read the PPAG and SAR tables at INIT stage")

As we discussed on IRC, this is not the right fix.  I have now finally
had the time to fix it properly, so let's drop this patch.  I'll send a
new one soon.

--
Cheers,
Luca.
