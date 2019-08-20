Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA5D96A2C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 22:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfHTUXk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 16:23:40 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43280 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTUXk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 16:23:40 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0AfG-0007nu-IY; Tue, 20 Aug 2019 22:23:35 +0200
Message-ID: <54d8d4600d53bac855b19a26fa744ed16be09bf0.camel@sipsolutions.net>
Subject: Re: [PATCH 06/49] ath11k: add ce.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Date:   Tue, 20 Aug 2019 22:23:32 +0200
In-Reply-To: <1566316095-27507-7-git-send-email-kvalo@codeaurora.org> (sfid-20190820_175153_878417_8C2C389B)
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
         <1566316095-27507-7-git-send-email-kvalo@codeaurora.org>
         (sfid-20190820_175153_878417_8C2C389B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 18:47 +0300, Kalle Valo wrote:
> +static const struct ce_attr host_ce_config_wlan[] = {
> +	/* CE0: host->target HTC control and raw streams */
> +	{
> +		.flags = CE_ATTR_FLAGS,
> +		.src_nentries = 16,
> +		.src_sz_max = 2048,
> +		.dest_nentries = 0,
> +	},
> 
Curious - this looks a lot like a similar thing in AHB, but there you
did it all in little endian? Totally different really, just looks
similar, or what's the reason?

> +	ring->skb[write_index] = skb;
> +	write_index = CE_RING_IDX_INCR(nentries_mask, write_index);
> +	ring->write_index = write_index;
> +
> +	ath11k_hal_srng_access_end(ab, srng);
> +
> +	spin_unlock_bh(&srng->lock);
> +
> +	pipe->rx_buf_needed--;
> +
> +	return 0;
> +
> +err:
> +	ath11k_hal_srng_access_end(ab, srng);
> +
> +	spin_unlock_bh(&srng->lock);

Seems like you could unify those unlock paths, the rx_buf_needed-- can
almost certainly be before the access_end/unlock, and then just set
ret=0?

> +static int ath11k_ce_completed_send_next(struct ath11k_ce_pipe *pipe,
> +					 struct sk_buff **skb)

Personally, I'd have preferred to have the *skb as the return value, and
use ERR_PTR()/IS_ERR() etc. to encode the error values, rather than the
double pointer.

> +{
> +	struct ath11k_base *ab = pipe->ab;
> +	struct hal_srng *srng;
> +	unsigned int sw_index;
> +	unsigned int nentries_mask;
> +	u32 *desc;
> +	int ret = 0;

Maybe don't initialize that to a success value, just for robustness? You
don't actually need to initialize it at all though if you set ret=0 when
you actually succeed, which might be even nicer given that the function
is simple enough for the compiler to figure out if you used 'ret'
uninitialized or not.

> +static struct ath11k_ce_ring *
> +ath11k_ce_alloc_ring(struct ath11k_base *ab, int nentries, int desc_sz)
> +{
> +	struct ath11k_ce_ring *ce_ring;
> +	dma_addr_t base_addr;
> +
> +	ce_ring = kzalloc(sizeof(*ce_ring) + (nentries * sizeof(*ce_ring->skb)),
> +			  GFP_KERNEL);

You should probably use struct_size().

johannes

