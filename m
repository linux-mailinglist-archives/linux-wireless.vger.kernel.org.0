Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29F85AF79D
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 00:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIFWDz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 18:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIFWDy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 18:03:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3E384EDD
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662501833; x=1694037833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gzsx0sqcIR+vSmALrntEU2uCEsZm8SlFkhJyCcOSmgI=;
  b=Q6pTVFYvhyUYfv3sX7oNvtpgod6uYVpMaEQVyMldW1hMpqFQSliK2krp
   opzczcIjtVumDDkPbZnl9vHkNzm5CZJdpp/p+2hJT42gHNju1jWuijtMW
   986rjVcF1kBcZ27KvdijiH23t+VP5VW7oJ8lpLHo1WrW7Nu4+XMY/kaMs
   OxCIf1x33r7Li6Gk/x3NQH74kZHXSxin2P2UuWs4UVeB/WZ8OGm7RBlpW
   im7We41jVwdOCxl5w88BwQHan9qmbtEh/LXO10OAebSh/mK5FE0Nlurqy
   5DXsLhkkpf0KmHy1s+6qPKKFIvz4PFWtdMAozs+ZdqH1J/Ayjgdf1voY0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="295451368"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="295451368"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 15:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="682564896"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2022 15:03:49 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVgfc-0005hj-1d;
        Tue, 06 Sep 2022 22:03:48 +0000
Date:   Wed, 7 Sep 2022 06:03:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deren Wu <Deren.Wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     kbuild-all@lists.01.org, Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7921: introduce Country Location
 Control support
Message-ID: <202209070520.bQXe62tP-lkp@intel.com>
References: <a7b8353c71c5c8689d22dc450721c98ed11ab912.1662454722.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b8353c71c5c8689d22dc450721c98ed11ab912.1662454722.git.deren.wu@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Deren,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.0-rc4 next-20220906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Deren-Wu/wifi-mt76-mt7921-introduce-Country-Location-Control-support/20220906-171401
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: arm64-randconfig-s042-20220906 (https://download.01.org/0day-ci/archive/20220907/202209070520.bQXe62tP-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/e0bf37418dbcff6f111fbf6dad1d142180e2ec4f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Deren-Wu/wifi-mt76-mt7921-introduce-Country-Location-Control-support/20220906-171401
        git checkout e0bf37418dbcff6f111fbf6dad1d142180e2ec4f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:1089:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [usertype] len @@     got unsigned long @@
   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:1089:25: sparse:     expected restricted __le16 [addressable] [usertype] len
   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:1089:25: sparse:     got unsigned long
>> drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:1090:65: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int len @@     got restricted __le16 [addressable] [usertype] len @@
   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:1090:65: sparse:     expected int len
   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:1090:65: sparse:     got restricted __le16 [addressable] [usertype] len

vim +1089 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c

  1048	
  1049	static
  1050	int __mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
  1051				 enum environment_cap env_cap,
  1052				 struct mt7921_clc *clc,
  1053				 u8 idx)
  1054	{
  1055		struct sk_buff *skb;
  1056		struct {
  1057			u8 ver;
  1058			u8 pad0;
  1059			__le16 len;
  1060			u8 idx;
  1061			u8 env;
  1062			u8 pad1[2];
  1063			u8 alpha2[2];
  1064			u8 type[2];
  1065			u8 rsvd[64];
  1066		} __packed req = {
  1067			.idx = idx,
  1068			.env = env_cap,
  1069		};
  1070		int ret, valid_cnt = 0;
  1071		u8 i, *pos;
  1072	
  1073		if (!clc)
  1074			return 0;
  1075	
  1076		pos = clc->data;
  1077		for (i = 0; i < clc->nr_country; i++) {
  1078			struct mt7921_clc_rule *rule = (struct mt7921_clc_rule *)pos;
  1079			u16 len = le16_to_cpu(rule->len);
  1080	
  1081			pos += len + sizeof(*rule);
  1082			if (rule->alpha2[0] != alpha2[0] ||
  1083			    rule->alpha2[1] != alpha2[1])
  1084				continue;
  1085	
  1086			memcpy(req.alpha2, rule->alpha2, 2);
  1087			memcpy(req.type, rule->type, 2);
  1088	
> 1089			req.len = sizeof(req) + len;
> 1090			skb = __mt76_mcu_msg_alloc(&dev->mt76, &req, req.len,
  1091						   sizeof(req), GFP_KERNEL);
  1092			if (!skb)
  1093				return -ENOMEM;
  1094			skb_put_data(skb, rule->data, len);
  1095	
  1096			ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
  1097						    MCU_CE_CMD(SET_CLC), false);
  1098			if (ret < 0)
  1099				return ret;
  1100			valid_cnt++;
  1101		}
  1102	
  1103		if (!valid_cnt)
  1104			return -ENOENT;
  1105	
  1106		return 0;
  1107	}
  1108	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
