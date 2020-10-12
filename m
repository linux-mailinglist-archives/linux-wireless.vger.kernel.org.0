Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CE528BEC8
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404104AbgJLRIx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 13:08:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:2417 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404100AbgJLRIu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 13:08:50 -0400
IronPort-SDR: O0DkNIvIb2DNZY8KEjm94y+rLtzP7MnxcxcsFJLEgYS54FPmjDWWD+Vjxcs68oJ7cmz7yg2q9d
 Hogro2V+XAjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="162306474"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="gz'50?scan'50,208,50";a="162306474"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 10:08:47 -0700
IronPort-SDR: 0uz4dfNEESO0DwNWEO7wB/Zz67ZjTd6vLX+pER3F5vmlXe3llBuSR05VVtZJY8XXf+1RW8yeal
 i9NP+7m5gyuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="gz'50?scan'50,208,50";a="299283386"
Received: from lkp-server01.sh.intel.com (HELO aa1d92d39b27) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2020 10:08:44 -0700
Received: from kbuild by aa1d92d39b27 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kS1JT-00004K-Sr; Mon, 12 Oct 2020 17:08:43 +0000
Date:   Tue, 13 Oct 2020 01:08:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shay Bar <shay.bar@celeno.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-wireless@vger.kernel.org, eliav.farber@celeno.com,
        aviad.brikman@celeno.com
