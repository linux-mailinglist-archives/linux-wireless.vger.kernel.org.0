Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18F0696049
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 11:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjBNKGs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 05:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjBNKGj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 05:06:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A8BE3B3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 02:06:12 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6B793660216A;
        Tue, 14 Feb 2023 10:06:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676369171;
        bh=s5SZVvdZQxR5mDQIx9uUkDGglHwSbD6+4806r+qB464=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J4EQ4j/amiH3pmf/FxzX9tJcPvLnxMW72yTOmIwKMLsYpqZ/sxQWTvbwZoJfKxVql
         dJeD1tXuDXJObc3SKSxxO4Hjb+Gfv8ls/Zh0dOMWG7ElB0iiWboM2TG9N+ExsawBJR
         utatCMP1wzxrXwNC7vAs0E3itCqJd3qG5Ygy9SNkSWC0WyVZbl/F1KA9CID786pMb1
         HAuD2k3YheYLPedZ/hKCO3KJ375cuNovHeKVMcosGRu1ioqUCMu9Ahx2R0UGTNJR1Z
         AOeJ5vtNU2DFk0pRoxeLDUTsKy9fMPb00ApXsRUMUUBUfgSnHBxCnX6PYlxuutQ1S0
         x34uLGq7mR7jQ==
Message-ID: <ba391995-014d-3308-53ad-81bbf0fee350@collabora.com>
Date:   Tue, 14 Feb 2023 11:06:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2] wifi: mt76: mt7921: fix PCI DMA hang after reboot
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
References: <9f4a25c54dc68c941fbbd864e56e1b78868a5a9a.1676342819.git.deren.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <9f4a25c54dc68c941fbbd864e56e1b78868a5a9a.1676342819.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Il 14/02/23 03:49, Deren Wu ha scritto:
> mt7921 just stop some workers and clean up chip status before reboot.
> In stress test, there are working activities still running at the period
> of .shutdown callback and that would cause some hosts cannot recover
> DMA after reboot. To avoid the floating state in reboot, we use
> mt7921_pci_remove() to fully deinit all resources.
> 
> Fixes: f23a0cea8bd6 ("wifi: mt76: mt7921e: add pci .shutdown() support")
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



