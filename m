Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479DA5E9481
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Sep 2022 18:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiIYQz1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Sep 2022 12:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiIYQzZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Sep 2022 12:55:25 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0C326AF0
        for <linux-wireless@vger.kernel.org>; Sun, 25 Sep 2022 09:55:23 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id w4so3114615qvp.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 Sep 2022 09:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date;
        bh=0g82oK4le+sYNETvvQmcpZvdDdMGU0fue7ex5fdp13A=;
        b=I6j6UFvqvHYdy5ATFdoJbGIvajn40EMC61e5Sp7YB/jBjoVslq8pYaXzSma6zfCEz2
         yVVwLOBK7sDeoyjLhDtLOS5KR2ain7Ykh2TdZmDSmzTKbeYKVzQJLI8Vos4XJpX8Z6/u
         MKpjrDEpHx70OER7xSHFAkAvaZD3Kn6taDN5gNxbHF3qq2TMawFF2pkSEu/hU8rg9T1L
         dHxPCc1eYcx9qS656mUiIRUDaKeD8glqQUgyZCW1oEGISTZ5iSn86uppNr9TTpduzcXU
         UTNGxYXQ5ZnPUHCfXOXV6unbjG/KYgY9jcjoaXYiQeZFm5FpdgiWQVF/LUoqPMcHWd+P
         xGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=0g82oK4le+sYNETvvQmcpZvdDdMGU0fue7ex5fdp13A=;
        b=f+yK95tHQV6TKqjSszl/JGZT7QSJCVQT3Yzv4ZtpHMuRms5SKjz8FNUysSMt44iwe8
         IKFUi1+iBUBr8gHgQCU3ubh6pBKlmZkys5cPMTrgtAeP5TX6/TyN73E5VmrnVESnemUJ
         h8dXEsG8Q5Fy+F5eusX8pxz3iXLQJeWyQvFRELwaDd21oRQ1qSBbUlalvt4c7fWg3ugp
         SKXlbRNaK6hTG3USH2NzVmH9I5YRerJRBbHpGNjTdr5JBvA6bAEdlhgu94/+uLL8SAx0
         BK99f4zFa5tQwpKO9umQhuhoNiBnYVE4FCNUPmov8XGwiombacQbjs4oDXm3seMKYGst
         p6hw==
X-Gm-Message-State: ACrzQf3BEpx2xTeO2bx9BP5iiPL0SEBeRt1UdIG1WRk8U5+E80RlZiv6
        GPZbwyKZXw2pP/2uWeaaIhQ=
X-Google-Smtp-Source: AMsMyM62aCDWtOtKc0+BDFsn5LWsbKRjRUMnAD4dNpv2Hh4PDHEwU+5bvgdAaHX+8vMiSVwnVm1Rrg==
X-Received: by 2002:a05:6214:242a:b0:4aa:9c94:5d77 with SMTP id gy10-20020a056214242a00b004aa9c945d77mr14363500qvb.99.1664124922806;
        Sun, 25 Sep 2022 09:55:22 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:1102::c4? ([2620:10d:c091:480::af4b])
        by smtp.gmail.com with ESMTPSA id x27-20020a05620a0b5b00b006a6ebde4799sm9720889qkg.90.2022.09.25.09.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 09:55:22 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Message-ID: <009d6437-6cdb-55f4-9a82-08b7700d47e8@gmail.com>
Date:   Sun, 25 Sep 2022 12:55:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/4] wifi: rtl8xxxu: gen2: Enable 40 MHz channel width
Content-Language: en-US
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
References: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
 <3a950997-7580-8a6b-97a0-e0a81a135456@gmail.com>
