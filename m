Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC97A330955
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Mar 2021 09:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCHIZ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Mar 2021 03:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhCHIZo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Mar 2021 03:25:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16CDA650BB;
        Mon,  8 Mar 2021 08:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615191944;
        bh=PZJ9xgYcIRCW9QstApuIqwb3j5m9rBrgIv1n3GQDjTE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BGeWzhRypRswFeikw0zas7H6LxlB/bq41DCsSEORxKCkiF2ztDtAExUTmXvrqj/nB
         CTs9kYc56PeSCr1/RScwX61yhCH9MyeFJLxtwRdTvcOZWCDVstWRGi98IUkrUVkFfB
         D1WZVtNWJ0JN2qPiwuPgHhu2xsoK3Lx+Pl9XPdqK27jamAlcUf97jfCr+bHUEwTtB0
         cDp13R+YQT8xkNlkwZudvf05gD3ngLx71qtwGxRHzRAIq7e5wqmCf337JoW3pBTzzq
         el+gWnY53ooHhonmz18Io63EsMZAPMFobAFE+gqOprXvT9wNcQOuWfGin8G1q3Jitx
         63Gaa0as3TQpw==
Date:   Mon, 8 Mar 2021 09:25:40 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_enqueue_hcmd()
In-Reply-To: <nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2103080925230.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2 Mar 2021, Jiri Kosina wrote:

> From: Jiri Kosina <jkosina@suse.cz>
> 
> It's possible for iwl_pcie_enqueue_hcmd() to be called with hard IRQs 
> disabled (e.g. from LED core). We can't enable BHs in such a situation.
> 
> Turn the unconditional BH-enable/BH-disable code into 
> hardirq-disable/conditional-enable.
> 
> This fixes the warning below.

Hi,

friendly ping on this one ... 

Thanks!

