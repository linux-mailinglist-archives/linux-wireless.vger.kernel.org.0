Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C800835A697
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 21:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhDITEN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 15:04:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:22013 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234933AbhDITEL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 15:04:11 -0400
IronPort-SDR: S2ttZaucm7JrYzLMosJq7FY0CBHg+A8UzNucuGc0YyHlD4OGXSoveqHboBVx3pdLTuy5dFCS8D
 ssBpnVO3doJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="214261582"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="gz'50?scan'50,208,50";a="214261582"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 12:03:39 -0700
IronPort-SDR: HYbk90PCnc1ijnZhN3061zRtc9cCNCgEFr1QU3GacpnYpKYZ/QQGmlIkc1U/lVGFxSYzuxSQRK
 toPeISFLN8+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="gz'50?scan'50,208,50";a="397579103"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Apr 2021 12:03:36 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUwPo-000HEP-1F; Fri, 09 Apr 2021 19:03:36 +0000
Date:   Sat, 10 Apr 2021 03:02:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 11/15] wireless: fix spelling of A-MSDU in HE capabilities
Message-ID: <202104100223.iZPxHYpm-lkp@intel.com>
References: <iwlwifi.20210409123755.9e6ff1af1181.If6868bc6902ccd9a95c74c78f716c4b41473ef14@changeid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <iwlwifi.20210409123755.9e6ff1af1181.If6868bc6902ccd9a95c74c78f716c4b41473ef14@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luca,

I love your patch! Yet something to improve:

[auto build test ERROR on mac80211-next/master]
[also build test ERROR on mac80211/master wireless-drivers-next/master wireless-drivers/master v5.12-rc6 next-20210409]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Luca-Coelho/cfg80211-mac80211-patches-from-our-internal-tree-2021-04-09/20210409-181210
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
config: x86_64-randconfig-a005-20210409 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project dd453a1389b6a7e6d9214b449d3c54981b1a89b6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        # https://github.com/0day-ci/linux/commit/ab7f3700d2d0fefb429cfbb3763930761035754c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Luca-Coelho/cfg80211-mac80211-patches-from-our-internal-tree-2021-04-09/20210409-181210
        git checkout ab7f3700d2d0fefb429cfbb3763930761035754c
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:641:6: error: use of undeclared identifier 'IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU'
                                           IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
                                           ^
>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:759:47: error: invalid application of 'sizeof' to an incomplete type 'const struct ieee80211_sband_iftype_data []'
           BUILD_BUG_ON(sizeof(data->iftd.low) != sizeof(iwl_he_capa));
                                                        ^~~~~~~~~~~~~
   include/linux/build_bug.h:50:19: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
                            ^~~~~~~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                                            ^~~~
   include/linux/compiler_types.h:320:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:308:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:300:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:760:48: error: invalid application of 'sizeof' to an incomplete type 'const struct ieee80211_sband_iftype_data []'
           BUILD_BUG_ON(sizeof(data->iftd.high) != sizeof(iwl_he_capa));
                                                         ^~~~~~~~~~~~~
   include/linux/build_bug.h:50:19: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
                            ^~~~~~~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                                            ^~~~
   include/linux/compiler_types.h:320:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:308:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:300:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:775:41: error: invalid application of 'sizeof' to an incomplete type 'const struct ieee80211_sband_iftype_data []'
           memcpy(iftype_data, iwl_he_capa, sizeof(iwl_he_capa));
                                                  ^~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:778:25: error: invalid application of 'sizeof' to an incomplete type 'const struct ieee80211_sband_iftype_data []'
           sband->n_iftype_data = ARRAY_SIZE(iwl_he_capa);
                                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:49:32: note: expanded from macro 'ARRAY_SIZE'
   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                  ^~~~~
   5 errors generated.


vim +/IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU +641 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c