Cc:     Chris Chiu <chris.chiu@canonical.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
In-Reply-To: <3a950997-7580-8a6b-97a0-e0a81a135456@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/18/22 08:40, Bitterblue Smith wrote:
> The module parameter ht40_2g was supposed to enable 40 MHz operation,
> but it didn't.
> 
> Tell the firmware about the channel width when updating the rate mask.
> This makes it work with my gen 2 chip RTL8188FU.
> 
> I'm not sure if anything needs to be done for the gen 1 chips, if 40
> MHz channel width already works or not. They update the rate mask with
> a different structure which doesn't have a field for the channel width.
> 
> Also set the channel width correctly for sta_statistics.
> 
> Fixes: f653e69009c6 ("rtl8xxxu: Implement basic 8723b specific update_rate_mask() function")
> Fixes: bd917b3d28c9 ("rtl8xxxu: fill up txrate info for gen1 chips")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Acked-by: Jes Sorensen <jes@trained-monkey.org>



>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  6 +++---
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 21 +++++++++++++------
>  2 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index 501900c07fac..9950a2ee00aa 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1477,7 +1477,7 @@ struct rtl8xxxu_fileops {
>  	void (*set_tx_power) (struct rtl8xxxu_priv *priv, int channel,
>  			      bool ht40);
>  	void (*update_rate_mask) (struct rtl8xxxu_priv *priv,
> -				  u32 ramask, u8 rateid, int sgi);
> +				  u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
>  	void (*report_connect) (struct rtl8xxxu_priv *priv,
>  				u8 macid, bool connect);
>  	void (*fill_txdesc) (struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
> @@ -1565,9 +1565,9 @@ void rtl8xxxu_gen2_config_channel(struct ieee80211_hw *hw);
>  void rtl8xxxu_gen1_usb_quirks(struct rtl8xxxu_priv *priv);
>  void rtl8xxxu_gen2_usb_quirks(struct rtl8xxxu_priv *priv);
>  void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
> -			       u32 ramask, u8 rateid, int sgi);
> +			       u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
>  void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
> -				    u32 ramask, u8 rateid, int sgi);
> +				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
>  void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
>  				  u8 macid, bool connect);
>  void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 7978d5dcc826..7724ee8033a8 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4407,7 +4407,7 @@ static void rtl8xxxu_sw_scan_complete(struct ieee80211_hw *hw,
>  }
>  
>  void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
> -			       u32 ramask, u8 rateid, int sgi)
> +			       u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
>  {
>  	struct h2c_cmd h2c;
>  
> @@ -4427,10 +4427,15 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
>  }
>  
>  void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
> -				    u32 ramask, u8 rateid, int sgi)
> +				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
>  {
>  	struct h2c_cmd h2c;
> -	u8 bw = RTL8XXXU_CHANNEL_WIDTH_20;
> +	u8 bw;
> +
> +	if (txbw_40mhz)
> +		bw = RTL8XXXU_CHANNEL_WIDTH_40;
> +	else
> +		bw = RTL8XXXU_CHANNEL_WIDTH_20;
>  
>  	memset(&h2c, 0, sizeof(struct h2c_cmd));
>  
> @@ -4717,7 +4722,11 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  						RATE_INFO_FLAGS_SHORT_GI;
>  				}
>  
> -				rarpt->txrate.bw |= RATE_INFO_BW_20;
> +				if (rtl8xxxu_ht40_2g &&
> +				    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
> +					rarpt->txrate.bw = RATE_INFO_BW_40;
> +				else
> +					rarpt->txrate.bw = RATE_INFO_BW_20;
>  			}
>  			bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
>  			rarpt->bit_rate = bit_rate;
> @@ -4726,7 +4735,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  			priv->vif = vif;
>  			priv->rssi_level = RTL8XXXU_RATR_STA_INIT;
>  
> -			priv->fops->update_rate_mask(priv, ramask, 0, sgi);
> +			priv->fops->update_rate_mask(priv, ramask, 0, sgi, rarpt->txrate.bw == RATE_INFO_BW_40);
>  
>  			rtl8xxxu_write8(priv, REG_BCN_MAX_ERR, 0xff);
>  
> @@ -6440,7 +6449,7 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
>  		}
>  
>  		priv->rssi_level = rssi_level;
> -		priv->fops->update_rate_mask(priv, rate_bitmap, ratr_idx, sgi);
> +		priv->fops->update_rate_mask(priv, rate_bitmap, ratr_idx, sgi, txbw_40mhz);
>  	}
>  }
>  

