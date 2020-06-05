Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AFE1EFB6E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2020 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgFEOaQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jun 2020 10:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgFEOaQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jun 2020 10:30:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC89FC08C5C2
        for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2020 07:30:15 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jhDML-0005WK-7W; Fri, 05 Jun 2020 16:30:13 +0200
Date:   Fri, 5 Jun 2020 16:30:13 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com
Subject: Re: [PATCH v2 2/5] rtw88: 8821c: add power tracking
Message-ID: <20200605143013.qnnwaemnt6l3rnf7@linutronix.de>
References: <20200603094218.19942-1-yhchuang@realtek.com>
 <20200603094218.19942-3-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200603094218.19942-3-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-03 17:42:15 [+0800], yhchuang@realtek.com wrote:
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> index 904eb494ccad..aa2457046ad1 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> @@ -61,6 +61,46 @@ static int rtw8821c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
>  	return 0;
>  }
>  
> +static const u32 rtw8821c_txscale_tbl[] = {
> +	0x081, 0x088, 0x090, 0x099, 0x0a2, 0x0ac, 0x0b6, 0x0c0, 0x0cc, 0x0d8,
> +	0x0e5, 0x0f2, 0x101, 0x110, 0x120, 0x131, 0x143, 0x156, 0x16a, 0x180,
> +	0x197, 0x1af, 0x1c8, 0x1e3, 0x200, 0x21e, 0x23e, 0x261, 0x285, 0x2ab,
> +	0x2d3, 0x2fe, 0x32b, 0x35c, 0x38e, 0x3c4, 0x3fe
> +};
> +
> +static const u8 rtw8821c_get_swing_index(struct rtw_dev *rtwdev)
> +{
> +	u8 i = 0;
> +	u32 swing, table_value;
> +
> +	swing = rtw_read32_mask(rtwdev, REG_TXSCALE_A, 0xffe00000);
> +	for (i = 0; i < ARRAY_SIZE(rtw8821c_txscale_tbl); i++) {
> +		table_value = rtw8821c_txscale_tbl[i];
> +		if (swing == table_value)
> +			break;
> +	}
> +
> +	return i;
> +}

This matches rtw8822b_get_swing_index() and rtw8822b_txscale_tbl. How
often are the lookups performed and how likely is it that the value is
not found?
With something like this:

 static int rtw8821c_get_swing_index(unsigned int swing)
 {
         unsigned short val;
         int start, end;
         int candidate;
 
         start = 0;
         end = ARRAY_SIZE(rtw8821c_txscale_tbl);
         while (start < end) {
 
                 candidate = start + (end - start) / 2;
                 val = rtw8821c_txscale_tbl[candidate];
                 if (swing == val)
                         return candidate;
                 if (swing < val)
                         end = candidate;
                 else
                         start = candidate + 1;
         }
         return -EINVAL;
 }

you would end up with more less constant lookup time with ~6 lookups in worst
case. I guess it is not a hot path but still…
Can the table become u16?

…
> +const struct rtw_pwr_track_tbl rtw8821c_rtw_pwr_track_tbl = {
> +	.pwrtrk_5gb_n[0] = rtw8821c_pwrtrk_5gb_n[0],
> +	.pwrtrk_5gb_n[1] = rtw8821c_pwrtrk_5gb_n[1],
> +	.pwrtrk_5gb_n[2] = rtw8821c_pwrtrk_5gb_n[2],

so the other driver use RTW_PWR_TRK_5G_1…3. Using constants here isn't
better because a line like

	.pwrtrk_5gb_n[2] = rtw8821c_pwrtrk_5gb_n[22],

will not trigger a warning. This is just an observation.

Sebastian
