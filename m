Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8992A3B3FD4
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jun 2021 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhFYI4k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Jun 2021 04:56:40 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48021 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYI4j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Jun 2021 04:56:39 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15P8s5821030996, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15P8s5821030996
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Jun 2021 16:54:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 25 Jun 2021 16:54:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 25 Jun 2021 16:54:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28]) by
 RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28%5]) with mapi id
 15.01.2106.013; Fri, 25 Jun 2021 16:54:02 +0800
From:   Pkshih <pkshih@realtek.com>
To:     kernel test robot <lkp@intel.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 24/24] rtw89: add Kconfig and Makefile
Thread-Topic: [PATCH 24/24] rtw89: add Kconfig and Makefile
Thread-Index: AQHXZA3/gygKxWxVIkmnIRuN2uKgWqsaJWEAgApRWYA=
Date:   Fri, 25 Jun 2021 08:54:02 +0000
Message-ID: <2e481f39632f44329ccf976ec7733775@realtek.com>
References: <20210618064625.14131-25-pkshih@realtek.com>
 <202106191135.vXd3K8Ik-lkp@intel.com>
In-Reply-To: <202106191135.vXd3K8Ik-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/6/24_=3F=3F_10:27:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?us-ascii?Q?Clean,_bases:_2021/6/25_=3F=3F_06:01:00?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/25/2021 08:33:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164617 [Jun 25 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Headers: Tracking_susp_links, url2}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;raw.githubusercontent.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1;git-scm.com:7.1.1;github.com:7.1.1;git.kernel.org:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/25/2021 08:35:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kernel test robot [mailto:lkp@intel.com]
> Sent: Saturday, June 19, 2021 11:19 AM
> To: Pkshih; kvalo@codeaurora.org
> Cc: kbuild-all@lists.01.org; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH 24/24] rtw89: add Kconfig and Makefile
> 
> Hi Ping-Ke,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on wireless-drivers-next/master]
> [also build test ERROR on wireless-drivers/master v5.13-rc6 next-20210618]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:
> https://github.com/0day-ci/linux/commits/Ping-Ke-Shih/rtw89-add-Realtek-802-11ax-driver/20210618-1
> 45007
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
> ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/f768bef58aeecd255f4cf55d014c36c91e183065
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review
> Ping-Ke-Shih/rtw89-add-Realtek-802-11ax-driver/20210618-145007
>         git checkout f768bef58aeecd255f4cf55d014c36c91e183065
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "__udivdi3" [drivers/net/wireless/realtek/rtw89/rtw89_core.ko] undefined!
> 

Will fix it by DIV_ROUND_DOWN_ULL() in next submission.

--
Ping-Ke


