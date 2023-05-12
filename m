Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE670026D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 10:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbjELIXf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbjELIXe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 04:23:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE41100F9;
        Fri, 12 May 2023 01:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A64156101A;
        Fri, 12 May 2023 08:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC371C433D2;
        Fri, 12 May 2023 08:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683879812;
        bh=aLJHJyS6M5h//+PXaHvfKDzdnL/8X0VG4qSLx9RFM/A=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aoAMyCkj2w7Hj80ebERcPH6fSSPGQVZ7CcyvePXfsdY+EpUgWQBrVu4tkzR30HxAS
         wrPTLW8l/N05eO+0NGUTX5PbsHQ5XR3a+frYoF4fEqFUJeOdfSoDYI+hf6wqed8LMx
         q6+E0yi4j1PCmbFUpybuijF8vJaoP03E4vHtHYVs010VebhBDMJwhlljDloF6072L/
         CjwDsDc6ln+bJBjnTaBbuPn/Fw1JO46I97hv85XzUoD6X0zswvceNDbRq4xGXBP3rT
         mG9zx0abif1D6L83xsMhAD/9LTJVDF424le7LU6Pbv4PEp0UkBhx/smKvJWqdvjYuA
         NIglR9W9sZsCA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: use work to update rate to avoid RCU warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230508085429.46653-1-pkshih@realtek.com>
References: <20230508085429.46653-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <stable@vger.kernel.org>,
        <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168387980651.10206.1005057675722458489.kvalo@kernel.org>
Date:   Fri, 12 May 2023 08:23:30 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The ieee80211_ops::sta_rc_update must be atomic, because
> ieee80211_chan_bw_change() holds rcu_read lock while calling
> drv_sta_rc_update(), so create a work to do original things.
> 
>  Voluntary context switch within RCU read-side critical section!
>  WARNING: CPU: 0 PID: 4621 at kernel/rcu/tree_plugin.h:318
>  rcu_note_context_switch+0x571/0x5d0
>  CPU: 0 PID: 4621 Comm: kworker/u16:2 Tainted: G        W  OE
>  Workqueue: phy3 ieee80211_chswitch_work [mac80211]
>  RIP: 0010:rcu_note_context_switch+0x571/0x5d0
>  Call Trace:
>   <TASK>
>   __schedule+0xb0/0x1460
>   ? __mod_timer+0x116/0x360
>   schedule+0x5a/0xc0
>   schedule_timeout+0x87/0x150
>   ? trace_raw_output_tick_stop+0x60/0x60
>   wait_for_completion_timeout+0x7b/0x140
>   usb_start_wait_urb+0x82/0x160 [usbcore
>   usb_control_msg+0xe3/0x140 [usbcore
>   rtw_usb_read+0x88/0xe0 [rtw_usb
>   rtw_usb_read8+0xf/0x10 [rtw_usb
>   rtw_fw_send_h2c_command+0xa0/0x170 [rtw_core
>   rtw_fw_send_ra_info+0xc9/0xf0 [rtw_core
>   drv_sta_rc_update+0x7c/0x160 [mac80211
>   ieee80211_chan_bw_change+0xfb/0x110 [mac80211
>   ieee80211_change_chanctx+0x38/0x130 [mac80211
>   ieee80211_vif_use_reserved_switch+0x34e/0x900 [mac80211
>   ieee80211_link_use_reserved_context+0x88/0xe0 [mac80211
>   ieee80211_chswitch_work+0x95/0x170 [mac80211
>   process_one_work+0x201/0x410
>   worker_thread+0x4a/0x3b0
>   ? process_one_work+0x410/0x410
>   kthread+0xe1/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x1f/0x30
>   </TASK>
> 
> Cc: stable@vger.kernel.org
> Fixes: c1edc86472fc ("rtw88: add ieee80211:sta_rc_update ops")
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Link: https://lore.kernel.org/linux-wireless/f1e31e8e-f84e-3791-50fb-663a83c5c6e9@lwfinger.net/T/#t
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless.git, thanks.

bcafcb959a57 wifi: rtw88: use work to update rate to avoid RCU warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230508085429.46653-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

