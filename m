Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EE5476BE3
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 09:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhLPI0t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 03:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhLPI0r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 03:26:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2988C061748
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 00:26:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A848661CBC
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 08:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A829C36AE4;
        Thu, 16 Dec 2021 08:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639643206;
        bh=/4x6IfGs1UNjvx4vJLeDpnDVq8uERYrZW98hb1j1yZM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QOv2Z2LhDvTJC6SFMe6EYBBtGFFg70vTNey6IBxxmc0GN/z5tyHawhoua1FlAcb4+
         7V4k/7xoJUi2VAkEZSk65HleeVbXuFPRVSvc/I5b40gXjHp4V5bpr5Ae9kkZr3dWtC
         bA7KzK2LRMf/EFccoiAE/mkU3Dm0YXi+GP9v8OmwlT6Iol1qTHvrX0QfDr1fWwu0aD
         pipmy6yBjW0oiG7t7pPXssVRAQNuYVjJgatCsQHSMB02VNm+tAH3gR9vsACBAgvUq4
         2K+inXymMUTAgnSCCFgbaOphP7IX9DDGFT0/MEI/KI5Ao6jwFJXti1pn1eOcqEFMZ5
         0zkybCNtzA7BA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: pull-request: iwlwifi-next 2021-12-08
References: <0ee53b7977ca2cd1c1d5deb100fb9cdbfe2acd0b.camel@coelho.fi>
        <163942158792.6700.2715258543960971487.kvalo@kernel.org>
        <8c0228220801f3ff03ffa0e3637269852dc5eefb.camel@coelho.fi>
Date:   Thu, 16 Dec 2021 10:26:41 +0200
In-Reply-To: <8c0228220801f3ff03ffa0e3637269852dc5eefb.camel@coelho.fi> (Luca
        Coelho's message of "Mon, 13 Dec 2021 20:56:54 +0200")
Message-ID: <87v8zpc5vi.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Mon, 2021-12-13 at 18:53 +0000, Kalle Valo wrote:
>> Luca Coelho <luca@coelho.fi> wrote:
>> 
>> > Hi Kalle,
>> > 
>> > Here's my first pull request for v5.17 with the three patchsets I sent
>> > earlier, plus a few patches to fix small issues introduced when iwlmei
>> > was merged and a couple of other patches sent by the community some
>> > time ago that were still pending.
>> > 
>> > Otherwise this is all normal development, new features, bugfixes and
>> > cleanups.  More details about the contents in the tag description.
>> > 
>> > Please let me know if there are any issues.
>> > 
>> > Cheers,
>> > Luca.
>> > 
>> > 
>> > The following changes since commit fe6db7eda9306d665f7b8fc3decdb556ec10fb85:
>> > 
>> >   iwlwifi: mei: fix linking when tracing is not enabled
>> > (2021-12-05 13:55:15 +0200)
>> > 
>> > are available in the Git repository at:
>> > 
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
>> > tags/iwlwifi-next-for-kalle-2021-12-08
>> > 
>> > for you to fetch changes up to 977df8bd5844c9370c26a9477418165b870da27c:
>> > 
>> >   iwlwifi: work around reverse dependency on MEI (2021-12-07 20:18:06 +0200)
>> > 
>> > ----------------------------------------------------------------
>> > first set of iwlwifi patches for v5.17
>> > 
>> > * A few mei fixes;
>> > * Some improvements in D3;
>> > * Support for new FW API commands;
>> > * Fixes and cleanups in device configurations;
>> > * Support some new FW API command versions;
>> > * Fix WGDS revision 3 reading bug;
>> > * Some firmware debugging improvements;
>> > * Fixes for in device configuration structures;
>> > * Improvements in the session protection code;
>> > * Support SAR GEO Offset Mapping (SGOM) via BIOS;
>> > * Continued work on the new Bz device family;
>> > * Some more firmware debugging improvements;
>> > * Support new FW API version 68;
>> > * Add some new device IDs;
>> > * Some other small fixes, clean-ups and improvements.
>> 
>> There's a conflict:
>> 
>> CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>> 
>> <<<<<<< HEAD
>> 	IWL_MVM_STATUS_STARTING,
>> =======
>> 	IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
>> > > > > > > > fb6b74def69548fe5854bf902108ec5e4afa9ef6
>> 
>> I assume both enums should be included and STATUS_STARTING should be first. Do
>> let me know if I should fix it somehow differently.
>
> Sorry for the conflict.  Yeah, both should be included, but in our
> internal tree we have STATUS_STARTING *after*
> IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE.  So if you can use the same
> order it's easier for us, but not a must.

Thanks, pulled now and I fixed the conflict like this:

--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@@ -1138,8 -1137,8 +1137,10 @@@ struct iwl_mvm 
   * @IWL_MVM_STATUS_FIRMWARE_RUNNING: firmware is running
   * @IWL_MVM_STATUS_NEED_FLUSH_P2P: need to flush P2P bcast STA
   * @IWL_MVM_STATUS_IN_D3: in D3 (or at least about to go into it)
+  * @IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE: suppress one error log
+  *    if this is set, when intentionally triggered
 + * @IWL_MVM_STATUS_STARTING: starting mac,
 + *    used to disable restart flow while in STARTING state
   */
  enum iwl_mvm_status {
        IWL_MVM_STATUS_HW_RFKILL,
@@@ -1151,7 -1150,7 +1152,8 @@@
        IWL_MVM_STATUS_FIRMWARE_RUNNING,
        IWL_MVM_STATUS_NEED_FLUSH_P2P,
        IWL_MVM_STATUS_IN_D3,
+       IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
 +      IWL_MVM_STATUS_STARTING,
  };
  
  struct iwl_mvm_csme_conn_info {

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
