Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DEF48827C
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jan 2022 09:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiAHIlv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jan 2022 03:41:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:2683 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233820AbiAHIlr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jan 2022 03:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641631307; x=1673167307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=egy9t3JfjOLC7tOKyDwth+qSX+cwX9921WGNnK9m/mE=;
  b=F4Pjx/tpJtsEvL0s4sA+rx+g8r+uvvyR4Yo7k0K5gNIJphDreURcUmiS
   PRMgvePcIxWc7f5oE3/mYdQosU331DOZ2UfvVpWkpZML0g9qKTj+Itk6B
   5VXMOhR9YvsCI1CaTLxMVMMz+lmkXWDhKzCtB6f0/OIa+hSF7wk7deLnd
   r5awN6tcPJtSu0F/XFUBttVhTNVrlKLB/0nlzH3JjWJ5XJ3YiKKsZWTeA
   hTaACKiJTZmaNdai/XCbeCPqkFS2qqfmBvWac2js5+lYtdxzDoZrZfwiY
   enTUVUbEMUvMvlLyyTy1mEaOyWa7BnpJvS960OtMJ+VNwJq2kx/OIFdWP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="243196366"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="243196366"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 00:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="612410772"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jan 2022 00:41:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n67IG-0000QJ-GS; Sat, 08 Jan 2022 08:41:44 +0000
Date:   Sat, 8 Jan 2022 16:41:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: Re: [PATCH 3/4] wcn36xx: Track SNR and RSSI for each RX frame
Message-ID: <202201081611.NwbnsnbW-lkp@intel.com>
References: <20220107153323.1807905-4-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107153323.1807905-4-bryan.odonoghue@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bryan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on kvalo-wireless-drivers-next/master]
[also build test WARNING on kvalo-ath/ath-next next-20220107]
[cannot apply to kvalo-wireless-drivers/master v5.16-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Bryan-O-Donoghue/wcn36xx-Add-spectrum-survey-reporting/20220107-233226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
config: riscv-randconfig-r042-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081611.NwbnsnbW-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/7fa379bc4e1728cf4e30f1f9de93bea0f520e37b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Bryan-O-Donoghue/wcn36xx-Add-spectrum-survey-reporting/20220107-233226
        git checkout 7fa379bc4e1728cf4e30f1f9de93bea0f520e37b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/wireless/ath/wcn36xx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/wcn36xx/main.c:22:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/net/wireless/ath/wcn36xx/main.c:22:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/net/wireless/ath/wcn36xx/main.c:22:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> drivers/net/wireless/ath/wcn36xx/main.c:1600:3: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
                   ret -= ENOMEM;
                   ^~~
   drivers/net/wireless/ath/wcn36xx/main.c:1567:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   8 warnings generated.


vim +/ret +1600 drivers/net/wireless/ath/wcn36xx/main.c

  1561	
  1562	static int wcn36xx_probe(struct platform_device *pdev)
  1563	{
  1564		struct ieee80211_hw *hw;
  1565		struct wcn36xx *wcn;
  1566		void *wcnss;
  1567		int ret;
  1568		const u8 *addr;
  1569		int n_channels;
  1570	
  1571		wcn36xx_dbg(WCN36XX_DBG_MAC, "platform probe\n");
  1572	
  1573		wcnss = dev_get_drvdata(pdev->dev.parent);
  1574	
  1575		hw = ieee80211_alloc_hw(sizeof(struct wcn36xx), &wcn36xx_ops);
  1576		if (!hw) {
  1577			wcn36xx_err("failed to alloc hw\n");
  1578			ret = -ENOMEM;
  1579			goto out_err;
  1580		}
  1581		platform_set_drvdata(pdev, hw);
  1582		wcn = hw->priv;
  1583		wcn->hw = hw;
  1584		wcn->dev = &pdev->dev;
  1585		wcn->first_boot = true;
  1586		mutex_init(&wcn->conf_mutex);
  1587		mutex_init(&wcn->hal_mutex);
  1588		mutex_init(&wcn->scan_lock);
  1589		__skb_queue_head_init(&wcn->amsdu);
  1590	
  1591		wcn->hal_buf = devm_kmalloc(wcn->dev, WCN36XX_HAL_BUF_SIZE, GFP_KERNEL);
  1592		if (!wcn->hal_buf) {
  1593			ret = -ENOMEM;
  1594			goto out_wq;
  1595		}
  1596	
  1597		n_channels = wcn_band_2ghz.n_channels + wcn_band_5ghz.n_channels;
  1598		wcn->chan_survey = devm_kmalloc(wcn->dev, n_channels, GFP_KERNEL);
  1599		if (!wcn->chan_survey) {
> 1600			ret -= ENOMEM;
  1601			goto out_wq;
  1602		}
  1603	
  1604		ret = dma_set_mask_and_coherent(wcn->dev, DMA_BIT_MASK(32));
  1605		if (ret < 0) {
  1606			wcn36xx_err("failed to set DMA mask: %d\n", ret);
  1607			goto out_wq;
  1608		}
  1609	
  1610		wcn->nv_file = WLAN_NV_FILE;
  1611		ret = of_property_read_string(wcn->dev->parent->of_node, "firmware-name", &wcn->nv_file);
  1612		if (ret < 0 && ret != -EINVAL) {
  1613			wcn36xx_err("failed to read \"firmware-name\" property: %d\n", ret);
  1614			goto out_wq;
  1615		}
  1616	
  1617		wcn->smd_channel = qcom_wcnss_open_channel(wcnss, "WLAN_CTRL", wcn36xx_smd_rsp_process, hw);
  1618		if (IS_ERR(wcn->smd_channel)) {
  1619			wcn36xx_err("failed to open WLAN_CTRL channel\n");
  1620			ret = PTR_ERR(wcn->smd_channel);
  1621			goto out_wq;
  1622		}
  1623	
  1624		addr = of_get_property(pdev->dev.of_node, "local-mac-address", &ret);
  1625		if (addr && ret != ETH_ALEN) {
  1626			wcn36xx_err("invalid local-mac-address\n");
  1627			ret = -EINVAL;
  1628			goto out_destroy_ept;
  1629		} else if (addr) {
  1630			wcn36xx_info("mac address: %pM\n", addr);
  1631			SET_IEEE80211_PERM_ADDR(wcn->hw, addr);
  1632		}
  1633	
  1634		ret = wcn36xx_platform_get_resources(wcn, pdev);
  1635		if (ret)
  1636			goto out_destroy_ept;
  1637	
  1638		wcn36xx_init_ieee80211(wcn);
  1639		ret = ieee80211_register_hw(wcn->hw);
  1640		if (ret)
  1641			goto out_unmap;
  1642	
  1643		return 0;
  1644	
  1645	out_unmap:
  1646		iounmap(wcn->ccu_base);
  1647		iounmap(wcn->dxe_base);
  1648	out_destroy_ept:
  1649		rpmsg_destroy_ept(wcn->smd_channel);
  1650	out_wq:
  1651		ieee80211_free_hw(hw);
  1652	out_err:
  1653		return ret;
  1654	}
  1655	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
