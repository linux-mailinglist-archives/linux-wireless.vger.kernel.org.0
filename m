Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8004CD096B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 10:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfJIISD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 04:18:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJIISD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 04:18:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 852DC61AE2; Wed,  9 Oct 2019 08:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570609081;
        bh=v7/qoxEYUqSqeBHpUrY9F8NJZnv7GOuopmgaO3pONlo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mzog6kXRYTP/ilZSvKnaSZmhGdQplWtOELiWI+zU7gSCmiGIjUZl7IUaoCLxkwOlX
         l2yZgkSfNHRwbLiBwr35o5mPJ6Zth9Xoi7njOPc/OQdqLZWTB9ZFPf0j65Cmi2QTTm
         tJJ1ghakFXS8dyO/W6ojk7XqpwTrx/tUc9ZU5dkQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3EC061AD9;
        Wed,  9 Oct 2019 08:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570609079;
        bh=v7/qoxEYUqSqeBHpUrY9F8NJZnv7GOuopmgaO3pONlo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WVxSZ0Jhj1n1NkbltnDvRGkokZepLSX8lfjy+vTqXbARV+6ZIJ9FjYXSmcnIWjjBz
         atvOJQWpDOgA2NKfyPFPYLVbH66MYvTcZAtJfmlDeCat8t2d3YsFu5K5tTtIoravTf
         +zQLlqR45/xVTYhDmiahwCjcCgZSTuhgRIBI0soU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3EC061AD9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: Re: [PATCH 01/10] rtw88: add power tracking support
References: <20191008082101.2494-1-yhchuang@realtek.com>
        <20191008082101.2494-2-yhchuang@realtek.com>
Date:   Wed, 09 Oct 2019 11:17:55 +0300
In-Reply-To: <20191008082101.2494-2-yhchuang@realtek.com> (yhchuang's message
        of "Tue, 8 Oct 2019 16:20:52 +0800")
Message-ID: <87lftugwng.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Tzu-En Huang <tehuang@realtek.com>
>
> The temperature of the chip can affect the output power
> of the RF components. Hence driver requires to compensate
> the power by adjusting the power index recorded in the
> power swing table.
>
> And if the difference of current thermal value to the
> default thermal value exceeds a threshold, the RF IQK
> should be triggered to re-calibrate the characteristics
> of the RF components, to keep the output IQ vectors of
> the RF components orthogonal enough.
>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> +/* This table stores the values of TX power that will be adjusted by power
> + * tracking.
> + *
> + * For 5G bands, there are 3 different settings.
> + * For 2G there are cck rate and ofdm rate with different settings.
> + */
> +struct rtw_pwr_track_tbl {
> +	const u8 *pwrtrk_5gb_n[RTW_PWRTRACK_5G_BAND_SIZE];
> +	const u8 *pwrtrk_5gb_p[RTW_PWRTRACK_5G_BAND_SIZE];
> +	const u8 *pwrtrk_5ga_n[RTW_PWRTRACK_5G_BAND_SIZE];
> +	const u8 *pwrtrk_5ga_p[RTW_PWRTRACK_5G_BAND_SIZE];
> +	const u8 *pwrtrk_2gb_n;
> +	const u8 *pwrtrk_2gb_p;
> +	const u8 *pwrtrk_2ga_n;
> +	const u8 *pwrtrk_2ga_p;
> +	const u8 *pwrtrk_2g_cckb_n;
> +	const u8 *pwrtrk_2g_cckb_p;
> +	const u8 *pwrtrk_2g_ccka_n;
> +	const u8 *pwrtrk_2g_ccka_p;
> +};

[...]

> +void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
> +				struct rtw_swing_table *swing_table)
> +{
> +	const struct rtw_pwr_track_tbl *tbl = rtwdev->chip->pwr_track_tbl;
> +	u8 channel = rtwdev->hal.current_channel;
> +
> +	if (channel >= 1 && channel <= 14) {
> +		if (rtwdev->dm_info.tx_rate <= DESC_RATE11M) {
> +			swing_table->tup[0] = (u8 *)tbl->pwrtrk_2g_ccka_p;
> +			swing_table->tdown[0] = (u8 *)tbl->pwrtrk_2g_ccka_n;
> +			swing_table->tup[1] = (u8 *)tbl->pwrtrk_2g_cckb_p;
> +			swing_table->tdown[1] = (u8 *)tbl->pwrtrk_2g_cckb_n;
> +		} else {
> +			swing_table->tup[0] = (u8 *)tbl->pwrtrk_2ga_p;
> +			swing_table->tdown[0] = (u8 *)tbl->pwrtrk_2ga_n;
> +			swing_table->tup[1] = (u8 *)tbl->pwrtrk_2gb_p;
> +			swing_table->tdown[1] = (u8 *)tbl->pwrtrk_2gb_n;
> +		}

This is ugly and immeadiately caught my attention, don't cast away the
const. It's const for a reason and if you cast it away you most likely
you create a bug somewhere. It's better to avoid casting as much as
possible as they get abused so easily.

I stopped reviewing here, will continue later.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
