Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6305A16B0
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 18:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiHYQ3D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiHYQ3C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 12:29:02 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68349B81C2
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 09:29:01 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r1-20020a056830418100b0063938f634feso7053886otu.8
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KbW68oK0vEJOOvYKrMBQsLV+/wVg/GAuIcjSOx+C1QQ=;
        b=PAN4YehbLXnzjgjLHyoOMKEJdEjRG312fcY3pGyMuaqx6jgylpzPozNX2B6Up5vWC+
         PxGdN7g4ivUPGBJtJ+423hxjq3H4etnASfaM9vO2aoc/STsjXhRd8kCUX66iKxjfvdrb
         MeLwzc3d0Nu1p2dhH5XZuKUWB8pkglLmZfarxITOsln5nQpxJ01X/sFhefFIG0IHIKlF
         gmrqXeYtRXB2QYUMxfVqYZIpZOU+eC3Q+xULPMmhdWCVdnoVVdZiqexnKUymz3vZuSh0
         ES1U8fpxIKU20srh74lOuhc6O2NYlfkQUFTdMp/FaLeyoz89AHVpEj3SuScyh1G5Qfb8
         n0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KbW68oK0vEJOOvYKrMBQsLV+/wVg/GAuIcjSOx+C1QQ=;
        b=HMG8PD89HAQO82DhgCBsKeGVgIkTcVexDsKFLHqQaM92pDx5GIjNcV8uf7W6+j5GjV
         rrcQtMj9WbGZuNoJKCEStn1JUiUJ4FQT5E39eyQJAW3LoS3ilRrfBND+L6P1hhuMsR/b
         0Osa3JbvBhh+pL8GMSZvb6k8vG7DCrH/TCZ5B9gCHwzjDKzwzdX2drKIOkSHInCByV66
         6FxKli+OwR7ZElPdKTt7QraXu99agUTe+tSoxQR+cul1wmuTQvM7gjpEPte6qcFJyPfG
         nVrL/ko7WeeZpFsHvTFk1JucAFFoeaHu7GEAovLvHyfunNN6YE9bHtpoZKk10pbj4fO5
         QDFw==
X-Gm-Message-State: ACgBeo3oQK1HZOCVeV5LGxW9OvHny31kBSpDgt2Otpu8vt/bQNKLWzbQ
        E3TBtTgSBwObg/XXTpf5/dCAJvAoZRKYTzdKda4=
X-Google-Smtp-Source: AA6agR4wdK+2p/7LuEjYrMYYbke/VZD/ilefCt1+hshmGnG1SxEGO28cONhGuq6K5HTR3JHHxkKgg+EC0+2WiDPtACA=
X-Received: by 2002:a9d:61d2:0:b0:639:31ca:87fe with SMTP id
 h18-20020a9d61d2000000b0063931ca87femr1704199otk.22.1661444940656; Thu, 25
 Aug 2022 09:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <Ywee5H+m/4Y5lXq4@kili>
In-Reply-To: <Ywee5H+m/4Y5lXq4@kili>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 25 Aug 2022 09:28:49 -0700
Message-ID: <CAF6AEGsEtY50Kwt9b9APPncyC_yNWyfhuUN1bi7rzsN4-4EcxQ@mail.gmail.com>
Subject: Re: [bug report] wcn36xx: check dma_mapping_error()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
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

On Thu, Aug 25, 2022 at 9:10 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Rob Clark,
>
> The patch 4165cf7ba52a: "wcn36xx: check dma_mapping_error()" from Jul
> 3, 2017, leads to the following Smatch static checker warning:
>
>     drivers/net/wireless/ath/wcn36xx/dxe.c:305 wcn36xx_dxe_fill_skb()
>     warn: 'dxe->dst_addr_l' is not a DMA mapping error
>
>     drivers/net/wireless/ath/wcn36xx/dxe.c:805 wcn36xx_dxe_tx_frame()
>     warn: 'desc_skb->src_addr_l' is not a DMA mapping error
>
> drivers/net/wireless/ath/wcn36xx/dxe.c
>     290 static int wcn36xx_dxe_fill_skb(struct device *dev,
>     291                                 struct wcn36xx_dxe_ctl *ctl,
>     292                                 gfp_t gfp)
>     293 {
>     294         struct wcn36xx_dxe_desc *dxe = ctl->desc;
>     295         struct sk_buff *skb;
>     296
>     297         skb = alloc_skb(WCN36XX_PKT_SIZE, gfp);
>     298         if (skb == NULL)
>     299                 return -ENOMEM;
>     300
>     301         dxe->dst_addr_l = dma_map_single(dev,
>     302                                          skb_tail_pointer(skb),
>     303                                          WCN36XX_PKT_SIZE,
>     304                                          DMA_FROM_DEVICE);
> --> 305         if (dma_mapping_error(dev, dxe->dst_addr_l)) {
>
> I'm so surprised that adding this check fixed a bug.  There is an
> addr_l and addr_h (presumably for the low and high bits of the address?)
> The ->dst_addr_h is never used.
>
> A 32bit dst_addr_l can't be equal to DMA_MAPPING_ERROR unless it's a 32
> bit system-ish.

judging by the date, it was probably on a 32b system ;-)

that said, it doesn't seem like that code even supports systems w/ 64b dma addr

BR,
-R

>
>     306                 dev_err(dev, "unable to map skb\n");
>     307                 kfree_skb(skb);
>     308                 return -ENOMEM;
>     309         }
>     310         ctl->skb = skb;
>     311
>     312         return 0;
>     313 }
>
> regards,
> dan carpenter
