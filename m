Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5442963C345
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 16:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiK2PBJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 10:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiK2PBH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 10:01:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C696DB5C
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 07:01:02 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3CB826602B14;
        Tue, 29 Nov 2022 15:01:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669734061;
        bh=tlzoqvO3u8C44kx2Y9u+ybzWD6r+wYvLQQmDBQC7WMI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YOX+dq1Vl6bi3pHyQsviCt6TMoG9ZK6WHrh8uTK/RTYzhYsASZvUIvjLIN157z6uR
         FZN3W4kyMFX/Lcs4VFezqODebQqEWTkpjzr0l70nsjAy6S8FhIze4jqctPSpyWAosZ
         k9Q0TJ7l6nAnD+5b5hEzn8f64rX3mSQczavXj8V/aCu+rP1qbsHPpv+D6Xb9UnACJ9
         8RG/fB7mFakIcJlAQPsW4BN6QjoQEc6DX90C3WZrp/714KSHvDcZlOhC1pGgi0ZfIQ
         QESVm7egzI1jfnCsmeKz8vmyP3RHMsEbGDmP6W022ef6mXgUGfSP0EKkCZbKSVgySl
         F3cM30a9B88BA==
Message-ID: <1e8185a3-0a40-a637-7e49-79b00d95e576@collabora.com>
Date:   Tue, 29 Nov 2022 16:00:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] wifi: mt76: introduce reboot notifier support
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
References: <d44631bcc74cce3f32a72f616a99d1bd2837690f.1669711916.git.deren.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <d44631bcc74cce3f32a72f616a99d1bd2837690f.1669711916.git.deren.wu@mediatek.com>
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

Il 29/11/22 10:16, Deren Wu ha scritto:
> Some combinations of hosts cannnot detect wifi chip after reboot. The
> interoperability issue is caused by the status mismatch between host
> and chip fw. In such cases, the driver should stop chip activities
> and reset chip to default state before reboot.
> 
> This is a preliminary patch to add mt7921e reboot notifier support.
> 
> Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>

If you want to perform shutdown actions when rebooting the machine, this
means that you want to perform actions when shutting down the kernel....

...so, have you tried to perform such actions in the .shutdown() callback
of your struct pci_driver? :-)

Regards,
Angelo

> ---
>   drivers/net/wireless/mediatek/mt76/mac80211.c | 21 +++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt76.h     |  2 ++
>   2 files changed, 23 insertions(+)
> 

