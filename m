Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1726572C5FD
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 15:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjFLNav (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 09:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjFLNaq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 09:30:46 -0400
Received: from bin-mail-out-06.binero.net (bin-mail-out-06.binero.net [195.74.38.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B5E10F7
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 06:30:37 -0700 (PDT)
X-Halon-ID: 48eebbcd-0925-11ee-b7d6-cf458ee68324
Authorized-sender: petter@technux.se
Received: from localhost.localdomain (user33.85-195-12.netatonce.net [85.195.12.33])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPSA
        id 48eebbcd-0925-11ee-b7d6-cf458ee68324;
        Mon, 12 Jun 2023 15:30:31 +0200 (CEST)
From:   petter@technux.se
To:     pkshih@realtek.com, linux-wireless@vger.kernel.org
Cc:     Larry.Finger@lwfinger.net, andreas@fatal.se, iam@valdikss.org.ru,
        kernel@pengutronix.de, kvalo@kernel.org, linux@ulli-kroll.de,
        petter.mabacker@esab.se, petter@technux.se, s.hauer@pengutronix.de
Subject: rtw8822cu (LM842) stalls when running HW offload scan
Date:   Mon, 12 Jun 2023 15:30:23 +0200
Message-Id: <20230612133023.321060-1-petter@technux.se>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some time ago https://bugzilla.kernel.org/show_bug.cgi?id=217034 was created. From the beginning it was just about some error printouts. Then Andreas (who created the bug report) mentioned that it seems to work worse after bumping the firmware to > 9.9.10. After some fixes from Sascha the error printouts dissappeared. But when I also started to run this using firmware > 9.9.10 I also got problems. On my i.MX8 and RPi4 board it works fine, but on some of my less powerful boards such as and older RPi and my i.MX6 SoloX board, it always fails using > 9.9.10 firmware. After some digging in the git log, I discovered that HW scan offload was introduced in a later firmware. So when I disable HW offload scan it seems to work again on all my boards. But still I want to understand why the HW offload scan don't work for me.

Like described in the bug report I get below when running on latest 6.4 mainline with all relevant patches around rtw88 applied.


~# ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=119 time=14.4 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=119 time=15.1 ms
^C
--- 8.8.8.8 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 14.377/14.746/15.116/0.369 ms

~# sudo nmcli dev wifi rescan
[ 5359.184667] rtw_8822cu 1-1:1.2: failed to get tx report from firmware

~# ping 8.8.8.8 <-- stops working
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.

^C
--- 8.8.8.8 ping statistics ---
11 packets transmitted, 0 received, 100% packet loss, time 10407ms

~# ip addr
...
wlx34c9f08deb60
       valid_lft 7159sec preferred_lft 7159sec
    inet6 fe80::3bc3:2caf:608a:2e32/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
...
[ 5389.664909] rtw_8822cu 1-1:1.2: failed to get tx report from firmware


Only thing that makes the driver work again, is the re-plug the wifi dongle..

I tried to enable full debug level and one thing I can see around the issue is that it never get request to switch back TO_5G mode after scan finished. Also it seems like it repeats sending some 0x37 messages and is somehow stuck in this mode.. Like described above, the interface is still up but not functional, it seems the firmware/driver stalls(?).

...
[ 1674.044584] rtw_8822cu 1-1:1.2: [BTCoex], SCAN START notify (2G)
[ 1674.044607] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[ 1674.045002] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x1d, len=14
[ 1674.045291] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[ 1674.045323] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_2G_RUNTIME
[ 1674.045740] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x1e, len=14
[ 1674.046228] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x1f, len=14
[ 1674.053428] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 0
[ 1674.053474] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 2
[ 1674.053670] rtw_8822cu 1-1:1.2: [BTCoex], WiFi is single-port 2G!!
[ 1674.053698] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_bt_idle()
[ 1674.053725] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 10
[ 1674.054679] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_table(): 0x6c0 = 66555555, 0x6c4 = 6a5a5a5a
[ 1674.054722] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_tdma(): native power save (byte1 = 0x61)
[ 1674.054747] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_power_save_state(): COEX_PS_WIFI_NATIVE
[ 1674.054772] rtw_8822cu 1-1:1.2: send H2C content 03306160 00001111
[ 1674.055548] rtw_8822cu 1-1:1.2: [BTCoex], coex tdma type(on, 3)
[ 1674.059937] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 0, status: 0
[ 1674.060059] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 1, status: 0
[ 1674.060109] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 4, status: 0
[ 1674.060149] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 5, status: 0
[ 1674.061428] rtw_8822cu 1-1:1.2: [BTCoex], Hi-Pri Rx/Tx: 3/0, Lo-Pri Rx/Tx: 0/0
[ 1674.063770] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x20, len=14
[ 1674.063896] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 6, status: 3
[ 1674.089202] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x21, len=14
[ 1674.089738] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x22, len=14
[ 1674.089956] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 7, status: 0
[ 1674.090015] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 8, status: 0
[ 1674.109142] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x23, len=14
[ 1674.109276] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 9, status: 3
[ 1674.109594] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x24, len=14
[ 1674.109724] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_switchband_notify(): TO_5G
[ 1674.109754] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 4
[ 1674.109780] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 2
[ 1674.110089] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x25, len=14
[ 1674.110459] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_wl_under5g()
[ 1674.110493] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[ 1674.111063] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[ 1674.111099] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_5G_RUNTIME
[ 1674.119081] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 0
[ 1674.120053] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_table(): 0x6c0 = ffffffff, 0x6c4 = ffffffff
[ 1674.120097] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_tdma(): native power save (byte1 = 0x0)
[ 1674.120123] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_power_save_state(): COEX_PS_WIFI_NATIVE
[ 1674.120148] rtw_8822cu 1-1:1.2: send H2C content 00000060 00000000
[ 1674.120930] rtw_8822cu 1-1:1.2: [BTCoex], coex tdma type(off, 0)
[ 1674.125114] rtw_8822cu 1-1:1.2: Chan switch: 90, id: 0, status: 0
[ 1674.125201] rtw_8822cu 1-1:1.2: Chan switch: 90, id: 1, status: 0
[ 1674.214018] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x26, len=14
[ 1674.214237] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_switchband_notify(): TO_2G
[ 1674.214271] rtw_8822cu 1-1:1.2: [BTCoex], SCAN START notify (2G)
[ 1674.214295] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[ 1674.214606] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x27, len=14
[ 1674.215216] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x28, len=14
[ 1674.215887] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x29, len=14
[ 1674.215978] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[ 1674.216005] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_2G_RUNTIME
[ 1674.223942] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 0
[ 1674.223988] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 2
[ 1674.225066] rtw_8822cu 1-1:1.2: [BTCoex], WiFi is single-port 2G!!
[ 1674.225104] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_bt_idle()
[ 1674.225131] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 10
[ 1674.226188] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_table(): 0x6c0 = 66555555, 0x6c4 = 6a5a5a5a
[ 1674.226234] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_tdma(): native power save (byte1 = 0x61)
[ 1674.226259] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_power_save_state(): COEX_PS_WIFI_NATIVE
[ 1674.226284] rtw_8822cu 1-1:1.2: send H2C content 03306160 00001111
[ 1674.227081] rtw_8822cu 1-1:1.2: [BTCoex], coex tdma type(on, 3)
[ 1674.231176] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 0, status: 0
[ 1674.231296] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 1, status: 0
[ 1674.231347] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 4, status: 0
[ 1674.231387] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 5, status: 0
[ 1674.233395] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x2a, len=14
[ 1674.233524] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 6, status: 3
[ 1674.258486] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x2b, len=14
[ 1674.259187] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x2c, len=14
[ 1674.259366] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 7, status: 0
[ 1674.259460] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 8, status: 0
[ 1674.279155] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x2d, len=14
[ 1674.279630] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x2e, len=14
[ 1674.280090] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x2f, len=14
[ 1674.280171] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 9, status: 3
[ 1674.280224] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_switchband_notify(): TO_5G
[ 1674.280252] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 4
[ 1674.280279] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 2
[ 1674.280583] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_wl_under5g()
[ 1674.280617] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[ 1674.281174] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[ 1674.281211] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_5G_RUNTIME
[ 1674.290438] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 0
[ 1674.291427] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_table(): 0x6c0 = ffffffff, 0x6c4 = ffffffff
[ 1674.291471] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_tdma(): native power save (byte1 = 0x0)
[ 1674.291496] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_power_save_state(): COEX_PS_WIFI_NATIVE
[ 1674.291520] rtw_8822cu 1-1:1.2: send H2C content 00000060 00000000
[ 1674.292315] rtw_8822cu 1-1:1.2: [BTCoex], coex tdma type(off, 0)
[ 1674.297068] rtw_8822cu 1-1:1.2: Chan switch: 95, id: 0, status: 0
[ 1674.297179] rtw_8822cu 1-1:1.2: Chan switch: 95, id: 1, status: 0
[ 1674.383661] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x30, len=14
[ 1674.383793] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_switchband_notify(): TO_2G
[ 1674.383824] rtw_8822cu 1-1:1.2: [BTCoex], SCAN START notify (2G)
[ 1674.383848] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[ 1674.384263] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x31, len=14
[ 1674.384552] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[ 1674.384831] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x32, len=14
[ 1674.384893] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_2G_RUNTIME
[ 1674.385454] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x33, len=14
[ 1674.393670] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 0
[ 1674.393715] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 2
[ 1674.393928] rtw_8822cu 1-1:1.2: [BTCoex], WiFi is single-port 2G!!
[ 1674.393990] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_bt_idle()
[ 1674.394017] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 10
[ 1674.395045] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_table(): 0x6c0 = 66555555, 0x6c4 = 6a5a5a5a
[ 1674.395090] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_tdma(): native power save (byte1 = 0x61)
[ 1674.395115] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_power_save_state(): COEX_PS_WIFI_NATIVE
[ 1674.395141] rtw_8822cu 1-1:1.2: send H2C content 03306160 00001111
[ 1674.396560] rtw_8822cu 1-1:1.2: [BTCoex], coex tdma type(on, 3)
[ 1674.400997] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 0, status: 0
[ 1674.401115] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 1, status: 0
[ 1674.401162] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 4, status: 0
[ 1674.401200] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 5, status: 0
[ 1674.403286] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x34, len=14
[ 1674.403415] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 6, status: 3
[ 1674.428009] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x35, len=14
[ 1674.428139] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 7, status: 0
[ 1674.428742] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x36, len=14
[ 1674.428919] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 8, status: 0
[ 1674.448417] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x37, len=14
[ 1674.449040] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x38, len=14
[ 1674.449142] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 9, status: 3
[ 1674.449196] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_switchband_notify(): TO_5G
[ 1674.449223] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 4
[ 1674.449248] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 2
[ 1674.449616] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x39, len=14
[ 1674.450084] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x3a, len=14
[ 1674.450191] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_wl_under5g()
[ 1674.450219] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[ 1674.450720] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x3b, len=14
[ 1674.451064] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[ 1674.451099] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_5G_RUNTIME
[ 1674.457929] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 0
[ 1674.459393] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_table(): 0x6c0 = ffffffff, 0x6c4 = ffffffff
[ 1674.459440] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_tdma(): native power save (byte1 = 0x0)
[ 1674.459465] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_power_save_state(): COEX_PS_WIFI_NATIVE
[ 1674.459490] rtw_8822cu 1-1:1.2: send H2C content 00000060 00000000
[ 1674.460299] rtw_8822cu 1-1:1.2: [BTCoex], coex tdma type(off, 0)
[ 1674.463821] rtw_8822cu 1-1:1.2: Chan switch: 99, id: 0, status: 0
[ 1674.463910] rtw_8822cu 1-1:1.2: Chan switch: 99, id: 1, status: 0
[ 1674.463955] rtw_8822cu 1-1:1.2: Chan switch: 99, id: 2, status: 0
[ 1674.463996] rtw_8822cu 1-1:1.2: Chan switch: 99, id: 3, status: 1
[ 1674.493426] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x3c, len=14
[ 1674.493561] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_switchband_notify(): TO_5G
[ 1674.493878] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x3d, len=14
[ 1674.494004] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 4
[ 1674.494031] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 2
[ 1674.494502] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x3e, len=14
[ 1674.494647] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_wl_under5g()
[ 1674.494675] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[ 1674.495209] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x3f, len=14
[ 1674.495582] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[ 1674.495617] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_5G_RUNTIME
[ 1674.504180] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 0
[ 1674.504678] rtw_8822cu 1-1:1.2: [BTCoex], Skip TDMA because no change TDMA(off, 0)
[ 1674.504715] rtw_8822cu 1-1:1.2: Chan switch: 9d, id: 0, status: 0
[ 1674.504786] rtw_8822cu 1-1:1.2: Chan switch: 9d, id: 1, status: 0
[ 1674.504830] rtw_8822cu 1-1:1.2: Chan switch: 9d, id: 2, status: 0
[ 1674.504870] rtw_8822cu 1-1:1.2: Chan switch: 9d, id: 3, status: 1
[ 1674.538421] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x40, len=14
[ 1674.539069] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x41, len=14
[ 1674.539178] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_switchband_notify(): TO_5G
[ 1674.539208] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 4
[ 1674.539234] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 2
[ 1674.539584] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_wl_under5g()
[ 1674.539619] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[ 1674.540172] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[ 1674.540208] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_5G_RUNTIME
[ 1674.546687] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 0
[ 1674.547183] rtw_8822cu 1-1:1.2: [BTCoex], Skip TDMA because no change TDMA(off, 0)
[ 1674.547221] rtw_8822cu 1-1:1.2: Chan switch: a1, id: 0, status: 0
[ 1674.547279] rtw_8822cu 1-1:1.2: Chan switch: a1, id: 1, status: 0
[ 1674.643088] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x42, len=14
[ 1674.643474] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x43, len=14
[ 1674.643554] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_switchband_notify(): TO_2G
[ 1674.643583] rtw_8822cu 1-1:1.2: [BTCoex], SCAN START notify (2G)
[ 1674.643606] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[ 1674.644070] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x44, len=14
[ 1674.644434] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[ 1674.644708] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x45, len=14
[ 1674.644789] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_2G_RUNTIME
[ 1674.651927] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 0
[ 1674.651971] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 2
[ 1674.652167] rtw_8822cu 1-1:1.2: [BTCoex], WiFi is single-port 2G!!
[ 1674.652195] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_bt_idle()
[ 1674.652221] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 10
[ 1674.653179] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_table(): 0x6c0 = 66555555, 0x6c4 = 6a5a5a5a
[ 1674.653222] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_tdma(): native power save (byte1 = 0x61)
[ 1674.653249] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_power_save_state(): COEX_PS_WIFI_NATIVE
[ 1674.653275] rtw_8822cu 1-1:1.2: send H2C content 03306160 00001111
[ 1674.654178] rtw_8822cu 1-1:1.2: [BTCoex], coex tdma type(on, 3)
[ 1674.658430] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 0, status: 0
[ 1674.658880] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 1, status: 0
[ 1674.659562] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 4, status: 0
[ 1674.659630] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 5, status: 0
[ 1674.662660] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x46, len=14
[ 1674.662789] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 6, status: 3
[ 1674.687222] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x47, len=14
[ 1674.687401] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 7, status: 0
[ 1674.687854] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x48, len=14
[ 1674.687961] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 8, status: 0
[ 1674.707755] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x49, len=14
[ 1674.708086] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x4a, len=14
[ 1674.708933] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x4b, len=14
[ 1674.709319] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 9, status: 3
[ 1674.709382] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_switchband_notify(): TO_5G
[ 1674.709408] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 4
[ 1674.709435] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 2
[ 1674.709706] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_wl_under5g()
[ 1674.709740] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[ 1674.710822] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[ 1674.710864] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_5G_RUNTIME
[ 1674.717429] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 0
[ 1674.719008] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_table(): 0x6c0 = ffffffff, 0x6c4 = ffffffff
[ 1674.719121] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_tdma(): native power save (byte1 = 0x0)
[ 1674.719153] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_power_save_state(): COEX_PS_WIFI_NATIVE
[ 1674.719178] rtw_8822cu 1-1:1.2: send H2C content 00000060 00000000
[ 1674.720380] rtw_8822cu 1-1:1.2: [BTCoex], coex tdma type(off, 0)
[ 1674.723938] rtw_8822cu 1-1:1.2: Chan switch: a5, id: 0, status: 0
[ 1674.724013] rtw_8822cu 1-1:1.2: Chan switch: a5, id: 1, status: 0
[ 1674.812280] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x4c, len=14
[ 1674.812411] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_switchband_notify(): TO_2G
[ 1674.812441] rtw_8822cu 1-1:1.2: [BTCoex], SCAN START notify (2G)
[ 1674.812465] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[ 1674.812871] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x4d, len=14
[ 1674.813171] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[ 1674.813204] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_2G_RUNTIME
[ 1674.813605] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x4e, len=14
[ 1674.814212] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x4f, len=14
[ 1674.814823] rtw_8822cu 1-1:1.2: recv C2H, id=0xff, seq=0x50, len=14
[ 1674.821805] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 0
[ 1674.821850] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 2
[ 1674.822072] rtw_8822cu 1-1:1.2: [BTCoex], WiFi is single-port 2G!!
[ 1674.822101] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_bt_idle()
[ 1674.822126] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 10
[ 1674.823178] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_table(): 0x6c0 = 66555555, 0x6c4 = 6a5a5a5a
[ 1674.823225] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_tdma(): native power save (byte1 = 0x61)
[ 1674.823251] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_power_save_state(): COEX_PS_WIFI_NATIVE
[ 1674.823276] rtw_8822cu 1-1:1.2: send H2C content 03306160 00001111
[ 1674.824058] rtw_8822cu 1-1:1.2: [BTCoex], coex tdma type(on, 3)
[ 1674.828332] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 0, status: 0
[ 1674.828453] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 1, status: 0
[ 1674.828796] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 4, status: 0
[ 1674.828842] rtw_8822cu 1-1:1.2: Chan switch: 5, id: 5, status: 0
[ 1674.829188] rtw_8822cu 1-1:1.2: send H2C content 00000059 00000000
[ 1674.831062] rtw_8822cu 1-1:1.2: recv C2H, id=0x38, seq=0xe8, len=1
[ 1674.831133] rtw_8822cu 1-1:1.2: scan.density = 10
[ 1674.832824] rtw_8822cu 1-1:1.2: [BTCoex], SCAN FINISH notify (Scan-AP = 30)
[ 1674.832865] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 2
[ 1674.832892] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 2
[ 1674.833435] rtw_8822cu 1-1:1.2: [BTCoex], WiFi is single-port 2G!!
[ 1674.833469] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_bt_idle()
[ 1674.833497] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 10
[ 1674.834062] rtw_8822cu 1-1:1.2: [BTCoex], Skip TDMA because no change TDMA(on, 3)
[ 1675.378586] rtw_8822cu 1-1:1.2: TX Report queue len not empty : 1
[ 1676.059715] rtw_8822cu 1-1:1.2: [BTCoex], Hi-Pri Rx/Tx: 2/0, Lo-Pri Rx/Tx: 0/0
[ 1676.059773] rtw_8822cu 1-1:1.2: send H2C content 37000042 00000002
[ 1676.068938] rtw_8822cu 1-1:1.2: IGI=0x37, rssi_min=55, cck_fa=219
[ 1676.068983] rtw_8822cu 1-1:1.2: cck_fa_avg=88, cck_pd_default=0
[ 1676.069555] rtw_8822cu 1-1:1.2: lv: (3) -> (3) bw=1 nr=1 cck_fa_avg=88
[ 1676.069594] rtw_8822cu 1-1:1.2: send H2C content 00000058 0021001b
[ 1676.070803] rtw_8822cu 1-1:1.2: Switch TX path=A
[ 1676.082811] rtw_8822cu 1-1:1.2: send H2C content 0037105a 00000010
[ 1676.084390] rtw_8822cu 1-1:1.2: recv C2H, id=0x37, seq=0xe9, len=6
[ 1676.084436] rtw_8822cu 1-1:1.2: Adaptivity: density 10 igi 37 l2h_th_init 0 l2h 7f h2l 7f option 5
[ 1676.084934] rtw_8822cu 1-1:1.2: Reg Setting: L2H ff H2L ff
[ 1676.085171] rtw_8822cu 1-1:1.2: EDCCA Flag Unset
[ 1676.198545] rtw_8822cu 1-1:1.2: recv C2H, id=0x27, seq=0xea, len=8
[ 1676.198885] rtw_8822cu 1-1:1.2: [BTCoex], WiFi Fw Dbg info = 08 00 00 00 00 00 11 00 (len = 8)
[ 1678.059485] rtw_8822cu 1-1:1.2: [BTCoex], Hi-Pri Rx/Tx: 3/0, Lo-Pri Rx/Tx: 0/0
[ 1678.059541] rtw_8822cu 1-1:1.2: send H2C content 37000042 00000002
[ 1678.067430] rtw_8822cu 1-1:1.2: IGI=0x37, rssi_min=55, cck_fa=33
[ 1678.067476] rtw_8822cu 1-1:1.2: cck_fa_avg=73, cck_pd_default=0
[ 1678.067948] rtw_8822cu 1-1:1.2: lv: (3) -> (3) bw=1 nr=1 cck_fa_avg=73
[ 1678.067987] rtw_8822cu 1-1:1.2: send H2C content 00000058 0021001b
[ 1678.075679] rtw_8822cu 1-1:1.2: send H2C content 0037105a 00000010
[ 1678.077182] rtw_8822cu 1-1:1.2: recv C2H, id=0x37, seq=0xeb, len=6
[ 1678.077225] rtw_8822cu 1-1:1.2: Adaptivity: density 10 igi 37 l2h_th_init 0 l2h 7f h2l 7f option 5
[ 1678.077802] rtw_8822cu 1-1:1.2: Reg Setting: L2H ff H2L ff
[ 1678.078049] rtw_8822cu 1-1:1.2: EDCCA Flag Unset
[ 1678.246401] rtw_8822cu 1-1:1.2: recv C2H, id=0x27, seq=0xec, len=8
[ 1678.246531] rtw_8822cu 1-1:1.2: [BTCoex], WiFi Fw Dbg info = 08 00 00 00 00 00 25 00 (len = 8)
[ 1680.061027] rtw_8822cu 1-1:1.2: [BTCoex], Hi-Pri Rx/Tx: 1/0, Lo-Pri Rx/Tx: 0/0
[ 1680.061124] rtw_8822cu 1-1:1.2: send H2C content 37000042 00000002
[ 1680.086020] rtw_8822cu 1-1:1.2: IGI=0x37, rssi_min=55, cck_fa=39
[ 1680.086105] rtw_8822cu 1-1:1.2: cck_fa_avg=64, cck_pd_default=0
[ 1680.086844] rtw_8822cu 1-1:1.2: lv: (3) -> (3) bw=1 nr=1 cck_fa_avg=64
[ 1680.086916] rtw_8822cu 1-1:1.2: send H2C content 00000058 0021001b
[ 1680.099434] rtw_8822cu 1-1:1.2: send H2C content 0037105a 00000010
[ 1680.100869] rtw_8822cu 1-1:1.2: recv C2H, id=0x37, seq=0xed, len=6
[ 1680.100912] rtw_8822cu 1-1:1.2: Adaptivity: density 10 igi 37 l2h_th_init 0 l2h 7f h2l 7f option 5
[ 1680.101427] rtw_8822cu 1-1:1.2: Reg Setting: L2H ff H2L ff
[ 1680.101681] rtw_8822cu 1-1:1.2: EDCCA Flag Unset
[ 1680.296175] rtw_8822cu 1-1:1.2: recv C2H, id=0x27, seq=0xee, len=8
[ 1680.296629] rtw_8822cu 1-1:1.2: [BTCoex], WiFi Fw Dbg info = 08 00 00 00 00 00 39 00 (len = 8)
[ 1682.064427] rtw_8822cu 1-1:1.2: [BTCoex], Hi-Pri Rx/Tx: 3/0, Lo-Pri Rx/Tx: 0/0
[ 1682.064615] rtw_8822cu 1-1:1.2: send H2C content 37000042 00000002
[ 1682.104318] rtw_8822cu 1-1:1.2: IGI=0x37, rssi_min=55, cck_fa=37
[ 1682.104364] rtw_8822cu 1-1:1.2: cck_fa_avg=57, cck_pd_default=0
[ 1682.105060] rtw_8822cu 1-1:1.2: lv: (3) -> (3) bw=1 nr=1 cck_fa_avg=57
[ 1682.105105] rtw_8822cu 1-1:1.2: send H2C content 00000058 0021001b
[ 1682.105938] rtw_8822cu 1-1:1.2: send H2C content 4d800040 0fff0000
[ 1682.114303] rtw_8822cu 1-1:1.2: send H2C content 0037105a 00000010
[ 1682.116008] rtw_8822cu 1-1:1.2: recv C2H, id=0x37, seq=0xef, len=6
[ 1682.116051] rtw_8822cu 1-1:1.2: Adaptivity: density 10 igi 37 l2h_th_init 0 l2h 7f h2l 7f option 5
...


Anyone that has any ideas around this? Some things I have tried is to disable lps_state and forced wifi_only in coex, but without any success..

BR Petter
