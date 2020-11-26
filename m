Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808482C5671
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 14:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390608AbgKZNtY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 08:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731417AbgKZNtY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 08:49:24 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D667C0613D4
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NXCdKIn17deszv6wrpX1f26AnC9C2tl3gjLUzBoGz+A=; b=HMmpDnBLsBnk3sWMHFleaaAAWZ
        otVKc16kSvXf1iMEF9vbOEKE1nfzWxp0m4ZyZnh7+xeFZfzkhjnK18y4TiH/Q6pGEEYYm7F6tc3an
        7bxJNJC7g3KsXc+314ywXLtsHka4KhXyhTLxNZBwxij1aswmzslvlbuVb4wka312sRx8=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kiHeD-00021K-JL; Thu, 26 Nov 2020 14:49:21 +0100
Subject: Re: [PATCH 5.10] mt76: usb: fix crash on device removal
To:     stf_xl@wp.pl, linux-wireless@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20201126125520.72912-1-stf_xl@wp.pl>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <33c3d769-aed9-1ef9-f791-cf3618ea3ad1@nbd.name>
Date:   Thu, 26 Nov 2020 14:49:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126125520.72912-1-stf_xl@wp.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-26 13:55, stf_xl@wp.pl wrote:
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
Acked-by: Felix Fietkau <nbd@nbd.name>

Thanks,

- Felix
