Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE1A77115F
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Aug 2023 20:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjHESYO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Aug 2023 14:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHESYN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Aug 2023 14:24:13 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68A7E55
        for <linux-wireless@vger.kernel.org>; Sat,  5 Aug 2023 11:24:10 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1bb717ece50so2334669fac.0
        for <linux-wireless@vger.kernel.org>; Sat, 05 Aug 2023 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691259849; x=1691864649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cHDEQ/B2ExuzZNmFU4DWIbzs5u8gEpzyWGSFURGNW9E=;
        b=UqqjAPQeNEG+2Hw7p/dNaf8Zi5RfFI2nGemelQCTyzdzFm9VU9J5VtnJfDfD241bNr
         nd63iwv1Tt0XYbt8iM8/hIA/QtiIE2AnzBXZPWuIj83QRsabejmfB0xWjjlo0M9qONtE
         wHwtZ8wFNSs/EOng9tbKSFebANZAaEuhv6VrzdWAcifxGzTLdzbpHHN1YO7ncwwD8pBd
         2GcuHTWsTbbXsrqh0KaoVyj3a3xNBGCgUAR9z0WstPHDd3pgwS7zTzgXpHWVIGGRdy39
         QbGcZnKuvq9TgG0sDXu3T3GJLP9J8zeJyX7fZFYzMpQTlmfDaDLvotQ0UDfATiqJXYD2
         b6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691259849; x=1691864649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHDEQ/B2ExuzZNmFU4DWIbzs5u8gEpzyWGSFURGNW9E=;
        b=QS86NSMDWBRypOd+R1hfNRympSR9vpqmgv0gvs75/7PKi+Wruno7K+o+Gmx/H7Q1ss
         8jBQObteiLXQsExl/Zo3NJxkNWk01UDOnVho8q3DTdGjKrFpntx1r3fPMGwJw4Pjcnun
         Fy02gR589pw9LbpueJgD0Hb8k2d3Z8o1MGVrXSANQ85aWAVwlcZJSlA2rlESX6R/+nRy
         2M7NLmJh/e/YI3OqpP5HnzxZeqMHrQ5OBxAEUplYda/df4uPaKvgL+NZfJN2S+fpwtei
         5v6Yuk0QBtRiDducT7hnOz2Kd1RtTnblUGcHV2jnjZwe57fCJ1BhT9x/wEmvs24SiC9c
         3Olg==
X-Gm-Message-State: AOJu0YxYhfijK+H4cdtYfTHh9CjShuD1Rx2nM07olOWC6QytalOhKRWh
        6+AVa3P7HjvHJs1XoRP0Vu3rJf4niSk=
X-Google-Smtp-Source: AGHT+IH8QoNYkNKiaN6IyauBSvau2cqz1mZJjuXlM6qLnZHubrqekPjFuTRkARS83WL+Z28Cc3LK1A==
X-Received: by 2002:a05:6870:7011:b0:1bf:12ab:e16b with SMTP id u17-20020a056870701100b001bf12abe16bmr6876365oae.2.1691259849355;
        Sat, 05 Aug 2023 11:24:09 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id n32-20020a056870822000b001bba940cbe6sm2797029oae.28.2023.08.05.11.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 11:24:08 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <d144c814-6270-2b64-df78-25c8282050a9@lwfinger.net>
Date:   Sat, 5 Aug 2023 13:24:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: Regression in rtw89
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <813e9c3d-7fbd-7589-ebd0-6c61f03f970b@lwfinger.net>
 <c58758f5e2134ca19d9a11a0d54b96f1@realtek.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <c58758f5e2134ca19d9a11a0d54b96f1@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/3/23 19:54, Ping-Ke Shih wrote:
> As the commit message of the 26a125f550a3, PS was broken since v5.20, and that
> patch fixes it. The correct bisection is from initial version of 8852BE + this patch.
> (8852BE is introduced by kernel v6.2, and PS was broken at that time.)
> 
> As the discussion in github, it looks like a BT-coexistence problem, because
> Both WiFi-only and BT-only work. Please update BT driver and firmware to have
> below:
>   BT driver:
>     - Bluetooth: btrtl: Firmware format v2 support
>     - Bluetooth: btrtl: Add the support for RTL8851B
>   BT firmware: (copy all files from linux-firmware.git:/rtl_bt/)
>     - rtl_bt: Add firmware and config files for RTL8851B
> 
> Then, read btc_info in period of 2 seconds before and after entering PS.
> A sample script to capture log
>     while [ true ]; do cat /sys/kernel/debug/ieee80211/phy0/rtw89/btc_info; date; sleep 2; done
> And, use 'iw wlan0 set power_save on/off' to switch PS state. Also, please
> point out the time when BT goes wrong.
> 

