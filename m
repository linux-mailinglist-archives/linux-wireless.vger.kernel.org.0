Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81F8506339
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 06:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbiDSEdJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 00:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345620AbiDSEdI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 00:33:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90474220CD
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 21:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650342626; x=1681878626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=75RHFcZMVW+I/UZ/yfunlweL0Kydxw/rwocNm9AXRzs=;
  b=RT8HhNPpJqVyu0yLQq2VTSSY4X8vwVywPdUEDcC1h76ofAi4j/gbwaXo
   ChHe48OiZfjTz12QPVaPl+Qfwwe7CM7p7HXdPsZeAEOCHWgsNYjleeBS0
   dQ2jz2KgeomMYCI7kd0d5P81ELWF+MpQzn1l5diGq8+QHv/Mdo8tFVuaq
   pZUGT+cyKGuwpBHzLQmiHFimxQfSxHFGmRfdGHTYg5bXWMPN1DwTFtFul
   1Z2Kmh2S2Df6F29P0QDxiG4yh3mSTOP834EwwU3dDsPyc+LEjlzFC1zVv
   3+vX2J9GzkGDb3Y++Fjr5Tr3834qIwbdsA06SyfhEDTxtfhkhoyy+Mmiq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="250975094"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="250975094"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="509990862"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Apr 2022 21:30:24 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngfVP-0005LI-QN;
        Tue, 19 Apr 2022 04:30:23 +0000
Date:   Tue, 19 Apr 2022 12:30:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        johannes@sipsolutions.net
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] cfg80211: Add support for sending more than two AKMs in
 crypto settings
Message-ID: <202204191244.ExffeoFU-lkp@intel.com>
References: <1650284612-14801-1-git-send-email-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650284612-14801-1-git-send-email-quic_vjakkam@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Veerendranath,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main v5.18-rc3 next-20220414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Veerendranath-Jakkam/cfg80211-Add-support-for-sending-more-than-two-AKMs-in-crypto-settings/20220418-203101
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220419/202204191244.ExffeoFU-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a90fd9fa52075529ae10224239a5b2c1ce156e34
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Veerendranath-Jakkam/cfg80211-Add-support-for-sending-more-than-two-AKMs-in-crypto-settings/20220418-203101
        git checkout a90fd9fa52075529ae10224239a5b2c1ce156e34
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:26,
                    from include/linux/skbuff.h:13,
                    from drivers/net/wireless/quantenna/qtnfmac/commands.c:5:
   drivers/net/wireless/quantenna/qtnfmac/commands.c: In function 'qtnf_cmd_send_connect':
