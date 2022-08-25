Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0125A06FE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 03:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiHYBxV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Aug 2022 21:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiHYBxA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Aug 2022 21:53:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BE8A3D09
        for <linux-wireless@vger.kernel.org>; Wed, 24 Aug 2022 18:46:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e20so22280869wri.13
        for <linux-wireless@vger.kernel.org>; Wed, 24 Aug 2022 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=n1R8DeGj6bdpiarOgdWgrG5OXTclNpSgwRxu1NPfULU=;
        b=JAD33duLbNHFb0vj/T//siZNh/iz6f13LLTBs8QDxMehvzCl+fo2er6b0Zj77yNNm1
         wdgCzB552QHkcfgfYOojlJ0N0giDoMqjE17qp8U2yxDhFOi5+RYBa+5dQDg6VDJb3Gw8
         IRaVT8wM8cpc8NSVls0u1bBou9ZJrPYOeHw1wwiR9oa9JBeHwbUQynRJxZ6N+W5+dqB3
         h7OD540bq9uuaZWtjKPqM4fmcktScQRhADu2UJqJfo/Kgk+hIrKm2D50ekQRD4KjC7DL
         loqKdbOwUVl8UFv65DxnqLfMtFrVvgFfY6v9+A6Q4uitUtvFQR8NOylkGSi7WcRKo64s
         zuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n1R8DeGj6bdpiarOgdWgrG5OXTclNpSgwRxu1NPfULU=;
        b=sF3lj8icNB+HOGxcjU0Y5wmqrnI+Dt3+Uwz0DcPXALHbOAgmjQc7ugu8e9NT+mt5q1
         yBC9rLHVLfuwrHTFsoMnDqDeZGSMRDIlX2XljdMnlOgOy+kFLAhAiKwwhcOZhxisZxBx
         8VfCnzlQlZfD+PiZJuEPnIWHY20uXkqQJWxpMZA86QklQP0Z8l2Cqjdu4gLYHLdF8AXV
         6ruyiwwEPy159tYhj6o17WmnC6rLzEu5m+3+zwPs+HCJukWaNmvOnQJgr9MXuIeF8FMT
         2DwTuUbWVDzdvvO66qd93DSwOE2wM+6A6Z+OKGilBkUxlNUhGOb14Cy6VVj/8CRnIMdI
         lHzw==
X-Gm-Message-State: ACgBeo13ZjbnDzV3s90RDTBHXx+C/s++hrpw0lB3VbiUO1zuIhjYWelC
        UeRub7TTpN0GxuPlM4ZTSKnOH809anOTfap4FEtdF1rgpQ0=
X-Google-Smtp-Source: AA6agR5+eKS6YqhKEk3fxsStR1ranxj0UfI7FJf9yL4nnspPUtrgkAahow3XoLp4r5FN4SQwEFLcZNoiJN2c1/JN+Gw=
X-Received: by 2002:a5d:6949:0:b0:225:4f78:7296 with SMTP id
 r9-20020a5d6949000000b002254f787296mr820726wrw.515.1661391922706; Wed, 24 Aug
 2022 18:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <727eb5ffd3c7c805245e512da150ecf0a7154020.1659452909.git.deren.wu@mediatek.com>
In-Reply-To: <727eb5ffd3c7c805245e512da150ecf0a7154020.1659452909.git.deren.wu@mediatek.com>
From:   sean wang <objelf@gmail.com>
Date:   Wed, 24 Aug 2022 18:45:10 -0700
Message-ID: <CAGp9LzoZkxONid2Kt-ykuQWiY1pTG6NGxho8FeLwMd9MdWd-rA@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7921e: fix crash in chip reset fail
To:     Deren Wu <Deren.Wu@mediatek.com>, Kalle Valo <kvalo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

If the patch looks good to you, could you help apply the patch to
wireless-drivers.git because there are getting more users reporting
the issue with the stable kernel such as [1]. I would like to backport
it earlier once it appears in the Linus tree to solve the indefinite
hang issue.

[1] https://lore.kernel.org/linux-wireless/VE1PR04MB64945C660A81D38F290E4A4BE59F9@VE1PR04MB6494.eurprd04.prod.outlook.com/T/

Sean

On Tue, Aug 2, 2022 at 8:20 AM Deren Wu <Deren.Wu@mediatek.com> wrote:
>
> From: Deren Wu <deren.wu@mediatek.com>
>
> In case of drv own fail in reset, we may need to run mac_reset several
> times. The sequence would trigger system crash as the log below.
>
> Because we do not re-enable/schedule "tx_napi" before disable it again,
> the process would keep waiting for state change in napi_diable(). To
> avoid the problem and keep status synchronize for each run, goto final
> resource handling if drv own failed.
>
> [ 5857.353423] mt7921e 0000:3b:00.0: driver own failed
> [ 5858.433427] mt7921e 0000:3b:00.0: Timeout for driver own
> [ 5859.633430] mt7921e 0000:3b:00.0: driver own failed
> [ 5859.633444] ------------[ cut here ]------------
> [ 5859.633446] WARNING: CPU: 6 at kernel/kthread.c:659 kthread_park+0x11d
> [ 5859.633717] Workqueue: mt76 mt7921_mac_reset_work [mt7921_common]
> [ 5859.633728] RIP: 0010:kthread_park+0x11d/0x150
> [ 5859.633736] RSP: 0018:ffff8881b676fc68 EFLAGS: 00010202
> ......
> [ 5859.633766] Call Trace:
> [ 5859.633768]  <TASK>
> [ 5859.633771]  mt7921e_mac_reset+0x176/0x6f0 [mt7921e]
> [ 5859.633778]  mt7921_mac_reset_work+0x184/0x3a0 [mt7921_common]
> [ 5859.633785]  ? mt7921_mac_set_timing+0x520/0x520 [mt7921_common]
> [ 5859.633794]  ? __kasan_check_read+0x11/0x20
> [ 5859.633802]  process_one_work+0x7ee/0x1320
> [ 5859.633810]  worker_thread+0x53c/0x1240
> [ 5859.633818]  kthread+0x2b8/0x370
> [ 5859.633824]  ? process_one_work+0x1320/0x1320
> [ 5859.633828]  ? kthread_complete_and_exit+0x30/0x30
> [ 5859.633834]  ret_from_fork+0x1f/0x30
> [ 5859.633842]  </TASK>
>
> Fixes: 0efaf31dec57 ("mt76: mt7921: fix MT7921E reset failure")
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> index e1800674089a..576a0149251b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> @@ -261,7 +261,7 @@ int mt7921e_mac_reset(struct mt7921_dev *dev)
>
>         err = mt7921e_driver_own(dev);
>         if (err)
> -               return err;
> +               goto out;
>
>         err = mt7921_run_firmware(dev);
>         if (err)
> --
> 2.18.0
>
