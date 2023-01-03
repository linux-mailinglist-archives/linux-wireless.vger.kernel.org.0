Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1E65BF6C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 12:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjACLzI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 06:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjACLzH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 06:55:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977DBD2E0
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 03:55:06 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 873636602CE7;
        Tue,  3 Jan 2023 11:55:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672746905;
        bh=e4EUjat9pToRSEm96KTsiek0XL1DaIo9ai/m2Kcwwt4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JcSj0ZpNVZN8gtIpt5l10oqndfZ82eBXiUEZPbQx9GpWlNitQyFeNXAQQVE3Coxed
         Z79ZR5joVBxeVDM6ykgwVWx8+0hnrFLdZQm0z/G/0nbFCcNW24t0S8IN/WmJilClhF
         PsJpGi1WV/yOO0/KdO6PvopIRjGGMmk2Qh8rfUgPbON+0FbQYZB5UiuP9n70pbxpsL
         Q5qVVjJfa/RDP1R3t5HIha9vxp1LzcQanKiaT8yU1ij3rXLLJybwmB82NPohmRPMUW
         R0pQkbALyLZvS09tZR6IjGz8R0hQeo/37c+EdlyMSPq92oR6faxaz5SaDu9UyP1xep
         ADSwqwr5FrZqA==
Message-ID: <838a4824-872f-0013-ecdd-acf7168708b6@collabora.com>
Date:   Tue, 3 Jan 2023 12:55:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] wifi: mt76: mt7921: fix invalid remain_on_channel
 duration
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
References: <09a2d41d349593e1cf4a542d076c1a49bd135d3e.1672476252.git.deren.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <09a2d41d349593e1cf4a542d076c1a49bd135d3e.1672476252.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Il 31/12/22 10:01, Deren Wu ha scritto:
> round_jiffies_up() may change the duration reported from chip. We should
> take the real timeout for current channel privilege.
> 
> Fixes: 034ae28b56f1 ("wifi: mt76: mt7921: introduce remain_on_channel support")
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


