Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30A6DCCE4
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Apr 2023 23:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjDJVpj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 17:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDJVpi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 17:45:38 -0400
Received: from stone.woods.net (stone.woods.net [74.50.54.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D729D173E
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 14:45:36 -0700 (PDT)
Received: from sneaky (66.29.179.130.static.utbb.net [66.29.179.130])
        by stone.woods.net (Postfix) with ESMTPSA id C849B80F8
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 21:45:35 +0000 (UTC)
Date:   Mon, 10 Apr 2023 15:45:33 -0600
From:   Aaron Dewell <acd@woods.net>
To:     "=?utf-8?Q?linux-wireless=40vger.kernel.org?=" 
        <linux-wireless@vger.kernel.org>
Message-ID: <6B4C1859-60D3-449E-8617-D20B9B06F5A0@getmailspring.com>
In-Reply-To: <9AEF6A8A-44F0-4863-9467-44C137D7430A@getmailspring.com>
References: <9AEF6A8A-44F0-4863-9467-44C137D7430A@getmailspring.com>
Subject: Re: ax204/Intel NUC13 i9
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To summarize up to now and reboot the discussion:

I have installed firmware-git. This is the file that was extracted into /lib/firmware:
-rw-r--r--  1 root  root 429469981 Apr  2 10:47 linux-firmware-iwlwifi-fw-2023-03-30.tar.gz

The card is not successfully initialized by the stock (6.1.20) kernel:
[    2.284183] Intel(R) Wireless WiFi driver for Linux
[    2.284221] cryptd: max_cpu_qlen set to 1000
[    2.284223] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    2.286133] iwlwifi: No config found for PCI dev 7af0/1692,
rev=0x430, rfid=0x3010d000
[    2.286155] iwlwifi: probe of 0000:00:14.3 failed with error -22

The distribution is Debian Bookworm (testing), which has kernel:
Linux shrub 6.1.0-7-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.20-1
(2023-03-19) x86_64 GNU/Linux

The card identifies as 0x7AF0, 0x1692:
00:14.3 Network controller [0280]: Intel Corporation Alder Lake-S PCH
CNVi WiFi [8086:7af0] (rev 11)
        Subsystem: Rivet Networks Alder Lake-S PCH CNVi WiFi [1a56:1692]
        Flags: fast devsel, IRQ 18, IOMMU group 6
        Memory at 604c124000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [80] MSI-X: Enable- Count=16 Masked-
        Capabilities: [100] Latency Tolerance Reporting
        Capabilities: [164] Vendor Specific Information: ID=0010 Rev=0
Len=014 <?>
        Kernel modules: iwlwifi

Granted that I am no expert on this, but I know enough to get myself
into trouble, which is what I proceeded to do.  I believe (but could
well be mistaken) that what is needed is a configuration line for that
PCI ID in iwlwifi/pcie/drv.c, something like this one:

IWL_DEV_INFO(0x7F70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),

My attempt was to duplicate then change the new line from 7F70 to 7AF0,
but that was also not successful, with such errors as (clipping because
it's rather long):

[...]
[    3.960164] iwlwifi 0000:00:14.3: Microcode SW error detected.
Restarting 0x0.
[...]
[    3.960551] iwlwifi 0000:00:14.3: Starting mac, retry will be
triggered anyway
[    3.960594] iwlwifi 0000:00:14.3: FW error in SYNC CMD ADD_STA
[    3.960600] Call Trace:
[    3.960602]  <TASK>
[    3.960602]  dump_stack_lvl+0x36/0x50
[    3.960606]  iwl_trans_txq_send_hcmd+0x338/0x450 [iwlwifi]
[...]

It does produce an interface but it is unusable.

I assume (but I am definitely out of my depth at this point) that it is
due to the wrong firmware being referenced by that line of code (i.e.
it's a different firmware for 7F70 vs. 7AF0) but I also don't know what
the correct one is, thus I'm asking here.  If I'm totally on the wrong
track, I'm fine with that too, I just want to get it working.

Thanks!


