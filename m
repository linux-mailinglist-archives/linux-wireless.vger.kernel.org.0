Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B75F76DF7C
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 06:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjHCE5u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 00:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHCE5t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 00:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3C6E42
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 21:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39EA861BD2
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 04:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDE8C433C8;
        Thu,  3 Aug 2023 04:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691038667;
        bh=yew0nIIdv5+4cZdHKECsN2/+DIEEPUIsBer6rmfZnuQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=sZfGRrT+SOUTRe8tt6a0byCjSYAkLQ+OIBSAyZzxMVkpnzuynGE8YsPTu+xOyZP3p
         hkrqR15pNZOVnRaV16erWiKaDOt3iftzNWAsvwre5cpPlHOV/32O3b34tn2Q0jAsMi
         3qnKBtOyc3rf6Ic9LW6SsmRxyZ/Qvj7qBXdAhgxwA3JQtLT+2xgdNpY4RqaJzamb9Y
         n3tWEy9MblzCaO1VK9Lh+ZHNgggafqeuPyZC6T9AsInpj5qaYybmFYqvQ/60+sa+XJ
         VTxNePln3pYzM2GfdrrYh2aoY/rvWSbVOYGQnllU0XZdMeU9lCYZZB0A7c15eIir9f
         21jGc3tjyvxSQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] wifi: mt76: mt7915: enable BSS_CHANGED_MU_GROUPS support
References: <ff63866d7d62d088edd4a9f7587320f8f59a361f.1690999957.git.ryder.lee@mediatek.com>
Date:   Thu, 03 Aug 2023 07:58:07 +0300
In-Reply-To: <ff63866d7d62d088edd4a9f7587320f8f59a361f.1690999957.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Thu, 3 Aug 2023 02:49:44 +0800")
Message-ID: <87bkfozpr4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> The Group ID Management frame is an Action frame of category VHT.
> It is transmitted by the AP to assign or change the user position
> of a STA for one or more group IDs.
>
> Also, sniffer can use a given group id to monitor STA that belongs
> to that group.
>
> Notify underlying driver of changes via BSS_CHANGED_MU_GROUPS.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Change-Id: I3d2f5508a2b6eb7c929c3997c31a9285713c8bea

No Change-Id, please.

> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -593,6 +593,34 @@ mt7915_update_bss_color(struct ieee80211_hw *hw,
>  	}
>  }
>  
> +static void
> +mt7915_update_mu_group(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> +		       struct ieee80211_bss_conf *info)
> +{
> +	struct mt7915_phy *phy = mt7915_hw_phy(hw);
> +	struct mt7915_dev *dev = mt7915_hw_dev(hw);
> +	u8 i, band = phy->mt76->band_idx;
> +	u32 *mu;
> +
> +	mu = (u32 *)info->mu_group.membership;

Is this safe on big endian?

> +	for (i = 0; i < WLAN_MEMBERSHIP_LEN / sizeof(*mu); i++) {
> +		if (is_mt7916(&dev->mt76))
> +			mt76_wr(dev, MT_WF_PHY_RX_GID_TAB_VLD_MT7916(band, i),
> +				mu[i]);
> +		else
> +			mt76_wr(dev, MT_WF_PHY_RX_GID_TAB_VLD(band, i), mu[i]);
> +	}
> +
> +	mu = (u32 *)info->mu_group.position;

And this?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
