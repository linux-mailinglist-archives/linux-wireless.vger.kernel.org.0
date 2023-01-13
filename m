Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D585669909
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 14:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbjAMNun (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 08:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbjAMNuW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 08:50:22 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6479E736D9
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 05:45:10 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4a263c4ddbaso285318197b3.0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 05:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N9gSuTuOIeRoyvXTslypN3S9Y3n9ZhQxFv0DvHbjXOo=;
        b=XUWtnSngwMqp0UV7+YoSQSR43zlVXU4xZV+OghNp2zfKJqKNZSWd+UoXUp9v9V9uvB
         ffGPgkM6bVmmhPDO8sh0LaGP514Je2D3rR9qM6QE9iWzkKJY7KKgxtXraU1tkwAy9s0Q
         SiybHuuvqpsSllMrAUzECDUxWETqLcic3sRQ09XfY/HkTdOTJFnzTV/T4IW9cG/r3Clu
         dWjoFsMVpqnqojQgsNhZfLDf38ymkZZ8mdyq+4YHqzoreBb3gQDswu46hWUfdIrqNG3H
         TathLmKvrjhS7oOIJ1AwWwFFDhO50clncGTZuQpI880Km2p4YABs/aZZY2fgvA3/EgUM
         znzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9gSuTuOIeRoyvXTslypN3S9Y3n9ZhQxFv0DvHbjXOo=;
        b=rJXvtkWADmESIj14ddQIWft6aJ0HM50xDSMajnlt/Gidiyqdm6PhR+8mnW1oExhNtG
         6vrq/hoE+moMOBX5tR/vH6hLmbKbb74wt7EO99ciAyNbn6kan6p1AQuvvmPp9JEkYM1D
         pnYSKEh0L0eJ0hiHu//KfGxgEJEeWHhwEtjVn7lLT6cWFYnEeiMuJCTF68Ihya0wMk/A
         UNMjIvea82V1VNcovfNgYX3dB2rMYfU68svbzO2CHefeHD/d0u+NNKNqvVbukmzT6K3N
         NgAElfQvez4pg0lhGA7QJTFj6vKMPil/pD57RM22eV0eghqILlewDIzsHkYrSuDn0Kkd
         j2dg==
X-Gm-Message-State: AFqh2kqo/FDWWvwEfCTi4qsnXXLDDmkPQ9O9K+umZM2Zn8Y28xYeoVo7
        yrvTJzdg2xd1mO3Y9UFPSSKWjLJK+8nUFMgTE1kHqA==
X-Google-Smtp-Source: AMrXdXtJH9fhqngsU/znGp5Pce6WNzdeRxElK/cgmqsxhsBn2wn0OeFj/fgiLxP0V8CiM2Wny3plPb1rZ6Kc6GkYCFs=
X-Received: by 2002:a05:690c:313:b0:37e:6806:a5f9 with SMTP id
 bg19-20020a05690c031300b0037e6806a5f9mr3612977ywb.47.1673617509336; Fri, 13
 Jan 2023 05:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20230113133503.58336-1-sensor1010@163.com>
In-Reply-To: <20230113133503.58336-1-sensor1010@163.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 13 Jan 2023 14:44:58 +0100
Message-ID: <CANn89iKDXQ_nvnXBp5Q99P67AW-jFTNkpEmYdESDWitf0Nt4vw@mail.gmail.com>
Subject: Re: [PATCH v1] wireless/at76c50x-usb.c : Use devm_kzalloc replaces kmalloc
To:     Lizhe <sensor1010@163.com>
Cc:     kvalo@kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, johannes.berg@intel.com,
        alexander@wetzel-home.de, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jan 13, 2023 at 2:35 PM Lizhe <sensor1010@163.com> wrote:
>
> use devm_kzalloc replaces kamlloc
>
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/net/wireless/atmel/at76c50x-usb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
> index 009bca34ece3..ebd8ef525557 100644
> --- a/drivers/net/wireless/atmel/at76c50x-usb.c
> +++ b/drivers/net/wireless/atmel/at76c50x-usb.c
> @@ -2444,7 +2444,7 @@ static int at76_probe(struct usb_interface *interface,
>
>         udev = usb_get_dev(interface_to_usbdev(interface));
>
> -       fwv = kmalloc(sizeof(*fwv), GFP_KERNEL);
> +       fwv = devm_kzalloc(sizeof(*fwv), GFP_KERNEL);

Have you compiled this patch ?

>         if (!fwv) {
>                 ret = -ENOMEM;
>                 goto exit;
> @@ -2535,7 +2535,6 @@ static int at76_probe(struct usb_interface *interface,
>                 at76_delete_device(priv);
>
>  exit:
> -       kfree(fwv);
>         if (ret < 0)
>                 usb_put_dev(udev);
>         return ret;
> --
> 2.17.1
>
