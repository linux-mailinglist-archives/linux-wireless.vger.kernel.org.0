Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430B4720E00
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jun 2023 07:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjFCF4Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Jun 2023 01:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFCF4Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Jun 2023 01:56:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F131DE55
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 22:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685771782; x=1717307782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OH9x1fFzy1O6DdldqBpam4C5AuoGAgCEPJBE4lDD5ik=;
  b=X7x48zRIuE/qor8sJEc1EbCr3XZmEH+Iwd2jpnLI4NyDqDIW4zLeNxZB
   xdb3C/YxCg6z6bvOp/cRfSZq4hQjLs8AUYYNSBK+Q1Sm+Wnork1SZoWsZ
   Nu3bbWkVghcSIZ0J07k9wO+ASH63N41VFv+v/4yc4faiaF/awI1QgK7Ce
   USdhFP0Ne12a5RqJuzyFg7+1irFZHKPjSdGTxThUXRp5rGCMD5mxUXuNV
   0UFeFJjvOFgXmKDI0r3gAKbmntQS57UyFfb8EnqywCMoPCT9NxtXrtDQ1
   JUXIRaGjPBekLcSGjvB67Eh3olupabdtJZJdMEKJ15R+lscnZXKDZIj/z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="356051383"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="356051383"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 22:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="777929534"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="777929534"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jun 2023 22:56:21 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5KFQ-0001M3-1x;
        Sat, 03 Jun 2023 05:56:20 +0000
Date:   Sat, 3 Jun 2023 13:55:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kevin Lund <kglund@google.com>, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Kevin Lund <kglund@google.com>
Subject: Re: [PATCH 1/2] wifi: cfg80211: Reject (re-)association to the same
 BSSID
