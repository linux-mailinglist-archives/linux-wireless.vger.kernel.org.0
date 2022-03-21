Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A094E2F46
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 18:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350142AbiCURol (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 13:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350134AbiCURog (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 13:44:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B9656D
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 10:43:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b15so18781058edn.4
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tqo1ZP4lXcNzWc8SJoDiTjhOIQN2DKVmWm7P1MeeqBA=;
        b=Ifdp/BvjZM0g68Shv0xrgipsnAP8GKBIwiCKC8P/4Iy3ASaBtWUa+b9aGGnK/Optl6
         sdnAr5GqR5lBzMdVXqpzMghUIv8NmKaO7CR020eiHFLDFkNl/p5QK+g9TMxJlTcmYtiP
         N8flJdzK+57ZW7twyA5xJf9OnG6CJeLzdGFlmEe2wgrYCi0g9pyboTu1YBn6r6DZpSb0
         GOuxRT4pUP9Uc9m/NcqjYs46hpzavNVZlnIT1bn5lQIgJkOjeccwJzR9zlB/70DJ4vuc
         Yni5aZsI8LrcBliZcEqw8CsSBh1vOiZEp0agYibTZ8NpP+Q62LWNikQthO13b9c52igF
         /7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tqo1ZP4lXcNzWc8SJoDiTjhOIQN2DKVmWm7P1MeeqBA=;
        b=G0pwiPLXm4ZwdTo51XmMKi+Nhv/eExrXxU+HvwCxbsgODKKOknoTjJEH1F/M7msTIO
         qZxyRoE+M315dL7pd3sftbHPOjheLisgk57Y1OIiVN+vh5dFv7NRGmJGUcLjGQihOjPv
         tW/yqXDCxUpWXtQSWMBkOZU3NFo3T4Bxj+ezJwHZk1VaOAyv3jZ+2JDHUmYgGBZzkYwu
         hq68rQEbkV1y+UdRHPaUl26AKzKU7lyJXAVpXSQYKm3lfa+CQStP7zEM1RK9HdFJo5N4
         TvmiXS+ldIKX0FU8fvUaqmH3EIGr5ZICT5TED43WcnJ/xVdTnumnMplw7TPMRGVi/I+5
         8Hiw==
X-Gm-Message-State: AOAM530ExhbgCkAOL8qDsAWkBaKF/C3bXEe0Y0LQkzdXnYe5h2hh6FrY
        P9/12jlqvHdJ5mg11r44Dnm8hbFRBvsl65l1QpmZp76oBBE=
X-Google-Smtp-Source: ABdhPJzrliiK7gje5VT4G/HWj7x35n8WgsNjYK2Yef+KNCzeFmId68IYZh2vdySwxpJdPHp2Afn9Bg2e4kAlZ3wKoz8=
X-Received: by 2002:a05:6402:1e90:b0:419:4cdc:8b05 with SMTP id
 f16-20020a0564021e9000b004194cdc8b05mr3222698edf.211.1647884589239; Mon, 21
 Mar 2022 10:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <2127068.tFZMq15b3B@t460-skr>
In-Reply-To: <2127068.tFZMq15b3B@t460-skr>
From:   Christian Lamparter <chunkeey@gmail.com>
Date:   Mon, 21 Mar 2022 18:42:57 +0100
Message-ID: <CAAd0S9A-NpOcDySVMRZf_Avb7iTkodZCKaTdy_32V7MevtBkPA@mail.gmail.com>
Subject: Re: rtw89: unstable connection
To:     Stefan K <shadow_7@gmx.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
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

Hi,

On Mon, Mar 21, 2022 at 5:13 PM Stefan K <shadow_7@gmx.net> wrote:
>
> Hello,
>
> I got an new Laptop (Lenovo T14 Gen2 AMD) and it has RTL8852AE chip, it can connect to WiFi, but its very slow and unstable:
> --- 8.8.8.8 ping statistics ---
> 100 packets transmitted, 60 received, 60% packet loss, time 99514ms
> rtt min/avg/max/mdev = 578.297/4515.244/10612.149/2763.037 ms, pipe 11
>
> I'm running on Debian bullseye with backport Kernel Linux 5.16.0-0.bpo.3-amd64
>

What rtw89 firmware version do you use? I found that the current
linux-firmware.git firmware v0.13.36.0,
together with the latest patches (i.e.: "rtw89: add tx_wake notify for
low ps mode" and later) improved
the situation... by a lot!

Do you know if your debian is using Larry's rtw89 repo for its rtw89 driver,
or are they simply sticking with that is in 5.16? If they just use the
5.16 stock, you should
give wireless-testing.git a try.

(Note: Your router/AP might also play a role here. In my case, the
connection was always "OK"
with unifi ac pro. But not with a Rudgers Advanced Wifi modem.)

(I had a Lenovo P14 Gen2 AMD and Ubuntu 21.10 for testing.)

Cheers,
Christian