Subject: Re: [PATCH] mac80211: 160MHz support per IEEE802.11ax standard
Message-ID: <202010130121.OiG87AVc-lkp@intel.com>
References: <20201012141808.22284-1-shay.bar@celeno.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20201012141808.22284-1-shay.bar@celeno.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shay,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mac80211-next/master]
[also build test WARNING on mac80211/master v5.9 next-20201012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shay-Bar/mac80211-160MHz-support-per-IEEE802-11ax-standard/20201012-221911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
config: riscv-randconfig-r006-20201012 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 9e72d3eaf38f217698f72cb8fdc969a6e72dad3a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/13bd6eb21625512094cdded5c24e9dd314fb00b7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Shay-Bar/mac80211-160MHz-support-per-IEEE802-11ax-standard/20201012-221911
        git checkout 13bd6eb21625512094cdded5c24e9dd314fb00b7
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

                                                                           ~~~~~~~~~~ ^
   arch/riscv/include/asm/mmio.h:87:48: note: expanded from macro 'readb_cpu'
   #define readb_cpu(c)            ({ u8  __r = __raw_readb(c); __r; })
                                                            ^
   In file included from net/mac80211/spectmgmt.c:15:
   In file included from include/linux/ieee80211.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:564:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return inw(addr);
                  ^~~~~~~~~
   arch/riscv/include/asm/io.h:55:76: note: expanded from macro 'inw'
   #define inw(c)          ({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
                                                                           ~~~~~~~~~~ ^
   arch/riscv/include/asm/mmio.h:88:76: note: expanded from macro 'readw_cpu'
   #define readw_cpu(c)            ({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
                                                                                        ^
   include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from net/mac80211/spectmgmt.c:15:
   In file included from include/linux/ieee80211.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:572:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return inl(addr);
                  ^~~~~~~~~
   arch/riscv/include/asm/io.h:56:76: note: expanded from macro 'inl'
   #define inl(c)          ({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
                                                                           ~~~~~~~~~~ ^
   arch/riscv/include/asm/mmio.h:89:76: note: expanded from macro 'readl_cpu'
   #define readl_cpu(c)            ({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
                                                                                        ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from net/mac80211/spectmgmt.c:15:
   In file included from include/linux/ieee80211.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:580:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outb(value, addr);
           ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:58:68: note: expanded from macro 'outb'
   #define outb(v,c)       ({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
                                                                 ~~~~~~~~~~ ^
   arch/riscv/include/asm/mmio.h:91:52: note: expanded from macro 'writeb_cpu'
   #define writeb_cpu(v, c)        ((void)__raw_writeb((v), (c)))
                                                             ^
   In file included from net/mac80211/spectmgmt.c:15:
   In file included from include/linux/ieee80211.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:588:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outw(value, addr);
           ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:59:68: note: expanded from macro 'outw'
   #define outw(v,c)       ({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
                                                                 ~~~~~~~~~~ ^
   arch/riscv/include/asm/mmio.h:92:76: note: expanded from macro 'writew_cpu'
   #define writew_cpu(v, c)        ((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
                                                                                     ^
   In file included from net/mac80211/spectmgmt.c:15:
   In file included from include/linux/ieee80211.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:596:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outl(value, addr);
           ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:60:68: note: expanded from macro 'outl'
   #define outl(v,c)       ({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
                                                                 ~~~~~~~~~~ ^
   arch/riscv/include/asm/mmio.h:93:76: note: expanded from macro 'writel_cpu'
   #define writel_cpu(v, c)        ((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
                                                                                     ^
   In file included from net/mac80211/spectmgmt.c:15:
   In file included from include/linux/ieee80211.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:1017:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> net/mac80211/spectmgmt.c:22:30: warning: no previous prototype for function 'ieee80211_vht_get_actual_chwidth' [-Wmissing-prototypes]
   enum ieee80211_vht_chanwidth ieee80211_vht_get_actual_chwidth(u8 vht_oper_bw,
                                ^
   net/mac80211/spectmgmt.c:22:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   enum ieee80211_vht_chanwidth ieee80211_vht_get_actual_chwidth(u8 vht_oper_bw,
   ^
   static 
>> net/mac80211/spectmgmt.c:49:1: warning: no previous prototype for function 'ieee80211_get_center_freq_seg1_location' [-Wmissing-prototypes]
   ieee80211_get_center_freq_seg1_location(struct ieee80211_sub_if_data *sdata,
   ^
   net/mac80211/spectmgmt.c:48:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   enum ieee80211_center_freq_seg1_location
   ^
   static 
   9 warnings generated.

vim +/ieee80211_vht_get_actual_chwidth +22 net/mac80211/spectmgmt.c

    21	
  > 22	enum ieee80211_vht_chanwidth ieee80211_vht_get_actual_chwidth(u8 vht_oper_bw,
    23								      u32 seg0,
    24								      u32 seg1)
    25	{
    26		enum ieee80211_vht_chanwidth ret = IEEE80211_VHT_CHANWIDTH_USE_HT;
    27	
    28		if (vht_oper_bw != IEEE80211_VHT_CHANWIDTH_80MHZ)
    29			return vht_oper_bw;
    30	
    31		if (!seg1) {
    32			return IEEE80211_VHT_CHANWIDTH_80MHZ;
    33		} else {
    34			int diff;
    35	
    36			diff = abs((int) seg0 - (int) seg1);
    37	
    38			if (diff == 8)
    39				return IEEE80211_VHT_CHANWIDTH_160MHZ;
    40	
    41			if (diff > 16)
    42				return IEEE80211_VHT_CHANWIDTH_80P80MHZ;
    43		}
    44	
    45		return ret;
    46	}
    47	
    48	enum ieee80211_center_freq_seg1_location
  > 49	ieee80211_get_center_freq_seg1_location(struct ieee80211_sub_if_data *sdata,
    50						u32 vht_cap_info,
    51						u8 actual_chanwidth)
    52	{
    53		u8 ext_nss_bw_supp = (vht_cap_info &
    54				      IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) >>
    55				      IEEE80211_VHT_CAP_EXT_NSS_BW_SHIFT;
    56		u8 supp_chwidth = (vht_cap_info &
    57				   IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) >>
    58				   IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_SHIFT;
    59		enum ieee80211_center_freq_seg1_location res =
    60						IEEE80211_CENTER_FREQ_SEG1_NONE;
    61	
    62		/* The bandwidth is less than 80+80/160MHz */
    63		if (actual_chanwidth < IEEE80211_VHT_CHANWIDTH_160MHZ)
    64			return IEEE80211_CENTER_FREQ_SEG1_NONE;
    65	
    66		switch (supp_chwidth) {
    67		case 0:
    68			if ((ext_nss_bw_supp > 1) ||
    69			    ((ext_nss_bw_supp == 1) &&
    70			     (actual_chanwidth == IEEE80211_VHT_CHANWIDTH_160MHZ)))
    71				res = IEEE80211_CENTER_FREQ_SEG1_HT_OPER; /* CCFS2 */
    72			break;
    73		case 1:
    74			if ((ext_nss_bw_supp > 2) ||
    75			    (actual_chanwidth == IEEE80211_VHT_CHANWIDTH_160MHZ))
    76				res = IEEE80211_CENTER_FREQ_SEG1_VHT_OPER; /* CCFS1 */
    77			else if (ext_nss_bw_supp > 0)
    78				res = IEEE80211_CENTER_FREQ_SEG1_HT_OPER; /* CCFS2 */
    79			break;
    80		case 2:
    81			res = IEEE80211_CENTER_FREQ_SEG1_VHT_OPER;
    82			if ((ext_nss_bw_supp > 0) && (ext_nss_bw_supp < 3))
    83				sdata_info(sdata,
    84					   "Invalid ext_nss_bw_supp %u for chwidth 2",
    85					   ext_nss_bw_supp);
    86			break;
    87		default:
    88			break;
    89		}
    90	
    91		return res;
    92	}
    93	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--UugvWAfsgieZRqgk
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--UugvWAfsgieZRqgk--
