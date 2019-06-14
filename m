Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BECAB45B3C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 13:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfFNLOT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 07:14:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfFNLOS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 07:14:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FBEB10C94;
        Fri, 14 Jun 2019 11:14:18 +0000 (UTC)
Received: from localhost (ovpn-204-80.brq.redhat.com [10.40.204.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D1F81A8F1;
        Fri, 14 Jun 2019 11:14:15 +0000 (UTC)
Date:   Fri, 14 Jun 2019 13:14:15 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name,
        johannes@sipsolutions.net
Subject: Re: [PATCH v3 wireless-drivers 1/3] mt76: usb: fix rx A-MSDU support
Message-ID: <20190614111414.GB17298@redhat.com>
References: <cover.1560461404.git.lorenzo@kernel.org>
 <66fc02e45fb5ce0d6176395b5ac43acbd53b3e66.1560461404.git.lorenzo@kernel.org>
 <20190614072449.GA3395@redhat.com>
 <20190614101115.GA2669@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614101115.GA2669@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 14 Jun 2019 11:14:18 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 14, 2019 at 12:11:17PM +0200, Lorenzo Bianconi wrote:
> > On Thu, Jun 13, 2019 at 11:43:11PM +0200, Lorenzo Bianconi wrote:
> > > Commit f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes
> > > for rx") breaks A-MSDU support. When A-MSDU is enable the device can
> > > receive frames up to q->buf_size but they will be discarded in
> > > mt76u_process_rx_entry since there is no enough room for
> > > skb_shared_info. Fix the issue reallocating the skb and copying in the
> > > linear area the first 128B of the received frames and in the frag_list
> > > the remaining part.
> > > 
> > > Fixes: f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes for rx")
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
> > >  drivers/net/wireless/mediatek/mt76/usb.c  | 49 ++++++++++++++++++-----
> > >  2 files changed, 41 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> > > index 8ecbf81a906f..889b76deb703 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> > > @@ -30,6 +30,7 @@
> > >  #define MT_TX_RING_SIZE     256
> > >  #define MT_MCU_RING_SIZE    32
> > >  #define MT_RX_BUF_SIZE      2048
> > > +#define MT_SKB_HEAD_LEN     128
> > >  
> > >  struct mt76_dev;
> > >  struct mt76_wcid;
> > > diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
> > > index bbaa1365bbda..12d60d31cb51 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/usb.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> > > @@ -429,6 +429,45 @@ static int mt76u_get_rx_entry_len(u8 *data, u32 data_len)
> > >  	return dma_len;
> > >  }
> > >  
> > > +static struct sk_buff *
> > > +mt76u_build_rx_skb(u8 *data, int len, int buf_size)
> > > +{
> > > +	struct sk_buff *skb;
> > > +
> > > +	if (SKB_WITH_OVERHEAD(buf_size) < MT_DMA_HDR_LEN + len) {
> > > +		struct page *page;
> > > +		int offset;
> > > +
> > > +		/* slow path, not enough space for data and
> > > +		 * skb_shared_info
> > > +		 */
> > > +		skb = alloc_skb(MT_SKB_HEAD_LEN, GFP_ATOMIC);
> > > +		if (!skb)
> > > +			return NULL;
> > > +
> > > +		skb_put_data(skb, data + MT_DMA_HDR_LEN, MT_SKB_HEAD_LEN);
> > 
> > I looked how rx amsdu is processed in mac80211 and it is decomposed and
> > copied into newly allocated individual skb's, see ieee80211_amsdu_to_8023s()
> > 
> > So copy L3 & L4 headers doesn't do anything good here, actually seems to
> > be better to have them in frag as __ieee80211_amsdu_copy_frag() do some
> > magic to avid copy.
> 
> Looking at __ieee80211_amsdu_copy() now I got why other drivers copy hdrlen +
> 8, thx :)
> In our case reuse_frag is true in __ieee80211_amsdu_copy, so we will end up

I don't think reuse_frag is true in our case since skb->head_frag is
not set when we use alloc_skb(). 

Stanislaw
