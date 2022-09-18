Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADE15BBE94
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Sep 2022 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIRPIm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIRPIk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 11:08:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70AD20F65
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663513717; x=1695049717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/KwvTyLC4Y67rZl20PUI9vsgvWbXE9VHCiWCQG84Zgo=;
  b=gG/sK/C98tJU5cyeswJp8SMPNJ4ovf1NuFgf+tK9RGW8RVH9aV1KdSD0
   thJ7ZAywiWcJ1265KD33kcBZQSK8VXjSIpfTdJvEltqjptb4xqkCuwoJp
   S252FHmd2US7Y0VOsm8DbEPFstYDFHqLtmZA0qJk8r4qHJ0gvVjXLw99B
   nQd3Ph2ZtVhxZDHPSZtn3ousPsBA3sxCt5wXcrKE5zHtiEOr6uRw/P8Tp
   gDdp+sOU90UTNJIHz8OVpXxixWzmGBzZfA2x4ZQiscfr0KW222uNZqGtC
   uq/nQFxAbks9exGQxkgb1RCKTVDYR6jtdfHdoUnQF6BQcjvS5JZPWPvEs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="286285266"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="286285266"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 08:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="946918935"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Sep 2022 08:08:34 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZvuL-0001HB-2C;
        Sun, 18 Sep 2022 15:08:33 +0000
Date:   Sun, 18 Sep 2022 23:08:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Golle <daniel@makrotopia.org>,
        linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 10/16] rt2x00: add TX LOFT calibration for MT7620
Message-ID: <202209182215.MtqzOalX-lkp@intel.com>
References: <dc196a577619af47eb759099e7a7cdbda9f7ce5f.1663431288.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc196a577619af47eb759099e7a7cdbda9f7ce5f.1663431288.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.0-rc5 next-20220916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/rt2x00-OpenWrt-patches-improving-MT7620/20220918-005109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220918/202209182215.MtqzOalX-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/40cb92749cf8545acfa03c180c973181abed168c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Golle/rt2x00-OpenWrt-patches-improving-MT7620/20220918-005109
        git checkout 40cb92749cf8545acfa03c180c973181abed168c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cpuidle/governors/ drivers/net/ethernet/mellanox/mlx5/core/ drivers/net/wireless/ralink/rt2x00/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9509:6: warning: no previous prototype for function 'rt2800_loft_iq_calibration' [-Wmissing-prototypes]
   void rt2800_loft_iq_calibration(struct rt2x00_dev *rt2x00dev)
        ^
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9509:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void rt2800_loft_iq_calibration(struct rt2x00_dev *rt2x00dev)
   ^
   static 
   1 warning generated.


vim +/rt2800_loft_iq_calibration +9509 drivers/net/wireless/ralink/rt2x00/rt2800lib.c

  9508	
