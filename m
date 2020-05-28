Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1561E639F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390988AbgE1OUe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390924AbgE1OUd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:20:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63374C05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:20:33 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeJOZ-0001XP-10; Thu, 28 May 2020 16:20:31 +0200
Date:   Thu, 28 May 2020 16:20:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com, kai.heng.feng@canonical.com
Subject: Re: [PATCH 3/3] rtw88: fix EAPOL 4-way failure by finish IQK earlier
Message-ID: <20200528142030.yznrgjmm4ptviun4@linutronix.de>
References: <20200518081444.7664-1-yhchuang@realtek.com>
 <20200518081444.7664-4-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518081444.7664-4-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-18 16:14:44 [+0800], yhchuang@realtek.com wrote:
> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> If we connect to an AP with WPA2 security, the IQK and the
> EAPOL 4-way handshake may be failed due to overlap, because
> driver does IQK right after assoc success.

Connectig to an AP with WPA2 security may fail. The IQK and the EAPOL
4-way handshake may overlap because the driver does IQK right after
assoc success.

> For 802.11n devices, they used to do IQK in driver that could
> requires more than 100ms to finished. During IQK, any TX/RX
> events are paused. So, if the EAPOL 4-way started before IQK
> is finished, the 1/4 and 2/4 could be dropped, then the AP
> will issue deauth with reason IEEE8021X_FAILED (23).

For 802.11n devices the IQK is done in the driver and could
require more than 100ms to complete. During IQK any TX/RX
events are paused. So if the EAPOL 4-way handshake started before
IQK finished then the 1/4 and 2/4 part of the handshake could be dropped. 
The AP will then issue deauth with reason IEEE8021X_FAILED (23).

> To resolve this, move IQK routine into managed TX prepare,
> which is ieee80211_ops::mgd_prepare_tx() called before the
> managed frames (auth/assoc) are sent. This can make sure IQK
> is done before connection. While scanning, not to do IQK for
> each channel because it would take too long.

To resolve this move IQK routine into managed TX prepare
(ieee80211_ops::mgd_prepare_tx()). The callback is called
before the managed frames (auth/assoc) are sent. This will make
sure that IQK is completed before the handshake starts.
Don't do IQK during scanning because doing it each channel ill take
too long.

> For 802.11ac devices, they used to do IQK in firmware, and it
> takes less time to finish it, so we do not see EAPOL 4-way
> failure on them. But, it is still worth to move the IQK to
> mgd_prepare_tx().

The 802.11ac devices do IQK in firmware and it takes less time to
complete. Therefore we don't see a failure during the EAPOL 4-way
handshake. It is still worth IQK to ieee80211_ops::mgd_prepare_tx().

> Fixes: f5df1a8b4376 ("rtw88: 8723d: Add 8723DE to Kconfig and Makefile")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/mac80211.c |  3 +--
>  drivers/net/wireless/realtek/rtw88/main.c     | 16 ++++++++++++++++
>  drivers/net/wireless/realtek/rtw88/main.h     |  3 +++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
> index 98d2ac22f6f6..c412bc54efde 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac80211.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
> @@ -341,13 +341,11 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
>  	rtw_leave_lps_deep(rtwdev);
>  
>  	if (changed & BSS_CHANGED_ASSOC) {
> -		struct rtw_chip_info *chip = rtwdev->chip;
>  		enum rtw_net_type net_type;
>  
>  		if (conf->assoc) {
>  			rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_FINISH);
>  			net_type = RTW_NET_MGD_LINKED;
> -			chip->ops->phy_calibration(rtwdev);
>  
>  			rtwvif->aid = conf->aid;
>  			rtw_fw_download_rsvd_page(rtwdev);
> @@ -663,6 +661,7 @@ static void rtw_ops_mgd_prepare_tx(struct ieee80211_hw *hw,
>  	mutex_lock(&rtwdev->mutex);
>  	rtw_leave_lps_deep(rtwdev);
>  	rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_START);
> +	rtw_chip_prepare_tx(rtwdev);
>  	mutex_unlock(&rtwdev->mutex);
>  }
>  
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index f88a7d2370aa..d561968b67da 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -408,6 +408,22 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
>  	}
>  
>  	rtw_phy_set_tx_power_level(rtwdev, center_chan);
> +
> +	/* If set channel isn't for scanning, we'll do RF calibration once in
> +	 * this channel while mgd_prepare_tx.
> +	 */

	/* If the channel isn't set for scanning, we'll do RF calibration
	 * in ::mgd_prepare_tx(). Performing the calibration during
	 * scanning on each channel takes too long.
	 */
> +	if (!test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
> +		rtwdev->need_rfk = true;
> +}
> +
> +void rtw_chip_prepare_tx(struct rtw_dev *rtwdev)
> +{
> +	struct rtw_chip_info *chip = rtwdev->chip;
> +
> +	if (rtwdev->need_rfk) {
> +		rtwdev->need_rfk = false;
> +		chip->ops->phy_calibration(rtwdev);
> +	}
>  }

Sebastian
