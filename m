Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD61F52D7D1
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 17:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbiESPfb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 May 2022 11:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbiESPe1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 May 2022 11:34:27 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B77ED790
        for <linux-wireless@vger.kernel.org>; Thu, 19 May 2022 08:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qdN7kX6gtg59GiEPD4pwZac2Oz5xropt2h9Xzi0szOk=; b=oIdtimg3tkSPoUPgEVYuDZtdmN
        7uJjpEqvJ77FneYTrCZ5CUhB1SG8CBNhgCd5RoK3fw9ovz2+iJNl6TcT3Rj/FzYrROQCnOkCtN+En
        QCTbheKSF+HRb40u5aWrrnnDJ7e5fFQ7EGfo/O15fzcsegZ43MTh+RWL5OaUK77SM11U=;
Received: from [217.114.218.28] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nri9b-0001tZ-6Z; Thu, 19 May 2022 17:33:31 +0200
Message-ID: <8207b98b-0c10-aff4-55c4-6c7118454832@nbd.name>
Date:   Thu, 19 May 2022 17:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] mt76: mt7921: introduce BIOS SAR config in tx power
Content-Language: en-US
To:     Deren Wu <Deren.Wu@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
References: <cover.1652941276.git.deren.wu@mediatek.com>
 <2e6b69a763d60897639101506e39a2b1a81d8eab.1652941276.git.deren.wu@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <2e6b69a763d60897639101506e39a2b1a81d8eab.1652941276.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 19.05.22 08:38, Deren Wu wrote:
> From: Deren Wu <deren.wu@mediatek.com>
> 
> Add new function mt7921_set_tx_sar_pwr() to update SAR power from
> .set_sar_specs and BIOS setting. Both settings would be merged into
> mt76_freq_range_power for final tx power value.
> 
> Reviewed-by: Sean Wang <sean.wang@mediatek.com>
> Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>   .../net/wireless/mediatek/mt76/mt7921/init.c  |  3 +-
>   .../net/wireless/mediatek/mt76/mt7921/main.c  | 32 +++++++++++++------
>   .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
>   3 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index 80279f342109..c86d8805f291 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1469,20 +1469,34 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
>   }
>   #endif
>   
> +int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
> +			  const struct cfg80211_sar_specs *sar)
> +{
> +	struct mt76_phy *mphy = hw->priv;
> +	int err;
> +
> +	if (sar) {
> +		err = mt76_init_sar_power(hw, sar);
> +		if (err)
> +			return err;
> +	}
> +
> +	mt7921_init_bios_sar_power(mt7921_hw_phy(hw), !sar);
> +
> +	err = mt76_connac_mcu_set_rate_txpower(mphy);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(mt7921_set_tx_sar_pwr);
Why is this exported?

- Felix
