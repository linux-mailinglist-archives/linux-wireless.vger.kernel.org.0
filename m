Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A81480D88
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Dec 2021 22:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhL1Vib (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Dec 2021 16:38:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:50345 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhL1Via (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Dec 2021 16:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640727510; x=1672263510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4ZHG+KKSOy2A0WoCy7Or5EzGsyfnazzGkpfmQYr1ixs=;
  b=FnDyTSdc1Q5aLAP+ZlopAWqODy2/X/7d8rW01YjQ3ALY95OAp51aRqoF
   9wAJxrvPAgnPms2+xxbXvHOlXhqQwTqsOZvufVsjQcBFdZlom7W/RBeE1
   63nIe3XfGlqRidrpXTcmYJyMWfiQH7j9pFcPXICn5HyuAfNwlIR2YiRu0
   o70jOWbV3wiToC3eTuR2U3ernkiTJLUuVcL/iuZhyKJHtmJlNjXYo2HRf
   Rg6x3tzdPTzBVl7SJQFIKwHfqvKFKKq9RfOP3N4Ldi0xBHdNT5k8Eh3IM
   FNGi3t27+JQAM/sKSRne/lHbfFxs3FPmTcp9ZGeokLhKq+ARYEQvuFa5o
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="228255073"
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="228255073"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 13:38:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="468235367"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2021 13:38:27 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2KAs-00084O-Cf; Tue, 28 Dec 2021 21:38:26 +0000
Date:   Wed, 29 Dec 2021 05:37:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>, ast@kernel.org,
        daniel@iogearbox.net
Cc:     kbuild-all@lists.01.org, andrew@lunn.ch, mustafa.ismail@intel.com,
        linux-wireless@vger.kernel.org, jiri@nvidia.com,
        pablo@netfilter.org, andrii@kernel.org,
        george.mccollister@gmail.com, ralf@linux-mips.org
Subject: Re: [Intel-wired-lan] [PATCH bpf-next] net: don't include filter.h
 from net/sock.h
Message-ID: <202112290510.oNkRIfJG-lkp@intel.com>
References: <20211228192519.386913-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211228192519.386913-1-kuba@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jakub,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Jakub-Kicinski/net-don-t-include-filter-h-from-net-sock-h/20211229-032712
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: ia64-randconfig-r024-20211228 (https://download.01.org/0day-ci/archive/20211229/202112290510.oNkRIfJG-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/655ad46a9ed1d3185292e9e8e545887d781d06d7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jakub-Kicinski/net-don-t-include-filter-h-from-net-sock-h/20211229-032712
        git checkout 655ad46a9ed1d3185292e9e8e545887d781d06d7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/bonding/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/bonding/bond_main.c: In function 'bond_enslave':
>> drivers/net/bonding/bond_main.c:2195:25: error: implicit declaration of function 'bpf_prog_inc' [-Werror=implicit-function-declaration]
    2195 |                         bpf_prog_inc(bond->xdp_prog);
         |                         ^~~~~~~~~~~~
   In file included from include/linux/module.h:23,
                    from drivers/net/bonding/bond_main.c:35:
   drivers/net/bonding/bond_main.c: In function 'bond_xdp_set':
>> drivers/net/bonding/bond_main.c:5249:36: error: 'bpf_master_redirect_enabled_key' undeclared (first use in this function)
    5249 |                 static_branch_inc(&bpf_master_redirect_enabled_key);
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jump_label.h:520:63: note: in definition of macro 'static_branch_inc'
     520 | #define static_branch_inc(x)            static_key_slow_inc(&(x)->key)
         |                                                               ^
   drivers/net/bonding/bond_main.c:5249:36: note: each undeclared identifier is reported only once for each function it appears in
    5249 |                 static_branch_inc(&bpf_master_redirect_enabled_key);
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jump_label.h:520:63: note: in definition of macro 'static_branch_inc'
     520 | #define static_branch_inc(x)            static_key_slow_inc(&(x)->key)
         |                                                               ^
>> drivers/net/bonding/bond_main.c:5251:17: error: implicit declaration of function 'bpf_prog_put' [-Werror=implicit-function-declaration]
    5251 |                 bpf_prog_put(old_prog);
         |                 ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/bpf_prog_inc +2195 drivers/net/bonding/bond_main.c

8a8efa22f51b3c Amerigo Wang                2011-02-17  2092  
fbe168ba91f7c3 Michal Kubeček              2014-11-13  2093  	if (!(bond_dev->features & NETIF_F_LRO))
fbe168ba91f7c3 Michal Kubeček              2014-11-13  2094  		dev_disable_lro(slave_dev);
fbe168ba91f7c3 Michal Kubeček              2014-11-13  2095  
35d48903e97819 Jiri Pirko                  2011-03-22  2096  	res = netdev_rx_handler_register(slave_dev, bond_handle_frame,
35d48903e97819 Jiri Pirko                  2011-03-22  2097  					 new_slave);
35d48903e97819 Jiri Pirko                  2011-03-22  2098  	if (res) {
e2a7420df2e013 Jarod Wilson                2019-06-07  2099  		slave_dbg(bond_dev, slave_dev, "Error %d calling netdev_rx_handler_register\n", res);
5831d66e8097ae Veaceslav Falico            2013-09-25  2100  		goto err_detach;
35d48903e97819 Jiri Pirko                  2011-03-22  2101  	}
35d48903e97819 Jiri Pirko                  2011-03-22  2102  
42ab19ee902929 David Ahern                 2017-10-04  2103  	res = bond_master_upper_dev_link(bond, new_slave, extack);
1f718f0f4f9714 Veaceslav Falico            2013-09-25  2104  	if (res) {
e2a7420df2e013 Jarod Wilson                2019-06-07  2105  		slave_dbg(bond_dev, slave_dev, "Error %d calling bond_master_upper_dev_link\n", res);
1f718f0f4f9714 Veaceslav Falico            2013-09-25  2106  		goto err_unregister;
1f718f0f4f9714 Veaceslav Falico            2013-09-25  2107  	}
1f718f0f4f9714 Veaceslav Falico            2013-09-25  2108  
32d4c5647aad13 Tobias Waldekranz           2021-01-13  2109  	bond_lower_state_changed(new_slave);
32d4c5647aad13 Tobias Waldekranz           2021-01-13  2110  
07699f9a7c8d10 sfeldma@cumulusnetworks.com 2014-01-16  2111  	res = bond_sysfs_slave_add(new_slave);
07699f9a7c8d10 sfeldma@cumulusnetworks.com 2014-01-16  2112  	if (res) {
e2a7420df2e013 Jarod Wilson                2019-06-07  2113  		slave_dbg(bond_dev, slave_dev, "Error %d calling bond_sysfs_slave_add\n", res);
07699f9a7c8d10 sfeldma@cumulusnetworks.com 2014-01-16  2114  		goto err_upper_unlink;
07699f9a7c8d10 sfeldma@cumulusnetworks.com 2014-01-16  2115  	}
07699f9a7c8d10 sfeldma@cumulusnetworks.com 2014-01-16  2116  
ae42cc62a9f07f Xin Long                    2018-03-26  2117  	/* If the mode uses primary, then the following is handled by
ae42cc62a9f07f Xin Long                    2018-03-26  2118  	 * bond_change_active_slave().
ae42cc62a9f07f Xin Long                    2018-03-26  2119  	 */
ae42cc62a9f07f Xin Long                    2018-03-26  2120  	if (!bond_uses_primary(bond)) {
ae42cc62a9f07f Xin Long                    2018-03-26  2121  		/* set promiscuity level to new slave */
ae42cc62a9f07f Xin Long                    2018-03-26  2122  		if (bond_dev->flags & IFF_PROMISC) {
ae42cc62a9f07f Xin Long                    2018-03-26  2123  			res = dev_set_promiscuity(slave_dev, 1);
ae42cc62a9f07f Xin Long                    2018-03-26  2124  			if (res)
ae42cc62a9f07f Xin Long                    2018-03-26  2125  				goto err_sysfs_del;
ae42cc62a9f07f Xin Long                    2018-03-26  2126  		}
ae42cc62a9f07f Xin Long                    2018-03-26  2127  
ae42cc62a9f07f Xin Long                    2018-03-26  2128  		/* set allmulti level to new slave */
ae42cc62a9f07f Xin Long                    2018-03-26  2129  		if (bond_dev->flags & IFF_ALLMULTI) {
ae42cc62a9f07f Xin Long                    2018-03-26  2130  			res = dev_set_allmulti(slave_dev, 1);
9f5a90c107741b Xin Long                    2018-03-26  2131  			if (res) {
9f5a90c107741b Xin Long                    2018-03-26  2132  				if (bond_dev->flags & IFF_PROMISC)
9f5a90c107741b Xin Long                    2018-03-26  2133  					dev_set_promiscuity(slave_dev, -1);
ae42cc62a9f07f Xin Long                    2018-03-26  2134  				goto err_sysfs_del;
ae42cc62a9f07f Xin Long                    2018-03-26  2135  			}
9f5a90c107741b Xin Long                    2018-03-26  2136  		}
ae42cc62a9f07f Xin Long                    2018-03-26  2137  
ae42cc62a9f07f Xin Long                    2018-03-26  2138  		netif_addr_lock_bh(bond_dev);
ae42cc62a9f07f Xin Long                    2018-03-26  2139  		dev_mc_sync_multiple(slave_dev, bond_dev);
ae42cc62a9f07f Xin Long                    2018-03-26  2140  		dev_uc_sync_multiple(slave_dev, bond_dev);
ae42cc62a9f07f Xin Long                    2018-03-26  2141  		netif_addr_unlock_bh(bond_dev);
ae42cc62a9f07f Xin Long                    2018-03-26  2142  
ae42cc62a9f07f Xin Long                    2018-03-26  2143  		if (BOND_MODE(bond) == BOND_MODE_8023AD) {
ae42cc62a9f07f Xin Long                    2018-03-26  2144  			/* add lacpdu mc addr to mc list */
ae42cc62a9f07f Xin Long                    2018-03-26  2145  			u8 lacpdu_multicast[ETH_ALEN] = MULTICAST_LACPDU_ADDR;
ae42cc62a9f07f Xin Long                    2018-03-26  2146  
ae42cc62a9f07f Xin Long                    2018-03-26  2147  			dev_mc_add(slave_dev, lacpdu_multicast);
ae42cc62a9f07f Xin Long                    2018-03-26  2148  		}
ae42cc62a9f07f Xin Long                    2018-03-26  2149  	}
ae42cc62a9f07f Xin Long                    2018-03-26  2150  
5378c2e6ea236d Veaceslav Falico            2013-10-21  2151  	bond->slave_cnt++;
5378c2e6ea236d Veaceslav Falico            2013-10-21  2152  	bond_compute_features(bond);
5378c2e6ea236d Veaceslav Falico            2013-10-21  2153  	bond_set_carrier(bond);
5378c2e6ea236d Veaceslav Falico            2013-10-21  2154  
ec0865a94991d1 Veaceslav Falico            2014-05-15  2155  	if (bond_uses_primary(bond)) {
f80889a5b79cae dingtianhong                2014-02-12  2156  		block_netpoll_tx();
5378c2e6ea236d Veaceslav Falico            2013-10-21  2157  		bond_select_active_slave(bond);
f80889a5b79cae dingtianhong                2014-02-12  2158  		unblock_netpoll_tx();
5378c2e6ea236d Veaceslav Falico            2013-10-21  2159  	}
1f718f0f4f9714 Veaceslav Falico            2013-09-25  2160  
e79c1055749e31 Debabrata Banerjee          2018-05-14  2161  	if (bond_mode_can_use_xmit_hash(bond))
ee6377147409a0 Mahesh Bandewar             2014-10-04  2162  		bond_update_slave_arr(bond, NULL);
ee6377147409a0 Mahesh Bandewar             2014-10-04  2163  
21706ee8a47d3e Debabrata Banerjee          2018-05-09  2164  
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2165  	if (!slave_dev->netdev_ops->ndo_bpf ||
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2166  	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2167  		if (bond->xdp_prog) {
6569fa2d4e0147 Jonathan Toppins            2021-08-10  2168  			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
6569fa2d4e0147 Jonathan Toppins            2021-08-10  2169  				     "Slave does not support XDP");
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2170  			res = -EOPNOTSUPP;
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2171  			goto err_sysfs_del;
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2172  		}
6d5f1ef838683e Jussi Maki                  2021-09-06  2173  	} else if (bond->xdp_prog) {
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2174  		struct netdev_bpf xdp = {
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2175  			.command = XDP_SETUP_PROG,
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2176  			.flags   = 0,
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2177  			.prog    = bond->xdp_prog,
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2178  			.extack  = extack,
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2179  		};
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2180  
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2181  		if (dev_xdp_prog_count(slave_dev) > 0) {
6569fa2d4e0147 Jonathan Toppins            2021-08-10  2182  			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2183  				     "Slave has XDP program loaded, please unload before enslaving");
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2184  			res = -EOPNOTSUPP;
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2185  			goto err_sysfs_del;
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2186  		}
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2187  
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2188  		res = slave_dev->netdev_ops->ndo_bpf(slave_dev, &xdp);
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2189  		if (res < 0) {
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2190  			/* ndo_bpf() sets extack error message */
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2191  			slave_dbg(bond_dev, slave_dev, "Error %d calling ndo_bpf\n", res);
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2192  			goto err_sysfs_del;
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2193  		}
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2194  		if (bond->xdp_prog)
9e2ee5c7e7c35d Jussi Maki                  2021-07-31 @2195  			bpf_prog_inc(bond->xdp_prog);
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2196  	}
9e2ee5c7e7c35d Jussi Maki                  2021-07-31  2197  
e2a7420df2e013 Jarod Wilson                2019-06-07  2198  	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
90194264ceffdf Joe Perches                 2014-02-15  2199  		   bond_is_active_slave(new_slave) ? "an active" : "a backup",
90194264ceffdf Joe Perches                 2014-02-15  2200  		   new_slave->link != BOND_LINK_DOWN ? "an up" : "a down");
^1da177e4c3f41 Linus Torvalds              2005-04-16  2201  
^1da177e4c3f41 Linus Torvalds              2005-04-16  2202  	/* enslave is successful */
69e6113343cfe9 Moni Shoua                  2015-02-03  2203  	bond_queue_slave_event(new_slave);
^1da177e4c3f41 Linus Torvalds              2005-04-16  2204  	return 0;
^1da177e4c3f41 Linus Torvalds              2005-04-16  2205  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
