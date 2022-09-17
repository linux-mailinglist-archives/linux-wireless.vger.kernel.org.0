Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9085BB87F
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 15:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIQN20 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQN2Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 09:28:25 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896BE2981C
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 06:28:24 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZXrm-0001or-2Z;
        Sat, 17 Sep 2022 15:28:18 +0200
Date:   Sat, 17 Sep 2022 14:28:16 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH RESEND 01/15] rt2x00: define RF5592 in init_eeprom routine
Message-ID: <YyXLcJoA0EiSBrHE@makrotopia.org>
References: <YyUA9QVEM+D2VOL4@makrotopia.org>
 <20220917131052.GL17901@wp.pl>
 <20220917132134.GN17901@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220917132134.GN17901@wp.pl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 03:21:34PM +0200, Stanislaw Gruszka wrote:
> On Sat, Sep 17, 2022 at 03:10:53PM +0200, Stanislaw Gruszka wrote:
> > On Sat, Sep 17, 2022 at 12:04:21AM +0100, Daniel Golle wrote:
> > > From: Tomislav Požega <pozega.tomislav@gmail.com>
> > > 
> > > This patch fixes following crash on Linksys EA2750 during 5GHz wifi
> > > init:
> > > 
> > > [    7.955153] rt2800pci 0000:01:00.0: card - bus=0x1, slot = 0x0 irq=4
> > > [    7.962259] rt2800pci 0000:01:00.0: loaded eeprom from mtd device "Factory"
> > > [    7.969435] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 5592, rev 0222 detected
> > > [    7.977348] ieee80211 phy0: rt2800_init_eeprom: Error - Invalid RF chipset 0x0000 detected
> > > [    7.985793] ieee80211 phy0: rt2x00lib_probe_dev: Error - Failed to allocate device
> > > [    7.993569] CPU 0 Unable to handle kernel paging request at virtual address 00000024, epc == 800c8f54, ra == 80249ff8
> > > [    8.004408] Oops[#1]:
> > > 
> > > Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
> > 
> > Please add your's signed-off-by and fix the changelog. Patch
> > fixes  incorrect rf value encoded in eeprom, not a crash. IIRC
> > crash itself was caused by incorrect rt2x00->eeprom_file pointer,
> > happend when rt2800_init_eeprom() returned error. And should
> > be alredy fixed in openwrt tree.
> 
> The crash was fixed by:
> https://patchwork.ozlabs.org/project/openwrt/patch/1551000198-30901-1-git-send-email-sgruszka@redhat.com/

Yes, the itself has been fixed. For working wifi it's just the RF
value in EEPROM which needs overriding with RT5592 PCIe radio (a single
chip with built-in RF frontend), which is also what the vendor driver
does afair. I will update the commit message in v2.
