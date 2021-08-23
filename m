Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B77D3F431F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 03:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhHWBik convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Aug 2021 21:38:40 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54390 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhHWBij (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Aug 2021 21:38:39 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 17N1bYeS5010968, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 17N1bYeS5010968
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Aug 2021 09:37:34 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 23 Aug 2021 09:37:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 23 Aug 2021 09:37:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Mon, 23 Aug 2021 09:37:32 +0800
From:   Pkshih <pkshih@realtek.com>
To:     kernel test robot <lkp@intel.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v6 24/24] rtw89: add Kconfig and Makefile
Thread-Topic: [PATCH v6 24/24] rtw89: add Kconfig and Makefile
Thread-Index: AQHXlX0xpCE0hegcRECFLaWxl/538at+XqMAgAH08qA=
Date:   Mon, 23 Aug 2021 01:37:32 +0000
Message-ID: <a91a82ca75174a138c50c013a1135641@realtek.com>
References: <20210820043538.12424-25-pkshih@realtek.com>
 <202108221143.6tdhCMqC-lkp@intel.com>
In-Reply-To: <202108221143.6tdhCMqC-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/8/22_=3F=3F_10:00:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/23/2021 01:21:35
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165716 [Aug 23 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c
X-KSE-AntiSpam-Info: {Headers: Tracking_susp_links, url2}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;github.com:7.1.1;realtek.com:7.1.1;raw.githubusercontent.com:7.1.1;127.0.0.199:7.1.2;git.kernel.org:7.1.1;git-scm.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/23/2021 01:23:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kernel test robot [mailto:lkp@intel.com]
> Sent: Sunday, August 22, 2021 11:43 AM
> To: Pkshih; kvalo@codeaurora.org
> Cc: clang-built-linux@googlegroups.com; kbuild-all@lists.01.org; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v6 24/24] rtw89: add Kconfig and Makefile
> 
> Hi Ping-Ke,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on wireless-drivers-next/master]
> [also build test WARNING on wireless-drivers/master v5.14-rc6 next-20210820]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:
> https://github.com/0day-ci/linux/commits/Ping-Ke-Shih/rtw89-add-Realtek-802-11ax-driver/20210820-1
> 24025
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
> config: i386-randconfig-a015-20210822 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project
> 9e9d70591e72fc6762b4b9a226b68ed1307419bf)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
> ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/6c4e6c23950c253389ad130ffe0367bbca3af99e
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review
> Ping-Ke-Shih/rtw89-add-Realtek-802-11ax-driver/20210820-124025
>         git checkout 6c4e6c23950c253389ad130ffe0367bbca3af99e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/net/wireless/realtek/rtw89/phy.c:1522:6: warning: variable 'active_entry' set but not used
> [-Wunused-but-set-variable]
>            u64 active_entry = 0;
>                ^
>    1 warning generated.
> 

[...]

Thanks for the finding. I'll remove this variable.

Ping-Ke

