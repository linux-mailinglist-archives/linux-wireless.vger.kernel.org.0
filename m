Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281A66CA545
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 15:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjC0NLZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjC0NLX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 09:11:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A080268C
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 06:11:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l8-20020a05600c1d0800b003ef6708bbf6so3199422wms.5
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679922678;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VG0BH3+DJzDKB+gqlAH1BqTlHfM3+d+PPT/Nr6aqgQc=;
        b=bZ3o9D+l1FX50K/h34y5b9XZUYOxEQoXB01wag9A9AZZgtPjFOYx0hv9kzPnsjYcCV
         qXuGRyXRNzJBiaMYOsNZkebQLX19p5Ge4IrzrHgH0TnBhYPJgVRJqVDMfeJN01OhjfPp
         vyllh8KtSTs8zfAWM6FU+2qF/haoit4ywrjzI6eDCqcjjX2FWv41tCVtLBQ+XYku2y65
         HnBSiwCcFYf1vuzQcoGt33Eqkq6ETWffBEFuMDnd2kENvaoBR+BgOw8UZJ15ySfEmE5t
         7UvfP/HvG6j3e+V0aJ6eqj0Ay3FzC3QW15+YT0ZRg1pe9hJH53aaUvTKFxUtiyhnWa6J
         pOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922678;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG0BH3+DJzDKB+gqlAH1BqTlHfM3+d+PPT/Nr6aqgQc=;
        b=6H5fo+kQ2iVItpTfoKsutHoqvHFZj6LURsbC2MLFgH1A8ocxdwWJPxAVkDwPuKoGSk
         Ger0DwzaH/h0A9UKqbRhHITErWMdNVXaE1TZH6L2TiLFrU0eWMnp5itBIZp8BJcrtncw
         2IVNa1IMA9psRfxTYl0oDNNk1e0i6HWRopJW2tEHD3Ya9MW0bWgXHFFs2KV42m5nWkDA
         aLClZD6UqBrAReC2ZQ9AhHC+1u2xQMM7QMrHWY1gsay7TPMY3ieN9XWhpxUPAX0CeGtL
         OQwjvrhPzFHJo29zn6iOO+Pdp3pRECvYGWw/W4x4xVNliCaWfVSuDTGtJ1JbWOgHwdaG
         gsZA==
X-Gm-Message-State: AO0yUKUkP50RdhauL7SURpX4IkCXQDhrRq97xWkoD0GeOtwQDbclfDgg
        HJQokkn1rexVkbbDdHPAUyA=
X-Google-Smtp-Source: AK7set8w8nuahycP51mY2MpB15SW//UgRcCvzofS9uU5nrgVDsHXABsrTBzkoC82C1tgRLmiGZGY3g==
X-Received: by 2002:a05:600c:474c:b0:3ed:bfb4:ad9f with SMTP id w12-20020a05600c474c00b003edbfb4ad9fmr12160178wmo.2.1679922678644;
        Mon, 27 Mar 2023 06:11:18 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id c18-20020a7bc852000000b003ed2c0a0f37sm13605738wml.35.2023.03.27.06.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 06:11:18 -0700 (PDT)
Message-ID: <7aaa94a0-543e-3097-ea63-71fc82191817@gmail.com>
Date:   Mon, 27 Mar 2023 16:11:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [RFC PATCH 09/14] wifi: rtl8xxxu: Add parameter role to
 report_connect
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-10-martin.kaistra@linutronix.de>
Content-Language: en-US
In-Reply-To: <20230322171905.492855-10-martin.kaistra@linutronix.de>
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

On 22/03/2023 19:19, Martin Kaistra wrote:
> This allows to tell the HW if a connection is made to a STA or an AP.
> Add the implementation for the gen2 version.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      |  9 ++++++---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 ++++++-----
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index c06ad33645974..e78e0bbd23354 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1280,6 +1280,9 @@ struct rtl8xxxu_rfregs {
>  #define  H2C_JOIN_BSS_DISCONNECT	0
>  #define  H2C_JOIN_BSS_CONNECT		1
>  
> +#define H2C_ROLE_STA			1
> +#define H2C_ROLE_AP			2
> +

They describe the role of a macid, so maybe call them H2C_MACID_ROLE_*.

>  /*
>   * H2C (firmware) commands differ between the older generation chips
>   * 8188[cr]u, 819[12]cu, and 8723au, and the more recent chips 8723bu,
> @@ -1908,7 +1911,7 @@ struct rtl8xxxu_fileops {
>  				  u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
>  				  u8 macid);
>  	void (*report_connect) (struct rtl8xxxu_priv *priv,
> -				u8 macid, bool connect);
> +				u8 macid, u8 role, bool connect);
>  	void (*report_rssi) (struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
>  	void (*fill_txdesc) (struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>  			     struct ieee80211_tx_info *tx_info,
> @@ -2012,9 +2015,9 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
>  void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
>  				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz, u8 macid);
>  void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
> -				  u8 macid, bool connect);
> +				  u8 macid, u8 role, bool connect);
>  void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
> -				  u8 macid, bool connect);
> +				  u8 macid, u8 role, bool connect);
>  void rtl8xxxu_gen1_report_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
>  void rtl8xxxu_gen2_report_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
>  void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv);
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 4209880d724be..5e36fddbbb488 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4524,7 +4524,7 @@ void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
>  }
>  
>  void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
> -				  u8 macid, bool connect)
> +				  u8 macid, u8 role, bool connect)
>  {
>  	struct h2c_cmd h2c;
>  
> @@ -4541,7 +4541,7 @@ void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
>  }
>  
>  void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
> -				  u8 macid, bool connect)
> +				  u8 macid, u8 role, bool connect)
>  {
>  	/*
>  	 * The firmware turns on the rate control when it knows it's
> @@ -4557,6 +4557,7 @@ void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
>  	else
>  		h2c.media_status_rpt.parm &= ~BIT(0);
>  
> +	h2c.media_status_rpt.parm |= ((role << 4) & 0xf0);
>  	h2c.media_status_rpt.macid = macid;
>  
>  	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
> @@ -4886,13 +4887,13 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  			rtl8xxxu_write16(priv, REG_BCN_PSR_RPT,
>  					 0xc000 | vif->cfg.aid);
>  
> -			priv->fops->report_connect(priv, 0, true);
> +			priv->fops->report_connect(priv, 0, H2C_ROLE_AP, true);
>  		} else {
>  			val8 = rtl8xxxu_read8(priv, REG_BEACON_CTRL);
>  			val8 |= BEACON_DISABLE_TSF_UPDATE;
>  			rtl8xxxu_write8(priv, REG_BEACON_CTRL, val8);
>  
> -			priv->fops->report_connect(priv, 0, false);
> +			priv->fops->report_connect(priv, 0, H2C_ROLE_AP, false);
>  		}
>  	}
>  
> @@ -4953,7 +4954,7 @@ static int rtl8xxxu_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  	dev_dbg(dev, "Start AP mode\n");
>  	rtl8xxxu_set_bssid(priv, vif->bss_conf.bssid);
>  	rtl8xxxu_write16(priv, REG_BCN_INTERVAL, vif->bss_conf.beacon_int);
> -	priv->fops->report_connect(priv, 0, true);
> +	priv->fops->report_connect(priv, 0, 0, true);
>  
>  	return 0;
>  }

