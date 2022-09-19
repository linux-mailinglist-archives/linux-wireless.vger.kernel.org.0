Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BCB5BD59C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 22:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiISUSS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 16:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiISUSQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 16:18:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDEA4363F
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663618695; x=1695154695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AWyCWx3atPM2rr9ya84xeFQEJZ50J2dAU+x1c+pW/ao=;
  b=O9IWVhn+PThbFbm5YKb/MpMaknPTWW3aH6ZzElY/yTcS3+VZGbogSnCn
   AoRj31EtFaS8e2oD3o5cld/t/I0ePhUshbAVf9uRaOkx59qp3jZcIcFqz
   nIeHX2C6Wb1HOJYDkr+5Src+V0NpeEY77XofK4ZoJwVC7+3VfwzhL6RKx
   /hFaShzLHWm4/W/Aw2VDQTVEbX+v6FNCjss0NgcJ4hSmGRLcRcjwPsTxg
   QgF8yF6/+0hDjiH7CpAMqFHYy8sP07sVs8wgxlsCfNfTnToSzJPNgX65Y
   y9xyDeRxNanFU5394MRTLRMkKpzlVIV03ep/HkTTdKDeoqzHB+wyI2Ifd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="286558907"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="286558907"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 13:18:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="651822525"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Sep 2022 13:18:12 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaNDX-0002Cz-2f;
        Mon, 19 Sep 2022 20:18:11 +0000
