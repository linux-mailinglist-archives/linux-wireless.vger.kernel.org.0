Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5051D69E95C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Feb 2023 22:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBUVUl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Feb 2023 16:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBUVUk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Feb 2023 16:20:40 -0500
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732F12DE79
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 13:20:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id C642F2019B
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 22:20:31 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 39aBLtjjHOQd for <linux-wireless@vger.kernel.org>;
        Tue, 21 Feb 2023 22:20:31 +0100 (CET)
Received: from eyak.inrialpe.fr (82-64-217-88.subs.proxad.net [82.64.217.88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 9AC2020101
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 22:20:31 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by eyak.inrialpe.fr (Postfix) with ESMTP id 36C0C1A0565
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 22:20:31 +0100 (CET)
Message-ID: <ad820d2e-c984-8603-9821-e6c1d426c4f8@debian.org>
Date:   Tue, 21 Feb 2023 22:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.22)
 Gecko/20091109 Lightning/0.8 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
From:   Vincent Danjean <vdanjean@debian.org>
To:     linux-wireless@vger.kernel.org
Content-Language: en-US
Subject: Bug report about ath9k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

   Hi,

I'm reporting here a bug in the ath9k driver.


I've spurious problems with my atheros PCIE card.
It is used with hostapd to provide wifi AP.
Sometimes, the client do not succeed to connect to internet.
In the log, I can observe the following lines. It seems that
most (all?) of the time, they are preceeded by:

[...]
Jan 29 17:08:33 aya kernel: [573587.069575] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
Jan 29 17:08:33 aya kernel: [573587.470696] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
Jan 29 17:21:29 aya kernel: [574363.908459] DMAR: DRHD: handling fault status reg 2
Jan 29 17:21:29 aya kernel: [574363.908465] DMAR: [DMA Read NO_PASID] Request device [72:00.0] fault addr 0xfe721000 [fault reason 0x06] PTE Read access is not set
Jan 29 17:21:30 aya kernel: [574364.294048] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x000062c0
Jan 29 17:21:30 aya kernel: [574364.681674] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
Jan 29 17:21:31 aya kernel: [574365.099751] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[...]
=> see how a bunch of "ath: phy1: DMA failed to stop in 10 ms" are
just following two "DMAR: ..." lines (and this pattern is recurent).

   I was using this PCIE card without any problems for several years.
The errors occured when I changed my tower for a more recent processor
and motherboard. The disk (software and system config) have been
kept.
   I suspect interraction between the atheros driver and the iommu
(DMAR), the latter was not available on my previous processor.

   Do you have some ideas about which kernel options I can try ?
Note that iommu is not used on this machine for now, but I plan
to use it now that the processor support it (several kvm virtual
machines are running, I would like to manage some hardware
directly in some VM)

   Regards,
     Vincent

PS: the BIOS is up-to-date (with already two upgrades for one month)
PPS: this message is mainly a copy of my Debian bug report
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1029990

-- Package-specific info:
** Version:
Linux version 6.0.0-0.deb11.6-amd64 (debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP PREEMPT_DYNAMIC Debian 6.0.12-1~bpo11+1 (2022-12-19)

** Command line:
BOOT_IMAGE=/vmlinuz-6.0.0-0.deb11.6-amd64 root=/dev/mapper/aya+raid1-root ro apparmor=0 md-degraded=no quiet security=

** Not tainted

** Kernel log:
[574483.465710] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574483.875469] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574484.285468] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574484.694685] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574485.104566] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574485.522817] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574485.923393] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574486.333154] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574486.742990] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574487.161219] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574487.562174] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574487.971704] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574488.381286] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574488.790844] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574489.200428] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574489.618794] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574490.019559] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574490.429334] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574490.840061] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574491.257437] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574491.657950] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574492.068770] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574492.477163] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574492.887130] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574493.297183] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574493.716053] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574494.115516] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574494.525232] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574494.934904] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574495.353391] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574495.753934] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574496.163622] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574496.573284] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574496.982681] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574497.392407] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574497.811844] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574498.211348] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574498.621129] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574499.029039] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574499.449288] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574499.850136] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574500.259461] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574500.669140] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574501.087352] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574501.488271] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574501.897974] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574502.307528] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574502.717098] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574503.126806] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574503.545287] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574503.946011] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574504.356089] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574504.765461] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574505.183703] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574505.584509] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574505.994197] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574506.403488] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574506.812918] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574507.222701] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574507.641312] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574508.041906] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574508.451683] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574508.861189] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574509.280626] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574509.680484] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574510.089885] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574510.499692] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574510.909464] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574511.318855] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574511.738266] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574512.137537] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574512.547572] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574512.957314] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574513.375597] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574513.776686] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574514.186017] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574514.595695] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574515.014088] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574515.415076] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574515.824966] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574516.234291] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574516.643743] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574517.053308] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574517.471734] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574517.873196] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574518.282005] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574518.691636] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574519.110226] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574519.511192] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574519.920438] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574520.329938] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574520.739653] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574521.149286] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574521.567510] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574521.968443] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00006040
[574522.379254] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574522.787812] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[574523.206163] ath: phy1: DMA failed to stop in 10 ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008040
[588351.137660] EXT4-fs (dm-34): re-mounted. Quota mode: none.
[588375.229470] EXT4-fs (dm-34): re-mounted. Quota mode: none.

