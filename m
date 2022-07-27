Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986C4582001
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 08:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiG0GVq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 02:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiG0GVo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 02:21:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C713319287
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jul 2022 23:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DF57611F8
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 06:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83974C433C1;
        Wed, 27 Jul 2022 06:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658902902;
        bh=Af9L7u+FbR+yb7xzkf1WSdO0L6t1u5uREsfOgxmauZI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mBCWKhQ++OPVNf0EpUNi8W8/7OSL+/ponxvgUcleiaPzcS7F3NwYVqaZfZes8RmXF
         ShOFsRREczESv4Aa7YZuj4vsg9aiC3OY1o1Ah/Dup03cR/8Pcd852WfNw82p9xYft9
         i+rtBJvPteBA5p9ZHy/Z2WYSc8VSXXHoBzvcw45N6l9zhf7AwpAlwmUcyoy5+Wfbh2
         6QFrW/YzitORyuThX71GzERvxpajfVdDLKc5VBMfiYNRQJv2ZYly/rGZvn3jssWtum
         IrMM5sqA98dRiyJmdjjMDzuPFUB+hj92XCnEqo6n8yQr1rkiC3/grnCvSg2+Qq3bYG
         YEI9yQRmWEOsw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc:     gregory.greenman@intel.com, linux-wireless@vger.kernel.org,
        Takayuki Nagata <tnagata@redhat.com>,
        Petr Stourac <pstourac@redhat.com>
Subject: Re: [PATCH] iwlwifi: mvm: fix double list_add at iwl_mvm_mac_wake_tx_queue
References: <20220719153542.81466-1-jtornosm@redhat.com>
Date:   Wed, 27 Jul 2022 09:21:35 +0300
In-Reply-To: <20220719153542.81466-1-jtornosm@redhat.com> (Jose Ignacio Tornos
        Martinez's message of "Tue, 19 Jul 2022 17:35:42 +0200")
Message-ID: <87a68vkrdc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jose Ignacio Tornos Martinez <jtornosm@redhat.com> writes:

> After successfull station association, if station queues are disabled for
> some reason, the related lists are not emptied. So if some new element is
> added to the list in iwl_mvm_mac_wake_tx_queue, it can match with the old
> one and produce a BUG like this:
>
> [   46.535263] list_add corruption. prev->next should be next (ffff94c1c318a360), but was 0000000000000000. (prev=ffff94c1d02d3388).
> [   46.535283] ------------[ cut here ]------------
> [   46.535284] kernel BUG at lib/list_debug.c:26!
> [   46.535290] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   46.585304] CPU: 0 PID: 623 Comm: wpa_supplicant Not tainted 5.19.0-rc3+ #1
> [   46.592380] Hardware name: Dell Inc. Inspiron 660s/0478VN       , BIOS A07 08/24/2012
> [   46.600336] RIP: 0010:__list_add_valid.cold+0x3d/0x3f
> [   46.605475] Code: f2 4c 89 c1 48 89 fe 48 c7 c7 c8 40 67 93 e8 20 cc fd ff 0f 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 70 40 67 93 e8 09 cc fd ff <0f> 0b 48 89 fe 48 c7 c7 00 41 67 93 e8 f8 cb fd ff 0f 0b 48 89 d1
> [   46.624469] RSP: 0018:ffffb20800ab76d8 EFLAGS: 00010286
> [   46.629854] RAX: 0000000000000075 RBX: ffff94c1c318a0e0 RCX: 0000000000000000
> [   46.637105] RDX: 0000000000000201 RSI: ffffffff9365e100 RDI: 00000000ffffffff
> [   46.644356] RBP: ffff94c1c5f43370 R08: 0000000000000075 R09: 3064316334396666
> [   46.651607] R10: 3364323064316334 R11: 39666666663d7665 R12: ffff94c1c5f43388
> [   46.658857] R13: ffff94c1d02d3388 R14: ffff94c1c318a360 R15: ffff94c1cf2289c0
> [   46.666108] FS:  00007f65634ff7c0(0000) GS:ffff94c1da200000(0000) knlGS:0000000000000000
> [   46.674331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.680170] CR2: 00007f7dfe984460 CR3: 000000010e894003 CR4: 00000000000606f0
> [   46.687422] Call Trace:
> [   46.689906]  <TASK>
> [   46.691950]  iwl_mvm_mac_wake_tx_queue+0xec/0x15c [iwlmvm]
> [   46.697601]  ieee80211_queue_skb+0x4b3/0x720 [mac80211]
> [   46.702973]  ? sta_info_get+0x46/0x60 [mac80211]
> [   46.707703]  ieee80211_tx+0xad/0x110 [mac80211]
> [   46.712355]  __ieee80211_tx_skb_tid_band+0x71/0x90 [mac80211]
> ...
>
> In order to avoid this problem, we must also remove the related lists when
> station queues are disabled.
>
> Fixes: cfbc6c4c5b91c ("iwlwifi: mvm: support mac80211 TXQs model")
> Reported-by: Takayuki Nagata <tnagata@redhat.com>
> Reported-by: Petr Stourac <pstourac@redhat.com>
> Tested-by: Petr Stourac <pstourac@redhat.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Gregory, I'll take also this directly to wireless-next, ok?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
