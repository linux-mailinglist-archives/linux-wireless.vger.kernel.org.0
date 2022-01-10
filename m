Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD198489E71
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jan 2022 18:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbiAJReS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jan 2022 12:34:18 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:52204 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238393AbiAJReQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jan 2022 12:34:16 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1n6yYc-001ZpG-Do; Mon, 10 Jan 2022 19:34:12 +0200
Message-ID: <08087e4e91841f0ee641b404f0087b138d5c5532.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com, You-Sheng Yang <vicamo.yang@canonical.com>
Date:   Mon, 10 Jan 2022 19:34:09 +0200
In-Reply-To: <CA+5PVA4+C06cNCDtzue4nUT4zFQPbc_2n4K6BnX4SrFSEFYK+w@mail.gmail.com>
References: <ea02828f6ebb5d8e3cd6b8a84aeeb2951d065207.camel@coelho.fi>
         <CA+5PVA4+C06cNCDtzue4nUT4zFQPbc_2n4K6BnX4SrFSEFYK+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: pull request: iwlwifi firmware updates 2022-01-10
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-01-10 at 12:24 -0500, Josh Boyer wrote:
> On Mon, Jan 10, 2022 at 7:45 AM Luca Coelho <luca@coelho.fi> wrote:
> > 
> > Hi,
> > 
> > This contains some new and updated firmwares for all our currently
> > maintained FW binaries.
> > 
> > Please pull or let me know if there are any issues.
> > 
> > --
> > Cheers,
> > Luca.
> > 
> > 
> > The following changes since commit 182a186c570baab3968ca9116ee58b1875fb0168:
> > 
> >   Merge branch 'for-upstream' of git://git.chelsio.net/pub/git/linux-firmware into main (2022-01-07 07:20:18 -0500)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2022-01-10
> > 
> > for you to fetch changes up to 8d8c6e9d9eb5402295c434603007377487458fef:
> > 
> >   iwlwifi: add new FWs from core66-88 release (2022-01-10 14:37:12 +0200)
> > 
> > ----------------------------------------------------------------
> > Update and add iwlwifi firmware binaries for release Core66-88
> > 
> > ----------------------------------------------------------------
> > Luca Coelho (2):
> >       iwlwifi: update 9000-family firmwares to core66-88
> >       iwlwifi: add new FWs from core66-88 release
> > 
> >  WHENCE                            |  44 ++++++++++++++++++++++++++++++++++++++++++--
> >  iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1519264 -> 1519544 bytes
> >  iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1490096 -> 1490376 bytes
> >  iwlwifi-Qu-b0-hr-b0-68.ucode      | Bin 0 -> 1355836 bytes
> >  iwlwifi-Qu-b0-jf-b0-68.ucode      | Bin 0 -> 1275268 bytes
> >  iwlwifi-Qu-c0-hr-b0-68.ucode      | Bin 0 -> 1355852 bytes
> >  iwlwifi-Qu-c0-jf-b0-68.ucode      | Bin 0 -> 1275284 bytes
> >  iwlwifi-QuZ-a0-hr-b0-68.ucode     | Bin 0 -> 1355800 bytes
> >  iwlwifi-QuZ-a0-jf-b0-68.ucode     | Bin 0 -> 1275264 bytes
> >  iwlwifi-cc-a0-68.ucode            | Bin 0 -> 1314392 bytes
> >  iwlwifi-so-a0-gf-a0-68.ucode      | Bin 0 -> 1533812 bytes
> >  iwlwifi-so-a0-gf-a0.pnvm          | Bin 41804 -> 41808 bytes
> >  iwlwifi-so-a0-gf4-a0-68.ucode     | Bin 0 -> 1552216 bytes
> >  iwlwifi-so-a0-gf4-a0.pnvm         | Bin 21576 -> 21576 bytes
> >  iwlwifi-so-a0-hr-b0-68.ucode      | Bin 0 -> 1429192 bytes
> >  iwlwifi-so-a0-jf-b0-68.ucode      | Bin 0 -> 1378284 bytes
> >  iwlwifi-ty-a0-gf-a0-68.ucode      | Bin 0 -> 1494304 bytes
> >  iwlwifi-ty-a0-gf-a0.pnvm          | Bin 41612 -> 41588 bytes
> 
> 
> [jwboyer@vader linux-firmware]$ ./check_whence.py
> E: iwlwifi-s0-a0-gf-a0.pnvm listed in WHENCE does not exist
> E: iwlwifi-s0-a0-gf4-a0.pnvm listed in WHENCE does not exist
> [jwboyer@vader linux-firmware]$
> 
> I think you added files with "...-so-a0-gf..." as the name, but added
> them to WHENCE as "...s0-a0-gf..." (letter o vs. number 0).
> 
> Can you fix this up?

Ouch, sorry.  Stupid typo.  I didn't realize we had this
check_whence.py script.  Nice! I'm make sure I run it every time from
now on.

I'll send a v2 of the pull-request.

--
Cheers,
Luca.
