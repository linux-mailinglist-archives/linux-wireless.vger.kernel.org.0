Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE12C1E64EE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403900AbgE1O5F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403856AbgE1O5B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:57:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9F7C08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:57:01 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeJxr-0002TK-FO; Thu, 28 May 2020 16:56:59 +0200
Date:   Thu, 28 May 2020 16:56:59 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com
Subject: Re: [PATCH 1/7] rtw88: 8821c: add basic functions
Message-ID: <20200528145659.33dcat7isqdzqvva@linutronix.de>
References: <20200520052335.22466-1-yhchuang@realtek.com>
 <20200520052335.22466-2-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200520052335.22466-2-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-20 13:23:29 [+0800], yhchuang@realtek.com wrote:
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> new file mode 100644
> index 000000000000..baf0cf5a35b3
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
…
> +static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
> +{
> +	u8 crystal_cap, val;

A space please

> +	/* power on BB/RF domain */
> +	val = rtw_read8(rtwdev, REG_SYS_FUNC_EN);
> +	val |= BIT_FEN_PCIEA;
> +	rtw_write8(rtwdev, REG_SYS_FUNC_EN, val);
> +	val |= BIT_FEN_BB_RSTB | BIT_FEN_BB_GLB_RST;
> +	rtw_write8(rtwdev, REG_SYS_FUNC_EN, val);
> +	val &= ~(BIT_FEN_BB_RSTB | BIT_FEN_BB_GLB_RST);
> +	rtw_write8(rtwdev, REG_SYS_FUNC_EN, val);
> +	val |= BIT_FEN_BB_RSTB | BIT_FEN_BB_GLB_RST;
> +	rtw_write8(rtwdev, REG_SYS_FUNC_EN, val);

So this is different compared to the other parts where you set the bits
once. Here you have to set it, clear it, set it.

> +	rtw_write8(rtwdev, REG_RF_CTRL,
> +		   BIT_RF_EN | BIT_RF_RSTB | BIT_RF_SDM_RSTB);
> +	usleep_range(10, 11);
> +	rtw_write8(rtwdev, REG_WLRF1 + 3,
> +		   BIT_RF_EN | BIT_RF_RSTB | BIT_RF_SDM_RSTB);
> +	usleep_range(10, 11);
> +
> +	/* pre init before header files config */
> +	rtw_write32_clr(rtwdev, REG_RXPSEL, BIT_RX_PSEL_RST);
> +
> +	rtw_phy_load_tables(rtwdev);
> +
> +	crystal_cap = rtwdev->efuse.crystal_cap & 0x3F;
> +	rtw_write32_mask(rtwdev, REG_AFE_XTAL_CTRL, 0x7e000000, crystal_cap);
> +	rtw_write32_mask(rtwdev, REG_AFE_PLL_CTRL, 0x7e, crystal_cap);
> +	rtw_write32_mask(rtwdev, REG_CCK0_FAREPORT, BIT(18) | BIT(22), 0);
> +
> +	/* post init after header files config */
> +	rtw_write32_set(rtwdev, REG_RXPSEL, BIT_RX_PSEL_RST);
> +
> +	rtw_phy_init(rtwdev);
> +}
> +
> +static int rtw8821c_mac_init(struct rtw_dev *rtwdev)
> +{
> +	u32 value32;
> +	u16 pre_txcnt;
> +
> +	/* protocol configuration */
> +	rtw_write8(rtwdev, REG_AMPDU_MAX_TIME_V1, WLAN_AMPDU_MAX_TIME);
> +	rtw_write8_set(rtwdev, REG_TX_HANG_CTRL, BIT_EN_EOF_V1);
> +	pre_txcnt = WLAN_PRE_TXCNT_TIME_TH | BIT_EN_PRECNT;
> +	rtw_write8(rtwdev, REG_PRECNT_CTRL, (u8)(pre_txcnt & 0xFF));
> +	rtw_write8(rtwdev, REG_PRECNT_CTRL + 1, (u8)(pre_txcnt >> 8));
> +	value32 = WLAN_RTS_LEN_TH | (WLAN_RTS_TX_TIME_TH << 8) |
> +		  (WLAN_MAX_AGG_PKT_LIMIT << 16) |
> +		  (WLAN_RTS_MAX_AGG_PKT_LIMIT << 24);
> +	rtw_write32(rtwdev, REG_PROT_MODE_CTRL, value32);
> +	rtw_write16(rtwdev, REG_BAR_MODE_CTRL + 2,
> +		    WLAN_BAR_RETRY_LIMIT | WLAN_RA_TRY_RATE_AGG_LIMIT << 8);
> +	rtw_write8(rtwdev, REG_FAST_EDCA_VOVI_SETTING, FAST_EDCA_VO_TH);
> +	rtw_write8(rtwdev, REG_FAST_EDCA_VOVI_SETTING + 2, FAST_EDCA_VI_TH);
> +	rtw_write8(rtwdev, REG_FAST_EDCA_BEBK_SETTING, FAST_EDCA_BE_TH);
> +	rtw_write8(rtwdev, REG_FAST_EDCA_BEBK_SETTING + 2, FAST_EDCA_BK_TH);
> +	rtw_write8_set(rtwdev, REG_INIRTS_RATE_SEL, BIT(5));

A space please

> +	/* EDCA configuration */
> +	rtw_write8_clr(rtwdev, REG_TIMER0_SRC_SEL, BIT_TSFT_SEL_TIMER0);
> +	rtw_write16(rtwdev, REG_TXPAUSE, 0);
> +	rtw_write8(rtwdev, REG_SLOT, WLAN_SLOT_TIME);
> +	rtw_write8(rtwdev, REG_PIFS, WLAN_PIFS_TIME);
> +	rtw_write32(rtwdev, REG_SIFS, WLAN_SIFS_CFG);
> +	rtw_write16(rtwdev, REG_EDCA_VO_PARAM + 2, WLAN_VO_TXOP_LIMIT);
> +	rtw_write16(rtwdev, REG_EDCA_VI_PARAM + 2, WLAN_VI_TXOP_LIMIT);
> +	rtw_write32(rtwdev, REG_RD_NAV_NXT, WLAN_NAV_CFG);
> +	rtw_write16(rtwdev, REG_RXTSF_OFFSET_CCK, WLAN_RX_TSF_CFG);

A space please

> +	/* Set beacon cotnrol - enable TSF and other related functions */
> +	rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
> +	/* Set send beacon related registers */
> +	rtw_write32(rtwdev, REG_TBTT_PROHIBIT, WLAN_TBTT_TIME);
> +	rtw_write8(rtwdev, REG_DRVERLYINT, WLAN_DRV_EARLY_INT);
> +	rtw_write8(rtwdev, REG_BCNDMATIM, WLAN_BCN_DMA_TIME);
> +	rtw_write8_clr(rtwdev, REG_TX_PTCL_CTRL + 1, BIT_SIFS_BK_EN >> 8);

A space please
> +	/* WMAC configuration */
> +	rtw_write32(rtwdev, REG_RXFLTMAP0, WLAN_RX_FILTER0);
> +	rtw_write16(rtwdev, REG_RXFLTMAP2, WLAN_RX_FILTER2);
> +	rtw_write32(rtwdev, REG_RCR, WLAN_RCR_CFG);
> +	rtw_write8(rtwdev, REG_RX_PKT_LIMIT, WLAN_RXPKT_MAX_SZ_512);
> +	rtw_write8(rtwdev, REG_TCR + 2, WLAN_TX_FUNC_CFG2);
> +	rtw_write8(rtwdev, REG_TCR + 1, WLAN_TX_FUNC_CFG1);
> +	rtw_write8(rtwdev, REG_ACKTO_CCK, 0x40);
> +	rtw_write8_set(rtwdev, REG_WMAC_TRXPTCL_CTL_H, BIT(1));
> +	rtw_write8_set(rtwdev, REG_SND_PTCL_CTRL, BIT(6));
> +	rtw_write32(rtwdev, REG_WMAC_OPTION_FUNCTION + 8, WLAN_MAC_OPT_FUNC2);
> +	rtw_write8(rtwdev, REG_WMAC_OPTION_FUNCTION + 4, WLAN_MAC_OPT_NORM_FUNC1);
> +
> +	return 0;
> +}
…
> +static struct rtw_page_table page_table_8821c[] = {
> +	/* not sure what [0] stands for */

So 2,3,4 is for USB (depending out endpoints), 1 is for PCI and my guess
is that 0 is for SDIO.  But yes, a better documentation of this values
wouldn't hurt.

> +	{16, 16, 16, 14, 1},
> +	{16, 16, 16, 14, 1},
> +	{16, 16, 0, 0, 1},
> +	{16, 16, 16, 0, 1},
> +	{16, 16, 16, 14, 1},
> +};
> +
> +static struct rtw_rqpn rqpn_table_8821c[] = {
> +	/* not sure what [0] stands for */

see above.

> +	{RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_NORMAL,
> +	 RTW_DMA_MAPPING_LOW, RTW_DMA_MAPPING_LOW,
> +	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
> +	{RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_NORMAL,
> +	 RTW_DMA_MAPPING_LOW, RTW_DMA_MAPPING_LOW,
> +	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
> +	{RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_NORMAL,
> +	 RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_HIGH,
> +	 RTW_DMA_MAPPING_HIGH, RTW_DMA_MAPPING_HIGH},
> +	{RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_NORMAL,
> +	 RTW_DMA_MAPPING_LOW, RTW_DMA_MAPPING_LOW,
> +	 RTW_DMA_MAPPING_HIGH, RTW_DMA_MAPPING_HIGH},
> +	{RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_NORMAL,
> +	 RTW_DMA_MAPPING_LOW, RTW_DMA_MAPPING_LOW,
> +	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
> +};

Sebastian
