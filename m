Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24566DE2B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 13:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbjAQMyk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 07:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbjAQMy1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 07:54:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D46D305E5
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 04:54:24 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9FD246602D6D;
        Tue, 17 Jan 2023 12:54:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673960063;
        bh=ybDJyEsG2p+R9ociVobtOJpRk9E5EtsX4W0/x3OP+ew=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Vnk4EWG8K9v1Y/gB9LAZUAnVWTN/KJw6vtAnMJq2914rYBX45sPCTMx970KDY53tN
         C4JuKvANepXMZk5MGNea4SwAhoyURhJ/Ok0sdKyHx7+i/pP0wu0qgdgYAVQLNln+ln
         Ut6mVSv/A+avgThCmZqSzlIojxXjruBFgyvBntBwgjF6u9QbvFIyedY4I2xcT0Av3u
         k1py8FSEGIktQ+Zi8UQi3wg6D52iwlR8Jo44UdPRvpQLnLR5D0yvpgnj6OJHE3sux0
         N6mO97U0bLN3RisFepHXpT1jAYbasmWnqCYz1gIyUigCjYvUVraduFKxz5xwIjZrg8
         dY5IK6+IFwg3g==
Message-ID: <6e95eb4f-614b-7b09-38ad-d23212ef81b3@collabora.com>
Date:   Tue, 17 Jan 2023 13:54:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] wifi: mt76: mt7921: fix rx filter incorrect by drv/fw
 inconsistent
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
References: <b9ebeda5d445f66fceb17c48c8251093dfe94c57.1673947063.git.deren.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <b9ebeda5d445f66fceb17c48c8251093dfe94c57.1673947063.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Il 17/01/23 10:30, Deren Wu ha scritto:
> From: Neil Chen <yn.chen@mediatek.com>
> 
> The rx filter, in mt7921 series, may be changed in fw operation. There is
> a racing problem if rx filter controlled by both driver and firmware at
> the same time. To avoid this issue, let mt7921 driver set rx filter by new
> command MCU_CE_CMD_SET_RX_FILTER and allow the firmware controlling it
> only.
> 
> Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Neil Chen <yn.chen@mediatek.com>

For MT7921E:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


