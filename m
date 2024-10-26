Return-Path: <linux-wireless+bounces-14569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33189B141C
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 03:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A843A28215E
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 01:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864F3217F33;
	Sat, 26 Oct 2024 01:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EF2jWBqz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA015661
	for <linux-wireless@vger.kernel.org>; Sat, 26 Oct 2024 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729907806; cv=none; b=kfGzVECP4P4zn92GVYMFnQZ8hJsY2dxA5x6Tu7/Y2gRtS4N9p9rCcBGnVSu5qHCiS0ci6cQKvPWGyeQgJWyAD9m8pYLo89H3x2WKXVkCbo+t0wEA5XfmPzWwb3P9QBsSFJeNvU6Dz6QBuO/yfmFh43W9NoA/duaFzE7OmuWS37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729907806; c=relaxed/simple;
	bh=Y84AS8AQPcjc3nRCoqcv1YhOeVsRduR6WIAYEw1f7wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyKFiRgxunGMcjMml2i/L+XsQpZ56SRtznkqjgb4pKDTo8VN7GdtRPqMt5w9ZjCNu7mBfS3Z7jX0LiHtTkevUkvvpXIBh5oyIHXIdI0AQSJWLs9q0wVXbtnhswGTQvPclCntbot7SGA+dlSj3iCq7NO/W1uXCVDhsZI2xgDlmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EF2jWBqz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729907804; x=1761443804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y84AS8AQPcjc3nRCoqcv1YhOeVsRduR6WIAYEw1f7wk=;
  b=EF2jWBqzXr1PITmq9cr5MyJej/5agYuYeARf/zNewdWBfdc0E4mQgt7m
   hIpZvC7+cjN617XIJ5+18HVYpspclRCMpqkQmHU81lFLqV5uK0vGaOcBg
   Xswn0muDcce7qwuM4X2a2D6O3MEOe+O0ki2x3mDaNcvTF9YjpnyuVd0mG
   34EK9DO/DbrevF8DH7vMghGPg3vZ1M74IDY6p4jgJj/wm5ARbTJeNdegB
   +KmLjUvsIH7iL8TdxQIZbSnPceJV8hEH5X+SSzKWQbVtGHnjfwOyiIBVP
   3UW4k3ryzAdhGzZU3CWH65TXZ6540qapE9quPrwFLTa6HpbLK3zXmHM2I
   Q==;
X-CSE-ConnectionGUID: kJl3JG6GTBqqv8WTIBHI6w==
X-CSE-MsgGUID: DUe+3O/RTWy8eEQVI/3fnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29452092"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29452092"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 18:56:44 -0700
X-CSE-ConnectionGUID: 5Ee8TF74Q+6Vb0+x0fQzpg==
X-CSE-MsgGUID: t2Xvn7inQ42u9nzs8xb8Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85050158"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Oct 2024 18:56:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4W2h-000Z9T-1u;
	Sat, 26 Oct 2024 01:56:39 +0000
Date: Sat, 26 Oct 2024 09:55:53 +0800
From: kernel test robot <lkp@intel.com>
To: Muna Sinada <quic_msinada@quicinc.com>, johannes@sipsolutions.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Muna Sinada <quic_msinada@quicinc.com>
Subject: Re: [PATCH v2 1/2] wifi: nl80211: add link id of transmitted profile
 for MLO MBSSID
Message-ID: <202410260903.OviN4GZO-lkp@intel.com>
References: <20241025013857.2793346-2-quic_msinada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025013857.2793346-2-quic_msinada@quicinc.com>

