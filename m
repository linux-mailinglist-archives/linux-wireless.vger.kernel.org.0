Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9FA63F712
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 19:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiLASDr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 13:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiLASDq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 13:03:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BBD1E73C
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 10:03:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A4E7620A3
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 18:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087CCC433C1;
        Thu,  1 Dec 2022 18:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669917824;
        bh=wDmogIlJ24CRFa6292pCYvvJm3H7+lP1QL4texaHICs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=j0ccEp3d2zU8ImiWOSntRsJfAAkGmkX7z86zbIXSaDddM9oLNTMpR07bC7fedoubt
         Q3E62nNpx851e6iF+3s+vFqM/ebEaTZqInqNyPHDR2dF9IT6eoujoNRey3N6G6qSnE
         TKmgZwbz+RGMMj4lB44daHreCLprDbNfSJmetOlcD6lzQ6isZgni4n9MAfH7fJkuAj
         KVVWxYHtLyaTmiz5AG+/lmEjtsQFC4KRVxymHtgzpdWS/Xrh1RviMF2q1QAe3i1ReE
         Rg08XHEGfq4rv5Rtu2uawt2+Sxwsfmbh4SbBC5OJ968Wke3lGfD5ADWxLO0/X2oA5R
         kuXBa0p0PcSbg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next-for-kalle-2022-11-28
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <b194da07d6f2617e6f273d204712d360be79f634.camel@intel.com>
References: <b194da07d6f2617e6f273d204712d360be79f634.camel@intel.com>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166991782028.16018.1726360547315521298.kvalo@kernel.org>
Date:   Thu,  1 Dec 2022 18:03:43 +0000 (UTC)
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
> Here's the second pull request for v6.2 with the last two patchsets I sent.
> 
> It contains EHT adjustments and some bugfixes (iwlmei and one old bug in tx path).
> 
> Please let me know if there are any issues.
> 
> Thanks,
> Gregory
> 
> The following changes since commit eceb024ee3eed1bacb5c32a4847269f2685e2ea4:
> 
>   Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git (2022-11-28 16:58:28 +0200)
> 
> are available in the Git repository at:
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2022-11-28
> 
> for you to fetch changes up to f31f7cd9875c2ab744006bd2ad25641db53f079d:
> 
>   wifi: iwlwifi: mei: fix parameter passing to iwl_mei_alive_notif() (2022-11-28 17:54:09 +0200)
> 
> ----------------------------------------------------------------
> This is the second pull request intended for v6.2
> 
> It contains two patch-sets sent before with the following content:
> * iwlwifi EHT adjustments
> * double-free fix in tx path
> * iwlmei PLDR flow fixes
> * iwlmei smatch fixes
> * a logging data improvement
> 
> ----------------------------------------------------------------
> Abhishek Naik (1):
>       wifi: iwlwifi: nvm: Update EHT capabilities for GL device
> 
> Avraham Stern (2):
>       wifi: iwlwifi: mvm: trigger PCI re-enumeration in case of PLDR sync
>       wifi: iwlwifi: mvm: return error value in case PLDR sync failed
> 
> Ben Greear (1):
>       wifi: iwlwifi: mvm: fix double free on tx path.
> 
> Daniel Gabay (1):
>       wifi: iwlwifi: mvm: print OTP info after alive
> 
> Gregory Greenman (1):
>       wifi: iwlwifi: mei: fix parameter passing to iwl_mei_alive_notif()
> 
> Ilan Peer (1):
>       wifi: iwlwifi: mvm: Advertise EHT capabilities
> 
> Johannes Berg (4):
>       wifi: iwlwifi: mvm: support 320 MHz PHY configuration
>       wifi: iwlwifi: mvm: set HE PHY bandwidth according to band
>       wifi: iwlwifi: mvm: advertise 320 MHz in 6 GHz only conditionally
>       wifi: iwlwifi: nvm-parse: support A-MPDU in EHT 2.4 GHz
> 
> Miri Korenblit (1):
>       wifi: iwlwifi: mvm: support PPE Thresholds for EHT
> 
> Mordechay Goodstein (2):
>       wifi: iwlwifi: rs: add support for parsing max MCS per NSS/BW in 11be
>       wifi: iwlwifi: mvm: add support for EHT 1K aggregation size
> 
>  drivers/net/wireless/intel/iwlwifi/fw/api/mac.h       |   6 ++---
>  drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |  33 ++++++++++++-------------
>  drivers/net/wireless/intel/iwlwifi/fw/api/rs.h        |  10 +++-----
>  drivers/net/wireless/intel/iwlwifi/fw/rs.c            |   2 ++
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.c          |   3 +++
>  drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h |   3 ++-
>  drivers/net/wireless/intel/iwlwifi/iwl-modparams.h    |   1 +
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c    | 235
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
>  drivers/net/wireless/intel/iwlwifi/iwl-prph.h         |   1 +
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h        |   1 +
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c           |  29 ++++++++++++++++++----
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c     | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------

Pulled, thanks.

e9ab0b2e680b Merge tag 'iwlwifi-next-for-kalle-2022-11-28' of http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/b194da07d6f2617e6f273d204712d360be79f634.camel@intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

