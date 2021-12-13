Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B119473476
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 19:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbhLMS5G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 13:57:06 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51114 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242027AbhLMS5E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 13:57:04 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mwqVM-001HET-AH; Mon, 13 Dec 2021 20:56:57 +0200
Message-ID: <8c0228220801f3ff03ffa0e3637269852dc5eefb.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Date:   Mon, 13 Dec 2021 20:56:54 +0200
In-Reply-To: <163942158792.6700.2715258543960971487.kvalo@kernel.org>
References: <0ee53b7977ca2cd1c1d5deb100fb9cdbfe2acd0b.camel@coelho.fi>
         <163942158792.6700.2715258543960971487.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: pull-request: iwlwifi-next 2021-12-08
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-12-13 at 18:53 +0000, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> wrote:
> 
> > Hi Kalle,
> > 
> > Here's my first pull request for v5.17 with the three patchsets I sent
> > earlier, plus a few patches to fix small issues introduced when iwlmei
> > was merged and a couple of other patches sent by the community some
> > time ago that were still pending.
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
> > The following changes since commit fe6db7eda9306d665f7b8fc3decdb556ec10fb85:
> > 
> >   iwlwifi: mei: fix linking when tracing is not enabled (2021-12-05 13:55:15 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-12-08
> > 
> > for you to fetch changes up to 977df8bd5844c9370c26a9477418165b870da27c:
> > 
> >   iwlwifi: work around reverse dependency on MEI (2021-12-07 20:18:06 +0200)
> > 
> > ----------------------------------------------------------------
> > first set of iwlwifi patches for v5.17
> > 
> > * A few mei fixes;
> > * Some improvements in D3;
> > * Support for new FW API commands;
> > * Fixes and cleanups in device configurations;
> > * Support some new FW API command versions;
> > * Fix WGDS revision 3 reading bug;
> > * Some firmware debugging improvements;
> > * Fixes for in device configuration structures;
> > * Improvements in the session protection code;
> > * Support SAR GEO Offset Mapping (SGOM) via BIOS;
> > * Continued work on the new Bz device family;
> > * Some more firmware debugging improvements;
> > * Support new FW API version 68;
> > * Add some new device IDs;
> > * Some other small fixes, clean-ups and improvements.
> 
> There's a conflict:
> 
> CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
> 
> <<<<<<< HEAD
> 	IWL_MVM_STATUS_STARTING,
> =======
> 	IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
> > > > > > > > fb6b74def69548fe5854bf902108ec5e4afa9ef6
> 
> I assume both enums should be included and STATUS_STARTING should be first. Do
> let me know if I should fix it somehow differently.

Sorry for the conflict.  Yeah, both should be included, but in our
internal tree we have STATUS_STARTING *after*
IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE.  So if you can use the same
order it's easier for us, but not a must.

--
Cheers,
Luca.
