Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453111E6722
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 18:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404885AbgE1QJw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 12:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404829AbgE1QJv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 12:09:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077F5C08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 09:09:51 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeL6K-0004O4-4L; Thu, 28 May 2020 18:09:48 +0200
Date:   Thu, 28 May 2020 18:09:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com
Subject: Re: [PATCH 5/7] rtw88: 8821c: add query rx desc support
Message-ID: <20200528160948.rn5eq6kguqcdf34b@linutronix.de>
References: <20200520052335.22466-1-yhchuang@realtek.com>
 <20200520052335.22466-6-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200520052335.22466-6-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-20 13:23:33 [+0800], yhchuang@realtek.com wrote:
> From: Tzu-En Huang <tehuang@realtek.com>
> 
> In different situtation, driver is able to get the current
> environment status from the information in rx packets.

Some RX packets contain also information about environment status. 

Implement rtw_chip_ops::query_rx_desc() for 8821c. Parse the RX
descriptor which describes the current condition of the received packet.
 
> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> @@ -366,6 +366,109 @@ static void rtw8821c_set_channel(struct rtw_dev *rtwdev, u8 channel, u8 bw,
>  	rtw8821c_set_channel_rxdfir(rtwdev, bw);
>  }
>  
> +static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
> +				   struct rtw_rx_pkt_stat *pkt_stat)
> +{
> +	s8 min_rx_power = -120;
> +	u8 pwdb = GET_PHY_STAT_P0_PWDB(phy_status);
> +
> +	if (pwdb >= -57)

Isn't pwdb always >= -57 since its type is unsigned?

> +		pkt_stat->rx_power[RF_PATH_A] = pwdb - 100;
> +	else
> +		pkt_stat->rx_power[RF_PATH_A] = pwdb - 102;
> +	pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power, 1);
> +	pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
> +	pkt_stat->signal_power = max(pkt_stat->rx_power[RF_PATH_A],
> +				     min_rx_power);
> +}
…

> +static void rtw8821c_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
> +				   struct rtw_rx_pkt_stat *pkt_stat,
> +				   struct ieee80211_rx_status *rx_status)
> +{
> +	struct ieee80211_hdr *hdr;
> +	u32 desc_sz = rtwdev->chip->rx_pkt_desc_sz;
> +	u8 *phy_status = NULL;
> +
> +	memset(pkt_stat, 0, sizeof(*pkt_stat));
> +
> +	pkt_stat->phy_status = GET_RX_DESC_PHYST(rx_desc);
> +	pkt_stat->icv_err = GET_RX_DESC_ICV_ERR(rx_desc);
> +	pkt_stat->crc_err = GET_RX_DESC_CRC32(rx_desc);
> +	pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc);
> +	pkt_stat->is_c2h = GET_RX_DESC_C2H(rx_desc);
> +	pkt_stat->pkt_len = GET_RX_DESC_PKT_LEN(rx_desc);
> +	pkt_stat->drv_info_sz = GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
> +	pkt_stat->shift = GET_RX_DESC_SHIFT(rx_desc);
> +	pkt_stat->rate = GET_RX_DESC_RX_RATE(rx_desc);
> +	pkt_stat->cam_id = GET_RX_DESC_MACID(rx_desc);
> +	pkt_stat->ppdu_cnt = GET_RX_DESC_PPDU_CNT(rx_desc);
> +	pkt_stat->tsf_low = GET_RX_DESC_TSFL(rx_desc);
> +
> +	/* drv_info_sz is in unit of 8-bytes */
> +	pkt_stat->drv_info_sz *= 8;
> +
> +	/* c2h cmd pkt's rx/phy status is not interested */
> +	if (pkt_stat->is_c2h)
> +		return;
> +
> +	hdr = (struct ieee80211_hdr *)(rx_desc + desc_sz + pkt_stat->shift +
> +				       pkt_stat->drv_info_sz);

I would feel safer if you could ensure that that hdr is within valid buffer bounds.
So that hdr and hdr + sizeof(*hdr)- 1 doesn't point outside of rx_desc.

> +	if (pkt_stat->phy_status) {
> +		phy_status = rx_desc + desc_sz + pkt_stat->shift;

and here, too.

> +		query_phy_status(rtwdev, phy_status, pkt_stat);
> +	}
> +
> +	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status, phy_status);
> +}
> +
>  static void
>  rtw8821c_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
>  {

Sebastian
