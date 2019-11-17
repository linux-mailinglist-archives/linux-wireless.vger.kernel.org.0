Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C391FF780
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Nov 2019 04:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfKQDoa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 22:44:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:55921 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfKQDo3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 22:44:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2019 19:44:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,314,1569308400"; 
   d="scan'208";a="230839421"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2019 19:44:27 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iWBUB-000HQB-G4; Sun, 17 Nov 2019 11:44:27 +0800
Date:   Sun, 17 Nov 2019 11:44:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     kbuild-all@lists.01.org, nbd@nbd.name,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: Re: [PATCH 4/4] mt76: mt76x02: add channel switch support for usb
 interfaces
Message-ID: <201911171138.hF8qpVzA%lkp@intel.com>
References: <20191116111709.4686-5-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191116111709.4686-5-markus.theil@tu-ilmenau.de>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Markus,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless-drivers-next/master]
[cannot apply to v5.4-rc7 next-20191115]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Markus-Theil/mt76-channel-switch-support-for-USB-devices/20191116-192204
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-32-g233d4e1-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c:103:6: sparse: sparse: symbol 'mt76x2u_channel_switch_beacon' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
