Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410FF647995
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 00:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLHXPE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 18:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiLHXPD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 18:15:03 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DB179C09
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 15:15:02 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id pp21so1232564qvb.5
        for <linux-wireless@vger.kernel.org>; Thu, 08 Dec 2022 15:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AbgxOMwpjewhzmMSPJ3VcRbgZTT1KK9NxNUKJUyOYKM=;
        b=OiP/aROy/idYv+3qg51kzjb4Rq+HT40ZCTJbUOWaFG2W/WrdTxLAZlrVzWkY5gC928
         qrJB6HMf8GTbqFIMnMGSvI9MM54HCjh1dFTaTB2iTbjFX/CvMBi5//nc8ssOtkAPynMX
         nIlY9BxFYsuarZRWkOQterBiJ44ZonAg8vE+2H4hEA9j/IIKKScXctfYNPOsnEk899NX
         OSaXC9C/iLwDppdzxDxFWbjscwz/6ugERxs5Efo4b4vMO0wbYCAHrEKjKa+M5rZvruXc
         QGUIIQ0HWeh0+nJUOl1bKhyUbdb5gFNH9CXzj+gaObf7Wstu+MOggAE2WdBnOUm9XNQu
         I6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbgxOMwpjewhzmMSPJ3VcRbgZTT1KK9NxNUKJUyOYKM=;
        b=HdnQKEY9uKj9aHPjt2VLD79iPmdoOjhlWxDNLHos4LxahQWhGOpAOGvMbN74XZEKzN
         ngxGuLnS4DTYuwaI0xlDiAIWT8HWee89nCBi1a3z0h7if40seTGuEgFtrgx6TyTt6hzb
         W1jyN/lmpivnA3Rqq/nHl4Dzeyc/eBGQGvenSy9yMP60AzpSGAxVUC1+beB9cdAQRIrs
         OhWoqwBBVbV5RyXPCF3DA3DhFifveOSC3CoucCjg0ZJgz500vin3RkOPr+FC8fv8q0Yi
         JnYqIQG/Xe3XCqUG33CLPCIROxWM0nsJwmQOg/QOQ8tUu2zh//OTG+LDz+T3UZRxGSOK
         tltQ==
X-Gm-Message-State: ANoB5pmO1x/qXMWzMQ4SfHEriJRMLWXeGSqMRMv0Y4Su786oyRWho49n
        5vaj3TWH+9ZkmRGoqPboGbtWC8M3KriAvW8VvQw=
X-Google-Smtp-Source: AA0mqf40Ch8Q8KacZrCKsvpVF7J+Jye6OvmlIgvk0BSMsMkN9rtdQpfKE89qMxkpPTwdGh9SVIlTeKWRhpEqXEoAenE=
X-Received: by 2002:a05:6214:519:b0:4c7:6210:8d8b with SMTP id
 px25-20020a056214051900b004c762108d8bmr16684366qvb.119.1670541301732; Thu, 08
 Dec 2022 15:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20221208160137.3855-1-shayne.chen@mediatek.com>
In-Reply-To: <20221208160137.3855-1-shayne.chen@mediatek.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Fri, 9 Dec 2022 10:14:50 +1100
Message-ID: <CAGRGNgWvT7e5DkTO96PaMazDae-wTe3ctBx8-n6EGhYxFPwCHQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7915: add chip id condition in mt7915_check_eeprom()
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Shayne,

On Fri, Dec 9, 2022 at 3:06 AM Shayne Chen <shayne.chen@mediatek.com> wrote:
>
> When flash mode is enabled, and the eeprom data in the flash is not for
> the current chipset, it'll still be checked valid, and the default
> eeprom bin won't be loaded.
> (e.g., mt7915 NIC inserted with mt7916 eeprom data in the flash.)
>
> Fix this kind of case by adding chip id into consideration in
> mt7915_check_eeprom().
>
> Reported-by: Cheng-Ji Li <cheng-ji.li@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> index 59069fb86414..e21aa03c85b1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> @@ -33,14 +33,12 @@ static int mt7915_check_eeprom(struct mt7915_dev *dev)
>         u8 *eeprom = dev->mt76.eeprom.data;
>         u16 val = get_unaligned_le16(eeprom);
>
> -       switch (val) {
> -       case 0x7915:
> -       case 0x7916:
> -       case 0x7986:
> +       if ((is_mt7915(&dev->mt76) && val == 0x7915) ||
> +           (is_mt7916(&dev->mt76) && val == 0x7916) ||
> +           (is_mt7986(&dev->mt76) && val == 0x7986))
>                 return 0;
> -       default:
> -               return -EINVAL;
> -       }
> +
> +       return -EINVAL;

If this returned a bool, you could write this as:

switch (val) {
        case 0x7915:
                return is_mt7915(&dev->mt76);
}

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
