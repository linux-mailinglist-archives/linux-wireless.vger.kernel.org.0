Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3786597638
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfHUJ3g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 05:29:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55902 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfHUJ3g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 05:29:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D4A4C60E40; Wed, 21 Aug 2019 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566379774;
        bh=GKZY1jxnpJvVPvKA7ZzH4YK0+Sf31FF3nAQtvn89uvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZWUBdkQgiu+jTWEi0tZ2PIEM4EOCDU3SxAf8ZCd2sd4DaXaRbKnJnQSSIFI6J7DSh
         rrS8TYgm0kEDKdKOP6v9HVRgQB5CRFQL4V2/vyOD0Na7/TXIIxGVDoM+Isg+M354V0
         kdQQt2L08RfD3U3hqA4RgTxIm7sfbhAfKUfh3J7Q=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0C0BF609F3;
        Wed, 21 Aug 2019 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566379774;
        bh=GKZY1jxnpJvVPvKA7ZzH4YK0+Sf31FF3nAQtvn89uvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZWUBdkQgiu+jTWEi0tZ2PIEM4EOCDU3SxAf8ZCd2sd4DaXaRbKnJnQSSIFI6J7DSh
         rrS8TYgm0kEDKdKOP6v9HVRgQB5CRFQL4V2/vyOD0Na7/TXIIxGVDoM+Isg+M354V0
         kdQQt2L08RfD3U3hqA4RgTxIm7sfbhAfKUfh3J7Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Aug 2019 14:59:33 +0530
From:   Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 04/49] ath11k: add ahb.c
In-Reply-To: <8c791df54a831f32fddd634e71e5e91342532535.camel@sipsolutions.net>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <1566316095-27507-5-git-send-email-kvalo@codeaurora.org>
 (sfid-20190820_175156_108502_D7159DB2)
 <8c791df54a831f32fddd634e71e5e91342532535.camel@sipsolutions.net>
Message-ID: <e53ddcaa11d069fbe9d083b9b0105d19@codeaurora.org>
X-Sender: vthiagar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-08-21 01:35, Johannes Berg wrote:

Thanks for the comments!

> On Tue, 2019-08-20 at 18:47 +0300, Kalle Valo wrote:
>> 
>> +static const struct service_to_pipe target_service_to_ce_map_wlan[] = 
>> {
>> +	{
>> +		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
>> +		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
>> +		__cpu_to_le32(3),
>> +	},
> 
> this might be nicer as C99 initializers as well? It's a struct of some
> sort, after all.

Sure.

> 
>> +	{ /* must be last */
>> +		__cpu_to_le32(0),
>> +		__cpu_to_le32(0),
>> +		__cpu_to_le32(0),
>> +	},
> 
> You don't need endian conversion for 0, even sparse will not complain,
> but I'd argue it should anyway be something like
> 
> 	{ /* terminator entry */ }
> 
> since that's why it's there I guess?

Ok.

> 
>> +#define ATH11K_TX_RING_MASK_3 0x0
> 
> You have a LOT of masks here that are 0, that seems odd?

We'll remove them.

> 
>> +/* enum ext_irq_num - irq nubers that can be used by external modules
> 
> typo ("numbers")
> 
>> +inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 offset)
>> +{
>> +	return ioread32(ab->mem + offset);
>> +}
>> +
>> +inline void ath11k_ahb_write32(struct ath11k_base *ab, u32 offset, 
>> u32 value)
>> +{
>> +	iowrite32(value, ab->mem + offset);
>> +}
> 
> Just "inline" doesn't seem to make that much sense? If it's only used
> here then I guess it should be static, otherwise not inline? Or maybe
> you want it to be inlined *in this file* but available out-of-line
> otherwise? I'm not sure that actually is guaranteed to work right in C?

Yes, these read/write functions are used from other files as well. May 
be define
them as static inline in ahb.c will be fine.

> 
>> +		val = ath11k_ahb_read32(ab, CE_HOST_IE_ADDRESS);
>> +		val |= BIT(ce_id);
>> +		ath11k_ahb_write32(ab, CE_HOST_IE_ADDRESS, val);
> 
> You could perhaps benefit from ath11k_ahb_setbit32() or something like
> that, this repeats a few times?
> 
>> +	if (__le32_to_cpu(ce_config->pipedir) & PIPEDIR_OUT) {
>> +		val = ath11k_ahb_read32(ab, CE_HOST_IE_ADDRESS);
>> +		val &= ~BIT(ce_id);
>> +		ath11k_ahb_write32(ab, CE_HOST_IE_ADDRESS, val);
> 
> and clearbit32() maybe. Dunno, I saw only 3 instances of each here I
> guess, but still, feels repetitive.

Sure.

> 
>> +int ath11k_ahb_start(struct ath11k_base *ab)
>> +{
>> +	ath11k_ahb_ce_irqs_enable(ab);
>> +	ath11k_ce_rx_post_buf(ab);
>> +
>> +	/* Bring up other components as appropriate */
> 
> Hmm. What would be appropriate? It's not really doing anything else?

These comments added during development not to miss anything during
bring up. Now it is not really needed, we'll remove them.

> 
>> +void ath11k_ahb_stop(struct ath11k_base *ab)
>> +{
>> +	if (!test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags))
>> +		ath11k_ahb_ce_irqs_disable(ab);
>> +	ath11k_ahb_sync_ce_irqs(ab);
>> +	ath11k_ahb_kill_tasklets(ab);
>> +	del_timer_sync(&ab->rx_replenish_retry);
>> +	ath11k_ce_cleanup_pipes(ab);
>> +	/* Shutdown other components as appropriate */
> 
> likewise, it's not doing anything else?
> 

Sure. Thanks.

Vasanth