** Model information
sys_vendor: ASUS
product_name: System Product Name
product_version: System Version
chassis_vendor: Default string
chassis_version: Default string
bios_vendor: American Megatrends Inc.
bios_version: 0814
board_vendor: ASUSTeK COMPUTER INC.
board_name: ProArt Z790-CREATOR WIFI
board_version: Rev 1.xx

** Loaded modules:
uvcvideo
videobuf2_vmalloc
videobuf2_memops
videobuf2_v4l2
videobuf2_common
videodev
ccm
vhost_net
vhost
vhost_iotlb
tap
tun
rfcomm
cpufreq_powersave
cpufreq_ondemand
cpufreq_userspace
cpufreq_conservative
bridge
stp
llc
nfnetlink_cttimeout
nfnetlink
dummy
openvswitch
nsh
nf_conncount
nf_nat
cmac
nf_conntrack
algif_hash
algif_skcipher
af_alg
nf_defrag_ipv6
bnep
nf_defrag_ipv4
binfmt_misc
intel_rapl_msr
ftdi_sio
pl2303
usbserial
mei_hdcp
tps6598x
intel_rapl_common
x86_pkg_temp_thermal
intel_powerclamp
kvm_intel
kvm
irqbypass
ghash_clmulni_intel
aesni_intel
crypto_simd
cryptd
intel_cstate
intel_uncore
pcspkr
efi_pstore
asus_nb_wmi
asus_wmi
platform_profile
battery
sparse_keymap
wmi_bmof
snd_usb_audio
snd_usbmidi_lib
snd_rawmidi
snd_seq_device
mc
nls_ascii
nls_cp437
vfat
fat
cdc_mbim
cdc_wdm
snd_hda_codec_hdmi
snd_sof_pci_intel_tgl
snd_sof_intel_hda_common
soundwire_intel
soundwire_generic_allocation
soundwire_cadence
snd_sof_intel_hda
snd_sof_pci
snd_sof_xtensa_dsp
snd_sof
snd_sof_utils
snd_soc_hdac_hda
ath9k
snd_hda_codec_realtek
snd_hda_ext_core
snd_soc_acpi_intel_match
snd_hda_codec_generic
ath9k_common
snd_soc_acpi
ledtrig_audio
btusb
snd_soc_core
ath9k_hw
iwlmvm
btrtl
btbcm
btintel
btmtk
ath
snd_compress
bluetooth
soundwire_bus
snd_hda_intel
mac80211
snd_intel_dspcfg
snd_intel_sdw_acpi
snd_hda_codec
snd_hda_core
iwlwifi
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
libarc4
jitterentropy_rng
cdc_ncm
snd_timer
cdc_ether
iTCO_wdt
cfg80211
snd
intel_pmc_bxt
sha512_ssse3
usbnet
iTCO_vendor_support
watchdog
sha512_generic
mii
soundcore
ctr
drbg
joydev
ansi_cprng
ecdh_generic
ecc
ucsi_acpi
rfkill
typec_ucsi
mei_me
roles
coretemp
sg
mei
typec
serial_multi_instantiate
intel_pmc_core
acpi_pad
acpi_tad
evdev
nfsd
auth_rpcgss
hwmon_vid
nfs_acl
firewire_sbp2
lockd
firewire_core
crc_itu_t
grace
loop
sunrpc
msr
fuse
configfs
efivarfs
ip_tables
x_tables
autofs4
ext4
crc16
mbcache
jbd2
raid10
raid0
multipath
linear
dm_thin_pool
dm_persistent_data
dm_bio_prison
dm_bufio
dm_mod
raid456
async_raid6_recov
async_memcpy
async_pq
async_xor
async_tx
xor
raid6_pq
libcrc32c
crc32c_generic
hid_generic
usbhid
hid
sr_mod
cdrom
sd_mod
i915
raid1
md_mod
drm_buddy
i2c_algo_bit
drm_display_helper
cec
rc_core
ttm
drm_kms_helper
ahci
xhci_pci
libahci
xhci_hcd
drm
libata
nvme
atlantic
usbcore
thunderbolt
nvme_core
igc
t10_pi
scsi_mod
crc32_pclmul
crc32c_intel
macsec
i2c_i801
crc64_rocksoft
ptp
i2c_smbus
crc64
intel_lpss_pci
crc_t10dif
pps_core
crct10dif_generic
intel_lpss
crct10dif_pclmul
crct10dif_common
idma64
usb_common
scsi_common
wmi
fan
video
pinctrl_alderlake
button