> 9509	void rt2800_loft_iq_calibration(struct rt2x00_dev *rt2x00dev)
  9510	{
  9511		struct rf_reg_pair rf_store[CHAIN_NUM][13];
  9512		u32 macorg1 = 0;
  9513		u32 macorg2 = 0;
  9514		u32 macorg3 = 0;
  9515		u32 macorg4 = 0;
  9516		u32 macorg5 = 0;
  9517		u32 orig528 = 0;
  9518		u32 orig52c = 0;
  9519	
  9520		u32 savemacsysctrl = 0;
  9521		u32 macvalue = 0;
  9522		u32 mac13b8 = 0;
  9523		u32 p0 = 0, p1 = 0;
  9524		u32 p0_idx10 = 0, p1_idx10 = 0;
  9525	
  9526		u8 rfvalue;
  9527		u8 loft_dc_search_result[CHAIN_NUM][RF_ALC_NUM][2];
  9528		u8 ger[CHAIN_NUM], per[CHAIN_NUM];
  9529	
  9530		u8 vga_gain[] = {14, 14};
  9531		u8 bbp = 0, ch_idx = 0, rf_alc_idx = 0, idx = 0;
  9532		u8 bbpr30, rfb0r39, rfb0r42;
  9533		u8 bbpr1;
  9534		u8 bbpr4;
  9535		u8 bbpr241, bbpr242;
  9536		u8 count_step;
  9537	
  9538		static const u8 rf_gain[] = {0x00, 0x01, 0x02, 0x04, 0x08, 0x0c};
  9539		static const u8 rfvga_gain_table[] = {0x24, 0x25, 0x26, 0x27, 0x28, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,
  9540						      0x31, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3F};
  9541		static const u8 bbp_2324gain[] = {0x16, 0x14, 0x12, 0x10, 0x0c, 0x08};
  9542	
  9543		savemacsysctrl = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
  9544		macorg1 = rt2800_register_read(rt2x00dev, TX_PIN_CFG);
  9545		macorg2 = rt2800_register_read(rt2x00dev, RF_CONTROL0);
  9546		macorg3 = rt2800_register_read(rt2x00dev, RF_BYPASS0);
  9547		macorg4 = rt2800_register_read(rt2x00dev, RF_CONTROL3);
  9548		macorg5 = rt2800_register_read(rt2x00dev, RF_BYPASS3);
  9549		mac13b8 = rt2800_register_read(rt2x00dev, 0x13b8);
  9550		orig528 = rt2800_register_read(rt2x00dev, RF_CONTROL2);
  9551		orig52c = rt2800_register_read(rt2x00dev, RF_BYPASS2);
  9552	
  9553		macvalue = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
  9554		macvalue &= (~0x04);
  9555		rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, macvalue);
  9556	
  9557		if (unlikely(rt2800_wait_bbp_rf_ready(rt2x00dev, MAC_STATUS_CFG_BBP_RF_BUSY_TX)))
  9558			rt2x00_warn(rt2x00dev, "RF TX busy in LOFT IQ calibration\n");
  9559	
  9560		macvalue = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
  9561		macvalue &= (~0x08);
  9562		rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, macvalue);
  9563	
  9564		if (unlikely(rt2800_wait_bbp_rf_ready(rt2x00dev, MAC_STATUS_CFG_BBP_RF_BUSY_RX)))
  9565			rt2x00_warn(rt2x00dev, "RF RX busy in LOFT IQ calibration\n");
  9566	
  9567		for (ch_idx = 0; ch_idx < 2; ch_idx++)
  9568			rt2800_rf_configstore(rt2x00dev, rf_store, ch_idx);
  9569	
  9570		bbpr30 = rt2800_bbp_read(rt2x00dev, 30);
  9571		rfb0r39 = rt2800_rfcsr_read_bank(rt2x00dev, 0, 39);
  9572		rfb0r42 = rt2800_rfcsr_read_bank(rt2x00dev, 0, 42);
  9573	
  9574		rt2800_bbp_write(rt2x00dev, 30, 0x1F);
  9575		rt2800_rfcsr_write_bank(rt2x00dev, 0, 39, 0x80);
  9576		rt2800_rfcsr_write_bank(rt2x00dev, 0, 42, 0x5B);
  9577	
  9578		rt2800_bbp_write(rt2x00dev, 23, 0x00);
  9579		rt2800_bbp_write(rt2x00dev, 24, 0x00);
  9580	
  9581		rt2800_setbbptonegenerator(rt2x00dev);
  9582	
  9583		for (ch_idx = 0; ch_idx < 2; ch_idx++) {
  9584			rt2800_bbp_write(rt2x00dev, 23, 0x00);
  9585			rt2800_bbp_write(rt2x00dev, 24, 0x00);
  9586			rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, 0x00);
  9587			rt2800_register_write(rt2x00dev, TX_PIN_CFG, 0x0000000F);
  9588			rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x00000004);
  9589			rt2800_register_write(rt2x00dev, RF_BYPASS0, 0x00003306);
  9590			rt2800_register_write(rt2x00dev, 0x13b8, 0x10);
  9591			udelay(1);
  9592	
  9593			if (ch_idx == 0)
  9594				rt2800_rf_aux_tx0_loopback(rt2x00dev);
  9595			else
  9596				rt2800_rf_aux_tx1_loopback(rt2x00dev);
  9597	
  9598			udelay(1);
  9599	
  9600			if (ch_idx == 0)
  9601				rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x00001004);
  9602			else
  9603				rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x00002004);
  9604	
  9605			rt2800_bbp_write(rt2x00dev, 158, 0x05);
  9606			rt2800_bbp_write(rt2x00dev, 159, 0x00);
  9607	
  9608			rt2800_bbp_write(rt2x00dev, 158, 0x01);
  9609			if (ch_idx == 0)
  9610				rt2800_bbp_write(rt2x00dev, 159, 0x00);
  9611			else
  9612				rt2800_bbp_write(rt2x00dev, 159, 0x01);
  9613	
  9614			vga_gain[ch_idx] = 18;
  9615			for (rf_alc_idx = 0; rf_alc_idx < 3; rf_alc_idx++) {
  9616				rt2800_bbp_write(rt2x00dev, 23, bbp_2324gain[rf_alc_idx]);
  9617				rt2800_bbp_write(rt2x00dev, 24, bbp_2324gain[rf_alc_idx]);
  9618	
  9619				macvalue = rt2800_register_read(rt2x00dev, RF_CONTROL3);
  9620				macvalue &= (~0x0000F1F1);
  9621				macvalue |= (rf_gain[rf_alc_idx] << 4);
  9622				macvalue |= (rf_gain[rf_alc_idx] << 12);
  9623				rt2800_register_write(rt2x00dev, RF_CONTROL3, macvalue);
  9624				macvalue = (0x0000F1F1);
  9625				rt2800_register_write(rt2x00dev, RF_BYPASS3, macvalue);
  9626	
  9627				if (rf_alc_idx == 0) {
  9628					rt2800_write_dc(rt2x00dev, ch_idx, 0, 1, 0x21);
  9629					for (; vga_gain[ch_idx] > 0;
  9630					     vga_gain[ch_idx] = vga_gain[ch_idx] - 2) {
  9631						rfvalue = rfvga_gain_table[vga_gain[ch_idx]];
  9632						rt2800_rfcsr_write_dccal(rt2x00dev, 3, rfvalue);
  9633						rt2800_rfcsr_write_dccal(rt2x00dev, 4, rfvalue);
  9634						rt2800_write_dc(rt2x00dev, ch_idx, 0, 1, 0x00);
  9635						rt2800_write_dc(rt2x00dev, ch_idx, 0, 0, 0x00);
  9636						p0 = rt2800_do_fft_accumulation(rt2x00dev, 0x0A, 0);
  9637						rt2800_write_dc(rt2x00dev, ch_idx, 0, 0, 0x21);
  9638						p1 = rt2800_do_fft_accumulation(rt2x00dev, 0x0A, 0);
  9639						rt2x00_dbg(rt2x00dev, "LOFT AGC %d %d\n", p0, p1);
  9640						if ((p0 < 7000 * 7000) && (p1 < (7000 * 7000)))
  9641							break;
  9642					}
  9643	
  9644					rt2800_write_dc(rt2x00dev, ch_idx, 0, 0, 0x00);
  9645					rt2800_write_dc(rt2x00dev, ch_idx, 0, 1, 0x00);
  9646	
  9647					rt2x00_dbg(rt2x00dev, "Used VGA %d %x\n", vga_gain[ch_idx],
  9648						   rfvga_gain_table[vga_gain[ch_idx]]);
  9649	
  9650					if (vga_gain[ch_idx] < 0)
  9651						vga_gain[ch_idx] = 0;
  9652				}
  9653	
  9654				rfvalue = rfvga_gain_table[vga_gain[ch_idx]];
  9655	
  9656				rt2800_rfcsr_write_dccal(rt2x00dev, 3, rfvalue);
  9657				rt2800_rfcsr_write_dccal(rt2x00dev, 4, rfvalue);
  9658	
  9659				rt2800_loft_search(rt2x00dev, ch_idx, rf_alc_idx, loft_dc_search_result);
  9660			}
  9661		}
  9662	
  9663		for (rf_alc_idx = 0; rf_alc_idx < 3; rf_alc_idx++) {
  9664			for (idx = 0; idx < 4; idx++) {
  9665				rt2800_bbp_write(rt2x00dev, 158, 0xB0);
  9666				bbp = (idx << 2) + rf_alc_idx;
  9667				rt2800_bbp_write(rt2x00dev, 159, bbp);
  9668				rt2x00_dbg(rt2x00dev, " ALC %2x,", bbp);
  9669	
  9670				rt2800_bbp_write(rt2x00dev, 158, 0xb1);
  9671				bbp = loft_dc_search_result[CHAIN_0][rf_alc_idx][0x00];
  9672				bbp = bbp & 0x3F;
  9673				rt2800_bbp_write(rt2x00dev, 159, bbp);
  9674				rt2x00_dbg(rt2x00dev, " I0 %2x,", bbp);
  9675	
  9676				rt2800_bbp_write(rt2x00dev, 158, 0xb2);
  9677				bbp = loft_dc_search_result[CHAIN_0][rf_alc_idx][0x01];
  9678				bbp = bbp & 0x3F;
  9679				rt2800_bbp_write(rt2x00dev, 159, bbp);
  9680				rt2x00_dbg(rt2x00dev, " Q0 %2x,", bbp);
  9681	
  9682				rt2800_bbp_write(rt2x00dev, 158, 0xb8);
  9683				bbp = loft_dc_search_result[CHAIN_1][rf_alc_idx][0x00];
  9684				bbp = bbp & 0x3F;
  9685				rt2800_bbp_write(rt2x00dev, 159, bbp);
  9686				rt2x00_dbg(rt2x00dev, " I1 %2x,", bbp);
  9687	
  9688				rt2800_bbp_write(rt2x00dev, 158, 0xb9);
  9689				bbp = loft_dc_search_result[CHAIN_1][rf_alc_idx][0x01];
  9690				bbp = bbp & 0x3F;
  9691				rt2800_bbp_write(rt2x00dev, 159, bbp);
  9692				rt2x00_dbg(rt2x00dev, " Q1 %2x\n", bbp);
  9693			}
  9694		}
  9695	
  9696		rt2800_bbp_write(rt2x00dev, 23, 0x00);
  9697		rt2800_bbp_write(rt2x00dev, 24, 0x00);
  9698	
  9699		rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x04);
  9700	
  9701		rt2800_bbp_write(rt2x00dev, 158, 0x00);
  9702		rt2800_bbp_write(rt2x00dev, 159, 0x00);
  9703	
  9704		bbp = 0x00;
  9705		rt2800_bbp_write(rt2x00dev, 244, 0x00);
  9706	
  9707		rt2800_bbp_write(rt2x00dev, 21, 0x01);
  9708		udelay(1);
  9709		rt2800_bbp_write(rt2x00dev, 21, 0x00);
  9710	
  9711		rt2800_rf_configrecover(rt2x00dev, rf_store);
  9712	
  9713		rt2800_register_write(rt2x00dev, TX_PIN_CFG, macorg1);
  9714		rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x04);
  9715		rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x00);
  9716		rt2800_register_write(rt2x00dev, RF_BYPASS0, 0x00);
  9717		rt2800_register_write(rt2x00dev, RF_CONTROL0, macorg2);
  9718		udelay(1);
  9719		rt2800_register_write(rt2x00dev, RF_BYPASS0, macorg3);
  9720		rt2800_register_write(rt2x00dev, RF_CONTROL3, macorg4);
  9721		rt2800_register_write(rt2x00dev, RF_BYPASS3, macorg5);
  9722		rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, savemacsysctrl);
  9723		rt2800_register_write(rt2x00dev, RF_CONTROL2, orig528);
  9724		rt2800_register_write(rt2x00dev, RF_BYPASS2, orig52c);
  9725		rt2800_register_write(rt2x00dev, 0x13b8, mac13b8);
  9726	
  9727		savemacsysctrl = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
  9728		macorg1 = rt2800_register_read(rt2x00dev, TX_PIN_CFG);
  9729		macorg2 = rt2800_register_read(rt2x00dev, RF_CONTROL0);
  9730		macorg3 = rt2800_register_read(rt2x00dev, RF_BYPASS0);
  9731		macorg4 = rt2800_register_read(rt2x00dev, RF_CONTROL3);
  9732		macorg5 = rt2800_register_read(rt2x00dev, RF_BYPASS3);
  9733	
  9734		bbpr1 = rt2800_bbp_read(rt2x00dev, 1);
  9735		bbpr4 = rt2800_bbp_read(rt2x00dev, 4);
  9736		bbpr241 = rt2800_bbp_read(rt2x00dev, 241);
  9737		bbpr242 = rt2800_bbp_read(rt2x00dev, 242);
  9738		mac13b8 = rt2800_register_read(rt2x00dev, 0x13b8);
  9739	
  9740		macvalue = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
  9741		macvalue &= (~0x04);
  9742		rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, macvalue);
  9743	
  9744		if (unlikely(rt2800_wait_bbp_rf_ready(rt2x00dev, MAC_STATUS_CFG_BBP_RF_BUSY_TX)))
  9745			rt2x00_warn(rt2x00dev, "RF TX busy in LOFT IQ calibration\n");
  9746	
  9747		macvalue = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
  9748		macvalue &= (~0x08);
  9749		rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, macvalue);
  9750	
  9751		if (unlikely(rt2800_wait_bbp_rf_ready(rt2x00dev, MAC_STATUS_CFG_BBP_RF_BUSY_RX)))
  9752			rt2x00_warn(rt2x00dev, "RF RX busy in LOFT IQ calibration\n");
  9753	
  9754		if (test_bit(CAPABILITY_EXTERNAL_PA_TX0, &rt2x00dev->cap_flags)) {
  9755			rt2800_register_write(rt2x00dev, RF_CONTROL3, 0x00000101);
  9756			rt2800_register_write(rt2x00dev, RF_BYPASS3, 0x0000F1F1);
  9757		}
  9758	
  9759		rt2800_bbp_write(rt2x00dev, 23, 0x00);
  9760		rt2800_bbp_write(rt2x00dev, 24, 0x00);
  9761	
  9762		if (test_bit(CAPABILITY_EXTERNAL_PA_TX0, &rt2x00dev->cap_flags)) {
  9763			rt2800_bbp_write(rt2x00dev, 4, bbpr4 & (~0x18));
  9764			rt2800_bbp_write(rt2x00dev, 21, 0x01);
  9765			udelay(1);
  9766			rt2800_bbp_write(rt2x00dev, 21, 0x00);
  9767	
  9768			rt2800_bbp_write(rt2x00dev, 241, 0x14);
  9769			rt2800_bbp_write(rt2x00dev, 242, 0x80);
  9770			rt2800_bbp_write(rt2x00dev, 244, 0x31);
  9771		} else {
  9772			rt2800_setbbptonegenerator(rt2x00dev);
  9773		}
  9774	
  9775		rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x00000004);
  9776		rt2800_register_write(rt2x00dev, RF_BYPASS0, 0x00003306);
  9777		udelay(1);
  9778	
  9779		rt2800_register_write(rt2x00dev, TX_PIN_CFG, 0x0000000F);
  9780	
  9781		if (!test_bit(CAPABILITY_EXTERNAL_PA_TX0, &rt2x00dev->cap_flags)) {
  9782			rt2800_register_write(rt2x00dev, RF_CONTROL3, 0x00000000);
  9783			rt2800_register_write(rt2x00dev, RF_BYPASS3, 0x0000F1F1);
  9784		}
  9785	
  9786		rt2800_register_write(rt2x00dev, 0x13b8, 0x00000010);
  9787	
  9788		for (ch_idx = 0; ch_idx < 2; ch_idx++)
  9789			rt2800_rf_configstore(rt2x00dev, rf_store, ch_idx);
  9790	
  9791		rt2800_rfcsr_write_dccal(rt2x00dev, 3, 0x3B);
  9792		rt2800_rfcsr_write_dccal(rt2x00dev, 4, 0x3B);
  9793	
  9794		rt2800_bbp_write(rt2x00dev, 158, 0x03);
  9795		rt2800_bbp_write(rt2x00dev, 159, 0x60);
  9796		rt2800_bbp_write(rt2x00dev, 158, 0xB0);
  9797		rt2800_bbp_write(rt2x00dev, 159, 0x80);
  9798	
  9799		for (ch_idx = 0; ch_idx < 2; ch_idx++) {
  9800			rt2800_bbp_write(rt2x00dev, 23, 0x00);
  9801			rt2800_bbp_write(rt2x00dev, 24, 0x00);
  9802	
  9803			if (ch_idx == 0) {
  9804				rt2800_bbp_write(rt2x00dev, 158, 0x01);
  9805				rt2800_bbp_write(rt2x00dev, 159, 0x00);
  9806				if (test_bit(CAPABILITY_EXTERNAL_PA_TX0, &rt2x00dev->cap_flags)) {
  9807					bbp = bbpr1 & (~0x18);
  9808					bbp = bbp | 0x00;
  9809					rt2800_bbp_write(rt2x00dev, 1, bbp);
  9810				}
  9811				rt2800_rf_aux_tx0_loopback(rt2x00dev);
  9812				rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x00001004);
  9813			} else {
  9814				rt2800_bbp_write(rt2x00dev, 158, 0x01);
  9815				rt2800_bbp_write(rt2x00dev, 159, 0x01);
  9816				if (test_bit(CAPABILITY_EXTERNAL_PA_TX1, &rt2x00dev->cap_flags)) {
  9817					bbp = bbpr1 & (~0x18);
  9818					bbp = bbp | 0x08;
  9819					rt2800_bbp_write(rt2x00dev, 1, bbp);
  9820				}
  9821				rt2800_rf_aux_tx1_loopback(rt2x00dev);
  9822				rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x00002004);
  9823			}
  9824	
  9825			rt2800_bbp_write(rt2x00dev, 158, 0x05);
  9826			rt2800_bbp_write(rt2x00dev, 159, 0x04);
  9827	
  9828			bbp = (ch_idx == 0) ? 0x28 : 0x46;
  9829			rt2800_bbp_write(rt2x00dev, 158, bbp);
  9830			rt2800_bbp_write(rt2x00dev, 159, 0x00);
  9831	
  9832			if (test_bit(CAPABILITY_EXTERNAL_PA_TX0, &rt2x00dev->cap_flags)) {
  9833				rt2800_bbp_write(rt2x00dev, 23, 0x06);
  9834				rt2800_bbp_write(rt2x00dev, 24, 0x06);
  9835				count_step = 1;
  9836			} else {
  9837				rt2800_bbp_write(rt2x00dev, 23, 0x1F);
  9838				rt2800_bbp_write(rt2x00dev, 24, 0x1F);
  9839				count_step = 2;
  9840			}
  9841	
  9842			for (; vga_gain[ch_idx] < 19; vga_gain[ch_idx] = (vga_gain[ch_idx] + count_step)) {
  9843				rfvalue = rfvga_gain_table[vga_gain[ch_idx]];
  9844				rt2800_rfcsr_write_dccal(rt2x00dev, 3, rfvalue);
  9845				rt2800_rfcsr_write_dccal(rt2x00dev, 4, rfvalue);
  9846	
  9847				bbp = (ch_idx == 0) ? 0x29 : 0x47;
  9848				rt2800_bbp_write(rt2x00dev, 158, bbp);
  9849				rt2800_bbp_write(rt2x00dev, 159, 0x00);
  9850				p0 = rt2800_do_fft_accumulation(rt2x00dev, 0x14, 0);
  9851				if (test_bit(CAPABILITY_EXTERNAL_PA_TX0, &rt2x00dev->cap_flags))
  9852					p0_idx10 = rt2800_read_fft_accumulation(rt2x00dev, 0x0A);
  9853	
  9854				bbp = (ch_idx == 0) ? 0x29 : 0x47;
  9855				rt2800_bbp_write(rt2x00dev, 158, bbp);
  9856				rt2800_bbp_write(rt2x00dev, 159, 0x21);
  9857				p1 = rt2800_do_fft_accumulation(rt2x00dev, 0x14, 0);
  9858				if (test_bit(CAPABILITY_EXTERNAL_PA_TX1, &rt2x00dev->cap_flags))
  9859					p1_idx10 = rt2800_read_fft_accumulation(rt2x00dev, 0x0A);
  9860	
  9861				rt2x00_dbg(rt2x00dev, "IQ AGC %d %d\n", p0, p1);
  9862	
  9863				if (test_bit(CAPABILITY_EXTERNAL_PA_TX0, &rt2x00dev->cap_flags)) {
  9864					rt2x00_dbg(rt2x00dev, "IQ AGC IDX 10 %d %d\n", p0_idx10, p1_idx10);
  9865					if ((p0_idx10 > 7000 * 7000) || (p1_idx10 > 7000 * 7000)) {
  9866						if (vga_gain[ch_idx] != 0)
  9867							vga_gain[ch_idx] = vga_gain[ch_idx] - 1;
  9868						break;
  9869					}
  9870				}
  9871	
  9872				if ((p0 > 2500 * 2500) || (p1 > 2500 * 2500))
  9873					break;
  9874			}
  9875	
  9876			if (vga_gain[ch_idx] > 18)
  9877				vga_gain[ch_idx] = 18;
  9878			rt2x00_dbg(rt2x00dev, "Used VGA %d %x\n", vga_gain[ch_idx],
  9879				   rfvga_gain_table[vga_gain[ch_idx]]);
  9880	
  9881			bbp = (ch_idx == 0) ? 0x29 : 0x47;
  9882			rt2800_bbp_write(rt2x00dev, 158, bbp);
  9883			rt2800_bbp_write(rt2x00dev, 159, 0x00);
  9884	
  9885			rt2800_iq_search(rt2x00dev, ch_idx, ger, per);
  9886		}
  9887	
  9888		rt2800_bbp_write(rt2x00dev, 23, 0x00);
  9889		rt2800_bbp_write(rt2x00dev, 24, 0x00);
  9890		rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x04);
  9891	
  9892		rt2800_bbp_write(rt2x00dev, 158, 0x28);
  9893		bbp = ger[CHAIN_0] & 0x0F;
  9894		rt2800_bbp_write(rt2x00dev, 159, bbp);
  9895	
  9896		rt2800_bbp_write(rt2x00dev, 158, 0x29);
  9897		bbp = per[CHAIN_0] & 0x3F;
  9898		rt2800_bbp_write(rt2x00dev, 159, bbp);
  9899	
  9900		rt2800_bbp_write(rt2x00dev, 158, 0x46);
  9901		bbp = ger[CHAIN_1] & 0x0F;
  9902		rt2800_bbp_write(rt2x00dev, 159, bbp);
  9903	
  9904		rt2800_bbp_write(rt2x00dev, 158, 0x47);
  9905		bbp = per[CHAIN_1] & 0x3F;
  9906		rt2800_bbp_write(rt2x00dev, 159, bbp);
  9907	
  9908		if (test_bit(CAPABILITY_EXTERNAL_PA_TX0, &rt2x00dev->cap_flags)) {
  9909			rt2800_bbp_write(rt2x00dev, 1, bbpr1);
  9910			rt2800_bbp_write(rt2x00dev, 241, bbpr241);
  9911			rt2800_bbp_write(rt2x00dev, 242, bbpr242);
  9912		}
  9913		rt2800_bbp_write(rt2x00dev, 244, 0x00);
  9914	
  9915		rt2800_bbp_write(rt2x00dev, 158, 0x00);
  9916		rt2800_bbp_write(rt2x00dev, 159, 0x00);
  9917		rt2800_bbp_write(rt2x00dev, 158, 0xB0);
  9918		rt2800_bbp_write(rt2x00dev, 159, 0x00);
  9919	
  9920		rt2800_bbp_write(rt2x00dev, 30, bbpr30);
  9921		rt2800_rfcsr_write_bank(rt2x00dev, 0, 39, rfb0r39);
  9922		rt2800_rfcsr_write_bank(rt2x00dev, 0, 42, rfb0r42);
  9923	
  9924		if (test_bit(CAPABILITY_EXTERNAL_PA_TX0, &rt2x00dev->cap_flags))
  9925			rt2800_bbp_write(rt2x00dev, 4, bbpr4);
  9926	
  9927		rt2800_bbp_write(rt2x00dev, 21, 0x01);
  9928		udelay(1);
  9929		rt2800_bbp_write(rt2x00dev, 21, 0x00);
  9930	
  9931		rt2800_rf_configrecover(rt2x00dev, rf_store);
  9932	
  9933		rt2800_register_write(rt2x00dev, TX_PIN_CFG, macorg1);
  9934		rt2800_register_write(rt2x00dev, RF_CONTROL0, 0x00);
  9935		rt2800_register_write(rt2x00dev, RF_BYPASS0, 0x00);
  9936		rt2800_register_write(rt2x00dev, RF_CONTROL0, macorg2);
  9937		udelay(1);
  9938		rt2800_register_write(rt2x00dev, RF_BYPASS0, macorg3);
  9939		rt2800_register_write(rt2x00dev, RF_CONTROL3, macorg4);
  9940		rt2800_register_write(rt2x00dev, RF_BYPASS3, macorg5);
  9941		rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, savemacsysctrl);
  9942		rt2800_register_write(rt2x00dev, 0x13b8, mac13b8);
  9943	}
  9944	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
