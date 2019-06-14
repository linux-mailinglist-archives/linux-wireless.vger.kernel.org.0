Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF0F456D0
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 09:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfFNHyk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 03:54:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfFNHyj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 03:54:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D4C73082E23;
        Fri, 14 Jun 2019 07:54:38 +0000 (UTC)
Received: from localhost (unknown [10.43.2.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B843660657;
        Fri, 14 Jun 2019 07:54:35 +0000 (UTC)
Date:   Fri, 14 Jun 2019 09:53:03 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v3 wireless-drivers 3/3] mt76: usb: do not always copy
 the first part of received frames
Message-ID: <20190614075303.GB3395@redhat.com>
References: <cover.1560461404.git.lorenzo@kernel.org>
 <1a9566c0a41ad0d940487a9d3f0008993c075ef2.1560461404.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a9566c0a41ad0d940487a9d3f0008993c075ef2.1560461404.git.lorenzo@kernel.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 14 Jun 2019 07:54:39 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 13, 2019 at 11:43:13PM +0200, Lorenzo Bianconi wrote:
> Set usb buffer size taking into account skb_shared_info in order to
> not always copy the first part of received frames if A-MSDU is enabled
> for SG capable devices. Moreover align usb buffer size to max_ep
> boundaries and set buf_size to PAGE_SIZE even for sg case

I think this should not be applied to wirless-drivers, only first patch
that fix the bug and optimizations should be done in -next.

> +	int i, data_size;
>  
> +	data_size = rounddown(SKB_WITH_OVERHEAD(q->buf_size),
> +			      dev->usb.in_ep[MT_EP_IN_PKT_RX].max_packet);
>  	for (i = 0; i < nsgs; i++) {
>  		struct page *page;
>  		void *data;
> @@ -302,7 +304,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
>  
>  		page = virt_to_head_page(data);
>  		offset = data - page_address(page);
> -		sg_set_page(&urb->sg[i], page, q->buf_size, offset);
> +		sg_set_page(&urb->sg[i], page, data_size, offset);
<snip>
> -	q->buf_size = dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
>  	q->ndesc = MT_NUM_RX_ENTRIES;
> +	q->buf_size = PAGE_SIZE;
> +

This should be associated with decrease of MT_SG_MAX_SIZE to value that
is actually needed and currently this is 2 for 4k AMSDU.

However I don't think allocating 2 pages to avoid ieee80211 header and SNAP
copy is worth to do. For me best approach would be allocate 1 page for
4k AMSDU, 2 for 8k and 3 for 12k (still using sg, but without data_size
change to avoid 32B copying).

Stanislaw
