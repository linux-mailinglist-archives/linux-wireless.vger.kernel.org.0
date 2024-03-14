Return-Path: <linux-wireless+bounces-4742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287E87BB25
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 11:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A648B22EE4
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 10:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44556D1A9;
	Thu, 14 Mar 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHD8xToY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3A6BFAC
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411636; cv=none; b=gcR2s4o1308vGoMFLzeJpba9GzrXMp2whhyuy/UATt7IIgGImRli8noBC9u6lqQNqroTsAq/0SFC6EyvgjjUUeUabqqG4WXDWYKZG16HaqgPbFQdKeVxPciAbxU3JuZIZq9R6ZM7yCxrTlcTtUHnu4N2NdeOiC1fM4ckzRBIXjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411636; c=relaxed/simple;
	bh=Q40t2apZMO7d2J09faoTKTeEJycl4UQXXRiMphUtsZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7B6Q4KZknYB/HyWyNJsevG8l8eNcX2ijmib9LMELM8xdkXCt2z7LNXyV/5soZj/l4fpJDqoOcusaMbw0bfx9LlN9cudJ5y3ddZLfQjNluOy/y0LamxXg6+/VhuuC1g0aVQLD3NbU6yLPz8KrgyreG8idEIdEx529eHDWIl3LrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHD8xToY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710411634; x=1741947634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q40t2apZMO7d2J09faoTKTeEJycl4UQXXRiMphUtsZA=;
  b=lHD8xToY4H0WGkoaInKuTEhGpJqf9vKd6VkSqfIIU3qRyNtvTk0GG+Ka
   QBG4sNstBoXzjaZIdeWgMphvS/H+pulh1gn6+RPVU93AlQtj/aYlGwjwf
   mP6cNhuHmvVJPqQpfDg8iv/1KBpkc9PVQjwbKRMvB0U9uKfXMkAepE7Le
   D2bK3ev7Ffu6CpWMBTEno8eelv2bHYsDMA0fNk7jLa8dHSW8Oxs3iGIjZ
   DpIr4tgkBGav853O8MeN1K0u7N61+a9LCHlZjNy4Vl6AkIBI1cfUsek/z
   P2sI3DGyeZZD9DUIa2e6wI73zcqysjpka9Uk4CJtzpcr+aQVdJfwERsa6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5343414"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5343414"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 03:20:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="12312950"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Mar 2024 03:18:24 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkiAH-000DKZ-2l;
	Thu, 14 Mar 2024 10:18:21 +0000
Date: Thu, 14 Mar 2024 18:17:35 +0800
From: kernel test robot <lkp@intel.com>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	ath12k@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Sriram R <quic_srirrama@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: Re: [PATCH v4 04/12] wifi: ath12k: vdev statemachine changes for
 single wiphy
Message-ID: <202403141850.4ccwnsut-lkp@intel.com>
References: <20240312135557.1778379-5-quic_ramess@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312135557.1778379-5-quic_ramess@quicinc.com>

