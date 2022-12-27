Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482C8656E96
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Dec 2022 21:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiL0UTG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Dec 2022 15:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiL0UTF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Dec 2022 15:19:05 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240A132A
        for <linux-wireless@vger.kernel.org>; Tue, 27 Dec 2022 12:19:04 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o5so13320031wrm.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Dec 2022 12:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQt3XIgKxG/R1xic9WIjPysoEYr5UvHmYlt3wQmqNls=;
        b=OflZ1ITPIM1ZkmX2rQJ9oYo9BMykPwng0ATXSqurFLDFalY6ut7xxxo8KIsi5XwvU1
         Fm0mXeCpIu5afYvmfWAUKWEfyXOo+JzYvkMjmFZEV+vHR4x8GDJPZ/hBs2y1xuUoucw+
         Z6uO1H4JTwwKV0j5MmOSP8dVxq9LRmqhdViewNKL9bDTR69Yn8A8GSZlCrYk3yXeTI5R
         IBfdzGjWRjBYC9mkNPNLbzDBfCH0peTUHr1cJMev9YKi9oz8ywQ5zp4LrH9oVgSFu1jp
         Y59g5IntWFz8MILhQfesOJOMFAe/0k9Auj1vzhxgZ4fsxbHoylbTZUEjatU47KaMY3Jq
         kcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQt3XIgKxG/R1xic9WIjPysoEYr5UvHmYlt3wQmqNls=;
        b=6ccet9NZxgOKBAMuRWqeX7XS6/09dIVsX5MFwEM3yV6iG1dTYueTJbUuj06UTKU9yL
         bdU09eRjuOuk/KW26feW7rLqPeL2GABbsMm6w5p5Io5qSUtrFUgy+pfzw6kDVyjztnZf
         WBwDe0axMlG5MsABaDGswQ/59+CSyjLKfvTbV32IRR6FfYnznMclX4YFvSR1whnMpLCr
         hdveJ9cGcUaYxVsl6GuOktROtF7RdcsbHu9pL0u85rObE4AxPIXZScBHhIpC+p08ji57
         aCYG1EPE6LhvB/9PWCxUPfwzm8RER+dPHG8h3SSQpfqrx49TQ/k7/EEf285gnkbgctx9
         ATrw==
X-Gm-Message-State: AFqh2ko6T1vUzIx8MzOXde/DUlgJfoh+FRaUCAOcU5Oe+M64OsYTvqjp
        SsYuD8cggQdASWq+Z2HmHGWaknYl5HcjWk1e9x8=
X-Google-Smtp-Source: AMrXdXtVVZzrYNqFccbbGdtPnM5B5DIdMQ0PM4Qp/J/8OplZFDMqfZVlgBYSgY4CpLR2tlIeoDsMrQ==
X-Received: by 2002:a5d:54ce:0:b0:242:486:5037 with SMTP id x14-20020a5d54ce000000b0024204865037mr14203711wrv.32.1672172342507;
        Tue, 27 Dec 2022 12:19:02 -0800 (PST)
Received: from tp440p.steeds.sam ([2602:fbf6:10:8::2])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d4f8c000000b002421a8f4fa6sm13098634wru.92.2022.12.27.12.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 12:19:01 -0800 (PST)
Date:   Tue, 27 Dec 2022 22:18:52 +0200
From:   Sicelo <absicsz@gmail.com>
To:     mailto: linux-wireless@vger.kernel.org, ;
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
        To:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: WLAN broken on Nokia N900 with v6.2-rc1
Message-ID: <Y6tTLPvsxh/Im4Ed@tp440p.steeds.sam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

With linux 6.2-rc1, wlan is broken on the Nokia N900 with wl1251, while
it was working up to at least 6.1-rc7. The driver probes fine and I can
scan for networks. However it is not possible to connect to any.

dmesg contains the following:


