Return-Path: <linux-wireless+bounces-9563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3085917534
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 02:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80E01C20CBE
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 00:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89565C83;
	Wed, 26 Jun 2024 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEYkSQad"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28521FDA;
	Wed, 26 Jun 2024 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719361200; cv=none; b=PA3jMWEnq3R3pBTceRrHEmXK9TBlvv6bfP+F2RDFWwYaC/OEcK4KID1jo90VuQgEh01uy5gy2TPSwg/T1SH27Id+ddbl4U++RpSsBQO7p0dRJ/U1Or2G8PMCjeIUU/jI+S5CxUfCbuWzj23gifIYiZT+mO2w/fJVd4gvMwQHjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719361200; c=relaxed/simple;
	bh=VyKJoiUnArbE85wVbW2yF8U84igiUbDe9AhUCeSC9bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXi20VENjAD0NCAbh4JIl6Zgl2T8GcNNQx32GFfeR9OVhBzni2xK7H6wFkrEw3AvrqKUAE7o+qGuWxRpX/zAzsY8+pvJSr2BbwJ/f2hF8LlmCV4Ge1NrqaKh7UFtuwzDGMCW5R7iLif47nZ16R0JVSkMACVPsz3CzVpPK7pBnS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEYkSQad; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719361198; x=1750897198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VyKJoiUnArbE85wVbW2yF8U84igiUbDe9AhUCeSC9bA=;
  b=ZEYkSQadVWYpLhvWaE8Gld6G2GguV1VUFyKCz8aoILMJZawdINvU5KZ/
   sDJQACpO7/KTpVQbQFntIWI1N1Yt02FNVlU7CEqR3zbVUDFJJk7NEgiHI
   UghD+H2O8q49IV440IGgvT2HnbVn+EUHmaFizpzaSPyVY9U9EQcUB13xE
   qikGdL2ojU5nhcoCeUscUJjNV8vSWg+9x+F4LopEz07MMvhdLcP0V/qgg
   EsNZMZ0t/AOWyzCSmtLJBeUDGn0mtnfRcubh2bOySyOdRcAxQLWevRGTy
   89z991oByaGhsdTP/MEX1h4io1TIixSPmNrkvEACiEOxjek6fU2VelNib
   w==;
X-CSE-ConnectionGUID: 496gPoHfSheBXa6bgXJDtQ==
X-CSE-MsgGUID: B8Lzn+ARQvyPWhnzZpV0Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="19300653"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="19300653"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 17:19:57 -0700
X-CSE-ConnectionGUID: JcfAnWtYQAe43ZyW7371ww==
X-CSE-MsgGUID: YXSpsHLhSsKFj+neRKfkBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="44531365"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 25 Jun 2024 17:19:55 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMGO8-000EpP-01;
	Wed, 26 Jun 2024 00:19:52 +0000
Date: Wed, 26 Jun 2024 08:19:02 +0800
From: kernel test robot <lkp@intel.com>
To: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, briannorris@chromium.org,
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH 42/43] wifi: nxpwifi: add Makefile and Kconfig files for
 nxpwifi compilation
