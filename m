Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37BF197661
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfHUJpH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 05:45:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfHUJpH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 05:45:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 556ED60ACA; Wed, 21 Aug 2019 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566380706;
        bh=/o+E3pg+RxmYgRDw6Eggd7PCg/wWZx3tNnro9j3bB+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cWSxisvk7pFZ86bi4U3wc8tyv5CcJDYeF25WqbNQULDr7ocyE+cmDR8ys7GEvzRE8
         dlpHIUQ+XBjlXauyhhe0Dgepw2BNeZpfmE0tZtc2ch8bRELoW6beR0CntTfYBEr0YZ
         IgAqE4/7JKKWfFAwMp/qx2q2zuGFIqlUVp8VKk3E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A87B860A96;
        Wed, 21 Aug 2019 09:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566380705;
        bh=/o+E3pg+RxmYgRDw6Eggd7PCg/wWZx3tNnro9j3bB+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HMqcaaE5olBM8yVvGidSKeUDl1tQLLQQ2h5K1ttBVLTEWKze3iwdCemGtcS9Krg9w
         zWB3MtrET5dwM7BOdZmeVmC921kO4xsv9p09YlbcSRSqQStDzJ68LeRXu5KddebBQf
         FeWPYwpBYM14/msMwfJWc5UzGUkN0rJvlqcO4V1Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Aug 2019 15:15:05 +0530
From:   Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 06/49] ath11k: add ce.c
In-Reply-To: <54d8d4600d53bac855b19a26fa744ed16be09bf0.camel@sipsolutions.net>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <1566316095-27507-7-git-send-email-kvalo@codeaurora.org>
 (sfid-20190820_175153_878417_8C2C389B)
 <54d8d4600d53bac855b19a26fa744ed16be09bf0.camel@sipsolutions.net>
Message-ID: <1f7b32540e54f01b91b4c113acf8c1be@codeaurora.org>
X-Sender: vthiagar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-08-21 01:53, Johannes Berg wrote:
> On Tue, 2019-08-20 at 18:47 +0300, Kalle Valo wrote:
>> +static const struct ce_attr host_ce_config_wlan[] = {
>> +	/* CE0: host->target HTC control and raw streams */
>> +	{
>> +		.flags = CE_ATTR_FLAGS,
>> +		.src_nentries = 16,
>> +		.src_sz_max = 2048,
>> +		.dest_nentries = 0,
>> +	},
>> 
> Curious - this looks a lot like a similar thing in AHB, but there you
> did it all in little endian? Totally different really, just looks
> similar, or what's the reason?

This particular table is for the driver use only. This has Copy Engine 
configurations
and any Copy Engine specific send/receive callbacks. The other in ahb.c 
is the configuration
sent to firmware.

> 
>> +	ring->skb[write_index] = skb;
>> +	write_index = CE_RING_IDX_INCR(nentries_mask, write_index);
>> +	ring->write_index = write_index;
>> +
>> +	ath11k_hal_srng_access_end(ab, srng);
>> +
>> +	spin_unlock_bh(&srng->lock);
>> +
>> +	pipe->rx_buf_needed--;
>> +
>> +	return 0;
>> +
>> +err:
>> +	ath11k_hal_srng_access_end(ab, srng);
>> +
>> +	spin_unlock_bh(&srng->lock);
> 
> Seems like you could unify those unlock paths, the rx_buf_needed-- can
> almost certainly be before the access_end/unlock, and then just set
> ret=0?

Sure.

> 
>> +static int ath11k_ce_completed_send_next(struct ath11k_ce_pipe *pipe,
>> +					 struct sk_buff **skb)
> 
> Personally, I'd have preferred to have the *skb as the return value, 
> and
> use ERR_PTR()/IS_ERR() etc. to encode the error values, rather than the
> double pointer.

Ok.

> 
>> +{
>> +	struct ath11k_base *ab = pipe->ab;
>> +	struct hal_srng *srng;
>> +	unsigned int sw_index;
>> +	unsigned int nentries_mask;
>> +	u32 *desc;
>> +	int ret = 0;
> 
> Maybe don't initialize that to a success value, just for robustness? 
> You
> don't actually need to initialize it at all though if you set ret=0 
> when
> you actually succeed, which might be even nicer given that the function
> is simple enough for the compiler to figure out if you used 'ret'
> uninitialized or not.

Ok.

> 
>> +static struct ath11k_ce_ring *
>> +ath11k_ce_alloc_ring(struct ath11k_base *ab, int nentries, int 
>> desc_sz)
>> +{
>> +	struct ath11k_ce_ring *ce_ring;
>> +	dma_addr_t base_addr;
>> +
>> +	ce_ring = kzalloc(sizeof(*ce_ring) + (nentries * 
>> sizeof(*ce_ring->skb)),
>> +			  GFP_KERNEL);
> 
> You should probably use struct_size().

Sure.

Thanks.

Vasanth