** Network interface configuration:
*** /etc/network/interfaces:

auto lo
iface lo inet loopback
	up ifup dummy0

auto br-ovs-ext
allow-ovs br-ovs-ext
iface br-ovs-ext inet manual
	ovs_type OVSBridge
	ovs_ports en-mb

allow-br-ovs-ext en-mb
iface en-mb inet manual
	ovs_bridge br-ovs-ext
	ovs_type OVSPort
	ovs_extra set port ${IFACE} trunks=10,11,50,51,100,200,201,202,1,2,3,16,17

auto br-wifi
iface br-wifi inet manual
	bridge_ports none
	bridge_maxwait 2
	bridge_fd 5
	bridge_stp on
	up echo 1 > /proc/sys/net/ipv6/conf/$IFACE/disable_ipv6


allow-wifi wifi1
iface wifi1 inet manual
	pre-up env -i PATH=$PATH ifup br-ovs-ext
	hostapd /etc/hostapd/hostapd-wifi1.conf
	post-up for i in `seq 1 10`; do if ip link ls ${IFACE}_1 ; then exit 0 ; else sleep 1 ; fi ; done ; echo "Failed to find ${IFACE}_1"; false
	post-up echo ${IFACE}_1 present
	post-up for i in `seq 1 10`; do if ip link ls ${IFACE}_2 ; then exit 0 ; else sleep 1 ; fi ; done ; echo "Failed to find ${IFACE}_2" ; false
	post-up echo ${IFACE}_2 present
	post-up ovs-vsctl set port ${IFACE}_1 tag=12
	post-up ovs-vsctl set port ${IFACE}_2 tag=13


** Network status:
*** IP interfaces and addresses:
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     inet 127.0.0.1/8 scope host lo
        valid_lft forever preferred_lft forever
     inet6 ::1/128 scope host        valid_lft forever preferred_lft forever
2: en-mb: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master ovs-system state UP group default qlen 1000
     link/ether 58:11:22:c1:cd:b9 brd ff:ff:ff:ff:ff:ff
     altname enp5s0
     altname eno1
     inet6 fe80::5a11:22ff:fec1:cdb9/64 scope link        valid_lft forever preferred_lft forever
6: wifi1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-wifi state UP group default qlen 1000
     link/ether f4:ec:38:c5:fd:94 brd ff:ff:ff:ff:ff:ff
     altname wlp114s0
8: ovs-system: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
     link/ether 8e:07:b8:f5:81:8f brd ff:ff:ff:ff:ff:ff
9: br-ovs-ext: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
     link/ether 58:11:22:c1:cd:b9 brd ff:ff:ff:ff:ff:ff
10: br-wifi: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
     link/ether da:51:ce:92:ce:72 brd ff:ff:ff:ff:ff:ff
51: wifi1_1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master ovs-system state UP group default qlen 1000
     link/ether f4:ec:38:c5:fd:95 brd ff:ff:ff:ff:ff:ff permaddr f4:ec:38:c5:fd:94
