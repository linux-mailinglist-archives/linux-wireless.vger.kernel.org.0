Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7D5693E97
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 08:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBMHBX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 02:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBMHBW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 02:01:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD503659F
        for <linux-wireless@vger.kernel.org>; Sun, 12 Feb 2023 23:01:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85FAFB80D3A
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 07:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2347C433D2;
        Mon, 13 Feb 2023 07:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676271674;
        bh=LltvaO+3CXJJ6pTj9XBc2xNMSYCKrkt4OgIz5SRogYQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mksVE4e2zVsL3auI9S4NS3zP4BZV8GbFPyZF5fBTvHHrhf6LNkD7ihCVcoQr+qG3q
         lOwpD5Ndy3aEDtQN+pu0c5PhO7deXez+kOlLuEi23/Abc2yynXJag44GhLZuiIc/Jt
         jG1rlr1Su/QP5D9KQkosMkEjtw9t2yHPQuAxfffWJuNpOTtyMgh4OKo5CIiIi06Czu
         yQGx+JGIKG9y31iCQHKII0BDWAeIN1tdQKNVaPgnU/qaRkc5nZcs4vdh2fT8LrfOkr
         Y0qK5WSY9FPjELf1sTcgqgIUZR6UNr9WreGdi6IfxAkmNnM8JZ4b2Wcb3zRkZnpig5
         68O7ztUYV2kkQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2023-01-30
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ddc23836b333327e83ac7a4f9096e9fd7219eed3.camel@intel.com>
References: <ddc23836b333327e83ac7a4f9096e9fd7219eed3.camel@intel.com>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167627167061.8603.6806363226241301411.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 07:01:13 +0000 (UTC)
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
> Here's a pull request for v6.3 with the last patchset I sent and one
> iwlwifi patch from the small patchset before that.
> 
> This is all normal development, new features, bugfixes and  cleanups. 
> More details about the contents in the tag description.
> 
> Please let me know if there are any issues.
> 
> Thanks,
> Gregory.
> 
> 
> The following changes since commit 4ca69027691a0039279b64cfa0aa511d9c9fde59:                                                                                                                           
>                                                                                                                                                                                                                    
>   wifi: wireless: deny wireless extensions on MLO-capable devices (2023-01-19 20:01:41 +0200)                                                                                                          
>                                                                                                                                                                                                                    
> are available in the Git repository at:                                                                                                                                                                
>                                                                                                                                                                                                                    
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2023-01-30                                                                                       
>                                                                                                                                                                                                                    
> for you to fetch changes up to 9cbd5a8abca904441e36861e3a92961bec41d13f:                                                                                                                               
>                                                                                                                                                                                                                    
>   wifi: iwlwifi: mei: fix compilation errors in rfkill() (2023-01-30 13:00:25 +0200)                                                                                                                   
>                                                                                                                                                                                                                    
> ----------------------------------------------------------------                                                                                                                                       
> iwlwifi updates towards v6.3, this patch-set contains:                                                                                                                                                 
> 
> * EHT rate reporting
> * Sniffer support for EHT and a few fixes in the related code
> * A few general cleanups and small bugfixes
> * Bump FW API to 74 for AX devices
> * Fix a compilation error in mei (it still depends on BROKEN)
> * STEP equalizer support - transfer some Phy related parameters from
>   the BIOS to the firmware
> 
> ----------------------------------------------------------------
> Ayala Barazani (1):
>       wifi: iwlwifi: mvm: Support STEP equalizer settings from BIOS.
> 
> Emmanuel Grumbach (1):
>       wifi: iwlwifi: mention the response structure in the kerneldoc
> 
> Golan Ben Ami (1):
>       wifi: iwlwifi: bump FW API to 74 for AX devices
> 
> Gregory Greenman (2):
>       wifi: iwlwifi: mvm: always send nullfunc frames on MGMT queue
>       wifi: iwlwifi: mei: fix compilation errors in rfkill()
> 
> Heiner Kallweit (1):
>       wifi: iwlwifi: improve tag handling in iwl_request_firmware
> 
> Johannes Berg (1):
>       wifi: iwlwifi: mvm: add minimal EHT rate reporting
> 
> Mordechay Goodstein (3):
>       wifi: iwlwifi: rx: add sniffer support for EHT mode
>       wifi: iwlwifi: mvm: add sniffer meta data APIs 
>       wifi: iwlwifi: mvm: simplify by using SKB MAC header pointer
> 
> Mukesh Sisodiya (1):
>       wifi: iwlwifi: mvm: Reset rate index if rate is wrong
> 
> Tom Rix (1):
>       wifi: iwlwifi: mvm: remove h from printk format specifier
> 
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c             |   2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/commands.h       |   1 +
>  drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h       |   2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/rx.h             | 145
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
>  drivers/net/wireless/intel/iwlwifi/fw/uefi.c               |  59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/fw/uefi.h               |  19 ++++++++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h |  21 +++++++++++++++++++--
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.c               |  12 ++++--------
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h             |   4 ++++
>  drivers/net/wireless/intel/iwlwifi/mei/main.c              |   6 +++---
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c           |   6 +++---
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c     |   4 ++--
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c          |   7 +++++++
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c               |   1 +
>  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c              |  80 +++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
>  drivers/net/wireless/intel/iwlwifi/mvm/tx.c                |   7 ++++---
>  drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |   5 +++++
>  17 files changed, 314 insertions(+), 67 deletions(-)

Pulled, thanks.

b187c70b0366 Merge tag 'iwlwifi-next-for-kalle-2023-01-30' of http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ddc23836b333327e83ac7a4f9096e9fd7219eed3.camel@intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

