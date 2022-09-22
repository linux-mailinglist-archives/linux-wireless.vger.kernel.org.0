Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE215E5B2C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 08:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIVGQ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 02:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiIVGQU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 02:16:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BBEB516D
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 23:16:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F42162E14
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 06:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F8BC433D6;
        Thu, 22 Sep 2022 06:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663827378;
        bh=tSnCshQpZziIVpsFpKczLAJI+Lu/DgY3WSi9vKZBJ5o=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sfkHA4PSqcrojKLQRujtiwKdvPsR2LNfJuk8Die8BjXacc8TlVr3dVeYctkCaoS5x
         H4DAZLPtUlhS7C7hnBs5sgapAipayHg2wOXIPPK4AQvMSxw1ExFZlLAJRo0F9yrVEF
         zECkT0BSNzwFNDfM0GSP0rrsVcu9hWd/sQ/yMDJNwqP9klOwuTxgqBcnlYpz787ynn
         9RQzNiQGwCPFV/jm4XbVEOQ2EGt07+XAZ9zpY26dOmqGgbdg80WOsFQP9Akj82Oipi
         Nb/NWaAcMbcaSMUCPFRD39Bh0IRk8VpReELSeFTf7m3wUr0G+SiDH6zEUm5RC8fHGB
         nxQ5uXziWpW8g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2022-09-18
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <b18b016d911204bdd5c6f4b08d698d679419a204.camel@intel.com>
References: <b18b016d911204bdd5c6f4b08d698d679419a204.camel@intel.com>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166382737500.9021.85906663731820397.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 06:16:17 +0000 (UTC)
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
> Here's my first pull request for v6.1
> 
> It contains the usual development, new features and cleanups.
> 
> The changes are:
> * Refactoring of some wowlan related code
> * Fixes and cleanups
> * Adding support for BZ device family
> 
> Thanks,
> Gregory
> 
> The following changes since commit d5350756c03cdf18696295c6b11d7acc4dbf825c:
> 
>   wifi: rtl8xxxu: Remove copy-paste leftover in gen2_update_rate_mask (2022-09-12 14:57:54 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2022-09-18
> 
> for you to fetch changes up to 32fed4706d9aca31c9d575c1efa4a3624a9d5543:
> 
>   wifi: iwlwifi: mvm: d3: parse keys from wowlan info notification (2022-09-18 14:40:17 +0300)
> 
> ----------------------------------------------------------------
> iwlwifi patches for v6.1
> 
> ----------------------------------------------------------------
> Haim Dreyfuss (5):
>       wifi: iwlwifi: mvm: don't check D0I3 version
>       wifi: iwlwifi: mvm: Add support for wowlan info notification
>       wifi: iwlwifi: mvm: Add support for wowlan wake packet notification
>       wifi: iwlwifi: mvm: Add support for d3 end notification
>       wifi: iwlwifi: mvm: enable resume based on notifications
> 
> Haim, Dreyfuss (1):
>       wifi: iwlwifi: mvm: trigger resume flow before wait for notifications
> 
> Ilan Peer (1):
>       wifi: iwlwifi: mvm: Add handling for scan offload match info notification
> 
> Johannes Berg (5):
>       wifi: iwlwifi: mvm: fix typo in struct iwl_rx_no_data API
>       wifi: iwlwifi: mvm: rxmq: refactor mac80211 rx_status setting
>       wifi: iwlwifi: mvm: rxmq: further unify some VHT/HE code
>       wifi: iwlwifi: mvm: refactor iwl_mvm_set_sta_rate() a bit
>       wifi: iwlwifi: cfg: remove IWL_DEVICE_BZ_COMMON macro
> 
> Naftali Goldstein (1):
>       wifi: iwlwifi: mvm: d3: parse keys from wowlan info notification
> 
> Yaara Baruch (1):
>       wifi: iwlwifi: pcie: add support for BZ devices
> 
> Yedidya Benshimol (1):
>       wifi: iwlwifi: mvm: iterate over interfaces after an assert in d3
> 
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c       |  42 ++++++++++--
>  drivers/net/wireless/intel/iwlwifi/fw/api/commands.h |   5 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/d3.h       |  61 ++++++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/offload.h  |  17 ++++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/rx.h       |   4 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/scan.h     |  20 ++++--
>  drivers/net/wireless/intel/iwlwifi/iwl-config.h      |   3 +
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c          | 668 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
> -------------------------------------
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c    |  25 ++++---
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h         |   1 -
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c         |  18 +++--
>  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c        | 376 ++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c        |  19 +++++-
>  13 files changed, 846 insertions(+), 413 deletions(-)

Pulled, thanks.

aa7a5f946f5b Merge tag 'iwlwifi-next-for-kalle-2022-09-18' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/b18b016d911204bdd5c6f4b08d698d679419a204.camel@intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

