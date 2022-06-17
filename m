Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9608254F52A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 12:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiFQKSj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 06:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381678AbiFQKSW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 06:18:22 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE12C2DAA1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DPLQTQg/V2zkueJDxCkpd+DAc6kfZ8POnGgjtisohn0=; b=VBXHyGwXDBNXbm8T0v09dAKZWU
        rWDkwjIRy+daxF0BlHaWFyGwMKhVQJpDE33iFTzRCyIdSPKcG+DOFO1wvfquOsLxMbYBLIP99d0K2
        42Bl2a9mrmBZw0VHKEg76pjkWtFwZThnSVKGqW01TPlcPSF3T/PUSMO1ff8b/NcQ1XUo=;
Received: from p200300daa71102000c7ec312ed29c590.dip0.t-ipconnect.de ([2003:da:a711:200:c7e:c312:ed29:c590] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o293N-0008LQ-Pa; Fri, 17 Jun 2022 12:18:13 +0200
Message-ID: <092a2631-4e91-203e-9199-96fd3c689afa@nbd.name>
Date:   Fri, 17 Jun 2022 12:18:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] mt76: mt7921u: enable HW beacon filter
Content-Language: en-US
To:     sean.wang@mediatek.com, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <27f75af42fe59ba9e3fadd173dfc777176eca555.1655341405.git.objelf@gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <27f75af42fe59ba9e3fadd173dfc777176eca555.1655341405.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 16.06.22 03:10, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> HW beacon filter and HW connection monitor can be supported on MT7921U
> as well so we enable them to be consistent with MT7921[E,S].
> 
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index acf6567368b7..d803a7dd5f83 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -677,8 +677,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
>   	if (changed & BSS_CHANGED_ASSOC) {
>   		mt7921_mcu_sta_update(dev, NULL, vif, true,
>   				      MT76_STA_INFO_STATE_ASSOC);
> -		if (dev->pm.enable)
> -			mt7921_mcu_set_beacon_filter(dev, vif, info->assoc);
> +		mt7921_mcu_set_beacon_filter(dev, vif, info->assoc);
To me it looks like patch description and code change don't really 
match. Could you please explain why you change it so that the beacon 
filter is enabled even if PM isn't?

- Felix
