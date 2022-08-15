Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66113592ED0
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Aug 2022 14:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbiHOMUi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Aug 2022 08:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiHOMUg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Aug 2022 08:20:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E9B2647
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660566035; x=1692102035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KalQqM3q/G0BQ/+bduaR5oyhn4VN1sBctd0e2o8g32k=;
  b=Q+LIrFLVgMfTYan0lA44N6pxpuC08zt+G5RnNWZ3fG+EBhup4t5bMm17
   nKNyYqFz2zigIdqJwzv0Op1Q/xeZa7pNUm3BMG2moeZd/yqT35wyPpIJ6
   zXPn3uh2/nxLe2NxBzlE1WTnVTbZs7F1JfbGnf/2ifWYijDFhNxbxwMsH
   fdPFNcqwDxxR1I3oDKd3TS5Y/2DvI2J7NXQzl6/2dQer1CT1Hi2a/eG9h
   vCX1guxCEr6O107pkqRBLn8Sa72NYWrX5gKl9Qo2F55RKXV4b6PM8W2BC
   XfMo0VaaJ90zhg12DAaqqWek2z1bxN0XiZGR6mjkgumdH+NuytMk4pWDQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="378234541"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="378234541"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 05:20:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="582859426"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Aug 2022 05:20:33 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNZ57-0000zh-07;
        Mon, 15 Aug 2022 12:20:33 +0000
Date:   Mon, 15 Aug 2022 20:20:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/3] wifi: rtw89: correct BA CAM allocation
Message-ID: <202208152030.442QsT2L-lkp@intel.com>
References: <20220815070703.26965-4-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815070703.26965-4-pkshih@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ping-Ke,

I love your patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.0-rc1 next-20220815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-correct-BA-CAM-allocation/20220815-151009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220815/202208152030.442QsT2L-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/336a217f279e1188ec626d83a9f6edc636e68aa5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ping-Ke-Shih/wifi-rtw89-correct-BA-CAM-allocation/20220815-151009
        git checkout 336a217f279e1188ec626d83a9f6edc636e68aa5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/realtek/rtw89/debug.c: In function 'rtw89_dump_ba_cam':
>> drivers/net/wireless/realtek/rtw89/debug.c:2450:42: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Wformat=]
    2450 |                 seq_printf(m, "tid[%u]=%ld", entry->tid,
         |                                        ~~^
         |                                          |
         |                                          long int
         |                                        %d
    2451 |                            entry - rtwdev->cam_info.ba_cam_entry);
         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                  |
         |                                  int


vim +2450 drivers/net/wireless/realtek/rtw89/debug.c

  2435	
  2436	static void rtw89_dump_ba_cam(struct seq_file *m, struct rtw89_sta *rtwsta)
  2437	{
  2438		struct rtw89_vif *rtwvif = rtwsta->rtwvif;
  2439		struct rtw89_dev *rtwdev = rtwvif->rtwdev;
  2440		struct rtw89_ba_cam_entry *entry;
  2441		bool first = true;
  2442	
  2443		list_for_each_entry(entry, &rtwsta->ba_cam_list, list) {
  2444			if (first) {
  2445				seq_puts(m, "\tba_cam ");
  2446				first = false;
  2447			} else {
  2448				seq_puts(m, ", ");
  2449			}
> 2450			seq_printf(m, "tid[%u]=%ld", entry->tid,
  2451				   entry - rtwdev->cam_info.ba_cam_entry);
  2452		}
  2453		seq_puts(m, "\n");
  2454	}
  2455	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
