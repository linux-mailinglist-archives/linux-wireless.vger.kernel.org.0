Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53ABC3EB44B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 12:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbhHMKwf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 06:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240230AbhHMKwf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 06:52:35 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941CFC061756
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 03:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2nGS+ijdQIDpgRg9ZkkZPkHb1ACLUfXfWxSReLJkR2Y=; b=pKk47s/qxvtcQQNvNIM67fp5mX
        DHXUh9pmjzt//CGoguWjomRDnZbouGlECAri8nqGRnYMKyFn4BSug9xt4slWEjrGbHDbAgh1Ltl+u
        m2m+9pGeCtQE/KFaLM0qAF3I/BPI4vz/wCbWqY5xS72MklaSiax51Ojv8Skfg/ilRHaY=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mEUnC-0008Er-SC; Fri, 13 Aug 2021 12:52:02 +0200
Subject: Re: [PATCH] mt76: mt7915: add LED support
To:     MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Money Wang <money.wang@mediatek.com>
References: <20210621141430.17577-1-MeiChia.Chiu@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <670252a9-636c-9d3d-5d6e-acfcabfff4c0@nbd.name>
Date:   Fri, 13 Aug 2021 12:52:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210621141430.17577-1-MeiChia.Chiu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-06-21 16:14, MeiChia Chiu wrote:
> From: MeiChia Chiu <meichia.chiu@mediatek.com>
> 
> Initialize brightness_set and blink_set callbacks to enable LED support.
> 
> Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Money Wang <money.wang@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/init.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7915/mmio.c |  6 +++--
>  .../net/wireless/mediatek/mt76/mt7915/regs.h | 19 ++++++++++++++
>  3 files changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> index e027273..defb0ec 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -151,6 +151,64 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
>  	return 0;
>  }
>  
> +static void mt7915_led_set_config(struct led_classdev *led_cdev,
> +				  u8 delay_on, u8 delay_off)
> +{
> +	struct mt7915_dev *dev;
> +	struct mt76_dev *mt76;
> +	u32 val;
> +
> +	mt76 = container_of(led_cdev, struct mt76_dev, led_cdev);
> +	dev = container_of(mt76, struct mt7915_dev, mt76);
> +
> +	/* select TX blink mode, 2: only data frames */
> +	mt76_rmw_field(dev, MT_TMAC_TCR0(0), MT_TMAC_TCR0_TX_BLINK, 2);
Does that mean the hw triggers the LED with the configured on/off delay
on TX? I think blinking should be controlled entirely by software.

- Felix
