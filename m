Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD1248AB80
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 11:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiAKKfg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 05:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349304AbiAKKfV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 05:35:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB0BC061748
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 02:35:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E7B1B81616
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 10:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91716C36AE3;
        Tue, 11 Jan 2022 10:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641897318;
        bh=SmlyaW+tLvrpX0Zv/pe2CErTT/E585XFtwSwIV6NSlk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ip4+UBc99ZnCvmZtW47i6Uhq40LLnGXYoPCO3g4UfDoGAi75kLudMbWCzzN9uMB7r
         TAdlqSD2fY/fCSnWEB4REJNDYx8i05H8loRMBUT6rvekDrg0BMcNMR5bK/PiVXqKwn
         Yb4zz+PHH8XKeXmosrz1mW5kYndvdkGZt4NqKMebLSecokgtt2GOxcLgcA7unNe1Er
         SKr8q1ZoDjMnzD/HDUDDHP9L31krmT5TZNQ3t/TclMlwgEcUov3UUHyFBbo+bNcx24
         ooJ6u+RecyIEmzprCYFYQkwUYIDiDfU0MyVeL4Z/UYyC03OHYr8gxGfkbvEDAWHka3
         gOCu+sepnJPoA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        deren.wu@mediatek.com
Subject: Re: [PATCH 1/2] mt76: mt7921: fix a leftover race in runtime-pm
References: <cover.1640897147.git.lorenzo@kernel.org>
        <65e65daddbcec420392befa3b4f9a6aaaea21315.1640897147.git.lorenzo@kernel.org>
Date:   Tue, 11 Jan 2022 12:35:13 +0200
In-Reply-To: <65e65daddbcec420392befa3b4f9a6aaaea21315.1640897147.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Thu, 30 Dec 2021 21:47:05 +0100")
Message-ID: <87zgo2k1b2.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Fix a possible race in mt7921_pm_power_save_work() if rx/tx napi
> schedules ps_work and we are currently accessing device register
> on a different cpu.
>
> Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> index defef3496246..0744f6e42ba3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -1553,6 +1553,14 @@ void mt7921_pm_power_save_work(struct work_struct *work)
>  	    dev->fw_assert)
>  		goto out;
>  
> +	if (mutex_is_locked(&dev->mt76.mutex))
> +		/* if mt76 mutex is held we should not put the device
> +		 * to sleep since we are currently accessing device
> +		 * register map. We need to wait for the next power_save
> +		 * trigger.
> +		 */
> +		goto out;

This looks fishy to me. What protects the case when ps_work is run first
and at the same time another cpu starts accessing the registers?

Do note that I didn't check the code, so I might be missing something.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