Date:   Tue, 20 Sep 2022 04:18:07 +0800
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
Message-ID: <202209200402.3TMVPkx4-lkp@intel.com>
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
[also build test WARNING on wireless/main linus/master v6.0-rc6 next-20220919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/rt2x00-OpenWrt-patches-improving-MT7620/20220918-005109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220920/202209200402.3TMVPkx4-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/40cb92749cf8545acfa03c180c973181abed168c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Golle/rt2x00-OpenWrt-patches-improving-MT7620/20220918-005109
        git checkout 40cb92749cf8545acfa03c180c973181abed168c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/irqchip/ drivers/net/wireless/ralink/rt2x00/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9439:15: warning: result of comparison of constant -7 with expression of type 'char' is always false [-Wtautological-constant-out-of-range-compare]
           gerr = (gerr < -0x07) ? -0x07 : (gerr > 0x05) ? 0x05 : gerr;
                   ~~~~ ^ ~~~~~
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9443:15: warning: result of comparison of constant -31 with expression of type 'char' is always false [-Wtautological-constant-out-of-range-compare]
           perr = (perr < -0x1f) ? -0x1f : (perr > 0x1d) ? 0x1d : perr;
                   ~~~~ ^ ~~~~~
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9509:6: warning: no previous prototype for function 'rt2800_loft_iq_calibration' [-Wmissing-prototypes]
   void rt2800_loft_iq_calibration(struct rt2x00_dev *rt2x00dev)
        ^
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9509:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void rt2800_loft_iq_calibration(struct rt2x00_dev *rt2x00dev)
   ^
   static 
   3 warnings generated.


vim +/char +9439 drivers/net/wireless/ralink/rt2x00/rt2800lib.c

  9350	
  9351	static void rt2800_iq_search(struct rt2x00_dev *rt2x00dev, u8 ch_idx, u8 *ges, u8 *pes)
  9352	{
  9353		u32 p0 = 0, p1 = 0, pf = 0;
  9354		char perr = 0, gerr = 0, iq_err = 0;
  9355		char pef = 0, gef = 0;
  9356		char psta, pend;
  9357		char gsta, gend;
  9358	
  9359		u8 ibit = 0x20;
  9360		u8 first_search = 0x00, touch_neg_max = 0x00;
  9361		char idx0 = 0, idx1 = 0;
  9362		u8 gop;
  9363		u8 bbp = 0;
  9364		char bidx;
  9365	
  9366		for (bidx = 5; bidx >= 1; bidx--) {
  9367			for (gop = 0; gop < 2; gop++) {
  9368				if (gop == 1 || bidx < 4) {
  9369					if (gop == 0)
  9370						iq_err = gerr;
  9371					else
  9372						iq_err = perr;
  9373	
  9374					first_search = (gop == 0) ? (bidx == 3) : (bidx == 5);
  9375					touch_neg_max = (gop) ? ((iq_err & 0x0F) == 0x08) :
  9376								((iq_err & 0x3F) == 0x20);
  9377	
  9378					if (touch_neg_max) {
  9379						p0 = pf;
  9380						idx0 = iq_err;
  9381					} else {
  9382						idx0 = iq_err - ibit;
  9383						bbp = (ch_idx == 0) ? ((gop == 0) ? 0x28 : 0x29) :
  9384								      ((gop == 0) ? 0x46 : 0x47);
  9385	
  9386						rt2800_bbp_write(rt2x00dev, 158, bbp);
  9387						rt2800_bbp_write(rt2x00dev, 159, idx0);
  9388	
  9389						p0 = rt2800_do_fft_accumulation(rt2x00dev, 0x14, 1);
  9390					}
  9391	
  9392					idx1 = iq_err + (first_search ? 0 : ibit);
  9393					idx1 = (gop == 0) ? (idx1 & 0x0F) : (idx1 & 0x3F);
  9394	
  9395					bbp = (ch_idx == 0) ? (gop == 0) ? 0x28 : 0x29 :
  9396					      (gop == 0) ? 0x46 : 0x47;
  9397	
  9398					rt2800_bbp_write(rt2x00dev, 158, bbp);
  9399					rt2800_bbp_write(rt2x00dev, 159, idx1);
  9400	
  9401					p1 = rt2800_do_fft_accumulation(rt2x00dev, 0x14, 1);
  9402	
  9403					rt2x00_dbg(rt2x00dev,
  9404						   "p0=%x, p1=%x, pwer_final=%x, idx0=%x, idx1=%x, iq_err=%x, gop=%d, ibit=%x\n",
  9405						   p0, p1, pf, idx0, idx1, iq_err, gop, ibit);
  9406	
  9407					if (!(!first_search && pf <= p0 && pf < p1)) {
  9408						if (p0 < p1) {
  9409							pf = p0;
  9410							iq_err = idx0;
  9411						} else {
  9412							pf = p1;
  9413							iq_err = idx1;
  9414						}
  9415					}
  9416	
  9417					bbp = (ch_idx == 0) ? (gop == 0) ? 0x28 : 0x29 :
  9418							      (gop == 0) ? 0x46 : 0x47;
  9419	
  9420					rt2800_bbp_write(rt2x00dev, 158, bbp);
  9421					rt2800_bbp_write(rt2x00dev, 159, iq_err);
  9422	
  9423					if (gop == 0)
  9424						gerr = iq_err;
  9425					else
  9426						perr = iq_err;
  9427	
  9428					rt2x00_dbg(rt2x00dev, "IQCalibration pf=%8x (%2x, %2x) !\n",
  9429						   pf, gerr & 0x0F, perr & 0x3F);
  9430				}
  9431			}
  9432	
  9433			if (bidx > 0)
  9434				ibit = (ibit >> 1);
  9435		}
  9436		gerr = (gerr & 0x08) ? (gerr & 0x0F) - 0x10 : (gerr & 0x0F);
  9437		perr = (perr & 0x20) ? (perr & 0x3F) - 0x40 : (perr & 0x3F);
  9438	
> 9439		gerr = (gerr < -0x07) ? -0x07 : (gerr > 0x05) ? 0x05 : gerr;
  9440		gsta = gerr - 1;
  9441		gend = gerr + 2;
  9442	
  9443		perr = (perr < -0x1f) ? -0x1f : (perr > 0x1d) ? 0x1d : perr;
  9444		psta = perr - 1;
  9445		pend = perr + 2;
  9446	
  9447		for (gef = gsta; gef <= gend; gef = gef + 1)
  9448			for (pef = psta; pef <= pend; pef = pef + 1) {
  9449				bbp = (ch_idx == 0) ? 0x28 : 0x46;
  9450				rt2800_bbp_write(rt2x00dev, 158, bbp);
  9451				rt2800_bbp_write(rt2x00dev, 159, gef & 0x0F);
  9452	
  9453				bbp = (ch_idx == 0) ? 0x29 : 0x47;
  9454				rt2800_bbp_write(rt2x00dev, 158, bbp);
  9455				rt2800_bbp_write(rt2x00dev, 159, pef & 0x3F);
  9456	
  9457				p1 = rt2800_do_fft_accumulation(rt2x00dev, 0x14, 1);
  9458				if (gef == gsta && pef == psta) {
  9459					pf = p1;
  9460					gerr = gef;
  9461					perr = pef;
  9462				} else if (pf > p1) {
  9463					pf = p1;
  9464					gerr = gef;
  9465					perr = pef;
  9466				}
  9467				rt2x00_dbg(rt2x00dev, "Fine IQCalibration p1=%8x pf=%8x (%2x, %2x) !\n",
  9468					   p1, pf, gef & 0x0F, pef & 0x3F);
  9469			}
  9470	
  9471		ges[ch_idx] = gerr & 0x0F;
  9472		pes[ch_idx] = perr & 0x3F;
  9473	}
  9474	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
