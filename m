Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1C35B66FC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 06:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiIMEgC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 00:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiIMEfa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 00:35:30 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B47F425EC
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 21:29:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28D4RwlsE000319, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28D4RwlsE000319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 13 Sep 2022 12:27:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 12:28:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 13 Sep 2022 12:28:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::402d:f52e:eaf0:28a2]) by
 RTEXMBS04.realtek.com.tw ([fe80::402d:f52e:eaf0:28a2%5]) with mapi id
 15.01.2375.007; Tue, 13 Sep 2022 12:28:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 03/50] wifi: ath12k: add ce.c
Thread-Topic: [PATCH 03/50] wifi: ath12k: add ce.c
Thread-Index: AQHYrmYIMsrBvw/I+06ltzv97HuLo63c8W6Q
Date:   Tue, 13 Sep 2022 04:28:18 +0000
Message-ID: <3634f14f162a4a9fb9c1c89647b9a29d@realtek.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-4-kvalo@kernel.org>
In-Reply-To: <20220812161003.27279-4-kvalo@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/9/12_=3F=3F_11:33:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Saturday, August 13, 2022 12:09 AM
> To: linux-wireless@vger.kernel.org
> Cc: ath12k@lists.infradead.org
> Subject: [PATCH 03/50] wifi: ath12k: add ce.c
> 
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> (Patches split into one patch per file for easier review, but the final
> commit will be one big patch. See the cover letter for more info.)
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/ce.c | 971 +++++++++++++++++++++++++++++++++++
>  1 file changed, 971 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
> new file mode 100644
> index 000000000000..5694eef37232
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/ce.c

[...]

> +
> +static int ath12k_ce_rx_buf_enqueue_pipe(struct ath12k_ce_pipe *pipe,
> +					 struct sk_buff *skb, dma_addr_t paddr)
> +{
> +	struct ath12k_base *ab = pipe->ab;
> +	struct ath12k_ce_ring *ring = pipe->dest_ring;
> +	struct hal_srng *srng;
> +	unsigned int write_index;
> +	unsigned int nentries_mask = ring->nentries_mask;
> +	struct hal_ce_srng_dest_desc *desc;
> +	int ret;
> +

[...]

> +
> +	ring->skb[write_index] = skb;
> +	write_index = CE_RING_IDX_INCR(nentries_mask, write_index);
> +	ring->write_index = write_index;
> +
> +	pipe->rx_buf_needed--;
> +
> +	ret = 0;

nit.
I think '= 0' can be initializer like other functions.

> +exit:
> +	ath12k_hal_srng_access_end(ab, srng);
> +
> +	spin_unlock_bh(&srng->lock);
> +
> +	return ret;
> +}
> +
> +static int ath12k_ce_rx_post_pipe(struct ath12k_ce_pipe *pipe)
> +{

[...]

> +
> +		ATH12K_SKB_RXCB(skb)->paddr = paddr;
> +
> +		ret = ath12k_ce_rx_buf_enqueue_pipe(pipe, skb, paddr);
> +

nit.
this blank line can be removed.

> +		if (ret) {
> +			ath12k_warn(ab, "failed to enqueue rx buf: %d\n", ret);
> +			dma_unmap_single(ab->dev, paddr,
> +					 skb->len + skb_tailroom(skb),
> +					 DMA_FROM_DEVICE);
> +			dev_kfree_skb_any(skb);
> +			goto exit;
> +		}
> +	}
> +
> +exit:
> +	spin_unlock_bh(&ab->ce.ce_lock);
> +	return ret;
> +}
> +

[...]

> +
> +int ath12k_ce_send(struct ath12k_base *ab, struct sk_buff *skb, u8 pipe_id,
> +		   u16 transfer_id)
> +{

[...]

> +
> +	ath12k_hal_srng_access_end(ab, srng);
> +
> +	spin_unlock_bh(&srng->lock);
> +
> +	spin_unlock_bh(&ab->ce.ce_lock);

Two unlock are duplicate of err_unlock. I think they can be merged to a single
copy to reduce maintain effort. If my opinion is accepted, maybe rename
err_unlock to out_unlock because it becomes a normal flow.

> +
> +	return 0;
> +
> +err_unlock:
> +	spin_unlock_bh(&srng->lock);
> +
> +	spin_unlock_bh(&ab->ce.ce_lock);
> +
> +	return ret;
> +}
> +

These opinions are not very important. Just for reference.

Ping-Ke

