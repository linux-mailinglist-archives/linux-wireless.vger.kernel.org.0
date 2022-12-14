Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2BA64C84C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 12:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiLNLpA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 06:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiLNLoc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 06:44:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582FB25E90
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 03:44:32 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A70C26602BF9;
        Wed, 14 Dec 2022 11:44:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671018271;
        bh=vWMG/i0XCLqz8upe0LKns6EShfTqYSiinpfQ04UAviY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lQgN+zFFBb4/2tMPRKZBKCD6SGN3wCryzOdFOD3LAwf5nu72uJFIrb6NH7O8W0BTi
         D9k8ervheSNBfsHwIcv7ofaGL0rWxfWPJo1BMNwPROKP1Kvo0D8iCW/9y0XZp2mQJ2
         COLwEN41rH3IAPEdwWauwfMnDT1yUQ228W30cXOV45DPbOQyCJTyfgC331FSSJzZZa
         jb9z+I2LMlVfZnGkmnB3CPwG7J2LS59iS/KKsB95goA2Y6aDBdSHgPx//ezIwDLI7T
         8s4I1wD398Czdd6sTbODsGHcQOdaAjQFzWW8Kzq2I/JVanhFADyXkZ/SuR3RapnY7z
         hncZgd/sUB3GA==
Message-ID: <b4a1c27f-44b1-0368-964c-175bc367c795@collabora.com>
Date:   Wed, 14 Dec 2022 12:44:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 0/4] rework thermal protection
Content-Language: en-US
To:     Howard Hsu <howard-yh.hsu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221214022809.32087-1-howard-yh.hsu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221214022809.32087-1-howard-yh.hsu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Il 14/12/22 03:28, Howard Hsu ha scritto:
> Rework thermal protection with the following changes:
> 1. Send thermal fw commands only after mcu init done.
> 2. Firmware expects to disable thermal protect before reconfiguring thermal protect.
> 3. Send fw commands through mt7915_thermal_temp_store() to update firmware
> temperature directly.
> 4. Add error messages for invalid setting.
> 
> Howard Hsu (4):
>    wifi: mt76: mt7915: call mt7915_mcu_set_thermal_throttling() only
>      after init_work
>    wifi: mt76: mt7915: rework mt7915_mcu_set_thermal_throttling
>    wifi: mt76: mt7915: rework mt7915_thermal_temp_store()
>    wifi: mt76: mt7915: add error message in
>      mt7915_thermal_set_cur_throttle_state()
> 
>   .../net/wireless/mediatek/mt76/mt7915/init.c  | 32 +++++++----
>   .../net/wireless/mediatek/mt76/mt7915/main.c  | 11 ++++
>   .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 54 +++++++++++--------
>   .../wireless/mediatek/mt76/mt7915/mt7915.h    |  6 +++
>   4 files changed, 70 insertions(+), 33 deletions(-)
> 


For the entire series:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
