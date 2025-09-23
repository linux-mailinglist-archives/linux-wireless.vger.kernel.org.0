Return-Path: <linux-wireless+bounces-27618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D9FB96DCD
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 18:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6B318A65E4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60B32340F;
	Tue, 23 Sep 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2C2ALed"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC630E0E6
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645798; cv=none; b=IZAGeE2KChFkiIoBgJ5D99V3BkyH+8UkFIi1WvQX3trgyFsgUiySS3ReuRfzOBU+5mrMEpUfSQVzfdG6zUWYraBMFpUQHK2rE4E9Y1DgpK8ZJ9l4wFS+/Q8sfvN6OeWndNqRHV/r76kWKlD8fhXiUyqncgYCFnLR0PBo8c60QSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645798; c=relaxed/simple;
	bh=SZu90RkHMc3N2sB4G4sJ5JIBQGh8toRx1QR7oo0+zwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGKwW0LFs6GNVIl90GG0ekCUzWTGX7k32MEK4/W+7skNXAZhzMMg4EG4jqImNnuk2SOYxToIMh7C/Vwjan7JypycCBGvRU+D3+zu3LBIIuNrFDTCpuBZtbMwJSHagv8n49NMACMw33ZHEd6GY26H1spghgHEroT1CDjuaAlLDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2C2ALed; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758645797; x=1790181797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SZu90RkHMc3N2sB4G4sJ5JIBQGh8toRx1QR7oo0+zwo=;
  b=l2C2ALedacNdANVjY5cJ9m9RzdtMPuWjXzonSaLp+LNH6k4PkslLEszL
   mcw6ljVUuxKqG8xmFu3VMunAfxD2TO6XzP+GB8WzzIwGOm6hu+ZFg8eSi
   peCgghATdrIuAtuZGi578nynaZiPSiWpSuCY3cAIxLyJ6QND8e6J54oOf
   FbTG++qXmycxBaIqtwt+4YCwTxZRJoEZryQ5rTQK5FjWUZ2MFpDWzDtRK
   +gpi4SISjgAfbBojj4/iUauhUyD6gU4s0NpcD2ykO3o20BLX2tA0iZo00
   opP6ATSwZ+VsGMXJkQ/dHZWwpE7cNiR0TtY1K/0JxQjf7rkQ1+FgUHbgw
   w==;
X-CSE-ConnectionGUID: ijqnfKh6QVGjub5hFCEXIA==
X-CSE-MsgGUID: dPzNk4EGRw+Myb0pIE3pug==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60823805"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="60823805"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 09:43:16 -0700
X-CSE-ConnectionGUID: LMJpSueIQrCBQr7A3MMcug==
X-CSE-MsgGUID: LIZAHN9LSf+pJYEKw1+4ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="213953775"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 23 Sep 2025 09:43:14 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v166h-0003KJ-2T;
	Tue, 23 Sep 2025 16:43:11 +0000
Date: Wed, 24 Sep 2025 00:42:36 +0800
From: kernel test robot <lkp@intel.com>
To: Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: oe-kbuild-all@lists.linux.dev, Shayne Chen <shayne.chen@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v1] wifi: cfg80211/mac80211: validate radio frequency
 range for monitor mode
Message-ID: <202509240056.ZzRWUscD-lkp@intel.com>
References: <9589ba59a05d43f2fff5218493c5a6f4fd6087d2.1758595078.git.ryder.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9589ba59a05d43f2fff5218493c5a6f4fd6087d2.1758595078.git.ryder.lee@mediatek.com>

Hi Ryder,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.17-rc7 next-20250922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryder-Lee/wifi-cfg80211-mac80211-validate-radio-frequency-range-for-monitor-mode/20250923-104030
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/9589ba59a05d43f2fff5218493c5a6f4fd6087d2.1758595078.git.ryder.lee%40mediatek.com
patch subject: [PATCH v1] wifi: cfg80211/mac80211: validate radio frequency range for monitor mode
config: sh-randconfig-002-20250923 (https://download.01.org/0day-ci/archive/20250924/202509240056.ZzRWUscD-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250924/202509240056.ZzRWUscD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509240056.ZzRWUscD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/wireless/util.c:15:
   include/net/cfg80211.h:1028:52: warning: 'struct wiphy_radio' declared inside parameter list will not be visible outside of this definition or declaration
    1028 | bool ieee80211_radio_freq_range_valid(const struct wiphy_radio *radio,
         |                                                    ^~~~~~~~~~~
>> net/wireless/util.c:2945:6: error: conflicting types for 'ieee80211_radio_freq_range_valid'
    2945 | bool ieee80211_radio_freq_range_valid(const struct wiphy_radio *radio,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from net/wireless/util.c:15:
   include/net/cfg80211.h:1028:6: note: previous declaration of 'ieee80211_radio_freq_range_valid' was here
    1028 | bool ieee80211_radio_freq_range_valid(const struct wiphy_radio *radio,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from net/wireless/util.c:10:
   net/wireless/util.c:2960:15: error: conflicting types for 'ieee80211_radio_freq_range_valid'
    2960 | EXPORT_SYMBOL(ieee80211_radio_freq_range_valid);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:76:21: note: in definition of macro '__EXPORT_SYMBOL'
      76 |  extern typeof(sym) sym;     \
         |                     ^~~
   include/linux/export.h:89:29: note: in expansion of macro '_EXPORT_SYMBOL'
      89 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   net/wireless/util.c:2960:1: note: in expansion of macro 'EXPORT_SYMBOL'
    2960 | EXPORT_SYMBOL(ieee80211_radio_freq_range_valid);
         | ^~~~~~~~~~~~~
   In file included from net/wireless/util.c:15:
   include/net/cfg80211.h:1028:6: note: previous declaration of 'ieee80211_radio_freq_range_valid' was here
    1028 | bool ieee80211_radio_freq_range_valid(const struct wiphy_radio *radio,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ieee80211_radio_freq_range_valid +2945 net/wireless/util.c

  2944	
> 2945	bool ieee80211_radio_freq_range_valid(const struct wiphy_radio *radio,
  2946					      u32 freq, u32 width)
  2947	{
  2948		const struct wiphy_radio_freq_range *r;
  2949		int i;
  2950	
  2951		for (i = 0; i < radio->n_freq_range; i++) {
  2952			r = &radio->freq_range[i];
  2953			if (freq - width / 2 >= r->start_freq &&
  2954			    freq + width / 2 <= r->end_freq)
  2955				return true;
  2956		}
  2957	
  2958		return false;
  2959	}
  2960	EXPORT_SYMBOL(ieee80211_radio_freq_range_valid);
  2961	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

