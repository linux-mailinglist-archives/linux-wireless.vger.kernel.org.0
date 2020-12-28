Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A232E6C25
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Dec 2020 00:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgL1Wzq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 17:55:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:17743 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbgL1VvD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 16:51:03 -0500
IronPort-SDR: s0ZlAU3WcEepJVLiOHRRuoymUJtDc/YYPo+aJ6xPMOl0wERuCsr4w7jHN7jDnUCk2qRhJmFBuV
 m9hR/u+IxXzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="163490986"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="gz'50?scan'50,208,50";a="163490986"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 13:50:19 -0800
IronPort-SDR: IEFoD/juHMwY6EczQ5qbp+fcB4ADzgpnGrXmvifm3cF/+Dlp7/+mivft1XIJvY4Kjqr1Zbplbl
 JrapC1WOMbiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="gz'50?scan'50,208,50";a="494429718"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Dec 2020 13:50:16 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ku0P9-00038Y-Jf; Mon, 28 Dec 2020 21:50:15 +0000
Date:   Tue, 29 Dec 2020 05:49:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, bryan.odonoghue@linaro.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org
Subject: Re: [PATCH 06/13] wcn36xx: Add ipv6 namespace offload in suspend
Message-ID: <202012290547.6ryYf96B-lkp@intel.com>
References: <20201228162839.369156-7-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20201228162839.369156-7-bryan.odonoghue@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bryan,

I love your patch! Yet something to improve:

[auto build test ERROR on wireless-drivers-next/master]
[also build test ERROR on wireless-drivers/master ath6kl/ath-next v5.11-rc1 next-20201223]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Bryan-O-Donoghue/wcn36xx-Enable-downstream-consistent-Wake-on-Lan/20201229-003134
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
config: m68k-randconfig-r004-20201228 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/3af46faf5418cb35d31847e75156f9bb24b3828a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Bryan-O-Donoghue/wcn36xx-Enable-downstream-consistent-Wake-on-Lan/20201229-003134
        git checkout 3af46faf5418cb35d31847e75156f9bb24b3828a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/linux/skbuff.h:13,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/wireless/ath/wcn36xx/smd.c:19:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                 ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/net/wireless/ath/wcn36xx/smd.c: In function 'wcn36xx_smd_ipv6_ns_offload':
>> drivers/net/wireless/ath/wcn36xx/smd.c:2816:15: error: 'struct wcn36xx_vif' has no member named 'num_target_ipv6_addrs'
    2816 |   if (vif_priv->num_target_ipv6_addrs) {
         |               ^~
   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/bvec.h:14,
                    from include/linux/skbuff.h:17,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/wireless/ath/wcn36xx/smd.c:19:
>> drivers/net/wireless/ath/wcn36xx/smd.c:2818:20: error: 'struct wcn36xx_vif' has no member named 'target_ipv6_addrs'
    2818 |           &vif_priv->target_ipv6_addrs[0].in6_u,
         |                    ^~
   arch/m68k/include/asm/string.h:72:45: note: in definition of macro 'memcpy'
      72 | #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
         |                                             ^
   drivers/net/wireless/ath/wcn36xx/smd.c:2821:20: error: 'struct wcn36xx_vif' has no member named 'target_ipv6_addrs'
    2821 |           &vif_priv->target_ipv6_addrs[0].in6_u,
         |                    ^~
   arch/m68k/include/asm/string.h:72:45: note: in definition of macro 'memcpy'
      72 | #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
         |                                             ^
   drivers/net/wireless/ath/wcn36xx/smd.c:2825:15: error: 'struct wcn36xx_vif' has no member named 'num_target_ipv6_addrs'
    2825 |   if (vif_priv->num_target_ipv6_addrs > 1) {
         |               ^~
   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/bvec.h:14,
                    from include/linux/skbuff.h:17,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/wireless/ath/wcn36xx/smd.c:19:
   drivers/net/wireless/ath/wcn36xx/smd.c:2827:20: error: 'struct wcn36xx_vif' has no member named 'target_ipv6_addrs'
    2827 |           &vif_priv->target_ipv6_addrs[1].in6_u,
         |                    ^~
   arch/m68k/include/asm/string.h:72:45: note: in definition of macro 'memcpy'
      72 | #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
         |                                             ^


vim +2816 drivers/net/wireless/ath/wcn36xx/smd.c

  2796	
  2797	int wcn36xx_smd_ipv6_ns_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
  2798					bool enable)
  2799	{
  2800		struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
  2801		struct wcn36xx_hal_host_offload_req_msg msg_body;
  2802		struct wcn36xx_hal_ns_offload_params *ns_params;
  2803		struct wcn36xx_hal_host_offload_req *ho_params;
  2804		int ret;
  2805	
  2806		mutex_lock(&wcn->hal_mutex);
  2807	
  2808		INIT_HAL_MSG(msg_body, WCN36XX_HAL_HOST_OFFLOAD_REQ);
  2809		ho_params = &msg_body.host_offload_params;
  2810		ns_params = &msg_body.ns_offload_params;
  2811	
  2812		ho_params->offload_type = WCN36XX_HAL_IPV6_NS_OFFLOAD;
  2813		if (enable) {
  2814			ho_params->enable =
  2815				WCN36XX_HAL_OFFLOAD_NS_AND_MCAST_FILTER_ENABLE;
> 2816			if (vif_priv->num_target_ipv6_addrs) {
  2817				memcpy(&ho_params->u,
> 2818				       &vif_priv->target_ipv6_addrs[0].in6_u,
  2819				       sizeof(struct in6_addr));
  2820				memcpy(&ns_params->target_ipv6_addr1,
  2821				       &vif_priv->target_ipv6_addrs[0].in6_u,
  2822				       sizeof(struct in6_addr));
  2823				ns_params->target_ipv6_addr1_valid = 1;
  2824			}
  2825			if (vif_priv->num_target_ipv6_addrs > 1) {
  2826				memcpy(&ns_params->target_ipv6_addr2,
  2827				       &vif_priv->target_ipv6_addrs[1].in6_u,
  2828				       sizeof(struct in6_addr));
  2829				ns_params->target_ipv6_addr2_valid = 1;
  2830			}
  2831		}
  2832		memcpy(&ns_params->self_addr, vif->addr, ETH_ALEN);
  2833		ns_params->bss_index = vif_priv->bss_index;
  2834	
  2835		PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
  2836	
  2837		ret = wcn36xx_smd_send_and_wait(wcn, msg_body.header.len);
  2838		if (ret) {
  2839			wcn36xx_err("Sending host_offload_arp failed\n");
  2840			goto out;
  2841		}
  2842		ret = wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len);
  2843		if (ret) {
  2844			wcn36xx_err("host_offload_arp failed err=%d\n", ret);
  2845			goto out;
  2846		}
  2847	out:
  2848		mutex_unlock(&wcn->hal_mutex);
  2849		return ret;
  2850	}
  2851	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--PEIAKu/WMn1b1Hv9
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AA==

--PEIAKu/WMn1b1Hv9--
