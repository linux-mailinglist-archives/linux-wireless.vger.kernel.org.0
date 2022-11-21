Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A779D63278D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 16:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiKUPOB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 10:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiKUPNh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 10:13:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D00A639D
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 07:07:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B236612AC
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 15:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C22C433C1;
        Mon, 21 Nov 2022 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669043268;
        bh=XCK2rE8lqFjARxnE3wTynZRLe02wfehU9M5s+cBsfng=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=msGnioqL0kQMTGlFbKAWlEEgigrzzJDswh7OLTbQMDV28I5gRXDo1Vw5HSk97S32L
         ciPWJX2GJa1sR9eUiXhpiOidEW8AI2/JS09T9iF788+KuYamOmPDVDSkLR+cDHB4hT
         uWT3YDSJLV4RC3wbcUZXZIH8Yq32QAeUxFyAbrn+NeDl1kW3ZbN9OaVEePcu17DimV
         kJwcFqRmUi8AKOOXAm7pDAKEj5zAn4BJwOG+rGrJlhC5+Ewv27CrWBFMQhDWdcjHSm
         ID/K6wVRHPhCAGx13SPnHN+bzO34QHmURkaCwzWnhlAiwhVrkWM/D/iC2JTsPk4vP3
         lofEO/GCFwvYw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Howard Hsu <howard-yh.hsu@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>
Subject: Re: [PATCH v2 9/9] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices
References: <20221110093525.29649-1-shayne.chen@mediatek.com>
        <20221110093525.29649-10-shayne.chen@mediatek.com>
Date:   Mon, 21 Nov 2022 17:07:40 +0200
In-Reply-To: <20221110093525.29649-10-shayne.chen@mediatek.com> (Shayne Chen's
        message of "Thu, 10 Nov 2022 17:35:25 +0800")
Message-ID: <87ilj8pcqr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shayne Chen <shayne.chen@mediatek.com> writes:

> Add MediaTek new mac80211 driver mt7996 for Wi-Fi 7 (802.11be) devices.
> The driver first supports Filogic 680 PCI device, which is a Wi-Fi 7
> chipset supporting concurrent tri-band operation at 6 GHz, 5 GHz, and
> 2.4 GHz with 4x4 antennas on each band.
>
> Currently, mt7996 only supports tri-band HE or older mode.
> EHT mode and more variants of Filogic 680 support will be introduced
> in further patches.
>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> Co-developed-by: Howard Hsu <howard-yh.hsu@mediatek.com>
> Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
> Co-developed-by: MeiChia Chiu <meichia.chiu@mediatek.com>
> Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
> Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Co-developed-by: Money Wang <Money.Wang@mediatek.com>
> Signed-off-by: Money Wang <Money.Wang@mediatek.com>
> Co-developed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
>  drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
>  .../net/wireless/mediatek/mt76/mt7996/Kconfig |   12 +
>  .../wireless/mediatek/mt76/mt7996/Makefile    |    6 +
>  .../wireless/mediatek/mt76/mt7996/debugfs.c   |  851 ++++
>  .../net/wireless/mediatek/mt76/mt7996/dma.c   |  360 ++
>  .../wireless/mediatek/mt76/mt7996/eeprom.c    |  229 ++
>  .../wireless/mediatek/mt76/mt7996/eeprom.h    |   75 +
>  .../net/wireless/mediatek/mt76/mt7996/init.c  |  816 ++++
>  .../net/wireless/mediatek/mt76/mt7996/mac.c   | 2468 ++++++++++++
>  .../net/wireless/mediatek/mt76/mt7996/mac.h   |  398 ++
>  .../net/wireless/mediatek/mt76/mt7996/main.c  | 1325 +++++++
>  .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 3428 +++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  662 ++++
>  .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  385 ++
>  .../wireless/mediatek/mt76/mt7996/mt7996.h    |  516 +++
>  .../net/wireless/mediatek/mt76/mt7996/pci.c   |  222 ++
>  .../net/wireless/mediatek/mt76/mt7996/regs.h  |  533 +++
>  18 files changed, 12288 insertions(+)

This patch is too big, please split it. One patch per file is a good
rule of thumb.

I did see some suspicious static variables in pci.c, but otherwise I
basically skipped everything.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