Hi Rameshkumar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvalo-ath/ath-next]
[also build test WARNING on wireless/main wireless-next/main linus/master next-20240314]
[cannot apply to v6.8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rameshkumar-Sundaram/wifi-ath12k-add-multiple-radio-support-in-a-single-MAC-HW-un-register/20240312-215924
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
patch link:    https://lore.kernel.org/r/20240312135557.1778379-5-quic_ramess%40quicinc.com
patch subject: [PATCH v4 04/12] wifi: ath12k: vdev statemachine changes for single wiphy
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240314/202403141850.4ccwnsut-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 503c55e17037436dcd45ac69dea8967e67e3f5e8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240314/202403141850.4ccwnsut-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403141850.4ccwnsut-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/powerpc/include/asm/cacheflush.h:7:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/ath/ath12k/mac.c:7:
   In file included from include/net/mac80211.h:20:
   In file included from include/linux/ieee80211.h:20:
   In file included from include/linux/etherdevice.h:21:
   In file included from include/linux/netdevice.h:45:
   In file included from include/uapi/linux/neighbour.h:6:
   In file included from include/linux/netlink.h:9:
   In file included from include/net/scm.h:9:
   In file included from include/linux/security.h:35:
   include/linux/bpf.h:742:48: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     742 |         ARG_PTR_TO_MAP_VALUE_OR_NULL    = PTR_MAYBE_NULL | ARG_PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:743:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     743 |         ARG_PTR_TO_MEM_OR_NULL          = PTR_MAYBE_NULL | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:744:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     744 |         ARG_PTR_TO_CTX_OR_NULL          = PTR_MAYBE_NULL | ARG_PTR_TO_CTX,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:745:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     745 |         ARG_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:746:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     746 |         ARG_PTR_TO_STACK_OR_NULL        = PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~
   include/linux/bpf.h:747:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     747 |         ARG_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:751:38: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     751 |         ARG_PTR_TO_UNINIT_MEM           = MEM_UNINIT | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:753:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     753 |         ARG_PTR_TO_FIXED_SIZE_MEM       = MEM_FIXED_SIZE | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:776:48: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     776 |         RET_PTR_TO_MAP_VALUE_OR_NULL    = PTR_MAYBE_NULL | RET_PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:777:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     777 |         RET_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:778:47: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     778 |         RET_PTR_TO_TCP_SOCK_OR_NULL     = PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:779:50: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     779 |         RET_PTR_TO_SOCK_COMMON_OR_NULL  = PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:781:49: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     781 |         RET_PTR_TO_DYNPTR_MEM_OR_NULL   = PTR_MAYBE_NULL | RET_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:782:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     782 |         RET_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:783:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     783 |         RET_PTR_TO_BTF_ID_TRUSTED       = PTR_TRUSTED    | RET_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~    ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:894:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     894 |         PTR_TO_MAP_VALUE_OR_NULL        = PTR_MAYBE_NULL | PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~
   include/linux/bpf.h:895:42: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     895 |         PTR_TO_SOCKET_OR_NULL           = PTR_MAYBE_NULL | PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   include/linux/bpf.h:896:46: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     896 |         PTR_TO_SOCK_COMMON_OR_NULL      = PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:897:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     897 |         PTR_TO_TCP_SOCK_OR_NULL         = PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~
   include/linux/bpf.h:898:42: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     898 |         PTR_TO_BTF_ID_OR_NULL           = PTR_MAYBE_NULL | PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath12k/mac.c:6038:54: warning: variable 'bit' is uninitialized when used here [-Wuninitialized]
    6038 |                 ath12k_warn(ab, "failed to create vdev %d ret %d", bit, ret);
         |                                                                    ^~~
   drivers/net/wireless/ath/ath12k/mac.c:6001:8: note: initialize the variable 'bit' to silence this warning
    6001 |         u8 bit;
         |               ^
         |                = '\0'
   26 warnings generated.


vim +/bit +6038 drivers/net/wireless/ath/ath12k/mac.c

  5991	
  5992	static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
  5993							    struct ieee80211_vif *vif,
  5994							    struct ieee80211_chanctx_conf *ctx)
  5995	{
  5996		struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
  5997		struct ath12k_hw *ah = hw->priv;
  5998		struct ath12k_base *ab;
  5999		struct ath12k *ar;
  6000		int ret;
  6001		u8 bit;
  6002	
  6003		if (arvif->ar) {
  6004			WARN_ON(!arvif->is_created);
  6005			goto out;
  6006		}
  6007	
  6008		if (ah->num_radio == 1)
  6009			ar = ah->radio;
  6010		else if (ctx)
  6011			ar = ath12k_get_ar_by_ctx(hw, ctx);
  6012		else
  6013			return NULL;
  6014	
  6015		if (!ar)
  6016			goto out;
  6017	
  6018		ab = ar->ab;
  6019	
  6020		mutex_lock(&ar->conf_mutex);
  6021	
  6022		if (vif->type == NL80211_IFTYPE_AP &&
  6023		    ar->num_peers > (ar->max_num_peers - 1)) {
  6024			ath12k_warn(ab, "failed to create vdev due to insufficient peer entry resource in firmware\n");
  6025			ret = -ENOBUFS;
  6026			goto unlock;
  6027		}
  6028	
  6029		if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
  6030			ath12k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
  6031				    TARGET_NUM_VDEVS);
  6032			ret = -EBUSY;
  6033			goto unlock;
  6034		}
  6035	
  6036		ret = ath12k_mac_vdev_create(ar, vif);
  6037		if (ret) {
> 6038			ath12k_warn(ab, "failed to create vdev %d ret %d", bit, ret);
  6039			goto unlock;
  6040		}
  6041	
  6042		/* TODO If the vdev is created during channel assign and not during
  6043		 * add_interface(), Apply any parameters for the vdev which were received
  6044		 * after add_interface, corresponding to this vif.
  6045		 */
  6046	unlock:
  6047		mutex_unlock(&ar->conf_mutex);
  6048	out:
  6049		return arvif->ar;
  6050	}
  6051	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

