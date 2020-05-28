Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41D1E674D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 18:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404905AbgE1QUA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 12:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404897AbgE1QT7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 12:19:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41837C08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 09:19:59 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeLG8-0004Ye-Ll; Thu, 28 May 2020 18:19:56 +0200
Date:   Thu, 28 May 2020 18:19:56 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com
Subject: Re: [PATCH 6/7] rtw88: 8821c: add false alarm statistics
Message-ID: <20200528161956.kuqont7heof5ebsn@linutronix.de>
References: <20200520052335.22466-1-yhchuang@realtek.com>
 <20200520052335.22466-7-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200520052335.22466-7-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-20 13:23:34 [+0800], yhchuang@realtek.com wrote:
> From: Tzu-En Huang <tehuang@realtek.com>
> 
> This ops is used to do statistics of false alarm periodically,
> and then fine tune RX initial gain to adaptive different
> circumstance.
> Implement check false alarm statistics for 8821c.

I would use rtw_chip_ops::false_alarm_statistics() or so. Very nice.

> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
…
> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> @@ -507,6 +507,54 @@ static void rtw8821c_set_tx_power_index(struct rtw_dev *rtwdev)
>  	}
>  }
>  
> +static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
> +{
> +	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
> +	u32 cck_enable;
> +	u32 cck_fa_cnt;
> +	u32 ofdm_fa_cnt;
> +	u32 crc32_cnt;
> +	u32 cca32_cnt;
> +
> +	cck_enable = rtw_read32(rtwdev, REG_RXPSEL) & BIT(28);
> +	cck_fa_cnt = rtw_read16(rtwdev, REG_FA_CCK);
> +	ofdm_fa_cnt = rtw_read16(rtwdev, REG_FA_OFDM);
> +
> +	dm_info->cck_fa_cnt = cck_fa_cnt;
> +	dm_info->ofdm_fa_cnt = ofdm_fa_cnt;

> +	dm_info->total_fa_cnt = ofdm_fa_cnt;
> +	dm_info->total_fa_cnt += cck_enable ? cck_fa_cnt : 0;

Since ofdm_fa_cnt isn't used otherwise you could do

	if (cck_enable)
		ofdm_fa_cnt += cck_fa_cnt;
	dm_info->total_fa_cnt = ofdm_fa_cnt;

> +	crc32_cnt = rtw_read32(rtwdev, REG_CRC_CCK);
> +	dm_info->cck_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
> +	dm_info->cck_err_cnt = FIELD_GET(GENMASK(31, 16), crc32_cnt);

a space please

> +	crc32_cnt = rtw_read32(rtwdev, REG_CRC_OFDM);
> +	dm_info->ofdm_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
> +	dm_info->ofdm_err_cnt = FIELD_GET(GENMASK(31, 16), crc32_cnt);

a space please
> +	crc32_cnt = rtw_read32(rtwdev, REG_CRC_HT);
> +	dm_info->ht_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
> +	dm_info->ht_err_cnt = FIELD_GET(GENMASK(31, 16), crc32_cnt);

a space please
> +	crc32_cnt = rtw_read32(rtwdev, REG_CRC_VHT);
> +	dm_info->vht_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
> +	dm_info->vht_err_cnt = FIELD_GET(GENMASK(31, 16), crc32_cnt);
> +
> +	cca32_cnt = rtw_read32(rtwdev, REG_CCA_OFDM);
> +	dm_info->ofdm_cca_cnt = FIELD_GET(GENMASK(31, 16), cca32_cnt);
> +	dm_info->total_cca_cnt = dm_info->ofdm_cca_cnt;
> +	if (cck_enable) {
> +		cca32_cnt = rtw_read32(rtwdev, 0xfcc);

would a register for 0xfcc look good?
			
> +		dm_info->cck_cca_cnt = FIELD_GET(GENMASK(15, 0), cca32_cnt);
> +		dm_info->total_cca_cnt += dm_info->cck_cca_cnt;
> +	}
> +
> +	rtw_write32_set(rtwdev, REG_FAS, BIT(17));
> +	rtw_write32_clr(rtwdev, REG_FAS, BIT(17));
> +	rtw_write32_clr(rtwdev, REG_RXDESC, BIT(15));
> +	rtw_write32_set(rtwdev, REG_RXDESC, BIT(15));
> +	rtw_write32_set(rtwdev, 0xb58, BIT(0));
> +	rtw_write32_clr(rtwdev, 0xb58, BIT(0));
> +}
> +
>  static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8821c[] = {
>  	{0x0086,
>  	 RTW_PWR_CUT_ALL_MSK,

Sebastian
