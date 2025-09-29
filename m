Return-Path: <linux-wireless+bounces-27708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B66BA9835
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 16:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256D73B600E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7F22FBE1E;
	Mon, 29 Sep 2025 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="CNUpqJdR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015372F25F5;
	Mon, 29 Sep 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155412; cv=none; b=CAvSaKsUCusYIchxvDdpGsSjLpss37UtsTGrnG0nnSCPSMLkFVHo/Bs+XhgYvvyNJBYRlkxT0H68woG/OOsFJovmQY19+SfzCbMmkdrP/FsWWhwAAXam7oO+V2OSmlu4zMwVNX6qvNCxtbBPSxWNFnLoCb1LS70pBVmwsQyIFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155412; c=relaxed/simple;
	bh=3+O5C6Vz/MkAbscpfMKARxnmsE5d9vXjTWJzlbsLnug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtQUEKH3K1R94QHc4XaPn+jxBJmnyVE9Whg2JReipby2XzmF8HMdl0RvLPaKTnWMFoQ7Wmc1t0ndTrvR64JBCFqLRFTkrlfwoUcvqmjGRlZiGuceFj2ubllYeO+aiWnOgnsQ28eUVW8iCzROXMeNO2+4J6tPh8//2HKiiCjDpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=CNUpqJdR; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.17])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 9205D40643CB;
	Mon, 29 Sep 2025 14:16:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9205D40643CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1759155405;
	bh=W1zN4RQ16FSgQFKeVYeqiwRubVmq/xZgRjCVRCpAZLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNUpqJdRpv3a7/gLgi4D4oErIzd0rjVicqgMppaNYr0EvsJEB1yprRBYIvIhFxlTN
	 PyNwLY3Mk0kjbWn8TS78WcWfwZGZIKuNSaNsPPWfiH2nuh3X+2kwElQ8yBjoU3IpQ/
	 SdmfHovckNM7CVh6Flce0gZTn8EGDikh1dhLh1w0=
Date: Mon, 29 Sep 2025 17:16:45 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next 4/6] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Message-ID: <20250929130524-9e0c010a824ad34c47c2e1c4-pchelkin@ispras>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-5-pchelkin@ispras.ru>
 <de5673b6c65d460187b9d99a14783a7e@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de5673b6c65d460187b9d99a14783a7e@realtek.com>

On Thu, 25. Sep 02:05, Ping-Ke Shih wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > Frames flagged with IEEE80211_TX_CTL_REQ_TX_STATUS mean the driver has to
> > report to mac80211 stack whether AP sent ACK for the null frame/probe
> > request or not.  It's not implemented in USB part of the driver yet.
>                  ^^ nit: two spaces
> > 
> > PCIe HCI has its own way of getting TX status incorporated into RPP
> > feature, and it's always enabled there.  Other HCIs need a different
>                                          ^^ nit: two spaces
> 
> I wonder if you want two spaces intentionally? 

Oh, it's intentional "style" used to mark sentence endings more
distinctively.  I've already done that in the previous series.

