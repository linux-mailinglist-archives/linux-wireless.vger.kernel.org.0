Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20A657442
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Dec 2022 09:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiL1IqX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Dec 2022 03:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiL1Ip6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Dec 2022 03:45:58 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3377AFD08
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 00:43:41 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pAS2G-0001j4-DE; Wed, 28 Dec 2022 09:43:40 +0100
Message-ID: <40ce69e8-04ed-2b5b-741c-ef7409a7005a@leemhuis.info>
Date:   Wed, 28 Dec 2022 09:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: WLAN broken on Nokia N900 with v6.2-rc1 #forregzbot
Content-Language: en-US, de-DE
To:     linux-wireless@vger.kernel.org
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <Y6tTLPvsxh/Im4Ed@tp440p.steeds.sam>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y6tTLPvsxh/Im4Ed@tp440p.steeds.sam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672217022;d2cba2d4;
X-HE-SMSGID: 1pAS2G-0001j4-DE
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[Note: this mail contains only information for Linux kernel regression
tracking. Mails like these contain '#forregzbot' in the subject to make
then easy to spot and filter out. The author also tried to remove most
or all individuals from the list of recipients to spare them the hassle.]

On 27.12.22 21:18, Sicelo wrote:
> Hi
> 
> With linux 6.2-rc1, wlan is broken on the Nokia N900 with wl1251, while
> it was working up to at least 6.1-rc7. The driver probes fine and I can
> scan for networks. However it is not possible to connect to any.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced a790cc3a4fad75048295571a350b95b87e022a5a
#regzbot title net: wifi: WLAN broken on Nokia N900
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

