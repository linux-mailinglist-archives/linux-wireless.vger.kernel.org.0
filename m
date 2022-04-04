Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13E14F200F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Apr 2022 01:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244289AbiDDXPo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 19:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243538AbiDDXPg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 19:15:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE5F2F393
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 15:59:20 -0700 (PDT)
X-UUID: c407711cda0d40b9b0150dbc3ebdeb18-20220405
X-UUID: c407711cda0d40b9b0150dbc3ebdeb18-20220405
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 905769536; Tue, 05 Apr 2022 06:59:15 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 5 Apr 2022 06:59:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 5 Apr
 2022 06:59:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Apr 2022 06:59:14 +0800
From:   <sean.wang@mediatek.com>
To:     <ihuguet@redhat.com>
CC:     <linux-wireless@vger.kernel.org>, <Sean.Wang@mediatek.com>,
        <Ryder.Lee@mediatek.com>, <Shayne.Chen@mediatek.com>,
        <lorenzo.bianconi83@gmail.com>, <nbd@nbd.name>,
        Sean Wang <sean.wang@mediatek.com>
Subject: =?UTF-8?q?Re=3A=20MT7921=20Causing=20Kernel=20to=20Freeze=20after=20Reboot?=
Date:   Tue, 5 Apr 2022 06:59:12 +0800
Message-ID: <1649113152-3982-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <d67a480b032523d65da24b77dee163899dc21ac2.camel@pschenker.ch--annotate>
References: <d67a480b032523d65da24b77dee163899dc21ac2.camel@pschenker.ch--annotate>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>On Thu, 2022-03-24 at 10:13 +0100, Íñigo Huguet wrote:
>> On Wed, Dec 22, 2021 at 12:52 PM Philippe Schenker <dev@pschenker.ch>
>> wrote:
>> >
>> > Hello
>> >
>> > So I received a new notebook recently, this is a Lenovo P14s that
>> > has a Mediatek 7961 network controller inside.
>> >
>> > -----
>> >
>> > 03:00.0 Network controller: MEDIATEK Corp. Device 7961
>> >         Subsystem: Lenovo Device e0bc
>> >         Physical Slot: 0
>> >         Flags: bus master, fast devsel, latency 0, IRQ 91, IOMMU
>> > group
>> > 13
>> >         Memory at 870200000 (64-bit, prefetchable) [size=1M]
>> >         Memory at 870300000 (64-bit, prefetchable) [size=16K]
>> >         Memory at 870304000 (64-bit, prefetchable) [size=4K]
>> >         Capabilities: <access denied>
>> >         Kernel driver in use: mt7921e
>> >         Kernel modules: mt7921e
>> > ------
>> >
>> > I have the issue that on 5.16-rc6 kernel (also on other rcs) it is
>> > always freezing after I issue a "reboot" command. "poweroff"
>> > followed by
>> > a normal power-on works always.
>>
>> I have a bug report with this same behaviour and almost identical
>> kernel logs.: message "Timeout for driver own" followed by traces
>> related to mt7921 dma stuff, indicating bad page state with refcount
>> -1 and "page dumped because: nonzero _refcount", finally causing a
>> crash during boot up, but only after reboot, not after normal power
>> on.
>>
>> It happens always, even with v5.17. Commit 602cc0c9618a (mt76:
>> mt7921e: fix possible probe failure after reboot) doesn't fix the
>> issue.
>>
>> I hadn't been able to verify where the problem exactly is, but my
>> guess is this:
>> - In function mt7921_init_hardware, initialization fails because
>> mt7921e_driver_own doesn't finish before the timeout (thus we see the
>> "Timeout for driver own")
>> - Then, before retrying to init, mt7921_init_hardware calls
>> mt7921e_init_reset, and the latter calls to mt7921_wpdma_reset
>> - That makes a cleanup of the DMA queues before stopping the DMA,
>> which had been enabled short before during probe
>> - Then, my guess is that in the meanwhile, a DMA event arrives with
>> the queues stillI being cleaned up
>>
>> Does it make sense?
>
>After your suggestion I went down the rabbit-hole and bisected this issue. Fortunately I found the commit introducing the issue. Reverting this commit solves the problem for me on v5.17. It is caused around the PCIe ASPM feature.
>
># first bad commit: [bf3747ae2e25dda6a9e6c464a717c66118c588c8] mt76:
>mt7921: enable aspm by default

have you tried the latest firmware to see if it can help with the issue ?

such as https://patchwork.kernel.org/project/linux-mediatek/patch/8e8a3e94ffe7586cec5abe56ba507e1e3ed8b823.1648171096.git.objelf@gmail.com/

>
>@Felix do I have to report this anywhere else than on here?
>
>Thanks,
>Philippe
>
>>
>> >
>> > Since it freezes and showing multiple Call Traces I included 4 logs
>> > in the attachment, it certainly points always to mt76_dma functions.

<snip>
