Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492A73338B2
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 10:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhCJJ0n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 04:26:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:48372 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229559AbhCJJ0k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 04:26:40 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1lJv6z-004SIf-95; Wed, 10 Mar 2021 11:26:38 +0200
Message-ID: <42eb781e8f89b92ff54a4d65b0916d420eb2a381.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Thomas Backlund <tmb@tmb.nu>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
Date:   Wed, 10 Mar 2021 11:26:35 +0200
In-Reply-To: <69d01bfd-a15f-2ebb-b55a-c6864a065e1f@tmb.nu>
References: <8e3877efc92f413d47ee1d71a119885c765d7312.camel@coelho.fi>
         <69d01bfd-a15f-2ebb-b55a-c6864a065e1f@tmb.nu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: pull request: iwlwifi firmware updates 2021-03-05-v2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Your email was in HTML, so it probably didn't reach the list.

On Wed, 2021-03-10 at 09:09 +0000, Thomas Backlund wrote:
> 
> More  "issues"...
> 
> Den 9.3.2021 kl. 13:57, skrev Luca Coelho:
> Hi,
> 
> This is v2 of my update which contains some new and updated files for
> all our currently maintained FW binaries.
> 
> In v2:
> 
>    * Fixed WHENCE so that the new files match, with "62" instead of
>    "59".
> 
> Please pull or let me know if there are any issues.
> 
> --
> Cheers,
> Luca.
> 
> 
> The following changes since commit
> 5ecd13ffe8e24385cf4f30f3d0dcaff4dfb24de2:
> 
>   Mellanox: Add new mlxsw_spectrum firmware xx.2008.2406 (2021-03-03
> 13:23:49 -0500)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-
> firmware.git iwlwifi-fw-2021-03-05-v2
> 
> for you to fetch changes up to
> b46d336044c448987589bd6cf3057f404c5581ad:
> 
>   iwlwifi: add new FWs from core59-66 release (2021-03-09 13:51:26
> +0200)
> 
> ----------------------------------------------------------------
> Update iwlwifi firmwares to Core59-66
> 
> ----------------------------------------------------------------
> Luca Coelho (3):
>       iwlwifi: update 7265D firmware
> 
> This one looks old... stuck in limbo for over 1.5 years... is that
> correct ?
> author    Luca Coelho <luciano.coelho@intel.com>    2019-08-23
> 07:35:14 +0300
>  committer    Luca Coelho <luciano.coelho@intel.com>    2021-03-05
> 11:37:56 +0200

Oh, I just reused the commit message from before and edited it as
needed.  Does it really matter?

>       iwlwifi: update 9000-family firmwares
> 
> This one adds duplicated fileinfo in WHENCE
>  
> https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/commit/?id=a6720504c812c1e8b0979a81d15b6ce6b4d87ae7
> instead of updating existing ones.

Okay, I'll fix it.

>       iwlwifi: add new FWs from core59-66 release
> 
> This one still adds some duplicated WHENCE stuff for  *-59.ucode:
>  
> https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/commit/?id=b46d336044c448987589bd6cf3057f404c5581ad
> 
> +File: iwlwifi-cc-a0-59.ucode
> +Version: 59.49eeb572.0
> +
> +File: iwlwifi-Qu-b0-hr-b0-59.ucode
> +Version: 59.49eeb572.0

Yep, copy/paste issue again, I'll fix it.

--
Luca.

