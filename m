Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2660E635122
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 08:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiKWHgO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 02:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiKWHgN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 02:36:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD75F802A
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 23:36:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0519DB81ECD
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31603C433D6;
        Wed, 23 Nov 2022 07:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669188969;
        bh=2Edqw+R1WvvZibkeH4SiWhA8NwRq/LvyT6/U9T28yKE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=G4GGmdRi5LxNwVMYU5xZ5/0ehUE0K4sdIoN7SPv/bm9jP3DYvVLdxwsZKPRPIs8JF
         AVY07aNTfreeE8ii4xndgwZ/2indDAt8dWn+PrhrradmIGN+dUr24CTeCl2v3jXCxf
         oCwPHEhbGCx/nCZOA6puwSv2TV9ZNYTTwBklTDriwLter1UdpSux1JR+XxprNHOQzJ
         YaxybbcCmshbp7Gtc8QFdIBghtqshAdA2jcAvJ7RrS0MnO/3g5hmZR/Ur+m0U3tQCx
         RoaquKYi3d/UCXO8CIzpLvoFd3ib7zHwvhO1dNfsgY6reWwDs94HMSu/1bXjL2c24J
         U55FwDv9wtsYg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ryder Lee <Ryder.Lee@mediatek.com>
Cc:     =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek\@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?Q?Howard-YH_Hsu_=28?=
         =?utf-8?Q?=E8=A8=B1=E8=82=B2=E8=B1=AA=29?= 
        <Howard-YH.Hsu@mediatek.com>,
        =?utf-8?B?TWVpQ2hpYSBDaGl1ICjpgrHnvo7lmIkp?= 
        <MeiChia.Chiu@mediatek.com>,
        =?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= 
        <Money.Wang@mediatek.com>, "nbd\@nbd.name" <nbd@nbd.name>,
        =?utf-8?Q?StanleyYP_Wang_=28=E7=8E=8B?=
         =?utf-8?Q?=E4=BE=91=E9=82=A6=29?= <StanleyYP.Wang@mediatek.com>,
        "lorenzo\@kernel.org" <lorenzo@kernel.org>,
        =?utf-8?Q?Chui-hao_Chiu_=28?=
         =?utf-8?Q?=E9=82=B1=E5=9E=82=E6=B5=A9=29?= 
        <Chui-hao.Chiu@mediatek.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>
Subject: Re: [PATCH v2 9/9] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices
References: <20221110093525.29649-1-shayne.chen@mediatek.com>
        <20221110093525.29649-10-shayne.chen@mediatek.com>
        <87ilj8pcqr.fsf@kernel.org>
        <0285ab6ac5d3edfdd513ff3888481f0764b2e38b.camel@mediatek.com>
Date:   Wed, 23 Nov 2022 09:36:04 +0200
In-Reply-To: <0285ab6ac5d3edfdd513ff3888481f0764b2e38b.camel@mediatek.com>
        (Ryder Lee's message of "Mon, 21 Nov 2022 19:45:14 +0000")
Message-ID: <875yf6p1gb.fsf@kernel.org>
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

Ryder Lee <Ryder.Lee@mediatek.com> writes:

> On Mon, 2022-11-21 at 17:07 +0200, Kalle Valo wrote:
>> Shayne Chen <shayne.chen@mediatek.com> writes:
>> 
>> > Add MediaTek new mac80211 driver mt7996 for Wi-Fi 7 (802.11be)
>> > devices.
>> > The driver first supports Filogic 680 PCI device, which is a Wi-Fi
>> > 7
>> > chipset supporting concurrent tri-band operation at 6 GHz, 5 GHz,
>> > and
>> > 2.4 GHz with 4x4 antennas on each band.
>> > 
>> > Currently, mt7996 only supports tri-band HE or older mode.
>> > EHT mode and more variants of Filogic 680 support will be
>> > introduced
>> > in further patches.
>> > 
>> > Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
>> > Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
>> > Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
>> > Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
>> > Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
>> > Co-developed-by: Howard Hsu <howard-yh.hsu@mediatek.com>
>> > Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
>> > Co-developed-by: MeiChia Chiu <meichia.chiu@mediatek.com>
>> > Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
>> > Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
>> > Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
>> > Co-developed-by: Money Wang <Money.Wang@mediatek.com>
>> > Signed-off-by: Money Wang <Money.Wang@mediatek.com>
>> > Co-developed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
>> > Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
>> > Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
>> > ---
>> >  drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
>> >  drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
>> >  .../net/wireless/mediatek/mt76/mt7996/Kconfig |   12 +
>> >  .../wireless/mediatek/mt76/mt7996/Makefile    |    6 +
>> >  .../wireless/mediatek/mt76/mt7996/debugfs.c   |  851 ++++
>> >  .../net/wireless/mediatek/mt76/mt7996/dma.c   |  360 ++
>> >  .../wireless/mediatek/mt76/mt7996/eeprom.c    |  229 ++
>> >  .../wireless/mediatek/mt76/mt7996/eeprom.h    |   75 +
>> >  .../net/wireless/mediatek/mt76/mt7996/init.c  |  816 ++++
>> >  .../net/wireless/mediatek/mt76/mt7996/mac.c   | 2468 ++++++++++++
>> >  .../net/wireless/mediatek/mt76/mt7996/mac.h   |  398 ++
>> >  .../net/wireless/mediatek/mt76/mt7996/main.c  | 1325 +++++++
>> >  .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 3428
>> > +++++++++++++++++
>> >  .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  662 ++++
>> >  .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  385 ++
>> >  .../wireless/mediatek/mt76/mt7996/mt7996.h    |  516 +++
>> >  .../net/wireless/mediatek/mt76/mt7996/pci.c   |  222 ++
>> >  .../net/wireless/mediatek/mt76/mt7996/regs.h  |  533 +++
>> >  18 files changed, 12288 insertions(+)
>> 
>> This patch is too big, please split it. One patch per file is a good
>> rule of thumb.
>> 
>
> Hi Kalle,
>
> Thanks for comments.
>
> It's a bit hard to adjugement to us actually. We'd prefer to keeping
> one topic (wifi7 thing support for this case) one patch. I guess add
> code that is nor used or does not compile could get other complaints.

Applying it to the git tree as one big commit is fine, but for reviews I
always recommend splitting new drivers to one file per patch. I tried to
review this huge patch and gave up, it was just too difficult.

> Given that the series has been merged to Felix's tree (and couple
> patches are being applied on top of his tree)... but we will take care
> of this part next time and split the series by functionality as much as
> we can. What do you think?

One option is to send followup patches to handle the issues found during
review.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
