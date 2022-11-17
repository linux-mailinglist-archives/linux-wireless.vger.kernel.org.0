Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D725462DC0C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 13:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiKQMyb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 07:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiKQMyP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 07:54:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89802248C5
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 04:54:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17C9E61C30
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 12:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A96C433D6;
        Thu, 17 Nov 2022 12:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668689653;
        bh=24hhyv4UTtioJwnwDdJM264Tsq2770z6Y+P0WfaDaFY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VZiyYozNjzMJ3JwyCEWBEVd8LbGGaRD6/+1KG+Rf+sAz34UTE725VQLh6v4w3h/zR
         xSpWHSBPEr4t+9E1d1fvqfiel3XMM6e+lyPlfss8lZAdqDrhBNz/RjghJugGODbnaQ
         OCvtLT3ZaXKx1lsrV2UArTR8WOcvZ7rNpkYIp1+vl4B18v3L1VmhhfZTraXl228hqf
         T2ovXBpXkHAz0XWN1uJGHQ2EcA25GQBR/5moTftiuUcDKWSXhuPJS8h/hSiNbrlC8a
         RySejBQJZaacuF+pjSiemTxecBvtypXhLIcNTXuxy26Rj61kmhBFGDGxEVEuvKyZKQ
         ZZcDfdSAf5DBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next-for-kalle-2022-11-06-v2
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <7af6d446bc64fc442e0d5f2c9d288e2c813b1504.camel@intel.com>
References: <7af6d446bc64fc442e0d5f2c9d288e2c813b1504.camel@intel.com>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166868965118.15377.5633401327411802673.kvalo@kernel.org>
Date:   Thu, 17 Nov 2022 12:54:12 +0000 (UTC)
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
> Here's the fixed pull request for v6.2 with the last two patchsets I sent.
> 
> It contains bugfixes (mostly mei) and cleanups.
> I put more details about the contents in the tag description.
> The second patchset depends on the first one.
> 
> Please let me know if there are any issues.
> 
> Thanks,
> Gregory
> 
> warning: redirecting to https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/
> The following changes since commit bd954a7e4aa0739630884fc572d2d0e4dcd16e25:
> 
>   wifi: rtl8xxxu: Use dev_* instead of pr_info (2022-11-04 13:01:35 +0200)
> 
> are available in the Git repository at:
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2022-11-06-v2
> 
> for you to fetch changes up to b0b9b80599a30ee8862c0294b8a3b69c9c6df4f9:
> 
>   wifi: iwlwifi: mei: wait for the mac to stop on suspend (2022-11-10 13:27:11 +0200)
> 
> ----------------------------------------------------------------
> iwlwifi patches intended for v6.2
> 
> * iwlmei fixes
> * Debug mechanism update for new devices (BZ)
> * Checksum offload fix for the new devices (BZ)
> * A few rate scale fixes and cleanups
> * A fix for iwlwifi debug mechanism
> * Start of MLO preparations - supporting new key API
> 
> ----------------------------------------------------------------
> Avraham Stern (7):
>       wifi: iwlwifi: mvm: send TKIP connection status to csme
>       wifi: iwlwifi: mei: make sure ownership confirmed message is sent
>       wifi: iwlwifi: mei: avoid blocking sap messages handling due to rtnl lock
>       wifi: iwlwifi: mei: implement PLDR flow
>       wifi: iwlwifi: mei: use wait_event_timeout() return value
>       wifi: iwlwifi: iwlmei: report disconnection as temporary
>       wifi: iwlwifi: mei: wait for the mac to stop on suspend
> 
> Emmanuel Grumbach (2):
>       wifi: iwlwifi: mei: don't send SAP commands if AMT is disabled
>       wifi: iwlwifi: mei: fix tx DHCP packet for devices with new Tx API
> 
> Ilan Peer (1):
>       wifi: iwlwifi: mvm: Fix getting the lowest rate
> 
> Johannes Berg (3):
>       wifi: iwlwifi: mei: fix potential NULL-ptr deref after clone
>       wifi: iwlwifi: mvm: use old checksum for Bz A-step
>       wifi: iwlwifi: mvm: support new key API
> 
> Luca Coelho (2):
>       wifi: iwlwifi: cfg: disable STBC for BL step A devices
>       wifi: iwlwifi: mvm: print an error instead of a warning on invalid rate
> 
> Rotem Saado (2):
>       wifi: iwlwifi: dbg: add support for DBGC4 on BZ family and above
>       wifi: iwlwifi: dbg: use bit of DRAM alloc ID to store failed allocs
> 
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c       |  36 ++++++++++++++++++---
>  drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h |  79 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c     |   7 +++--
>  drivers/net/wireless/intel/iwlwifi/iwl-prph.h        |   4 +++
>  drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h     |  30 ++++++++++++++++--
>  drivers/net/wireless/intel/iwlwifi/mei/main.c        | 302 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
> -------------------------------------
>  drivers/net/wireless/intel/iwlwifi/mei/net.c         |  10 ++++--
>  drivers/net/wireless/intel/iwlwifi/mei/sap.h         |  55 ++++++++++++++++++++++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/Makefile      |   1 +
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c     |   4 +--
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c          |   9 ++++++
>  drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c    |  60 ++++++++++++++++++++++++++++++-----
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c    |  23 ++++++++++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c     | 226 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h         |  19 ++++++++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c         |   3 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c        |   8 +++--
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c         |   3 ++
>  drivers/net/wireless/intel/iwlwifi/mvm/tx.c          |  15 +++++++--
>  19 files changed, 773 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c

Pulled, thanks.

e7e40cc6555c Merge tag 'iwlwifi-next-for-kalle-2022-11-06-v2' of http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/7af6d446bc64fc442e0d5f2c9d288e2c813b1504.camel@intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