Message-ID: <202406260755.fqLnsFhr-lkp@intel.com>
References: <20240621075208.513497-43-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621075208.513497-43-yu-hao.lin@nxp.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 238d636723a30311e20fde0a361662e829fe488b]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lin/wifi-nxpwifi-add-11ac-c/20240625-161306
base:   238d636723a30311e20fde0a361662e829fe488b
patch link:    https://lore.kernel.org/r/20240621075208.513497-43-yu-hao.lin%40nxp.com
patch subject: [PATCH 42/43] wifi: nxpwifi: add Makefile and Kconfig files for nxpwifi compilation
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240626/202406260755.fqLnsFhr-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406260755.fqLnsFhr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406260755.fqLnsFhr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/nxp/nxpwifi/11h.c:208:7: warning: variable 'chan2_offset' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     208 |         case NL80211_CHAN_WIDTH_80P80:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:214:16: note: uninitialized use occurs here
     214 |         *band_cfg = ((chan2_offset << BAND_CFG_CHAN2_SHIFT_BIT) &
         |                       ^~~~~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:209:7: warning: variable 'chan2_offset' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     209 |         case NL80211_CHAN_WIDTH_160:
         |              ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:214:16: note: uninitialized use occurs here
     214 |         *band_cfg = ((chan2_offset << BAND_CFG_CHAN2_SHIFT_BIT) &
         |                       ^~~~~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:192:7: warning: variable 'chan2_offset' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     192 |         case NL80211_CHAN_WIDTH_20_NOHT:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:214:16: note: uninitialized use occurs here
     214 |         *band_cfg = ((chan2_offset << BAND_CFG_CHAN2_SHIFT_BIT) &
         |                       ^~~~~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:193:7: warning: variable 'chan2_offset' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     193 |         case NL80211_CHAN_WIDTH_20:
         |              ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:214:16: note: uninitialized use occurs here
     214 |         *band_cfg = ((chan2_offset << BAND_CFG_CHAN2_SHIFT_BIT) &
         |                       ^~~~~~~~~~~~
>> drivers/net/wireless/nxp/nxpwifi/11h.c:210:2: warning: variable 'chan2_offset' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
     210 |         default:
         |         ^~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:214:16: note: uninitialized use occurs here
     214 |         *band_cfg = ((chan2_offset << BAND_CFG_CHAN2_SHIFT_BIT) &
         |                       ^~~~~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:178:40: note: initialize the variable 'chan2_offset' to silence this warning
     178 |         u8 chan_band, chan_width, chan2_offset;
         |                                               ^
         |                                                = '\0'
>> drivers/net/wireless/nxp/nxpwifi/11h.c:208:7: warning: variable 'chan_width' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     208 |         case NL80211_CHAN_WIDTH_80P80:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:216:9: note: uninitialized use occurs here
     216 |                     ((chan_width << BAND_CFG_CHAN_WIDTH_SHIFT_BIT) &
         |                       ^~~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:209:7: warning: variable 'chan_width' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     209 |         case NL80211_CHAN_WIDTH_160:
         |              ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:216:9: note: uninitialized use occurs here
     216 |                     ((chan_width << BAND_CFG_CHAN_WIDTH_SHIFT_BIT) &
         |                       ^~~~~~~~~~
>> drivers/net/wireless/nxp/nxpwifi/11h.c:210:2: warning: variable 'chan_width' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
     210 |         default:
         |         ^~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:216:9: note: uninitialized use occurs here
     216 |                     ((chan_width << BAND_CFG_CHAN_WIDTH_SHIFT_BIT) &
         |                       ^~~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:178:26: note: initialize the variable 'chan_width' to silence this warning
     178 |         u8 chan_band, chan_width, chan2_offset;
         |                                 ^
         |                                  = '\0'
>> drivers/net/wireless/nxp/nxpwifi/11h.c:187:2: warning: variable 'chan_band' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
     187 |         default:
         |         ^~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:218:9: note: uninitialized use occurs here
     218 |                     ((chan_band << BAND_CFG_CHAN_BAND_SHIFT_BIT) &
         |                       ^~~~~~~~~
   drivers/net/wireless/nxp/nxpwifi/11h.c:178:14: note: initialize the variable 'chan_band' to silence this warning
     178 |         u8 chan_band, chan_width, chan2_offset;
         |                     ^
         |                      = '\0'
   9 warnings generated.


vim +/chan2_offset +208 drivers/net/wireless/nxp/nxpwifi/11h.c

647388e635d138 David Lin 2024-06-21  174  
647388e635d138 David Lin 2024-06-21  175  static void nxpwifi_convert_chan_to_band_cfg(u8 *band_cfg,
647388e635d138 David Lin 2024-06-21  176  					     struct cfg80211_chan_def *chan_def)
647388e635d138 David Lin 2024-06-21  177  {
647388e635d138 David Lin 2024-06-21  178  	u8 chan_band, chan_width, chan2_offset;
647388e635d138 David Lin 2024-06-21  179  
647388e635d138 David Lin 2024-06-21  180  	switch (chan_def->chan->band) {
647388e635d138 David Lin 2024-06-21  181  	case NL80211_BAND_2GHZ:
647388e635d138 David Lin 2024-06-21  182  		chan_band = BAND_2GHZ;
647388e635d138 David Lin 2024-06-21  183  		break;
647388e635d138 David Lin 2024-06-21  184  	case NL80211_BAND_5GHZ:
647388e635d138 David Lin 2024-06-21  185  		chan_band = BAND_5GHZ;
647388e635d138 David Lin 2024-06-21  186  		break;
647388e635d138 David Lin 2024-06-21 @187  	default:
647388e635d138 David Lin 2024-06-21  188  		break;
647388e635d138 David Lin 2024-06-21  189  	}
647388e635d138 David Lin 2024-06-21  190  
647388e635d138 David Lin 2024-06-21  191  	switch (chan_def->width) {
647388e635d138 David Lin 2024-06-21  192  	case NL80211_CHAN_WIDTH_20_NOHT:
647388e635d138 David Lin 2024-06-21  193  	case NL80211_CHAN_WIDTH_20:
647388e635d138 David Lin 2024-06-21  194  		chan_width = CHAN_BW_20MHZ;
647388e635d138 David Lin 2024-06-21  195  		break;
647388e635d138 David Lin 2024-06-21  196  	case NL80211_CHAN_WIDTH_40:
647388e635d138 David Lin 2024-06-21  197  		chan_width = CHAN_BW_40MHZ;
647388e635d138 David Lin 2024-06-21  198  		if (chan_def->center_freq1 > chan_def->chan->center_freq)
647388e635d138 David Lin 2024-06-21  199  			chan2_offset = SEC_CHAN_ABOVE;
647388e635d138 David Lin 2024-06-21  200  		else
647388e635d138 David Lin 2024-06-21  201  			chan2_offset = SEC_CHAN_BELOW;
647388e635d138 David Lin 2024-06-21  202  		break;
647388e635d138 David Lin 2024-06-21  203  	case NL80211_CHAN_WIDTH_80:
647388e635d138 David Lin 2024-06-21  204  		chan2_offset =
647388e635d138 David Lin 2024-06-21  205  			nxpwifi_get_channel_2_offset(chan_def->chan->hw_value);
647388e635d138 David Lin 2024-06-21  206  		chan_width = CHAN_BW_80MHZ;
647388e635d138 David Lin 2024-06-21  207  		break;
647388e635d138 David Lin 2024-06-21 @208  	case NL80211_CHAN_WIDTH_80P80:
647388e635d138 David Lin 2024-06-21  209  	case NL80211_CHAN_WIDTH_160:
647388e635d138 David Lin 2024-06-21 @210  	default:
647388e635d138 David Lin 2024-06-21  211  		break;
647388e635d138 David Lin 2024-06-21  212  	}
647388e635d138 David Lin 2024-06-21  213  
647388e635d138 David Lin 2024-06-21 @214  	*band_cfg = ((chan2_offset << BAND_CFG_CHAN2_SHIFT_BIT) &
647388e635d138 David Lin 2024-06-21  215  		     BAND_CFG_CHAN2_OFFSET_MASK) |
647388e635d138 David Lin 2024-06-21 @216  		    ((chan_width << BAND_CFG_CHAN_WIDTH_SHIFT_BIT) &
647388e635d138 David Lin 2024-06-21  217  		     BAND_CFG_CHAN_WIDTH_MASK) |
647388e635d138 David Lin 2024-06-21  218  		    ((chan_band << BAND_CFG_CHAN_BAND_SHIFT_BIT) &
647388e635d138 David Lin 2024-06-21  219  		     BAND_CFG_CHAN_BAND_MASK);
647388e635d138 David Lin 2024-06-21  220  }
647388e635d138 David Lin 2024-06-21  221  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

