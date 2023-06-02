Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03F271F7F1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 03:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjFBBdP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 21:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjFBBdO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 21:33:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83F0133
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 18:33:12 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d4e4598f0so1792471b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 01 Jun 2023 18:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685669592; x=1688261592;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cyfmntu6Uu0BGY09Vhn1+0AR0FfT3FPp6lkotUkhyNE=;
        b=pSUlpfSGzJWswqAMqAWXIxq+LAktVRgR4h/bNrbNZskk0LJlFd7gFBJcocfXvliVg7
         a6cpCsqwkeMMmG3UCjtxD8xiRCF3coXlGFLVkcQwA0jFp48dEN0xWlqIUV3APsg0/QK5
         QuAr/AlKgA2O+uAoXLKm6J5BvBCQy7tVRmef7jxXwWYlFDdZuH8Ex8yljbr8GJ0zwLjW
         iO6ADkbwR6OpyokZ3jFLR3e+XEwj+wQdbd/1TUutvSAa9q71IwwxJeYAtHUPyiBDj0Bc
         ZVuiCBfbFrdTtEKgALOrWVY+XCLX7Ux6WHRXEuDV8gEbk8RnVAhqkjDSA/uvwRvrcH6p
         DpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685669592; x=1688261592;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cyfmntu6Uu0BGY09Vhn1+0AR0FfT3FPp6lkotUkhyNE=;
        b=VwiiidNZplCpRoSsG1AHSj4ViIIa6ZlY6u9ljyrhaTjhFEVztht3N5xfFL4z3UMoMZ
         lDDKVYx8Y/Kfu6Njb8fddYiD1Uky9Z0PilY3biV7o/nye7b3cCbpNDoz0MSed9eAOVW5
         KM97ht6U+HMa0z+JVPcq2udaEE92uZpKRN2HZacCaliYMIFAN1yUPAqIy+D6aJCIF9Ap
         CsFsb/UKfJzJAt/yXhfzzVoiCAHRC0/7g1a2vZfnYsfjW8qHWiM1/m58eKWE09lxvMGq
         7MmfMEWaff4l9viTtphH7I+gmrelTdP4YND5DCl7NN5o0pQttOY9oTFxjjDEmCaAOgvE
         qt0Q==
X-Gm-Message-State: AC+VfDyz2Hsay5HDAZ1V9jz4kMc1KzbO+TM824AkoAHQ1NP00hxQfXfj
        LINIH/1G3VonO8KBePqZa2mRtT5wBxbNlfnQKUR4kWr7qB9cPQ==
X-Google-Smtp-Source: ACHHUZ4BT0u8E/TxjLhBAaocKzqVzBW6QusgexdwJnDG4Mm80CpBYaWQBhpzEL9NWQ5hNTY8TvWKxbm2KrleVMjWPwM=
X-Received: by 2002:a05:6a20:9c88:b0:10b:960:c4a1 with SMTP id
 mj8-20020a056a209c8800b0010b0960c4a1mr11070400pzb.57.1685669591947; Thu, 01
 Jun 2023 18:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <CALKa4bRo2DxK56pxDhqMJtr8C08OVsJ7KpVFyaELnttZaxgguQ@mail.gmail.com>
In-Reply-To: <CALKa4bRo2DxK56pxDhqMJtr8C08OVsJ7KpVFyaELnttZaxgguQ@mail.gmail.com>
From:   Utkarsh Verma <utkarsh.naveen@gmail.com>
Date:   Fri, 2 Jun 2023 07:03:00 +0530
Message-ID: <CALKa4bQ6quTd6PoHCt9wQ-x6LznzmSz3Vbw1aOTc21USgdnctQ@mail.gmail.com>
Subject: Re: RTL8822BE not working after suspend
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Additionally, here is the dmesg log after resuming the laptop:

Jun 02 06:25:06.698947 metia kernel: rtw_8822be 0000:04:00.0: failed
to poll offset=3D0x5 mask=3D0x2 value=3D0x0
Jun 02 06:25:06.699373 metia kernel: rtw_8822be 0000:04:00.0: mac
power on failed
Jun 02 06:25:06.699751 metia kernel: rtw_8822be 0000:04:00.0: failed
to power on mac
Jun 02 06:25:08.698770 metia kernel: rtw_8822be 0000:04:00.0: failed
to poll offset=3D0x5 mask=3D0x2 value=3D0x0
Jun 02 06:25:08.699414 metia kernel: rtw_8822be 0000:04:00.0: mac
power on failed
Jun 02 06:25:08.699800 metia kernel: rtw_8822be 0000:04:00.0: failed
to power on mac
Jun 02 06:25:20.688984 metia kernel: rtw_8822be 0000:04:00.0: failed
to poll offset=3D0x5 mask=3D0x2 value=3D0x0
Jun 02 06:25:20.689553 metia kernel: rtw_8822be 0000:04:00.0: mac
power on failed
Jun 02 06:25:20.689968 metia kernel: rtw_8822be 0000:04:00.0: failed
to power on mac
Jun 02 06:25:22.692089 metia kernel: rtw_8822be 0000:04:00.0: failed
to poll offset=3D0x5 mask=3D0x2 value=3D0x0
Jun 02 06:25:22.692584 metia kernel: rtw_8822be 0000:04:00.0: mac
power on failed
Jun 02 06:25:22.693016 metia kernel: rtw_8822be 0000:04:00.0: failed
to power on mac
Jun 02 06:25:24.958755 metia kernel: rtw_8822be 0000:04:00.0: failed
to poll offset=3D0x5 mask=3D0x2 value=3D0x0
Jun 02 06:25:24.959390 metia kernel: rtw_8822be 0000:04:00.0: mac
power on failed
Jun 02 06:25:24.959814 metia kernel: rtw_8822be 0000:04:00.0: failed
to power on mac

On Fri, Jun 2, 2023 at 6:59=E2=80=AFAM Utkarsh Verma <utkarsh.naveen@gmail.=
com> wrote:
>
> Hi everyone,
>
> This is my first bug report on the mailing list, so please let me know
> if I mess anything up.
>
> I have an ASUS TUF FX505DT which has the RTL8822BE WiFi card. It works
> fine normally without any issues. However, once I suspend my
> laptop(closing the lid) for a considerable amount of time (> ~30
> mins), the WiFi card doesn't work after resume and I have to reboot
> every time.
>
> This bug really undermines the portability aspect of the laptop as I
> can't simply close the lid and continue my work later. The WiFi simply
> dies every time I suspend, and I have to reboot.
>
> It would be really helpful if I could get this to work in the meantime
> as well with a workaround as I will be on the move soon.
>
> Lastly, thank you for all the work put into the drivers. They work
> mostly fine without any issues. This suspend issue is the only thing I
> can see, and I would be glad to help to get it fixed.
>
> My machine details:
> OS: Arch Linux w/Linux 6.1.31-1-lts
> Card: Realtek 8822BE WiFi
> Laptop: ASUS TUF FX505DT
>
> Please let me know if you need further information.
>
> Regards,
> Utkarsh Verma