Message-ID: <202306031354.S6fuhpkH-lkp@intel.com>
References: <20230602225751.164525-1-kglund@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602225751.164525-1-kglund@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kevin,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.4-rc4 next-20230602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kevin-Lund/wifi-mwifiex-Stop-rejecting-connection-attempts-while-connected/20230603-065907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20230602225751.164525-1-kglund%40google.com
patch subject: [PATCH 1/2] wifi: cfg80211: Reject (re-)association to the same BSSID
config: mips-ath79_defconfig (https://download.01.org/0day-ci/archive/20230603/202306031354.S6fuhpkH-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/09f9fe87fe3588d03dafcaf05b36b3e931f8c8eb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kevin-Lund/wifi-mwifiex-Stop-rejecting-connection-attempts-while-connected/20230603-065907
        git checkout 09f9fe87fe3588d03dafcaf05b36b3e931f8c8eb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash net/wireless/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306031354.S6fuhpkH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/wireless/sme.c:1454:30: error: no member named 'current_bss' in 'struct wireless_dev'
                   if (ether_addr_equal(wdev->current_bss->pub.bssid,
                                        ~~~~  ^
   1 error generated.


vim +1454 net/wireless/sme.c

  1418	
  1419	/*
  1420	 * API calls for nl80211/wext compatibility code
  1421	 */
  1422	int cfg80211_connect(struct cfg80211_registered_device *rdev,
  1423			     struct net_device *dev,
  1424			     struct cfg80211_connect_params *connect,
  1425			     struct cfg80211_cached_keys *connkeys,
  1426			     const u8 *prev_bssid)
  1427	{
  1428		struct wireless_dev *wdev = dev->ieee80211_ptr;
  1429		int err;
  1430	
  1431		ASSERT_WDEV_LOCK(wdev);
  1432	
  1433		/*
  1434		 * If we have an ssid_len, we're trying to connect or are
  1435		 * already connected, so reject a new SSID unless it's the
  1436		 * same (which is the case for re-association.)
  1437		 */
  1438		if (wdev->u.client.ssid_len &&
  1439		    (wdev->u.client.ssid_len != connect->ssid_len ||
  1440		     memcmp(wdev->u.client.ssid, connect->ssid, wdev->u.client.ssid_len)))
  1441			return -EALREADY;
  1442	
  1443		/*
  1444		 * If connected, reject (re-)association unless prev_bssid
  1445		 * matches the current BSSID. Also reject if the current BSSID matches
  1446		 * the desired BSSID.
  1447		 */
  1448		if (wdev->connected) {
  1449			if (!prev_bssid)
  1450				return -EALREADY;
  1451			if (!ether_addr_equal(prev_bssid,
  1452					      wdev->u.client.connected_addr))
  1453				return -ENOTCONN;
> 1454			if (ether_addr_equal(wdev->current_bss->pub.bssid,
  1455					     connect->bssid))
  1456				return -EALREADY;
  1457		}
  1458	
  1459		/*
  1460		 * Reject if we're in the process of connecting with WEP,
  1461		 * this case isn't very interesting and trying to handle
  1462		 * it would make the code much more complex.
  1463		 */
  1464		if (wdev->connect_keys)
  1465			return -EINPROGRESS;
  1466	
  1467		cfg80211_oper_and_ht_capa(&connect->ht_capa_mask,
  1468					  rdev->wiphy.ht_capa_mod_mask);
  1469		cfg80211_oper_and_vht_capa(&connect->vht_capa_mask,
  1470					   rdev->wiphy.vht_capa_mod_mask);
  1471	
  1472		if (connkeys && connkeys->def >= 0) {
  1473			int idx;
  1474			u32 cipher;
  1475	
  1476			idx = connkeys->def;
  1477			cipher = connkeys->params[idx].cipher;
  1478			/* If given a WEP key we may need it for shared key auth */
  1479			if (cipher == WLAN_CIPHER_SUITE_WEP40 ||
  1480			    cipher == WLAN_CIPHER_SUITE_WEP104) {
  1481				connect->key_idx = idx;
  1482				connect->key = connkeys->params[idx].key;
  1483				connect->key_len = connkeys->params[idx].key_len;
  1484	
  1485				/*
  1486				 * If ciphers are not set (e.g. when going through
  1487				 * iwconfig), we have to set them appropriately here.
  1488				 */
  1489				if (connect->crypto.cipher_group == 0)
  1490					connect->crypto.cipher_group = cipher;
  1491	
  1492				if (connect->crypto.n_ciphers_pairwise == 0) {
  1493					connect->crypto.n_ciphers_pairwise = 1;
  1494					connect->crypto.ciphers_pairwise[0] = cipher;
  1495				}
  1496			}
  1497		} else {
  1498			if (WARN_ON(connkeys))
  1499				return -EINVAL;
  1500	
  1501			/* connect can point to wdev->wext.connect which
  1502			 * can hold key data from a previous connection
  1503			 */
  1504			connect->key = NULL;
  1505			connect->key_len = 0;
  1506			connect->key_idx = 0;
  1507		}
  1508	
  1509		wdev->connect_keys = connkeys;
  1510		memcpy(wdev->u.client.ssid, connect->ssid, connect->ssid_len);
  1511		wdev->u.client.ssid_len = connect->ssid_len;
  1512	
  1513		wdev->conn_bss_type = connect->pbss ? IEEE80211_BSS_TYPE_PBSS :
  1514						      IEEE80211_BSS_TYPE_ESS;
  1515	
  1516		if (!rdev->ops->connect)
  1517			err = cfg80211_sme_connect(wdev, connect, prev_bssid);
  1518		else
  1519			err = rdev_connect(rdev, dev, connect);
  1520	
  1521		if (err) {
  1522			wdev->connect_keys = NULL;
  1523			/*
  1524			 * This could be reassoc getting refused, don't clear
  1525			 * ssid_len in that case.
  1526			 */
  1527			if (!wdev->connected)
  1528				wdev->u.client.ssid_len = 0;
  1529			return err;
  1530		}
  1531	
  1532		return 0;
  1533	}
  1534	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
