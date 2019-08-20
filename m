Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4EB969F4
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 22:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfHTUGC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 16:06:02 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42808 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTUGC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 16:06:02 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0AOD-0007Om-8M; Tue, 20 Aug 2019 22:05:57 +0200
Message-ID: <8c791df54a831f32fddd634e71e5e91342532535.camel@sipsolutions.net>
Subject: Re: [PATCH 04/49] ath11k: add ahb.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Date:   Tue, 20 Aug 2019 22:05:55 +0200
In-Reply-To: <1566316095-27507-5-git-send-email-kvalo@codeaurora.org> (sfid-20190820_175156_108502_D7159DB2)
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
         <1566316095-27507-5-git-send-email-kvalo@codeaurora.org>
         (sfid-20190820_175156_108502_D7159DB2)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 18:47 +0300, Kalle Valo wrote:
> 
> +static const struct service_to_pipe target_service_to_ce_map_wlan[] = {
> +	{
> +		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
> +		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
> +		__cpu_to_le32(3),
> +	},

this might be nicer as C99 initializers as well? It's a struct of some
sort, after all.

> +	{ /* must be last */
> +		__cpu_to_le32(0),
> +		__cpu_to_le32(0),
> +		__cpu_to_le32(0),
> +	},

You don't need endian conversion for 0, even sparse will not complain,
but I'd argue it should anyway be something like

	{ /* terminator entry */ }

since that's why it's there I guess?

> +#define ATH11K_TX_RING_MASK_3 0x0

You have a LOT of masks here that are 0, that seems odd?

> +/* enum ext_irq_num - irq nubers that can be used by external modules

typo ("numbers")

> +inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 offset)
> +{
> +	return ioread32(ab->mem + offset);
> +}
> +
> +inline void ath11k_ahb_write32(struct ath11k_base *ab, u32 offset, u32 value)
> +{
> +	iowrite32(value, ab->mem + offset);
> +}

Just "inline" doesn't seem to make that much sense? If it's only used
here then I guess it should be static, otherwise not inline? Or maybe
you want it to be inlined *in this file* but available out-of-line
otherwise? I'm not sure that actually is guaranteed to work right in C?

> +		val = ath11k_ahb_read32(ab, CE_HOST_IE_ADDRESS);
> +		val |= BIT(ce_id);
> +		ath11k_ahb_write32(ab, CE_HOST_IE_ADDRESS, val);

You could perhaps benefit from ath11k_ahb_setbit32() or something like
that, this repeats a few times?

> +	if (__le32_to_cpu(ce_config->pipedir) & PIPEDIR_OUT) {
> +		val = ath11k_ahb_read32(ab, CE_HOST_IE_ADDRESS);
> +		val &= ~BIT(ce_id);
> +		ath11k_ahb_write32(ab, CE_HOST_IE_ADDRESS, val);

and clearbit32() maybe. Dunno, I saw only 3 instances of each here I
guess, but still, feels repetitive.

> +int ath11k_ahb_start(struct ath11k_base *ab)
> +{
> +	ath11k_ahb_ce_irqs_enable(ab);
> +	ath11k_ce_rx_post_buf(ab);
> +
> +	/* Bring up other components as appropriate */

Hmm. What would be appropriate? It's not really doing anything else?

> +void ath11k_ahb_stop(struct ath11k_base *ab)
> +{
> +	if (!test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags))
> +		ath11k_ahb_ce_irqs_disable(ab);
> +	ath11k_ahb_sync_ce_irqs(ab);
> +	ath11k_ahb_kill_tasklets(ab);
> +	del_timer_sync(&ab->rx_replenish_retry);
> +	ath11k_ce_cleanup_pipes(ab);
> +	/* Shutdown other components as appropriate */

likewise, it's not doing anything else?

johannes

