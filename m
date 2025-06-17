Return-Path: <linux-wireless+bounces-24218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E4BADCBBE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 14:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF3F3AF9F6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A32B28C5D2;
	Tue, 17 Jun 2025 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="S5/WJAug"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45632DE201;
	Tue, 17 Jun 2025 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750164100; cv=none; b=OYzSxCJ7vXjeZUmsF4lkJ6KHNgqraHrNhZYdM1mNHhF23fY0fPLaGDQRbLlR65imTV7eAHRSoI1nnrdEuIhpNAdh0cZ/8WNKSfQrPbLORTdlteXUELyZAQ/d7JDAFkLu++IxK0vbN4V4mhhNdDv9fIEyep/O6SybYgmH/tn7KQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750164100; c=relaxed/simple;
	bh=S/vEW/fan9K334tSdi3pAzSFCI2ayyqbUN8pDKkxVQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZXiNogprkRhGDUCWesDMjghD3N+l7IlX0k9rk91EaTYJArndmDczRlKy4HzO3RJXEPDG+3qz4Rb+WVtNckmPrtzbV74mxxQ4wqOtFpkM0gFMRdUReK0uOKF4srHp1G0owPG8+kMPqh4MV3EH5u67ob7PxJ5oLMctQ5K0FNEuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=S5/WJAug; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.23])
	by mail.ispras.ru (Postfix) with ESMTPSA id B8B73552F52E;
	Tue, 17 Jun 2025 12:41:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B8B73552F52E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1750164092;
	bh=YxXQRcWigoSg6NRDEhBP6ktmTuOUhSBeHt3WEN36q3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5/WJAugShCymWj2DL0SzGc/170B9EerPYYwXu3PETh0tY0Df77FSIFjSykXMg1fS
	 5inhHg4Wio9bAepVSys0H/dA3XJLd+50dB4io56KrZjaTv81UI49c3ucNwfIrXmNtM
	 vokTkvTN2goynAPjl8BoMRccv2t6k5wfbQZFF7b0=
Date: Tue, 17 Jun 2025 15:41:32 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Daniil Dulov <d.dulov@aladdin.ru>, 
	Hin-Tak Leung <hintak.leung@gmail.com>, "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "John W. Linville" <linville@tuxdriver.com>, 
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH 1/2] rtl818x: Fix potential data race in rtl8187_tx_cb()
Message-ID: <hdv4w26nbwtjou3i2qdbhxjia27h7hyu46e3hivki5xpouctd7@r7yymzmqr3rp>
References: <20250616101050.6911-1-d.dulov@aladdin.ru>
 <20250616101050.6911-2-d.dulov@aladdin.ru>
 <a139c0c192ff4f1fbc14dafc37c54bab@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a139c0c192ff4f1fbc14dafc37c54bab@realtek.com>

Hi,

We've worked with Daniil internally on the series so I'm chiming into
the thread..

On Tue, 17. Jun 01:11, Ping-Ke Shih wrote:
> Daniil Dulov <d.dulov@aladdin.ru> wrote:
> > There is a potential data race between rtl8187_tx_cb() and rtl8187_stop().
> > It is possible for rtl8187_stop() to clear the queue right after rtl8187_tx_cb()
> > checks that queue has more than 5 elements, but before it dequeues any skb.
> > This results in skb_dequeue() returns NULL and the pointer is dereferenced
> > in ieee80211_tx_status_irqsafe().
> 
> Is there a way to flush rtl8187_tx_cb() before rtl8187_stop() clear queue?
> It looks risky that rtl8187_tx_cb() can still be running after rtl8187_stop().
> Maybe you only treat this patch as a workaround?

That's what the second patch does, yes.

I've probably found where we screwed this up and made the patch
description and the actual diff go out of sync, apologies.

The current one should've described that it's targeting a race between
rtl8187_tx_cb() and rtl8187_work().

     Thread A                                     Thread B
  rtl8187_tx_cb()
  while (skb_queue_len > 5) // OK
                                               rtl8187_work()
                                               while (skb_queue_len > 0)
                                                 skb_dequeue()
    skb_dequeue() -> NULL


But giving this a second glance, it should be impossible because
rtl8187_tx_cb() dequeues elements only for is_rtl8187b case, and the
worker function is only scheduled for the non-is_rtl8187b case.

