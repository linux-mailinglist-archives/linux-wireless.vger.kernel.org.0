Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F7946D4F9
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 15:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhLHOEV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 09:04:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:22502 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234499AbhLHOEV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 09:04:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237774617"
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="237774617"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 06:00:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="612096706"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Dec 2021 06:00:45 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muxUy-0000ci-M1; Wed, 08 Dec 2021 14:00:44 +0000
Date:   Wed, 8 Dec 2021 22:00:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        MeiChia Chiu <meichia.chiu@mediatek.com>
Subject: Re: [PATCH v2] mt76: mt7915: add mu-mimo and ofdma debugfs knobs
Message-ID: <202112082145.YwvZAzNR-lkp@intel.com>
References: <20211208090319.19096-1-MeiChia.Chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208090319.19096-1-MeiChia.Chiu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi MeiChia,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kvalo-wireless-drivers-next/master]
[also build test WARNING on kvalo-wireless-drivers/master v5.16-rc4 next-20211208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/MeiChia-Chiu/mt76-mt7915-add-mu-mimo-and-ofdma-debugfs-knobs/20211208-170525
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211208/202112082145.YwvZAzNR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2d224f4e59aa02c401f3f6f5e9d4586040773a8a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review MeiChia-Chiu/mt76-mt7915-add-mu-mimo-and-ofdma-debugfs-knobs/20211208-170525
        git checkout 2d224f4e59aa02c401f3f6f5e9d4586040773a8a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/wireless/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c: In function 'mt7915_muru_stat_show':
>> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:167:29: warning: format '%d' expects argument of type 'int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     167 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | %7d%% | %7d%% | ",
         |                           ~~^
         |                             |
         |                             int
         |                           %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:167:37: warning: format '%d' expects argument of type 'int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     167 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | %7d%% | %7d%% | ",
         |                                   ~~^
         |                                     |
         |                                     int
         |                                   %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:167:45: warning: format '%d' expects argument of type 'int', but argument 5 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     167 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | %7d%% | %7d%% | ",
         |                                           ~~^
         |                                             |
         |                                             int
         |                                           %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:167:53: warning: format '%d' expects argument of type 'int', but argument 6 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     167 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | %7d%% | %7d%% | ",
         |                                                   ~~^
         |                                                     |
         |                                                     int
         |                                                   %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:167:61: warning: format '%d' expects argument of type 'int', but argument 7 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     167 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | %7d%% | %7d%% | ",
         |                                                           ~~^
         |                                                             |
         |                                                             int
         |                                                           %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:186:29: warning: format '%d' expects argument of type 'int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     186 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | ",
         |                           ~~^
         |                             |
         |                             int
         |                           %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:186:37: warning: format '%d' expects argument of type 'int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     186 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | ",
         |                                   ~~^
         |                                     |
         |                                     int
         |                                   %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:186:45: warning: format '%d' expects argument of type 'int', but argument 5 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     186 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | ",
         |                                           ~~^
         |                                             |
         |                                             int
         |                                           %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:215:29: warning: format '%d' expects argument of type 'int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     215 |         seq_printf(file, "%7d%% | %7d%% | ",
         |                           ~~^
         |                             |
         |                             int
         |                           %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:215:37: warning: format '%d' expects argument of type 'int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     215 |         seq_printf(file, "%7d%% | %7d%% | ",
         |                                   ~~^
         |                                     |
         |                                     int
         |                                   %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:231:29: warning: format '%d' expects argument of type 'int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     231 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | ",
         |                           ~~^
         |                             |
         |                             int
         |                           %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:231:37: warning: format '%d' expects argument of type 'int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     231 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | ",
         |                                   ~~^
         |                                     |
         |                                     int
         |                                   %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:231:45: warning: format '%d' expects argument of type 'int', but argument 5 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     231 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | ",
         |                                           ~~^
         |                                             |
         |                                             int
         |                                           %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:251:29: warning: format '%d' expects argument of type 'int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     251 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | %7d%% | %8d%% | %7d%% | ",
         |                           ~~^
         |                             |
         |                             int
         |                           %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:251:37: warning: format '%d' expects argument of type 'int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     251 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | %7d%% | %8d%% | %7d%% | ",
         |                                   ~~^
         |                                     |
         |                                     int
         |                                   %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:251:45: warning: format '%d' expects argument of type 'int', but argument 5 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     251 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | %7d%% | %8d%% | %7d%% | ",
         |                                           ~~^
         |                                             |
         |                                             int
         |                                           %7lld
   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:251:53: warning: format '%d' expects argument of type 'int', but argument 6 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     251 |         seq_printf(file, "%7d%% | %7d%% | %7d%% | %7d%% | %8d%% | %7d%% | ",
         |                                                   ~~^
         |                                                     |
         |                                                     int


vim +167 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c

   104	
   105	DEFINE_DEBUGFS_ATTRIBUTE(fops_muru_debug, mt7915_muru_debug_get,
   106				 mt7915_muru_debug_set, "%lld\n");
   107	
   108	static int mt7915_muru_stat_show(struct seq_file *file, void *data)
   109	{
   110		struct mt7915_phy *phy = file->private;
   111		struct mt7915_dev *dev = phy->dev;
   112		struct mt7915_mcu_muru_stats mu_stats = {};
   113		static const char * const dl_non_he_type[] = {
   114			"CCK", "OFDM", "HT MIX", "HT GF",
   115			"VHT SU", "VHT 2MU", "VHT 3MU", "VHT 4MU"
   116		};
   117		static const char * const dl_he_type[] = {
   118			"HE SU", "HE EXT", "HE 2MU", "HE 3MU", "HE 4MU",
   119			"HE 2RU", "HE 3RU", "HE 4RU", "HE 5-8RU", "HE 9-16RU",
   120			"HE >16RU"
   121		};
   122		static const char * const ul_he_type[] = {
   123			"HE 2MU", "HE 3MU", "HE 4MU", "HE SU", "HE 2RU",
   124			"HE 3RU", "HE 4RU", "HE 5-8RU", "HE 9-16RU", "HE >16RU"
   125		};
   126		int ret, i;
   127		u64 total_ppdu_cnt;
   128	
   129		if (!dev->muru_debug) {
   130			seq_puts(file, "Please enable muru_debug first.\n");
   131			return 0;
   132		}
   133	
   134		mutex_lock(&dev->mt76.mutex);
   135	
   136		ret = mt7915_mcu_muru_debug_get(phy, &mu_stats);
   137		if (ret)
   138			goto exit;
   139	
   140	#define __ms_ratio(s)	(!total_ppdu_cnt ? 0 :			  \
   141			le32_to_cpu(s) * 100 / total_ppdu_cnt)
   142	#define __dl_u32(s)	le32_to_cpu(mu_stats.dl.s)
   143		/* Non-HE Downlink*/
   144		total_ppdu_cnt = __dl_u32(cck_cnt) +
   145			__dl_u32(ofdm_cnt) +
   146			__dl_u32(htmix_cnt) +
   147			__dl_u32(htgf_cnt) +
   148			__dl_u32(vht_su_cnt) +
   149			__dl_u32(vht_2mu_cnt) +
   150			__dl_u32(vht_3mu_cnt) +
   151			__dl_u32(vht_4mu_cnt);
   152	
   153		seq_puts(file, "[Non-HE]\nDownlink\nData Type:  ");
   154	
   155		for (i = 0; i < 5; i++)
   156			seq_printf(file, "%8s | ", dl_non_he_type[i]);
   157	
   158		seq_puts(file, "\nTotal Cnt:  ");
   159		seq_printf(file, "%8u | %8u | %8u | %8u | %8u | ",
   160			   __dl_u32(cck_cnt),
   161			   __dl_u32(ofdm_cnt),
   162			   __dl_u32(htmix_cnt),
   163			   __dl_u32(htgf_cnt),
   164			   __dl_u32(vht_su_cnt));
   165	
   166		seq_puts(file, "\nRatio    :  ");
 > 167		seq_printf(file, "%7d%% | %7d%% | %7d%% | %7d%% | %7d%% | ",
   168			   __ms_ratio(mu_stats.dl.cck_cnt),
   169			   __ms_ratio(mu_stats.dl.ofdm_cnt),
   170			   __ms_ratio(mu_stats.dl.htmix_cnt),
   171			   __ms_ratio(mu_stats.dl.htgf_cnt),
   172			   __ms_ratio(mu_stats.dl.vht_su_cnt));
   173	
   174		seq_puts(file, "\nDownlink MU-MIMO\nData Type:  ");
   175	
   176		for (i = 5; i < 8; i++)
   177			seq_printf(file, "%8s | ", dl_non_he_type[i]);
   178	
   179		seq_puts(file, "\nTotal Cnt:  ");
   180		seq_printf(file, "%8u | %8u | %8u | ",
   181			   __dl_u32(vht_2mu_cnt),
   182			   __dl_u32(vht_3mu_cnt),
   183			   __dl_u32(vht_4mu_cnt));
   184	
   185		seq_puts(file, "\nRatio    :  ");
   186		seq_printf(file, "%7d%% | %7d%% | %7d%% | ",
   187			   __ms_ratio(mu_stats.dl.vht_2mu_cnt),
   188			   __ms_ratio(mu_stats.dl.vht_3mu_cnt),
   189			   __ms_ratio(mu_stats.dl.vht_4mu_cnt));
   190	
   191		/* HE Downlink */
   192		total_ppdu_cnt = __dl_u32(he_su_cnt) +
   193			__dl_u32(he_ext_su_cnt) +
   194			__dl_u32(he_2mu_cnt) +
   195			__dl_u32(he_3mu_cnt) +
   196			__dl_u32(he_4mu_cnt) +
   197			__dl_u32(he_2ru_cnt) +
   198			__dl_u32(he_3ru_cnt) +
   199			__dl_u32(he_4ru_cnt) +
   200			__dl_u32(he_5to8ru_cnt) +
   201			__dl_u32(he_9to16ru_cnt) +
   202			__dl_u32(he_gtr16ru_cnt);
   203	
   204		seq_puts(file, "\n\n[HE]\nDownlink\nData Type:  ");
   205	
   206		for (i = 0; i < 2; i++)
   207			seq_printf(file, "%8s | ", dl_he_type[i]);
   208	
   209		seq_puts(file, "\nTotal Cnt:  ");
   210		seq_printf(file, "%8u | %8u | ",
   211			   __dl_u32(he_su_cnt),
   212			   __dl_u32(he_ext_su_cnt));
   213	
   214		seq_puts(file, "\nRatio    :  ");
   215		seq_printf(file, "%7d%% | %7d%% | ",
   216			   __ms_ratio(mu_stats.dl.he_su_cnt),
   217			   __ms_ratio(mu_stats.dl.he_ext_su_cnt));
   218	
   219		seq_puts(file, "\nDownlink MU-MIMO\nData Type:  ");
   220	
   221		for (i = 2; i < 5; i++)
   222			seq_printf(file, "%8s | ", dl_he_type[i]);
   223	
   224		seq_puts(file, "\nTotal Cnt:  ");
   225		seq_printf(file, "%8u | %8u | %8u | ",
   226			   __dl_u32(he_2mu_cnt),
   227			   __dl_u32(he_3mu_cnt),
   228			   __dl_u32(he_4mu_cnt));
   229	
   230		seq_puts(file, "\nRatio    :  ");
   231		seq_printf(file, "%7d%% | %7d%% | %7d%% | ",
   232			   __ms_ratio(mu_stats.dl.he_2mu_cnt),
   233			   __ms_ratio(mu_stats.dl.he_3mu_cnt),
   234			   __ms_ratio(mu_stats.dl.he_4mu_cnt));
   235	
   236		seq_puts(file, "\nDownlink OFDMA\nData Type:  ");
   237	
   238		for (i = 5; i < 11; i++)
   239			seq_printf(file, "%8s | ", dl_he_type[i]);
   240	
   241		seq_puts(file, "\nTotal Cnt:  ");
   242		seq_printf(file, "%8u | %8u | %8u | %8u | %9u | %8u | ",
   243			   __dl_u32(he_2ru_cnt),
   244			   __dl_u32(he_3ru_cnt),
   245			   __dl_u32(he_4ru_cnt),
   246			   __dl_u32(he_5to8ru_cnt),
   247			   __dl_u32(he_9to16ru_cnt),
   248			   __dl_u32(he_gtr16ru_cnt));
   249	#undef __dl_u32
   250		seq_puts(file, "\nRatio    :  ");
   251		seq_printf(file, "%7d%% | %7d%% | %7d%% | %7d%% | %8d%% | %7d%% | ",
   252			   __ms_ratio(mu_stats.dl.he_2ru_cnt),
   253			   __ms_ratio(mu_stats.dl.he_3ru_cnt),
   254			   __ms_ratio(mu_stats.dl.he_4ru_cnt),
   255			   __ms_ratio(mu_stats.dl.he_5to8ru_cnt),
   256			   __ms_ratio(mu_stats.dl.he_9to16ru_cnt),
   257			   __ms_ratio(mu_stats.dl.he_gtr16ru_cnt));
   258	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
