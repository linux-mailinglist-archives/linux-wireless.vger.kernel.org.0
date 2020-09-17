Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F0D26DE13
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 16:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgIQOWI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 10:22:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:22647 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbgIQNwG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 09:52:06 -0400
IronPort-SDR: afN3c6/636naHRX4LhNYxQmR5Io1Da3bs66zDzw2p8Gy8t0nDURcrW93k9PB9lWbbgFpv9FfyD
 QkMOt5MURJsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="223872954"
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; 
   d="gz'50?scan'50,208,50";a="223872954"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 06:41:12 -0700
IronPort-SDR: e3zWrGAc384Iob1BUNnGAZP6J5q9fQd94Djd6XmlaZEibBic38K8dEnVuhsHjQRpoUSb3ElKi4
 r9HuSkrWuKTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; 
   d="gz'50?scan'50,208,50";a="507690241"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Sep 2020 06:41:02 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kIu9j-00000P-Gi; Thu, 17 Sep 2020 13:40:59 +0000
Date:   Thu, 17 Sep 2020 21:40:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Tova Mussai <tova.mussai@intel.com>
Subject: Re: [PATCH v4] nl80211/cfg80211: support 6 GHz scanning
Message-ID: <202009172152.5ogCSh1u%lkp@intel.com>
References: <20200917105938.190537ba2295.Ida22f0212f9122f47094d81659e879a50434a6a2@changeid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20200917105938.190537ba2295.Ida22f0212f9122f47094d81659e879a50434a6a2@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johannes,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mac80211-next/master]
[also build test ERROR on mac80211/master v5.9-rc5 next-20200917]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Johannes-Berg/nl80211-cfg80211-support-6-GHz-scanning/20200917-170112
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
config: powerpc64-randconfig-r035-20200917 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 1321160a26e7e489baf9b10d6de90a342f898960)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:604:
   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:213:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:542:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from net/wireless/scan.c:13:
   In file included from include/linux/netdevice.h:37:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:604:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:215:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:543:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from net/wireless/scan.c:13:
   In file included from include/linux/netdevice.h:37:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:604:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:217:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:544:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from net/wireless/scan.c:13:
   In file included from include/linux/netdevice.h:37:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:604:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:219:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:545:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from net/wireless/scan.c:13:
   In file included from include/linux/netdevice.h:37:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:604:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:221:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:546:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
>> net/wireless/scan.c:839:7: error: implicit declaration of function 'cfg80211_is_psc' [-Werror,-Wimplicit-function-declaration]
                   if (cfg80211_is_psc(chan) && !need_scan_psc)
                       ^
   12 warnings and 1 error generated.

