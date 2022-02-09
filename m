Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634D74AF728
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 17:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiBIQry convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 11:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiBIQrx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 11:47:53 -0500
X-Greylist: delayed 2420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 08:47:56 PST
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B15FC0613C9
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 08:47:56 -0800 (PST)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1nHpVC-0005gw-RU; Wed, 09 Feb 2022 17:07:30 +0100
Date:   Wed, 9 Feb 2022 17:05:50 +0100
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     linux-wireless@vger.kernel.org
Subject: mt7921: Oops in mt76_dma_rx_fill
Message-ID: <20220209170550.0a73ebe4@barney>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

on the latest stable 5.16.8 (df659ebe) the Mediatek WLAN driver crashes
on my machine in a DMA function.

Please excuse me for the crappy photos. The first one has been captured
out of a video. Therefore it's partially interleaved with the
predecessor frame.

https://bues.ch/misc/mt7921/mt7921_oops1.jpg
https://bues.ch/misc/mt7921/mt7921_oops2.jpg

Most of the time the crash happens right during system boot.

The stable kernel 5.15.y does not crash. (However, I frequently get
connection interruptions. But I'm not sure whether that's related to
the driver.)

03:00.0 Network controller: MEDIATEK Corp. MT7921 802.11ax PCI Express Wireless Network Adapter

03:00.0 0280: 14c3:7961
        Subsystem: 17aa:e0bc
        Physical Slot: 0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 94
        IOMMU group: 11
        Region 0: Memory at 670200000 (64-bit, prefetchable) [size=1M]
        Region 2: Memory at 670300000 (64-bit, prefetchable) [size=16K]
        Region 4: Memory at 670304000 (64-bit, prefetchable) [size=4K]
        Capabilities: <access denied>
        Kernel driver in use: mt7921e
        Kernel modules: mt7921e


-- 
Michael Büsch
https://bues.ch/
