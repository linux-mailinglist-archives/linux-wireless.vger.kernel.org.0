Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EC069F6D8
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 15:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBVOmg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 09:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjBVOme (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 09:42:34 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA993864F
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 06:42:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o4so7973396wrs.4
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 06:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freexian.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lVCW7MI+Qy/5ZmCdmoYl/ooWI3q3pGzVGV+ojATwfE=;
        b=i9DI5g9G5wvEbjS6/NlU8T3PfXwaPDf3vLb3UkGwjK3MisL5H1/XgwEsU2cuAoWkPZ
         UdIGmuVkLT1oYi9cnqVWjBqoGu7gTGviNrOOyMULg0TAkNSbCdk7jFX5GH+YrvjSaTDn
         NCXLzr5qP2LXXEvJ1A0CT0kIJ+QfyXipp6yvUzyptOU53NVp+aQDWLNill3nP22MZpVJ
         CgS0MxWFMv0t1Ftm2OYo6UBpoHVffRcIoYp/GR2J/v5bSOmIPkJUgkcyXjbGsQRQW8r5
         Qsu4TTi1G2Ef/NsvI33wVcwcYElj1X2NvofCHY5Kj5/JsvVHZSHSuWiZMbo0943YR8xf
         mkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lVCW7MI+Qy/5ZmCdmoYl/ooWI3q3pGzVGV+ojATwfE=;
        b=BkucUEr/uH9hpIQDRPmVrH1SfNMa3lhtdeVQj5m7/f4tscw7uxsm/76m0ReIdPMhkF
         gRTvny+YQd2hfBqZ9JVhQXaWzoJowD5tZXFpvgSRbHPfluphyrERCTMbq/YCl047REvn
         MGy4aMDivFfN95vZTYtkGUKJVwnpG52VjkJVQHAwkXitGV50aJcazhl1QxHE7JjSXzk5
         DIHxwWLqLRlIhtfnoBy1TvUyQ4dgIyNxcO2XLxTCW4aWdi4Sp32RnOLld3loc/eJYDXK
         pOeyfubwqh3WBpCUMeIVaKnK6P5ELlBl9GjaodzNK4Vxup2/ALHtYry7y0GvvS5TX+Rk
         ZF6A==
X-Gm-Message-State: AO0yUKXQXrw9UH1gKfXagm06EG7a2NkXOrLVY90Ncy+qhvJWZQwBgAso
        ry85J72YbcunI4jtBb8I9jud+g==
X-Google-Smtp-Source: AK7set88LJFeKPQqvZ1xnrFREpJObDAOhSBt0G0rQe7pLgoiP1AsOX66h0PzeeBOTjmLBNqfQVGgZg==
X-Received: by 2002:a5d:4acb:0:b0:2c5:9a0d:709f with SMTP id y11-20020a5d4acb000000b002c59a0d709fmr8077207wrs.15.1677076947321;
        Wed, 22 Feb 2023 06:42:27 -0800 (PST)
Received: from isilmar-4.linta.de ([2a01:4f8:212:25b0::4])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d6107000000b002c559626a50sm8097211wrt.13.2023.02.22.06.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 06:42:27 -0800 (PST)
Date:   Wed, 22 Feb 2023 15:42:03 +0100
From:   Helmut Grohne <helmut@freexian.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless@vger.kernel.org,
        Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>, netdev@vger.kernel.org,
        1029116@bugs.debian.org
Subject: Re: [PATCH] wifi: mt76: mt7921: correctly handle removal in the
 absence of firmware
Message-ID: <Y/YpuyMWwAiCkcbv@alf.mars>
Mail-Followup-To: Helmut Grohne <helmut@freexian.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org,
        Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>, netdev@vger.kernel.org,
        1029116@bugs.debian.org
References: <Y/Ss5LYSYG2M7jSq@alf.mars>
 <Y/X6DPaxF0TMaUBh@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/X6DPaxF0TMaUBh@lore-desk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Feb 22, 2023 at 12:18:36PM +0100, Lorenzo Bianconi wrote:
> Thx for working on this. I would say it is a more general issue since we have
> dbdc support in mt7915/mt7996/mt7915 devices. I think we can move the check in
> mac80211.c, what do you think? Something like (please note this patch is not
> tested):

Thanks for looking into this and improving the solution. Your patch
didn't apply cleanly to torvald's master, but it was easy to rebase.

> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
> index b117e4467c87..34abf70f44af 100644
> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> @@ -539,6 +539,7 @@ int mt76_register_phy(struct mt76_phy *phy, bool vht,
>  	if (ret)
>  		return ret;
>  
> +	set_bit(MT76_STATE_REGISTERED, &phy->state);
>  	phy->dev->phys[phy->band_idx] = phy;
>  
>  	return 0;
> @@ -549,6 +550,9 @@ void mt76_unregister_phy(struct mt76_phy *phy)
>  {
>  	struct mt76_dev *dev = phy->dev;
>  
> +	if (!test_bit(MT76_STATE_REGISTERED, &phy->state))
> +		return;
> +
>  	if (IS_ENABLED(CONFIG_MT76_LEDS))
>  		mt76_led_cleanup(phy);
>  	mt76_tx_status_check(dev, true);
> @@ -719,6 +723,7 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
>  		return ret;
>  
>  	WARN_ON(mt76_worker_setup(hw, &dev->tx_worker, NULL, "tx"));
> +	set_bit(MT76_STATE_REGISTERED, &phy->state);
>  	sched_set_fifo_low(dev->tx_worker.task);
>  
>  	return 0;
> @@ -729,6 +734,9 @@ void mt76_unregister_device(struct mt76_dev *dev)
>  {
>  	struct ieee80211_hw *hw = dev->hw;
>  
> +	if (!test_bit(MT76_STATE_REGISTERED, &dev->phy.state))
> +		return;
> +
>  	if (IS_ENABLED(CONFIG_MT76_LEDS))
>  		mt76_led_cleanup(&dev->phy);
>  	mt76_tx_status_check(dev, true);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index 4ffb6be63571..38c311760d15 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -402,6 +402,7 @@ struct mt76_tx_cb {
>  
>  enum {
>  	MT76_STATE_INITIALIZED,
> +	MT76_STATE_REGISTERED,
>  	MT76_STATE_RUNNING,
>  	MT76_STATE_MCU_RUNNING,
>  	MT76_SCANNING,
> 

Tested-by: Helmut Grohne <helmut@freexian.com>

I confirm that it really solves the problem on MT7921 PCIe hardware.

Helmut