[  143.202484] WARNING: CPU: 0 PID: 1300 at net/wireless/core.c:1463 cfg802=
11_netdev_notifier_call+0x26d/0x30c [cfg80211]
[  143.203613] Modules linked in: nft_reject_inet nf_reject_ipv4 nf_reject_=
ipv6 nft_reject nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables=
 nfnetlink bnep cmt_speech nokia_modem ssi_protocol phonet radio_platform_s=
i4713 joydev mousedev hsi_char wl1251_spi wl1251 mac80211 libarc4 omap3_rom=
_rng rng_core ir_rx51 pwm_omap_dmtimer rc_core snd_soc_rx51 rx51_battery is=
p1704_charger cpufreq_dt snd_soc_omap_mcbsp snd_soc_ti_sdma omap_wdt cfg802=
11 omap3_isp videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2=
_common omap_sham crypto_engine snd_soc_tlv320aic3x_i2c snd_soc_tlv320aic3x=
 snd_soc_tpa6130a2 tsc2005 snd_soc_core regmap_spi snd_pcm_dmaengine tsc200=
x_core snd_pcm omap_mailbox snd_timer leds_lp5523 bq27xxx_battery_i2c snd s=
i4713 leds_lp55xx_common bq27xxx_battery soundcore led_class tsl2563 twl403=
0_wdt hci_nokia rtc_twl hci_uart btbcm bluetooth twl4030_vibra pwm_twl_led =
pwm_twl ff_memless ecdh_generic twl4030_madc ecc rfkill libaes et8ek8 ad582=
0 v4l2_fwnode v4l2_async
[  143.205780]  st_accel_i2c st_sensors_i2c st_accel industrialio_triggered=
_buffer kfifo_buf st_sensors videodev industrialio omap_ssi mc hsi
[  143.206146] CPU: 0 PID: 1300 Comm: NetworkManager Tainted: G        W   =
       6.2.0-rc1-nokia-n900+ #1
[  143.206207] Hardware name: Nokia RX-51 board
[  143.206268]  unwind_backtrace from show_stack+0xb/0xc
[  143.206390]  show_stack from dump_stack_lvl+0x2b/0x34
[  143.206512]  dump_stack_lvl from __warn+0xdb/0xe8
[  143.206604]  __warn from warn_slowpath_fmt+0x3f/0x76
[  143.206726]  warn_slowpath_fmt from cfg80211_netdev_notifier_call+0x26d/=
0x30c [cfg80211]
[  143.207519]  cfg80211_netdev_notifier_call [cfg80211] from raw_notifier_=
call_chain+0x31/0x3c
[  143.208282]  raw_notifier_call_chain from __dev_notify_flags+0x3f/0x90
[  143.208404]  __dev_notify_flags from dev_change_flags+0x2d/0x34
[  143.208496]  dev_change_flags from do_setlink+0x20f/0xa98
[  143.208587]  do_setlink from rtnl_newlink+0x341/0x5f0
[  143.208679]  rtnl_newlink from rtnetlink_rcv_msg+0x193/0x218
[  143.208770]  rtnetlink_rcv_msg from netlink_rcv_skb+0x75/0xb0
[  143.208892]  netlink_rcv_skb from netlink_unicast+0x113/0x1b4
[  143.208984]  netlink_unicast from netlink_sendmsg+0x161/0x31c
[  143.209106]  netlink_sendmsg from ____sys_sendmsg+0x123/0x158
[  143.209228]  ____sys_sendmsg from ___sys_sendmsg+0x43/0x68
[  143.209350]  ___sys_sendmsg from sys_sendmsg+0x33/0x60
[  143.209442]  sys_sendmsg from ret_fast_syscall+0x1/0x5c
[  143.209564] Exception stack(0xd0149fa8 to 0xd0149ff0)
[  143.209625] 9fa0:                   00000000 00000000 0000000d beabf550 =
00000000 00000000
[  143.209686] 9fc0: 00000000 00000000 00000001 00000128 beabf67c beabf678 =
00000000 beabf674
[  143.209747] 9fe0: beabf508 beabf4f8 b6fadcdb b6fad994
[  143.209808] ---[ end trace 0000000000000000 ]---
[  143.241180] ------------[ cut here ]------------
[  143.241241] WARNING: CPU: 0 PID: 25 at net/wireless/scan.c:1021 cfg80211=
_scan_done+0x6b/0x124 [cfg80211]
[  143.241912] Modules linked in: nft_reject_inet nf_reject_ipv4 nf_reject_=
ipv6 nft_reject nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables=
 nfnetlink bnep cmt_speech nokia_modem ssi_protocol phonet radio_platform_s=
