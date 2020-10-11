Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D128A9A4
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Oct 2020 21:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgJKT3e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Oct 2020 15:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgJKT3e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Oct 2020 15:29:34 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD1EC0613CE
        for <linux-wireless@vger.kernel.org>; Sun, 11 Oct 2020 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vYr/0qS9baILVUt6efTRhTyMnHQZBwitAl2nfLiCECg=; b=nc01MhEoyYGv5aR+0aWSrMQ11i
        r9kREKCE8j/2dEn+o/KkOOm1nUMKBKwy3KjP++jBZmQ4dXfdHWB6xHjXgGlfadLpBQlHS9XOHF0er
        V7/9IsTcp3GvnQiDiT0vwh5SNIEI/KHMri8ySvvp3W7W2/o5vHSBOE5LFfpmZMeFTPnQ=;
Received: from p54ae9462.dip0.t-ipconnect.de ([84.174.148.98] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kRh2C-0006Gn-DZ; Sun, 11 Oct 2020 21:29:32 +0200
Subject: Re: [PATCH] mt76: dma: fix possible deadlock running mt76_dma_cleanup
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
References: <85eb01e17c3214103bf3b4a62ab4d722d9a017a1.1602004125.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <59f21735-1ffc-a596-608f-083a236357c0@nbd.name>
Date:   Sun, 11 Oct 2020 21:29:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <85eb01e17c3214103bf3b4a62ab4d722d9a017a1.1602004125.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-10-06 19:13, Lorenzo Bianconi wrote:
> Fix the following possible deadlock reported by lockdep disabling BH
> running __mt76_get_txwi/mt76_put_txwi
> 
> ================================
> WARNING: inconsistent lock state
> 5.9.0-rc6 #14 Not tainted
> --------------------------------
> inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> rmmod/1227 [HC0[0]:SC0[0]:HE1:SE1] takes:
> ffff888156a83530 (&dev->lock#2){+.?.}-{2:2}, at: mt76_dma_cleanup+0x125/0x150 [mt76]
> {IN-SOFTIRQ-W} state was registered at:
>   __lock_acquire+0x20c/0x6b0
>   lock_acquire+0x9d/0x220
>   _raw_spin_lock+0x2c/0x70
>   mt76_dma_tx_cleanup+0xc7/0x200 [mt76]
>   mt76x02_poll_tx+0x31/0xb0 [mt76x02_lib]
>   napi_poll+0x3a/0x100
>   net_rx_action+0xa8/0x200
>   __do_softirq+0xc4/0x430
>   asm_call_on_stack+0xf/0x20
>   do_softirq_own_stack+0x49/0x60
>   irq_exit_rcu+0x9a/0xd0
>   common_interrupt+0xa4/0x190
>   asm_common_interrupt+0x1e/0x40
> irq event stamp: 9915
> hardirqs last  enabled at (9915): [<ffffffff8124e286>] __free_pages_ok+0x336/0x3b0
> hardirqs last disabled at (9914): [<ffffffff8124e24e>] __free_pages_ok+0x2fe/0x3b0
> softirqs last  enabled at (9912): [<ffffffffa03aa672>] mt76_dma_rx_cleanup+0xa2/0x120 [mt76]
> softirqs last disabled at (9846): [<ffffffffa03aa5ea>] mt76_dma_rx_cleanup+0x1a/0x120 [mt76]
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&dev->lock#2);
>   <Interrupt>
>     lock(&dev->lock#2);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by rmmod/1227:
>  #0: ffff88815b5eb240 (&dev->mutex){....}-{3:3}, at: driver_detach+0xb5/0x110
> 
> stack backtrace:
> CPU: 1 PID: 1227 Comm: rmmod Kdump: loaded Not tainted 5.9.0-rc6-wdn-src+ #14
> Hardware name: Dell Inc. Studio XPS 1340/0K183D, BIOS A11 09/08/2009
> Call Trace:
>  dump_stack+0x77/0xa0
>  mark_lock_irq.cold+0x15/0x39
>  mark_lock+0x1fc/0x500
>  mark_usage+0xc7/0x140
>  __lock_acquire+0x20c/0x6b0
>  ? find_held_lock+0x2b/0x80
>  ? sched_clock_cpu+0xc/0xb0
>  lock_acquire+0x9d/0x220
>  ? mt76_dma_cleanup+0x125/0x150 [mt76]
>  _raw_spin_lock+0x2c/0x70
>  ? mt76_dma_cleanup+0x125/0x150 [mt76]
>  mt76_dma_cleanup+0x125/0x150 [mt76]
>  mt76x2_cleanup+0x5a/0x70 [mt76x2e]
>  mt76x2e_remove+0x18/0x30 [mt76x2e]
>  pci_device_remove+0x36/0xa0
>  __device_release_driver+0x16c/0x220
>  driver_detach+0xcf/0x110
>  bus_remove_driver+0x56/0xca
>  pci_unregister_driver+0x36/0x80
>  __do_sys_delete_module.constprop.0+0x127/0x200
>  ? syscall_enter_from_user_mode+0x1d/0x50
>  ? trace_hardirqs_on+0x1c/0xe0
>  do_syscall_64+0x33/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7ff0da54e36b
> Code: 73 01 c3 48 8b 0d 2d 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd 0a 0c 00 f7 d8 64 89 01 48
> 
> Fixes: dd57a95cfddc ("mt76: move txwi handling code to dma.c, since it is mmio specific")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/dma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
> index 214fc95b8a33..9ea6df9ecd01 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -33,13 +33,13 @@ __mt76_get_txwi(struct mt76_dev *dev)
>  {
>  	struct mt76_txwi_cache *t = NULL;
>  
> -	spin_lock(&dev->lock);
> +	spin_lock_bh(&dev->lock);
>  	if (!list_empty(&dev->txwi_cache)) {
>  		t = list_first_entry(&dev->txwi_cache, struct mt76_txwi_cache,
>  				     list);
>  		list_del(&t->list);
>  	}
> -	spin_unlock(&dev->lock);
> +	spin_unlock_bh(&dev->lock);
I think we should fix this one by adding local_bh_disable/enable in
mt76_dma_cleanup instead.

- Felix
