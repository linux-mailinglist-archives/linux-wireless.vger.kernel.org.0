Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C369464DFA
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 13:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349205AbhLAMjw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 07:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbhLAMjv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 07:39:51 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED95C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 04:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:
        From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=aBJqhnIna/12srrx7Hhxu77xuBdV740H9IFpWBhVEkc=; b=TA68QdtytKm5w0KUgUQsOVss+G
        ocPW2y3La2J8XKaJLJRnSgoKjyoDIzD131yWbLyy5nHUD+I2SMv8QnluooIagCdwtrDwrW6sYbRbu
        +UQ4KtUsyYaRglUv0QYdiU9+Ir7CN8GnIzNhnI7A2OzIDS7fHTjPPifzelXXjpcPtO/k=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1msOqZ-00034G-2d; Wed, 01 Dec 2021 13:36:27 +0100
Message-ID: <904d5edb-99b2-ec13-c3a5-78ba4fbfd5b6@nbd.name>
Date:   Wed, 1 Dec 2021 13:36:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Content-Language: en-US
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <cover.1637652742.git.Bo.Jiao@mediatek.com>
 <2cafdbc766a12db8ef4851fc10691ea5cc0113a8.1637652742.git.Bo.Jiao@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v3 03/11] mt76: mt7915: rework dma.c to adapt mt7916
 changes
