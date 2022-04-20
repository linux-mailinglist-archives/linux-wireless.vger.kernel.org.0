Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B225086EB
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 13:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378056AbiDTL2m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 07:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378060AbiDTL2j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 07:28:39 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28F62E5
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5NbAC5y8SSXoeF4ubJ0VGH9BseO7jD22woRHSrslIlk=; b=GwtWDzeZM7IRV6E4A5Fzd8s9Le
        2Wxpn3TAHslLjrGQbbdRjHRruSzLykD3J9dszbyJndtQfTx3k6XgrNX26t8I3b0ULrLljKSJSdToT
        dwpYYc+YgKEzzGxS5YYqM2yYydrYyyOgw5VTAPC8F1nIiZrZKGwHCSRk0KnsraZQmsoQ=;
Received: from p200300daa70ef200009e86881025829d.dip0.t-ipconnect.de ([2003:da:a70e:f200:9e:8688:1025:829d] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nh8Sz-0006bA-Su; Wed, 20 Apr 2022 13:25:50 +0200
Message-ID: <46f14357-d02b-cad3-9fa8-7e1962305251@nbd.name>
Date:   Wed, 20 Apr 2022 13:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH] mt76: mt7915: disable RX_HDR_TRANS_SHORT
Content-Language: en-US
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        "lian . chen" <lian.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20220420071144.14573-1-bo.jiao@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20220420071144.14573-1-bo.jiao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 20.04.22 09:11, Bo Jiao wrote:
> From: Bo Jiao <Bo.Jiao@mediatek.com>
> 
> This patch disables RX_TRANS_SHORT to make MDP to do header translation
> when payload less than 8 bytes, hence the (QoS) null data can be encapsulated
> to 802.3 format. However, WDS requires (QoS) null data in 802.11 format
> to created vlan AP interfaces.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: lian.chen <lian.chen@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> ---
>   drivers/net/wireless/mediatek/mt76/agg-rx.c      | 3 +++
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c | 3 +++
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c  | 4 ----
>   drivers/net/wireless/mediatek/mt76/mt7915/regs.h | 3 +++
>   4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> index 7262222..efd1a85 100644
> --- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
> +++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> @@ -167,6 +167,9 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
>   		return;
>   	}
>   
> +	if (!status->aggr)
> +		return;
> +
>   	/* not part of a BA session */
>   	ackp = status->qos_ctl & IEEE80211_QOS_CTL_ACK_POLICY_MASK;
>   	if (ackp != IEEE80211_QOS_CTL_ACK_POLICY_BLOCKACK &&
This is an unrelated change, for which I've just sent a replacement 
patch. The rest is applied.

Thanks,

- Felix
