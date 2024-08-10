Return-Path: <linux-wireless+bounces-11264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C31594DE8C
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 22:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23D61F21877
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 20:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C913D619;
	Sat, 10 Aug 2024 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndvahX+R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0043D969;
	Sat, 10 Aug 2024 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723321619; cv=none; b=D4eapsw+SMg8AUf9PnphmMRh6x8FCPQZFQYBWOZYOScEj1ddJmFSlrp6GSteqJmcDmJbjRjdrS/0+BCfFm6G4mYfTREXsWNwciLhfAA0sNie6ALYH/tk0oHNlltVJl+1/5U6Dk/aX6710JuOOCXulf5K75t3y9m9gWjLAUUF6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723321619; c=relaxed/simple;
	bh=PvcelU/bNYejzU1CBAvFCW412MVtwEgLhYcwggEXHh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJaUVx6UZdZiPggQiPK4iWjDp2SfksS54nr7JjxciwP7IuJpLA9TgsFMqVpXLHlvrvaqrb/bkmMCcRCiTl6hrI8O+1EsMR3Qq+e6laLJirb9nqMCJBkbg0ms8MQWJFEvpR4jIfcac6LOx2BCiC71aXu1zF+a+4G5qfAtA1fTYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndvahX+R; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723321618; x=1754857618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PvcelU/bNYejzU1CBAvFCW412MVtwEgLhYcwggEXHh4=;
  b=ndvahX+RkbQyzwPjugehcaJW7NlvYmwuRsgk1bFZFHmGKmQAXojThbcA
   /RzunwzfrMtMap8wTWSIHzVPB4QWktF0pLeu5ovn6Jhc06pEKyqhgeHGn
   ipsIQzPwwR33dfu8OhqipZja78quIQUMXznyxL1vwZLuAcq0Sd97i3t9M
   r1ioXGeP/Yj2QwWEKkKV1+jQI95ikYy3ag+OXfhN6bmU8+l4jRBJQ4FrX
   FLTcQVOe4VjtIiTvbG9BFVP81qwYOYGvRQvnHnWwvt4tovMIAUz1gffMj
   cadDGskWP5EnQSUzPzsZNDTz1onR6ea1x130DjJKT4RwkTqUri0o1T43x
   Q==;
X-CSE-ConnectionGUID: raGzPZisRQGLw1maTEl0BA==
X-CSE-MsgGUID: 9JwovDPgQoqLplGqqXN/3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="12949238"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="12949238"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 13:26:57 -0700
X-CSE-ConnectionGUID: QvxAfgq/SG2ey7h0sSLnAA==
X-CSE-MsgGUID: HJktMLTpT829khMLu3uJEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="88728902"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 10 Aug 2024 13:26:53 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scsfr-000AGv-1R;
	Sat, 10 Aug 2024 20:26:51 +0000
Date: Sun, 11 Aug 2024 04:26:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] wifi: iwlwifi: mvm: Use __counted_by() and
 avoid -Wfamnae warnings
Message-ID: <202408110634.V68RFEtW-lkp@intel.com>
References: <ZrZs5KL5Pz9tIinr@cute>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrZs5KL5Pz9tIinr@cute>

Hi Gustavo,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.11-rc2 next-20240809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gustavo-A-R-Silva/wifi-iwlwifi-mvm-Use-__counted_by-and-avoid-Wfamnae-warnings/20240810-103759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/ZrZs5KL5Pz9tIinr%40cute
patch subject: [PATCH v2][next] wifi: iwlwifi: mvm: Use __counted_by() and avoid -Wfamnae warnings
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20240811/202408110634.V68RFEtW-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f86594788ce93b696675c94f54016d27a6c21d18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240811/202408110634.V68RFEtW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408110634.V68RFEtW-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/intel/iwlwifi/mvm/d3.c:7:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2149:2: error: call to '__compiletime_assert_1044' declared with 'error' attribute: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
    2149 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_GCMP_256);
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:510:2: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:498:2: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:491:4: note: expanded from macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:38:1: note: expanded from here
      38 | __compiletime_assert_1044
         | ^
>> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2148:2: error: call to '__compiletime_assert_1043' declared with 'error' attribute: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
    2148 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_CCMP);
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:510:2: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:498:2: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:491:4: note: expanded from macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:34:1: note: expanded from here
      34 | __compiletime_assert_1043
         | ^
   5 warnings and 2 errors generated.


vim +2149 drivers/net/wireless/intel/iwlwifi/mvm/d3.c

  2134	
  2135	static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
  2136				      struct ieee80211_vif *vif,
  2137				      struct iwl_mvm *mvm, u32 gtk_cipher)
  2138	{
  2139		int i, j;
  2140		struct ieee80211_key_conf *key;
  2141		DEFINE_FLEX(struct ieee80211_key_conf, conf, key, keylen,
  2142			    WOWLAN_KEY_MAX_SIZE);
  2143		int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
  2144	
  2145		conf->cipher = gtk_cipher;
  2146	
  2147		BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
> 2148		BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_CCMP);
> 2149		BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_GCMP_256);
  2150		BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_TKIP);
  2151		BUILD_BUG_ON(conf->keylen < sizeof(status->gtk[0].key));
  2152	
  2153		switch (gtk_cipher) {
  2154		case WLAN_CIPHER_SUITE_CCMP:
  2155		case WLAN_CIPHER_SUITE_GCMP:
  2156			conf->keylen = WLAN_KEY_LEN_CCMP;
  2157			break;
  2158		case WLAN_CIPHER_SUITE_GCMP_256:
  2159			conf->keylen = WLAN_KEY_LEN_GCMP_256;
  2160			break;
  2161		case WLAN_CIPHER_SUITE_TKIP:
  2162			conf->keylen = WLAN_KEY_LEN_TKIP;
  2163			break;
  2164		default:
  2165			WARN_ON(1);
  2166		}
  2167	
  2168		for (i = 0; i < ARRAY_SIZE(status->gtk); i++) {
  2169			if (!status->gtk[i].len)
  2170				continue;
  2171	
  2172			conf->keyidx = status->gtk[i].id;
  2173			IWL_DEBUG_WOWLAN(mvm,
  2174					 "Received from FW GTK cipher %d, key index %d\n",
  2175					 conf->cipher, conf->keyidx);
  2176			memcpy(conf->key, status->gtk[i].key,
  2177			       sizeof(status->gtk[i].key));
  2178	
  2179			key = ieee80211_gtk_rekey_add(vif, conf, link_id);
  2180			if (IS_ERR(key))
  2181				return false;
  2182	
  2183			for (j = 0; j < ARRAY_SIZE(status->gtk_seq); j++) {
  2184				if (!status->gtk_seq[j].valid ||
  2185				    status->gtk_seq[j].key_id != key->keyidx)
  2186					continue;
  2187				iwl_mvm_set_key_rx_seq_idx(key, status, j);
  2188				break;
  2189			}
  2190			WARN_ON(j == ARRAY_SIZE(status->gtk_seq));
  2191		}
  2192	
  2193		return true;
  2194	}
  2195	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

