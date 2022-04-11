Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A344FC6E9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Apr 2022 23:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350075AbiDKVtP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Apr 2022 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiDKVtN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Apr 2022 17:49:13 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43851A3B8
        for <linux-wireless@vger.kernel.org>; Mon, 11 Apr 2022 14:46:57 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.128])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 945051A0079;
        Mon, 11 Apr 2022 21:46:55 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 16E7F78007C;
        Mon, 11 Apr 2022 21:46:55 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 556C113C2B0;
        Mon, 11 Apr 2022 14:46:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 556C113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1649713614;
        bh=vZBJEjEXVv7vkYWu45/t9P3Pseqadz+jUFmYKPilua8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CmitlglNAnRKJ1IPPDMef/C+iEmDY7pLz7Qz7GRfJsaPP95iWp191vqQlahnu5X39
         bov9byy1CqgLn9Wg2CTeM2xMclbUTdUxUyaJoOhevZizn0H2Yg8PJt0feaZnuCeH7R
         arD2FkQpboIJ3HxayD4Xo2qEw19kD/raWJDu4OxY=
Subject: Re: [PATCH 5/6] mt76: mt7915: enable radar background detection
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com
References: <cover.1641996493.git.lorenzo@kernel.org>
 <f97a4fe5bec70d8e5594c0f4d286b46b844939a5.1641996493.git.lorenzo@kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <70c4ecc0-cfc6-e924-6578-3314dca42d75@candelatech.com>
Date:   Mon, 11 Apr 2022 14:46:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f97a4fe5bec70d8e5594c0f4d286b46b844939a5.1641996493.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1649713616-S53We6qANOgR
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/12/22 6:13 AM, Lorenzo Bianconi wrote:
> Notify userland the hw supports background radar/CAC detection.

So, what about someone like me using mtk7915 4x4 radio from asia-rf?  It
has no extra RF chains afaik, and it is certainly broken when
trying to use DFS channels on my system.

Maybe you need a positive check instead of negative check before
enabling this feature?

Thanks,
Ben

> 
> Tested-by: Owen Peng <owen.peng@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> index 5c1643963506..91c7ce60f296 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -309,6 +309,7 @@ static void
>   mt7915_init_wiphy(struct ieee80211_hw *hw)
>   {
>   	struct mt7915_phy *phy = mt7915_hw_phy(hw);
> +	struct mt76_dev *mdev = &phy->dev->mt76;
>   	struct wiphy *wiphy = hw->wiphy;
>   	struct mt7915_dev *dev = phy->dev;
>   
> @@ -337,6 +338,12 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
>   	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_VHT);
>   	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
>   
> +	if (!mdev->dev->of_node ||
> +	    !of_property_read_bool(mdev->dev->of_node,
> +				   "mediatek,disable-radar-background"))
> +		wiphy_ext_feature_set(wiphy,
> +				      NL80211_EXT_FEATURE_RADAR_BACKGROUND);
> +
>   	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
>   	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
>   	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

