Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5337345AF5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Mar 2021 10:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhCWJgF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Mar 2021 05:36:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38948 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhCWJfg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Mar 2021 05:35:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616492136; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=qfaC1i4qa4JUCrl8hEFqEKmLg01NZUUXg1FfT2rZ4og=;
 b=g0x6pn68C//AdFm4jiNp3UDesDKxPxBbSZq2uxKp4s/C7hkp24RmrNC3F2xkefxMXUMJFbvd
 G+MxloEhxZiahkErLPIir+arXBumPKLdwajBeStWPnmOwpIx31DH0He5W/w8wSyC6cnE86XA
 l+rENTgUCJiKNfmc3LAfswz2UJ8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6059b661e2200c0a0dc0461c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Mar 2021 09:35:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5001C433C6; Tue, 23 Mar 2021 09:35:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6276C433ED;
        Tue, 23 Mar 2021 09:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6276C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_enqueue_hcmd()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210323093528.B5001C433C6@smtp.codeaurora.org>
Date:   Tue, 23 Mar 2021 09:35:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jiri Kosina <jikos@kernel.org> wrote:

> From: Jiri Kosina <jkosina@suse.cz>
> 
> It's possible for iwl_pcie_enqueue_hcmd() to be called with hard IRQs 
> disabled (e.g. from LED core). We can't enable BHs in such a situation.
> 
> Turn the unconditional BH-enable/BH-disable code into 
> hardirq-disable/conditional-enable.
> 
> This fixes the warning below.
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
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v12.0.0-rc3
> Acked-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

2800aadc18a6 iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

