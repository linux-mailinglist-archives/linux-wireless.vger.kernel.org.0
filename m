Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105D46CA53A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjC0NKx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 09:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC0NKw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 09:10:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37C12135
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 06:10:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id q7-20020a05600c46c700b003ef6e809574so1970831wmo.4
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679922645;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ymrtjeRJGV7kUuYwwDOKKK97uOKCz9Rcv/Mcfqs8P2A=;
        b=EwOLqFZMUNhGOTl5387v3D8Xuag48kc2lvMje+PInK0swsGPiAeobeesoP4p4MPWlT
         NEVmQNLSpTguLUZcFLfz6DLdvOdroBWm8WdqoIJftvwGi+4tZ+U+Q8vlCcEdQNo5SeZZ
         KPNL0dfVyHwLbEMz6KVPWilretInbXtBsky9j+VYaa3RvDgm+jVgxbcGfVVion7Xisuk
         bqq1aQ9z+SGTtxhoarYgLgG/CyqRDCPDiBlipIpSzAEjavp0VoJsNsnAe78gxGdD0oYz
         1bWSZGx4R0FtOORYKC0oCYdtS/81wNA3N+GVxi7q9LA4C6CAqprRgcpssJjAaFBapYY0
         tPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922645;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymrtjeRJGV7kUuYwwDOKKK97uOKCz9Rcv/Mcfqs8P2A=;
        b=GTv8XSsDX3h8uzbZgtE7W0xR7BCLDRxGjWkVrmJXGp607IMW2trVghxCIN6CCASf0T
         pNLpQ4hYpzQCtrJh638h+2PeWNsRelOQu4xPrSAW0FzbSwrxLBRVwitRm/kIMFgbMKp9
         mDPTyHBgIwt/DdgJp5k+IDPIj2m4MbkicJT0PouHXU+nC3tPpH5asXacECxeC5N+16+p
         m9wNK/TRMo4DupVGhRKsNhi1uml/3harDa40RPlXHHUboji1BUP1Qb8TNVF7uL91Z/HN
         LNgpi5wGxTtQKJHcmqYRYdGnA0h9w2mvdAV/ZLyo6b+gqVU2z0ztigYYE8OGm4CrCXKI
         FJHw==
X-Gm-Message-State: AO0yUKVzDG68QuK/6w1KnvhY2A1cp4r5iur7zD/cdw3e09ou3NcCvbc3
        TOOLc8QqNWiRDkTwMevmhNM=
X-Google-Smtp-Source: AK7set+zDcVppyiMSTJ6dHxIPrpQ4gfXv60m+hwB0c/9iM+sU68wCFlFPLKkw+SkPDi/IkqAWkxQBQ==
X-Received: by 2002:a7b:c4c6:0:b0:3ee:1afc:c15 with SMTP id g6-20020a7bc4c6000000b003ee1afc0c15mr9352527wmk.33.1679922645301;
        Mon, 27 Mar 2023 06:10:45 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c451400b003ee443bf0c7sm8941463wmo.16.2023.03.27.06.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 06:10:45 -0700 (PDT)
