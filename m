Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5E71C5727
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 15:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgEENiU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 09:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgEENiU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 09:38:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8862C061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 06:38:19 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jVxm5-0007ZH-JV; Tue, 05 May 2020 15:38:17 +0200
Date:   Tue, 5 May 2020 15:38:17 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com
Subject: Re: [PATCH v4 2/8] rtw88: 8723d: Add query_rx_desc
Message-ID: <20200505133817.tkr3kxduzhjnk6e3@linutronix.de>
References: <20200504105010.10780-1-yhchuang@realtek.com>
 <20200504105010.10780-3-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200504105010.10780-3-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-04 18:50:04 [+0800], yhchuang@realtek.com wrote:
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
> index 6321dea83519..035049a29e7c 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
> @@ -44,6 +44,28 @@ struct rtw8723d_efuse {
>  	struct rtw8723de_efuse e;
>  };
>  
> +/* phy status page0 */
> +#define GET_PHY_STAT_P0_PWDB(phy_stat)                                         \
> +	le32_get_bits(*((__le32 *)(phy_stat) + 0x00), GENMASK(15, 8))
> +
> +/* phy status page1 */
> +#define GET_PHY_STAT_P1_PWDB_A(phy_stat)                                       \
> +	le32_get_bits(*((__le32 *)(phy_stat) + 0x00), GENMASK(15, 8))
> +#define GET_PHY_STAT_P1_PWDB_B(phy_stat)                                       \
> +	le32_get_bits(*((__le32 *)(phy_stat) + 0x00), GENMASK(23, 16))
> +#define GET_PHY_STAT_P1_RF_MODE(phy_stat)                                      \
> +	le32_get_bits(*((__le32 *)(phy_stat) + 0x03), GENMASK(29, 28))
> +#define GET_PHY_STAT_P1_L_RXSC(phy_stat)                                       \
> +	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(11, 8))
> +#define GET_PHY_STAT_P1_HT_RXSC(phy_stat)                                      \
> +	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(15, 12))
> +#define GET_PHY_STAT_P1_RXEVM_A(phy_stat)                                      \
> +	le32_get_bits(*((__le32 *)(phy_stat) + 0x04), GENMASK(7, 0))
> +#define GET_PHY_STAT_P1_CFO_TAIL_A(phy_stat)                                   \
> +	le32_get_bits(*((__le32 *)(phy_stat) + 0x05), GENMASK(7, 0))
> +#define GET_PHY_STAT_P1_RXSNR_A(phy_stat)                                      \
> +	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(7, 0))
> +

Out of curiosity: Does it make sense to merge these defines into a
common file? Unless I missed something, b and c have the same ones here.

>  #define REG_OFDM0_XAAGC1	0x0c50
>  #define REG_OFDM0_XBAGC1	0x0c58
>  
> -- 
> 2.17.1

Sebastian