> 
> > 
> >  BUG: kernel NULL pointer dereference, address: 0000000000000080
> >  #PF: supervisor read access in kernel mode
> >  #PF: error_code(0x0000) - not-present page
> >  PGD 0 P4D 0
> >  Oops: Oops: 0000 [#1] SMP NOPTI
> >  CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.15.0 #8 PREEMPT(voluntary)
> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> >  RIP: 0010:ieee80211_tx_status_irqsafe+0x21/0xc0 [mac80211]
> >  Call Trace:
> >   <IRQ>
> >   rtl8187_tx_cb+0x116/0x150 [rtl8187]
> >   __usb_hcd_giveback_urb+0x9d/0x120
> >   usb_giveback_urb_bh+0xbb/0x140
> >   process_one_work+0x19b/0x3c0
> >   bh_worker+0x1a7/0x210
> >   tasklet_action+0x10/0x30
> >   handle_softirqs+0xf0/0x340
> >   __irq_exit_rcu+0xcd/0xf0
> >   common_interrupt+0x85/0xa0
> >   </IRQ>
> > 
> > In order to avoid potential data races and leading dereference of a NULL
> > pointer, acquire the queue lock before any work with the queue is done and
> > replace all skb_* calls with their lockless versions.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Do you have a real hardware and tested this patchset? If not, please mention
> compile tested only in commit message. 

Yes, the crash above was observed with our RTL8187BvE device and, urgh,
it actually concerns the root cause fixed by the second patch. The changes
were tested for regressions with debug-enabled kernel and basic
throughput checks.

Thank you for review and comments!

Adding skb_dequeue() return value checks here, as now clarified, should
then be considered only as improvement. We understand that proposing such
kind of stuff for old stable drivers is just churn so I think we'd better
go only with the second patch of the series since it entirely eliminates
the real problem. We'll repost it.

> 
> > 
> > Fixes: 3517afdefc3a ("rtl8187: feedback transmitted packets using tx close descriptor for 8187B")
> > Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> > ---
> >  .../net/wireless/realtek/rtl818x/rtl8187/dev.c    | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> > b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> > index 220ac5bdf279..8fe6fdc32e56 100644
> > --- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> > +++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> > @@ -189,6 +189,7 @@ static void rtl8187_tx_cb(struct urb *urb)
> >         struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
> >         struct ieee80211_hw *hw = info->rate_driver_data[0];
> >         struct rtl8187_priv *priv = hw->priv;
> > +       unsigned long flags;
> > 
> >         skb_pull(skb, priv->is_rtl8187b ? sizeof(struct rtl8187b_tx_hdr) :
> >                                           sizeof(struct rtl8187_tx_hdr));
> > @@ -196,7 +197,8 @@ static void rtl8187_tx_cb(struct urb *urb)
> > 
> >         if (!(urb->status) && !(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
> >                 if (priv->is_rtl8187b) {
> > -                       skb_queue_tail(&priv->b_tx_status.queue, skb);
> > +                       spin_lock_irqsave(&priv->b_tx_status.queue.lock, flags);
> > +                       __skb_queue_tail(&priv->b_tx_status.queue, skb);
> > 
> >                         /* queue is "full", discard last items */
> >                         while (skb_queue_len(&priv->b_tx_status.queue) > 5) {
> > @@ -205,9 +207,11 @@ static void rtl8187_tx_cb(struct urb *urb)
> >                                 dev_dbg(&priv->udev->dev,
> >                                         "transmit status queue full\n");
> > 
> > -                               old_skb = skb_dequeue(&priv->b_tx_status.queue);
> 
> Another simple way could be just to check if old_skb is NULL here.
> 
>     if (!old_skb)
>        break;
> 
> No need to adjust spin_lock.
> 
> > +                               old_skb = __skb_dequeue(&priv->b_tx_status.queue);
> >                                 ieee80211_tx_status_irqsafe(hw, old_skb);
> >                         }
> > +
> > +                       spin_unlock_irqrestore(&priv->b_tx_status.queue.lock, flags);
> >                         return;
> >                 } else {
> >                         info->flags |= IEEE80211_TX_STAT_ACK;
> > @@ -893,6 +897,7 @@ static void rtl8187_work(struct work_struct *work)
> >                                     work.work);
> >         struct ieee80211_tx_info *info;
> >         struct ieee80211_hw *dev = priv->dev;
> > +       unsigned long flags;
> >         static u16 retry;
> >         u16 tmp;
> >         u16 avg_retry;
> > @@ -900,6 +905,8 @@ static void rtl8187_work(struct work_struct *work)
> > 
> >         mutex_lock(&priv->conf_mutex);
> >         tmp = rtl818x_ioread16(priv, (__le16 *)0xFFFA);
> > +
> > +       spin_lock_irqsave(&priv->b_tx_status.queue.lock, flags);
> >         length = skb_queue_len(&priv->b_tx_status.queue);
> >         if (unlikely(!length))
> >                 length = 1;
> > @@ -909,13 +916,15 @@ static void rtl8187_work(struct work_struct *work)
> >         while (skb_queue_len(&priv->b_tx_status.queue) > 0) {
> >                 struct sk_buff *old_skb;
> > 
> > -               old_skb = skb_dequeue(&priv->b_tx_status.queue);
> > +               old_skb = __skb_dequeue(&priv->b_tx_status.queue);
> 
> And here as well. 
> 
>     if (!old_skb)
>        break;
> 
> >                 info = IEEE80211_SKB_CB(old_skb);
> >                 info->status.rates[0].count = avg_retry + 1;
> >                 if (info->status.rates[0].count > RETRY_COUNT)
> >                         info->flags &= ~IEEE80211_TX_STAT_ACK;
> >                 ieee80211_tx_status_irqsafe(dev, old_skb);
> >         }
> > +       spin_unlock_irqrestore(&priv->b_tx_status.queue.lock, flags);
> > +
> >         retry = tmp;
> >         mutex_unlock(&priv->conf_mutex);
> >  }
> > --
> > 2.34.1
> > 

