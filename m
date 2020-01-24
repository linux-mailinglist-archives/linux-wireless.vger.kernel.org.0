Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449FA148E24
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2020 19:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391725AbgAXS7R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jan 2020 13:59:17 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54886 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389376AbgAXS7R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jan 2020 13:59:17 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iv4Ai-00058m-6E; Fri, 24 Jan 2020 20:59:12 +0200
Message-ID: <2fb702500e0232083956f6ac1b3cf60bc2e65914.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Date:   Fri, 24 Jan 2020 20:59:10 +0200
In-Reply-To: <875zh0ewuz.fsf@kamboji.qca.qualcomm.com>
References: <f548bee28a2ef4700a024e33c02b62893af498c7.camel@coelho.fi>
         <87eevoex5m.fsf@kamboji.qca.qualcomm.com>
         <875zh0ewuz.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: pull-request: iwlwifi-next 2020-01-11
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-01-24 at 16:45 +0200, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
> 
> > Luca Coelho <luca@coelho.fi> writes:
> > 
> > > Here's the fist batch of patches intended for v5.6.  This includes
> > > the last two patchsets I sent out.  Usual development work.  More
> > > details about the contents in the tag description.
> > > 
> > > I pushed these patches to my pending branch, but it was just now, so I
> > > didn't get the results from kbuildbot yet.
> > > 
> > > Please let me know if there are any issues.
> > > 
> > > Cheers,
> > > Luca.
> > > 
> > > 
> > > The following changes since commit ae0a723c4cfd89dad31ce238f47ccfbe81b35b84:
> > > 
> > >   Merge ath-next from
> > > git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
> > > (2019-12-19 18:27:36 +0200)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
> > > tags/iwlwifi-next-for-kalle-2020-01-11
> > > 
> > > for you to fetch changes up to 0b295a1eb81f37dc7d4f4f2ee9ef375fb36ab5d8:
> > > 
> > >   iwlwifi: add device name to device_info (2020-01-04 12:48:41 +0200)
> > > 
> > > ----------------------------------------------------------------
> > > First set of patches intended for v5.6
> > > 
> > > * Support new versions of the FTM FW APIs;
> > > * Fix an old bug in D3 (WoWLAN);
> > > * A couple of fixes/improvements in the receive-buffers code;
> > > * Fix in the debugging where we were skipping one TXQ;
> > > * Support new version of the beacon template FW API;
> > > * Print some extra information when the driver is loaded;
> > > * Some debugging infrastructure (aka. yoyo) updates;
> > > * Support for a new HW version;
> > > * Second phase of device configuration work started;
> > > * Some clean-ups;
> > > 
> > > ----------------------------------------------------------------
> > 
> > There was a conflict in pcie/drv.c due to this commit:
> > 
> > db5cce1afc8d Revert "iwlwifi: assign directly to iwl_trans->cfg in QuZ detection"
> > 
> > Please double check my resolution in the pending branch:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=5e01e8338c9d741dbf473a56f753b9c12344432d
> > 
> > I just took the hunk from commit db5cce1afc8d and didn't do any other
> > changes.
> 
> Wrong link obviously, it should be this one:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=8dd96ed75b07e0134df24333c5766cf656af60af
> 

Looks good! Thanks for resolving it, Kalle!

--
Cheers,
Luca.

