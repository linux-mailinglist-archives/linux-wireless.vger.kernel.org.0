Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56C567F7D4
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Jan 2023 13:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjA1Mpf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Jan 2023 07:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjA1Mpe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Jan 2023 07:45:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F347ED5
        for <linux-wireless@vger.kernel.org>; Sat, 28 Jan 2023 04:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674909932; x=1706445932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4B1iDhM0pqsAG1u6CYpdDazgo47245B8+/FsjpicWck=;
  b=UBreepoVl17hsbby+Z8ZuLJ0J8n4tj1Cr61Ijy2DnNDpvu2Q2K9PONBO
   lTGFUxIS0Vxjst5HRjEG7nI0fGLdiVEWVWn87GDgJeiZFso789OF0rFBU
   CVhYGWJw3xtQ8Df+/ogqcBUuaqp6pUb4zt1F1IBc8QKsJNHextBVWx2cD
   DrxpJJ/rqpFmh0jXtLpvyPhjOC4aqxtnaYPEVIGqRivdWUhWrJDdxZ5NY
   cpv1FqPn3QWtBU3Cmc6UoNTTw5GyVPeXw8Bao+G0O8Yxp/2Bs1yIBSro0
   LiMzYkSS2vyMI42R/u83rWoo93Y47JuieCmtwX18Yk70zymbgrqDI8Xl5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="354596358"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="354596358"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 04:45:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="641022225"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="641022225"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2023 04:45:29 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLkaG-0000eP-1a;
        Sat, 28 Jan 2023 12:45:28 +0000
Date:   Sat, 28 Jan 2023 20:44:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vinay Gannevaram <quic_vganneva@quicinc.com>,
        johannes@sipsolutions.net
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] nl80211: Allow authentication frames and set keys on
 NAN interface
