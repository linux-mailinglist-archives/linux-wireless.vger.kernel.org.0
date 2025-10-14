Return-Path: <linux-wireless+bounces-27973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB91BDB673
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 23:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F9D3BB224
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 21:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468A6306B0C;
	Tue, 14 Oct 2025 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="o8b0R0Db"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3B1F03C5;
	Tue, 14 Oct 2025 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477008; cv=none; b=TcTpL/FW3LjVG/q4BWE0ZeS5b6mM11f6mgoLW4bU74ipcmlJvLqZK+GjVce3MWExDiibltYLEemmR8hu661cNRGU/tTgzEwXaQVMidAs8h6XZbJ49g2K4KEcWJTek6Wi86My7b/bkBeYVYlRv9TejtrSK1zVD+IRtmwrROGe02s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477008; c=relaxed/simple;
	bh=bDcet6jYUKQrojwM2JeCRNuMi2MvlrQ34HS/moqpMZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/5E8bevrqStngjfO8u+nNMWTPZmN0SU4Zf3qGt6Pwf/y24JhPJ2AT6JndRHEi1ufAzx/y2WdnYyVDv6Ei5/AfOyFwPEyttlCG9fjLorsDlLQ5NR6hx2G5QJdl/ezas3pw/jDeHhsU8WMOhB664PfXLAu4V41OVj+JZbwLiECmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=o8b0R0Db; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id CDF5340762D8;
	Tue, 14 Oct 2025 21:23:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CDF5340762D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760477000;
	bh=17Sykv4x5Ri3VLi09kZFffzQ6OCY1SkcYZ6WJh1ESho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8b0R0DbZLORMKBkVDimAexpc9we81esJ/sMkWxEFP/PoGRUO+S6BZ7z3asyQlfV6
	 IaJoizI/+EGAN2p0sYZnoU9F6KlR5z9K94adzNaUjnEKEf4znhoxFULhV/udzwMoud
	 aSqufJCz/rICvduloESnWEq25qeSz+B5NLpvFliI=
Date: Wed, 15 Oct 2025 00:23:20 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next v2 6/7] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Message-ID: <20251014234211-4f763e2dab18fe04fbe4d95c-pchelkin@ispras>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-7-pchelkin@ispras.ru>
 <b1725b36caba476ba9ee4916910d8232@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1725b36caba476ba9ee4916910d8232@realtek.com>

Hi,

thanks for detailed review!

On Tue, 07. Oct 06:31, Ping-Ke Shih wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > Frames flagged with IEEE80211_TX_CTL_REQ_TX_STATUS mean the driver has to
> > report to mac80211 stack whether AP sent ACK for the null frame/probe
> > request or not.  It's not implemented in USB part of the driver yet.
> > 
> > PCIe HCI has its own way of getting TX status incorporated into RPP
> > feature, and it's always enabled there.  Other HCIs need a different
> > scheme based on processing C2H messages.
> > 
> > Thus define a .tx_rpt_enable flag defining which HCIs would need a TX
> > report feature.  Currently it is USB only.
> > 
> > Do skb handling / queueing part quite similar to what rtw88 has.  Store
> > the flagged skbs in a queue for further processing in a C2H handler.
> > Flush the queue on HCI reset and on timeout via delayed work handler used
> > for TX waits - it's convenient since the further changes will pass TX wait
> > skbs management to the same TX report queue.
> > 
> > Found by Linux Verification Center (linuxtesting.org).
> > 
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > ---
> > 
> > v2: - update TX rpt description in rtw89_core_tx_update_desc_info()
> >     - add a flag in rtw89_hci_info to determine if we should enable TX report (Ping-Ke)
> >     - refine rtw89_tx_rpt_queue_purge() - it's called on USB HCI reset
> >       and at rtw89_tx_wait_work.  Queueing delayed rtw89_tx_wait_work may be
> >       suboptimal but basically it's what rtw88 does with timer stuff.
> >       We can drop it and rely only on HCI reset to free remaining buffers
> >       in case firmware didn't send any TX status report.  I'd like to know
> >       your thoughts on this.
> > 
> >  drivers/net/wireless/realtek/rtw89/core.c |  9 ++++-
> >  drivers/net/wireless/realtek/rtw89/core.h |  6 ++++
> >  drivers/net/wireless/realtek/rtw89/mac.c  | 19 ++++++++++
> >  drivers/net/wireless/realtek/rtw89/mac.h  | 43 +++++++++++++++++++++++
> >  drivers/net/wireless/realtek/rtw89/usb.c  | 14 +++++++-
> >  5 files changed, 89 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
> > index 49ecc248464b..214924f8bee0 100644
> > --- a/drivers/net/wireless/realtek/rtw89/core.c
> > +++ b/drivers/net/wireless/realtek/rtw89/core.c
> > @@ -1107,6 +1107,9 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
> >                                                  tx_req->rtwsta_link);
> >                 if (addr_cam->valid && desc_info->mlo)
> >                         upd_wlan_hdr = true;
> > +
> > +               if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)
> > +                       rtw89_tx_rpt_enable(rtwdev, tx_req);
> 
> During review of previous round, I add a patch [1] internally to adjust
> this function, because we only need to fill few fields for FWCMD type.
> 
> Please add my patch into your patchset before this patch.
> 
> [1] https://lore.kernel.org/linux-wireless/20251007032656.13189-1-pkshih@realtek.com/T/#u