In-Reply-To: <2cafdbc766a12db8ef4851fc10691ea5cc0113a8.1637652742.git.Bo.Jiao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-11-23 08:49, Bo Jiao wrote:
> From: Bo Jiao <Bo.Jiao@mediatek.com>
> 
> The RXQ of mt7916 are separated to MT_RXQ_MAIN_WA and MT_RXQ_MCU_WA,
> which causes a hole for queue iteration so modify it accordingly.
> 
> This is an intermediate patch to add mt7916 support.
> 
> Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> ---
> v2:
> - revert the modify to mt76_for_each_q_rx() which may cause
>    not work for sdo/usb chip.
> ---
>   drivers/net/wireless/mediatek/mt76/dma.c      |  13 +-
>   drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
>   .../net/wireless/mediatek/mt76/mt7915/dma.c   | 375 ++++++++++++------
>   .../net/wireless/mediatek/mt76/mt7915/init.c  |   9 +-
>   .../net/wireless/mediatek/mt76/mt7915/mac.c   |   4 +
>   .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  38 +-
>   .../wireless/mediatek/mt76/mt7915/mt7915.h    |   3 +-
>   .../net/wireless/mediatek/mt76/mt7915/regs.h  |  60 ++-
>   8 files changed, 358 insertions(+), 145 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
> index 5e1c150..3cc1acf 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -93,7 +93,7 @@ mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
>   {
>   	int i;
>   
> -	if (!q)
> +	if (!q || !q->ndesc)
>   		return;
>   
>   	/* clear descriptors */
> @@ -233,7 +233,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
>   	struct mt76_queue_entry entry;
>   	int last;
>   
> -	if (!q)
> +	if (!q || !q->ndesc)
>   		return;
>   
>   	spin_lock_bh(&q->cleanup_lock);
> @@ -448,6 +448,9 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
>   	int len = SKB_WITH_OVERHEAD(q->buf_size);
>   	int offset = q->buf_offset;
>   
> +	if (!q->ndesc)
> +		return 0;
> +
>   	spin_lock_bh(&q->lock);
>   
>   	while (q->queued < q->ndesc - 1) {
> @@ -484,6 +487,9 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
>   	void *buf;
>   	bool more;
>   
> +	if (!q->ndesc)
> +		return;
> +
>   	spin_lock_bh(&q->lock);
>   	do {
>   		buf = mt76_dma_dequeue(dev, q, true, NULL, NULL, &more);
> @@ -508,6 +514,9 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
>   	struct mt76_queue *q = &dev->q_rx[qid];
>   	int i;
>   
> +	if (!q->ndesc)
> +		return;
> +
>   	for (i = 0; i < q->ndesc; i++)
>   		q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
>   
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index e2da720..8fd6890 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -85,6 +85,7 @@ enum mt76_rxq_id {
>   	MT_RXQ_MCU_WA,
>   	MT_RXQ_EXT,
>   	MT_RXQ_EXT_WA,
> +	MT_RXQ_MAIN_WA,
>   	__MT_RXQ_MAX
>   };
>   

The mt76 core changes should be in a separate patch.

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
> index ad9678b..05104b1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
> @@ -44,31 +44,52 @@ static int mt7915_poll_tx(struct napi_struct *napi, int budget)
>   static void __mt7915_dma_prefetch(struct mt7915_dev *dev, u32 ofs)
>   {
>   #define PREFETCH(base, depth)	((base) << 16 | (depth))
> -
> -	mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL + ofs, PREFETCH(0x0, 0x4));
> -	mt76_wr(dev, MT_WFDMA0_RX_RING1_EXT_CTRL + ofs, PREFETCH(0x40, 0x4));
> -	mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL + ofs, PREFETCH(0x80, 0x0));
> -
> -	mt76_wr(dev, MT_WFDMA1_TX_RING0_EXT_CTRL + ofs, PREFETCH(0x80, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_TX_RING1_EXT_CTRL + ofs, PREFETCH(0xc0, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_TX_RING2_EXT_CTRL + ofs, PREFETCH(0x100, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_TX_RING3_EXT_CTRL + ofs, PREFETCH(0x140, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_TX_RING4_EXT_CTRL + ofs, PREFETCH(0x180, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_TX_RING5_EXT_CTRL + ofs, PREFETCH(0x1c0, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_TX_RING6_EXT_CTRL + ofs, PREFETCH(0x200, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_TX_RING7_EXT_CTRL + ofs, PREFETCH(0x240, 0x4));
> -
> -	mt76_wr(dev, MT_WFDMA1_TX_RING16_EXT_CTRL + ofs, PREFETCH(0x280, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_TX_RING17_EXT_CTRL + ofs, PREFETCH(0x2c0, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_TX_RING18_EXT_CTRL + ofs, PREFETCH(0x300, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_TX_RING19_EXT_CTRL + ofs, PREFETCH(0x340, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_TX_RING20_EXT_CTRL + ofs, PREFETCH(0x380, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_TX_RING21_EXT_CTRL + ofs, PREFETCH(0x3c0, 0x0));
> -
> -	mt76_wr(dev, MT_WFDMA1_RX_RING0_EXT_CTRL + ofs, PREFETCH(0x3c0, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_RX_RING1_EXT_CTRL + ofs, PREFETCH(0x400, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_RX_RING2_EXT_CTRL + ofs, PREFETCH(0x440, 0x4));
> -	mt76_wr(dev, MT_WFDMA1_RX_RING3_EXT_CTRL + ofs, PREFETCH(0x480, 0x0));
> +	struct mt76_dev *mdev = &dev->mt76;
> +	u32 base_ofs = 0;
> +
> +	/* prefetch SRAM wrapping boundary for tx/rx ring. */
> +	mt76_wr(dev, MT_WFDMA_TX_RING_EXT_CTRL_FWDL + ofs,
> +		PREFETCH(0x0, 0x4));
> +	mt76_wr(dev, MT_WFDMA_TX_RING_EXT_CTRL_WM + ofs,
> +		PREFETCH(0x40, 0x4));
> +	mt76_wr(dev, MT_WFDMA_TX_RING_EXT_CTRL_BAND0 + ofs,
> +		PREFETCH(0x80, 0x4));
> +	mt76_wr(dev, MT_WFDMA_TX_RING_EXT_CTRL_BAND1 + ofs,
> +		PREFETCH(0xc0, 0x4));
> +	mt76_wr(dev, MT_WFDMA_TX_RING_EXT_CTRL_WA + ofs,
> +		PREFETCH(0x100, 0x4));
> +	mt76_wr(dev, MT_WFDMA1_TX_RING21_EXT_CTRL + ofs,
> +		PREFETCH(0x140, 0x0));
> +
> +	mt76_wr(dev, MT_WFDMA_RX_RING_EXT_CTRL_WM + ofs,
> +		PREFETCH(0x140, 0x4));
> +	if (!is_mt7915(mdev)) {
> +		mt76_wr(dev, MT_WFDMA_RX_RING_EXT_CTRL_WA + ofs,
> +			PREFETCH(0x180, 0x4));
> +		base_ofs = 0x40;
> +	}
> +	mt76_wr(dev, MT_WFDMA_RX_RING_EXT_CTRL_STS0 + ofs,
> +		PREFETCH(0x180 + base_ofs, 0x4));
> +	mt76_wr(dev, MT_WFDMA_RX_RING_EXT_CTRL_STS1 + ofs,
> +		PREFETCH(0x1c0 + base_ofs, 0x4));
> +	mt76_wr(dev, MT_WFDMA_RX_RING_EXT_CTRL_BAND0 + ofs,
> +		PREFETCH(0x200 + base_ofs, 0x4));
> +	mt76_wr(dev, MT_WFDMA_RX_RING_EXT_CTRL_BAND1 + ofs,
> +		PREFETCH(0x240 + base_ofs, 0x4));
> +
> +	/* for mt7915, the ring which is next the last
> +	 * used ring must be initialized.
> +	 */
> +	if (is_mt7915(mdev)) {
> +		mt76_wr(dev, MT_WFDMA1_TX_RING21_EXT_CTRL + ofs,
> +			PREFETCH(0x140, 0x0));
> +
> +		mt76_wr(dev, MT_WFDMA1_RX_RING3_EXT_CTRL + ofs,
> +			PREFETCH(0x200 + base_ofs, 0x0));
> +
> +		mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL + ofs,
> +			PREFETCH(0x280 + base_ofs, 0x0));
> +	}

It seems to me that a large part of the tx/rx ring related register 
differences come from the fact that they're distributed differently over 
WFDMA0 and WFDMA1 on 7915 vs 7916. Maybe this could be simplified a lot 
by using a chip specific mask for rx/tx queues that indicates which ones 
should be on WFDMA1.

This could be used in queue allocation, prefetch configuration and maybe 
in a few other places too.

- Felix
