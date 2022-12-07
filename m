Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F583645A8C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 14:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLGNRa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 08:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLGNR3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 08:17:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F35B56EED
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 05:17:28 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F2AA6602BB7;
        Wed,  7 Dec 2022 13:17:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670419047;
        bh=Ixv5+2qeipyxLWYB1z8spcuWJvLJCGXY957CuqQgBIw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mb2zWX/28qChejNSI8AEV0tS+7vWceaGq5aLBoz/oWC82SHmAvXagin9+1d679RHC
         yA8UUQfhW8kigNyr5VSv1hSHkzXLb1xG2jKyKeTHBNeUMFjLR5q09NLH2JW0pZ46VZ
         zPgfghMMAQR09ndN8JbmRfj/4SROTZxl5XxwbbDZoH7MgLVHSaCGtpY7tfDLZOOFX9
         B3YCCGx2ZLlUdRMllQgTck2zfKSltOsmIIKFBxkDbBBqwPXr0qGBj4TwoxcNKW1f5h
         ZuRP5DKpvQSPRih/NFMf3ocftNzA/K6mB9LPZcIeZa84Im51aB6Q4r6MCqkDEhcRO4
         BqQUNjAfAliOA==
Message-ID: <65220c33-dc2d-9f3d-578b-dc973b9c043a@collabora.com>
Date:   Wed, 7 Dec 2022 14:17:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] wifi: mt76: fix coverity uninit_use_in_call in
 mt76_connac2_reverse_frag0_hdr_trans()
Content-Language: en-US
To:     Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <200ea97407b6f121da7ccd4567fde4b0426c5d9c.1670404791.git.deren.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <200ea97407b6f121da7ccd4567fde4b0426c5d9c.1670404791.git.deren.wu@mediatek.com>
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

Il 07/12/22 10:22, Deren Wu ha scritto:
> The default case for frame_contorl is invalid. We should always
> assign addr3 of this frame properly.
> 
> Coverity error message:
> if (ieee80211_has_a4(hdr.frame_control))
> (19) Event uninit_use_in_call:	Using uninitialized value "hdr".
> Field "hdr.addr3" is uninitialized when calling "memcpy".
> 	memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
> else
> 	memcpy(skb_push(skb, sizeof(hdr) - 6), &hdr, sizeof(hdr) - 6);
> 
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>

Please add the appropriate Fixes tag to this commit.

Thanks,
Angelo

