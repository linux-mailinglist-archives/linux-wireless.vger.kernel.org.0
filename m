Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE5366BD5C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 12:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjAPL6M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 06:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjAPL5i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 06:57:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9A91A481
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 03:57:37 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C57F26602AA1;
        Mon, 16 Jan 2023 11:57:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673870256;
        bh=SKhjba5Ic9MZRmS+zXRK7T5CUknOZvwgZFyHEBXNl+s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iXY29UKOyzjeqOYJhs2LHH2sfVFfkEb7VYeD4yqfFDjgizoJwkGBkFL03mK47XZzS
         27HqVblTFZ7tWXOKVH9bRpQ8kMViok1vjHwCjIdg8ICQtqFdlaozRDg0KXDP8aOFN9
         i9dSoXb+XJ5epbNx30J99NPcIoYePGZM+cI8VBxXAqZClzOKnZAhXSraiVh3WrhgSI
         6D5H02oho/zvTuzPIGEhF8kJFT02BuFj+M+pJg3q6nvZcaSFlNmXu53ZPcScell4Ey
         m+FdXKVLniID/bOTky6VBiG3bpwP3EYrNYCgJdkgnfeZ6ZZgZDKfWjDAHaGApL3yqB
         UHXac/jncMAhQ==
Message-ID: <c33a1bb9-3311-02fc-162d-324dda589d79@collabora.com>
Date:   Mon, 16 Jan 2023 12:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] wifi: mt76: add memory barrier to SDIO queue kick
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
References: <2489b17e8249ef8db840edb6168888ff5c887a6b.1673754074.git.deren.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2489b17e8249ef8db840edb6168888ff5c887a6b.1673754074.git.deren.wu@mediatek.com>
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

Il 15/01/23 05:44, Deren Wu ha scritto:
> Ensure the entry has been fully updated before SDIO bus worker access
> it. This patch would fix potential memory risk in both mt7663s and
> mt7921s.
> 
> Fixes: 764dee47e2c1 ("mt76: sdio: move common code in mt76_sdio module")
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


