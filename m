Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52E94DA649
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 00:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352592AbiCOXae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 19:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352580AbiCOXae (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 19:30:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C325DA54
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 16:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647386960; x=1678922960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pLU3fgQDOl761oyzZOf4a58KHnznTKBPdCDbFIat1J8=;
  b=ndD97YEJcmMDzUvELgXU788SQIZi7VDek63/zONNqgg4GEg6pvbvz0W5
   spliwtBoYeZZE3DCpYZF4Ilmf6Wc5+wl2f6cH1LBE6BjgScSiSuGfot1C
   h1NbrbuBkhQmNcru3cwnHPJNRcFhyZxnq84WDMef/dLKviWZhX/2hS2/o
   sq3UyDrnrR2wM+PcmaDdVoLkD2rOGSV3XoqLr2/gBvEt6Tw9SGFP123WD
   XnNoa5q74y15IfPixCgNySO57qYPhvwnv6zIjfX06McfCGmUUTqVLHeya
   6t8m2khPhqtGlmtywZtkoD4RkETmRSCiPGkF1wXVhB+BWwXJgoWOmsl4L
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319663015"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="319663015"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 16:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="580697060"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Mar 2022 16:29:18 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUGbN-000BdT-Hl; Tue, 15 Mar 2022 23:29:17 +0000
Date:   Wed, 16 Mar 2022 07:28:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        money.wang@mediatek.com, evelyn.tsai@mediatek.com
Subject: Re: [PATCH v2] mt76: mt7915: introduce 802.11ax multi-bss support
Message-ID: <202203160706.VipMbRpV-lkp@intel.com>
References: <de8955efb254ae54ed9e1b7883ad2b067ae34d0f.1647346612.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de8955efb254ae54ed9e1b7883ad2b067ae34d0f.1647346612.git.lorenzo@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

I love your patch! Yet something to improve:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on next-20220315]
[cannot apply to wireless/main v5.17-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Lorenzo-Bianconi/mt76-mt7915-introduce-802-11ax-multi-bss-support/20220315-202139
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220316/202203160706.VipMbRpV-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4887429a54676d58b10bf3d73377cd24b4a455bb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Lorenzo-Bianconi/mt76-mt7915-introduce-802-11ax-multi-bss-support/20220315-202139
        git checkout 4887429a54676d58b10bf3d73377cd24b4a455bb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/net/mac80211.h:20,
                    from drivers/net/wireless/mediatek/mt76/mt7915/../mt76.h:16,
                    from drivers/net/wireless/mediatek/mt76/mt7915/../mt76_connac.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h:9,
                    from drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:6:
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c: In function 'mt7915_mcu_beacon_mbss':
>> drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1834:44: error: 'struct ieee80211_mutable_offsets' has no member named 'mbssid_off'
    1834 |                             &skb->data[offs->mbssid_off],
         |                                            ^~
   include/linux/ieee80211.h:4263:47: note: in definition of macro 'for_each_element'
    4263 |         for (_elem = (const struct element *)(_data);                   \
         |                                               ^~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1833:9: note: in expansion of macro 'for_each_element_id'
    1833 |         for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1834:44: error: 'struct ieee80211_mutable_offsets' has no member named 'mbssid_off'
    1834 |                             &skb->data[offs->mbssid_off],
         |                                            ^~
   include/linux/ieee80211.h:4264:27: note: in definition of macro 'for_each_element'
    4264 |              (const u8 *)(_data) + (_datalen) - (const u8 *)_elem >=    \
         |                           ^~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1833:9: note: in expansion of macro 'for_each_element_id'
    1833 |         for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID,
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1835:44: error: 'struct ieee80211_mutable_offsets' has no member named 'mbssid_off'
    1835 |                             skb->len - offs->mbssid_off) {
         |                                            ^~
   include/linux/ieee80211.h:4264:37: note: in definition of macro 'for_each_element'
    4264 |              (const u8 *)(_data) + (_datalen) - (const u8 *)_elem >=    \
         |                                     ^~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1833:9: note: in expansion of macro 'for_each_element_id'
    1833 |         for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1834:44: error: 'struct ieee80211_mutable_offsets' has no member named 'mbssid_off'
    1834 |                             &skb->data[offs->mbssid_off],
         |                                            ^~
   include/linux/ieee80211.h:4266:27: note: in definition of macro 'for_each_element'
    4266 |              (const u8 *)(_data) + (_datalen) - (const u8 *)_elem >=    \
         |                           ^~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1833:9: note: in expansion of macro 'for_each_element_id'
    1833 |         for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID,
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1835:44: error: 'struct ieee80211_mutable_offsets' has no member named 'mbssid_off'
    1835 |                             skb->len - offs->mbssid_off) {
         |                                            ^~
   include/linux/ieee80211.h:4266:37: note: in definition of macro 'for_each_element'
    4266 |              (const u8 *)(_data) + (_datalen) - (const u8 *)_elem >=    \
         |                                     ^~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1833:9: note: in expansion of macro 'for_each_element_id'
    1833 |         for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID,
         |         ^~~~~~~~~~~~~~~~~~~


vim +1834 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c

  1812	
  1813	static void
  1814	mt7915_mcu_beacon_mbss(struct sk_buff *rskb, struct sk_buff *skb,
  1815			       struct ieee80211_vif *vif, struct bss_info_bcn *bcn,
  1816			       struct ieee80211_mutable_offsets *offs)
  1817	{
  1818		struct bss_info_bcn_mbss *mbss;
  1819		const struct element *elem;
  1820		struct tlv *tlv;
  1821	
  1822		if (!vif->bss_conf.bssid_indicator)
  1823			return;
  1824	
  1825		tlv = mt7915_mcu_add_nested_subtlv(rskb, BSS_INFO_BCN_MBSSID,
  1826						   sizeof(*mbss), &bcn->sub_ntlv,
  1827						   &bcn->len);
  1828	
  1829		mbss = (struct bss_info_bcn_mbss *)tlv;
  1830		mbss->offset[0] = cpu_to_le16(offs->tim_offset);
  1831		mbss->bitmap = cpu_to_le32(1);
  1832	
  1833		for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID,
> 1834				    &skb->data[offs->mbssid_off],
  1835				    skb->len - offs->mbssid_off) {
  1836			const struct element *sub_elem;
  1837	
  1838			if (elem->datalen < 2)
  1839				continue;
  1840	
  1841			for_each_element(sub_elem, elem->data + 1, elem->datalen - 1) {
  1842				const u8 *data;
  1843	
  1844				if (sub_elem->id || sub_elem->datalen < 4)
  1845					continue; /* not a valid BSS profile */
  1846	
  1847				/* Find WLAN_EID_MULTI_BSSID_IDX
  1848				 * in the merged nontransmitted profile
  1849				 */
  1850				data = cfg80211_find_ie(WLAN_EID_MULTI_BSSID_IDX,
  1851							sub_elem->data,
  1852							sub_elem->datalen);
  1853				if (!data || data[1] < 1 || !data[2])
  1854					continue;
  1855	
  1856				mbss->offset[data[2]] = cpu_to_le16(data - skb->data);
  1857				mbss->bitmap |= cpu_to_le32(BIT(data[2]));
  1858			}
  1859		}
  1860	}
  1861	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
