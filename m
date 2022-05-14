Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1539526EB8
	for <lists+linux-wireless@lfdr.de>; Sat, 14 May 2022 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiENGt2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 May 2022 02:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiENGt1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 May 2022 02:49:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA5D3467D
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 23:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652510966; x=1684046966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7CeSZT5P5efH0mPrKoXjprz7uPBlIHVxVgpKvJBhu8=;
  b=F9XNMHaNzZUA1iDwfbOPdizB3xiHaqTQP+/ZTEuvbIZspWwHCmP7mB/+
   Y41qAahAVSUYDJrjKw1BwbVTdK1W2m8uy4QQB5jP6JNV1n48VqdlALxme
   quM5QfI1XKU9s0RGZ49B8AaWWl2SNmgtqrXEVIkvLiXYoWhvVNPh609D3
   VoDhAMqFNGg8Dv2q3axPre1ilV9qPqadaFJDErO4zMnVMxqoFyxmGB/CV
   ZtCLOT+lE+XLBLxLcbEXJNFFjcH/ddgVrnyWRrGg8lh7NhCcVdjK2lV8S
   Bu+qndCDvnfFmN4pW3jzVGQT3/LksAMD5PNlPFEy0C74Zw1krqVzxL8L7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="268066460"
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="268066460"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 23:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="659418786"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 May 2022 23:49:23 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nplac-0000J8-Pr;
        Sat, 14 May 2022 06:49:22 +0000
Date:   Sat, 14 May 2022 14:48:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, Ajay.Kathat@microchip.com
Subject: Re: [PATCH 3/4] wilc1000: add WPA3 SAE support
Message-ID: <202205141457.gyZ6XGV0-lkp@intel.com>
References: <20220513171741.26701-3-ajay.kathat@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513171741.26701-3-ajay.kathat@microchip.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main v5.18-rc6 next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajay-Kathat-microchip-com/wilc1000-use-correct-sequence-of-RESET-for-chip-Power-UP-Down/20220514-011943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20220514/202205141457.gyZ6XGV0-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cd10e5eab42df173c299af63e2f50308bbf0f27e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ajay-Kathat-microchip-com/wilc1000-use-correct-sequence-of-RESET-for-chip-Power-UP-Down/20220514-011943
        git checkout cd10e5eab42df173c299af63e2f50308bbf0f27e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/clk/mediatek/ drivers/net/wireless/microchip/wilc1000/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/microchip/wilc1000/netdev.c: In function 'wilc_wfi_mgmt_rx':
>> drivers/net/wireless/microchip/wilc1000/netdev.c:845:35: warning: variable 'priv' set but not used [-Wunused-but-set-variable]
     845 |                 struct wilc_priv *priv;
         |                                   ^~~~


vim +/priv +845 drivers/net/wireless/microchip/wilc1000/netdev.c

   837	
   838	void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size, bool is_auth)
   839	{
   840		int srcu_idx;
   841		struct wilc_vif *vif;
   842	
   843		srcu_idx = srcu_read_lock(&wilc->srcu);
   844		list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
 > 845			struct wilc_priv *priv;
   846			struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)buff;
   847			u16 type = le16_to_cpup((__le16 *)buff);
   848			u32 type_bit = BIT(type >> 4);
   849			u32 auth_bit = BIT(IEEE80211_STYPE_AUTH >> 4);
   850	
   851			priv = &vif->priv;
   852			if ((vif->mgmt_reg_stypes & auth_bit &&
   853			     ieee80211_is_auth(mgmt->frame_control)) &&
   854			    vif->iftype == WILC_STATION_MODE && is_auth) {
   855				wilc_wfi_mgmt_frame_rx(vif, buff, size);
   856				break;
   857			}
   858	
   859			if (vif->priv.p2p_listen_state &&
   860			    vif->mgmt_reg_stypes & type_bit)
   861				wilc_wfi_p2p_rx(vif, buff, size);
   862	
   863			if (vif->monitor_flag)
   864				wilc_wfi_monitor_rx(wilc->monitor_dev, buff, size);
   865		}
   866		srcu_read_unlock(&wilc->srcu, srcu_idx);
   867	}
   868	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
