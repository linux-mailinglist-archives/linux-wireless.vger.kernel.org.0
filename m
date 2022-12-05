Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A5642A64
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 15:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiLEO3H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 09:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiLEO3G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 09:29:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B724D6445
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 06:29:05 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2377B66015ED;
        Mon,  5 Dec 2022 14:29:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670250544;
        bh=ys8fhiXpp9xvHYpKrIJjEmW2LSYWaxJot+FfCB/4JBY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W5yslql8CovbY2VpT4REdf9LAbzb1fPe07wid9NhrEc/2QaWSSPPRHveTjyI97Sbp
         HWa5MJUYQROM2HltWz1UVqbITxZAcFuFTrEILseEeU5rjGwtzyiAtL0Iwlt1JVCYvC
         iYVIO6CwNQDomCqPCIsStEOtac/mDXh3HNuWjjP23Yp4s7zQP4vQLtYRLW8XrxIXbR
         BJkJAHeNBzJogQlSbj9lQFyY7mY6GErBOWQUrz35xVcpZQiysa1JFav3wJDK80Ih4a
         rp64vG7mtHyEVXs3oeY9bTn1xOI0A/10t5M/pFbSR6AHdQvmk5glsiTaePv1OqMBnx
         3asPdLkVxpu/w==
Message-ID: <efca1639-9dcd-4d72-7c43-4b7bf20db8c4@collabora.com>
Date:   Mon, 5 Dec 2022 15:29:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] wifi: mt76: mt7915: split mcu chan_mib array up
Content-Language: en-US
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        linux-wireless@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek@lists.infradead.org
References: <51130dcbc200962672540cb726dd9841c5ad7fe9.1670049959.git.ryder.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <51130dcbc200962672540cb726dd9841c5ad7fe9.1670049959.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Il 03/12/22 08:37, Ryder Lee ha scritto:
> The current flow confuses coverity check that leads to false reporting,
> so split the offs[] into two pieces according to chipset revision to
> silence coverity tool.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>   .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 50 ++++++++++---------
>   1 file changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index b2652de082ba..ca315af3905b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -2974,38 +2974,42 @@ int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy)
>   
>   int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch)
>   {
> -	/* strict order */
> -	static const u32 offs[] = {
> -		MIB_NON_WIFI_TIME,
> -		MIB_TX_TIME,
> -		MIB_RX_TIME,
> -		MIB_OBSS_AIRTIME,
> -		MIB_TXOP_INIT_COUNT,
> -		/* v2 */
> -		MIB_NON_WIFI_TIME_V2,
> -		MIB_TX_TIME_V2,
> -		MIB_RX_TIME_V2,
> -		MIB_OBSS_AIRTIME_V2
> -	};
>   	struct mt76_channel_state *state = phy->mt76->chan_state;
>   	struct mt76_channel_state *state_ts = &phy->state_ts;
>   	struct mt7915_dev *dev = phy->dev;
>   	struct mt7915_mcu_mib *res, req[5];
>   	struct sk_buff *skb;
> -	int i, ret, start = 0, ofs = 20;
> +	static const u32 *offs;
> +	int i, ret, len, offs_cc;
>   	u64 cc_tx;
>   

A more readable option would be

	/* strict order */
	static const u32 chip_offs_v1[] = {
		MIB_NON_WIFI_TIME,
		MIB_TX_TIME,
		MIB_RX_TIME,
		MIB_OBSS_AIRTIME,
		MIB_TXOP_INIT_COUNT,
	};

	static const u32 chip_offs_v2[] = {
		MIB_NON_WIFI_TIME_V2,
		MIB_TX_TIME_V2,
		MIB_RX_TIME_V2,
		MIB_OBSS_AIRTIME_V2
	};

	if (is_mt7915(&dev->mt76)) {
		len = ARRAY_SIZE(chip_offs_v1);
		offs = chip_offs_v1;
		offs_cc = 20;
	} else {
		len = ARRAY_SIZE(chip_offs_v2);
		offs = chip_offs_v2;
		offs_cc = 20;
	}

Regards,
Angelo