>> drivers/net/wireless/quantenna/qtnfmac/commands.c:2138:54: error: 's' undeclared (first use in this function)
    2138 |         for (i = 0; i < min(QLINK_MAX_NR_AKM_SUITES, s->crypto.n_akm_suites);
         |                                                      ^
   include/linux/minmax.h:20:46: note: in definition of macro '__typecheck'
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                              ^
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   drivers/net/wireless/quantenna/qtnfmac/commands.c:2138:25: note: in expansion of macro 'min'
    2138 |         for (i = 0; i < min(QLINK_MAX_NR_AKM_SUITES, s->crypto.n_akm_suites);
         |                         ^~~
   drivers/net/wireless/quantenna/qtnfmac/commands.c:2138:54: note: each undeclared identifier is reported only once for each function it appears in
    2138 |         for (i = 0; i < min(QLINK_MAX_NR_AKM_SUITES, s->crypto.n_akm_suites);
         |                                                      ^
   include/linux/minmax.h:20:46: note: in definition of macro '__typecheck'
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                              ^
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   drivers/net/wireless/quantenna/qtnfmac/commands.c:2138:25: note: in expansion of macro 'min'
    2138 |         for (i = 0; i < min(QLINK_MAX_NR_AKM_SUITES, s->crypto.n_akm_suites);
         |                         ^~~
>> include/linux/minmax.h:36:9: error: first argument to '__builtin_choose_expr' not a constant
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   drivers/net/wireless/quantenna/qtnfmac/commands.c:2138:25: note: in expansion of macro 'min'
    2138 |         for (i = 0; i < min(QLINK_MAX_NR_AKM_SUITES, s->crypto.n_akm_suites);
         |                         ^~~


vim +/s +2138 drivers/net/wireless/quantenna/qtnfmac/commands.c

  2071	
  2072	int qtnf_cmd_send_connect(struct qtnf_vif *vif,
  2073				  struct cfg80211_connect_params *sme)
  2074	{
  2075		struct sk_buff *cmd_skb;
  2076		struct qlink_cmd_connect *cmd;
  2077		struct qlink_auth_encr *aen;
  2078		int ret;
  2079		int i;
  2080		u32 connect_flags = 0;
  2081	
  2082		cmd_skb = qtnf_cmd_alloc_new_cmdskb(vif->mac->macid, vif->vifid,
  2083						    QLINK_CMD_CONNECT,
  2084						    sizeof(*cmd));
  2085		if (!cmd_skb)
  2086			return -ENOMEM;
  2087	
  2088		cmd = (struct qlink_cmd_connect *)cmd_skb->data;
  2089	
  2090		ether_addr_copy(cmd->bssid, vif->bssid);
  2091	
  2092		if (sme->bssid_hint)
  2093			ether_addr_copy(cmd->bssid_hint, sme->bssid_hint);
  2094		else
  2095			eth_zero_addr(cmd->bssid_hint);
  2096	
  2097		if (sme->prev_bssid)
  2098			ether_addr_copy(cmd->prev_bssid, sme->prev_bssid);
  2099		else
  2100			eth_zero_addr(cmd->prev_bssid);
  2101	
  2102		if ((sme->bg_scan_period >= 0) &&
  2103		    (sme->bg_scan_period <= SHRT_MAX))
  2104			cmd->bg_scan_period = cpu_to_le16(sme->bg_scan_period);
  2105		else
  2106			cmd->bg_scan_period = cpu_to_le16(-1); /* use default value */
  2107	
  2108		if (sme->flags & ASSOC_REQ_DISABLE_HT)
  2109			connect_flags |= QLINK_STA_CONNECT_DISABLE_HT;
  2110		if (sme->flags & ASSOC_REQ_DISABLE_VHT)
  2111			connect_flags |= QLINK_STA_CONNECT_DISABLE_VHT;
  2112		if (sme->flags & ASSOC_REQ_USE_RRM)
  2113			connect_flags |= QLINK_STA_CONNECT_USE_RRM;
  2114	
  2115		cmd->flags = cpu_to_le32(connect_flags);
  2116		memcpy(&cmd->ht_capa, &sme->ht_capa, sizeof(cmd->ht_capa));
  2117		memcpy(&cmd->ht_capa_mask, &sme->ht_capa_mask,
  2118		       sizeof(cmd->ht_capa_mask));
  2119		memcpy(&cmd->vht_capa, &sme->vht_capa, sizeof(cmd->vht_capa));
  2120		memcpy(&cmd->vht_capa_mask, &sme->vht_capa_mask,
  2121		       sizeof(cmd->vht_capa_mask));
  2122		cmd->pbss = sme->pbss;
  2123	
  2124		aen = &cmd->aen;
  2125		aen->auth_type = sme->auth_type;
  2126		aen->privacy = !!sme->privacy;
  2127		cmd->mfp = sme->mfp;
  2128		aen->wpa_versions = cpu_to_le32(sme->crypto.wpa_versions);
  2129		aen->cipher_group = cpu_to_le32(sme->crypto.cipher_group);
  2130		aen->n_ciphers_pairwise = cpu_to_le32(sme->crypto.n_ciphers_pairwise);
  2131	
  2132		for (i = 0; i < QLINK_MAX_NR_CIPHER_SUITES; i++)
  2133			aen->ciphers_pairwise[i] =
  2134				cpu_to_le32(sme->crypto.ciphers_pairwise[i]);
  2135	
  2136		aen->n_akm_suites = cpu_to_le32(sme->crypto.n_akm_suites);
  2137	
> 2138		for (i = 0; i < min(QLINK_MAX_NR_AKM_SUITES, s->crypto.n_akm_suites);
  2139		     i++)
  2140			aen->akm_suites[i] = cpu_to_le32(sme->crypto.akm_suites[i]);
  2141	
  2142		aen->control_port = sme->crypto.control_port;
  2143		aen->control_port_no_encrypt =
  2144			sme->crypto.control_port_no_encrypt;
  2145		aen->control_port_ethertype =
  2146			cpu_to_le16(be16_to_cpu(sme->crypto.control_port_ethertype));
  2147	
  2148		qtnf_cmd_skb_put_tlv_arr(cmd_skb, WLAN_EID_SSID, sme->ssid,
  2149					 sme->ssid_len);
  2150	
  2151		if (sme->ie_len != 0)
  2152			qtnf_cmd_tlv_ie_set_add(cmd_skb, QLINK_IE_SET_ASSOC_REQ,
  2153						sme->ie, sme->ie_len);
  2154	
  2155		if (sme->channel)
  2156			qtnf_cmd_channel_tlv_add(cmd_skb, sme->channel);
  2157	
  2158		qtnf_bus_lock(vif->mac->bus);
  2159		ret = qtnf_cmd_send(vif->mac->bus, cmd_skb);
  2160		qtnf_bus_unlock(vif->mac->bus);
  2161	
  2162		return ret;
  2163	}
  2164	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
