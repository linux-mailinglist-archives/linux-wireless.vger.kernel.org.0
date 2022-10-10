Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E475F9BBF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 11:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiJJJTQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 05:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJJJTP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 05:19:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEF44A801
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 02:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C757FB80D2B
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 09:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AED1C433B5;
        Mon, 10 Oct 2022 09:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665393551;
        bh=1QXyosa5SWh/8hByl5+x8fW8HWjgC+y2dyZ7k9YzSAw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZlaZeZf86q/1yjuTnpNqGItmeQEZ6LXdc7kOZPG6HY10osL/6IvzLcOykh5vUgrgK
         Mz9YbTIGw+RPn2t2f65+zJwjuef+ei6JyQYJEbLa4elKBVCFbOMGyGNSJVyGHCvBSv
         XVG27di3fTYnZTHu8lLW9YAM4ntivcYZoOHC2CHUtHUbvbxmiaQVqO9msbwMGKtWzq
         Vl3JS3ijQVgBb6GjOrhfVmfjt45ttT8FtrjGJYXARSAKdgBbt5Hx9CGRPfZWhGw+4u
         LthAeD8sgnhIbm7s69Y3hzk2h6QzF4n66m7QMo3C3wh2/eokgqxKU36lVmlCyAd1Kc
         a6LmlJiFqd/tA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc:     gregory.greenman@intel.com, linux-wireless@vger.kernel.org,
        pstourac@redhat.com
Subject: Re: [PATCH v2] iwlwifi: mvm: fix double list_add at iwl_mvm_mac_wake_tx_queue (other cases)
References: <20220909121235.575541-1-jtornosm@redhat.com>
        <20221010081611.145027-1-jtornosm@redhat.com>
Date:   Mon, 10 Oct 2022 12:19:05 +0300
In-Reply-To: <20221010081611.145027-1-jtornosm@redhat.com> (Jose Ignacio
        Tornos Martinez's message of "Mon, 10 Oct 2022 10:16:11 +0200")
Message-ID: <87pmf0ox2u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jose Ignacio Tornos Martinez <jtornosm@redhat.com> writes:

> BUGs like this are still reproducible:
>
> [   31.509616] list_add corruption. prev->next should be next (ffff8f8644242300), but was ffff8f86493fd300. (prev=ffff8f86493fd300).
> [   31.521544] ------------[ cut here ]------------
> [   31.526248] kernel BUG at lib/list_debug.c:30!
> [   31.530781] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   31.535831] CPU: 1 PID: 626 Comm: wpa_supplicant Not tainted 6.0.0+ #7
> [   31.542450] Hardware name: Dell Inc. Inspiron 660s/0478VN       , BIOS A07 08/24/2012
> [   31.550484] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
> [   31.555537] Code: f2 4c 89 c1 48 89 fe 48 c7 c7 28 20 69 89 e8 4c e3 fd ff 0f 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 d0 1f 69 89 e8 35 e3 fd ff <0f> 0b 4c 89 c1 48 c7 c7 78 1f 69 89 e8 24 e3 fd ff 0f 0b 48 c7 c7
> [   31.574605] RSP: 0018:ffff9f6f00dc3748 EFLAGS: 00010286
> [   31.579990] RAX: 0000000000000075 RBX: ffff8f8644242080 RCX: 0000000000000000
> [   31.587155] RDX: 0000000000000201 RSI: ffffffff8967862d RDI: 00000000ffffffff
> [   31.594482] RBP: ffff8f86493fd2e8 R08: 0000000000000000 R09: 00000000ffffdfff
> [   31.601735] R10: ffff9f6f00dc3608 R11: ffffffff89f46128 R12: ffff8f86493fd300
> [   31.608986] R13: ffff8f86493fd300 R14: ffff8f8644242300 R15: ffff8f8643dd3f2c
> [   31.616151] FS:  00007f3bb9a707c0(0000) GS:ffff8f865a300000(0000) knlGS:0000000000000000
> [   31.624447] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   31.630286] CR2: 00007fe3647d5600 CR3: 00000001125a6002 CR4: 00000000000606e0
> [   31.637539] Call Trace:
> [   31.639936]  <TASK>
> [   31.642143]  iwl_mvm_mac_wake_tx_queue+0x71/0x90 [iwlmvm]
> [   31.647569]  ieee80211_queue_skb+0x4b6/0x720 [mac80211]
> ...
>
> So, it is necessary to extend the applied solution with commit 14a3aacf517a9
> ("iwlwifi: mvm: fix double list_add at iwl_mvm_mac_wake_tx_queue")
> to all other cases where the station queues are invalidated and the related
> lists are not emptied. Because, otherwise as before, if some new element is 
> added later to the list in iwl_mvm_mac_wake_tx_queue, it can match with the 
> old one and produce the same commented BUG.
>
> That is, in order to avoid this problem completely, we must also remove the 
> related lists for the other cases when station queues are invalidated.
>
> Fixes: cfbc6c4c5b91c ("iwlwifi: mvm: support mac80211 TXQs model")
> Reported-by: Petr Stourac <pstourac@redhat.com>
> Tested-by: Petr Stourac <pstourac@redhat.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Gregory, can I take this to wireless tree? I already assigned it to me
on patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