33158fefc88e58 drivers/net/wireless/iwlwifi/iwl-nvm-parse.c       Eytan Lifshitz    2013-02-20  536  
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  537  static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  538  	{
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  539  		.types_mask = BIT(NL80211_IFTYPE_STATION),
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  540  		.he_cap = {
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  541  			.has_he = true,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  542  			.he_cap_elem = {
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  543  				.mac_cap_info[0] =
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  544  					IEEE80211_HE_MAC_CAP0_HTC_HE |
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  545  					IEEE80211_HE_MAC_CAP0_TWT_REQ,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  546  				.mac_cap_info[1] =
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  547  					IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US |
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  548  					IEEE80211_HE_MAC_CAP1_MULTI_TID_AGG_RX_QOS_8,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  549  				.mac_cap_info[2] =
38af8d5a90a8c3 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Ilan Peer         2020-04-17  550  					IEEE80211_HE_MAC_CAP2_32BIT_BA_BITMAP,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  551  				.mac_cap_info[3] =
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  552  					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
14d0d9bb385498 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2021-04-09  553  					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  554  				.mac_cap_info[4] =
ab7f3700d2d0fe drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2021-04-09  555  					IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU |
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  556  					IEEE80211_HE_MAC_CAP4_MULTI_TID_AGG_TX_QOS_B39,
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  557  				.mac_cap_info[5] =
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  558  					IEEE80211_HE_MAC_CAP5_MULTI_TID_AGG_TX_QOS_B40 |
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  559  					IEEE80211_HE_MAC_CAP5_MULTI_TID_AGG_TX_QOS_B41 |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  560  					IEEE80211_HE_MAC_CAP5_UL_2x996_TONE_RU |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  561  					IEEE80211_HE_MAC_CAP5_HE_DYNAMIC_SM_PS |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  562  					IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  563  				.phy_cap_info[0] =
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  564  					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  565  					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  566  					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  567  				.phy_cap_info[1] =
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  568  					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  569  					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  570  					IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  571  				.phy_cap_info[2] =
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  572  					IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  573  				.phy_cap_info[3] =
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  574  					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_NO_DCM |
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  575  					IEEE80211_HE_PHY_CAP3_DCM_MAX_TX_NSS_1 |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  576  					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_NO_DCM |
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  577  					IEEE80211_HE_PHY_CAP3_DCM_MAX_RX_NSS_1,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  578  				.phy_cap_info[4] =
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  579  					IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  580  					IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_8 |
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  581  					IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_8,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  582  				.phy_cap_info[5] =
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  583  					IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_2 |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  584  					IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_2,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  585  				.phy_cap_info[6] =
13582e33bee863 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2021-04-09  586  					IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
13582e33bee863 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2021-04-09  587  					IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB |
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  588  					IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  589  				.phy_cap_info[7] =
13582e33bee863 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2021-04-09  590  					IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  591  					IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI |
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  592  					IEEE80211_HE_PHY_CAP7_MAX_NC_1,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  593  				.phy_cap_info[8] =
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  594  					IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  595  					IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  596  					IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  597  					IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  598  					IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_2x996,
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  599  				.phy_cap_info[9] =
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  600  					IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  601  					IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  602  					IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  603  					IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_RESERVED,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  604  			},
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  605  			/*
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  606  			 * Set default Tx/Rx HE MCS NSS Support field.
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  607  			 * Indicate support for up to 2 spatial streams and all
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  608  			 * MCS, without any special cases
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  609  			 */
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  610  			.he_mcs_nss_supp = {
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  611  				.rx_mcs_80 = cpu_to_le16(0xfffa),
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  612  				.tx_mcs_80 = cpu_to_le16(0xfffa),
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  613  				.rx_mcs_160 = cpu_to_le16(0xfffa),
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  614  				.tx_mcs_160 = cpu_to_le16(0xfffa),
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  615  				.rx_mcs_80p80 = cpu_to_le16(0xffff),
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  616  				.tx_mcs_80p80 = cpu_to_le16(0xffff),
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  617  			},
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  618  			/*
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  619  			 * Set default PPE thresholds, with PPET16 set to 0,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  620  			 * PPET8 set to 7
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  621  			 */
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  622  			.ppe_thres = {0x61, 0x1c, 0xc7, 0x71},
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  623  		},
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  624  	},
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  625  	{
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  626  		.types_mask = BIT(NL80211_IFTYPE_AP),
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  627  		.he_cap = {
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  628  			.has_he = true,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  629  			.he_cap_elem = {
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  630  				.mac_cap_info[0] =
7360f99e0b99e3 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Emmanuel Grumbach 2018-09-12  631  					IEEE80211_HE_MAC_CAP0_HTC_HE,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  632  				.mac_cap_info[1] =
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  633  					IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US |
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  634  					IEEE80211_HE_MAC_CAP1_MULTI_TID_AGG_RX_QOS_8,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  635  				.mac_cap_info[2] =
38af8d5a90a8c3 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Ilan Peer         2020-04-17  636  					IEEE80211_HE_MAC_CAP2_BSR,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  637  				.mac_cap_info[3] =
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  638  					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
14d0d9bb385498 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2021-04-09  639  					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  640  				.mac_cap_info[4] =
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20 @641  					IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  642  				.mac_cap_info[5] =
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  643  					IEEE80211_HE_MAC_CAP5_UL_2x996_TONE_RU,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  644  				.phy_cap_info[0] =
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  645  					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  646  					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  647  					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  648  				.phy_cap_info[1] =
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  649  					IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  650  				.phy_cap_info[2] =
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  651  					IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  652  				.phy_cap_info[3] =
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  653  					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_NO_DCM |
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  654  					IEEE80211_HE_PHY_CAP3_DCM_MAX_TX_NSS_1 |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  655  					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_NO_DCM |
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  656  					IEEE80211_HE_PHY_CAP3_DCM_MAX_RX_NSS_1,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  657  				.phy_cap_info[4] =
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  658  					IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  659  					IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_8 |
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  660  					IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_8,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  661  				.phy_cap_info[5] =
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  662  					IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_2 |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  663  					IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_2,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  664  				.phy_cap_info[6] =
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  665  					IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  666  				.phy_cap_info[7] =
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  667  					IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI |
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  668  					IEEE80211_HE_PHY_CAP7_MAX_NC_1,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  669  				.phy_cap_info[8] =
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  670  					IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  671  					IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  672  					IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  673  					IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  674  					IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_2x996,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  675  				.phy_cap_info[9] =
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  676  					IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  677  					IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB |
77ff2c6b49843b drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Liad Kaufman      2019-02-06  678  					IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_RESERVED,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  679  			},
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  680  			/*
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  681  			 * Set default Tx/Rx HE MCS NSS Support field.
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  682  			 * Indicate support for up to 2 spatial streams and all
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  683  			 * MCS, without any special cases
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  684  			 */
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  685  			.he_mcs_nss_supp = {
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  686  				.rx_mcs_80 = cpu_to_le16(0xfffa),
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  687  				.tx_mcs_80 = cpu_to_le16(0xfffa),
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  688  				.rx_mcs_160 = cpu_to_le16(0xfffa),
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  689  				.tx_mcs_160 = cpu_to_le16(0xfffa),
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  690  				.rx_mcs_80p80 = cpu_to_le16(0xffff),
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  691  				.tx_mcs_80p80 = cpu_to_le16(0xffff),
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  692  			},
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  693  			/*
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  694  			 * Set default PPE thresholds, with PPET16 set to 0,
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  695  			 * PPET8 set to 7
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  696  			 */
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  697  			.ppe_thres = {0x61, 0x1c, 0xc7, 0x71},
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  698  		},
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  699  	},
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  700  };
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  701  
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  702  static void iwl_init_he_6ghz_capa(struct iwl_trans *trans,
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  703  				  struct iwl_nvm_data *data,
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  704  				  struct ieee80211_supported_band *sband,
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  705  				  u8 tx_chains, u8 rx_chains)
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  706  {
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  707  	struct ieee80211_sta_ht_cap ht_cap;
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  708  	struct ieee80211_sta_vht_cap vht_cap = {};
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  709  	struct ieee80211_sband_iftype_data *iftype_data;
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  710  	u16 he_6ghz_capa = 0;
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  711  	u32 exp;
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  712  	int i;
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  713  
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  714  	if (sband->band != NL80211_BAND_6GHZ)
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  715  		return;
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  716  
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  717  	/* grab HT/VHT capabilities and calculate HE 6 GHz capabilities */
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  718  	iwl_init_ht_hw_capab(trans, data, &ht_cap, NL80211_BAND_5GHZ,
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  719  			     tx_chains, rx_chains);
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  720  	WARN_ON(!ht_cap.ht_supported);
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  721  	iwl_init_vht_hw_capab(trans, data, &vht_cap, tx_chains, rx_chains);
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  722  	WARN_ON(!vht_cap.vht_supported);
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  723  
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  724  	he_6ghz_capa |=
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  725  		u16_encode_bits(ht_cap.ampdu_density,
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  726  				IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  727  	exp = u32_get_bits(vht_cap.cap,
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  728  			   IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK);
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  729  	he_6ghz_capa |=
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  730  		u16_encode_bits(exp, IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  731  	exp = u32_get_bits(vht_cap.cap, IEEE80211_VHT_CAP_MAX_MPDU_MASK);
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  732  	he_6ghz_capa |=
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  733  		u16_encode_bits(exp, IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  734  	/* we don't support extended_ht_cap_info anywhere, so no RD_RESPONDER */
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  735  	if (vht_cap.cap & IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN)
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  736  		he_6ghz_capa |= IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS;
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  737  	if (vht_cap.cap & IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN)
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  738  		he_6ghz_capa |= IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  739  
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  740  	IWL_DEBUG_EEPROM(trans->dev, "he_6ghz_capa=0x%x\n", he_6ghz_capa);
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  741  
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  742  	/* we know it's writable - we set it before ourselves */
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  743  	iftype_data = (void *)sband->iftype_data;
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  744  	for (i = 0; i < sband->n_iftype_data; i++)
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  745  		iftype_data[i].he_6ghz_capa.capa = cpu_to_le16(he_6ghz_capa);
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  746  }
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  747  
df658908566455 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2019-11-05  748  static void iwl_init_he_hw_capab(struct iwl_trans *trans,
df658908566455 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2019-11-05  749  				 struct iwl_nvm_data *data,
df658908566455 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2019-11-05  750  				 struct ieee80211_supported_band *sband,
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  751  				 u8 tx_chains, u8 rx_chains)
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  752  {
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  753  	struct ieee80211_sband_iftype_data *iftype_data;
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  754  
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  755  	/* should only initialize once */
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  756  	if (WARN_ON(sband->iftype_data))
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  757  		return;
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  758  
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09 @759  	BUILD_BUG_ON(sizeof(data->iftd.low) != sizeof(iwl_he_capa));
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  760  	BUILD_BUG_ON(sizeof(data->iftd.high) != sizeof(iwl_he_capa));
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  761  
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  762  	switch (sband->band) {
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  763  	case NL80211_BAND_2GHZ:
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  764  		iftype_data = data->iftd.low;
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  765  		break;
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  766  	case NL80211_BAND_5GHZ:
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  767  	case NL80211_BAND_6GHZ:
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  768  		iftype_data = data->iftd.high;
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  769  		break;
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  770  	default:
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  771  		WARN_ON(1);
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  772  		return;
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  773  	}
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  774  
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  775  	memcpy(iftype_data, iwl_he_capa, sizeof(iwl_he_capa));
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  776  
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  777  	sband->iftype_data = iftype_data;
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  778  	sband->n_iftype_data = ARRAY_SIZE(iwl_he_capa);
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  779  
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  780  	/* If not 2x2, we need to indicate 1x1 in the Midamble RX Max NSTS */
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  781  	if ((tx_chains & rx_chains) != ANT_AB) {
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  782  		int i;
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  783  
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  784  		for (i = 0; i < sband->n_iftype_data; i++) {
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  785  			iftype_data[i].he_cap.he_cap_elem.phy_cap_info[1] &=
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  786  				~IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS;
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  787  			iftype_data[i].he_cap.he_cap_elem.phy_cap_info[2] &=
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  788  				~IEEE80211_HE_PHY_CAP2_MIDAMBLE_RX_TX_MAX_NSTS;
d43ab298efc639 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Johannes Berg     2020-12-09  789  			iftype_data[i].he_cap.he_cap_elem.phy_cap_info[7] &=
add7453ad62f05 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-09-05  790  				~IEEE80211_HE_PHY_CAP7_MAX_NC_MASK;
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  791  		}
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  792  	}
eae94cf82d7456 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2020-12-10  793  	iwl_init_he_6ghz_capa(trans, data, sband, tx_chains, rx_chains);
57a3a454f30368 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Shaul Triebitz    2018-08-20  794  }
514c30696fbc25 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c Luca Coelho       2018-06-24  795  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--X1bOJ3K7DJ5YkBrT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--X1bOJ3K7DJ5YkBrT--
