Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9069846160B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbhK2NT0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:19:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:44612 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377397AbhK2NRZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:17:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="235786610"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="235786610"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 05:06:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="676344613"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2021 05:06:09 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrgMC-000Bxj-SM; Mon, 29 Nov 2021 13:06:08 +0000
Date:   Mon, 29 Nov 2021 21:05:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Finn Behrens <me@kloenk.dev>
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [jberg-mac80211:master 8/8] net/wireless/reg.c:1137:28: warning:
 implicit conversion from 'enum nl80211_user_reg_hint_type' to 'enum
 nl80211_reg_initiator'
Message-ID: <202111292027.ZZFNfeUA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
head:   1eda919126b420fee6b8d546f7f728fbbd4b8f11
commit: 1eda919126b420fee6b8d546f7f728fbbd4b8f11 [8/8] nl80211: reset regdom when reloading regdb
config: parisc-randconfig-r034-20211129 (https://download.01.org/0day-ci/archive/20211129/202111292027.ZZFNfeUA-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?id=1eda919126b420fee6b8d546f7f728fbbd4b8f11
        git remote add jberg-mac80211 https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git
        git fetch --no-tags jberg-mac80211 master
        git checkout 1eda919126b420fee6b8d546f7f728fbbd4b8f11
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash net/wireless/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/wireless/reg.c: In function 'reg_reload_regdb':
>> net/wireless/reg.c:1137:28: warning: implicit conversion from 'enum nl80211_user_reg_hint_type' to 'enum nl80211_reg_initiator' [-Wenum-conversion]
    1137 |         request->initiator = NL80211_USER_REG_HINT_USER;
         |                            ^


vim +1137 net/wireless/reg.c

  1096	
  1097	int reg_reload_regdb(void)
  1098	{
  1099		const struct firmware *fw;
  1100		void *db;
  1101		int err;
  1102		const struct ieee80211_regdomain *current_regdomain;
  1103		struct regulatory_request *request;
  1104	
  1105		err = request_firmware(&fw, "regulatory.db", &reg_pdev->dev);
  1106		if (err)
  1107			return err;
  1108	
  1109		if (!valid_regdb(fw->data, fw->size)) {
  1110			err = -ENODATA;
  1111			goto out;
  1112		}
  1113	
  1114		db = kmemdup(fw->data, fw->size, GFP_KERNEL);
  1115		if (!db) {
  1116			err = -ENOMEM;
  1117			goto out;
  1118		}
  1119	
  1120		rtnl_lock();
  1121		if (!IS_ERR_OR_NULL(regdb))
  1122			kfree(regdb);
  1123		regdb = db;
  1124	
  1125		/* reset regulatory domain */
  1126		current_regdomain = get_cfg80211_regdom();
  1127	
  1128		request = kzalloc(sizeof(*request), GFP_KERNEL);
  1129		if (!request) {
  1130			err = -ENOMEM;
  1131			goto out_unlock;
  1132		}
  1133	
  1134		request->wiphy_idx = WIPHY_IDX_INVALID;
  1135		request->alpha2[0] = current_regdomain->alpha2[0];
  1136		request->alpha2[1] = current_regdomain->alpha2[1];
> 1137		request->initiator = NL80211_USER_REG_HINT_USER;
  1138		request->user_reg_hint_type = NL80211_USER_REG_HINT_USER;
  1139		request->reload = true;
  1140	
  1141		reg_process_hint(request);
  1142	
  1143	out_unlock:
  1144		rtnl_unlock();
  1145	 out:
  1146		release_firmware(fw);
  1147		return err;
  1148	}
  1149	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