Ping-Ke,

Thanks for the quick response. The OP is using kernel 6.4.7, thus his btrtl 
should be new enough. I copied the latest firmware in linux-firmware, and he 
copied it into the appropriate locations. That did not help.

I then had him create a script to capture the log. He found that BT goes wrong 
immediately as soon as power_save is set on. His logs were as follows:

*************************************************************************

First is when the problem started. It happened as soon as I enabled the 
power_save feature on my wifi card.

=========================================
WL FW / BT FW           0.29.29.1 / NA
manual                  0
=========================================

  [bt_info]       : raw_data[49 00 c5 00 04 7f] (type:auto/cnt:1576/same:1)
=========================================
========== [BTC COEX INFO (1)] ==========
  [coex_version]  : Coex:7.0.1(branch:19), WL_FW_coex:7.8.0(branch:29)(Match, 
desired:5.5.0), BT_FW_coex:7(Match, desired:5)
  [sub_module]    : WL_FW:0.29.29.1, BT_FW:0x1fc6b20f(patch)
  [hw_info]       : cv:1, rfe_type:0x1, ant_iso:10, ant_pg:2, 3rd_coex:0, 
dbcc:0, tx_num:2, rx_num:2
========== [WL Status] ==========
  [status]        : link_mode:9, rf_off:0, power_save:1, 
scan:N(band:1/phy_map:0x0), connecting:N, roam:N, 4way:N, init_ok:Y
  [port_0]        : role=1(phy-0), connect=2(client_cnt=-1), mode=3, 
center_ch=42, bw=2, mac_id=0, max_tx_time=0us, max_tx_retry=0
  [port_0]        : rssi=-59dBm(51), busy=0, dir=DL, tx[rate:260/busy_level:0], 
rx[rate:280/busy_level:0/drop:0]
========== [BT Status] ==========
  [status]        : enable:Y, btg:Y, connect:Y, igno_wl:N, mailbox_avl:Y, 
rfk_state:0x0
  [profile]       : profile:A2DP, multi-link:N, role:Master, ble-connect:N, 
CQDDR:N, A2DP_active:Y, PAN_active:N
  [link]          : rssi:-53dBm, tx_rate:3M,  acl_busy!! 
afh_map[ffff_ffff_ffff_f3f1_fffe], wl_ch_map[en:0/ch:0/bw:32]
  [stat_cnt]      : retry:0, relink:1, rate_chg:11, reinit:0, reenable:1, 
role-switch:0, afh:0, inq_page:1(inq:0/page:1), igno_wl:1
  [A2DP]          : type:Legacy, bit-pool:63, flush-time:0, vid:0xa, 
Dev-name:0x2d4857, sut_pwr:0, golden-rx:0
  [bt_info]       : raw_data[49 00 c5 00 04 7f] (type:auto/cnt:1576/same:1)
  [trx_req_cnt]   : Hi-rx = 178, Hi-tx = 0, Lo-rx = 546, Lo-tx = 546 
(bt_polut_wl_tx = 0)(BG:0-0/INIT:0-0/LE:0-0)
========== [Mechanism Status (Auto)] ==========
  [status]        : type:shared, reason:NTFY_RADIO_STATE(), action:WL_OFF(), 
ant_path:5, run_cnt:2220
  [dm_steps]      : -> UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0      -> 
NTFY_WL_STA         -> WL_5G          -> OFF_EQ0
  [dm_steps]      : -> UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0      -> 
UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0
  [dm_steps]      : -> UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0      -> 
UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0
  [dm_steps]      : -> UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0      -> 
UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0
  [dm_steps]      : -> NTFY_WL_STA         -> WL_5G          -> OFF_EQ0      -> 
NTFY_RADIO_STATE    -> WL_OFF         -> OFF_BT
  [dm_flag]       : wl_only:0, bt_only:0, igno_bt:1, free_run:0, wl_ps_ctrl:0, 
wl_mimo_ps:0, leak_ap:0, fw_offload:N
  [trx_ctrl]      : wl_rssi_lvl:3, para_lvl:0, wl_tx_pwr:orig, wl_rx_lvl:0, 
bt_tx_pwr_dec:0, bt_rx_lna:7(Ori-tbl), wl_btg_rx:0
  [dm_ctrl]       : wl_tx_limit[en:0/max_t:5280us/max_retry:31], 
bt_slot_reg:0-TU, bt_scan_rx_low_pri:0
  [tdma_policy]   : type:0, rx_flow_ctrl:0, tx_pause:0, wl_toggle_n:0, leak_n:0, 
