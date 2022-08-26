Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026AC5A2620
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 12:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbiHZKvC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 06:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344027AbiHZKuq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 06:50:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B345F37181
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 03:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 535D0B830AC
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 10:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEF8C433D7
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 10:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661511040;
        bh=GyPmqNhvJM6Rg2RFDCY39gIB8qMT1X8vz4z7CrUDmKc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OJuFYgDJRMum+ZujmhNJfhQK9hyhlw/T2uF6Pstg1w6yGOmLXzFBCMJF5coj/MNvg
         fS+UcMZAUKuqphKJ3ZVnl9XMoisDQnIV3zcv6QRZB05DHwXu31rlFswMFnck5GWIKL
         TrQBQour2PGmE53Dvs8+Sm0JeyYt2LvrxEuonnf3O2EMN/iibIs0TDzViXHL+mxoNl
         VfQ53anCKVZ/+gbxDkJDN2KeWvzmDlTIW3Qp0jbqiYmZw+8dHiuYsAcCvQc4WJrpqb
         C+CWq0CikOkvxNoCoprOMssZjNLP6mEae7dE/R1gSX9eIQYZQTJfmvxjfizr17iQTI
         7e4uat05MGyog==
Received: by mail-wr1-f51.google.com with SMTP id bs25so1354999wrb.2
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 03:50:40 -0700 (PDT)
X-Gm-Message-State: ACgBeo0ij+tFmSh0R574OpFziptAo4S4XHRE6PkFE852Av7qbS40WeiU
        BdwreGvTJpmtEI7wEpH8iQh2HfI8DbfnEKCeY/Q=
X-Google-Smtp-Source: AA6agR6z4cfT1LyC0KYrLonQjHrBPt3eQqG5KfKkOA0xPqbM5fxaakddMUJQ+f6rD5hhQOREFE4q0zGretEd8X9dqHA=
X-Received: by 2002:adf:d4c6:0:b0:225:2eeb:fe8e with SMTP id
 w6-20020adfd4c6000000b002252eebfe8emr4563323wrk.429.1661511038296; Fri, 26
 Aug 2022 03:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <727eb5ffd3c7c805245e512da150ecf0a7154020.1659452909.git.deren.wu@mediatek.com>
 <CAGp9LzoZkxONid2Kt-ykuQWiY1pTG6NGxho8FeLwMd9MdWd-rA@mail.gmail.com>
In-Reply-To: <CAGp9LzoZkxONid2Kt-ykuQWiY1pTG6NGxho8FeLwMd9MdWd-rA@mail.gmail.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Fri, 26 Aug 2022 03:50:26 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzo+MxynP-Lwb8_eCX4w+EQ6FqZAU3w-OMpcj7x1N8xyyQ@mail.gmail.com>
Message-ID: <CAGp9Lzo+MxynP-Lwb8_eCX4w+EQ6FqZAU3w-OMpcj7x1N8xyyQ@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7921e: fix crash in chip reset fail
To:     Deren Wu <Deren.Wu@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

Kalle seemed not available this week, so I would like to look for help from you.
If the patch looks good to you, could you help apply the patch to
wireless-drivers.git because there are getting more users reporting
the issue with the stable kernel such as [1]. I would like to backport
it sooner once it appears in the Linus tree to solve the indefinite
hang issue. Sorry for the hurry request, I knew you just sent the pull
request one moment ago :(

[1] https://lore.kernel.org/linux-wireless/VE1PR04MB64945C660A81D38F290E4A4BE59F9@VE1PR04MB6494.eurprd04.prod.outlook.com/T/

Sean

On Wed, Aug 24, 2022 at 6:45 PM sean wang <objelf@gmail.com> wrote:
>
> Hi Kalle,
>
> If the patch looks good to you, could you help apply the patch to
> wireless-drivers.git because there are getting more users reporting
> the issue with the stable kernel such as [1]. I would like to backport
> it earlier once it appears in the Linus tree to solve the indefinite
> hang issue.
>
> [1] https://lore.kernel.org/linux-wireless/VE1PR04MB64945C660A81D38F290E4A4BE59F9@VE1PR04MB6494.eurprd04.prod.outlook.com/T/
>
> Sean
>
> On Tue, Aug 2, 2022 at 8:20 AM Deren Wu <Deren.Wu@mediatek.com> wrote:
> >
> > From: Deren Wu <deren.wu@mediatek.com>
> >
> > In case of drv own fail in reset, we may need to run mac_reset several
> > times. The sequence would trigger system crash as the log below.
> >
> > Because we do not re-enable/schedule "tx_napi" before disable it again,
> > the process would keep waiting for state change in napi_diable(). To
> > avoid the problem and keep status synchronize for each run, goto final
> > resource handling if drv own failed.
> >
> > [ 5857.353423] mt7921e 0000:3b:00.0: driver own failed
> > [ 5858.433427] mt7921e 0000:3b:00.0: Timeout for driver own
> > [ 5859.633430] mt7921e 0000:3b:00.0: driver own failed
> > [ 5859.633444] ------------[ cut here ]------------
> > [ 5859.633446] WARNING: CPU: 6 at kernel/kthread.c:659 kthread_park+0x11d
> > [ 5859.633717] Workqueue: mt76 mt7921_mac_reset_work [mt7921_common]
> > [ 5859.633728] RIP: 0010:kthread_park+0x11d/0x150
> > [ 5859.633736] RSP: 0018:ffff8881b676fc68 EFLAGS: 00010202
> > ......
> > [ 5859.633766] Call Trace:
> > [ 5859.633768]  <TASK>
> > [ 5859.633771]  mt7921e_mac_reset+0x176/0x6f0 [mt7921e]
> > [ 5859.633778]  mt7921_mac_reset_work+0x184/0x3a0 [mt7921_common]
> > [ 5859.633785]  ? mt7921_mac_set_timing+0x520/0x520 [mt7921_common]
> > [ 5859.633794]  ? __kasan_check_read+0x11/0x20
> > [ 5859.633802]  process_one_work+0x7ee/0x1320
> > [ 5859.633810]  worker_thread+0x53c/0x1240
> > [ 5859.633818]  kthread+0x2b8/0x370
> > [ 5859.633824]  ? process_one_work+0x1320/0x1320
> > [ 5859.633828]  ? kthread_complete_and_exit+0x30/0x30
> > [ 5859.633834]  ret_from_fork+0x1f/0x30
> > [ 5859.633842]  </TASK>
> >
> > Fixes: 0efaf31dec57 ("mt76: mt7921: fix MT7921E reset failure")
> > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> > index e1800674089a..576a0149251b 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> > @@ -261,7 +261,7 @@ int mt7921e_mac_reset(struct mt7921_dev *dev)
> >
> >         err = mt7921e_driver_own(dev);
> >         if (err)
> > -               return err;
> > +               goto out;
> >
> >         err = mt7921_run_firmware(dev);
> >         if (err)
> > --
> > 2.18.0
> >
