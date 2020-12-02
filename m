Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF102CC630
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 20:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgLBTHB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 14:07:01 -0500
Received: from m42-5.mailgun.net ([69.72.42.5]:59352 "EHLO m42-5.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730896AbgLBTHA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 14:07:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606935995; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=JyBhRR7psqFMO9ysCo94QOS2xhmhb8b/BpOR8uxVeVY=;
 b=aRcKzEyjQvlC02kguAYhj0orTV4nk+oERjlqbRNQ5BloWe3aqTUTveM2CaEyNbJROb/T/efo
 rPUc3lx6qvVXtcCBFn/2jmyiGvYpQrpMPV1LRUTVNEVvfLCReOHbqnhPtTyT7Rd4rE+DbXMh
 B1PvpG/Y9UAq/Ivp53L8CsMkClA=
X-Mailgun-Sending-Ip: 69.72.42.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fc7e5ba4a918fcc079ded74 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 19:06:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DC2CCC43462; Wed,  2 Dec 2020 19:06:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C6BCC433ED;
        Wed,  2 Dec 2020 19:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C6BCC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.10] mt76: usb: fix crash on device removal
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201126125520.72912-1-stf_xl@wp.pl>
References: <20201126125520.72912-1-stf_xl@wp.pl>
To:     stf_xl@wp.pl
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201202190634.DC2CCC43462@smtp.codeaurora.org>
Date:   Wed,  2 Dec 2020 19:06:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

stf_xl@wp.pl wrote:

> From: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> Currently 'while (q->queued > 0)' loop was removed from mt76u_stop_tx()
> code. This causes crash on device removal as we try to cleanup empty
> queue:
> 
> [   96.495571] kernel BUG at include/linux/skbuff.h:2297!
> [   96.498983] invalid opcode: 0000 [#1] SMP PTI
> [   96.501162] CPU: 3 PID: 27 Comm: kworker/3:0 Not tainted 5.10.0-rc5+ #11
> [   96.502754] Hardware name: LENOVO 20DGS08H00/20DGS08H00, BIOS J5ET48WW (1.19 ) 08/27/2015
> [   96.504378] Workqueue: usb_hub_wq hub_event
> [   96.505983] RIP: 0010:skb_pull+0x2d/0x30
> [   96.507576] Code: 00 00 8b 47 70 39 c6 77 1e 29 f0 89 47 70 3b 47 74 72 17 48 8b 87 c8 00 00 00 89 f6 48 01 f0 48 89 87 c8 00 00 00 c3 31 c0 c3 <0f> 0b 90 0f 1f 44 00 00 53 48 89 fb 48 8b bf c8 00 00 00 8b 43 70
> [   96.509296] RSP: 0018:ffffb11b801639b8 EFLAGS: 00010287
> [   96.511038] RAX: 000000001c6939ed RBX: ffffb11b801639f8 RCX: 0000000000000000
> [   96.512964] RDX: ffffb11b801639f8 RSI: 0000000000000018 RDI: ffff90c64e4fb800
> [   96.514710] RBP: ffff90c654551ee0 R08: ffff90c652bce7a8 R09: ffffb11b80163728
> [   96.516450] R10: 0000000000000001 R11: 0000000000000001 R12: ffff90c64e4fb800
> [   96.519749] R13: 0000000000000010 R14: 0000000000000020 R15: ffff90c64e352ce8
> [   96.523455] FS:  0000000000000000(0000) GS:ffff90c96eec0000(0000) knlGS:0000000000000000
> [   96.527171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   96.530900] CR2: 0000242556f18288 CR3: 0000000146a10002 CR4: 00000000003706e0
> [   96.534678] Call Trace:
> [   96.538418]  mt76x02u_tx_complete_skb+0x1f/0x50 [mt76x02_usb]
> [   96.542231]  mt76_queue_tx_complete+0x23/0x50 [mt76]
> [   96.546028]  mt76u_stop_tx.cold+0x71/0xa2 [mt76_usb]
> [   96.549797]  mt76x0u_stop+0x2f/0x90 [mt76x0u]
> [   96.553638]  drv_stop+0x33/0xd0 [mac80211]
> [   96.557449]  ieee80211_do_stop+0x558/0x860 [mac80211]
> [   96.561262]  ? dev_deactivate_many+0x298/0x2d0
> [   96.565101]  ieee80211_stop+0x16/0x20 [mac80211]
> 
> Fix that by adding while loop again. We need loop, not just single
> check, to clean all pending entries.
> 
> Additionally move mt76_worker_disable/enable after !mt76_has_tx_pending()
> as we want to tx_worker to run to process tx queues, while we wait for
> exactly that.
> 
> I was a bit worried about accessing q->queued without lock, but
> mt76_worker_disable() -> kthread_park() should assure this value will
> be seen updated on other cpus.
> 
> Fixes: fe5b5ab52e9d ("mt76: unify queue tx cleanup code")
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> Acked-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-drivers.git, thanks.

807982017730 mt76: usb: fix crash on device removal

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201126125520.72912-1-stf_xl@wp.pl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

