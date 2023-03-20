Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0BF6C1137
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 12:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjCTLwr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 07:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCTLwq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 07:52:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21741EFEC
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 04:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679313164; x=1710849164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pY6RMccNGsHhbZXGtq3IwKsxdzht/Pg3LGEYE2HXpX8=;
  b=ndmqI9MFYJMss/G+/BrtijIvTSJqIK50F9P/+pT9DH6rjqDAGt7WE9lk
   rlAWzVNXfcOPiu8UNYbwHehAqmial7nEtKXUJPgviPxRj4uicxxH5ppfi
   crmMHlJhTy5q5kQEzp5IbZ7/+R3NWDlm1L6jkb8HIbFxLhxs+OHCht8i6
   PdaWPJwVq906uESJy4H0WjUJ7kUsbUb35tU6TNPvqRnmPEg8NvIG7M1xN
   k+AAlT9FYJJP1WXv0O3VmMcEyD+oiyRplmAq5OgyvOSss7ssJ5pZalVtE
   mx6cYt8nPjJvT6Wnvz4q36bJ7UCpgWMdR/n24nGwRRg/EEGYHRmkwsQna
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="338665526"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="338665526"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 04:52:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="770170296"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="770170296"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Mar 2023 04:52:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peE49-000B1N-1L;
        Mon, 20 Mar 2023 11:52:41 +0000
Date:   Mon, 20 Mar 2023 19:51:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] wifi: brcmfmac: Fix SDIO suspend/resume regression
Message-ID: <202303201958.knUoo50R-lkp@intel.com>
References: <20230320101345.105714-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320101345.105714-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Hans,

I love your patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.3-rc3 next-20230320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-de-Goede/wifi-brcmfmac-Fix-SDIO-suspend-resume-regression/20230320-181456
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20230320101345.105714-1-hdegoede%40redhat.com
patch subject: [PATCH] wifi: brcmfmac: Fix SDIO suspend/resume regression
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230320/202303201958.knUoo50R-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cc08330c25aed804a422164413a39e67bfc1c277
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hans-de-Goede/wifi-brcmfmac-Fix-SDIO-suspend-resume-regression/20230320-181456
        git checkout cc08330c25aed804a422164413a39e67bfc1c277
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/net/wireless/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303201958.knUoo50R-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c: In function 'brcmf_ops_sdio_probe':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c:1034:24: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
    1034 |         struct device *dev;
         |                        ^~~


vim +/dev +1034 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c

00e27eeb75bb91 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2015-05-27  1027  
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1028  static int brcmf_ops_sdio_probe(struct sdio_func *func,
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1029  				const struct sdio_device_id *id)
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1030  {
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1031  	int err;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1032  	struct brcmf_sdio_dev *sdiodev;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1033  	struct brcmf_bus *bus_if;
f0992ace680c7a drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Fu, Zhonghui     2015-05-11 @1034  	struct device *dev;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1035  
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1036  	brcmf_dbg(SDIO, "Enter\n");
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1037  	brcmf_dbg(SDIO, "Class=%x\n", func->class);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1038  	brcmf_dbg(SDIO, "sdio vendor ID: 0x%04x\n", func->vendor);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1039  	brcmf_dbg(SDIO, "sdio device ID: 0x%04x\n", func->device);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1040  	brcmf_dbg(SDIO, "Function#: %d\n", func->num);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1041  
f0992ace680c7a drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Fu, Zhonghui     2015-05-11  1042  	dev = &func->dev;
508422f3695bf6 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c Ian Molton       2017-12-19  1043  
508422f3695bf6 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c Ian Molton       2017-12-19  1044  	/* Set MMC_QUIRK_LENIENT_FN0 for this card */
508422f3695bf6 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c Ian Molton       2017-12-19  1045  	func->card->quirks |= MMC_QUIRK_LENIENT_FN0;
508422f3695bf6 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c Ian Molton       2017-12-19  1046  
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1047  	/* Consume func num 1 but dont do anything with it. */
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1048  	if (func->num == 1)
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1049  		return 0;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1050  
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1051  	/* Ignore anything but func 2 */
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1052  	if (func->num != 2)
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1053  		return -ENODEV;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1054  
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1055  	bus_if = kzalloc(sizeof(struct brcmf_bus), GFP_KERNEL);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1056  	if (!bus_if)
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1057  		return -ENOMEM;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1058  	sdiodev = kzalloc(sizeof(struct brcmf_sdio_dev), GFP_KERNEL);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1059  	if (!sdiodev) {
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1060  		kfree(bus_if);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1061  		return -ENOMEM;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1062  	}
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1063  
36c4e7e4aa0605 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1064  	/* store refs to functions used. mmc_card does
36c4e7e4aa0605 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1065  	 * not hold the F0 function pointer.
36c4e7e4aa0605 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1066  	 */
c9aa7a91de740c drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c Arend Van Spriel 2018-01-09  1067  	sdiodev->func1 = func->card->sdio_func[0];
c9aa7a91de740c drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c Arend Van Spriel 2018-01-09  1068  	sdiodev->func2 = func;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1069  
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1070  	sdiodev->bus_if = bus_if;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1071  	bus_if->bus_priv.sdio = sdiodev;
943258b6a3b1fe drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Hante Meuleman   2013-12-12  1072  	bus_if->proto_type = BRCMF_PROTO_BCDC;
da6d9c8ecd00e2 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c Arend van Spriel 2022-11-29  1073  	bus_if->fwvid = id->driver_data;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1074  	dev_set_drvdata(&func->dev, bus_if);
c9aa7a91de740c drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c Arend Van Spriel 2018-01-09  1075  	dev_set_drvdata(&sdiodev->func1->dev, bus_if);
c9aa7a91de740c drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c Arend Van Spriel 2018-01-09  1076  	sdiodev->dev = &sdiodev->func1->dev;
330b4e4be937bf drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Hante Meuleman   2014-10-28  1077  
cc08330c25aed8 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c Hans de Goede    2023-03-20  1078  	brcmf_sdiod_acpi_save_power_manageable(sdiodev);
a1ce7a0d6a4f1e drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2015-02-06  1079  	brcmf_sdiod_change_state(sdiodev, BRCMF_SDIOD_DOWN);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1080  
a39be27b49e309 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1081  	brcmf_dbg(SDIO, "F2 found, calling brcmf_sdiod_probe...\n");
a39be27b49e309 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1082  	err = brcmf_sdiod_probe(sdiodev);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1083  	if (err) {
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1084  		brcmf_err("F2 error, probe failed %d...\n", err);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1085  		goto fail;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1086  	}
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1087  
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1088  	brcmf_dbg(SDIO, "F2 init completed...\n");
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1089  	return 0;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1090  
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1091  fail:
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1092  	dev_set_drvdata(&func->dev, NULL);
c9aa7a91de740c drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c Arend Van Spriel 2018-01-09  1093  	dev_set_drvdata(&sdiodev->func1->dev, NULL);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1094  	kfree(sdiodev);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1095  	kfree(bus_if);
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1096  	return err;
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1097  }
e2dc9eea531ec9 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c          Arend van Spriel 2013-12-12  1098  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
