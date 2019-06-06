Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29FF837C89
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 20:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfFFSsy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 14:48:54 -0400
Received: from mx3.wp.pl ([212.77.101.9]:35642 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbfFFSsy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 14:48:54 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2019 14:48:52 EDT
Received: (wp-smtpd smtp.wp.pl 6363 invoked from network); 6 Jun 2019 20:48:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1559846931; bh=Q4uXcWqxnfiKK35xUxUuDfBI699GZMYJ7M08wC7xsAQ=;
          h=From:To:Cc:Subject;
          b=JmPSPtkLJx4akFIunydHX8/b5U8GyjWpNjNX2BDk2CmITFqWDwN/gcTEWihziUxZc
           E4DgBmCz+FXL6+2dtEmH5dNAxCN2+JBhW1fL6o3r7KQXF9KYYxWm+DEPBDA70dAnIV
           +FL4JIro7d9aRfCIn66GIUo8s39XXj0XsmOJD7rQ=
Received: from 014.152-60-66-biz-static.surewest.net (HELO cakuba.netronome.com) (kubakici@wp.pl@[66.60.152.14])
          (envelope-sender <kubakici@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <lorenzo@kernel.org>; 6 Jun 2019 20:48:50 +0200
Date:   Thu, 6 Jun 2019 11:48:45 -0700
From:   Jakub Kicinski <kubakici@wp.pl>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] mt7601u: fix possible memory leak when the device is
 disconnected
Message-ID: <20190606114845.4026270e@cakuba.netronome.com>
In-Reply-To: <27c6d00cfb5936978cfb8304c6e1f03973905848.1559835089.git.lorenzo@kernel.org>
References: <27c6d00cfb5936978cfb8304c6e1f03973905848.1559835089.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: ec05270bb05e77ce495625164c2f2bce
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [ceNE]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu,  6 Jun 2019 17:34:16 +0200, Lorenzo Bianconi wrote:
> When the device is disconnected while passing traffic it is possible
> to receive out of order urbs causing a memory leak since the skb liked
> to the current tx urb is not removed. Fix the issue deallocating the skb
> cleaning up the tx ring. Moreover this patch fixes the following kernel
> warning

Ugh if we don't have ordering guarantees then the entire "ring" scheme
no longer works :(  Should we move to URB queues, I don't remember now,
but there seem to had been a better way to manage URBs :S

> [   57.480771] usb 1-1: USB disconnect, device number 2
> [   57.483451] ------------[ cut here ]------------
> [   57.483462] TX urb mismatch
> [   57.483481] WARNING: CPU: 1 PID: 32 at drivers/net/wireless/mediatek/mt7601u/dma.c:245 mt7601u_complete_tx+0x165/00
> [   57.483483] Modules linked in:
> [   57.483496] CPU: 1 PID: 32 Comm: kworker/1:1 Not tainted 5.2.0-rc1+ #72
> [   57.483498] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-2.fc30 04/01/2014
> [   57.483502] Workqueue: usb_hub_wq hub_event
> [   57.483507] RIP: 0010:mt7601u_complete_tx+0x165/0x1e0
> [   57.483510] Code: 8b b5 10 04 00 00 8b 8d 14 04 00 00 eb 8b 80 3d b1 cb e1 00 00 75 9e 48 c7 c7 a4 ea 05 82 c6 05 f
> [   57.483513] RSP: 0000:ffffc900000a0d28 EFLAGS: 00010092
> [   57.483516] RAX: 000000000000000f RBX: ffff88802c0a62c0 RCX: ffffc900000a0c2c
> [   57.483518] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff810a8371
> [   57.483520] RBP: ffff88803ced6858 R08: 0000000000000000 R09: 0000000000000001
> [   57.483540] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000046
> [   57.483542] R13: ffff88802c0a6c88 R14: ffff88803baab540 R15: ffff88803a0cc078
> [   57.483548] FS:  0000000000000000(0000) GS:ffff88803eb00000(0000) knlGS:0000000000000000
> [   57.483550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   57.483552] CR2: 000055e7f6780100 CR3: 0000000028c86000 CR4: 00000000000006a0
> [   57.483554] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   57.483556] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   57.483559] Call Trace:
> [   57.483561]  <IRQ>
> [   57.483565]  __usb_hcd_giveback_urb+0x77/0xe0
> [   57.483570]  xhci_giveback_urb_in_irq.isra.0+0x8b/0x140
> [   57.483574]  handle_cmd_completion+0xf5b/0x12c0
> [   57.483577]  xhci_irq+0x1f6/0x1810
> [   57.483581]  ? lockdep_hardirqs_on+0x9e/0x180
> [   57.483584]  ? _raw_spin_unlock_irq+0x24/0x30
> [   57.483588]  __handle_irq_event_percpu+0x3a/0x260
> [   57.483592]  handle_irq_event_percpu+0x1c/0x60
> [   57.483595]  handle_irq_event+0x2f/0x4c
> [   57.483599]  handle_edge_irq+0x7e/0x1a0
> [   57.483603]  handle_irq+0x17/0x20
> [   57.483607]  do_IRQ+0x54/0x110
> [   57.483610]  common_interrupt+0xf/0xf
> [   57.483612]  </IRQ>
> 
> Fixes: c869f77d6abb ("add mt7601u driver")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt7601u/dma.c | 24 +++++++++++++++------
>  drivers/net/wireless/mediatek/mt7601u/tx.c  |  4 ++--
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
> index e7703990b291..bbf1deed7f3b 100644
> --- a/drivers/net/wireless/mediatek/mt7601u/dma.c
> +++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
> @@ -238,14 +238,25 @@ static void mt7601u_complete_tx(struct urb *urb)
>  	struct sk_buff *skb;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&dev->tx_lock, flags);
> +	switch (urb->status) {
> +	case -ECONNRESET:
> +	case -ESHUTDOWN:
> +	case -ENOENT:
> +		return;
> +	default:
> +		dev_err_ratelimited(dev->dev, "tx urb failed: %d\n",
> +				    urb->status);
> +		/* fall through */
> +	case 0:
> +		break;
> +	}
>  
> -	if (mt7601u_urb_has_error(urb))
> -		dev_err(dev->dev, "Error: TX urb failed:%d\n", urb->status);
> +	spin_lock_irqsave(&dev->tx_lock, flags);
>  	if (WARN_ONCE(q->e[q->start].urb != urb, "TX urb mismatch"))
>  		goto out;
>  
>  	skb = q->e[q->start].skb;
> +	q->e[q->start].skb = NULL;
>  	trace_mt_tx_dma_done(dev, skb);
>  
>  	__skb_queue_tail(&dev->tx_skb_done, skb);
> @@ -446,10 +457,10 @@ static void mt7601u_free_tx_queue(struct mt7601u_tx_queue *q)
>  {
>  	int i;
>  
> -	WARN_ON(q->used);
> -
>  	for (i = 0; i < q->entries; i++)  {
>  		usb_poison_urb(q->e[i].urb);
> +		if (q->e[i].skb)
> +			mt7601u_tx_status(q->dev, q->e[i].skb);

Perhaps a separate patch?

>  		usb_free_urb(q->e[i].urb);
>  	}
>  }
> @@ -463,6 +474,7 @@ static void mt7601u_free_tx(struct mt7601u_dev *dev)
>  
>  	for (i = 0; i < __MT_EP_OUT_MAX; i++)
>  		mt7601u_free_tx_queue(&dev->tx_q[i]);
> +	tasklet_kill(&dev->tx_tasklet);
>  }
>  
>  static int mt7601u_alloc_tx_queue(struct mt7601u_dev *dev,
> @@ -528,6 +540,4 @@ void mt7601u_dma_cleanup(struct mt7601u_dev *dev)
>  
>  	mt7601u_free_rx(dev);
>  	mt7601u_free_tx(dev);
> -
> -	tasklet_kill(&dev->tx_tasklet);
>  }
> diff --git a/drivers/net/wireless/mediatek/mt7601u/tx.c b/drivers/net/wireless/mediatek/mt7601u/tx.c
> index 3600e911a63e..4d81c45722fb 100644
> --- a/drivers/net/wireless/mediatek/mt7601u/tx.c
> +++ b/drivers/net/wireless/mediatek/mt7601u/tx.c
> @@ -117,9 +117,9 @@ void mt7601u_tx_status(struct mt7601u_dev *dev, struct sk_buff *skb)
>  	info->status.rates[0].idx = -1;
>  	info->flags |= IEEE80211_TX_STAT_ACK;
>  
> -	spin_lock(&dev->mac_lock);
> +	spin_lock_bh(&dev->mac_lock);
>  	ieee80211_tx_status(dev->hw, skb);
> -	spin_unlock(&dev->mac_lock);
> +	spin_unlock_bh(&dev->mac_lock);
>  }
>  
>  static int mt7601u_skb_rooms(struct mt7601u_dev *dev, struct sk_buff *skb)