# https://github.com/0day-ci/linux/commit/6c8ef71e4783e7524ee2a59e264dd67676a5f532
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Johannes-Berg/nl80211-cfg80211-support-6-GHz-scanning/20200917-170112
git checkout 6c8ef71e4783e7524ee2a59e264dd67676a5f532
vim +/cfg80211_is_psc +839 net/wireless/scan.c

   720	
   721	static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
   722	{
   723		u8 i;
   724		struct cfg80211_colocated_ap *ap;
   725		int n_channels, count = 0, err;
   726		struct cfg80211_scan_request *request, *rdev_req = rdev->scan_req;
   727		LIST_HEAD(coloc_ap_list);
   728		bool need_scan_psc;
   729		const struct ieee80211_sband_iftype_data *iftd;
   730	
   731		rdev_req->scan_6ghz = true;
   732	
   733		if (!rdev->wiphy.bands[NL80211_BAND_6GHZ])
   734			return -EOPNOTSUPP;
   735	
   736		iftd = ieee80211_get_sband_iftype_data(rdev->wiphy.bands[NL80211_BAND_6GHZ],
   737						       rdev_req->wdev->iftype);
   738		if (!iftd || !iftd->he_cap.has_he)
   739			return -EOPNOTSUPP;
   740	
   741		n_channels = rdev->wiphy.bands[NL80211_BAND_6GHZ]->n_channels;
   742	
   743		if (rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ) {
   744			struct cfg80211_internal_bss *intbss;
   745	
   746			spin_lock_bh(&rdev->bss_lock);
   747			list_for_each_entry(intbss, &rdev->bss_list, list) {
   748				struct cfg80211_bss *res = &intbss->pub;
   749	
   750				count += cfg80211_parse_colocated_ap(res->ies,
   751								     &coloc_ap_list);
   752			}
   753			spin_unlock_bh(&rdev->bss_lock);
   754		}
   755	
   756		request = kzalloc(struct_size(request, channels, n_channels) +
   757				  sizeof(*request->scan_6ghz_params) * count,
   758				  GFP_KERNEL);
   759		if (!request) {
   760			cfg80211_free_coloc_ap_list(&coloc_ap_list);
   761			return -ENOMEM;
   762		}
   763	
   764		*request = *rdev_req;
   765		request->n_channels = 0;
   766		request->scan_6ghz_params =
   767			(void *)&request->channels[n_channels];
   768	
   769		/*
   770		 * PSC channels should not be scanned if all the reported co-located APs
   771		 * are indicating that all APs in the same ESS are co-located
   772		 */
   773		if (count) {
   774			need_scan_psc = false;
   775	
   776			list_for_each_entry(ap, &coloc_ap_list, list) {
   777				if (!ap->colocated_ess) {
   778					need_scan_psc = true;
   779					break;
   780				}
   781			}
   782		} else {
   783			need_scan_psc = true;
   784		}
   785	
   786		/*
   787		 * add to the scan request the channels that need to be scanned
   788		 * regardless of the collocated APs (PSC channels or all channels
   789		 * in case that NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set)
   790		 */
   791		for (i = 0; i < rdev_req->n_channels; i++) {
   792			if (rdev_req->channels[i]->band == NL80211_BAND_6GHZ &&
   793			    ((need_scan_psc &&
   794			      cfg80211_channel_is_psc(rdev_req->channels[i])) ||
   795			     !(rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ))) {
   796				cfg80211_scan_req_add_chan(request,
   797							   rdev_req->channels[i],
   798							   false);
   799			}
   800		}
   801	
   802		if (!(rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ))
   803			goto skip;
   804	
   805		list_for_each_entry(ap, &coloc_ap_list, list) {
   806			bool found = false;
   807			struct cfg80211_scan_6ghz_params *scan_6ghz_params =
   808				&request->scan_6ghz_params[request->n_6ghz_params];
   809			struct ieee80211_channel *chan =
   810				ieee80211_get_channel(&rdev->wiphy, ap->center_freq);
   811	
   812			if (!chan || chan->flags & IEEE80211_CHAN_DISABLED)
   813				continue;
   814	
   815			for (i = 0; i < rdev_req->n_channels; i++) {
   816				if (rdev_req->channels[i] == chan)
   817					found = true;
   818			}
   819	
   820			if (!found)
   821				continue;
   822	
   823			if (request->n_ssids > 0 &&
   824			    !cfg80211_find_ssid_match(ap, request))
   825				continue;
   826	
   827			cfg80211_scan_req_add_chan(request, chan, true);
   828			memcpy(scan_6ghz_params->bssid, ap->bssid, ETH_ALEN);
   829			scan_6ghz_params->short_ssid = ap->short_ssid;
   830			scan_6ghz_params->short_ssid_valid = ap->short_ssid_valid;
   831			scan_6ghz_params->unsolicited_probe = ap->unsolicited_probe;
   832	
   833			/*
   834			 * If a PSC channel is added to the scan and 'need_scan_psc' is
   835			 * set to false, then all the APs that the scan logic is
   836			 * interested with on the channel are collocated and thus there
   837			 * is no need to perform the initial PSC channel listen.
   838			 */
 > 839			if (cfg80211_is_psc(chan) && !need_scan_psc)
   840				scan_6ghz_params->psc_no_listen = true;
   841	
   842			request->n_6ghz_params++;
   843		}
   844	
   845	skip:
   846		cfg80211_free_coloc_ap_list(&coloc_ap_list);
   847	
   848		if (request->n_channels) {
   849			struct cfg80211_scan_request *old = rdev->int_scan_req;
   850	
   851			rdev->int_scan_req = request;
   852	
   853			/*
   854			 * If this scan follows a previous scan, save the scan start
   855			 * info from the first part of the scan
   856			 */
   857			if (old)
   858				rdev->int_scan_req->info = old->info;
   859	
   860			err = rdev_scan(rdev, request);
   861			if (err) {
   862				rdev->int_scan_req = old;
   863				kfree(request);
   864			} else {
   865				kfree(old);
   866			}
   867	
   868			return err;
   869		}
   870	
   871		kfree(request);
   872		return -EINVAL;
   873	}
   874	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LZvS9be/3tNcYl/X
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
nVhv8QUmJ/RuFN7IxNjqBZmGAwCsHU/17XsBAA==

--LZvS9be/3tNcYl/X--
