Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D31CE395
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 21:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbgEKTIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 15:08:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:50806 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731191AbgEKTIR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 15:08:17 -0400
IronPort-SDR: VLNPZMp0aj/qAFV1calD4Nnj28+lYL2ui79ghk48LIFqNNO9lT6LeHiTCinJOrwPY9zynQauEk
 Z1muGGlGjjIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 12:08:16 -0700
IronPort-SDR: 9HUucCpObecXJDk0H6NfXqbKqxG2nuTijKoMXvyMqbVrihfM26AiXTy1+gH9JJUxmxX10v3RnH
 mjIXTb9BEhww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="409021972"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 May 2020 12:08:14 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jYDmf-000AQO-R3; Tue, 12 May 2020 03:08:13 +0800
Date:   Tue, 12 May 2020 03:07:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     yhchuang@realtek.com, kvalo@codeaurora.org
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com, bigeasy@linutronix.de
Subject: Re: [PATCH v2 9/9] rtw88: 8723d: Add 8723DE to Kconfig and Makefile
Message-ID: <202005120230.86A2Fjow%lkp@intel.com>
References: <20200507042151.15634-10-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507042151.15634-10-yhchuang@realtek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on wireless-drivers-next/master]
[cannot apply to wireless-drivers/master v5.7-rc5 next-20200511]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/yhchuang-realtek-com/rtw88-8723d-Add-RF-calibration-and-coex/20200507-134547
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-191-gc51a0382-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/wireless/realtek/rtw88/rtw8723d.c:1899:6: sparse: sparse: symbol 'rtw8723d_pwr_track' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