Okay.

> 
> >         }
> >         is_bmc = (is_broadcast_ether_addr(hdr->addr1) ||
> >                   is_multicast_ether_addr(hdr->addr1));
> > @@ -1140,7 +1143,10 @@ static void rtw89_tx_wait_work(struct wiphy *wiphy, struct wiphy_work *work)
> >         struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
> >                                                 tx_wait_work.work);
> > 
> > -       rtw89_tx_wait_list_clear(rtwdev);
> > +       if (!rtwdev->hci.tx_rpt_enable)
> > +               rtw89_tx_wait_list_clear(rtwdev);
> > +       else
> > +               rtw89_tx_rpt_queue_purge(rtwdev);
> 
> I feel rtw89_tx_wait_work() should only free list of 'rtwdev->tx_waits'.
> To mix TX report queue ('rtwdev->tx_rpt_queue') looks hard to understand.
> A skb exists in two queues looks not easy to handle...
> 
> Also, I see rtw89_hci_reset() calls rtw89_tx_wait_list_clear(). Is it still
> correct after this patch?

TX wait list is currently empty when TX reports are used but, yeah, this
code will most probably be reworked due to the need to separate tx_rpt_queue
and TX wait_list and unify PCIe and USB reset-handlers.  I'm pondering over
these patches and will send out v3 in a day or two.