i4713 joydev mousedev hsi_char wl1251_spi wl1251 mac80211 libarc4 omap3_rom=
_rng rng_core ir_rx51 pwm_omap_dmtimer rc_core snd_soc_rx51 rx51_battery is=
p1704_charger cpufreq_dt snd_soc_omap_mcbsp snd_soc_ti_sdma omap_wdt cfg802=
11 omap3_isp videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2=
_common omap_sham crypto_engine snd_soc_tlv320aic3x_i2c snd_soc_tlv320aic3x=
 snd_soc_tpa6130a2 tsc2005 snd_soc_core regmap_spi snd_pcm_dmaengine tsc200=
x_core snd_pcm omap_mailbox snd_timer leds_lp5523 bq27xxx_battery_i2c snd s=
i4713 leds_lp55xx_common bq27xxx_battery soundcore led_class tsl2563 twl403=
0_wdt hci_nokia rtc_twl hci_uart btbcm bluetooth twl4030_vibra pwm_twl_led =
pwm_twl ff_memless ecdh_generic twl4030_madc ecc rfkill libaes et8ek8 ad582=
0 v4l2_fwnode v4l2_async
[  143.243041]  st_accel_i2c st_sensors_i2c st_accel industrialio_triggered=
_buffer kfifo_buf st_sensors videodev industrialio omap_ssi mc hsi
[  143.243225] CPU: 0 PID: 25 Comm: kworker/u2:2 Tainted: G        W       =
   6.2.0-rc1-nokia-n900+ #1
[  143.243255] Hardware name: Nokia RX-51 board
[  143.243286] Workqueue: phy0 ieee80211_scan_work [mac80211]
[  143.243865]  unwind_backtrace from show_stack+0xb/0xc
[  143.243927]  show_stack from dump_stack_lvl+0x2b/0x34
[  143.243988]  dump_stack_lvl from __warn+0xdb/0xe8
[  143.244049]  __warn from warn_slowpath_fmt+0x3f/0x76
[  143.244110]  warn_slowpath_fmt from cfg80211_scan_done+0x6b/0x124 [cfg80=
211]
[  143.244598]  cfg80211_scan_done [cfg80211] from __ieee80211_scan_complet=
ed+0x85/0x2d8 [mac80211]
[  143.245269]  __ieee80211_scan_completed [mac80211] from ieee80211_scan_w=
ork+0xdf/0x3b4 [mac80211]
[  143.245849]  ieee80211_scan_work [mac80211] from process_one_work+0x153/=
0x35c
[  143.246185]  process_one_work from worker_thread+0xd9/0x3d4
[  143.246246]  worker_thread from kthread+0xad/0xc0
[  143.246276]  kthread from ret_from_fork+0x11/0x20
[  143.246337] Exception stack(0xd0085fb0 to 0xd0085ff8)
[  143.246368] 5fa0:                                     00000000 00000000 =
00000000 00000000
[  143.246398] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[  143.246429] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  143.246459] ---[ end trace 0000000000000000 ]---



I tried to bisect with v6.2-rc1 as bad and v6.1-rc7 as good commits, and
it suggested a790cc3a4fad75048295571a350b95b87e022a5a as the first bad
commit. However I am not entirely sure yet what the real cause is, and
the correct fix.

I will appreciate assistance with this issue, and/or ideas how to
troubleshoot it further.

Regards
Sicelo
