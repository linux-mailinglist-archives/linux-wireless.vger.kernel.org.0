Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D125E78EB
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Sep 2022 12:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIWK7y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Sep 2022 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiIWK7w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Sep 2022 06:59:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD77220CE
        for <linux-wireless@vger.kernel.org>; Fri, 23 Sep 2022 03:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663930789; x=1695466789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d4A1iWvp56WwfP/u1qlw9ipegonJUxCLzIyr4qnq9ug=;
  b=S0Tp1B0PCY6JSzL+dPoCCoeRGLsd7nw4LKzQNPituWRhT4RJFXKRjmTn
   7ukkoifX6h63bc49uk1RsYYms/P7reNT0gD2LLAfPTELwigiGVClunLHU
   hFW4ZI53d1dV5i4MhGgiaPeo0CgCr17GA/btv7s+zMD/Pc+T6HWzVTpRC
   pP+DnfRuewM1L57U+f5XZaEMPlkKWrCgGyWEhRPHJesA7eXVLudy7gTVg
   SaRuxMJy5JDg+h+tLXNO9RFhTGhHZxZwX2sy7l+68SLyxsmqHdGShDHrQ
   mmuBOpd4SiV57yjNvEfUkFlKwo9046t8cVKCnpaeZTxbjBgmWcBYFwxE8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362379559"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="362379559"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 03:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="795470906"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Sep 2022 03:59:46 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obgPJ-0005b6-2G;
        Fri, 23 Sep 2022 10:59:45 +0000
Date:   Fri, 23 Sep 2022 18:59:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ian Lin <ian.lin@infineon.com>, linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        Double.Lo@infineon.com, ian.lin@infineon.com
Subject: Re: [PATCH v2 4/5] brcmfmac: Update SSID of hidden AP while
 informing its bss to cfg80211 layer
Message-ID: <202209231808.8r6Ydw4M-lkp@intel.com>
References: <20220922104229.12119-5-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922104229.12119-5-ian.lin@infineon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Lin/Fix-connect-p2p-issue-series/20220922-184424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220923/202209231808.8r6Ydw4M-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/620f981fff55c74cd1fa86e5b6c177d51344f654
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ian-Lin/Fix-connect-p2p-issue-series/20220922-184424
        git checkout 620f981fff55c74cd1fa86e5b6c177d51344f654
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_inform_single_bss':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3039:28: warning: passing argument 1 of 'memcpy' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    3039 |                 memcpy(ssid->data, bi->SSID, bi->SSID_len);
         |                        ~~~~^~~~~~
   In file included from include/linux/string.h:20,
                    from include/linux/uuid.h:12,
                    from include/linux/mod_devicetable.h:13,
                    from arch/parisc/include/asm/hardware.h:5,
                    from arch/parisc/include/asm/processor.h:17,
                    from arch/parisc/include/asm/spinlock.h:7,
                    from arch/parisc/include/asm/atomic.h:22,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:22,
                    from drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:8:
   arch/parisc/include/asm/string.h:9:22: note: expected 'void *' but argument is of type 'const u8 *' {aka 'const unsigned char *'}
       9 | void * memcpy(void * dest,const void *src,size_t count);
         |               ~~~~~~~^~~~


vim +3039 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c

  2990	
  2991	static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
  2992					   struct brcmf_bss_info_le *bi)
  2993	{
  2994		struct wiphy *wiphy = cfg_to_wiphy(cfg);
  2995		struct brcmf_pub *drvr = cfg->pub;
  2996		struct cfg80211_bss *bss;
  2997		enum nl80211_band band;
  2998		struct brcmu_chan ch;
  2999		u16 channel;
  3000		u32 freq;
  3001		u16 notify_capability;
  3002		u16 notify_interval;
  3003		u8 *notify_ie;
  3004		size_t notify_ielen;
  3005		struct cfg80211_inform_bss bss_data = {};
  3006		const struct brcmf_tlv *ssid = NULL;
  3007	
  3008		if (le32_to_cpu(bi->length) > WL_BSS_INFO_MAX) {
  3009			bphy_err(drvr, "Bss info is larger than buffer. Discarding\n");
  3010			return -EINVAL;
  3011		}
  3012	
  3013		if (!bi->ctl_ch) {
  3014			ch.chspec = le16_to_cpu(bi->chanspec);
  3015			cfg->d11inf.decchspec(&ch);
  3016			bi->ctl_ch = ch.control_ch_num;
  3017		}
  3018		channel = bi->ctl_ch;
  3019	
  3020		if (channel <= CH_MAX_2G_CHANNEL)
  3021			band = NL80211_BAND_2GHZ;
  3022		else
  3023			band = NL80211_BAND_5GHZ;
  3024	
  3025		freq = ieee80211_channel_to_frequency(channel, band);
  3026		bss_data.chan = ieee80211_get_channel(wiphy, freq);
  3027		bss_data.scan_width = NL80211_BSS_CHAN_WIDTH_20;
  3028		bss_data.boottime_ns = ktime_to_ns(ktime_get_boottime());
  3029	
  3030		notify_capability = le16_to_cpu(bi->capability);
  3031		notify_interval = le16_to_cpu(bi->beacon_period);
  3032		notify_ie = (u8 *)bi + le16_to_cpu(bi->ie_offset);
  3033		notify_ielen = le32_to_cpu(bi->ie_length);
  3034		bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
  3035	
  3036		ssid = brcmf_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID);
  3037		if (ssid && ssid->data[0] == '\0' && ssid->len == bi->SSID_len) {
  3038			/* Update SSID for hidden AP */
> 3039			memcpy(ssid->data, bi->SSID, bi->SSID_len);
  3040		}
  3041	
  3042		brcmf_dbg(CONN, "bssid: %pM\n", bi->BSSID);
  3043		brcmf_dbg(CONN, "Channel: %d(%d)\n", channel, freq);
  3044		brcmf_dbg(CONN, "Capability: %X\n", notify_capability);
  3045		brcmf_dbg(CONN, "Beacon interval: %d\n", notify_interval);
  3046		brcmf_dbg(CONN, "Signal: %d\n", bss_data.signal);
  3047	
  3048		bss = cfg80211_inform_bss_data(wiphy, &bss_data,
  3049					       CFG80211_BSS_FTYPE_UNKNOWN,
  3050					       (const u8 *)bi->BSSID,
  3051					       0, notify_capability,
  3052					       notify_interval, notify_ie,
  3053					       notify_ielen, GFP_KERNEL);
  3054	
  3055		if (!bss)
  3056			return -ENOMEM;
  3057	
  3058		cfg80211_put_bss(wiphy, bss);
  3059	
  3060		return 0;
  3061	}
  3062	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
