Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097747B24FA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 20:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjI1SMb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 14:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjI1SMa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 14:12:30 -0400
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 11:12:26 PDT
Received: from lisa.dawes.za.net (lisa.dawes.za.net [178.63.77.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 788F319D
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 11:12:26 -0700 (PDT)
Received: by lisa.dawes.za.net (Postfix, from userid 1000)
        id 3F76B146BFA; Thu, 28 Sep 2023 20:03:28 +0200 (SAST)
Date:   Thu, 28 Sep 2023 20:03:28 +0200
From:   Rogan Dawes <rogan@dawes.za.net>
To:     linux-wireless@vger.kernel.org
Subject: Panic with brcmfmac on Wink Hub v1 (near mainline port)
Message-ID: <20230928180328.GA21844@lisa.dawes.za.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi folks,

I am trying to get mainline Linux running on my Wink Hub v1 (imx28 with
Broadcom 4334 via SDIO). I am using the nvram.conf that the vendor shipped
with back in 2014, and brcmfmac driver.

I experienced the below panics at some point during the night, printed to
the serial console. The device was idle, but obviously receiving broadcast
traffic from the rest of the network. This is a near mainline kernel,
running an OpenWrt mainline userland. The interface is configured as a
station to my AP.

# iw dev phy0-sta0 info
Interface phy0-sta0
ifindex 2
wdev 0x1
addr 34:23:ba:eb:14:5f
ssid Dawes
type managed
wiphy 0
channel 1 (2412 MHz), width: 20 MHz, center1: 2412 MHz
txpower 31.00 dBm
#

I know absolutely nothing about WiFi drivers, so would need to be walked
through collecting any information that will help to fix this.

# iw dev phy0-sta0 info
Interface phy0-sta0
ifindex 2
wdev 0x1
addr 34:23:ba:eb:14:5f
ssid Dawes
type managed
wiphy 0
channel 1 (2412 MHz), width: 20 MHz, center1: 2412 MHz
txpower 31.00 dBm

FWIW, the performance of the WiFi interface is pretty poor. It seems to
hang periodically, and when it is running, the best throughput I get is
around 1.4MB/s copying an unpacked tarball from a local computer to
/dev/null over wifi. This does seem to be a problem with the vendor kernel
as well, as I have seen comments to the effect of "Poke the wifi interface
to keep it awake" while reviewing their firmware update scripts! FWIW, the
vendor firmware constrains the radio to only connect to 2.4GHz AP's, even
though it is apparently 5GHz capable too.

Please let me know if I can provide any more information.

Regards,

Rogan


--8x-- vendor nvram.conf ------
# SWB-B53_B1_R04_eLNA 10/21/2011

manfid=0x2d0
prodid=0x05c1
vendid=0x14e4
devid=0x4380
boardtype=0x05de
boardrev=0x1105
boardnum=22
macaddr=00:90:4c:c5:12:38
sromrev=0

boardflags=0x10081a00
xtalfreq=37400
nocrc=1
ag0=255
aa2g=1
ccode=ALL
pa0itssit=0x20

#PA parameters for 2.4GHz (0x15A7,0xFD54,0xFF4A)
pa0b0=0x19B7
pa0b1=0xFD2A
pa0b2=0xFF7B
extpagain2g=2
extpagain5g=2

# rssi params for 2.4GHz
rssismf2g=0x2
rssismc2g=0x7
rssisav2g=0x1
cckPwrOffset=0

# rssi params for 5GHz
rssismf5g=0x8
rssismc5g=0x8
rssisav5g=0x1


#PA parameters for lower a-band
pa1lob0=5516
pa1lob1=-680
pa1lob2=-182
#PA parameters for midband
pa1b0=5560
pa1b1=-683
pa1b2=-178
#PA paramasdeters for high band
pa1hib0=5438
pa1hib1=-681
pa1hib2=-193
rxpo5g=0


maxp2ga0=66
ofdm2gpo=0x22222222
mcs2gpo0=0x4444
mcs2gpo1=0x4444

maxp5ga0=0x4a
maxp5gla0=0x4a
maxp5gha0=0x4a
ofdm5gpo=0x66666666
ofdm5glpo=0x66666666
ofdm5ghpo=0x66666666
mcs5gpo0=0x8888
mcs5gpo1=0x8888
mcs5glpo0=0x8888
mcs5glpo1=0x8888
mcs5ghpo0=0x8888
mcs5ghpo1=0x8888

#il0macaddr=00:90:4c:c5:12:38
wl0id=0x431b
pagc2g=0x10
#dacgc2g=4
txalpfbyp=1

#For SEMCO B53-R04-eLNA Module
swctrlmap_2g=0x0c0c0c0c,0x12121212,0x02020202,0x11202,0x1ff
swctrlmap_5g=0x40404040,0x20202020,0x20202020,0x12202,0x2f8

gain=32
triso2g=12
triso5g=8

hostwake=0x40
hostrdy=0x41
usbrdy=0x03
usbrdydelay=100
deadman_to=0xffffffff
muxenab=0x1

tssioffsetmax=27

PwrOffset40mhz2g=0
PwrOffset40mhz5g=-8

tssioffsetmax5gl=21
tssioffsetmax5gm=23
tssioffsetmax5gh=20
--8x-- vendor nvram.conf ------

[13591.698109] ------------[ cut here ]------------
[13591.703529] WARNING: CPU: 0 PID: 6 at net/wireless/sme.c:839
__cfg80211_connect_result+0x68c/0x700
[13591.713058] Modules linked in: g_mass_storage usb_f_mass_storage g_ether
usb_f_rndis brcmfmac brcmutil usb_f_ecm u_ether libcomposite configfs
[13591.726764] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted
6.1.35-00014-g7e67972bd0c9-dirty #4
[13591.735338] Hardware name: Freescale MXS (Device Tree)
[13591.740567] Workqueue: cfg80211 cfg80211_event_work
[13591.745651]  unwind_backtrace from show_stack+0x10/0x14
[13591.751056]  show_stack from dump_stack_lvl+0x38/0x4c
[13591.756248]  dump_stack_lvl from __warn+0x78/0x134
[13591.761190]  __warn from warn_slowpath_fmt+0x74/0xac
[13591.766308]  warn_slowpath_fmt from __cfg80211_connect_result+0x68c/0x700
[13591.773254]  __cfg80211_connect_result from
cfg80211_process_wdev_events+0xf8/0x158
[13591.781064]  cfg80211_process_wdev_events from
cfg80211_process_rdev_events+0x30/0x78
[13591.789023]  cfg80211_process_rdev_events from
cfg80211_event_work+0x20/0x2c
[13591.796223]  cfg80211_event_work from process_one_work+0x240/0x5d4
[13591.802541]  process_one_work from worker_thread+0x30/0x4b8
[13591.808225]  worker_thread from kthread+0xd8/0xfc
[13591.813072]  kthread from ret_from_fork+0x14/0x3c
[13591.817905] Exception stack(0xc482dfb0 to 0xc482dff8)
[13591.823051] dfa0:                                     00000000 00000000
00000000 00000000
[13591.831321] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
[13591.839586] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[13591.846593] irq event stamp: 2983
[13591.850247] hardirqs last  enabled at (2993): [<c006a204>]
__up_console_sem+0x54/0x64
[13591.858465] hardirqs last disabled at (3002): [<c006a1f0>]
__up_console_sem+0x40/0x64
[13591.866467] softirqs last  enabled at (2884): [<c07ad5d8>]
cfg80211_get_bss+0x254/0x2fc
[13591.874860] softirqs last disabled at (2834): [<c07ad3d8>]
cfg80211_get_bss+0x54/0x2fc
[13591.883180] ---[ end trace 0000000000000000 ]---
[13595.798665] ------------[ cut here ]------------
[13595.803445] WARNING: CPU: 0 PID: 6 at net/wireless/sme.c:1074
__cfg80211_roamed+0x30c/0x334
[13595.812471] Modules linked in: g_mass_storage usb_f_mass_storage g_ether
usb_f_rndis brcmfmac brcmutil usb_f_ecm u_ether libcomposite configfs
[13595.826184] CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G        W
 6.1.35-00014-g7e67972bd0c9-dirty #4
[13595.836235] Hardware name: Freescale MXS (Device Tree)
[13595.841467] Workqueue: cfg80211 cfg80211_event_work
[13595.846547]  unwind_backtrace from show_stack+0x10/0x14
[13595.851948]  show_stack from dump_stack_lvl+0x38/0x4c
[13595.857141]  dump_stack_lvl from __warn+0x78/0x134
[13595.862084]  __warn from warn_slowpath_fmt+0x74/0xac
[13595.867189]  warn_slowpath_fmt from __cfg80211_roamed+0x30c/0x334
[13595.873444]  __cfg80211_roamed from
cfg80211_process_wdev_events+0xdc/0x158
[13595.880557]  cfg80211_process_wdev_events from
cfg80211_process_rdev_events+0x30/0x78
[13595.888512]  cfg80211_process_rdev_events from
cfg80211_event_work+0x20/0x2c
[13595.895712]  cfg80211_event_work from process_one_work+0x240/0x5d4
[13595.902034]  process_one_work from worker_thread+0x30/0x4b8
[13595.907722]  worker_thread from kthread+0xd8/0xfc
[13595.912567]  kthread from ret_from_fork+0x14/0x3c
[13595.917396] Exception stack(0xc482dfb0 to 0xc482dff8)
[13595.922544] dfa0:                                     00000000 00000000
00000000 00000000
[13595.930814] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
[13595.939079] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[13595.946201] irq event stamp: 3183
[13595.949858] hardirqs last  enabled at (3193): [<c006a204>]
__up_console_sem+0x54/0x64
[13595.958158] hardirqs last disabled at (3214): [<c006a1f0>]
__up_console_sem+0x40/0x64
[13595.966168] softirqs last  enabled at (3212): [<c00097a4>]
__do_softirq+0x234/0x3fc
[13595.974197] softirqs last disabled at (3201): [<c001ff10>]
__irq_exit_rcu+0x15c/0x1bc
[13595.982561] ---[ end trace 0000000000000000 ]---
[13744.581391] ------------[ cut here ]------------
[13744.586286] WARNING: CPU: 0 PID: 6 at net/wireless/sme.c:839
__cfg80211_connect_result+0x68c/0x700
[13744.595797] Modules linked in: g_mass_storage usb_f_mass_storage g_ether
usb_f_rndis brcmfmac brcmutil usb_f_ecm u_ether libcomposite configfs
[13744.609498] CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G        W
 6.1.35-00014-g7e67972bd0c9-dirty #4
[13744.619549] Hardware name: Freescale MXS (Device Tree)
[13744.624779] Workqueue: cfg80211 cfg80211_event_work
[13744.629855]  unwind_backtrace from show_stack+0x10/0x14
[13744.635259]  show_stack from dump_stack_lvl+0x38/0x4c
[13744.640452]  dump_stack_lvl from __warn+0x78/0x134
[13744.645399]  __warn from warn_slowpath_fmt+0x74/0xac
[13744.650508]  warn_slowpath_fmt from __cfg80211_connect_result+0x68c/0x700
[13744.657456]  __cfg80211_connect_result from
cfg80211_process_wdev_events+0xf8/0x158
[13744.665265]  cfg80211_process_wdev_events from
cfg80211_process_rdev_events+0x30/0x78
[13744.673221]  cfg80211_process_rdev_events from
cfg80211_event_work+0x20/0x2c
[13744.680420]  cfg80211_event_work from process_one_work+0x240/0x5d4
[13744.686738]  process_one_work from worker_thread+0x30/0x4b8
[13744.692428]  worker_thread from kthread+0xd8/0xfc
[13744.697272]  kthread from ret_from_fork+0x14/0x3c
[13744.702100] Exception stack(0xc482dfb0 to 0xc482dff8)
[13744.707245] dfa0:                                     00000000 00000000
00000000 00000000
[13744.715515] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
[13744.723779] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[13744.730745] irq event stamp: 3809
[13744.734201] hardirqs last  enabled at (3817): [<c006a204>]
__up_console_sem+0x54/0x64
[13744.742423] hardirqs last disabled at (3826): [<c006a1f0>]
__up_console_sem+0x40/0x64
[13744.750647] softirqs last  enabled at (3708): [<c07ad5d8>]
cfg80211_get_bss+0x254/0x2fc
[13744.759064] softirqs last disabled at (3652): [<c07ad3d8>]
cfg80211_get_bss+0x54/0x2fc
[13744.767370] ---[ end trace 0000000000000000 ]---
[13749.909380] ------------[ cut here ]------------
[13749.914158] WARNING: CPU: 0 PID: 6 at net/wireless/sme.c:1074
__cfg80211_roamed+0x30c/0x334
[13749.923053] Modules linked in: g_mass_storage usb_f_mass_storage g_ether
usb_f_rndis brcmfmac brcmutil usb_f_ecm u_ether libcomposite configfs
[13749.937044] CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G        W
 6.1.35-00014-g7e67972bd0c9-dirty #4
[13749.947100] Hardware name: Freescale MXS (Device Tree)
[13749.952329] Workqueue: cfg80211 cfg80211_event_work
[13749.957405]  unwind_backtrace from show_stack+0x10/0x14
[13749.962814]  show_stack from dump_stack_lvl+0x38/0x4c
[13749.968008]  dump_stack_lvl from __warn+0x78/0x134
[13749.972955]  __warn from warn_slowpath_fmt+0x74/0xac
[13749.978066]  warn_slowpath_fmt from __cfg80211_roamed+0x30c/0x334
[13749.984322]  __cfg80211_roamed from cfg80211_process_wdev_events+0xdc/0x158
[13749.991434]  cfg80211_process_wdev_events from cfg80211_process_rdev_events+0x30/0x78
[13749.999391]  cfg80211_process_rdev_events from cfg80211_event_work+0x20/0x2c
[13750.006587]  cfg80211_event_work from process_one_work+0x240/0x5d4
[13750.012905]  process_one_work from worker_thread+0x30/0x4b8
[13750.018594]  worker_thread from kthread+0xd8/0xfc
[13750.023436]  kthread from ret_from_fork+0x14/0x3c
[13750.028266] Exception stack(0xc482dfb0 to 0xc482dff8)
[13750.033413] dfa0:                                     00000000 00000000
00000000 00000000
[13750.041683] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
[13750.049945] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[13750.057104] irq event stamp: 4009
[13750.060569] hardirqs last  enabled at (4017): [<c006a204>]
__up_console_sem+0x54/0x64
[13750.068800] hardirqs last disabled at (4026): [<c006a1f0>]
__up_console_sem+0x40/0x64
[13750.076816] softirqs last  enabled at (4008): [<c00097a4>]
__do_softirq+0x234/0x3fc
[13750.084922] softirqs last disabled at (4039): [<c001ff10>]
__irq_exit_rcu+0x15c/0x1bc
[13750.093152] ---[ end trace 0000000000000000 ]---

Here is a more recent one:

[  541.616072] ------------[ cut here ]------------
[  541.621734] WARNING: CPU: 0 PID: 6 at net/wireless/sme.c:839 __cfg80211_connect_result+0x68c/0x700
[  541.631243] Modules linked in: brcmfmac brcmutil usb_f_acm u_serial usb_f_ecm g_cdc u_ether libcomposite configfs
[  541.642384] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 6.1.35-00016-gb85d2f107135-dirty #10
[  541.651044] Hardware name: Freescale MXS (Device Tree)
[  541.656273] Workqueue: cfg80211 cfg80211_event_work
[  541.661350]  unwind_backtrace from show_stack+0x10/0x14
[  541.666750]  show_stack from dump_stack_lvl+0x38/0x4c
[  541.671947]  dump_stack_lvl from __warn+0x78/0x134
[  541.676890]  __warn from warn_slowpath_fmt+0x74/0xac
[  541.682003]  warn_slowpath_fmt from __cfg80211_connect_result+0x68c/0x700
[  541.688951]  __cfg80211_connect_result from cfg80211_process_wdev_events+0xf8/0x158
[  541.696761]  cfg80211_process_wdev_events from cfg80211_process_rdev_events+0x30/0x78
[  541.704719]  cfg80211_process_rdev_events from cfg80211_event_work+0x20/0x2c
[  541.711921]  cfg80211_event_work from process_one_work+0x240/0x5d4
[  541.718239]  process_one_work from worker_thread+0x30/0x4b8
[  541.723926]  worker_thread from kthread+0xd8/0xfc
[  541.728770]  kthread from ret_from_fork+0x14/0x3c
[  541.733599] Exception stack(0xc482dfb0 to 0xc482dff8)
[  541.738749] dfa0:                                     00000000 00000000 00000000 00000000
[  541.747022] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  541.755286] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  541.762240] irq event stamp: 1189
[  541.765696] hardirqs last  enabled at (1197): [<c006a204>] __up_console_sem+0x54/0x64
[  541.773921] hardirqs last disabled at (1206): [<c006a1f0>] __up_console_sem+0x40/0x64
[  541.782152] softirqs last  enabled at (1094): [<c07ad5d0>] cfg80211_get_bss+0x254/0x2fc
[  541.790350] softirqs last disabled at (1056): [<c07ad3d0>] cfg80211_get_bss+0x54/0x2fc
[  541.798648] ---[ end trace 0000000000000000 ]---
[  546.440876] ------------[ cut here ]------------
[  546.446097] WARNING: CPU: 0 PID: 6 at net/wireless/sme.c:1074 __cfg80211_roamed+0x30c/0x334
[  546.455112] Modules linked in: brcmfmac brcmutil usb_f_acm u_serial usb_f_ecm g_cdc u_ether libcomposite configfs
[  546.466245] CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G        W          6.1.35-00016-gb85d2f107135-dirty #10
[  546.476382] Hardware name: Freescale MXS (Device Tree)
[  546.481610] Workqueue: cfg80211 cfg80211_event_work
[  546.486687]  unwind_backtrace from show_stack+0x10/0x14
[  546.492092]  show_stack from dump_stack_lvl+0x38/0x4c
[  546.497284]  dump_stack_lvl from __warn+0x78/0x134
[  546.502224]  __warn from warn_slowpath_fmt+0x74/0xac
[  546.507336]  warn_slowpath_fmt from __cfg80211_roamed+0x30c/0x334
[  546.513587]  __cfg80211_roamed from cfg80211_process_wdev_events+0xdc/0x158
[  546.520700]  cfg80211_process_wdev_events from cfg80211_process_rdev_events+0x30/0x78
[  546.528657]  cfg80211_process_rdev_events from cfg80211_event_work+0x20/0x2c
[  546.535855]  cfg80211_event_work from process_one_work+0x240/0x5d4
[  546.542166]  process_one_work from worker_thread+0x30/0x4b8
[  546.547856]  worker_thread from kthread+0xd8/0xfc
[  546.552700]  kthread from ret_from_fork+0x14/0x3c
[  546.557530] Exception stack(0xc482dfb0 to 0xc482dff8)
[  546.562676] dfa0:                                     00000000 00000000 00000000 00000000
[  546.570941] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  546.579206] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  546.586273] irq event stamp: 1397
[  546.589731] hardirqs last  enabled at (1405): [<c006a204>] __up_console_sem+0x54/0x64
[  546.597954] hardirqs last disabled at (1414): [<c006a1f0>] __up_console_sem+0x40/0x64
[  546.606252] softirqs last  enabled at (1434): [<c00097a4>] __do_softirq+0x234/0x3fc
[  546.614314] softirqs last disabled at (1423): [<c001ff10>] __irq_exit_rcu+0x15c/0x1bc
[  546.622628] ---[ end trace 0000000000000000 ]---