52: wifi1_2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master ovs-system state UP group default qlen 1000
     link/ether f4:ec:38:c5:fd:96 brd ff:ff:ff:ff:ff:ff permaddr f4:ec:38:c5:fd:94

*** Device statistics:
Inter-|   Receive                                                |  Transmit
  face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
     lo: 1039080882224 332941597    0    0    0     0          0         0 1039080882224 332941597    0    0    0     0       0          0
  en-mb: 75095428826 522892242    0    0    0     0          0   1122207 3080133227567 2078044544    0    0    0     0       0          0
  wifi1: 442705345 1828921    0    0    0     0          0         0 3068581829 2938822    0    0    0     0       0          0
ovs-system:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
br-ovs-ext: 640513872 8370895    0   17    0     0          0         0        0       0    0    0    0     0       0          0
br-wifi: 3130180   28174    0    0    0     0          0     21064        0       0    0    0    0     0       0          0
wifi1_1: 17755871  307608    0    0    0     0          0         0 22114965  290885    0    0    0     0       0          0
wifi1_2:  579446    3987    0    0    0     0          0         0  2032088    4964    0    0    0     0       0          0

*** Protocol statistics:
Ip:
     Forwarding: 2
     593835204 total packets received
     30 with invalid headers
     169 with invalid addresses
     0 forwarded
     0 incoming packets discarded
     593312396 incoming packets delivered
     465098979 requests sent out
     26 outgoing packets dropped
     1 dropped because of missing route
     5 fragments received ok
     10 fragments created
Icmp:
     5605 ICMP messages received
     9 input ICMP message failed
     ICMP input histogram:
         destination unreachable: 173
         echo requests: 5009
         echo replies: 423
     5734 ICMP messages sent
     0 ICMP messages failed
     ICMP output histogram:
         destination unreachable: 302
         echo requests: 423
         echo replies: 5009
IcmpMsg:
         InType0: 423
         InType3: 173
         InType8: 5009
         OutType0: 5009
         OutType3: 302
         OutType8: 423
Tcp:
     1997805 active connection openings
     40149 passive connection openings
     83 failed connection attempts
     127009 connection resets received
     37 connections established
     810867421 segments received
     2371944734 segments sent out
     9617056 segments retransmitted
     304 bad segments received
     3111592 resets sent
Udp:
     4072670 packets received
     233 packets to unknown port received
     0 packet receive errors
     4037857 packets sent
     0 receive buffer errors
     0 send buffer errors
     IgnoredMulti: 10264
UdpLite:
TcpExt:
     70 ICMP packets dropped because they were out-of-window
     44962 TCP sockets finished time wait in fast timer
     1 time wait sockets recycled by time stamp
     1487 packetes rejected in established connections because of timestamp
     171256 delayed acks sent
     5306 delayed acks further delayed because of locked socket
     Quick ack mode was activated 760 times
     86213280 packet headers predicted
     365651310 acknowledgments not containing data payload received
     259738680 predicted acknowledgments
     TCPSackRecovery: 641203
     Detected reordering 548568 times using SACK
     Detected reordering 19570 times using time stamp
     94 congestion windows fully recovered without slow start
     19004 congestion windows partially recovered using Hoe heuristic
     TCPDSACKUndo: 80
     145 congestion windows recovered without slow start after partial ack
     TCPLostRetransmit: 127962
     TCPSackFailures: 42
     9607265 fast retransmits
     4123 retransmits in slow start
     TCPTimeouts: 2349
     TCPLossProbes: 3665
     TCPLossProbeRecovery: 834
     TCPSackRecoveryFail: 423
     TCPBacklogCoalesce: 478790
     TCPDSACKOldSent: 773
     TCPDSACKOfoSent: 1
     TCPDSACKRecv: 46626
     TCPDSACKOfoRecv: 53
     1499389 connections reset due to unexpected data
     126463 connections reset due to early user close
     17 connections aborted due to timeout
     TCPSACKDiscard: 8
     TCPDSACKIgnoredOld: 4362
     TCPDSACKIgnoredNoUndo: 16242
     TCPSpuriousRTOs: 6
     TCPSackShifted: 8927280
     TCPSackMerged: 18836846
     TCPSackShiftFallback: 7056498
     TCPDeferAcceptDrop: 17404
     TCPRcvCoalesce: 1429476
     TCPOFOQueue: 36142
     TCPOFOMerge: 1
     TCPChallengeACK: 341
     TCPSYNChallenge: 304
     TCPSpuriousRtxHostQueues: 2
     TCPAutoCorking: 6172
     TCPFromZeroWindowAdv: 1
     TCPToZeroWindowAdv: 1
     TCPWantZeroWindowAdv: 485
     TCPSynRetrans: 1595
     TCPOrigDataSent: 2274768878
     TCPHystartTrainDetect: 13076
     TCPHystartTrainCwnd: 13212334
     TCPHystartDelayDetect: 10799
     TCPHystartDelayCwnd: 8721838
     TCPACKSkippedPAWS: 939
     TCPACKSkippedTimeWait: 17
     TCPWinProbe: 669
     TCPKeepAlive: 6588
     TCPDelivered: 2273042102
     TCPAckCompressed: 2282
     TcpTimeoutRehash: 1
     TCPDSACKRecvSegs: 93109
     TCPDSACKIgnoredDubious: 9
