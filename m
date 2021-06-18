Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DAC3AC4B6
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 09:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhFRHNh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 03:13:37 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40528 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhFRHNh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 03:13:37 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15I7BMOU0016884, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15I7BMOU0016884
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Jun 2021 15:11:22 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 18 Jun 2021 15:11:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 18 Jun 2021 15:11:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28]) by
 RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28%5]) with mapi id
 15.01.2106.013; Fri, 18 Jun 2021 15:11:20 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Pkshih <pkshih@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 00/24] rtw89: add Realtek 802.11ax driver
Thread-Topic: [PATCH 00/24] rtw89: add Realtek 802.11ax driver
Thread-Index: AQHXZA3Ab/EhTauGgE2vb9Vy4ZBfAasZVKsA
Date:   Fri, 18 Jun 2021 07:11:20 +0000
Message-ID: <ac6c9122cb04498793bee926c2b7ee1f@realtek.com>
References: <20210618064625.14131-1-pkshih@realtek.com>
In-Reply-To: <20210618064625.14131-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/6/18_=3F=3F_06:01:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/18/2021 06:50:09
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 30
X-KSE-AntiSpam-Info: Lua profiles 164465 [Jun 18 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Prob_susp_to_in_reply, in_rep}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;github.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 30
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/18/2021 06:53:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Ping-Ke Shih [mailto:pkshih@realtek.com]
> Sent: Friday, June 18, 2021 2:46 PM
> To: kvalo@codeaurora.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [PATCH 00/24] rtw89: add Realtek 802.11ax driver

Sorry. I forget to add "v5" prefix, but I think it's confusing people if
I send this patchset again. 
 
> 
> This driver named rtw89, which is the next generation of rtw88, supports
> Realtek 8852AE 802.11ax 2x2 chip whose new features are OFDMA, DBCC,
> Spatial reuse, TWT and BSS coloring; now some of them aren't implemented
> though.
> 
> The chip architecture is entirely different from the chips supported by
> rtw88 like RTL8822CE 802.11ac chip. First of all, register address ranges
> are totally redefined, so it's impossible to reuse register definition. To
> communicate with firmware, new H2C/C2H format is proposed. In order to have
> better utilization, TX DMA flow is changed to two stages DMA. To provide
> rich RX status information, additional RX PPDU packets are added.
> 
> Since there are so many differences mentioned above, we decide to propose
> a new driver. It has many authors, they are listed in alphabetic order:
> 
> Chin-Yen Lee <timlee@realtek.com>
> Ping-Ke Shih <pkshih@realtek.com>
> Po Hao Huang <phhuang@realtek.com>
> Tzu-En Huang <tehuang@realtek.com>
> Vincent Fann <vincent_fann@realtek.com>
> Yan-Hsuan Chuang <tony0620emma@gmail.com>
> Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> v5:
>   - add OFDMA feature
>   - improve BT coexistence performance
>   - improve power save mode
>   - support SAR
>   - fine tune performance
>   - firmware: rtw89: 8852a: update fw to v0.13.24.0
>     https://github.com/pkshih/linux-firmware.git
>     pick the commit a5b79c4790da3eb3690e23554225ef8db464f2c6
> v4:
>   - add basic BT coexistence features
>   - add power save mode, so an new patch (two files) is added
>   - fine tune performance
>   - add debugfs for debugging coex, bb, ...
> v3:
>   - fix "networking block comments" reported by checkpatch
>   - Add MODULE_DEVICE_TABLE() generated by Thomas Backlund <tmb@mageia.org>
>   - Add missed BB settings
>   - error handle of RX BD and DESC length
>   - reduce debug level of C2H ACKs
>   - fix rekey failure due to wrong operator
> v2:
>   - fix compiler warnings made by W=1
>     Reported-by: kernel test robot <lkp@intel.com>
>   - sort header file alphabetically
>   - fix "networking block comments" reported by checkpatch
> 

Hi Kalle and wireless experts,

I submitted first version of rtw89 at the end of 2020, and continue to add
features and fine tune driver by following versions. After half year
development, I think this driver has been stable, so I'd like to inquiry if
experts have time to help review this driver. Not only reviewing but you want
to verify this driver, a 8852AE demoboard is needed; please feel free to
contact me privately.

--
Ping-Ke