Message-ID: <ee916498-f7b4-275d-831b-d97a7c6fa90f@gmail.com>
Date:   Mon, 27 Mar 2023 16:10:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [RFC PATCH 03/14] wifi: rtl8xxxu: Add beacon functions
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-4-martin.kaistra@linutronix.de>
Content-Language: en-US
In-Reply-To: <20230322171905.492855-4-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22/03/2023 19:18, Martin Kaistra wrote:
> Add a workqueue to update the beacon contents asynchronously and
> implement downloading the beacon to the HW and starting beacon tx like
> the vendor driver.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  3 +
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 81 +++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index 9d48c69ffece1..cac985271628c 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1744,6 +1744,8 @@ struct rtl8xxxu_priv {
>  	bool shutdown;
>  	struct work_struct rx_urb_wq;
>  
> +	bool beacon_enabled;
> +
>  	u8 mac_addr[ETH_ALEN];
>  	char chip_name[8];
>  	char chip_vendor[8];
> @@ -1850,6 +1852,7 @@ struct rtl8xxxu_priv {
>  	struct delayed_work ra_watchdog;
>  	struct work_struct c2hcmd_work;
>  	struct sk_buff_head c2hcmd_queue;
> +	struct work_struct update_beacon_work;
>  	struct rtl8xxxu_btcoex bt_coex;
>  	struct rtl8xxxu_ra_report ra_report;
>  	struct rtl8xxxu_cfo_tracking cfo_tracking;
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index daeaa7d6864f9..404fa6e322f58 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -1104,6 +1104,24 @@ static void rtl8xxxu_stop_tx_beacon(struct rtl8xxxu_priv *priv)
>  	val8 = rtl8xxxu_read8(priv, REG_TBTT_PROHIBIT + 2);
>  	val8 &= ~BIT(0);
>  	rtl8xxxu_write8(priv, REG_TBTT_PROHIBIT + 2, val8);
> +
> +	priv->beacon_enabled = false;
> +}
> +
> +static void rtl8xxxu_start_tx_beacon(struct rtl8xxxu_priv *priv)
> +{
> +	u8 val8;
> +
> +	val8 = rtl8xxxu_read8(priv, REG_FWHW_TXQ_CTRL + 2);
> +	val8 |= BIT(6);
> +	rtl8xxxu_write8(priv, REG_FWHW_TXQ_CTRL + 2, val8);
> +
> +	rtl8xxxu_write8(priv, REG_TBTT_PROHIBIT + 1, 0x80);
> +	val8 = rtl8xxxu_read8(priv, REG_TBTT_PROHIBIT + 2);
> +	val8 &= 0xF0;
> +	rtl8xxxu_write8(priv, REG_TBTT_PROHIBIT + 2, val8);
> +
> +	priv->beacon_enabled = true;
>  }
>  
>  
> @@ -4895,6 +4913,17 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  		dev_dbg(dev, "Changed BASIC_RATES!\n");
>  		rtl8xxxu_set_basic_rates(priv, bss_conf->basic_rates);
>  	}
> +
> +	if (changed & BSS_CHANGED_BEACON ||
> +	    (changed & BSS_CHANGED_BEACON_ENABLED &&
> +	     bss_conf->enable_beacon)) {
> +		if (!priv->beacon_enabled) {
> +			dev_dbg(dev, "BSS_CHANGED_BEACON_ENABLED\n");
> +			rtl8xxxu_start_tx_beacon(priv);
> +			schedule_work(&priv->update_beacon_work);
> +		}

Is it not necessary to stop transmitting the beacons when
bss_conf->enable_beacon is false?

> +	}
> +
>  error:
>  	return;
>  }
> @@ -5476,6 +5505,57 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>  	dev_kfree_skb(skb);
>  }
>  
> +static void rtl8xxxu_send_beacon_frame(struct ieee80211_hw *hw,
> +				       struct ieee80211_vif *vif)
> +{
> +	struct rtl8xxxu_priv *priv = hw->priv;
> +	struct sk_buff *skb = ieee80211_beacon_get(hw, vif, 0);> +	struct device *dev = &priv->udev->dev;
> +	int retry;
> +	u8 val8;
> +
> +	/* BCN_VALID, BIT16 of REG_TDECTRL = BIT0 of REG_TDECTRL+2,
> +	 * write 1 to clear, cleared by SW.
> +	 */
> +	val8 = rtl8xxxu_read8(priv, REG_TDECTRL + 2);
> +	val8 |= BIT(0);
> +	rtl8xxxu_write8(priv, REG_TDECTRL + 2, val8);
> +
> +	/* SW_BCN_SEL - Port0 */
> +	val8 = rtl8xxxu_read8(priv, REG_DWBCN1_CTRL_8723B + 2);
> +	val8 &= ~BIT(4);
> +	rtl8xxxu_write8(priv, REG_DWBCN1_CTRL_8723B + 2, val8);
> +
> +	if (skb)
> +		rtl8xxxu_tx(hw, NULL, skb);
> +
> +	retry = 100;
> +	do {
> +		val8 = rtl8xxxu_read8(priv, REG_TDECTRL + 2);
> +		if (val8 & BIT(0))
> +			break;
> +		usleep_range(10, 20);
> +	} while (retry--);
> +
> +	if (!retry)
> +		dev_err(dev, "%s: Failed to read beacon valid bit\n", __func__);
> +}
> +
> +static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
> +{
> +	struct rtl8xxxu_priv *priv =
> +		container_of(work, struct rtl8xxxu_priv, update_beacon_work);
> +	struct ieee80211_hw *hw = priv->hw;
> +	struct ieee80211_vif *vif = priv->vif;
> +
> +	if (!vif) {
> +		WARN_ONCE(true, "no vif to update beacon\n");
> +		return;
> +	}
> +
> +	rtl8xxxu_send_beacon_frame(hw, vif);
> +}
> +
>  void rtl8723au_rx_parse_phystats(struct rtl8xxxu_priv *priv,
>  				 struct ieee80211_rx_status *rx_status,
>  				 struct rtl8723au_phy_stats *phy_stats,
> @@ -7244,6 +7324,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>  	spin_lock_init(&priv->rx_urb_lock);
>  	INIT_WORK(&priv->rx_urb_wq, rtl8xxxu_rx_urb_work);
>  	INIT_DELAYED_WORK(&priv->ra_watchdog, rtl8xxxu_watchdog_callback);
> +	INIT_WORK(&priv->update_beacon_work, rtl8xxxu_update_beacon_work_callback);
>  	skb_queue_head_init(&priv->c2hcmd_queue);
>  
>  	usb_set_intfdata(interface, hw);