> 
> >  }
> > 
> >  void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
> > @@ -5847,6 +5853,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
> >         wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6ghz_probe_work);
> >         INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
> > 
> > +       skb_queue_head_init(&rtwdev->tx_rpt_queue);
> >         skb_queue_head_init(&rtwdev->c2h_queue);
> >         rtw89_core_ppdu_sts_init(rtwdev);
> >         rtw89_traffic_stats_init(rtwdev, &rtwdev->stats);
> > diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
> > index 66b7bfa5902e..3940e54353d3 100644
> > --- a/drivers/net/wireless/realtek/rtw89/core.h
> > +++ b/drivers/net/wireless/realtek/rtw89/core.h
> > @@ -3527,6 +3527,8 @@ struct rtw89_tx_wait_info {
> > 
> >  struct rtw89_tx_skb_data {
> >         struct rtw89_tx_wait_info __rcu *wait;
> > +       u8 tx_rpt_sn;
> > +       u8 tx_pkt_cnt_lmt;
> >         u8 hci_priv[];
> >  };
> > 
> > @@ -3696,6 +3698,7 @@ struct rtw89_hci_info {
> >         u32 rpwm_addr;
> >         u32 cpwm_addr;
> >         bool paused;
> > +       bool tx_rpt_enable;
> 
> tx_rpt_enabled?
> 
> >  };
> > 
> >  struct rtw89_chip_ops {
> > @@ -6015,6 +6018,9 @@ struct rtw89_dev {
> >         struct list_head tx_waits;
> >         struct wiphy_delayed_work tx_wait_work;
> > 
> > +       atomic_t sn;
> > +       struct sk_buff_head tx_rpt_queue;
> > +
> >         struct rtw89_cam_info cam_info;
> > 
> >         struct sk_buff_head c2h_queue;
> > diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> > index 10c2a39e544b..75d9efac452b 100644
> > --- a/drivers/net/wireless/realtek/rtw89/mac.c
> > +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> > @@ -5465,10 +5465,29 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> >         u8 sw_define = le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_SW_DEFINE);
> >         u8 tx_status = le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_TX_STATE);
> >         u8 data_txcnt = le32_get_bits(rpt->w5, RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT);
> > +       struct rtw89_tx_skb_data *skb_data;
> > +       struct sk_buff *cur, *tmp;
> > +       unsigned long flags;
> > 
> >         rtw89_debug(rtwdev, RTW89_DBG_TXRX,
> >                     "C2H TX RPT: sn %d, tx_status %d, data_txcnt %d\n",
> >                     sw_define, tx_status, data_txcnt);
> > +
> > +       spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
> > +       skb_queue_walk_safe(&rtwdev->tx_rpt_queue, cur, tmp) {
> > +               skb_data = RTW89_TX_SKB_CB(cur);
> 
> Prefer just 'skb' instead of 'cur'. 
> I don't need look back to understand 'cur' is a sk_buff.
> 
> > +
> > +               if (sw_define != skb_data->tx_rpt_sn)
> > +                       continue;
> > +               if (tx_status != RTW89_TX_DONE &&
> > +                   data_txcnt != skb_data->tx_pkt_cnt_lmt)
> 
> As commit message of previous patch, "When there is a failed
> TX status reported by the firmware, the report is ignored until the limit
> is reached or success status appears."
> 
> Do you still need to check data_txcnt for failed cases? 

The question also concerns

  tx_req->desc_info.tx_cnt_lmt = 8;

line in rtw89_tx_rpt_enable().  'tx_cnt_lmt' is written to TX descriptor
and processed by firmware.  The value defines how many times the firmware
will retry transmission attempts, it will not retry more times than that.

'data_txcnt' C2H field determines the retry attempt counter for the frame
returned by the firmware.  If it reaches the limit, this means we got
the last report from the firmware and there would be no other firmware
reports for the sent frame.  So a final tx_status should be taken
uncondionally in this case.

E.g. if 'tx_cnt_lmt' is set to 1, the firmware will try only once,
'data_txcnt' will be 1, too.  The limit is reached and we should take
tx_status immediately as is.  So there's a higher chance of getting a
failed status eventually.

I set it currently to 8 as the vendor driver does.  In local testing it
looks more than enough.  I've seen maximum of 5 retry attempts for the
same frame (usually there are no retries at all) though my network radio
environment is quite noisy.

I'll add the tx_cnt_lmt related info to commit message for clarity.

> 
> 
> > +                       continue;
> > +
> > +               __skb_unlink(cur, &rtwdev->tx_rpt_queue);
> > +               rtw89_tx_rpt_tx_status(rtwdev, cur, tx_status);
> > +               break;
> > +       }
> > +       spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);
> >  }
> > 
> >  static void
> > diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
> > index 15c5c7e4033c..1f7d3734d15f 100644
> > --- a/drivers/net/wireless/realtek/rtw89/mac.h
> > +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> > @@ -1616,4 +1616,47 @@ int rtw89_mac_scan_offload(struct rtw89_dev *rtwdev,
> > 
> >         return ret;
> >  }
> > +
> > +static inline
> > +void rtw89_tx_rpt_enable(struct rtw89_dev *rtwdev,
> > +                        struct rtw89_core_tx_request *tx_req)
> > +{
> > +       if (!rtwdev->hci.tx_rpt_enable)
> > +               return;
> > +
> > +       tx_req->desc_info.report = true;
> > +       tx_req->desc_info.sn = atomic_inc_return(&rtwdev->sn) & 0xF;
> 
> Since you have assigned 4 bits for 'sn', no need '& 0xF'. 
> If you still want to emphasize this, maybe add a comment.
> 
> > +       tx_req->desc_info.tx_cnt_lmt_en = true;
> > +       tx_req->desc_info.tx_cnt_lmt = 8;
> 
> Question about '8'. Can it be larger?
> 
> I mean if hardware retry over 8 (e.g. 10), and succeed to send at 9th retry.
> Would it be a problem?
> 
> 
> > +}
> > +
> > +static inline
> > +void rtw89_tx_rpt_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *skb, u8 tx_status)
> > +{
> > +       struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
> > +
> > +       ieee80211_tx_info_clear_status(info);
> > +       if (tx_status == RTW89_TX_DONE)
> > +               info->flags |= IEEE80211_TX_STAT_ACK;
> > +       else
> > +               info->flags &= ~IEEE80211_TX_STAT_ACK;
> > +
> > +       ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
> > +}
> > +
> > +static inline
> > +void rtw89_tx_rpt_queue_purge(struct rtw89_dev *rtwdev)
> > +{
> > +       struct sk_buff_head q;
> > +       struct sk_buff *skb;
> > +       unsigned long flags;
> > +
> > +       __skb_queue_head_init(&q);
> 
> With a blank line, the lock would be clear. 
> 
> > +       spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
> > +       skb_queue_splice_init(&rtwdev->tx_rpt_queue, &q);
> > +       spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);
> > +
> > +       while ((skb = __skb_dequeue(&q)))
> > +               rtw89_tx_rpt_tx_status(rtwdev, skb, RTW89_TX_MACID_DROP);
> > +}
> >  #endif
> > diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
> > index 655e8437d62e..f53ab676e9a8 100644
> > --- a/drivers/net/wireless/realtek/rtw89/usb.c
> > +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> > @@ -216,6 +216,15 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
> >                 skb_pull(skb, txdesc_size);
> > 
> >                 info = IEEE80211_SKB_CB(skb);
> > +               if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
> > +                       /* sn is passed to rtw89_mac_c2h_tx_rpt() via driver data */
> > +                       skb_queue_tail(&rtwdev->tx_rpt_queue, skb);
> > +                       wiphy_delayed_work_queue(rtwdev->hw->wiphy,
> > +                                                &rtwdev->tx_wait_work,
> > +                                                RTW89_TX_WAIT_WORK_TIMEOUT);
> > +                       continue;
> > +               }
> > +
> >                 ieee80211_tx_info_clear_status(info);
> > 
> >                 if (urb->status == 0) {
> > @@ -396,6 +405,8 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
> >         memset(txdesc, 0, txdesc_size);
> >         rtw89_chip_fill_txdesc(rtwdev, desc_info, txdesc);
> > 
> > +       RTW89_TX_SKB_CB(skb)->tx_rpt_sn = tx_req->desc_info.sn;
> 
> Prefer a local variable 'struct rtw89_tx_skb_data *skb_data;'.
> 
> > +
> >         le32p_replace_bits(&txdesc->dword0, 1, RTW89_TXWD_BODY0_STF_MODE);
> 
> This is also to fill tx desc, so prefer filling tx_rpt_sn after this. 
> 
> > 
> >         skb_queue_tail(&rtwusb->tx_queue[desc_info->ch_dma], skb);
> > @@ -678,7 +689,7 @@ static void rtw89_usb_deinit_tx(struct rtw89_dev *rtwdev)
> > 
> >  static void rtw89_usb_ops_reset(struct rtw89_dev *rtwdev)
> >  {
> > -       /* TODO: anything to do here? */
> > +       rtw89_tx_rpt_queue_purge(rtwdev);
> 
> No sure if we can ensure no TX packets still on the fly --
> which have been submitted, but not call rtw89_usb_write_port_complete() yet.

It may race, agree.

> 
> But I'm also not sure if it is a problem that newly TX completion happens
> after calling rtw89_tx_rpt_queue_purge().

I can't imagine of scenario where that would be a problem, too.

> 
> >  }
> > 
> >  static int rtw89_usb_ops_start(struct rtw89_dev *rtwdev)
> > @@ -962,6 +973,7 @@ int rtw89_usb_probe(struct usb_interface *intf,
> > 
> >         rtwdev->hci.ops = &rtw89_usb_ops;
> >         rtwdev->hci.type = RTW89_HCI_TYPE_USB;
> > +       rtwdev->hci.tx_rpt_enable = true;
> > 
> >         ret = rtw89_usb_intf_init(rtwdev, intf);
> >         if (ret) {
> > --
> > 2.51.0
> > 
> 

