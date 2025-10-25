Return-Path: <linux-wireless+bounces-28243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B159EC0900E
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 14:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B268F4E8843
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3BB223DE5;
	Sat, 25 Oct 2025 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ixIMXYwH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862451F5838;
	Sat, 25 Oct 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761394267; cv=none; b=I90GJ0U+t2a3ZlN0BZNeEwJDgWEl40MlOE2V39wBSka3kvkz1mnIjH2het9AgHBHpNCRapg1+/zQRkOfysYB6aXZlMlGezJede3gNAVvfS+otbA5n0mQiVawRgfDtNLlx8ZHeAj0du4OKcCgvJXI/wuOdykNdIw6nB847xXJooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761394267; c=relaxed/simple;
	bh=0hw+HnkWtOszaFvfv8pWJiog78lB/IISzNNMZ1Epvfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up3wB3nUiabdZ6eQUjmVucBMZG3H2ZvJoAQYKoqgFufrakkjD4EzNKJg+bXYLt6nSPWKz6o+X920pK1azYI8N2xth6RzdkjXy2lYxUJjF1mQ3NOUGTNyEhW1tn4bNSOGk6gjsmg8mJWPhb4sKBpju+XCNMBmCF/aBOr1Gq979H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ixIMXYwH; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id EF749407674D;
	Sat, 25 Oct 2025 12:10:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EF749407674D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761394260;
	bh=9TA1nTcqS1c7E3pMQCWPyHKJBcSBxYYPbUmS6qAxGlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixIMXYwHFukHpm3FyRfl6mmE88ZTKXIMKC70KTTTiCgniLmFs/pxbclr8A0sWdciy
	 aP5finHnisGDu3uDd85FQPLAz+eWjWX9QUld5l62d0h581MjrNCHzs5HylobMrcYnq
	 suZieEVvrc2KHfSC2FqLGDdlQcioeZGqVfbXWrSc=
Date: Sat, 25 Oct 2025 15:10:59 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next v3 7/9] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Message-ID: <20251025131637-d3a03888f5c753e6b213e204-pchelkin@ispras>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
 <20251017100658.66581-8-pchelkin@ispras.ru>
 <f013f65b97a447e2b744a4f3d6aff269@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f013f65b97a447e2b744a4f3d6aff269@realtek.com>

On Wed, 22. Oct 07:16, Ping-Ke Shih wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > @@ -5849,6 +5852,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
> >         wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6ghz_probe_work);
> >         INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
> > 
> > +       skb_queue_head_init(&rtwdev->tx_rpt.queue);
> 
> not sure if it's worth to initialize tx_rpt.sn to zero?

That shouldn't be needed because rtwdev is zero initialized in
rtw89_alloc_ieee80211_hw().  ieee80211_alloc_hw() fills the private
driver part with zeroes.

