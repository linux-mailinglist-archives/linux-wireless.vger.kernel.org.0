Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA5350807E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 07:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346941AbiDTFXl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 01:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbiDTFXk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 01:23:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8B3587B
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 22:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:
        From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=YAZC9y8BBhsm62CdLgduktz90VpmUPVlcKmGJkLc64w=; b=lA91Tk/4hnua5jf4aEIAWRR1sV
        WIKl9OGKQoW/fH/6ev9Qqb5GdhIJfDlbokw0y2slAZs+912GNSY4xQo5i0jMUZ6yriao4VVjeVRcU
        EDZoEJ5JRE2U/IIspZKQSzr68VZANu47JkOMKteLVHw3KomerHBP9OqnnpEQphZkz4xo=;
Received: from p200300daa70ef200009e86881025829d.dip0.t-ipconnect.de ([2003:da:a70e:f200:9e:8688:1025:829d] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nh2ll-00024n-85; Wed, 20 Apr 2022 07:20:49 +0200
Message-ID: <c7757409-9197-32d1-84f1-6c5588c92a73@nbd.name>
Date:   Wed, 20 Apr 2022 07:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Content-Language: en-US
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20220420040346.8378-1-bo.jiao@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH] mt76: mt7915: report qos_ctl without ACK policy
In-Reply-To: <20220420040346.8378-1-bo.jiao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 20.04.22 06:03, Bo Jiao wrote:
> From: Bo Jiao <Bo.Jiao@mediatek.com>
> 
> there is no need to report to the mac80211 layer the ACK policy which may
> cause rx out-of-order issue, because the hardware rmac module already handle it
> 
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> index b47aea6..5080280 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -675,6 +675,11 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
>   
>   		fc = cpu_to_le16(FIELD_GET(MT_RXD6_FRAME_CONTROL, v0));
>   		qos_ctl = FIELD_GET(MT_RXD8_QOS_CTL, v2);
> +		/*
> +		 * there is no need to report the ACK policy to the
> +		 * mac80211 layer, because hw has already processed it.
> +		 */
> +		qos_ctl &= ~IEEE80211_QOS_CTL_ACK_POLICY_MASK;
I don't understand this change at all. First of all, the qos_ctl field 
isn't really reported to the mac80211 layer, it's used in mt76 internally.
The rx reorder code uses it to detect no-ack policy in order to avoid 
reordering for it.
Since you're masking out the ack policy, the value will be 
IEEE80211_QOS_CTL_ACK_POLICY_NORMAL, which ends up forcibly enabling rx 
reordering, even when the policy indicates no-ack.
How does this help, and what part does the rmac module already handle?

- Felix
