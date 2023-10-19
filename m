Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14247CF63F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 13:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345297AbjJSLKg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 07:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345272AbjJSLKe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 07:10:34 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 04:10:27 PDT
Received: from vsp-unauthed02.binero.net (vsp-unauthed02.binero.net [195.74.38.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743A0136
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 04:10:27 -0700 (PDT)
X-Halon-ID: f373bc5d-6e6f-11ee-a08a-c7501c22f7f2
Authorized-sender: petter@technux.se
Received: from localhost.localdomain (user33.85-195-12.netatonce.net [85.195.12.33])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPSA
        id f373bc5d-6e6f-11ee-a08a-c7501c22f7f2;
        Thu, 19 Oct 2023 13:09:20 +0200 (CEST)
From:   petter@technux.se
To:     pkshih@realtek.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        timlee@realtek.com
Subject: rtw88: rtw8822cu (LM842): Firmware coredump when completely stalls
Date:   Thu, 19 Oct 2023 13:09:18 +0200
Message-ID: <20231019110919.16265-1-petter@technux.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

I still have som issues from time-to-time with the LM842 dongle in my i.MX6 SoloX board. So I started to play around with the firware dump mechanism that Ping-Ke Shih sent up in https://lore.kernel.org/linux-wireless/20231016053554.744180-1-pkshih@realtek.com/T/#t . Here are some dumps that I recieved, please let me know if you can make something out of these dumps and also if you want me to test something else, since I have a fairly easy way to make the driver stall.

BR Petter

First example is from "firmware failed to leave lps state"

```
[ 2142.913945] rtw_8822cu 2-1:1.2: send H2C content 01000020 00000c00
[ 2143.021858] rtw_8822cu 2-1:1.2: firmware failed to leave lps state
[ 2143.021858] rtw_8822cu 2-1:1.2: firmware failed to leave lps state
[ 2143.029669] rtw_8822cu 2-1:1.2: recv C2H, id=0x32, seq=0x59, len=2
[ 2143.080035] rtw_8822cu 2-1:1.2: [FWIMR]addr:0x130 mask:0xffffffff value:0x3f2
[ 2143.080710] rtw_8822cu 2-1:1.2: [FWIMR enable]addr:0x130 mask:0x10 value:0x1
[ 2143.080948] rtw_8822cu 2-1:1.2: [FWISR]addr:0x134 mask:0xffffffff value:0x800d
[ 2143.081190] rtw_8822cu 2-1:1.2: [FWISR enable]addr:0x134 mask:0x10 value:0x0
[ 2143.081954] rtw_8822cu 2-1:1.2: [BoxBitMap]addr:0x1cc mask:0xf value:0x0
[ 2143.082473] rtw_8822cu 2-1:1.2: [MSG 0]addr:0x1d0 mask:0xffffffff value:0x31105a
[ 2143.083307] rtw_8822cu 2-1:1.2: [MSG_EX 0]addr:0x1f0 mask:0xffffffff value:0x10
[ 2143.084667] rtw_8822cu 2-1:1.2: [MSG 1]addr:0x1d4 mask:0xffffffff value:0x1210120
[ 2143.084972] rtw_8822cu 2-1:1.2: [MSG_EX 1]addr:0x1f4 mask:0xffffffff value:0x0
[ 2143.086676] rtw_8822cu 2-1:1.2: [MSG 2]addr:0x1d8 mask:0xffffffff value:0x1000020
[ 2143.086968] rtw_8822cu 2-1:1.2: [MSG_EX 2]addr:0x1f8 mask:0xffffffff value:0xc00
[ 2143.087195] rtw_8822cu 2-1:1.2: [MSG 3]addr:0x1dc mask:0xffffffff value:0x5e890040
[ 2143.087449] rtw_8822cu 2-1:1.2: [MSG_EX 3]addr:0x1fc mask:0xffffffff value:0xffff0000
[ 2143.087694] rtw_8822cu 2-1:1.2: [FT1IMR]addr:0x1138 mask:0xffffffff value:0x3007001
[ 2143.087943] rtw_8822cu 2-1:1.2: [FT1IMR enable]addr:0x1138 mask:0x2000000 value:0x1
[ 2143.088197] rtw_8822cu 2-1:1.2: [FT1ISR]addr:0x113c mask:0xffffffff value:0x20000010
[ 2143.088457] rtw_8822cu 2-1:1.2: [FT1ISR enable ]addr:0x113c mask:0x2000000 value:0x0
[ 2143.088701] rtw_8822cu 2-1:1.2: [FWIMR]addr:0x130 mask:0xffffffff value:0x3f2
[ 2143.090921] rtw_8822cu 2-1:1.2: [CPWM]addr:0x130 mask:0x10 value:0x1
[ 2143.091225] rtw_8822cu 2-1:1.2: [HRECV]addr:0x130 mask:0x20 value:0x1
[ 2143.091444] rtw_8822cu 2-1:1.2: [FWISR]addr:0x134 mask:0xffffffff value:0x800d
[ 2143.091695] rtw_8822cu 2-1:1.2: [CPWM]addr:0x134 mask:0x10 value:0x0
[ 2143.091983] rtw_8822cu 2-1:1.2: [HRECV]addr:0x134 mask:0x20 value:0x0
[ 2143.092189] rtw_8822cu 2-1:1.2: [REG_CPWM]addr:0x12c mask:0xffffffff value:0x0
[ 2143.092223] rtw_8822cu 2-1:1.2: Firmware Coredump 1th
[ 2143.092450] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[ 2143.092699] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[ 2143.092958] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[ 2143.093203] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[ 2143.123043] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[ 2143.138905] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[ 2143.155697] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[ 2143.156357] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[ 2143.157648] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035719
[ 2143.157688] rtw_8822cu 2-1:1.2: Firmware Coredump 2th
[ 2143.158428] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[ 2143.159786] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[ 2143.161341] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[ 2143.168254] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[ 2143.170935] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[ 2143.171885] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[ 2143.172797] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[ 2143.173142] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[ 2143.173628] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035719
[ 2143.173666] rtw_8822cu 2-1:1.2: Firmware Coredump 3th
[ 2143.177613] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[ 2143.178445] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[ 2143.184995] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[ 2143.185559] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[ 2143.186920] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[ 2143.190744] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[ 2143.199410] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[ 2143.199820] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[ 2143.200595] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035361
[ 2143.200632] rtw_8822cu 2-1:1.2: Firmware Coredump 4th
[ 2143.202113] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[ 2143.205319] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[ 2143.205575] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[ 2143.206947] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[ 2143.207260] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[ 2143.207873] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[ 2143.208096] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[ 2143.208319] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[ 2143.208780] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035361
[ 2143.208821] rtw_8822cu 2-1:1.2: Firmware Coredump 5th
[ 2143.211747] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[ 2143.211995] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[ 2143.212614] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[ 2143.213110] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[ 2143.213318] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[ 2143.213921] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[ 2143.215329] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[ 2143.216028] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[ 2143.218264] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035361
[ 2143.218310] rtw_8822cu 2-1:1.2: Firmware Coredump 6th
[ 2143.221352] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[ 2143.221860] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[ 2143.223384] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[ 2143.224037] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[ 2143.224832] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[ 2143.225433] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[ 2143.226344] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[ 2143.226599] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[ 2143.226822] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x8003b0b6
[ 2143.226856] rtw_8822cu 2-1:1.2: Firmware Coredump 7th
[ 2143.227459] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[ 2143.227689] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[ 2143.229262] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[ 2143.230380] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[ 2143.232053] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[ 2143.232828] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[ 2143.234845] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[ 2143.240100] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[ 2143.240586] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x800353de
[ 2143.240624] rtw_8822cu 2-1:1.2: Firmware Coredump 8th
[ 2143.249508] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[ 2143.250089] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[ 2143.250458] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[ 2143.250699] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[ 2143.250982] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[ 2143.253146] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[ 2143.253748] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[ 2143.255321] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[ 2143.255602] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035719
[ 2143.255636] rtw_8822cu 2-1:1.2: Firmware Coredump 9th
[ 2143.256406] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[ 2143.257203] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[ 2143.257818] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[ 2143.258752] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[ 2143.260078] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[ 2143.260330] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[ 2143.260851] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[ 2143.261069] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[ 2143.261323] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x8003b0b6
[ 2143.261357] rtw_8822cu 2-1:1.2: Firmware Coredump 10th
[ 2143.261591] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[ 2143.261815] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[ 2143.262695] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[ 2143.262966] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[ 2143.263651] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[ 2143.264752] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[ 2143.265964] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[ 2143.266580] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[ 2143.267504] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x8003b4e5
[ 2143.268058] rtw_8822cu 2-1:1.2: send H2C content 00000161 00000000
[ 2143.282646] rtw_8822cu 2-1:1.2: recv C2H, id=0x0c, seq=0x5a, len=8
[ 2143.296266] rtw_8822cu 2-1:1.2: send H2C content 33000042 00000002
[ 2143.314119] rtw_8822cu 2-1:1.2: send H2C content 00000058 001a3b35
[ 2143.328452] rtw_8822cu 2-1:1.2: recv C2H, id=0x0c, seq=0x5b, len=8
```

Second crash is when I tried to extend the driver with a firmware dump, when I got stuck in "failed to get tx report from firmware" (since this is the most common place the driver stalls for me). However it seems like I got some lock dep issue while doing it, but hopefully the below firmware dump can show something interesting at least..

I used:

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 2821119dc930..0a8ed53c1982 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -181,6 +181,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
                return;
 
        rtw_warn(rtwdev, "failed to get tx report from firmware\n");
+       rtw_fw_dump_dbg_info(rtwdev);
 
        spin_lock_irqsave(&tx_report->q_lock, flags);
        skb_queue_purge(&tx_report->queue);


Crash and dump:

[  434.561466] rtw_8822cu 2-1:1.2: failed to get tx report from firmware
[  434.572433] BUG: scheduling while atomic: ksoftirqd/0/13/0x00000101
[  434.579230] 1 lock held by ksoftirqd/0/13:
[  434.583762]  #0: f0865e70 ((&rtwdev->tx_report.purge_timer)){+.-.}-{0:0}, at: call_timer_fn+0x0/0x304
[  434.593904] Modules linked in: rtw88_8822cu rtw88_8822c rtw88_usb rtw88_core btusb btrtl btbcm btintel btmtk imx_sdma ip_tables x_tables
[  434.607571] CPU: 0 PID: 13 Comm: ksoftirqd/0 Not tainted 6.4.16-edge-g4a17f23ed16a #28
[  434.615632] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[  434.621574]  unwind_backtrace from show_stack+0x10/0x14
[  434.626984]  show_stack from dump_stack_lvl+0x58/0x70
[  434.632196]  dump_stack_lvl from __schedule_bug+0x64/0x84
[  434.637773]  __schedule_bug from __schedule+0x904/0xc00
[  434.643164]  __schedule from schedule+0x60/0xbc
[  434.647848]  schedule from schedule_timeout+0x78/0xfc
[  434.653075]  schedule_timeout from do_wait_for_common+0x84/0x138
[  434.659255]  do_wait_for_common from wait_for_completion_timeout+0x2c/0x44
[  434.666294]  wait_for_completion_timeout from usb_start_wait_urb+0x6c/0xe8
[  434.673348]  usb_start_wait_urb from usb_control_msg+0xb0/0x11c
[  434.679426]  usb_control_msg from rtw_usb_read+0x8c/0xe4 [rtw88_usb]
[  434.686304]  rtw_usb_read [rtw88_usb] from rtw_fw_dump_dbg_info+0x68/0x1f8 [rtw88_core]
[  434.695338]  rtw_fw_dump_dbg_info [rtw88_core] from call_timer_fn+0xb4/0x304
[  434.703240]  call_timer_fn from expire_timers+0xb4/0x10c
[  434.708683]  expire_timers from run_timer_softirq+0xf8/0x2a8
[  434.714469]  run_timer_softirq from __do_softirq+0x164/0x5a4
[  434.720270]  __do_softirq from run_ksoftirqd+0x38/0x50
[  434.725566]  run_ksoftirqd from smpboot_thread_fn+0x110/0x230
[  434.731455]  smpboot_thread_fn from kthread+0xfc/0x130
[  434.736720]  kthread from ret_from_fork+0x14/0x24
[  434.741545] Exception stack(0xf0865fb0 to 0xf0865ff8)
[  434.746702] 5fa0:                                     00000000 00000000 00000000 00000000
[  434.754990] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  434.763270] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  434.834834] NOHZ tick-stop error: local softirq work is pending, handler #202!!!
[  434.870045] 
[  434.871582] ================================
[  434.875871] WARNING: inconsistent lock state
[  434.880160] 6.4.16-edge-g4a17f23ed16a #28 Tainted: G        W         
[  434.886710] --------------------------------
[  434.890996] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[  434.897023] ksoftirqd/0/13 [HC0[0]:SC1[0]:HE0:SE1] takes:
[  434.902453] f0865e70 ((&rtwdev->tx_report.purge_timer)){+.?.}-{0:0}, at: call_timer_fn+0x0/0x304
[  434.911332] {IN-SOFTIRQ-W} state was registered at:
[  434.916229]   lock_acquire.part.0+0xd0/0x27c
[  434.920536]   call_timer_fn+0x7c/0x304
[  434.924310]   expire_timers+0xb4/0x10c
[  434.928086]   run_timer_softirq+0xf8/0x2a8
[  434.932209]   __do_softirq+0x164/0x5a4
[  434.935994]   __irq_exit_rcu+0x144/0x1b4
[  434.939959]   irq_exit+0x8/0x28
[  434.943134]   call_with_stack+0x18/0x20
[  434.947012]   __irq_svc+0x9c/0xd4
[  434.950355]   __local_bh_disable_ip+0x0/0x94
[  434.954661]   0x1
[  434.956609] irq event stamp: 453198
[  434.960114] hardirqs last  enabled at (453196): [<c0e22680>] _raw_spin_unlock_irq+0x20/0x50
[  434.968501] hardirqs last disabled at (453197): [<c0101950>] __do_softirq+0x400/0x5a4
[  434.976365] softirqs last  enabled at (453198): [<c0101808>] __do_softirq+0x2b8/0x5a4
[  434.984226] softirqs last disabled at (452109): [<c012edb4>] run_ksoftirqd+0x38/0x50
[  434.992010] 
[  434.992010] other info that might help us debug this:
[  434.998555]  Possible unsafe locking scenario:
[  434.998555] 
[  435.004487]        CPU0
[  435.006947]        ----
[  435.009407]   lock((&rtwdev->tx_report.purge_timer));
[  435.014493]   <Interrupt>
[  435.017126]     lock((&rtwdev->tx_report.purge_timer));
[  435.022384] 
[  435.022384]  *** DEADLOCK ***
[  435.022384] 
[  435.028317] 1 lock held by ksoftirqd/0/13:
[  435.032436]  #0: f0865e70 ((&rtwdev->tx_report.purge_timer)){+.?.}-{0:0}, at: call_timer_fn+0x0/0x304
[  435.041741] 
[  435.041741] stack backtrace:
[  435.046118] CPU: 0 PID: 13 Comm: ksoftirqd/0 Tainted: G        W          6.4.16-edge-g4a17f23ed16a #28
[  435.055541] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[  435.061400]  unwind_backtrace from show_stack+0x10/0x14
[  435.066686]  show_stack from dump_stack_lvl+0x58/0x70
[  435.071788]  dump_stack_lvl from mark_lock.part.0+0x6f8/0x940
[  435.077577]  mark_lock.part.0 from mark_held_locks+0x4c/0x78
[  435.083269]  mark_held_locks from lockdep_hardirqs_on_prepare+0x1fc/0x2bc
[  435.090091]  lockdep_hardirqs_on_prepare from trace_hardirqs_on+0x7c/0x118
[  435.097026]  trace_hardirqs_on from preempt_schedule_irq+0x34/0x78
[  435.103266]  preempt_schedule_irq from svc_preempt+0x8/0x18
[  435.108884] Exception stack(0xf0865d18 to 0xf0865d60)
[  435.113963] 5d00:                                                       a0060113 ef7d85cc
[  435.122172] 5d20: f0865d68 ef7d85c8 c2001100 00000c00 00000008 ffffffff c5bb87c0 2e343000
[  435.130378] 5d40: 001b6b74 c50319a8 001b6b78 f0865d68 c5bb8f40 c02dc1d8 60060113 ffffffff
[  435.138574]  svc_preempt from __kmem_cache_alloc_node+0xdc/0x1fc
[  435.144647]  __kmem_cache_alloc_node from kmalloc_trace+0x28/0x58
[  435.150808]  kmalloc_trace from usb_control_msg+0x4c/0x11c
[  435.156355]  usb_control_msg from rtw_usb_read+0x8c/0xe4 [rtw88_usb]
[  435.162796]  rtw_usb_read [rtw88_usb] from rtw_fw_dump_dbg_info+0x180/0x1f8 [rtw88_core]
[  435.171349]  rtw_fw_dump_dbg_info [rtw88_core] from call_timer_fn+0xb4/0x304
[  435.178775]  call_timer_fn from expire_timers+0xb4/0x10c
[  435.184125]  expire_timers from run_timer_softirq+0xf8/0x2a8
[  435.189819]  run_timer_softirq from __do_softirq+0x164/0x5a4
[  435.195525]  __do_softirq from run_ksoftirqd+0x38/0x50
[  435.200721]  run_ksoftirqd from smpboot_thread_fn+0x110/0x230
[  435.206515]  smpboot_thread_fn from kthread+0xfc/0x130
[  435.211690]  kthread from ret_from_fork+0x14/0x24
[  435.216427] Exception stack(0xf0865fb0 to 0xf0865ff8)
[  435.221505] 5fa0:                                     00000000 00000000 00000000 00000000
[  435.229709] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  435.237910] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  435.377118] NOHZ tick-stop error: local softirq work is pending, handler #20a!!!
[  435.386154] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[  435.393642] NOHZ tick-stop error: local softirq work is pending, handler #200!!!
[  435.404920] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035361
[  435.413025] rtw_8822cu 2-1:1.2: Firmware Coredump 2th
[  435.418250] NOHZ tick-stop error: local softirq work is pending, handler #200!!!
[  435.431619] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[  435.444677] NOHZ tick-stop error: local softirq work is pending, handler #202!!!
[  435.457401] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[  435.468129] NOHZ tick-stop error: local softirq work is pending, handler #200!!!
[  435.476542] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[  435.485320] NOHZ tick-stop error: local softirq work is pending, handler #240!!!
[  435.499722] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[  435.506903] NOHZ tick-stop error: local softirq work is pending, handler #20a!!!
[  435.517964] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[  435.525425] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[  435.538228] NOHZ tick-stop error: local softirq work is pending, handler #202!!!
[  435.546141] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[  435.565577] NOHZ tick-stop error: local softirq work is pending, handler #202!!!
[  435.573872] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[  435.585584] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x8003b081
[  435.596143] rtw_8822cu 2-1:1.2: Firmware Coredump 3th
[  435.604481] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[  435.614471] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[  435.624838] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[  435.635091] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[  435.645213] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[  435.660719] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[  435.671340] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[  435.682145] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[  435.690769] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035361
[  435.704471] rtw_8822cu 2-1:1.2: Firmware Coredump 4th
[  435.710090] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[  435.721281] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[  435.733284] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[  435.740695] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[  435.751204] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[  435.766380] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[  435.776840] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[  435.787965] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[  435.799424] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035719
[  435.810139] rtw_8822cu 2-1:1.2: Firmware Coredump 5th
[  435.818324] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[  435.828223] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[  435.838603] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[  435.848721] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[  435.864101] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[  435.874337] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[  435.885255] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[  435.896299] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[  435.912059] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x800353dd
[  435.919817] rtw_8822cu 2-1:1.2: Firmware Coredump 6th
[  435.931236] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[  435.938416] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[  435.951197] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[  435.965189] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[  435.972335] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[  435.979659] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[  435.991392] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[  436.007586] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[  436.017964] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035719
[  436.028543] rtw_8822cu 2-1:1.2: Firmware Coredump 7th
[  436.036849] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[  436.046834] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[  436.057219] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[  436.071862] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[  436.078880] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[  436.091778] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[  436.103571] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[  436.114083] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[  436.124351] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035719
[  436.135034] rtw_8822cu 2-1:1.2: Firmware Coredump 8th
[  436.140454] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[  436.151257] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[  436.163542] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[  436.173834] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[  436.186507] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[  436.194191] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[  436.207935] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[  436.218455] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[  436.229218] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035719
[  436.240038] rtw_8822cu 2-1:1.2: send H2C content 36000042 00000002
[  436.249332] rtw_8822cu 2-1:1.2: Firmware Coredump 9th
[  436.255759] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[  436.268427] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[  436.285763] rtw_8822cu 2-1:1.2: send H2C content 00000058 0005043c
[  436.299496] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[  436.314550] rtw_8822cu 2-1:1.2: send H2C content 0036105a 0000000c
[  436.320872] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[  436.334682] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[  436.342424] rtw_8822cu 2-1:1.2: recv C2H, id=0x37, seq=0x30, len=6
[  436.357061] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[  436.367583] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[  436.381713] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[  436.389032] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x8003b0b6
[  436.401032] rtw_8822cu 2-1:1.2: Firmware Coredump 10th
[  436.411824] rtw_8822cu 2-1:1.2: [EPC]addr:0x48c mask:0xffffffff value:0x0
[  436.422567] rtw_8822cu 2-1:1.2: [BADADDR]addr:0x490 mask:0xffffffff value:0x0
[  436.430584] rtw_8822cu 2-1:1.2: [CAUSE]addr:0x494 mask:0xffffffff value:0x0
[  436.444196] rtw_8822cu 2-1:1.2: [ExcCode]addr:0x494 mask:0x7c value:0x0
[  436.454699] rtw_8822cu 2-1:1.2: [Status]addr:0x498 mask:0xffffffff value:0x0
[  436.465462] rtw_8822cu 2-1:1.2: [SP]addr:0x49c mask:0xffffffff value:0x600f010
[  436.480468] rtw_8822cu 2-1:1.2: [RA]addr:0x4a0 mask:0xffffffff value:0x400003e0
[  436.491757] rtw_8822cu 2-1:1.2: [DBG 6]addr:0x10f8 mask:0xffffffff value:0x0
[  436.499299] rtw_8822cu 2-1:1.2: [DBG 7]addr:0x10fc mask:0xffffffff value:0x80035362
[  436.511011] ------------[ cut here ]------------
[  436.515817] WARNING: CPU: 0 PID: 13 at kernel/time/timer.c:1706 call_timer_fn+0x2d4/0x3
```
