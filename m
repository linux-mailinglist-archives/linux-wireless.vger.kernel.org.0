Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2ABD46F51
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 11:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfFOJkW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 05:40:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfFOJkW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 05:40:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 268B53082134;
        Sat, 15 Jun 2019 09:40:21 +0000 (UTC)
Received: from localhost (ovpn-204-44.brq.redhat.com [10.40.204.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96707600CC;
        Sat, 15 Jun 2019 09:40:18 +0000 (UTC)
Date:   Sat, 15 Jun 2019 11:40:17 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: Re: [PATCH v3 wireless-drivers 3/3] mt76: usb: do not always copy
 the first part of received frames
Message-ID: <20190615094016.GA20197@redhat.com>
References: <cover.1560461404.git.lorenzo@kernel.org>
 <1a9566c0a41ad0d940487a9d3f0008993c075ef2.1560461404.git.lorenzo@kernel.org>
 <20190614075303.GB3395@redhat.com>
 <20190614102247.GB2669@localhost.localdomain>
 <20190614110442.GA17298@redhat.com>
 <20190614124635.GD2669@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614124635.GD2669@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 15 Jun 2019 09:40:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 14, 2019 at 02:46:36PM +0200, Lorenzo Bianconi wrote:
> > > 
> > > ack, right. I think patch 2/3 and 3/3 can go directly in Felix's tree
> > > 
> > > > 
> > > > > +	int i, data_size;
> > > > >  
> > > > > +	data_size = rounddown(SKB_WITH_OVERHEAD(q->buf_size),
> > > > > +			      dev->usb.in_ep[MT_EP_IN_PKT_RX].max_packet);
> > > > >  	for (i = 0; i < nsgs; i++) {
> > > > >  		struct page *page;
> > > > >  		void *data;
> > > > > @@ -302,7 +304,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
> > > > >  
> > > > >  		page = virt_to_head_page(data);
> > > > >  		offset = data - page_address(page);
> > > > > -		sg_set_page(&urb->sg[i], page, q->buf_size, offset);
> > > > > +		sg_set_page(&urb->sg[i], page, data_size, offset);
> > > > <snip>
> > > > > -	q->buf_size = dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
> > > > >  	q->ndesc = MT_NUM_RX_ENTRIES;
> > > > > +	q->buf_size = PAGE_SIZE;
> > > > > +
> > > > 
> > > > This should be associated with decrease of MT_SG_MAX_SIZE to value that
> > > > is actually needed and currently this is 2 for 4k AMSDU.
> > > 
> > > MT_SG_MAX_SIZE is used even on tx side and I do not think we will end up with a
> > > huge difference here
> > 
> > So use different value as argument for mt76u_fill_rx_sg() in
> > mt76u_rx_urb_alloc(). After changing buf_size to PAGE_SIZE we will
> > allocate 8 pages per rx queue entry, but only 2 pages will be used
> > (with data_size change, 1 without data_size change). Or I'm wrong?
> 
> yes, it is right (we will use two pages with data_size change). Maybe better to
> use 4 pages for each rx queue entry? (otherwise we will probably change it in
> the future)

We should not allocate more than is required. If support for bigger
rx AMSDUs will be added and announced in vht/ht capabilities to remote
stations, then increase of number of segments will be needed.

> > > > However I don't think allocating 2 pages to avoid ieee80211 header and SNAP
> > > > copy is worth to do. For me best approach would be allocate 1 page for
> > > > 4k AMSDU, 2 for 8k and 3 for 12k (still using sg, but without data_size
> > > > change to avoid 32B copying).
> > > 
> > > From my point of view it is better to avoid copying if it is possible. Are you
> > > sure there is no difference?
> > 
> > I do not understand what you mean by difference here.
> 
> tpt differences, not sure if there are any

I would not expect any measurable difference in tpt nor in cpu usage
either way.

But I think, if some AMSDU subframe will be spited into two fragments,
data most likely will need to be linearised/copied, at some point before
passed to application, what will overcome any benefit of avoiding coping
802.11 header. Thought, I don't think this somehow will be visible in
benchmarking.

Stanislaw