Hi Muna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main ath/ath-next linus/master v6.12-rc4 next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muna-Sinada/wifi-nl80211-add-link-id-of-transmitted-profile-for-MLO-MBSSID/20241025-094154
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20241025013857.2793346-2-quic_msinada%40quicinc.com
patch subject: [PATCH v2 1/2] wifi: nl80211: add link id of transmitted profile for MLO MBSSID
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241026/202410260903.OviN4GZO-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260903.OviN4GZO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260903.OviN4GZO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/wireless/nl80211.c:16:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> net/wireless/nl80211.c:5588:13: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    5588 |         } else if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]) {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/wireless/nl80211.c:5599:9: note: uninitialized use occurs here
    5599 |         return err;
         |                ^~~
   net/wireless/nl80211.c:5588:9: note: remove the 'if' if its condition is always false
    5588 |         } else if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]) {
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    5589 |                 goto out;
         |                 ~~~~~~~~~
    5590 |         }
         |         ~
   net/wireless/nl80211.c:5579:7: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    5579 |                 if (!tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/wireless/nl80211.c:5599:9: note: uninitialized use occurs here
    5599 |         return err;
         |                ^~~
   net/wireless/nl80211.c:5579:3: note: remove the 'if' if its condition is always false
    5579 |                 if (!tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    5580 |                         goto out;
         |                         ~~~~~~~~
   net/wireless/nl80211.c:5527:9: note: initialize the variable 'err' to silence this warning
    5527 |         int err;
         |                ^
         |                 = 0
   6 warnings generated.


vim +5588 net/wireless/nl80211.c

  5519	
  5520	static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
  5521					       struct net_device *dev,
  5522					       struct nlattr *attrs,
  5523					       struct cfg80211_mbssid_config *config,
  5524					       u8 num_elems)
  5525	{
  5526		struct nlattr *tb[NL80211_MBSSID_CONFIG_ATTR_MAX + 1];
  5527		int err;
  5528	
  5529		if (!wiphy->mbssid_max_interfaces)
  5530			return -EOPNOTSUPP;
  5531	
  5532		if (nla_parse_nested(tb, NL80211_MBSSID_CONFIG_ATTR_MAX, attrs, NULL,
  5533				     NULL) ||
  5534		    !tb[NL80211_MBSSID_CONFIG_ATTR_INDEX])
  5535			return -EINVAL;
  5536	
  5537		config->ema = nla_get_flag(tb[NL80211_MBSSID_CONFIG_ATTR_EMA]);
  5538		if (config->ema) {
  5539			if (!wiphy->ema_max_profile_periodicity)
  5540				return -EOPNOTSUPP;
  5541	
  5542			if (num_elems > wiphy->ema_max_profile_periodicity)
  5543				return -EINVAL;
  5544		}
  5545	
  5546		config->index = nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_INDEX]);
  5547		if (config->index >= wiphy->mbssid_max_interfaces ||
  5548		    (!config->index && !num_elems))
  5549			return -EINVAL;
  5550	
  5551		if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX]) {
  5552			u32 tx_ifindex =
  5553				nla_get_u32(tb[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX]);
  5554	
  5555			if ((!config->index && tx_ifindex != dev->ifindex) ||
  5556			    (config->index && tx_ifindex == dev->ifindex))
  5557				return -EINVAL;
  5558	
  5559			if (tx_ifindex != dev->ifindex) {
  5560				config->tx_wdev =
  5561				 dev_get_by_index(wiphy_net(wiphy), tx_ifindex)->ieee80211_ptr;
  5562				if (!config->tx_wdev ||
  5563				    config->tx_wdev->wiphy != wiphy ||
  5564				    config->tx_wdev->iftype != NL80211_IFTYPE_AP) {
  5565					err = -EINVAL;
  5566					goto out;
  5567				}
  5568			} else {
  5569				config->tx_wdev = dev->ieee80211_ptr;
  5570			}
  5571		} else if (!config->index) {
  5572			config->tx_wdev = dev->ieee80211_ptr;
  5573		} else {
  5574			return -EINVAL;
  5575		}
  5576	
  5577		config->tx_link_id = 0;
  5578		if (config->tx_wdev->valid_links) {
  5579			if (!tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
  5580				goto out;
  5581	
  5582			config->tx_link_id =
  5583				  nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]);
  5584			if (!(config->tx_wdev->valid_links & BIT(config->tx_link_id))) {
  5585				err = -ENOLINK;
  5586				goto out;
  5587			}
> 5588		} else if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]) {
  5589			goto out;
  5590		}
  5591	
  5592		return 0;
  5593	
  5594	out:
  5595		if (config->tx_wdev && config->tx_wdev->netdev &&
  5596		    config->tx_wdev->netdev != dev)
  5597			dev_put(config->tx_wdev->netdev);
  5598	
  5599		return err;
  5600	}
  5601	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

