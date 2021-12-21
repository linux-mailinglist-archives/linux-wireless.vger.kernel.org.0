Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A16947BE26
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 11:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhLUKcI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 05:32:08 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51638 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233126AbhLUKcI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 05:32:08 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mzcRB-001PG8-TW; Tue, 21 Dec 2021 12:32:06 +0200
Message-ID: <121638e1482539306c0e861aadc783d104876834.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 21 Dec 2021 12:32:04 +0200
In-Reply-To: <875yri9rv6.fsf@codeaurora.org>
References: <64f03fe09e5e811878a609824464d84086c3647f.camel@coelho.fi>
         <875yri9rv6.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: pull-request: iwlwifi-next 2021-12-21
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-12-21 at 12:25 +0200, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > Hi Kalle,
> > 
> > Here's my second pull request for v5.17 with the five patchsets I sent
> > earlier, plus a couple of indentation fixes and a couple of compilation
> > cleanups that were sent to the list earlier.
> > 
> > Otherwise this is all normal development, new features, bugfixes and 
> > cleanups.  More details about the contents in the tag description.
> > 
> > Please let me know if there are any issues.
> > 
> > Cheers,
> > Luca.
> > 
> > 
> > The following changes since commit f75c1d55ecbadce027fd650d3ca79e357afae0d9:
> > 
> >   Merge tag 'wireless-drivers-next-2021-12-17' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next (2021-12-17 07:30:07 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-12-21
> > 
> > for you to fetch changes up to 33511b2061dc0cd85bdb3d2a30cf4b875a7b9635:
> > 
> >   iwlwifi: mei: wait before mapping the shared area (2021-12-21 09:54:32 +0200)
> > 
> > ----------------------------------------------------------------
> > iwlwifi patches for v5.17
> > 
> > * Support for Time-Aware-SAR (TAS) as read from the BIOS;
> > * Fix scan timeout issue when 6GHz is enabled;
> > * Work continues for new HW family Bz;
> > * Support for Optimized Connectivity Experience (OCE) scan;
> > * A bunch of FW debugging improvements and fixes;
> > * Fix one 32-bit compilation issue;
> > * Some RX changes for new HW family
> > * Some fixes for 6 GHz scan;
> > * Fix SAR table fixes with newer platforms;
> > * Fix early restart crash;
> > * Small fix in the debugging code;
> > * Add new Killer device IDs;
> > * Datapath updates for Bz family continues;
> > * A couple of important fixes in iwlmei;
> > * Some other small fixes, clean-ups and improvements.
> > 
> > ----------------------------------------------------------------
> 
> Some issues:
> 
> Commits
> 
>   9fae33eb13cc ("iwlwifi: yoyo: fix issue with new DBGI_SRAM region read.")
>   64ae418ed8d0 ("iwlwifi: mvm: fix rfi get table vendor command handler")
> 
> are missing a Signed-off-by from their authors.

Oh, thanks for noticing.  I'll add them and resend.

--
Cheers,
Luca.
