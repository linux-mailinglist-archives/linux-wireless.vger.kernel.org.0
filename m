Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508BA3D85AE
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jul 2021 03:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhG1Bwl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 21:52:41 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:56421 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbhG1Bwl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 21:52:41 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16S1qOXJ1001018, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16S1qOXJ1001018
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 09:52:24 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 28 Jul 2021 09:52:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 28 Jul 2021 09:52:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91]) by
 RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91%5]) with mapi id
 15.01.2106.013; Wed, 28 Jul 2021 09:52:22 +0800
From:   Pkshih <pkshih@realtek.com>
To:     kernel test robot <lkp@intel.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>
Subject: RE: [PATCH 3/4] rtw88: wow: report wow reason through mac80211 api
Thread-Topic: [PATCH 3/4] rtw88: wow: report wow reason through mac80211 api
Thread-Index: AQHXgs50ScP7mMNnIky6rgj1HURcV6tXCieAgACWN3A=
Date:   Wed, 28 Jul 2021 01:52:22 +0000
Message-ID: <c8741e12d6b8499895a5da97ee08c26f@realtek.com>
References: <20210727100046.30116-4-pkshih@realtek.com>
 <202107280846.9pimJdSE-lkp@intel.com>
In-Reply-To: <202107280846.9pimJdSE-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/7/27_=3F=3F_07:42:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/28/2021 01:38:15
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165288 [Jul 28 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 449 449 5db59deca4a4f5e6ea34a93b13bc730e229092f4
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: git-scm.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;github.com:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;raw.githubusercontent.com:7.1.1;git.kernel.org:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/28/2021 01:41:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kernel test robot [mailto:lkp@intel.com]
> Sent: Wednesday, July 28, 2021 8:53 AM
> To: Pkshih; tony0620emma@gmail.com; kvalo@codeaurora.org
> Cc: kbuild-all@lists.01.org; linux-wireless@vger.kernel.org; Timlee
> Subject: Re: [PATCH 3/4] rtw88: wow: report wow reason through mac80211 api
> 
> Hi Ping-Ke,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on wireless-drivers-next/master]
> [also build test ERROR on v5.14-rc3 next-20210727]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:
> https://github.com/0day-ci/linux/commits/Ping-Ke-Shih/rtw88-fix-WoWLAN-function-and-report-reason-
> to-mac80211/20210727-180221
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
> config: parisc-allyesconfig (attached as .config)
> compiler: hppa-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
> ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/97da528a8da3f33ccd9f58ed43d008b51c6d19d9
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review
> Ping-Ke-Shih/rtw88-fix-WoWLAN-function-and-report-reason-to-mac80211/20210727-180221
>         git checkout 97da528a8da3f33ccd9f58ed43d008b51c6d19d9
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=parisc
> SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    hppa-linux-ld: drivers/net/wireless/realtek/rtw88/wow.o: in function
> `rtw_wow_show_wakeup_reason':
> >> (.text+0x6c4): undefined reference to `ieee80211_report_wowlan_wakeup'
> >> hppa-linux-ld: (.text+0x6e0): undefined reference to `ieee80211_report_wowlan_wakeup'
> 

Without CONFIG_PM, we don't need to build drivers/net/wireless/realtek/rtw88/wow.c.
Fix this by [1].

[1] https://lore.kernel.org/linux-wireless/20210728014335.8785-1-pkshih@realtek.com/T/#t

Ping-Ke

