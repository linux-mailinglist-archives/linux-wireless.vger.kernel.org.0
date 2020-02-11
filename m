Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7361598D6
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 19:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgBKSiP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 13:38:15 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:15593 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728725AbgBKSiP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 13:38:15 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 13:38:14 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581446294; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Wt8xNyJIiPUfFnO+TEUKnzTg1LxDNvsSL+qq+NVgZpA=;
 b=IHhp7JFaBngpl/FfIT4cUv4uAQ/fPZYrMpOGFqi9+fJF2M3pXfteVr86RUUQG3MlLbtEOE4K
 at6ffj5XC3tkFMYFd8Xlz1QYROMzE7w9AT1Z8vhKQXSfLkK5uwDeLmedXwpC7xNnWNqtVgH+
 l6hI2Y0RnXBFVbPM6TU9ZIw//6w=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e42f363.7fa54a5e4b90-smtp-out-n01;
 Tue, 11 Feb 2020 18:33:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 962C6C4479C; Tue, 11 Feb 2020 18:33:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27B70C433A2;
        Tue, 11 Feb 2020 18:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27B70C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix warn-on in disassociation
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1580865828-31330-1-git-send-email-periyasa@codeaurora.org>
References: <1580865828-31330-1-git-send-email-periyasa@codeaurora.org>
To:     Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200211183306.962C6C4479C@smtp.codeaurora.org>
Date:   Tue, 11 Feb 2020 18:33:06 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <periyasa@codeaurora.org> wrote:

> In multi AP VAP scenario, when user bring down the interfaces. mac80211 mark
> the interface down for the duplicated VAP and removed from the
> local->interfaces list. ath11k_mac_get_arvif() is dependent on
> ieee80211_iterate_active_interfaces_atomic() API to find the vdev id
> in a given radio. In disassociation path, ath11k_mac_get_arvif() not
> able to find the given vdev id since that VAP is removed from the
> local->interfaces list. since sta_state callback throws error, mac80211 log
> the below WARN_ON_ONCE message.
> 
> Fixed it by storing the allocated_vdev_map in each radio structure to maintain
> the created vdev id bits. so that we can directly mask this against the given
> vdev_id to find out the ar from the vdev_id.
> 
> WARN LOG:
> 
> WARNING: at net/mac80211/sta_info.c:1008
> CPU: 2 PID: 2135 Comm: hostapd Not tainted #1
> Hardware name: Qualcomm Technologies, Inc. IPQ807x/AP-HK01-C1 (DT)
> task: ffffffc03a43d800 ti: ffffffc03a43d800 task.ti: ffffffc03a43d800
> PC is at sta_set_sinfo+0x9dc/0xad4 [mac80211]
> LR is at sta_set_sinfo+0x9cc/0xad4 [mac80211]
> pc : [<ffffffbffce2a008>] lr : [<ffffffbffce29ff8>] pstate: 20000145
> sp : ffffffc02cedb5f0
> x29: ffffffc02cedb5f0 x28: ffffffc03a43d800
> x27: 0000000000000014 x26: 0000000000000001
> x25: ffffffc02cfc4000 x24: ffffffc036905508
> x23: 0000000000000012 x22: ffffffc02cedb670
> x21: ffffffc03bc64880 x20: ffffffc036904f80
> x19: ffffffc02ae31000 x18: 00000000b019f3a1
> x17: 0000000057f30331 x16: 00000000d8d1998e
> x15: 0000000000000066 x14: 393a35383a36343a
> x13: 6337203a6e6f6974 x12: 6174732065746169
> x11: 636f737361736964 x10: 206f742064656c69
> x9 : 6146203a31696669 x8 : 6337203a6e6f6974
> x7 : 6174732065746169 x6 : ffffffc0008c33f6
> x5 : 0000000000000000 x4 : 0000000000000000
> x3 : 0000000000000000 x2 : 00000000ffffff92
> x1 : 0000000000000000 x0 : ffffffbffcea1091
> ---[ end trace 63c4b1c527345d5a ]---
> Call trace:
> [<ffffffbffce2a008>] sta_set_sinfo+0x9dc/0xad4 [mac80211]
> [<ffffffbffce2a2c4>] __sta_info_flush+0xec/0x130 [mac80211]
> [<ffffffbffce3dc48>] ieee80211_nan_func_match+0x1a34/0x23e4 [mac80211]
> [<ffffffbffcde03e0>] __cfg80211_stop_ap+0x60/0xf0 [cfg80211]
> [<ffffffbffcdb6d08>] __cfg80211_leave+0x110/0x150 [cfg80211]
> [<ffffffbffcdb6d78>] cfg80211_leave+0x30/0x48 [cfg80211]
> [<ffffffbffcdb6fbc>] cfg80211_init_wdev+0x22c/0x808 [cfg80211]
> [<ffffffc0000afe28>] notifier_call_chain+0x50/0x84
> [<ffffffc0000afefc>] raw_notifier_call_chain+0x14/0x1c
> [<ffffffc0004ae94c>] call_netdevice_notifiers_info+0x5c/0x6c
> [<ffffffc0004ae96c>] call_netdevice_notifiers+0x10/0x18
> [<ffffffc0004aea80>] __dev_close_many+0x54/0xc0
> [<ffffffc0004aeb50>] dev_close_many+0x64/0xdc
> [<ffffffc0004b0b70>] rollback_registered_many+0x138/0x2f4
> [<ffffffc0004b0d4c>] rollback_registered+0x20/0x34
> [<ffffffc0004b34b4>] unregister_netdevice_queue+0x68/0xa8
> [<ffffffbffce3870c>] ieee80211_if_remove+0x84/0xc0 [mac80211]
> [<ffffffbffce3e588>] ieee80211_nan_func_match+0x2374/0x23e4 [mac80211]
> [<ffffffbffcdc29e8>] cfg80211_wext_giwscan+0x1000/0x1140 [cfg80211]
> [<ffffffbffcb2a87c>] backport_genlmsg_multicast_allns+0x158/0x1b4 [compat]
> [<ffffffc0004e0944>] genl_family_rcv_msg+0x258/0x2c0
> [<ffffffc0004e09f4>] genl_rcv_msg+0x48/0x6c
> [<ffffffc0004dfb50>] netlink_rcv_skb+0x5c/0xc4
> [<ffffffc0004e06d8>] genl_rcv+0x34/0x48
> [<ffffffc0004df570>] netlink_unicast+0x12c/0x1e0
> [<ffffffc0004df9a4>] netlink_sendmsg+0x2bc/0x2dc
> [<ffffffc00049a540>] sock_sendmsg+0x18/0x2c
> [<ffffffc00049ab94>] ___sys_sendmsg+0x1bc/0x248
> [<ffffffc00049ba24>] __sys_sendmsg+0x40/0x68
> [<ffffffc00049ba5c>] SyS_sendmsg+0x10/0x20
> [<ffffffc000085db0>] el0_svc_naked+0x24/0x28
> 
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

79c080dbe35b ath11k: fix warn-on in disassociation

-- 
https://patchwork.kernel.org/patch/11365673/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
