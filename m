Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB507851A1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 09:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjHWHfF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 03:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjHWHfE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 03:35:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C286FE73
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 00:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692776099; x=1724312099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+WoV4tVJSCaUjsWyOMHHl7owKPLxv8Zvbh4nBhVd9LM=;
  b=ZslhCT1mExWR4kZPDS1B4P528MuEO8ehrdYXYb9XZsQ5Zx1Kca1//rT4
   ZObrt6KjvkZo1KbeeIF5mZUlSdaGVuMIC7bU92k3lmzzPvrouYnOAoE75
   8Dju8Q21DifyICqJZzXxT/K0U5m4oWcrAaasn7hD0NaRjt8Bv1J6cgDla
   I6E27gGJbgbOwuvF6U1sWCPCILuqBYM1CP++11PlPp+V6OLyffA47FITW
   AIF+l7Q1LTU4wnN+fGqwdBWZfzmPxmHe/uVUCbDIggHF6rCldaYnDDITU
   tbI2/FgkNf28qVpK9njdkkxS2czFlNNGiySyt+6cNwViXEd4KugVuoWIf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="460459187"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="460459187"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 00:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="713476425"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713476425"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Aug 2023 00:34:56 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYiOF-0000y4-2F;
        Wed, 23 Aug 2023 07:34:55 +0000
Date:   Wed, 23 Aug 2023 15:34:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 1/3] wifi: ath10k: cleanup CE initialization
Message-ID: <202308231552.qVY1nOZs-lkp@intel.com>
References: <20230822155532.95983-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822155532.95983-1-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvalo-ath/ath-next]
[also build test WARNING on wireless-next/main wireless/main linus/master v6.5-rc7 next-20230822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Antipov/wifi-ath10k-simplify-ath10k_peer_assoc_h_vht/20230822-235854
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
patch link:    https://lore.kernel.org/r/20230822155532.95983-1-dmantipov%40yandex.ru
patch subject: [PATCH 1/3] wifi: ath10k: cleanup CE initialization
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230823/202308231552.qVY1nOZs-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308231552.qVY1nOZs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308231552.qVY1nOZs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath10k/snoc.c:1083:1: warning: unused label 'err_free_rri' [-Wunused-label]
   err_free_rri:
   ^~~~~~~~~~~~~
   1 warning generated.


vim +/err_free_rri +1083 drivers/net/wireless/ath/ath10k/snoc.c

0fa4fbe9b8cf76 Govind Singh   2018-04-10  1056  
3c545a25939c27 Rakesh Pillai  2019-02-08  1057  static int ath10k_snoc_hif_power_up(struct ath10k *ar,
3c545a25939c27 Rakesh Pillai  2019-02-08  1058  				    enum ath10k_firmware_mode fw_mode)
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1059  {
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1060  	int ret;
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1061  
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1062  	ath10k_dbg(ar, ATH10K_DBG_SNOC, "%s:WCN3990 driver state = %d\n",
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1063  		   __func__, ar->state);
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1064  
5f1aa93ffa1f36 Rakesh Pillai  2020-12-12  1065  	ret = ath10k_hw_power_on(ar);
5f1aa93ffa1f36 Rakesh Pillai  2020-12-12  1066  	if (ret) {
5f1aa93ffa1f36 Rakesh Pillai  2020-12-12  1067  		ath10k_err(ar, "failed to power on device: %d\n", ret);
5f1aa93ffa1f36 Rakesh Pillai  2020-12-12  1068  		return ret;
5f1aa93ffa1f36 Rakesh Pillai  2020-12-12  1069  	}
5f1aa93ffa1f36 Rakesh Pillai  2020-12-12  1070  
3c545a25939c27 Rakesh Pillai  2019-02-08  1071  	ret = ath10k_snoc_wlan_enable(ar, fw_mode);
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1072  	if (ret) {
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1073  		ath10k_err(ar, "failed to enable wcn3990: %d\n", ret);
5f1aa93ffa1f36 Rakesh Pillai  2020-12-12  1074  		goto err_hw_power_off;
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1075  	}
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1076  
4945af5b264fbd Govind Singh   2018-04-17  1077  	ath10k_ce_alloc_rri(ar);
4945af5b264fbd Govind Singh   2018-04-17  1078  
7279d6262224cd Dmitry Antipov 2023-08-22  1079  	ath10k_snoc_init_pipes(ar);
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1080  
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1081  	return 0;
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1082  
31561e8557cd1e Rakesh Pillai  2020-12-12 @1083  err_free_rri:
31561e8557cd1e Rakesh Pillai  2020-12-12  1084  	ath10k_ce_free_rri(ar);
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1085  	ath10k_snoc_wlan_disable(ar);
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1086  
5f1aa93ffa1f36 Rakesh Pillai  2020-12-12  1087  err_hw_power_off:
5f1aa93ffa1f36 Rakesh Pillai  2020-12-12  1088  	ath10k_hw_power_off(ar);
5f1aa93ffa1f36 Rakesh Pillai  2020-12-12  1089  
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1090  	return ret;
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1091  }
0fa4fbe9b8cf76 Govind Singh   2018-04-10  1092  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
