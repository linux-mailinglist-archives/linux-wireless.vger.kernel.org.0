Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D9E2F5E5E
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 11:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbhANKJf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 05:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbhANKJe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 05:09:34 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43145C061573
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jan 2021 02:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZZhQW659v8ok3HEpZQomXzazDe7ltbs/MsSjMslqZdY=; b=tSrcpTQSFyjZbh206CqHvvZZ/E
        +BknSfjJSB4QEhvXpCDtaG9T/HdLY1QQML1LQCU2FZh5DW+HSLXjNipOfwKghLYHW95MRq1TFfTap
        yZzUEDdm9X9nm+oCRK3QX1wx0AkwjpaPzZmx6xufxeJuDOrH0l4BmKxyzVI2Og/Ym8Ys=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kzzYS-0006ED-UY; Thu, 14 Jan 2021 11:08:37 +0100
Subject: Re: [PATCH] mt76: mt7615: set mcu country code in
 mt7615_mcu_set_channel_domain()
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
References: <a86337de4272797c0e1ed5913fe0de0f02d9e130.1610127075.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <d408e117-8f1e-64a3-a3da-139b9c968f2b@nbd.name>
Date:   Thu, 14 Jan 2021 11:08:36 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <a86337de4272797c0e1ed5913fe0de0f02d9e130.1610127075.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-01-08 18:34, Lorenzo Bianconi wrote:
> Update mcu country code running mt7615_mcu_set_channel_domain routine in
> mt7615_regd_notifier().
> Filter out disabled channels in mt7615_mcu_set_channel_domain().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
>  .../net/wireless/mediatek/mt76/mt7615/init.c  | 10 +++--
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 43 +++++++++++++------
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 ++
>  4 files changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index 10034c21f812..5c86ade0aa1e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -647,6 +647,7 @@ struct mt76_dev {
>  
>  	struct mt76_rate_power rate_power;
>  
> +	char alpha2[3];
>  	enum nl80211_dfs_regions region;
>  
>  	u32 debugfs_reg;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> index a73b76e57c7f..635b94de1021 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> @@ -296,13 +296,15 @@ mt7615_regd_notifier(struct wiphy *wiphy,
>  	struct mt7615_phy *phy = mphy->priv;
>  	struct cfg80211_chan_def *chandef = &mphy->chandef;
>  
> +	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
>  	dev->mt76.region = request->dfs_region;
>  
> -	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
> -		return;
> -
>  	mt7615_mutex_acquire(dev);
> -	mt7615_dfs_init_radar_detector(phy);
> +
> +	if (chandef->chan->flags & IEEE80211_CHAN_RADAR)
> +		mt7615_dfs_init_radar_detector(phy);
> +	mt7615_mcu_set_channel_domain(phy);
> +
>  	mt7615_mutex_release(dev);
>  }
>  
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> index c49e9041006f..715423c325e1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -2981,6 +2981,7 @@ int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
>  {
>  	struct mt76_phy *mphy = phy->mt76;
>  	struct mt7615_dev *dev = phy->dev;
> +	u32 country_code = MT76_ALPHA2_TO_CC(dev->mt76.alpha2);
>  	struct mt7615_mcu_channel_domain {
>  		__le32 country_code; /* regulatory_request.alpha2 */
>  		u8 bw_2g; /* BW_20_40M		0
> @@ -2995,45 +2996,61 @@ int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
>  		u8 n_5ch;
>  		__le16 pad2;
>  	} __packed hdr = {
> +		.country_code = cpu_to_le32(country_code),
Instead of converting alpha2 to a cpu-endian u32 and then turning it
back into LE, you should be able to simply add u8 country_code[4] and
memcpy the request alpha2 to it without any order swapping.

- Felix