IpExt:
     InMcastPkts: 10403
     OutMcastPkts: 2869
     InBcastPkts: 12221
     OutBcastPkts: 216
     InOctets: 390810766165
     OutOctets: 3289360697258
     InMcastOctets: 3158835
     OutMcastOctets: 1868452
     InBcastOctets: 1163686
     OutBcastOctets: 26288
     InNoECTPkts: 597198569
MPTcpExt:


** PCI devices:
00:00.0 Host bridge [0600]: Intel Corporation Device [8086:a700] (rev 01)
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	IOMMU group: 0
	Region 3: Memory at <ignored> (32-bit, non-prefetchable)

00:02.0 VGA compatible controller [0300]: Intel Corporation Device [8086:a780] (rev 04) (prog-if 00 [VGA controller])
	DeviceName: Onboard IGD
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 212
	IOMMU group: 1
	Region 0: Memory at 604b000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at 4000000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 4000 [size=64]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: i915
	Kernel modules: i915

00:06.0 PCI bridge [0604]: Intel Corporation Device [8086:a74d] (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 122
	IOMMU group: 2
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: 93800000-938fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:0a.0 Signal processing controller [1180]: Intel Corporation Device [8086:a77d] (rev 01)
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	IOMMU group: 3
	Region 0: Memory at 604c110000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: <access denied>

00:14.0 USB controller [0c03]: Intel Corporation Device [8086:7a60] (rev 11) (prog-if 30 [XHCI])
	DeviceName: USB Controller
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 210
	IOMMU group: 4
	Region 0: Memory at 604c100000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <access denied>
	Kernel driver in use: xhci_hcd
	Kernel modules: mei_me, xhci_pci

00:14.2 RAM memory [0500]: Intel Corporation Device [8086:7a27] (rev 11)
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	IOMMU group: 4
	Region 0: Memory at 604c124000 (64-bit, non-prefetchable) [disabled] [size=16K]
	Region 2: Memory at 604c12d000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: <access denied>

00:15.0 Serial bus controller [0c80]: Intel Corporation Device [8086:7a4c] (rev 11)
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 27
	IOMMU group: 5
	Region 0: Memory at 4017200000 (64-bit, non-prefetchable) [virtual] [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:15.1 Serial bus controller [0c80]: Intel Corporation Device [8086:7a4d] (rev 11)
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 40
	IOMMU group: 5
	Region 0: Memory at 4017201000 (64-bit, non-prefetchable) [virtual] [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:15.2 Serial bus controller [0c80]: Intel Corporation Device [8086:7a4e] (rev 11)
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 29
	IOMMU group: 5
	Region 0: Memory at 4017202000 (64-bit, non-prefetchable) [virtual] [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:16.0 Communication controller [0780]: Intel Corporation Device [8086:7a68] (rev 11)
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 213
	IOMMU group: 6
	Region 0: Memory at 604c129000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: mei_me
	Kernel modules: mei_me

00:17.0 SATA controller [0106]: Intel Corporation Device [8086:7a62] (rev 11) (prog-if 01 [AHCI 1.0])
	DeviceName: SATA Controller
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 209
	IOMMU group: 7
	Region 0: Memory at 93900000 (32-bit, non-prefetchable) [size=8K]
	Region 1: Memory at 93903000 (32-bit, non-prefetchable) [size=256]
	Region 2: I/O ports at 4090 [size=8]
	Region 3: I/O ports at 4080 [size=4]
	Region 4: I/O ports at 4060 [size=32]
	Region 5: Memory at 93902000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: <access denied>
	Kernel driver in use: ahci
	Kernel modules: ahci

00:1a.0 PCI bridge [0604]: Intel Corporation Device [8086:7a48] (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 123
	IOMMU group: 8
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00003000-00003fff [size=4K]
	Memory behind bridge: 92900000-932fffff [size=10M]
	Prefetchable memory behind bridge: 0000004017000000-00000040171fffff [size=2M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1b.0 PCI bridge [0604]: Intel Corporation Device [8086:7a40] (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 124
	IOMMU group: 9
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: [disabled]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1b.4 PCI bridge [0604]: Intel Corporation Device [8086:7a44] (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 125
	IOMMU group: 10
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: 93700000-937fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:7a38] (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 126
	IOMMU group: 11
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: 92400000-928fffff [size=5M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1c.2 PCI bridge [0604]: Intel Corporation Device [8086:7a3a] (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 127
	IOMMU group: 12
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: 93600000-936fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1c.3 PCI bridge [0604]: Intel Corporation Device [8086:7a3b] (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 128
	IOMMU group: 13
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: 93300000-934fffff [size=2M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1c.4 PCI bridge [0604]: Intel Corporation Device [8086:7a3c] (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 129
	IOMMU group: 14
	Bus: primary=00, secondary=08, subordinate=71, sec-latency=0
	I/O behind bridge: 00005000-00007fff [size=12K]
	Memory behind bridge: 64000000-920fffff [size=737M]
	Prefetchable memory behind bridge: 0000006000000000-000000604a0fffff [size=1185M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1d.0 PCI bridge [0604]: Intel Corporation Device [8086:7a30] (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 130
	IOMMU group: 15
	Bus: primary=00, secondary=72, subordinate=72, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: 93500000-935fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:7a04] (rev 11)
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	IOMMU group: 16

00:1f.3 Audio device [0403]: Intel Corporation Device [8086:7a50] (rev 11)
	DeviceName: Intel HD Audio
	Subsystem: ASUSTeK Computer Inc. Device [1043:882a]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 231
	IOMMU group: 16
	Region 0: Memory at 604c120000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at 604c000000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: <access denied>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel, snd_sof_pci_intel_tgl

00:1f.4 SMBus [0c05]: Intel Corporation Device [8086:7a23] (rev 11)
	DeviceName: SMBus Controller
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 18
	IOMMU group: 16
	Region 0: Memory at 604c128000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at efa0 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

00:1f.5 Serial bus controller [0c80]: Intel Corporation Device [8086:7a24] (rev 11)
	Subsystem: ASUSTeK Computer Inc. Device [1043:8882]
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	IOMMU group: 16
	Region 0: Memory at 60800000 (32-bit, non-prefetchable) [size=4K]

01:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 NVMe Solid State Drive 1TB [1c5c:1285] (prog-if 02 [NVM Express])
	Subsystem: SK hynix PC300 NVMe Solid State Drive 1TB [1c5c:0000]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	NUMA node: 0
	IOMMU group: 17
	Region 0: Memory at 93800000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: nvme
	Kernel modules: nvme

04:00.0 Non-Volatile memory controller [0108]: Toshiba Corporation Device [1179:0116] (prog-if 02 [NVM Express])
	Subsystem: Toshiba Corporation Device [1179:0001]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	NUMA node: 0
	IOMMU group: 18
	Region 0: Memory at 93700000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: nvme
	Kernel modules: nvme

05:00.0 Ethernet controller [0200]: Aquantia Corp. Device [1d6a:94c0] (rev 03)
	DeviceName: Intel WiFi 6E AX210
	Subsystem: ASUSTeK Computer Inc. Device [1043:87f5]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 19
	Region 0: Memory at 92800000 (64-bit, non-prefetchable) [size=512K]
	Region 2: Memory at 928a0000 (64-bit, non-prefetchable) [size=4K]
	Region 4: Memory at 92400000 (64-bit, non-prefetchable) [size=4M]
	Expansion ROM at 92880000 [disabled] [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: atlantic
	Kernel modules: atlantic

06:00.0 Network controller [0280]: Intel Corporation Device [8086:2725] (rev 1a)
	Subsystem: Intel Corporation Device [8086:0024]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	IOMMU group: 20
	Region 0: Memory at 93600000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

07:00.0 Ethernet controller [0200]: Intel Corporation Device [8086:125c] (rev 06)
	DeviceName: Intel I226-V LAN
	Subsystem: ASUSTeK Computer Inc. Device [1043:8867]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 19
	IOMMU group: 21
	Region 0: Memory at 93300000 (32-bit, non-prefetchable) [size=1M]
	Region 3: Memory at 93400000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: igc
	Kernel modules: igc

08:00.0 PCI bridge [0604]: Intel Corporation Thunderbolt 4 Bridge [Maple Ridge 4C 2020] [8086:1136] (rev 02) (prog-if 00 [Normal decode])
	Physical Slot: 8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 131
	IOMMU group: 22
	Bus: primary=08, secondary=09, subordinate=71, sec-latency=0
	I/O behind bridge: 00005000-00006fff [size=8K]
	Memory behind bridge: 64000000-91efffff [size=735M]
	Prefetchable memory behind bridge: 0000006000000000-000000604a0fffff [size=1185M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

09:00.0 PCI bridge [0604]: Intel Corporation Thunderbolt 4 Bridge [Maple Ridge 4C 2020] [8086:1136] (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 132
	IOMMU group: 23
	Bus: primary=09, secondary=0a, subordinate=0a, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: [disabled]
	Prefetchable memory behind bridge: 000000604a000000-000000604a0fffff [size=1M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

09:01.0 PCI bridge [0604]: Intel Corporation Thunderbolt 4 Bridge [Maple Ridge 4C 2020] [8086:1136] (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 133
	IOMMU group: 24
	Bus: primary=09, secondary=0b, subordinate=3d, sec-latency=0
	I/O behind bridge: 00005000-00005fff [size=4K]
	Memory behind bridge: 7af00000-91dfffff [size=367M]
	Prefetchable memory behind bridge: 0000006025000000-0000006049ffffff [size=592M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

09:02.0 PCI bridge [0604]: Intel Corporation Thunderbolt 4 Bridge [Maple Ridge 4C 2020] [8086:1136] (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 134
	IOMMU group: 25
	Bus: primary=09, secondary=3e, subordinate=3e, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: 91e00000-91efffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

09:03.0 PCI bridge [0604]: Intel Corporation Thunderbolt 4 Bridge [Maple Ridge 4C 2020] [8086:1136] (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 135
	IOMMU group: 26
	Bus: primary=09, secondary=3f, subordinate=71, sec-latency=0
	I/O behind bridge: 00006000-00006fff [size=4K]
	Memory behind bridge: 64000000-7aefffff [size=367M]
	Prefetchable memory behind bridge: 0000006000000000-0000006024ffffff [size=592M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

0a:00.0 USB controller [0c03]: Intel Corporation Thunderbolt 4 NHI [Maple Ridge 4C 2020] [8086:1137] (prog-if 40 [USB4 Host Interface])
	Subsystem: ASUSTeK Computer Inc. Device [1043:87f6]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 27
	Region 0: Memory at 604a000000 (64-bit, prefetchable) [size=256K]
	Region 2: Memory at 604a040000 (64-bit, prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: thunderbolt
	Kernel modules: thunderbolt

3e:00.0 USB controller [0c03]: Intel Corporation Thunderbolt 4 USB Controller [Maple Ridge 4C 2020] [8086:1138] (prog-if 30 [XHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 211
	IOMMU group: 28
	Region 0: Memory at 91e00000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <access denied>
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

72:00.0 Network controller [0280]: Qualcomm Atheros AR9285 Wireless Network Adapter (PCI-Express) [168c:002b] (rev 01)
	Subsystem: Qualcomm Atheros AR9285 Wireless Network Adapter (PCI-Express) [168c:30a1]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 29
	Region 0: Memory at 93500000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <access denied>
	Kernel driver in use: ath9k
	Kernel modules: ath9k


** USB devices:
Bus 004 Device 007: ID 0b95:1790 ASIX Electronics Corp. AX88179 Gigabit Ethernet
Bus 004 Device 006: ID 0bda:0411 Realtek Semiconductor Corp. Hub
Bus 004 Device 005: ID 2109:0824 VIA Labs, Inc. USB3.1 Hub             Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 019: ID 8087:0032 Intel Corp. Bus 001 Device 038: ID 2109:8824 VIA Labs, Inc. USB Billboard Device   Bus 001 Device 032: ID 0bda:1100 Realtek Semiconductor Corp. HID Device
Bus 001 Device 029: ID 08bb:29c3 Texas Instruments PCM2903C Audio CODEC
Bus 001 Device 037: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port / Mobile Action MA-8910P
Bus 001 Device 036: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port / Mobile Action MA-8910P
Bus 001 Device 034: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port / Mobile Action MA-8910P
Bus 001 Device 031: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port / Mobile Action MA-8910P
Bus 001 Device 028: ID 0409:005a NEC Corp. HighSpeed Hub
Bus 001 Device 035: ID 0403:6015 Future Technology Devices International, Ltd Bridge(I2C/SPI/UART/FIFO)
Bus 001 Device 033: ID 0403:6001 Future Technology Devices International, Ltd FT232 Serial (UART) IC
Bus 001 Device 039: ID 051d:0002 American Power Conversion Uninterruptible Power Supply
Bus 001 Device 027: ID 1a40:0101 Terminus Technology Inc. Hub
Bus 001 Device 026: ID 0bda:5411 Realtek Semiconductor Corp. RTS5411 Hub
Bus 001 Device 025: ID 2109:2824 VIA Labs, Inc. USB2.0 Hub             Bus 001 Device 005: ID 0b05:19af ASUSTek Computer, Inc. AURA LED Controller
Bus 001 Device 003: ID 05e3:0608 Genesys Logic, Inc. Hub
Bus 001 Device 006: ID 0461:4d51 Primax Electronics, Ltd 0Y357C PMX-MMOCZUL (B) [Dell Laser Mouse]
Bus 001 Device 004: ID 413c:2011 Dell Computer Corp. Multimedia Pro Keyboard
Bus 001 Device 002: ID 413c:1005 Dell Computer Corp. Multimedia Pro Keyboard Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub


-- System Information:
Debian Release: 11.6
   APT prefers stable-security
   APT policy: (990, 'stable-security'), (990, 'stable'), (500, 'stable-updates'), (500, 'oldstable-updates'), (500, 'oldstable'), (200, 'unstable')
Architecture: amd64 (x86_64)
Foreign Architectures: i386

Kernel: Linux 6.0.0-0.deb11.6-amd64 (SMP w/32 CPU threads; PREEMPT)
Locale: LANG=C.UTF-8, LC_CTYPE=C.UTF-8 (charmap=UTF-8), LANGUAGE not set
Shell: /bin/sh linked to /bin/bash
Init: systemd (via /run/systemd/system)

Versions of packages linux-image-6.0.0-0.deb11.6-amd64 depends on:
ii  initramfs-tools [linux-initramfs-tool]  0.140
ii  kmod                                    28-1
ii  linux-base                              4.6

Versions of packages linux-image-6.0.0-0.deb11.6-amd64 recommends:
ii  apparmor             2.13.6-10
ii  firmware-linux-free  20200122-1

Versions of packages linux-image-6.0.0-0.deb11.6-amd64 suggests:
pn  debian-kernel-handbook  <none>
ii  grub-efi-amd64          2.06-3~deb11u5
pn  linux-doc-6.0           <none>

Versions of packages linux-image-6.0.0-0.deb11.6-amd64 is related to:
ii  firmware-amd-graphics     20221214-3
pn  firmware-atheros          <none>
pn  firmware-bnx2             <none>
pn  firmware-bnx2x            <none>
pn  firmware-brcm80211        <none>
pn  firmware-cavium           <none>
pn  firmware-intel-sound      <none>
pn  firmware-intelwimax       <none>
pn  firmware-ipw2x00          <none>
pn  firmware-ivtv             <none>
ii  firmware-iwlwifi          20221214-3
pn  firmware-libertas         <none>
ii  firmware-linux-nonfree    20221214-3
ii  firmware-misc-nonfree     20221214-3
pn  firmware-myricom          <none>
pn  firmware-netxen           <none>
pn  firmware-qlogic           <none>
ii  firmware-realtek          20210818-1~bpo11+1
pn  firmware-samsung          <none>
pn  firmware-siano            <none>
pn  firmware-ti-connectivity  <none>
pn  xen-hypervisor            <none>

-- no debconf information