> > @@ -5484,6 +5488,26 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> >         rtw89_debug(rtwdev, RTW89_DBG_TXRX,
> >                     "C2H TX RPT: sn %d, tx_status %d, data_txcnt %d\n",
> >                     sw_define, tx_status, data_txcnt);
> > +
> > +       spin_lock_irqsave(&tx_rpt->queue.lock, flags);
> > +       skb_queue_walk_safe(&tx_rpt->queue, skb, tmp) {
> > +               skb_data = RTW89_TX_SKB_CB(skb);
> > +
> > +               /* skip if sequence number doesn't match */
> > +               if (sw_define != skb_data->tx_rpt_sn)
> > +                       continue;
> > +               /* skip if TX attempt has failed and retry limit has not been
> > +                * reached yet
> > +                */
> > +               if (tx_status != RTW89_TX_DONE &&
> > +                   data_txcnt != skb_data->tx_pkt_cnt_lmt)
> > +                       continue;
> > +
> > +               __skb_unlink(skb, &tx_rpt->queue);
> > +               rtw89_tx_rpt_tx_status(rtwdev, skb, tx_status);
> 
> Would it be better to run rtw89_tx_rpt_tx_status() after this loop outside
> spin_lock()?

I don't have a strong opinion here: PCIe side implements the release
like

rtw89_pci_poll_rpq_dma()
 spin_lock_bh(&rtwpci->trx_lock)
 rtw89_pci_release_tx()
 ...
   rtw89_pci_release_txwd_skb()
	skb_queue_walk_safe(&txwd->queue, skb, tmp) {
		skb_unlink(skb, &txwd->queue);

		tx_data = RTW89_PCI_TX_SKB_CB(skb);
		dma_unmap_single(&rtwpci->pdev->dev, tx_data->dma, skb->len,
				 DMA_TO_DEVICE);

		rtw89_pci_tx_status(rtwdev, tx_ring, skb, tx_status);
	}
 ...
 spin_unlock_bh(&rtwpci->trx_lock)


Apart from bh/irqsave part the iteration over skbs looks visually similar
at the moment.

> > --- a/drivers/net/wireless/realtek/rtw89/usb.c
> > +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> > @@ -216,6 +216,14 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
> >                 skb_pull(skb, txdesc_size);
> > 
> >                 info = IEEE80211_SKB_CB(skb);
> > +               if (rtw89_is_tx_rpt_skb(skb)) {
> > +                       /* sequence number is passed to rtw89_mac_c2h_tx_rpt() via
> 
> nit: The 'via' is over 80 characters a little bit. Move to next line.
> 
> > +                        * driver data
> > +                        */
> > +                       skb_queue_tail(&rtwdev->tx_rpt.queue, skb);
> > +                       continue;
> > +               }
> > +
> >                 ieee80211_tx_info_clear_status(info);
> > 
> >                 if (urb->status == 0) {
> 
> Should we move this checking upward? Enqueue skb into tx_rpt_skb only if
> urb->status == 0?

Yep, I agree we can do it.  Just need to report it immediately with
RTW89_TX_MACID_DROP status.

As it currently stands, we should not receive notification from the
firmware for such skb so it would remain inside tx_rpt.queue until HCI
reset occurs.

However, I've not considered the case when the queue is full and we start
queueing skbs with duplicate sequence numbers - the overall range we have
is just 0xF, theoretically the situation is possible if the firmware
fatally crashes and doesn't provide notifications in time.  IMHO the TX
status will be the last thing we're going to be interested in when this
happens.  In the end, HCI reset during SER activity will purge the queue.

But the possibility of having skbs with duplicate seq numbers is not good.
Though I'm not sure if we can ever hit such a situation... Generally it
indicates that the firmware doesn't respond or performs very badly, and
we'd better reset it or something.  What do you think on this?

> 
> > @@ -372,6 +380,7 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
> >  {
> >         struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
> >         struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
> > +       struct rtw89_tx_skb_data *skb_data;
> >         struct sk_buff *skb = tx_req->skb;
> >         struct rtw89_txwd_body *txdesc;
> >         u32 txdesc_size;
> > @@ -398,6 +407,9 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
> > 
> >         le32p_replace_bits(&txdesc->dword0, 1, RTW89_TXWD_BODY0_STF_MODE);
> > 
> > +       skb_data = RTW89_TX_SKB_CB(skb);
> > +       skb_data->tx_rpt_sn = tx_req->desc_info.sn;
> 
> Shouldn't set skb_data->tx_pkt_cnt_lmt? 
> 
> skb_data->tx_pkt_cnt_lmt = tx_req->desc_info.tx_cnt_lmt;
> 
> Also, should we check desc_info.{report, tx_cnt_lmt_en} individually before 
> setting?

Right, this all makes sense.  Will fix it, thanks!

> 
> 
> > +
> >         skb_queue_tail(&rtwusb->tx_queue[desc_info->ch_dma], skb);
> > 
> >         return 0;
> > @@ -678,7 +690,7 @@ static void rtw89_usb_deinit_tx(struct rtw89_dev *rtwdev)
> > 
> >  static void rtw89_usb_ops_reset(struct rtw89_dev *rtwdev)
> >  {
> > -       /* TODO: anything to do here? */
> > +       rtw89_tx_rpt_queue_purge(rtwdev);
> 
> Have you consider the SKB that has been rtw89_usb_write_port() but
> has not yet rtw89_usb_write_port_complete()?
> 
> Since we call rtw89_mac_pwr_off() before rtw89_hci_reset() in 
> rtw89_core_stop(), it should be not more C2H at rtw89_hci_reset().
> It seems to be safe, right?

Well, rtw89_usb_write_port_complete() is asynchronous URB callback managed
by USB subsystem and it's mainly independent of rtw89.  We're guaranteed
all pending URB completions will complete when the device is being
disconnected and rtw89_usb_disconnect() method is called.  That's all, I
think.

In other call sites like SER we risk URB completion be called after
purging the queue, the only consequence will be the obsolete skb still
added to the queue.

We can implement an anchor for TX URBs and explicitly wait with
usb_kill_anchored_urbs() in ->reset() until all pending URB completions
are done, and then purge the queue.

If nothing else, I'll add it in the next respin of the series.

