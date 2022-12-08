Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D7B647241
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 15:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLHOy6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 09:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiLHOy4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 09:54:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8C889300
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 06:54:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87FC6CE24B1
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 14:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04935C433D6;
        Thu,  8 Dec 2022 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670511291;
        bh=e65yNfG7mObelo3Qw/sLtIqGcUvT7yAnrBsixTTHTHE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ld/kXrWX+BlOsGwqd1JDYlNVKxM1k99WnyDDvrpFX3X7EN8l8d6pwPyu+D+ibMoX7
         mXRKhypugKmJcgNJjAdad1Z7b7wNLGtpl0AY0sWFMqN+slIHcpyNpd3aLjRHw+9eoS
         3JBga4ugZHqONgNARsQb2E+j5p3vNxEOyRJ5Oqx/gh/NjPS+zoZACkcBOKBQGJY9/+
         RrCYQ0kvyRLxJAwD1rKq3wY2fIfSr581JIihLCEHVTTLKB+KnxKY2fZdnEu5YbLYnO
         14kDugaBxYJIGbbxH5OjKyONDIimCBxYWGX7g3UnzTXt5hlM7KRTGJj7RYTgJWzMnG
         We+tMgUafUO3Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next-for-kalle-2022-12-07
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <b34ff82b2d084d939e636494b24ab1e25ad9b2d3.camel@intel.com>
References: <b34ff82b2d084d939e636494b24ab1e25ad9b2d3.camel@intel.com>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167051128926.9839.15888157537977416396.kvalo@kernel.org>
Date:   Thu,  8 Dec 2022 14:54:50 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Greenman, Gregory" <gregory.greenman@intel.com> wrote:

> Hi Kalle,
> 
> Here's the 3rd pull request for v6.2 with the last patchset I sent.
> This is all normal development, new features, small fixes and  cleanups. 
> More details about the contents in the tag description.
> 
> Please let me know if there are any issues.
> 
> Thanks,
> Gregory
> 
> The following changes since commit 65e6af6cebefbf7d8d8ac52b71cd251c2071ad00:
> 
>   net: ethernet: mtk_wed: fix sleep while atomic in mtk_wed_wo_queue_refill (2022-12-02 21:23:02 -0800)
> 
> are available in the Git repository at:
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2022-12-07
> 
> for you to fetch changes up to a6365c2da9faf7c7bcb81fbc4b422e9f319c9f0c:
> 
>   wifi: iwlwifi: fw: use correct IML/ROM status register (2022-12-07 17:36:50 +0200)
> 
> ----------------------------------------------------------------
> An additional set of patches intended for v6.2.
> 
> It contains:
> * Adjustments for the new HW
> * Adjustments for FW API update
> * A few small fixes and cleanups
> * Improvements for debug dumps mechanism
> 
> ----------------------------------------------------------------
> Jakob Koschel (1):
>       wifi: iwlwifi: mvm: replace usage of found with dedicated list iterator variable
> 
> Johannes Berg (3):
>       wifi: iwlwifi: nvm-parse: enable WiFi7 for Fm radio for now
>       wifi: iwlwifi: modify new queue allocation command
>       wifi: iwlwifi: fw: use correct IML/ROM status register
> 
> Miri Korenblit (1):
>       wifi: iwlwifi: mvm: Don't use deprecated register
> 
> Mordechay Goodstein (1):
>       wifi: iwlwifi: mvm: don't access packet before checking len
> 
> Mukesh Sisodiya (3):
>       wifi: iwlwifi: dump: Update check for valid FW address
>       wifi: iwlwifi: pcie: Add reading and storing of crf and cdb id.
>       wifi: iwlwifi: dump: Update check for UMAC valid FW address
> 
> Naftali Goldstein (1):
>       wifi: iwlwifi: mvm: d3: add TKIP to the GTK iterator
> 
> Tom Rix (1):
>       wifi: iwlwifi: mei: clean up comments
> 
>  drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h   | 16 ++++++++++------
>  drivers/net/wireless/intel/iwlwifi/fw/dump.c           |  7 ++++---
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c     |  2 ++
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h         |  4 ++++
>  drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h       |  6 +++---
>  drivers/net/wireless/intel/iwlwifi/mei/main.c          |  2 +-
>  drivers/net/wireless/intel/iwlwifi/mei/sap.h           | 10 +++++-----
>  drivers/net/wireless/intel/iwlwifi/mei/trace-data.h    |  2 +-
>  drivers/net/wireless/intel/iwlwifi/mei/trace.h         |  2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c            |  9 +++++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 12 +++++-------
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c            |  6 +++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c           |  9 ++++++---
>  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c          | 38 ++++++++++++++++++++------------------
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c           | 26 ++++++++++++++++----------
>  drivers/net/wireless/intel/iwlwifi/mvm/time-event.c    |  7 +++----
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c          | 33 +++++++++++++++++++++++----------
>  17 files changed, 116 insertions(+), 75 deletions(-)

Pulled, thanks.

832c3f66f53f Merge tag 'iwlwifi-next-for-kalle-2022-12-07' of http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/b34ff82b2d084d939e636494b24ab1e25ad9b2d3.camel@intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

