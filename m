Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C404121EA1
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 23:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfLPW4R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 17:56:17 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:40152 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfLPW4R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 17:56:17 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4968F13C283;
        Mon, 16 Dec 2019 14:56:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4968F13C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576536976;
        bh=v2KA2DrorMHcM46JB9Zju55tw82ClY+44aru2efRgl4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=eekkpdFEpqzkR7ozCNv+I19rKgWNcpjyOrQx6ECFH9Jj0HsY5BQUJ3DPn2QvbhvO5
         nJf8m6gz6U2Yz2GaR9V0XsqpqWver/soYf//Wq2Rg/4/oR6LQAZgVPD29ptigf+6sa
         aWgSG7JRnJdvL66CaQzArPdm+rBp+Kx50NNLObWY=
Subject: Re: [RFC] mac80211: Fix setting txpower to zero.
To:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
References: <20191213230334.27631-1-greearb@candelatech.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <e2c54ffb-d346-65b0-e4ab-1cd2f8ff2a27@candelatech.com>
Date:   Mon, 16 Dec 2019 14:56:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213230334.27631-1-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/13/19 3:03 PM, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> With multiple VIFS ath10k, and probably others, tries to find the
> minimum txpower for all vifs and uses that when setting txpower in
> the firmware.

Johannes, sorry to be impatient, but I want to get some new ath10k-ct
changes into OpenWRT (to fix per-chain RSSI reporting), and if only my
driver change goes in, then ath10k-ct will have the old problem that Ryan Hsu
tried to fix.

Are you OK with initializing the txpower to -1 to mean 'unset' in mac80211?  Or, do I need
to come up with some other way to indicate to the driver that the txpower should
be ignored?

Thanks,
Ben

> 
> If a second vif is added and starts to scan, it's txpower is not initialized yet
> and it set to zero.
> 
> ath10k had a patch to ignore zero values, but then it is impossible to actually set
> txpower to zero.
> 
> So, instead initialize the txpower to -1 in mac80211, and let drivers know that
> means the power has not been set and so should be ignored.
> 
> This should fix regression in:
> 
> commit 88407beb1b1462f706a1950a355fd086e1c450b6
> Author: Ryan Hsu <ryanhsu@qca.qualcomm.com>
> Date:   Tue Dec 13 14:55:19 2016 -0800
> 
>      ath10k: fix incorrect txpower set by P2P_DEVICE interface
> 
> Tested on ath10k 9984 with ath10k-ct firmware.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>   drivers/net/wireless/ath/ath10k/mac.c | 2 +-
>   drivers/net/wireless/ath/ath9k/main.c | 3 +++
>   drivers/net/wireless/ath/ath9k/xmit.c | 7 +++++--
>   include/net/mac80211.h                | 2 +-
>   net/mac80211/iface.c                  | 1 +
>   net/mac80211/main.c                   | 2 ++
>   6 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 289d03da14b2..c846f232e930 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -5906,7 +5906,7 @@ static int ath10k_mac_txpower_recalc(struct ath10k *ar)
>   	lockdep_assert_held(&ar->conf_mutex);
>   
>   	list_for_each_entry(arvif, &ar->arvifs, list) {
> -		if (arvif->txpower <= 0)
> +		if (arvif->txpower < 0) /* txpower not initialized yet? */
>   			continue;
>   
>   		if (txpower == -1)
> diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
> index 14f253199909..2edf70cf7e7e 100644
> --- a/drivers/net/wireless/ath/ath9k/main.c
> +++ b/drivers/net/wireless/ath/ath9k/main.c
> @@ -1196,6 +1196,9 @@ static void ath9k_tpc_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
>   {
>   	int *power = data;
>   
> +	if (vif->bss_conf.txpower < 0)
> +		return;
> +
>   	if (*power < vif->bss_conf.txpower)
>   		*power = vif->bss_conf.txpower;
>   }
> diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
> index 751d0d0550b5..82c592ca2cd2 100644
> --- a/drivers/net/wireless/ath/ath9k/xmit.c
> +++ b/drivers/net/wireless/ath/ath9k/xmit.c
> @@ -2114,10 +2114,13 @@ static void setup_frame_info(struct ieee80211_hw *hw,
>   
>   	if (tx_info->control.vif) {
>   		struct ieee80211_vif *vif = tx_info->control.vif;
> -
> +		if (vif->bss_conf.txpower < 0)
> +			goto nonvifpower;
>   		txpower = 2 * vif->bss_conf.txpower;
>   	} else {
> -		struct ath_softc *sc = hw->priv;
> +		struct ath_softc *sc;
> +	nonvifpower:
> +		sc = hw->priv;
>   
>   		txpower = sc->cur_chan->cur_txpower;
>   	}
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 2b70b9268f76..db66520c5389 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -569,7 +569,7 @@ struct ieee80211_ftm_responder_params {
>    * @ssid: The SSID of the current vif. Valid in AP and IBSS mode.
>    * @ssid_len: Length of SSID given in @ssid.
>    * @hidden_ssid: The SSID of the current vif is hidden. Only valid in AP-mode.
> - * @txpower: TX power in dBm
> + * @txpower: TX power in dBm.  -1 means not configured.
>    * @txpower_type: TX power adjustment used to control per packet Transmit
>    *	Power Control (TPC) in lower driver for the current vif. In particular
>    *	TPC is enabled if value passed in %txpower_type is
> diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
> index b0c2df6e22c5..49fcf9d80f85 100644
> --- a/net/mac80211/iface.c
> +++ b/net/mac80211/iface.c
> @@ -1459,6 +1459,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
>   	sdata->control_port_no_encrypt = false;
>   	sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
>   	sdata->vif.bss_conf.idle = true;
> +	sdata->vif.bss_conf.txpower = -1; /* unset */
>   
>   	sdata->noack_map = 0;
>   
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index a148509a88bc..2f53188851ee 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -145,6 +145,8 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
>   			continue;
>   		if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
>   			continue;
> +		if (sdata->vif.bss_conf.txpower < 0)
> +			continue;
>   		power = min(power, sdata->vif.bss_conf.txpower);
>   	}
>   	rcu_read_unlock();
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

