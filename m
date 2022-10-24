Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C8560B235
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Oct 2022 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiJXQoX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJXQnp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 12:43:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906BB647E1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 08:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D91BB81A97
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 13:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D09AC433D6;
        Mon, 24 Oct 2022 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666619663;
        bh=bwqPATfhA9ITtSQoko92JrBwkzgbni+rSAGqUyOweco=;
        h=Date:From:To:Cc:Subject:From;
        b=GXKjhxz21eFZP0ojjzaKVDgoqgtjwVJvCVmmkVJv9XwoDq9aF7XCDkex9uy2R/Q6e
         HPACg15gRJHvKKaQy5Fy2eJ+m9yafuVCuzt+BMuHbz6f4JbOhyU5/4JOzOUTU7RZh0
         Ol2DzlCxs42M3WL51ohOKl3CcJTG0m8y8c236MPUq0Drd+bOHKzOopSQzf7ub438zW
         PoDMedcYdVbFXPLHCOg56tUGbAotoYpi0xUP6Q22ADLEugXD1q4yBObg1IyNh3TSjg
         eNLU9OXQ91df1BaiQHRoGHbtcmc1YLoOzK5F0LKuQHROQb4AD4JISEhLmn2BdlKgVo
         DGFPENQrSsq8Q==
Date:   Mon, 24 Oct 2022 15:54:07 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: wilc1000 kernel crash
Message-ID: <20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm using the WILC1000 wifi chip in SDIO mode and with NetworkManager
which seems to be probing the network in the background. What I am
seeing is a kernel oops while processing the workqueue.

This is on a kernel 5.15.74, but it also happens with the latest next,
but not that often - I guess due to a different timing.

My reduced steps to reproduce are the following:
  $ while true; do ifconfig wlan0 up; iw dev wlan0 scan & \
      ifconfig wlan0 down; done

After a while I'll get the following splash:

[  487.955326] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  487.955363] Mem abort info:
[  487.955366]   ESR = 0x96000004
[  487.955370]   EC = 0x25: DABT (current EL), IL = 32 bits
[  487.965939] FW not responding
[  487.971033]   SET = 0, FnV = 0
[  487.971039]   EA = 0, S1PTW = 0
[  487.971043]   FSC = 0x04: level 0 translation fault
[  487.971047] Data abort info:
[  487.971050]   ISV = 0, ISS = 0x00000004
[  487.971053]   CM = 0, WnR = 0
[  487.971059] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000497b0000
[  487.971066] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  487.971085] Internal error: Oops: 96000004 [#1] SMP
[  487.971094] Modules linked in:
[  487.971104] CPU: 1 PID: 9 Comm: kworker/u8:0 Not tainted 5.15.74-00013-g2d5897cb12ef #130
[  487.971113] Hardware name: NXP i.MX8MNano DDR3L EVK board (DT)
[  487.971122] Workqueue: WILC_wq handle_rcvd_ntwrk_info
[  488.035377] wilc1000_sdio mmc1:0001:1: chipid (001003a0)
[  487.971085] Internal error: Oops:
[  488.041180] 96000004 [#1] SMP
[  488.041186] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  488.041196] pc : handle_rcvd_ntwrk_info+0x7c/0xc4
[  488.041208] lr : handle_rcvd_ntwrk_info+0x70/0xc4
[  488.049128] wilc1000_sdio mmc1:0001:1: has_thrpt_enh3 = 1...
[  488.057273] sp : ffff80000a20bd70
[  488.057277] x29: ffff80000a20bd70 x28: 0000000000000000 x27: 0000000000000000
[  488.057289] x26: ffff000000118470 x25: ffff000005059d05 x24: ffff00000de94d30
[  488.057299] x23: 0000000000000000
[  488.062670] wilc1000_sdio mmc1:0001:1 wlan0: ChipID [1003a0] loading firmware [atmel/wilc1000_wifi_firmware-1.bin]
[  488.070418]  x22: ffff000005059d00 x21: 0000000000000000
[  488.070428] x20: ffff00000de94d00 x19: ffff00000de94d28 x18: 0000000000000000
[  488.070440] x17: 0000000000000000 x16: 0000000000000000 x15: a4270000a4030001
[  488.070450] x14: 010102f2500018dd x13: 0018dd0000010002 x12: 0546000000000000
[  488.070461] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff800008ad92a0
[  488.150644] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffff0000063e88c0
[  488.157799] x5 : 0000000000000000 x4 : 0000000000000003 x3 : 0000000000000000
[  488.164947] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
[  488.172095] Call trace:
[  488.174548]  handle_rcvd_ntwrk_info+0x7c/0xc4
[  488.175400] FW not responding
[  488.178927]  process_one_work+0x1ec/0x48c
[  488.178941]  worker_thread+0x170/0x564
[  488.178948]  kthread+0x128/0x13c
[  488.178959]  ret_from_fork+0x10/0x20
[  488.185280] FW not responding
[  488.185958] Code: 9415ea8e b4000060 39400401 35000201 (f94002a3)
[  488.192042] FW not responding
[  488.192957] ---[ end trace fa915dc840cf0355 ]---
[  488.199700] FW not responding
[  488.205601] Kernel panic - not syncing: Oops: Fatal exception
[  488.205608] SMP: stopping secondary CPUs
[  488.205630] Kernel Offset: disabled
[  488.205634] CPU features: 0x00002001,20000846
[  488.205642] Memory Limit: none

In handle_rcvd_ntwrk_info() scan_req->scan_result isn't valid anymore,
although it doesn't contain NULL. Thus the driver is calling into a
bogus function pointer. There seems to be no locking between the
asynchronous calls within the workqueue (wilc_enqueue_work()) and when
the interface is disabled (wilc_deinit()). wilc_deinit() will free the
host_if_drv object which might still be used within the workqueue
context.

BTW, ignore the "FW not repsonding" for now, that seems to be a
different problem.

-michael