> 
>  WARNING: CPU: 1 PID: 1139 at kernel/softirq.c:178 __local_bh_enable_ip+0xa5/0xf0
>  CPU: 1 PID: 1139 Comm: NetworkManager Not tainted 5.12.0-rc1-00004-gb4ded168af79 #7
>  Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/31/2017
>  RIP: 0010:__local_bh_enable_ip+0xa5/0xf0
>  Code: f7 69 e8 ee 23 14 00 fb 66 0f 1f 44 00 00 65 8b 05 f0 f4 f7 69 85 c0 74 3f 48 83 c4 08 5b c3 65 8b 05 9b fe f7 69 85 c0 75 8e <0f> 0b eb 8a 48 89 3c 24 e8 4e 20 14 00 48 8b 3c 24 eb 91 e8 13 4e
>  RSP: 0018:ffffafd580b13298 EFLAGS: 00010046
>  RAX: 0000000000000000 RBX: 0000000000000201 RCX: 0000000000000000
>  RDX: 0000000000000003 RSI: 0000000000000201 RDI: ffffffffc1272389
>  RBP: ffff96517ae4c018 R08: 0000000000000001 R09: 0000000000000000
>  R10: ffffafd580b13178 R11: 0000000000000001 R12: ffff96517b060000
>  R13: 0000000000000000 R14: ffffffff80000000 R15: 0000000000000001
>  FS:  00007fc604ebefc0(0000) GS:ffff965267480000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055fb3fef13b2 CR3: 0000000109112004 CR4: 00000000003706e0
>  Call Trace:
>   ? _raw_spin_unlock_bh+0x1f/0x30
>   iwl_pcie_enqueue_hcmd+0x5d9/0xa00 [iwlwifi]
>   iwl_trans_txq_send_hcmd+0x6c/0x430 [iwlwifi]
>   iwl_trans_send_cmd+0x88/0x170 [iwlwifi]
>   ? lock_acquire+0x277/0x3d0
>   iwl_mvm_send_cmd+0x32/0x80 [iwlmvm]
>   iwl_mvm_led_set+0xc2/0xe0 [iwlmvm]
>   ? led_trigger_event+0x46/0x70
>   led_trigger_event+0x46/0x70
>   ieee80211_do_open+0x5c5/0xa20 [mac80211]
>   ieee80211_open+0x67/0x90 [mac80211]
>   __dev_open+0xd4/0x150
>   __dev_change_flags+0x19e/0x1f0
>   dev_change_flags+0x23/0x60
>   do_setlink+0x30d/0x1230
>   ? lock_is_held_type+0xb4/0x120
>   ? __nla_validate_parse.part.7+0x57/0xcb0
>   ? __lock_acquire+0x2e1/0x1a50
>   __rtnl_newlink+0x560/0x910
>   ? __lock_acquire+0x2e1/0x1a50
>   ? __lock_acquire+0x2e1/0x1a50
>   ? lock_acquire+0x277/0x3d0
>   ? sock_def_readable+0x5/0x290
>   ? lock_is_held_type+0xb4/0x120
>   ? find_held_lock+0x2d/0x90
>   ? sock_def_readable+0xb3/0x290
>   ? lock_release+0x166/0x2a0
>   ? lock_is_held_type+0x90/0x120
>   rtnl_newlink+0x47/0x70
>   rtnetlink_rcv_msg+0x25c/0x470
>   ? netlink_deliver_tap+0x97/0x3e0
>   ? validate_linkmsg+0x350/0x350
>   netlink_rcv_skb+0x50/0x100
>   netlink_unicast+0x1b2/0x280
>   netlink_sendmsg+0x336/0x450
>   sock_sendmsg+0x5b/0x60
>   ____sys_sendmsg+0x1ed/0x250
>   ? copy_msghdr_from_user+0x5c/0x90
>   ___sys_sendmsg+0x88/0xd0
>   ? lock_is_held_type+0xb4/0x120
>   ? find_held_lock+0x2d/0x90
>   ? lock_release+0x166/0x2a0
>   ? __fget_files+0xfe/0x1d0
>   ? __sys_sendmsg+0x5e/0xa0
>   __sys_sendmsg+0x5e/0xa0
>   ? lockdep_hardirqs_on_prepare+0xd9/0x170
>   do_syscall_64+0x33/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7fc605c9572d
>  Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 da ee ff ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 2e ef ff ff 48
>  RSP: 002b:00007fffc83789f0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
>  RAX: ffffffffffffffda RBX: 000055ef468570c0 RCX: 00007fc605c9572d
>  RDX: 0000000000000000 RSI: 00007fffc8378a30 RDI: 000000000000000c
>  RBP: 0000000000000010 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
>  R13: 00007fffc8378b80 R14: 00007fffc8378b7c R15: 0000000000000000
>  irq event stamp: 170785
>  hardirqs last  enabled at (170783): [<ffffffff9609a8c2>] __local_bh_enable_ip+0x82/0xf0
>  hardirqs last disabled at (170784): [<ffffffff96a8613d>] _raw_read_lock_irqsave+0x8d/0x90
>  softirqs last  enabled at (170782): [<ffffffffc1272389>] iwl_pcie_enqueue_hcmd+0x5d9/0xa00 [iwlwifi]
>  softirqs last disabled at (170785): [<ffffffffc1271ec6>] iwl_pcie_enqueue_hcmd+0x116/0xa00 [iwlwifi]
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
> index fb3d2f6299aa..0b35bf258fad 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
> @@ -928,6 +928,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
>  	u32 cmd_pos;
>  	const u8 *cmddata[IWL_MAX_CMD_TBS_PER_TFD];
>  	u16 cmdlen[IWL_MAX_CMD_TBS_PER_TFD];
> +	unsigned long flags;
>  
>  	if (WARN(!trans->wide_cmd_header &&
>  		 group_id > IWL_ALWAYS_LONG_GROUP,
> @@ -1011,10 +1012,10 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
>  		goto free_dup_buf;
>  	}
>  
> -	spin_lock_bh(&txq->lock);
> +	spin_lock_irqsave(&txq->lock, flags);
>  
>  	if (iwl_txq_space(trans, txq) < ((cmd->flags & CMD_ASYNC) ? 2 : 1)) {
> -		spin_unlock_bh(&txq->lock);
> +		spin_unlock_irqrestore(&txq->lock, flags);
>  
>  		IWL_ERR(trans, "No space in command queue\n");
>  		iwl_op_mode_cmd_queue_full(trans->op_mode);
> @@ -1174,7 +1175,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
>   unlock_reg:
>  	spin_unlock(&trans_pcie->reg_lock);
>   out:
> -	spin_unlock_bh(&txq->lock);
> +	spin_unlock_irqrestore(&txq->lock, flags);
>   free_dup_buf:
>  	if (idx < 0)
>  		kfree(dup_buf);
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 

-- 
Jiri Kosina
SUSE Labs

