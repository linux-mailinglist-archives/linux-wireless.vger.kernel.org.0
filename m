Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE15089F3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 16:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379212AbiDTODi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 10:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354209AbiDTODh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 10:03:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FEF1A392;
        Wed, 20 Apr 2022 07:00:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y10so3723703ejw.8;
        Wed, 20 Apr 2022 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fUhflkjuCQ88rw7Co6ugfAm65XGN6gdXNEWk+vq4zPg=;
        b=mTQ16iAF+djeeNR9aPcILOYKECu/ZbfrGwtnu+XynE7Cbibu3eYpGHSkx0VsKCzYaH
         0vYMp4nkY7qUJdvf7jEqbOrK82j/wxNovOIraHMJGjrSzwXHGuDGYjdszN3R9KWy7hHi
         tLjBmaB5emRntrDbTzVb1D8TRy4/lwo8AMBaRdQCCNfiFsFhtL496un7SXtv1bwq388Q
         diNH+Vi0cy4dgxWKADNIKM9tsPXTqI+f9ezwaG6fGyyoPpGsAalTl/PjuXprMswpykTd
         rzG7NjM25EnzH9IKqAHyXahVzan18fdTBRU0jUJ60dy8+cMV1JkdrThgPdjmTNLwvFUo
         OUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fUhflkjuCQ88rw7Co6ugfAm65XGN6gdXNEWk+vq4zPg=;
        b=TwDm1iDn+EsreAce2wwMAvoMT9l+KYK56Jnk91Ti5fJptz6auhph0X6CN6E4Lg/vVx
         EqLpnWt7gJPBQzoX6j5MLR48lJZ0AHuZW/Fk4XbnypvKGypMot7PA0jNlORwaZ5QR6jO
         Jd8GjvtNgyUN4FXhZIEXL/wcsCY1K3d6ArJbFAGkYpK7yl6ocfrG6j1tf8zi6zkJgNoo
         /lOknjU7A5EKhJasqtK4Rk4TogsiQKsdVIVr7tsSQ59dTeZSiu/omreSY7xozTqEH0d2
         LORDNGBOCMqkMKmqdcjtaGUExsQAlBSjfq1hQS3D8bNCs3WLdwZOvkVCdiGQ6EseGG1E
         08kQ==
X-Gm-Message-State: AOAM53112uAAgXqw2l/2tNvTSH86EXkvgCsULPlyu6kN49VSuj6Y7UJ5
        Pb5qBKH15BLayJG45iJ8ohxrL06/GSjotEGkJReoKn/Q0gM=
X-Google-Smtp-Source: ABdhPJwven6/+OjHqo8zevNFU9kEoxmbW/0E8ncV3gakvluubft6qctAClBbe5/Rkcv9DDjAPNFmSfX4Ao9bTAw3O7w=
X-Received: by 2002:a17:907:e88:b0:6ef:bce9:ff6a with SMTP id
 ho8-20020a1709070e8800b006efbce9ff6amr12474874ejc.275.1650463249997; Wed, 20
 Apr 2022 07:00:49 -0700 (PDT)
MIME-Version: 1.0
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Wed, 20 Apr 2022 15:57:24 +0200
Message-ID: <CAGm1_ktEim1vGOf5i=H_sqrPvg=dT50790YYwXgYKgAut-a=ng@mail.gmail.com>
Subject: wl18xx: NVS file handling
To:     Linux-OMAP <linux-omap@vger.kernel.org>
Cc:     linux-wireless@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        sebastian.reichel@collabora.co.uk
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

Hi all,

using the 5.18.x kernel, I get the following warning:

wlcore: WARNING Detected unconfigured mac address in nvs, derive from
fuse instead.
wlcore: WARNING This default nvs file can be removed from the file system

removing the /lib/firmware/ti-connectivity/wl127x-nvs.bin file, I get
this warning:

wl18xx_driver wl18xx.0.auto: Direct firmware load for
ti-connectivity/wl1271-nvs.bin failed with error -2

What's the best way to get rid of these warnings when I don't want to
handle WLAN's MAC address via the wl127x-nvs.bin?

According to this discussion [1], NVS file is the last resort for
handling the MAC address.

[1] https://patchwork.kernel.org/project/linux-wireless/patch/8665E2433BC68541A24DFFCA87B70F5B363E1A3D@DFRE01.ent.ti.com/

Regards,
Yegor
