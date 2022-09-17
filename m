Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D128E5BB870
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIQNVl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQNVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 09:21:39 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E732126F
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 06:21:37 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 22298 invoked from network); 17 Sep 2022 15:21:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663420895; bh=nrePjWJEfo1bN1hzN7CYhPEEtXafH27RfEVwE+MenR0=;
          h=From:To:Cc:Subject;
          b=pR6oGpnrJvfDER2xYNSCER8y0dFDpAhoU4Fubpeq3MnKFEgLjTMt2uVfIebgu84Qa
           HoDrEKFyEjLiAVmCyHU61j8nKvdZh+gw50BaORVmsv4ijM0rwYjAeAS7fqPJONxFNY
           O5cAx8uFGdrvOF0wREzHHUxQ+VJRJpM2BDKPtMLQ=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 15:21:35 +0200
Date:   Sat, 17 Sep 2022 15:21:34 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH RESEND 01/15] rt2x00: define RF5592 in init_eeprom routine
Message-ID: <20220917132134.GN17901@wp.pl>
References: <YyUA9QVEM+D2VOL4@makrotopia.org>
 <20220917131052.GL17901@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220917131052.GL17901@wp.pl>
X-WP-MailID: b958f9740d737c40509916147241a859
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [QbP0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 03:10:53PM +0200, Stanislaw Gruszka wrote:
> On Sat, Sep 17, 2022 at 12:04:21AM +0100, Daniel Golle wrote:
> > From: Tomislav Požega <pozega.tomislav@gmail.com>
> > 
> > This patch fixes following crash on Linksys EA2750 during 5GHz wifi
> > init:
> > 
> > [    7.955153] rt2800pci 0000:01:00.0: card - bus=0x1, slot = 0x0 irq=4
> > [    7.962259] rt2800pci 0000:01:00.0: loaded eeprom from mtd device "Factory"
> > [    7.969435] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 5592, rev 0222 detected
> > [    7.977348] ieee80211 phy0: rt2800_init_eeprom: Error - Invalid RF chipset 0x0000 detected
> > [    7.985793] ieee80211 phy0: rt2x00lib_probe_dev: Error - Failed to allocate device
> > [    7.993569] CPU 0 Unable to handle kernel paging request at virtual address 00000024, epc == 800c8f54, ra == 80249ff8
> > [    8.004408] Oops[#1]:
> > 
> > Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
> 
> Please add your's signed-off-by and fix the changelog. Patch
> fixes  incorrect rf value encoded in eeprom, not a crash. IIRC
> crash itself was caused by incorrect rt2x00->eeprom_file pointer,
> happend when rt2800_init_eeprom() returned error. And should
> be alredy fixed in openwrt tree.

The crash was fixed by:
https://patchwork.ozlabs.org/project/openwrt/patch/1551000198-30901-1-git-send-email-sgruszka@redhat.com/