ext_ctrl:0, policy_type:0
  [slot_list]     :   OFF[100/0xe5555555/0],   B2W[005/0xea5a5a5a/1], 
W1[070/0xea5a5a5a/1],    W2[015/0xea5a5a5a/1],   W2B[015/0xea5a5a5a/1]
  [slot_list]     :    B1[250/0xe5555555/0],    B2[007/0xea5a5a5a/0], 
B3[005/0xe5555555/0],    B4[050/0xe5555555/0],    LK[020/0xea5a5a5a/1]
  [slot_list]     :   BLK[500/0x55555555/0],   E2G[000/0xea5a5a5a/0], 
E5G[000/0xffffffff/1],   EBT[000/0xe5555555/0], ENULL[000/0xaaaaaaaa/1]
  [slot_list]     :   WLK[250/0xea5a5a5a/0], W1FDD[050/0xffffffff/1], 
B1FDD[050/0xffffdfff/1]
========== [HW Status] ==========
  [scoreboard]    : WL->BT:0x00004083(cnt:443), BT->WL:0x4001051b(total:219, 
bt_update:14)
  [reg]           : 0_0xda24=0xffffffff, 0_0xda28=0xffffffff, 
0_0xda2c=0xf0ffffff, 0_0xda30=0x00000008, 0_0xda4c=0x0000000d, 0_0xda10=0x00000100
  [reg]           : 0_0xda20=0x00000002, 0_0xda34=0x00000100, 
0_0xcef4=0x00000000, 0_0x8424=0x00000000, 0_0xd200=0x00000000, 0_0xd220=0x00000000
  [reg]           : 1_0x0980=0x10182250, 1_0x4738=0x8325c500, 
1_0x4688=0x1a10ff04, 1_0x4694=0x04fa2a2a
========== [Statistics] ==========
  [summary]       : h2c_cnt=886(fail:1), c2h_cnt=0
  [notify_cnt]    : total=821, show_coex_info=162, power_on=0, init_coex=1, 
power_off=0, radio_state=398, role_info=2, wl_rfk=5, wl_sta=238
  [notify_cnt]    : scan_start=2, scan_finish=2, switch_band=2, special_pkt=5, 
timer=4, control=0, customerize=0sam. 05 août 2023 10:18:38 CEST

*************************************************************************

Second is the output right before the previous one, when power_save was disabled 
and no issues were present.

=========================================
WL FW / BT FW           0.29.29.1 / NA
manual                  0
=========================================

  [bt_info]       : raw_data[49 00 c5 00 04 7f] (type:auto/cnt:1576/same:1)
=========================================
========== [BTC COEX INFO (1)] ==========
  [coex_version]  : Coex:7.0.1(branch:19), WL_FW_coex:7.8.0(branch:29)(Match, 
desired:5.5.0), BT_FW_coex:7(Match, desired:5)
  [sub_module]    : WL_FW:0.29.29.1, BT_FW:0x1fc6b20f(patch)
  [hw_info]       : cv:1, rfe_type:0x1, ant_iso:10, ant_pg:2, 3rd_coex:0, 
dbcc:0, tx_num:2, rx_num:2
========== [WL Status] ==========
  [status]        : link_mode:9, rf_off:0, power_save:0, 
scan:N(band:1/phy_map:0x0), connecting:N, roam:N, 4way:N, init_ok:Y
  [port_0]        : role=1(phy-0), connect=2(client_cnt=-1), mode=3, 
center_ch=42, bw=2, mac_id=0, max_tx_time=0us, max_tx_retry=0
  [port_0]        : rssi=-59dBm(51), busy=0, dir=DL, tx[rate:260/busy_level:0], 
rx[rate:280/busy_level:0/drop:0]
========== [BT Status] ==========
  [status]        : enable:Y, btg:Y, connect:Y, igno_wl:N, mailbox_avl:Y, 
rfk_state:0x0
  [profile]       : profile:A2DP, multi-link:N, role:Master, ble-connect:N, 
CQDDR:N, A2DP_active:Y, PAN_active:N
  [link]          : rssi:-53dBm, tx_rate:3M,  acl_busy!! 
afh_map[ffff_ffff_ffff_f3f1_fffe], wl_ch_map[en:0/ch:0/bw:32]
  [stat_cnt]      : retry:0, relink:1, rate_chg:11, reinit:0, reenable:1, 
role-switch:0, afh:0, inq_page:1(inq:0/page:1), igno_wl:1
  [A2DP]          : type:Legacy, bit-pool:63, flush-time:0, vid:0xa, 
Dev-name:0x2d4857, sut_pwr:0, golden-rx:0
  [bt_info]       : raw_data[49 00 c5 00 04 7f] (type:auto/cnt:1576/same:1)
  [trx_req_cnt]   : Hi-rx = 178, Hi-tx = 0, Lo-rx = 546, Lo-tx = 546 