Message-ID: <202301282020.R7v2wcBQ-lkp@intel.com>
References: <1674845256-4300-1-git-send-email-quic_vganneva@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674845256-4300-1-git-send-email-quic_vganneva@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Vinay,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vinay-Gannevaram/nl80211-Allow-authentication-frames-and-set-keys-on-NAN-interface/20230128-145815
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/1674845256-4300-1-git-send-email-quic_vganneva%40quicinc.com
patch subject: [PATCH v2] nl80211: Allow authentication frames and set keys on NAN interface
config: hexagon-randconfig-r041-20230123 (https://download.01.org/0day-ci/archive/20230128/202301282020.R7v2wcBQ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/954d2dd8f85ced417476083a99011b8920d68161
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vinay-Gannevaram/nl80211-Allow-authentication-frames-and-set-keys-on-NAN-interface/20230128-145815
        git checkout 954d2dd8f85ced417476083a99011b8920d68161
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/wireless/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/wireless/nl80211.c:16:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from net/wireless/nl80211.c:16:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from net/wireless/nl80211.c:16:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> net/wireless/nl80211.c:1555:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           case NL80211_IFTYPE_UNSPECIFIED:
           ^
   net/wireless/nl80211.c:1555:2: note: insert '__attribute__((fallthrough));' to silence this warning
           case NL80211_IFTYPE_UNSPECIFIED:
           ^
           __attribute__((fallthrough)); 
   net/wireless/nl80211.c:1555:2: note: insert 'break;' to avoid fall-through
           case NL80211_IFTYPE_UNSPECIFIED:
           ^
           break; 
   net/wireless/nl80211.c:12262:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   net/wireless/nl80211.c:12262:2: note: insert '__attribute__((fallthrough));' to silence this warning
           default:
           ^
           __attribute__((fallthrough)); 
   net/wireless/nl80211.c:12262:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   net/wireless/nl80211.c:12322:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   net/wireless/nl80211.c:12322:2: note: insert '__attribute__((fallthrough));' to silence this warning
           default:
           ^
           __attribute__((fallthrough)); 
   net/wireless/nl80211.c:12322:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   net/wireless/nl80211.c:12462:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   net/wireless/nl80211.c:12462:2: note: insert '__attribute__((fallthrough));' to silence this warning
           default:
           ^
           __attribute__((fallthrough)); 
   net/wireless/nl80211.c:12462:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   10 warnings generated.


vim +1555 net/wireless/nl80211.c

fffd0934b9390f Johannes Berg    2009-07-08  1531  
fffd0934b9390f Johannes Berg    2009-07-08  1532  static int nl80211_key_allowed(struct wireless_dev *wdev)
fffd0934b9390f Johannes Berg    2009-07-08  1533  {
fffd0934b9390f Johannes Berg    2009-07-08  1534  	ASSERT_WDEV_LOCK(wdev);
fffd0934b9390f Johannes Berg    2009-07-08  1535  
fffd0934b9390f Johannes Berg    2009-07-08  1536  	switch (wdev->iftype) {
fffd0934b9390f Johannes Berg    2009-07-08  1537  	case NL80211_IFTYPE_AP:
fffd0934b9390f Johannes Berg    2009-07-08  1538  	case NL80211_IFTYPE_AP_VLAN:
074ac8df9f93f2 Johannes Berg    2010-09-16  1539  	case NL80211_IFTYPE_P2P_GO:
ff973af74aa693 Thomas Pedersen  2011-05-03  1540  	case NL80211_IFTYPE_MESH_POINT:
fffd0934b9390f Johannes Berg    2009-07-08  1541  		break;
fffd0934b9390f Johannes Berg    2009-07-08  1542  	case NL80211_IFTYPE_ADHOC:
7b0a0e3c3a8826 Johannes Berg    2022-04-14  1543  		if (wdev->u.ibss.current_bss)
7b0a0e3c3a8826 Johannes Berg    2022-04-14  1544  			return 0;
7b0a0e3c3a8826 Johannes Berg    2022-04-14  1545  		return -ENOLINK;
fffd0934b9390f Johannes Berg    2009-07-08  1546  	case NL80211_IFTYPE_STATION:
074ac8df9f93f2 Johannes Berg    2010-09-16  1547  	case NL80211_IFTYPE_P2P_CLIENT:
7b0a0e3c3a8826 Johannes Berg    2022-04-14  1548  		if (wdev->connected)
7b0a0e3c3a8826 Johannes Berg    2022-04-14  1549  			return 0;
fffd0934b9390f Johannes Berg    2009-07-08  1550  		return -ENOLINK;
954d2dd8f85ced Vinay Gannevaram 2023-01-28  1551  	case NL80211_IFTYPE_NAN:
954d2dd8f85ced Vinay Gannevaram 2023-01-28  1552  		if (wiphy_ext_feature_isset(wdev->wiphy,
954d2dd8f85ced Vinay Gannevaram 2023-01-28  1553  					    NL80211_EXT_FEATURE_SECURE_NAN))
954d2dd8f85ced Vinay Gannevaram 2023-01-28  1554  			return 0;
de4fcbadde68e3 Johannes Berg    2014-10-31 @1555  	case NL80211_IFTYPE_UNSPECIFIED:
6e0bd6c35b021d Rostislav Lisovy 2014-11-03  1556  	case NL80211_IFTYPE_OCB:
de4fcbadde68e3 Johannes Berg    2014-10-31  1557  	case NL80211_IFTYPE_MONITOR:
de4fcbadde68e3 Johannes Berg    2014-10-31  1558  	case NL80211_IFTYPE_P2P_DEVICE:
de4fcbadde68e3 Johannes Berg    2014-10-31  1559  	case NL80211_IFTYPE_WDS:
de4fcbadde68e3 Johannes Berg    2014-10-31  1560  	case NUM_NL80211_IFTYPES:
fffd0934b9390f Johannes Berg    2009-07-08  1561  		return -EINVAL;
fffd0934b9390f Johannes Berg    2009-07-08  1562  	}
fffd0934b9390f Johannes Berg    2009-07-08  1563  
fffd0934b9390f Johannes Berg    2009-07-08  1564  	return 0;
fffd0934b9390f Johannes Berg    2009-07-08  1565  }
fffd0934b9390f Johannes Berg    2009-07-08  1566  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
