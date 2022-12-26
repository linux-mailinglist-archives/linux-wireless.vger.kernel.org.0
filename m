Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C2656606
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Dec 2022 00:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLZX0t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Dec 2022 18:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLZX0s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Dec 2022 18:26:48 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69235219B
        for <linux-wireless@vger.kernel.org>; Mon, 26 Dec 2022 15:26:47 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id i12so8209659qvs.2
        for <linux-wireless@vger.kernel.org>; Mon, 26 Dec 2022 15:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P3iFAM+GnyX6r4cvrGUC8lHicqwkHTYezPzVa39Vp7Y=;
        b=d3Ld0ygPlxxUti1hCMp2GmpWH8tyzD8WCkabG/sCamJ+Ts18002WhAomvaLG+k6BKn
         comiM1gVWfJN8SqTtUtMPj8p2ZfW/nl5vT8p2bJCWFrw/MBJmlNjSG4egl9Vlxho2Xc5
         bOk/iwLlruUl3ftXNa9ot6wNeiOIrLvPSYWZgGrA6UHi4yhg3BVWwzSrAoqeps1ZPInF
         dxEGmjb0qOS5cXQI+35l08C1QledwnQ22LruAaq68gd7DX8L2dVSwGesn8AQXeQjBai7
         IOCeWFi7TWVlV3tmLSZDYnGK629l3FZygtpF2isMCQJ4lmJR6cEZJM4RQ9opoiLWZSw9
         7YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3iFAM+GnyX6r4cvrGUC8lHicqwkHTYezPzVa39Vp7Y=;
        b=zmLissq6F8LGv+2pepa5zVNq9rTUpYm3a3U8DwSt8enxTFIY661KzDeiFP+MS/lqyU
         D2TFIaFagNeaKbW080Ll8MzvhRBMaU07ucFk1KcEBWWCxBm/Q5NS5bBGg96lDXfjNc8C
         A88gg+pArhfPiYF8MY5l8yject+dNQ+mRkOyHRYSAPMgqbjpcWxc1dDqkQq8EE7QEZWB
         kiz/G8hjGwj+vfOIcCEclyYWGMXW/r0aKCouPDGQ6Az4Rx9BuQxergXCWXFQF58K8nl9
         xrlc0eMH+JeIZCj7C1/Xr81KQ3NDoht1SzhL/JMkDyLUVnvOIeZQoA7Cy4P1SXSFxcrb
         vQow==
X-Gm-Message-State: AFqh2krdudzO17Ov9sgaLIZ0UvAf5CUbXFR13jBk7KdXXopuP4tWM/tR
        D007fQYpipL/KfWtA1E8tyZh1lS19JpfEUsg4w==
X-Google-Smtp-Source: AMrXdXsbqkPHOy+T6frU2y8Jnt5iC/XfCam6oRV+wa/TwXlhAE8BKPPB3Qc3blNMaP9U8bhcAtWdz34BQ4WxEBNmCus=
X-Received: by 2002:a0c:eecf:0:b0:4c7:6648:a2c4 with SMTP id
 h15-20020a0ceecf000000b004c76648a2c4mr1119448qvs.12.1672097206548; Mon, 26
 Dec 2022 15:26:46 -0800 (PST)
MIME-Version: 1.0
References: <CAFktD2fRnSbNgWRRoGbQzG5_Mw7=zFJKTVBHS_3D+mNUYcv9hQ@mail.gmail.com>
 <Y6Y3wzSxbTG2aLAo@localhost.localdomain>
In-Reply-To: <Y6Y3wzSxbTG2aLAo@localhost.localdomain>
From:   Nick Morrow <morrownr@gmail.com>
Date:   Mon, 26 Dec 2022 17:26:20 -0600
Message-ID: <CAFktD2fbpUv9X5MY1jozyXoxvNXW=4OfaJ3B1KcZtdrBfiG4NA@mail.gmail.com>
Subject: Re: [bug report} wifi: mt76: mt7612u/mt7610u - 6.1.x hard locking systems
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        Sean Wang <sean.wang@mediatek.com>, deren.wu@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
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

> > Starting with kernel 6.1 rc1, mt7612u and mt7610u are hard locking
> > systems when connection is established. From a report this morning:
> >
> > "So I'm using a MT7610U based adapter and updated to 6.1.1 in Arch
> > Linux and it's a complete lockup a few seconds after connecting as
> > other people have said, I'll use the LTS kernel (5.15) in the
> > meanwhile but this is probably going to get a lot of people that use
> > distros with newer kernels."
> >
> > Background: Problem first discovered with kernel 6.1 rc1. Bug report
> > was seen on linux-wireless around the rc5 timeframe. This is an
> > additional bug report.
> >
> > I don't think additional info is needed as I have tested on several
> > distros with various RC's of 6.1 and the problem is 100% reproducible
> > and unavoidable. This is a show stopper bug and will result in
> > widespread reports as distros upgrade to kernel 6.1.
> >
> > Regards,
>
> Hi Nick,
>
> Can you please try the patch below?
> https://patchwork.kernel.org/project/linux-wireless/patch/20221217085624.52077-1-nbd@nbd.name/
>
> Regards,
> Lorenzo

Lorenzo,

Today, I downloaded kernel 6.1.1, applied the above patch and
compiled. Once installed, I tested with an Alfa ACM mt7612u based
adapter. I no longer see the problem. No system lockups at all. iperf3
is showing a consistent performance of around 387 Mb/s. dmesg is
clean. The patch appears to have fixed the issue. I can also test with
a mt7610u based adapter if you think it is necessary but since that
patch was not to mt76, I decided testing only with the mt7612u adapter
was probably good enough. Let me know if there is anything else I can
do.

Nick
https://github.com/morrownr/USB-WiFi