(bt_polut_wl_tx = 0)(BG:0-0/INIT:0-0/LE:0-0)
========== [Mechanism Status (Auto)] ==========
  [status]        : type:shared, reason:NTFY_WL_STA(), action:WL_5G(), 
ant_path:5, run_cnt:2219
  [dm_steps]      : -> UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0      -> 
UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0
  [dm_steps]      : -> NTFY_WL_STA         -> WL_5G          -> OFF_EQ0      -> 
UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0
  [dm_steps]      : -> UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0      -> 
UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0
  [dm_steps]      : -> UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0      -> 
UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0
  [dm_steps]      : -> UPDATE_BT_INFO      -> WL_5G          -> OFF_EQ0      -> 
NTFY_WL_STA         -> WL_5G          -> OFF_EQ0
  [dm_flag]       : wl_only:0, bt_only:0, igno_bt:0, free_run:0, wl_ps_ctrl:0, 
wl_mimo_ps:0, leak_ap:0, fw_offload:N
  [trx_ctrl]      : wl_rssi_lvl:3, para_lvl:0, wl_tx_pwr:orig, wl_rx_lvl:0, 
bt_tx_pwr_dec:0, bt_rx_lna:7(Ori-tbl), wl_btg_rx:0
  [dm_ctrl]       : wl_tx_limit[en:0/max_t:5280us/max_retry:31], 
bt_slot_reg:0-TU, bt_scan_rx_low_pri:0
  [tdma_policy]   : type:0, rx_flow_ctrl:0, tx_pause:0, wl_toggle_n:0, leak_n:0, 
ext_ctrl:0, policy_type:2
  [slot_list]     :   OFF[100/0xffffffff/1],   B2W[005/0xea5a5a5a/1], 
W1[070/0xea5a5a5a/1],    W2[015/0xea5a5a5a/1],   W2B[015/0xea5a5a5a/1]
  [slot_list]     :    B1[250/0xe5555555/0],    B2[007/0xea5a5a5a/0], 
B3[005/0xe5555555/0],    B4[050/0xe5555555/0],    LK[020/0xea5a5a5a/1]
  [slot_list]     :   BLK[500/0x55555555/0],   E2G[000/0xea5a5a5a/0], 
E5G[000/0xffffffff/1],   EBT[000/0xe5555555/0], ENULL[000/0xaaaaaaaa/1]
  [slot_list]     :   WLK[250/0xea5a5a5a/0], W1FDD[050/0xffffffff/1], 
B1FDD[050/0xffffdfff/1]
========== [HW Status] ==========
  [scoreboard]    : WL->BT:0x00004083(cnt:443), BT->WL:0x4001051b(total:219, 
bt_update:14)
  [gnt_status]    : pta_owner:WL, phy-0[gnt_wl:SW-1/gnt_bt:HW-1], 
phy-1[gnt_wl:SW-1/gnt_bt:HW-1]
  [reg]           : 0_0xda24=0xffffffff, 0_0xda28=0xffffffff, 
0_0xda2c=0xf0ffffff, 0_0xda30=0x00000008, 0_0xda4c=0x0000000d, 0_0xda10=0x00000100
  [reg]           : 0_0xda20=0x00000002, 0_0xda34=0x00000100, 
0_0xcef4=0x00000000, 0_0x8424=0x00000000, 0_0xd200=0x00000000, 0_0xd220=0x00000000
  [reg]           : 1_0x0980=0x10182250, 1_0x4738=0x8325c500, 
1_0x4688=0x1a10ff04, 1_0x4694=0x04fa2a2a
========== [Statistics] ==========
  [summary]       : h2c_cnt=884(fail:1, fw_recv:1083), c2h_cnt=0(fw_send:2137, 
len:235), rpt_cnt=549(fw_send:548), rpt_map=0x64
  [mailbox]       : send_ok:192, send_fail:0, recv:48257, 
A2DP_empty:46499(stop:0, tx:181882, ack:170362, nack:2061)
  [RFK/LPS]       : wl_rfk[req:5/go:5/reject:0/tout:0], bt_rfk[req:0], 
AOAC[RF_on:2031/RF_off:2031]
  [notify_cnt]    : total=818, show_coex_info=160, power_on=0, init_coex=1, 
power_off=0, radio_state=397, role_info=2, wl_rfk=5, wl_sta=238
  [notify_cnt]    : scan_start=2, scan_finish=2, switch_band=2, special_pkt=5, 
timer=4, control=0, customerize=0sam. 05 août 2023 10:18:36 CEST

Thanks for your help.

Larry

