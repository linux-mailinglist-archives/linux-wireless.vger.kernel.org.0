Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C7A41E00
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 09:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406717AbfFLHmL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 03:42:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38792 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406598AbfFLHmL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 03:42:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7522F60A50; Wed, 12 Jun 2019 07:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560325330;
        bh=xNPHKoKqV1TutMy1xldj6g77SuBxNhjrNFll8kibEGs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MiV+9jOoYb4rcUmtLC064Gi6LkvZgLAE+iEsir2POQTM2pi5jSBNeUfmv4QUFplAd
         ZRAo0V5+PjNXCe6r/j3RrenDK9uEtBDeMc4uFwuT7YLZOTuj0vB7TWsmi5C5FgoL8w
         dqxPVy60h01uqg8hWK1FpGxQc5X37x32QuPrzcfA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15AEA605A0;
        Wed, 12 Jun 2019 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560325329;
        bh=xNPHKoKqV1TutMy1xldj6g77SuBxNhjrNFll8kibEGs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NrmlUA3GK1/rPnPk27PqVUgPpD6YR9NzqBNVVCDMD+eGUKF4Wq+iBTGEeAPmoa1oc
         MMQPcT7kI4gMft02HDbPLu/QOI7yOxhxs3a4/K8tY1AAPMpzPgDwOc+X0WfbWxr4+W
         4E/JKVGDE9maJztyA2zWkMRgaizmL70sRpgKBOkk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15AEA605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 07/11] rtw88: 8822c: use more accurate ofdm fa counting
References: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
        <1560321917-17751-8-git-send-email-yhchuang@realtek.com>
Date:   Wed, 12 Jun 2019 10:42:06 +0300
In-Reply-To: <1560321917-17751-8-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Wed, 12 Jun 2019 14:45:13 +0800")
Message-ID: <875zpbgshd.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> 8822c used to count OFDM FA count by subtracting tx count from FA count.
> But it need to substract more counters to be accurate.
>
> However, we can count it by adding up all of the FA counters we want.
> And it is simpler to add than list all of the components to substract.
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> --- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> @@ -1491,13 +1491,29 @@ static void rtw8822c_false_alarm_statistics(struct rtw_dev *rtwdev)
>  	u32 cck_enable;
>  	u32 cck_fa_cnt;
>  	u32 ofdm_fa_cnt;
> -	u32 ofdm_tx_counter;
> +	u32 ofdm_fa_cnt1, ofdm_fa_cnt2, ofdm_fa_cnt3, ofdm_fa_cnt4, ofdm_fa_cnt5;
> +	u16 parity_fail, rate_illegal, crc8_fail, mcs_fail, sb_search_fail,
> +	    fast_fsync, crc8_fail_vhta, mcs_fail_vht;
>  
>  	cck_enable = rtw_read32(rtwdev, REG_ENCCK) & BIT_CCK_BLK_EN;
>  	cck_fa_cnt = rtw_read16(rtwdev, REG_CCK_FACNT);
> -	ofdm_fa_cnt = rtw_read16(rtwdev, REG_OFDM_FACNT);
> -	ofdm_tx_counter = rtw_read16(rtwdev, REG_OFDM_TXCNT);
> -	ofdm_fa_cnt -= ofdm_tx_counter;
> +
> +	ofdm_fa_cnt1 = rtw_read32(rtwdev, REG_OFDM_FACNT1);
> +	ofdm_fa_cnt2 = rtw_read32(rtwdev, REG_OFDM_FACNT2);
> +	ofdm_fa_cnt3 = rtw_read32(rtwdev, REG_OFDM_FACNT3);
> +	ofdm_fa_cnt4 = rtw_read32(rtwdev, REG_OFDM_FACNT4);
> +	ofdm_fa_cnt5 = rtw_read32(rtwdev, REG_OFDM_FACNT5);
> +
> +	parity_fail = (ofdm_fa_cnt1 & 0xffff0000) >> 16;
> +	rate_illegal = (ofdm_fa_cnt2 & 0xffff);
> +	crc8_fail = (ofdm_fa_cnt2 & 0xffff0000) >> 16;
> +	crc8_fail_vhta = (ofdm_fa_cnt3 & 0xffff);
> +	mcs_fail = (ofdm_fa_cnt4 & 0xffff);
> +	mcs_fail_vht = (ofdm_fa_cnt4 & 0xffff0000) >> 16;
> +	fast_fsync = (ofdm_fa_cnt5 & 0xffff);
> +	sb_search_fail = (ofdm_fa_cnt5 & 0xffff0000) >> 16;

No magic numbers, please. IMO the cleanest way is to use create defines
using GENMASK() and FIELD_GET(), that way the values are proper
documented. An example (but not compile tested so can be buggy!):

#define OFDM_FA_CNT1_PARITY_FAIL GENMASK(31, 16)

parity_fail = FIELD_GET(OFDM_FA_CNT1_PARITY_FAIL, ofdm_fa_cnt1);

-- 
Kalle Valo
