Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7371E10868E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 03:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKYCmU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Nov 2019 21:42:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:44077 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfKYCmU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Nov 2019 21:42:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 18:42:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600"; 
   d="scan'208";a="358699863"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Nov 2019 18:42:16 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iZ4KN-000BNh-TW; Mon, 25 Nov 2019 10:42:15 +0800
Date:   Mon, 25 Nov 2019 10:42:06 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     kbuild-all@lists.01.org, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH 4/4] rtlwifi: rtl8192de: Convert inline routines to
 little-endian words
Message-ID: <201911251054.NQcrqhia%lkp@intel.com>
References: <20191121214417.29676-5-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121214417.29676-5-Larry.Finger@lwfinger.net>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

I love your patch! Perhaps something to improve:

[auto build test WARNING on wireless-drivers-next/master]
[also build test WARNING on next-20191122]
[cannot apply to v5.4-rc8]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Larry-Finger/rtlwifi-rtl8192de-Replace-local-TX-and-RX-bit-manipulation-macro/20191124-122525
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-36-g9305d48-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:445:43: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:445:43: sparse:    expected unsigned int [usertype] *__pdesc
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:445:43: sparse:    got restricted __le32 [usertype] *pdesc
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:256:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:256:30: sparse:    expected restricted __le32 [usertype] v
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:256:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:447:50: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:447:50: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:447:50: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:231:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:231:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:231:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:448:64: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:448:64: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:448:64: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:246:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:246:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:246:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:450:53: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:450:53: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:450:53: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:251:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:251:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:251:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:451:43: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:451:43: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:451:43: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:241:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:241:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:241:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:452:45: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:452:45: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:452:45: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:236:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:236:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:236:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:454:47: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:454:47: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:454:47: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:261:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:261:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:261:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:455:45: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:455:45: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:455:45: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:296:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:296:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:296:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:456:55: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:456:55: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:456:55: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:306:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:306:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:306:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:457:51: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:457:51: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:457:51: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:286:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:286:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:286:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:458:58: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:458:58: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:458:58: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:286:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:286:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:286:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:459:58: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:459:58: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:459:58: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:291:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:291:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:291:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:460:49: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:460:49: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:460:49: sparse:    got restricted __le32 [usertype] *pdesc
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:316:16: sparse: sparse: cast to restricted __le32
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:461:56: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:461:56: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:461:56: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:311:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:311:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:311:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:462:47: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:462:47: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:462:47: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:301:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:301:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:301:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:465:31: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:465:31: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:465:31: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:236:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:236:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:236:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:467:32: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:467:32: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:467:32: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:261:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:261:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:261:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:469:28: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:469:28: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:469:28: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:311:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:311:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:311:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:471:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:471:30: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:471:30: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:301:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] v @@    got icted __le32 [usertype] v @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:301:30: sparse:    expected restricted __le32 [usertype] v
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:301:30: sparse:    got unsigned int [usertype]
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:478:47: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:478:47: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:478:47: sparse:    got restricted __le32 [usertype] *pdesc
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:316:16: sparse: sparse: cast to restricted __le32
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:499:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__paddr @@    got restrunsigned int [usertype] *__paddr @@
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:499:30: sparse:    expected unsigned int [usertype] *__paddr
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:499:30: sparse:    got restricted __le32 [usertype] *virtualaddress
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:338:28: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:338:28: sparse:    expected restricted __le32 [usertype] *p
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:338:28: sparse:    got unsigned int [usertype] *__paddr
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:500:28: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__paddr @@    got restrunsigned int [usertype] *__paddr @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:500:28: sparse:    expected unsigned int [usertype] *__paddr
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:500:28: sparse:    got restricted __le32 [usertype] *virtualaddress
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:343:28: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:343:28: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:343:28: sparse:    got unsigned int [usertype] *__paddr
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:501:28: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__paddr @@    got restrunsigned int [usertype] *__paddr @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:501:28: sparse:    expected unsigned int [usertype] *__paddr
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:501:28: sparse:    got restricted __le32 [usertype] *virtualaddress
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:348:28: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:348:28: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:348:28: sparse:    got unsigned int [usertype] *__paddr
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:502:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__paddr @@    got restrunsigned int [usertype] *__paddr @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:502:30: sparse:    expected unsigned int [usertype] *__paddr
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:502:30: sparse:    got restricted __le32 [usertype] *virtualaddress
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:353:28: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:353:28: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:353:28: sparse:    got unsigned int [usertype] *__paddr
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:503:30: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__paddr @@    got restrunsigned int [usertype] *__paddr @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:503:30: sparse:    expected unsigned int [usertype] *__paddr
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:503:30: sparse:    got restricted __le32 [usertype] *virtualaddress
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:358:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:358:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:358:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:504:28: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__paddr @@    got restrunsigned int [usertype] *__paddr @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:504:28: sparse:    expected unsigned int [usertype] *__paddr
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:504:28: sparse:    got restricted __le32 [usertype] *virtualaddress
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:363:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:363:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:363:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:505:28: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__paddr @@    got restrunsigned int [usertype] *__paddr @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:505:28: sparse:    expected unsigned int [usertype] *__paddr
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:505:28: sparse:    got restricted __le32 [usertype] *virtualaddress
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:368:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:368:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:368:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:562:48: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:562:48: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:562:48: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:91:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:91:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:91:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:563:44: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:563:44: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:563:44: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:26:28: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:26:28: sparse:    expected restricted __le32 [usertype] *p
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:26:28: sparse:    got unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:573:44: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:573:44: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:573:44: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:26:28: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:26:28: sparse:    expected restricted __le32 [usertype] *p
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:26:28: sparse:    got unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:579:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:579:37: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:579:37: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:186:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:186:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:186:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:581:50: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:581:50: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:581:50: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:191:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:191:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:191:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:585:50: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:585:50: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:585:50: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:191:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:191:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:191:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:588:48: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:588:48: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:588:48: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:66:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:66:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:66:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:589:49: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:589:49: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:589:49: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:206:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:206:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:206:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:591:33: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:591:33: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:591:33: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:106:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:106:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:106:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:592:40: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:592:40: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:592:40: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:146:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:146:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:146:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:595:43: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:595:43: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:595:43: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:151:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:151:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:151:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:597:38: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:597:38: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:597:38: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:141:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:141:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:141:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:598:38: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:598:38: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:598:38: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:181:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:181:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:181:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:603:38: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:603:38: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:603:38: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:116:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:116:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:116:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:604:36: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:604:36: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:604:36: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:171:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:171:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:171:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:605:36: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:605:36: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:605:36: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:176:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:176:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:176:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:606:39: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:606:39: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:606:39: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:166:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:166:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:166:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:612:53: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:612:53: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:612:53: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:161:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:161:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:161:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:613:60: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:613:60: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:613:60: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:156:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:156:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:156:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:615:53: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:615:53: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:615:53: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:161:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:161:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:161:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:616:60: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:616:60: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:616:60: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:156:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:156:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:156:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:620:45: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:620:45: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:620:45: sparse:    got restricted __le32 [usertype] *pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:161:37: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __le32 [usertype] *p @@    got icted __le32 [usertype] *p @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:161:37: sparse:    expected restricted __le32 [usertype] *p
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:161:37: sparse:    got unsigned int [usertype] *
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:621:52: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] *__pdesc @@    got restrunsigned int [usertype] *__pdesc @@
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:621:52: sparse:    expected unsigned int [usertype] *__pdesc
   drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c:621:52: sparse:    got restricted __le32 [usertype] *pdesc
>> drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h:156:37: sparse: sparse: too many warnings

vim +445 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c

674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  438  
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  439  bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  440  		struct ieee80211_rx_status *rx_status,
8bfc1a8d624d66c drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  441  		u8 *pdesc8, struct sk_buff *skb)
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  442  {
8bfc1a8d624d66c drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  443  	__le32 *pdesc = (__le32 *)pdesc8;
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  444  	struct rx_fwinfo_92d *p_drvinfo;
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21 @445  	u32 phystatus = get_rx_desc_physt(pdesc);
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  446  
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  447  	stats->length = (u16)get_rx_desc_pkt_len(pdesc);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  448  	stats->rx_drvinfo_size = (u8)get_rx_desc_drv_info_size(pdesc) *
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  449  				 RX_DRV_INFO_SIZE_UNIT;
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  450  	stats->rx_bufshift = (u8)(get_rx_desc_shift(pdesc) & 0x03);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  451  	stats->icv = (u16)get_rx_desc_icv(pdesc);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  452  	stats->crc = (u16)get_rx_desc_crc32(pdesc);
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  453  	stats->hwerror = (stats->crc | stats->icv);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  454  	stats->decrypted = !get_rx_desc_swdec(pdesc);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  455  	stats->rate = (u8)get_rx_desc_rxmcs(pdesc);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  456  	stats->shortpreamble = (u16)get_rx_desc_splcp(pdesc);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  457  	stats->isampdu = (bool)(get_rx_desc_paggr(pdesc) == 1);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  458  	stats->isfirst_ampdu = (bool)((get_rx_desc_paggr(pdesc) == 1) &&
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  459  				      (get_rx_desc_faggr(pdesc) == 1));
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  460  	stats->timestamp_low = get_rx_desc_tsfl(pdesc);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  461  	stats->rx_is40mhzpacket = (bool)get_rx_desc_bw(pdesc);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  462  	stats->is_ht = (bool)get_rx_desc_rxht(pdesc);
675a0b049abf6ed drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Karl Beldan     2013-03-25  463  	rx_status->freq = hw->conf.chandef.chan->center_freq;
675a0b049abf6ed drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Karl Beldan     2013-03-25  464  	rx_status->band = hw->conf.chandef.chan->band;
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  465  	if (get_rx_desc_crc32(pdesc))
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  466  		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  467  	if (!get_rx_desc_swdec(pdesc))
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  468  		rx_status->flag |= RX_FLAG_DECRYPTED;
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  469  	if (get_rx_desc_bw(pdesc))
da6a4352e7c867f drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Johannes Berg   2017-04-26  470  		rx_status->bw = RATE_INFO_BW_40;
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21 @471  	if (get_rx_desc_rxht(pdesc))
da6a4352e7c867f drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Johannes Berg   2017-04-26  472  		rx_status->encoding = RX_ENC_HT;
f4bda337bbb6e24 drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Thomas Pedersen 2012-11-13  473  	rx_status->flag |= RX_FLAG_MACTIME_START;
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  474  	if (stats->decrypted)
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  475  		rx_status->flag |= RX_FLAG_DECRYPTED;
a160ba06c1bde5e drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Larry Finger    2014-12-18  476  	rx_status->rate_idx = rtlwifi_rate_mapping(hw, stats->is_ht,
fd3cb22ad87fd53 drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Larry Finger    2014-12-18  477  						   false, stats->rate);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21 @478  	rx_status->mactime = get_rx_desc_tsfl(pdesc);
9928c7d1b1c5e3d drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Larry Finger    2011-06-30  479  	if (phystatus) {
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  480  		p_drvinfo = (struct rx_fwinfo_92d *)(skb->data +
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  481  						     stats->rx_bufshift);
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  482  		_rtl92de_translate_rx_signal_stuff(hw,
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  483  						   skb, stats,
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  484  						   (struct rx_desc_92d *)pdesc,
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  485  						   p_drvinfo);
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  486  	}
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  487  	/*rx_status->qual = stats->signal; */
3545f3d5f4af715 drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Larry Finger    2013-11-05  488  	rx_status->signal = stats->recvsignalpower + 10;
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  489  	return true;
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  490  }
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  491  
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  492  static void _rtl92de_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
8bfc1a8d624d66c drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  493  				      u8 *virtualaddress8)
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  494  {
8bfc1a8d624d66c drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  495  	__le32 *virtualaddress = (__le32 *)virtualaddress8;
8bfc1a8d624d66c drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  496  
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  497  	memset(virtualaddress, 0, 8);
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  498  
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21 @499  	set_earlymode_pktnum(virtualaddress, ptcb_desc->empkt_num);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  500  	set_earlymode_len0(virtualaddress, ptcb_desc->empkt_len[0]);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  501  	set_earlymode_len1(virtualaddress, ptcb_desc->empkt_len[1]);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  502  	set_earlymode_len2_1(virtualaddress, ptcb_desc->empkt_len[2] & 0xF);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  503  	set_earlymode_len2_2(virtualaddress, ptcb_desc->empkt_len[2] >> 4);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  504  	set_earlymode_len3(virtualaddress, ptcb_desc->empkt_len[3]);
eec368b98776a58 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c Larry Finger    2019-11-21  505  	set_earlymode_len4(virtualaddress, ptcb_desc->empkt_len[4]);
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  506  }
674f0523ec07a7c drivers/net/wireless/rtlwifi/rtl8192de/trx.c         Chaoming Li     2011-06-10  507  

:::::: The code at line 445 was first introduced by commit
:::::: eec368b98776a58d48990e086e77e52bc52aff52 rtlwifi: rtl8192de: Convert macros that set descriptor

:::::: TO: Larry Finger <Larry.Finger@lwfinger.net>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