> > @@ -6294,6 +6304,7 @@ static inline void rtw89_hci_reset(struct rtw89_dev *rtwdev)
> >  {
> >         rtwdev->hci.ops->reset(rtwdev);
> >         rtw89_tx_wait_list_clear(rtwdev);
> > +       skb_queue_purge(&rtwdev->tx_rpt_queue);
> 
> ieee80211_purge_tx_queue()? 
> (a caller needs to hold lock)

Alright, plain skb_queue_purge() may lead to "Have pending ack frames!"
WARNING later.

> > diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> > index 01afdcd5f36c..831e53aedccc 100644
> > --- a/drivers/net/wireless/realtek/rtw89/mac.c
> > +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> > @@ -5457,15 +5457,44 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
> >         rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
> >  }
> > 
> > +static void
> > +rtw89_tx_rpt_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *skb, bool acked)
> > +{
> > +       struct ieee80211_tx_info *info;
> > +
> > +       info = IEEE80211_SKB_CB(skb);
> 
> nit: just declare ` struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);` 
> 
> > +       ieee80211_tx_info_clear_status(info);
> > +       if (acked)
> > +               info->flags |= IEEE80211_TX_STAT_ACK;
> > +       else
> > +               info->flags &= ~IEEE80211_TX_STAT_ACK;
> > +
> > +       ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
> 
> I'm not aware USB use _irqsafe version before. Can I know the context of
> rtw89_usb_write_port_complete()? Is it IRQ context?
> 

Depends on the USB host controller if I'm not mistaken.  URB completion
callback may be invoked either in hard IRQ or BH context.
usb_hcd_giveback_urb() has an updated doc stating:

 * Context: atomic. The completion callback is invoked either in a work queue
 * (BH) context or in the caller's context, depending on whether the HCD_BH
 * flag is set in the @hcd structure, except that URBs submitted to the
 * root hub always complete in BH context.

If HCD_BH is not set for the host controller in use then, depending on host
controller, URB handler might be executed in hard IRQ context.

I guess you're implying to unify the usage of ieee80211_tx_status_* for
PCIe (which has ieee80211_tx_status_ni) and USB variants of rtw89.  These
calls are not mixed for the single hardware so there is no real issue
for unification.

> > +}
> > +
> >  static void
> >  rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> >  {
> >         u8 sw_define = RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h->data);
> >         u8 tx_status = RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h->data);
> > +       struct sk_buff *cur, *tmp;
> > +       unsigned long flags;
> > +       u8 *n;
> > 
> >         rtw89_debug(rtwdev, RTW89_DBG_TXRX,
> >                     "C2H TX RPT: sn %d, tx_status %d\n",
> >                     sw_define, tx_status);
> > +
> > +       spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
> > +       skb_queue_walk_safe(&rtwdev->tx_rpt_queue, cur, tmp) {
> > +               n = (u8 *)RTW89_TX_SKB_CB(cur)->hci_priv;
> 
> The *n is rtw89_usb_tx_data::sn, right? I feel this is hard to ensure
> correctness. Why not just define this in struct rtw89_tx_skb_data?
> So no need RTW89_USB_TX_SKB_CB() for this.

Ah, this should work because recent commit 19989c80734c ("wifi: rtw89: use
ieee80211_tx_info::driver_data to store driver TX info") has allowed
storing more than 2 'void *' pointers in private data.

> 
> > +               if (*n == sw_define) {
> > +                       __skb_unlink(cur, &rtwdev->tx_rpt_queue);
> > +                       rtw89_tx_rpt_tx_status(rtwdev, cur, tx_status == RTW89_TX_DONE);
> > +                       break;
> > +               }
> > +       }
> > +       spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);
> 
> If we can use ieee80211_tx_status_ni() or ieee80211_tx_status_skb(), 

We can't use non-_irqsafe versions here unless rtw89_usb_write_port_complete()
is reworked not to use _irqsafe one.  And there is no way other than
transfering this work from URB completion handler to some other async
worker (in BH context or similar).  Not sure it'll be better overall.

> I'd like use skb_queue_splice() to create a local skb list, and iterate the
> local list, and then splice back to original.
> 
> (Reference to mesh_path_move_to_queue())

Perhaps we can do that with ieee80211_tx_status_irqsafe() still in place.

> 
> >  }
> > 
> >  static void
> > diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
> > index 0ee5f8579447..fdf142d77ecc 100644
> > --- a/drivers/net/wireless/realtek/rtw89/pci.c
> > +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> > @@ -4675,6 +4675,7 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
> >         .pause          = rtw89_pci_ops_pause,
> >         .switch_mode    = rtw89_pci_ops_switch_mode,
> >         .recalc_int_mit = rtw89_pci_recalc_int_mit,
> > +       .tx_rpt_enable  = NULL, /* always enabled */
> 
> The comment is weird. PCI devices don't never use TX report, no?

It's me mixing up the terminology, sorry.  The comment was supposed to
indicate that PCI always have TX status reported.  (but it's done via RPP
feature which is actually a separate thing compared to TX Report, okay)

I'd rather replace it with "TX status is reported via RPP" if that comment
is helpful.