> dmesg contains the following:
> 
> 
> [  143.202484] WARNING: CPU: 0 PID: 1300 at net/wireless/core.c:1463 cfg80211_netdev_notifier_call+0x26d/0x30c [cfg80211]
> [  143.203613] Modules linked in: nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink bnep cmt_speech nokia_modem ssi_protocol phonet radio_platform_si4713 joydev mousedev hsi_char wl1251_spi wl1251 mac80211 libarc4 omap3_rom_rng rng_core ir_rx51 pwm_omap_dmtimer rc_core snd_soc_rx51 rx51_battery isp1704_charger cpufreq_dt snd_soc_omap_mcbsp snd_soc_ti_sdma omap_wdt cfg80211 omap3_isp videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common omap_sham crypto_engine snd_soc_tlv320aic3x_i2c snd_soc_tlv320aic3x snd_soc_tpa6130a2 tsc2005 snd_soc_core regmap_spi snd_pcm_dmaengine tsc200x_core snd_pcm omap_mailbox snd_timer leds_lp5523 bq27xxx_battery_i2c snd si4713 leds_lp55xx_common bq27xxx_battery soundcore led_class tsl2563 twl4030_wdt hci_nokia rtc_twl hci_uart btbcm bluetooth twl4030_vibra pwm_twl_led pwm_twl ff_memless ecdh_generic twl4030_madc ecc rfkill libaes et8ek8 ad5820 v4l2_fwnode v4l2_async
> [  143.205780]  st_accel_i2c st_sensors_i2c st_accel industrialio_triggered_buffer kfifo_buf st_sensors videodev industrialio omap_ssi mc hsi
> [  143.206146] CPU: 0 PID: 1300 Comm: NetworkManager Tainted: G        W          6.2.0-rc1-nokia-n900+ #1
> [  143.206207] Hardware name: Nokia RX-51 board
> [  143.206268]  unwind_backtrace from show_stack+0xb/0xc
> [  143.206390]  show_stack from dump_stack_lvl+0x2b/0x34
> [  143.206512]  dump_stack_lvl from __warn+0xdb/0xe8
> [  143.206604]  __warn from warn_slowpath_fmt+0x3f/0x76
> [  143.206726]  warn_slowpath_fmt from cfg80211_netdev_notifier_call+0x26d/0x30c [cfg80211]
> [  143.207519]  cfg80211_netdev_notifier_call [cfg80211] from raw_notifier_call_chain+0x31/0x3c
> [  143.208282]  raw_notifier_call_chain from __dev_notify_flags+0x3f/0x90
> [  143.208404]  __dev_notify_flags from dev_change_flags+0x2d/0x34
> [  143.208496]  dev_change_flags from do_setlink+0x20f/0xa98
> [  143.208587]  do_setlink from rtnl_newlink+0x341/0x5f0
> [  143.208679]  rtnl_newlink from rtnetlink_rcv_msg+0x193/0x218
> [  143.208770]  rtnetlink_rcv_msg from netlink_rcv_skb+0x75/0xb0
> [  143.208892]  netlink_rcv_skb from netlink_unicast+0x113/0x1b4
> [  143.208984]  netlink_unicast from netlink_sendmsg+0x161/0x31c
> [  143.209106]  netlink_sendmsg from ____sys_sendmsg+0x123/0x158
> [  143.209228]  ____sys_sendmsg from ___sys_sendmsg+0x43/0x68
> [  143.209350]  ___sys_sendmsg from sys_sendmsg+0x33/0x60
> [  143.209442]  sys_sendmsg from ret_fast_syscall+0x1/0x5c
> [  143.209564] Exception stack(0xd0149fa8 to 0xd0149ff0)
> [  143.209625] 9fa0:                   00000000 00000000 0000000d beabf550 00000000 00000000
> [  143.209686] 9fc0: 00000000 00000000 00000001 00000128 beabf67c beabf678 00000000 beabf674
> [  143.209747] 9fe0: beabf508 beabf4f8 b6fadcdb b6fad994
> [  143.209808] ---[ end trace 0000000000000000 ]---
> [  143.241180] ------------[ cut here ]------------
> [  143.241241] WARNING: CPU: 0 PID: 25 at net/wireless/scan.c:1021 cfg80211_scan_done+0x6b/0x124 [cfg80211]
> [  143.241912] Modules linked in: nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink bnep cmt_speech nokia_modem ssi_protocol phonet radio_platform_si4713 joydev mousedev hsi_char wl1251_spi wl1251 mac80211 libarc4 omap3_rom_rng rng_core ir_rx51 pwm_omap_dmtimer rc_core snd_soc_rx51 rx51_battery isp1704_charger cpufreq_dt snd_soc_omap_mcbsp snd_soc_ti_sdma omap_wdt cfg80211 omap3_isp videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common omap_sham crypto_engine snd_soc_tlv320aic3x_i2c snd_soc_tlv320aic3x snd_soc_tpa6130a2 tsc2005 snd_soc_core regmap_spi snd_pcm_dmaengine tsc200x_core snd_pcm omap_mailbox snd_timer leds_lp5523 bq27xxx_battery_i2c snd si4713 leds_lp55xx_common bq27xxx_battery soundcore led_class tsl2563 twl4030_wdt hci_nokia rtc_twl hci_uart btbcm bluetooth twl4030_vibra pwm_twl_led pwm_twl ff_memless ecdh_generic twl4030_madc ecc rfkill libaes et8ek8 ad5820 v4l2_fwnode v4l2_async
> [  143.243041]  st_accel_i2c st_sensors_i2c st_accel industrialio_triggered_buffer kfifo_buf st_sensors videodev industrialio omap_ssi mc hsi
> [  143.243225] CPU: 0 PID: 25 Comm: kworker/u2:2 Tainted: G        W          6.2.0-rc1-nokia-n900+ #1
> [  143.243255] Hardware name: Nokia RX-51 board
> [  143.243286] Workqueue: phy0 ieee80211_scan_work [mac80211]
> [  143.243865]  unwind_backtrace from show_stack+0xb/0xc
> [  143.243927]  show_stack from dump_stack_lvl+0x2b/0x34
> [  143.243988]  dump_stack_lvl from __warn+0xdb/0xe8
> [  143.244049]  __warn from warn_slowpath_fmt+0x3f/0x76
> [  143.244110]  warn_slowpath_fmt from cfg80211_scan_done+0x6b/0x124 [cfg80211]
> [  143.244598]  cfg80211_scan_done [cfg80211] from __ieee80211_scan_completed+0x85/0x2d8 [mac80211]
> [  143.245269]  __ieee80211_scan_completed [mac80211] from ieee80211_scan_work+0xdf/0x3b4 [mac80211]
> [  143.245849]  ieee80211_scan_work [mac80211] from process_one_work+0x153/0x35c
> [  143.246185]  process_one_work from worker_thread+0xd9/0x3d4
> [  143.246246]  worker_thread from kthread+0xad/0xc0
> [  143.246276]  kthread from ret_from_fork+0x11/0x20
> [  143.246337] Exception stack(0xd0085fb0 to 0xd0085ff8)
> [  143.246368] 5fa0:                                     00000000 00000000 00000000 00000000
> [  143.246398] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  143.246429] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [  143.246459] ---[ end trace 0000000000000000 ]---
> 
> 
> 
> I tried to bisect with v6.2-rc1 as bad and v6.1-rc7 as good commits, and
> it suggested a790cc3a4fad75048295571a350b95b87e022a5a as the first bad
> commit. However I am not entirely sure yet what the real cause is, and
> the correct fix.
> 
> I will appreciate assistance with this issue, and/or ideas how to
> troubleshoot it further.
> 
> Regards
> Sicelo
