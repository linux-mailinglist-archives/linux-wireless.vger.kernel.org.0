Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F7E4204E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 11:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406494AbfFLJKm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 05:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405024AbfFLJKl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 05:10:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98A3E3092675;
        Wed, 12 Jun 2019 09:10:41 +0000 (UTC)
Received: from localhost (unknown [10.43.2.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B5161001B0D;
        Wed, 12 Jun 2019 09:10:38 +0000 (UTC)
Date:   Wed, 12 Jun 2019 11:10:37 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v2 2/2] mt76: usb: do not always copy the first part of
 received frames
Message-ID: <20190612091036.GB2965@redhat.com>
References: <cover.1559293385.git.lorenzo@kernel.org>
 <2ed0b595a12944a8cfea14e066bcc4fa24f0ba44.1559293385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ed0b595a12944a8cfea14e066bcc4fa24f0ba44.1559293385.git.lorenzo@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 12 Jun 2019 09:10:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 31, 2019 at 11:38:23AM +0200, Lorenzo Bianconi wrote:
> Set usb buffer size taking into account skb_shared_info in order to
> not always copy the first part of received frames if A-MSDU is enabled
> for SG capable devices
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h |  3 +++
>  drivers/net/wireless/mediatek/mt76/usb.c  | 12 ++++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index 74d4edf941d6..7899e9b88b54 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -32,6 +32,9 @@
>  #define MT_RX_BUF_SIZE      2048
>  #define MT_SKB_HEAD_LEN     128
>  
> +#define MT_BUF_WITH_OVERHEAD(x) \
> +	((x) + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
> +
>  struct mt76_dev;
>  struct mt76_wcid;
>  
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
> index 2bfc8214c0d8..5081643ce701 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -286,7 +286,7 @@ static int
>  mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
>  		 int nsgs, gfp_t gfp)
>  {
> -	int i;
> +	int i, data_size = SKB_WITH_OVERHEAD(q->buf_size);
>  
>  	for (i = 0; i < nsgs; i++) {
>  		struct page *page;
> @@ -299,7 +299,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
>  
>  		page = virt_to_head_page(data);
>  		offset = data - page_address(page);
> -		sg_set_page(&urb->sg[i], page, q->buf_size, offset);
> +		sg_set_page(&urb->sg[i], page, data_size, offset);
>  	}
>  
>  	if (i < nsgs) {
> @@ -311,7 +311,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
>  	}
>  
>  	urb->num_sgs = max_t(int, i, urb->num_sgs);
> -	urb->transfer_buffer_length = urb->num_sgs * q->buf_size,
> +	urb->transfer_buffer_length = urb->num_sgs * data_size;
>  	sg_init_marker(urb->sg, urb->num_sgs);
>  
>  	return i ? : -ENOMEM;
> @@ -611,8 +611,12 @@ static int mt76u_alloc_rx(struct mt76_dev *dev)
>  	if (!q->entry)
>  		return -ENOMEM;
>  
> -	q->buf_size = dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
> +	if (dev->usb.sg_en)
> +		q->buf_size = MT_BUF_WITH_OVERHEAD(MT_RX_BUF_SIZE);

I strongly recommend to not doing this. While this should work
in theory creating buffer with size of 2k + some bytes might
trigger various bugs in dma mapping or other low level code.

And skb_shered_info is needed only in first buffer IIUC.

Also this patch seems to make first patch unnecessary except for
non sg_en case (in which I think rx AMSDU is broken anyway),
so I would prefer just to apply first patch.

Stanislaw

