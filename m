Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8424202F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 10:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbfFLI6w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 04:58:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfFLI6w (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 04:58:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9ED143082DD3;
        Wed, 12 Jun 2019 08:58:51 +0000 (UTC)
Received: from localhost (unknown [10.43.2.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53AFE17B6D;
        Wed, 12 Jun 2019 08:58:47 +0000 (UTC)
Date:   Wed, 12 Jun 2019 10:58:45 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v2 1/2] mt76: usb: fix rx A-MSDU support
Message-ID: <20190612085844.GA2965@redhat.com>
References: <cover.1559293385.git.lorenzo@kernel.org>
 <52ea155d9889aa15df44b4910806b74fa2fd9056.1559293385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ea155d9889aa15df44b4910806b74fa2fd9056.1559293385.git.lorenzo@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 12 Jun 2019 08:58:51 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi and sorry for late comment.

On Fri, May 31, 2019 at 11:38:22AM +0200, Lorenzo Bianconi wrote:
> Commit f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes
> for rx") breaks A-MSDU support. When A-MSDU is enable the device can
> receive frames up to q->buf_size but they will be discarded in
> mt76u_process_rx_entry since there is no enough room for
> skb_shared_info. Fix the issue reallocating the skb and copying in the
> linear area the first 128B of the received frames and in the frag_list
> the remaining part.
> 
> Fixes: f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes for rx")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
>  drivers/net/wireless/mediatek/mt76/usb.c  | 52 +++++++++++++++++++----
>  2 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index 97a1296562d0..74d4edf941d6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -30,6 +30,7 @@
>  #define MT_TX_RING_SIZE     256
>  #define MT_MCU_RING_SIZE    32
>  #define MT_RX_BUF_SIZE      2048
> +#define MT_SKB_HEAD_LEN     128
>  
>  struct mt76_dev;
>  struct mt76_wcid;
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
> index bbaa1365bbda..2bfc8214c0d8 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -429,6 +429,48 @@ static int mt76u_get_rx_entry_len(u8 *data, u32 data_len)
>  	return dma_len;
>  }
>  
> +static struct sk_buff *
> +mt76u_build_rx_skb(u8 *data, int len, int buf_size,
> +		   int *nsgs)
> +{
> +	int data_len = min(len, MT_SKB_HEAD_LEN);
> +	struct sk_buff *skb;
> +
> +	if (SKB_WITH_OVERHEAD(buf_size) >= MT_DMA_HDR_LEN + len) {
> +		/* fast path */
> +		skb = build_skb(data, buf_size);
> +		if (!skb)
> +			return NULL;
> +
> +		skb_reserve(skb, MT_DMA_HDR_LEN);
> +		__skb_put(skb, len);
> +
> +		return skb;
> +	}
> +
> +	/* slow path, not enough space for data and
> +	 * skb_shared_info
> +	 */
> +	skb = alloc_skb(data_len, GFP_ATOMIC);
> +	if (!skb)
> +		return NULL;
> +
> +	skb_put_data(skb, data + MT_DMA_HDR_LEN, data_len);
mt7601u and iwlmvm just copy hdrlen + 8 and put the rest
of the buffer in fragment, which supose to be more efficient,
see comment in iwl_mvm_pass_packet_to_mac80211().
 
> +	data += (data_len + MT_DMA_HDR_LEN);
> +	len -= data_len;
> +	if (len > 0) {
> +		struct page *page = virt_to_head_page(data);
> +		int offset = data - (u8 *)page_address(page);
u8 cast not needed.

> +		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> +				page, offset, len, buf_size);
> +	} else {
> +		*nsgs = 0;
This seems to be not necessary or a bug (use first buffer 2 times). 

Stanislaw
