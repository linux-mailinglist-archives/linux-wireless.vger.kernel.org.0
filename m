Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418E9286C5A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 03:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgJHBKq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Oct 2020 21:10:46 -0400
Received: from 6.mo175.mail-out.ovh.net ([46.105.47.107]:58449 "EHLO
        6.mo175.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgJHBKq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Oct 2020 21:10:46 -0400
X-Greylist: delayed 16799 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 21:10:44 EDT
Received: from mxplan8.mail.ovh.net (unknown [10.109.143.21])
        by mo175.mail-out.ovh.net (Postfix) with ESMTPS id 8068F3C5C076;
        Wed,  7 Oct 2020 22:23:39 +0200 (CEST)
Received: from awhome.eu (37.59.142.99) by mxplan8.mail.ovh.net (172.16.2.1)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2044.4; Wed, 7 Oct 2020
 22:23:38 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-99G00397a64730-54ee-41b6-80d3-c4b321476687,
                    ACC92CD9FBCBF345917947E6A3A38F7D35137F5D) smtp.auth=postmaster@awhome.eu
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1602102212;
        bh=aQmlGPMYy1nUBL/E0J4UjwGdaSrnH2Hwlb1yEPs7tUc=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To;
        b=fI5PjDMnTH8zLcFAgsS9AlZTEPiJNEV6jBD057mDh5/Cv/yCglCJGrD3Ck6qrxvkd
         vPNsvtisnt2CTQ5ij5oJyNz8zJhBfw12icLx04nw1JXS/P92WcvkvjDZncZigkSGoj
         v2V2VorqoFkhVGAIcNeENAZCFtawu8e6BWf1oVkU=
Subject: [REGRESSION] Re: [PATCH 10/12] iwlwifi: remove wide_cmd_header field
To:     Luca Coelho <luca@coelho.fi>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
References: <20200928092321.649185-1-luca@coelho.fi>
 <iwlwifi.20200928121852.e6137861d917.I93405604eb503568688b28d3169fea7fbb88ed7e@changeid>
Message-ID: <f20c67c4-3b9b-acc7-5e8c-998ddaf6b6ec@wetzel-home.de>
Date:   Wed, 7 Oct 2020 22:23:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <iwlwifi.20200928121852.e6137861d917.I93405604eb503568688b28d3169fea7fbb88ed7e@changeid>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-GUID: c59fa77d-034b-4f70-bd12-41bed3017cc6
X-Ovh-Tracer-Id: 2579155214157290717
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeeigdduheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffuvfhfkffffgggjggtgfesthejredttdefjeenucfhrhhomheptehlvgigrghnuggvrhcuhggvthiivghluceorghlvgigrghnuggvrhesfigvthiivghlqdhhohhmvgdruggvqeenucggtffrrghtthgvrhhnpeejtedvhefhheegieeutdeuheetlefhveefleelffffieeuleehieffleefgeeifeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnkedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrlhgvgigrnhguvghrseifvghtiigvlhdqhhhomhgvrdguvgdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 28.09.20 um 11:23 schrieb Luca Coelho:
> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> 
> Driver doesn't support fw without wide_cmd
> so driver always sets it to true.  instead of setting
> it always to true just remove the field.
> 

I guess that's only true for mvm but not dvm...

At least this patch kills my wireless using a Ultimate-N 6300.
Reverting to commit on top of wt-2020-10-06 works.

Here the last error I got during git bisect:


[  375.671958] iwlwifi 0000:03:00.0: Radio type=0x0-0x3-0x1
[  375.739218] iwlwifi 0000:03:00.0: Microcode SW error detected. 
Restarting 0x82000000.
[  375.739226] iwlwifi 0000:03:00.0: Loaded firmware version: 9.221.4.1 
build 25532 6000-4.ucode
[  375.739349] iwlwifi 0000:03:00.0: Start IWL Error Log Dump:
[  375.739353] iwlwifi 0000:03:00.0: Status: 0x00000000, count: 5
[  375.739357] iwlwifi 0000:03:00.0: 0x00000007 | BAD_COMMAND
[  375.739361] iwlwifi 0000:03:00.0: 0x00000D10 | uPc
[  375.739365] iwlwifi 0000:03:00.0: 0x00000D0E | branchlink1
[  375.739368] iwlwifi 0000:03:00.0: 0x00000D0E | branchlink2
[  375.739372] iwlwifi 0000:03:00.0: 0x000014DE | interruptlink1
[  375.739376] iwlwifi 0000:03:00.0: 0x00000000 | interruptlink2
[  375.739380] iwlwifi 0000:03:00.0: 0x00000000 | data1
[  375.739383] iwlwifi 0000:03:00.0: 0x00000001 | data2
[  375.739387] iwlwifi 0000:03:00.0: 0x00000463 | line
[  375.739391] iwlwifi 0000:03:00.0: 0x0000B337 | beacon time
[  375.739394] iwlwifi 0000:03:00.0: 0x0000DCC9 | tsf low
[  375.739398] iwlwifi 0000:03:00.0: 0x00000000 | tsf hi
[  375.739402] iwlwifi 0000:03:00.0: 0x00000000 | time gp1
[  375.739406] iwlwifi 0000:03:00.0: 0x0000DCCD | time gp2
[  375.739409] iwlwifi 0000:03:00.0: 0x00000000 | time gp3
[  375.739413] iwlwifi 0000:03:00.0: 0x000109DD | uCode version
[  375.739417] iwlwifi 0000:03:00.0: 0x00000074 | hw version
[  375.739420] iwlwifi 0000:03:00.0: 0x0048D304 | board version
[  375.739424] iwlwifi 0000:03:00.0: 0x00704001 | hcmd
[  375.739427] iwlwifi 0000:03:00.0: 0x00122080 | isr0
[  375.739431] iwlwifi 0000:03:00.0: 0x00000000 | isr1
[  375.739435] iwlwifi 0000:03:00.0: 0x00000002 | isr2
[  375.739438] iwlwifi 0000:03:00.0: 0x014400C0 | isr3
[  375.739442] iwlwifi 0000:03:00.0: 0x00000000 | isr4
[  375.739446] iwlwifi 0000:03:00.0: 0x01000112 | isr_pref
[  375.739449] iwlwifi 0000:03:00.0: 0x0001BB08 | wait_event
[  375.739453] iwlwifi 0000:03:00.0: 0x00000000 | l2p_control
[  375.739457] iwlwifi 0000:03:00.0: 0x00000000 | l2p_duration
[  375.739460] iwlwifi 0000:03:00.0: 0x00000000 | l2p_mhvalid
[  375.739464] iwlwifi 0000:03:00.0: 0x00000000 | l2p_addr_match
[  375.739468] iwlwifi 0000:03:00.0: 0x00000047 | lmpm_pmg_sel
[  375.739471] iwlwifi 0000:03:00.0: 0x02061040 | timestamp
[  375.739475] iwlwifi 0000:03:00.0: 0x00000008 | flow_handler
[  375.739555] iwlwifi 0000:03:00.0: Log capacity 1024 is bogus, limit 
to 512 entries
[  375.739559] iwlwifi 0000:03:00.0: Start IWL Event Log Dump: display 
last 20 entries
[  375.739608] iwlwifi 0000:03:00.0: EVT_LOGT:0000056468:0x00000054:1334
[  375.739646] iwlwifi 0000:03:00.0: EVT_LOGT:0000056469:0x01508c46:1334
[  375.739680] iwlwifi 0000:03:00.0: EVT_LOGT:0000056470:0x00000017:0484
[  375.739714] iwlwifi 0000:03:00.0: EVT_LOGT:0000056471:0x00000000:1334
[  375.739749] iwlwifi 0000:03:00.0: EVT_LOGT:0000056475:0x00000000:1334
[  375.739782] iwlwifi 0000:03:00.0: EVT_LOGT:0000056479:0x00000046:1334
[  375.739816] iwlwifi 0000:03:00.0: EVT_LOGT:0000056479:0x00000046:1334
[  375.739850] iwlwifi 0000:03:00.0: EVT_LOGT:0000056481:0x00000000:1334
[  375.739883] iwlwifi 0000:03:00.0: EVT_LOGT:0000056485:0x00000000:1334
[  375.739917] iwlwifi 0000:03:00.0: EVT_LOGT:0000056488:0x00000046:1334
[  375.739950] iwlwifi 0000:03:00.0: EVT_LOGT:0000056489:0x00008c46:1334
[  375.739984] iwlwifi 0000:03:00.0: EVT_LOGT:0000056490:0x00000000:1334
[  375.740017] iwlwifi 0000:03:00.0: EVT_LOGT:0000056494:0x00000000:1334
[  375.740051] iwlwifi 0000:03:00.0: EVT_LOGT:0000056497:0x00000054:1334
[  375.740085] iwlwifi 0000:03:00.0: EVT_LOGT:0000056498:0x01508c46:1334
[  375.740119] iwlwifi 0000:03:00.0: EVT_LOGT:0000056499:0x00000018:0484
[  375.740152] iwlwifi 0000:03:00.0: EVT_LOGT:0000056506:0x00000019:0484
[  375.740186] iwlwifi 0000:03:00.0: EVT_LOGT:0000056515:0x00000000:0661
[  375.740226] iwlwifi 0000:03:00.0: EVT_LOGT:0000056521:0x00704001:0401
[  375.740259] iwlwifi 0000:03:00.0: EVT_LOGT:0000056542:0x00000100:0125
[  375.740315] iwlwifi 0000:03:00.0: Error Reply type 0x00000000 cmd 
REPLY_ERROR (0x01) seq 0x0070 ser 0x00000001
[  375.740339] iwlwifi 0000:03:00.0: FW error in SYNC CMD UNKNOWN
[  375.740347] CPU: 6 PID: 354 Comm: wpa_supplicant Tainted: G       T 
5.9.0-rc6+ #33
[  375.740351] Hardware name: LENOVO 2438CTO/2438CTO, BIOS G5ETB6WW 
(2.76 ) 09/09/2019
[  375.740356] Call Trace:
[  375.740366]  dump_stack+0x77/0xa0
[  375.740380]  iwl_trans_pcie_send_hcmd+0x43e/0x450 [iwlwifi]
[  375.740387]  ? wait_woken+0xb0/0xb0
[  375.740397]  iwl_trans_send_cmd+0x73/0x160 [iwlwifi]
[  375.740406]  iwl_send_calib_results+0x79/0xd0 [iwldvm]
[  375.740414]  iwl_load_ucode_wait_alive+0x184/0x1d0 [iwldvm]
[  375.740421]  ? iwl_send_calib_cfg+0xc0/0xc0 [iwldvm]
[  375.740426]  ? __local_bh_enable_ip+0x74/0xb0
[  375.740433]  iwl_run_init_ucode+0x90/0x130 [iwldvm]
[  375.740439]  ? iwl_alive_fn+0x80/0x80 [iwldvm]
[  375.740446]  iwlagn_mac_start+0xd2/0x2a0 [iwldvm]
[  375.740466]  drv_start+0x79/0x230 [mac80211]
[  375.740483]  ieee80211_do_open+0x1c4/0xb30 [mac80211]
[  375.740499]  ? ieee80211_check_concurrent_iface+0x151/0x1c0 [mac80211]
[  375.740505]  __dev_open+0xed/0x1a0
[  375.740511]  __dev_change_flags+0x1a0/0x200
[  375.740515]  ? dev_load+0x69/0x140
[  375.740520]  dev_change_flags+0x21/0x60
[  375.740525]  devinet_ioctl+0x701/0x8f0
[  375.740530]  inet_ioctl+0x194/0x1d0
[  375.740536]  sock_do_ioctl+0x3e/0x130
[  375.740542]  sock_ioctl+0x259/0x3e0
[  375.740548]  __x64_sys_ioctl+0x8d/0xc0
[  375.740554]  do_syscall_64+0x33/0x80
[  375.740560]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  375.740565] RIP: 0033:0x7fc781e68fd7
[  375.740570] Code: 89 d8 48 f7 d8 49 39 c4 72 b9 e8 24 ff ff ff 85 c0 
78 be 5b 4c 89 e0 5d 41 5c c3 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 61 5e 0c 00 f7 d8 64 89 01 48
[  375.740575] RSP: 002b:00007fffb94c1828 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  375.740580] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
00007fc781e68fd7
[  375.740584] RDX: 00007fffb94c1830 RSI: 0000000000008914 RDI: 
0000000000000007
[  375.740588] RBP: 0000000000000007 R08: 0000000000000007 R09: 
0000560db64d3010
[  375.740592] R10: 00007fc781f2fba0 R11: 0000000000000246 R12: 
0000000000000000
[  375.740596] R13: 0000560db64e93a0 R14: 00007fffb94c1830 R15: 
0000000000000000
[  375.740602] iwlwifi 0000:03:00.0: Error -5 on calib cmd 15
[  375.740608] iwlwifi 0000:03:00.0: Could not complete ALIVE transition: -5
[  375.752211] iwlwifi 0000:03:00.0: Failed to run INIT ucode: -5
[  375.752251] iwlwifi 0000:03:00.0: Unable to initialize device.
[  375.752305] ieee80211 phy4: Hardware restart was requested
[  375.766178] iwlwifi 0000:03:00.0: Radio type=0x0-0x3-0x1
[  375.829450] iwlwifi 0000:03:00.0: Microcode SW error detected. 
Restarting 0x82000000.
[  375.829482] iwlwifi 0000:03:00.0: Loaded firmware version: 9.221.4.1 
build 25532 6000-4.ucode
[  375.829630] iwlwifi 0000:03:00.0: Start IWL Error Log Dump:
[  375.829634] iwlwifi 0000:03:00.0: Status: 0x00000000, count: 5
[  375.829638] iwlwifi 0000:03:00.0: 0x00000007 | BAD_COMMAND
[  375.829641] iwlwifi 0000:03:00.0: 0x00000D10 | uPc
[  375.829645] iwlwifi 0000:03:00.0: 0x00000D0E | branchlink1
[  375.829648] iwlwifi 0000:03:00.0: 0x00000D0E | branchlink2
[  375.829652] iwlwifi 0000:03:00.0: 0x000014DE | interruptlink1
[  375.829655] iwlwifi 0000:03:00.0: 0x00000000 | interruptlink2
[  375.829659] iwlwifi 0000:03:00.0: 0x00000000 | data1
[  375.829663] iwlwifi 0000:03:00.0: 0x00000001 | data2
[  375.829666] iwlwifi 0000:03:00.0: 0x00000463 | line
[  375.829670] iwlwifi 0000:03:00.0: 0x0000C31E | beacon time
[  375.829673] iwlwifi 0000:03:00.0: 0x0000CCE2 | tsf low
[  375.829677] iwlwifi 0000:03:00.0: 0x00000000 | tsf hi
[  375.829680] iwlwifi 0000:03:00.0: 0x00000000 | time gp1
[  375.829684] iwlwifi 0000:03:00.0: 0x0000CCE7 | time gp2
[  375.829687] iwlwifi 0000:03:00.0: 0x00000000 | time gp3
[  375.829691] iwlwifi 0000:03:00.0: 0x000109DD | uCode version
[  375.829695] iwlwifi 0000:03:00.0: 0x00000074 | hw version
[  375.829698] iwlwifi 0000:03:00.0: 0x0048D304 | board version
[  375.829702] iwlwifi 0000:03:00.0: 0x00704001 | hcmd
[  375.829705] iwlwifi 0000:03:00.0: 0x00122080 | isr0
[  375.829709] iwlwifi 0000:03:00.0: 0x00000000 | isr1
[  375.829712] iwlwifi 0000:03:00.0: 0x00000002 | isr2
[  375.829716] iwlwifi 0000:03:00.0: 0x014000C0 | isr3
[  375.829719] iwlwifi 0000:03:00.0: 0x00000000 | isr4
[  375.829723] iwlwifi 0000:03:00.0: 0x01000112 | isr_pref
[  375.829726] iwlwifi 0000:03:00.0: 0x0001BB08 | wait_event
[  375.829730] iwlwifi 0000:03:00.0: 0x00000000 | l2p_control
[  375.829733] iwlwifi 0000:03:00.0: 0x00000000 | l2p_duration
[  375.829737] iwlwifi 0000:03:00.0: 0x00000000 | l2p_mhvalid
[  375.829740] iwlwifi 0000:03:00.0: 0x00000000 | l2p_addr_match
[  375.829744] iwlwifi 0000:03:00.0: 0x00000047 | lmpm_pmg_sel
[  375.829747] iwlwifi 0000:03:00.0: 0x02061040 | timestamp
[  375.829751] iwlwifi 0000:03:00.0: 0x00000008 | flow_handler
[  375.829832] iwlwifi 0000:03:00.0: Log capacity 1024 is bogus, limit 
to 512 entries
[  375.829836] iwlwifi 0000:03:00.0: Start IWL Event Log Dump: display 
last 20 entries
[  375.829880] iwlwifi 0000:03:00.0: EVT_LOGT:0000052398:0x00000054:1334
[  375.829918] iwlwifi 0000:03:00.0: EVT_LOGT:0000052399:0x01508c46:1334
[  375.829951] iwlwifi 0000:03:00.0: EVT_LOGT:0000052400:0x00000017:0484
[  375.829985] iwlwifi 0000:03:00.0: EVT_LOGT:0000052402:0x00000000:1334
[  375.830018] iwlwifi 0000:03:00.0: EVT_LOGT:0000052405:0x00000000:1334
[  375.830052] iwlwifi 0000:03:00.0: EVT_LOGT:0000052409:0x00000046:1334
[  375.830086] iwlwifi 0000:03:00.0: EVT_LOGT:0000052409:0x00000046:1334
[  375.830120] iwlwifi 0000:03:00.0: EVT_LOGT:0000052411:0x00000000:1334
[  375.830153] iwlwifi 0000:03:00.0: EVT_LOGT:0000052415:0x00000000:1334
[  375.830187] iwlwifi 0000:03:00.0: EVT_LOGT:0000052418:0x00000046:1334
[  375.830221] iwlwifi 0000:03:00.0: EVT_LOGT:0000052419:0x00008c46:1334
[  375.830254] iwlwifi 0000:03:00.0: EVT_LOGT:0000052420:0x00000000:1334
[  375.830288] iwlwifi 0000:03:00.0: EVT_LOGT:0000052424:0x00000000:1334
[  375.830321] iwlwifi 0000:03:00.0: EVT_LOGT:0000052427:0x00000054:1334
[  375.830355] iwlwifi 0000:03:00.0: EVT_LOGT:0000052428:0x01508c46:1334
[  375.830388] iwlwifi 0000:03:00.0: EVT_LOGT:0000052429:0x00000018:0484
[  375.830422] iwlwifi 0000:03:00.0: EVT_LOGT:0000052436:0x00000019:0484
[  375.830455] iwlwifi 0000:03:00.0: EVT_LOGT:0000052445:0x00000000:0661
[  375.830489] iwlwifi 0000:03:00.0: EVT_LOGT:0000052451:0x00704001:0401
[  375.830522] iwlwifi 0000:03:00.0: EVT_LOGT:0000052471:0x00000100:0125
[  375.830604] iwlwifi 0000:03:00.0: Error Reply type 0x00000000 cmd 
REPLY_ERROR (0x01) seq 0x0070 ser 0x00000001
[  375.830615] iwlwifi 0000:03:00.0: FW error in SYNC CMD UNKNOWN
[  375.830624] CPU: 6 PID: 354 Comm: wpa_supplicant Tainted: G       T 
5.9.0-rc6+ #33
[  375.830629] Hardware name: LENOVO 2438CTO/2438CTO, BIOS G5ETB6WW 
(2.76 ) 09/09/2019
[  375.830633] Call Trace:
[  375.830644]  dump_stack+0x77/0xa0
[  375.830668]  iwl_trans_pcie_send_hcmd+0x43e/0x450 [iwlwifi]
[  375.830675]  ? wait_woken+0xb0/0xb0
[  375.830685]  iwl_trans_send_cmd+0x73/0x160 [iwlwifi]
[  375.830694]  iwl_send_calib_results+0x79/0xd0 [iwldvm]
[  375.830701]  iwl_load_ucode_wait_alive+0x184/0x1d0 [iwldvm]
[  375.830708]  ? iwl_send_calib_cfg+0xc0/0xc0 [iwldvm]
[  375.830713]  ? __local_bh_enable_ip+0x74/0xb0
[  375.830720]  iwl_run_init_ucode+0x90/0x130 [iwldvm]
[  375.830726]  ? iwl_alive_fn+0x80/0x80 [iwldvm]
[  375.830732]  iwlagn_mac_start+0xd2/0x2a0 [iwldvm]
[  375.830752]  drv_start+0x79/0x230 [mac80211]
[  375.830769]  ieee80211_do_open+0x1c4/0xb30 [mac80211]
[  375.830784]  ? ieee80211_check_concurrent_iface+0x151/0x1c0 [mac80211]
[  375.830791]  __dev_open+0xed/0x1a0
[  375.830796]  __dev_change_flags+0x1a0/0x200
[  375.830801]  ? dev_load+0x69/0x140
[  375.830806]  dev_change_flags+0x21/0x60
[  375.830811]  devinet_ioctl+0x701/0x8f0
[  375.830816]  inet_ioctl+0x194/0x1d0
[  375.830822]  sock_do_ioctl+0x3e/0x130
[  375.830827]  sock_ioctl+0x259/0x3e0
[  375.830833]  __x64_sys_ioctl+0x8d/0xc0
[  375.830838]  do_syscall_64+0x33/0x80
[  375.830845]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  375.830850] RIP: 0033:0x7fc781e68fd7
[  375.830856] Code: 89 d8 48 f7 d8 49 39 c4 72 b9 e8 24 ff ff ff 85 c0 
78 be 5b 4c 89 e0 5d 41 5c c3 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 61 5e 0c 00 f7 d8 64 89 01 48
[  375.830860] RSP: 002b:00007fffb94c16c8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  375.830865] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
00007fc781e68fd7
[  375.830869] RDX: 00007fffb94c16d0 RSI: 0000000000008914 RDI: 
0000000000000008
[  375.830873] RBP: 0000000000000008 R08: 0000000000000000 R09: 
0000000000000007
[  375.830877] R10: ffffffffffffffc8 R11: 0000000000000246 R12: 
0000000000000000
[  375.830881] R13: 0000560db6511e98 R14: 00007fffb94c16d0 R15: 
00007fffb94c1830
[  375.830887] iwlwifi 0000:03:00.0: Error -5 on calib cmd 15
[  375.830893] iwlwifi 0000:03:00.0: Could not complete ALIVE transition: -5
[  375.842315] iwlwifi 0000:03:00.0: Failed to run INIT ucode: -5
[  375.842360] iwlwifi 0000:03:00.0: Unable to initialize device.
[  375.842419] ieee80211 phy4: Hardware restart was requested
