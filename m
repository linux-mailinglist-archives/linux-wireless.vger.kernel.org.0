Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85176456AD0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 08:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhKSHUq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 02:20:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:40049 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233682AbhKSHUq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 02:20:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="221587733"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="gz'50?scan'50,208,50";a="221587733"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 23:17:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="gz'50?scan'50,208,50";a="587639353"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2021 23:17:42 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mny9V-0004De-RA; Fri, 19 Nov 2021 07:17:41 +0000
Date:   Fri, 19 Nov 2021 15:16:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH 7/8] mt76: mt7915: add support for tx-overrides
Message-ID: <202111191516.6QAZ0itw-lkp@intel.com>
References: <20211118164549.3863-7-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20211118164549.3863-7-greearb@candelatech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kvalo-wireless-drivers-next/master]
[also build test ERROR on v5.16-rc1 next-20211118]
[cannot apply to kvalo-wireless-drivers/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/greearb-candelatech-com/mt76-mt7915-cache-sgi-in-wcid/20211119-005421
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
config: microblaze-buildonly-randconfig-r005-20211119 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c742cd1ffffaeff7ab79835466b08fd5616cdce3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review greearb-candelatech-com/mt76-mt7915-cache-sgi-in-wcid/20211119-005421
        git checkout c742cd1ffffaeff7ab79835466b08fd5616cdce3
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/net/wireless/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7915/mac.c: In function 'mt7915_mac_write_txwi_tm':
>> drivers/net/wireless/mediatek/mt76/mt7915/mac.c:778:37: error: 'struct mt76_phy' has no member named 'test'
     778 |                 if (skb != phy->mt76->test.tx_skb)
         |                                     ^~
   drivers/net/wireless/mediatek/mt76/mt7915/mac.c:780:32: error: 'struct mt76_phy' has no member named 'test'
     780 |                 td = &phy->mt76->test;
         |                                ^~
   In file included from include/linux/byteorder/little_endian.h:5,
                    from arch/microblaze/include/uapi/asm/byteorder.h:6,
                    from include/asm-generic/bitops/le.h:7,
                    from include/asm-generic/bitops.h:36,
                    from ./arch/microblaze/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:12,
                    from include/linux/skbuff.h:13,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/wireless/mediatek/mt76/mt7915/mac.c:4:
>> drivers/net/wireless/mediatek/mt76/mt7915/mac.c:909:54: error: 'struct mt7915_phy' has no member named 'test'
     909 |                                                   phy->test.spe_idx));
         |                                                      ^~
   include/uapi/linux/byteorder/little_endian.h:33:51: note: in definition of macro '__cpu_to_le32'
      33 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   include/linux/compiler_types.h:310:9: note: in expansion of macro '__compiletime_assert'
     310 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:17: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/mac.c:908:40: note: in expansion of macro 'FIELD_PREP'
     908 |                 txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX,
         |                                        ^~~~~~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7915/mac.c:909:54: error: 'struct mt7915_phy' has no member named 'test'
     909 |                                                   phy->test.spe_idx));
         |                                                      ^~
   include/uapi/linux/byteorder/little_endian.h:33:51: note: in definition of macro '__cpu_to_le32'
      33 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   include/linux/compiler_types.h:310:9: note: in expansion of macro '__compiletime_assert'
     310 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:17: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/mac.c:908:40: note: in expansion of macro 'FIELD_PREP'
     908 |                 txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX,
         |                                        ^~~~~~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7915/mac.c:909:54: error: 'struct mt7915_phy' has no member named 'test'
     909 |                                                   phy->test.spe_idx));
         |                                                      ^~
   include/uapi/linux/byteorder/little_endian.h:33:51: note: in definition of macro '__cpu_to_le32'
      33 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   drivers/net/wireless/mediatek/mt76/mt7915/mac.c:908:40: note: in expansion of macro 'FIELD_PREP'
     908 |                 txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX,
         |                                        ^~~~~~~~~~
   At top level:
   drivers/net/wireless/mediatek/mt76/mt7915/mac.c:760:1: warning: 'mt7915_mac_write_txwi_tm' defined but not used [-Wunused-function]
     760 | mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, struct mt76_wcid *wcid, __le32 *txwi,
         | ^~~~~~~~~~~~~~~~~~~~~~~~


vim +778 drivers/net/wireless/mediatek/mt76/mt7915/mac.c

5d8a83f0994134 Shayne Chen 2020-10-22  758  
aadf09537c575d Shayne Chen 2020-10-22  759  static void
c742cd1ffffaef Ben Greear  2021-11-18  760  mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, struct mt76_wcid *wcid, __le32 *txwi,
c918c74d06457e Shayne Chen 2020-12-04  761  			 struct sk_buff *skb)
aadf09537c575d Shayne Chen 2020-10-22  762  {
c742cd1ffffaef Ben Greear  2021-11-18  763  	struct mt76_testmode_data *td;
cc91747be98f2a Shayne Chen 2021-04-12  764  	const struct ieee80211_rate *r;
c742cd1ffffaef Ben Greear  2021-11-18  765  	struct mt7915_sta *msta;
c742cd1ffffaef Ben Greear  2021-11-18  766  	u8 bw, mode, nss;
c742cd1ffffaef Ben Greear  2021-11-18  767  	u8 rate_idx;
aadf09537c575d Shayne Chen 2020-10-22  768  	u16 rateval = 0;
aadf09537c575d Shayne Chen 2020-10-22  769  	u32 val;
cc91747be98f2a Shayne Chen 2021-04-12  770  	bool cck = false;
cc91747be98f2a Shayne Chen 2021-04-12  771  	int band;
aadf09537c575d Shayne Chen 2020-10-22  772  
c742cd1ffffaef Ben Greear  2021-11-18  773  	msta = container_of(wcid, struct mt7915_sta, wcid);
c742cd1ffffaef Ben Greear  2021-11-18  774  
c742cd1ffffaef Ben Greear  2021-11-18  775  	if (msta->test.txo_active) {
c742cd1ffffaef Ben Greear  2021-11-18  776  		td = &msta->test;
c742cd1ffffaef Ben Greear  2021-11-18  777  	} else {
c918c74d06457e Shayne Chen 2020-12-04 @778  		if (skb != phy->mt76->test.tx_skb)
aadf09537c575d Shayne Chen 2020-10-22  779  			return;
c742cd1ffffaef Ben Greear  2021-11-18  780  		td = &phy->mt76->test;
c742cd1ffffaef Ben Greear  2021-11-18  781  	}
c742cd1ffffaef Ben Greear  2021-11-18  782  
c742cd1ffffaef Ben Greear  2021-11-18  783  	nss = td->tx_rate_nss;
c742cd1ffffaef Ben Greear  2021-11-18  784  	rate_idx = td->tx_rate_idx;
aadf09537c575d Shayne Chen 2020-10-22  785  
aadf09537c575d Shayne Chen 2020-10-22  786  	switch (td->tx_rate_mode) {
aadf09537c575d Shayne Chen 2020-10-22  787  	case MT76_TM_TX_MODE_HT:
aadf09537c575d Shayne Chen 2020-10-22  788  		nss = 1 + (rate_idx >> 3);
aadf09537c575d Shayne Chen 2020-10-22  789  		mode = MT_PHY_TYPE_HT;
aadf09537c575d Shayne Chen 2020-10-22  790  		break;
aadf09537c575d Shayne Chen 2020-10-22  791  	case MT76_TM_TX_MODE_VHT:
aadf09537c575d Shayne Chen 2020-10-22  792  		mode = MT_PHY_TYPE_VHT;
aadf09537c575d Shayne Chen 2020-10-22  793  		break;
aadf09537c575d Shayne Chen 2020-10-22  794  	case MT76_TM_TX_MODE_HE_SU:
aadf09537c575d Shayne Chen 2020-10-22  795  		mode = MT_PHY_TYPE_HE_SU;
aadf09537c575d Shayne Chen 2020-10-22  796  		break;
aadf09537c575d Shayne Chen 2020-10-22  797  	case MT76_TM_TX_MODE_HE_EXT_SU:
aadf09537c575d Shayne Chen 2020-10-22  798  		mode = MT_PHY_TYPE_HE_EXT_SU;
aadf09537c575d Shayne Chen 2020-10-22  799  		break;
aadf09537c575d Shayne Chen 2020-10-22  800  	case MT76_TM_TX_MODE_HE_TB:
aadf09537c575d Shayne Chen 2020-10-22  801  		mode = MT_PHY_TYPE_HE_TB;
aadf09537c575d Shayne Chen 2020-10-22  802  		break;
aadf09537c575d Shayne Chen 2020-10-22  803  	case MT76_TM_TX_MODE_HE_MU:
aadf09537c575d Shayne Chen 2020-10-22  804  		mode = MT_PHY_TYPE_HE_MU;
aadf09537c575d Shayne Chen 2020-10-22  805  		break;
cc91747be98f2a Shayne Chen 2021-04-12  806  	case MT76_TM_TX_MODE_CCK:
cc91747be98f2a Shayne Chen 2021-04-12  807  		cck = true;
cc91747be98f2a Shayne Chen 2021-04-12  808  		fallthrough;
aadf09537c575d Shayne Chen 2020-10-22  809  	case MT76_TM_TX_MODE_OFDM:
cc91747be98f2a Shayne Chen 2021-04-12  810  		band = phy->mt76->chandef.chan->band;
cc91747be98f2a Shayne Chen 2021-04-12  811  		if (band == NL80211_BAND_2GHZ && !cck)
cc91747be98f2a Shayne Chen 2021-04-12  812  			rate_idx += 4;
cc91747be98f2a Shayne Chen 2021-04-12  813  
cc91747be98f2a Shayne Chen 2021-04-12  814  		r = &phy->mt76->hw->wiphy->bands[band]->bitrates[rate_idx];
cc91747be98f2a Shayne Chen 2021-04-12  815  		val = cck ? r->hw_value_short : r->hw_value;
cc91747be98f2a Shayne Chen 2021-04-12  816  
cc91747be98f2a Shayne Chen 2021-04-12  817  		mode = val >> 8;
cc91747be98f2a Shayne Chen 2021-04-12  818  		rate_idx = val & 0xff;
cc91747be98f2a Shayne Chen 2021-04-12  819  		break;
aadf09537c575d Shayne Chen 2020-10-22  820  	default:
aadf09537c575d Shayne Chen 2020-10-22  821  		mode = MT_PHY_TYPE_OFDM;
aadf09537c575d Shayne Chen 2020-10-22  822  		break;
aadf09537c575d Shayne Chen 2020-10-22  823  	}
aadf09537c575d Shayne Chen 2020-10-22  824  
c742cd1ffffaef Ben Greear  2021-11-18  825  	if (msta->test.txo_active) {
c742cd1ffffaef Ben Greear  2021-11-18  826  		bw = td->txbw;
c742cd1ffffaef Ben Greear  2021-11-18  827  	} else {
c918c74d06457e Shayne Chen 2020-12-04  828  		switch (phy->mt76->chandef.width) {
aadf09537c575d Shayne Chen 2020-10-22  829  		case NL80211_CHAN_WIDTH_40:
aadf09537c575d Shayne Chen 2020-10-22  830  			bw = 1;
aadf09537c575d Shayne Chen 2020-10-22  831  			break;
aadf09537c575d Shayne Chen 2020-10-22  832  		case NL80211_CHAN_WIDTH_80:
aadf09537c575d Shayne Chen 2020-10-22  833  			bw = 2;
aadf09537c575d Shayne Chen 2020-10-22  834  			break;
aadf09537c575d Shayne Chen 2020-10-22  835  		case NL80211_CHAN_WIDTH_80P80:
aadf09537c575d Shayne Chen 2020-10-22  836  		case NL80211_CHAN_WIDTH_160:
aadf09537c575d Shayne Chen 2020-10-22  837  			bw = 3;
aadf09537c575d Shayne Chen 2020-10-22  838  			break;
aadf09537c575d Shayne Chen 2020-10-22  839  		default:
aadf09537c575d Shayne Chen 2020-10-22  840  			bw = 0;
aadf09537c575d Shayne Chen 2020-10-22  841  			break;
aadf09537c575d Shayne Chen 2020-10-22  842  		}
c742cd1ffffaef Ben Greear  2021-11-18  843  	}
aadf09537c575d Shayne Chen 2020-10-22  844  
aadf09537c575d Shayne Chen 2020-10-22  845  	if (td->tx_rate_stbc && nss == 1) {
aadf09537c575d Shayne Chen 2020-10-22  846  		nss++;
aadf09537c575d Shayne Chen 2020-10-22  847  		rateval |= MT_TX_RATE_STBC;
aadf09537c575d Shayne Chen 2020-10-22  848  	}
aadf09537c575d Shayne Chen 2020-10-22  849  
aadf09537c575d Shayne Chen 2020-10-22  850  	rateval |= FIELD_PREP(MT_TX_RATE_IDX, rate_idx) |
aadf09537c575d Shayne Chen 2020-10-22  851  		   FIELD_PREP(MT_TX_RATE_MODE, mode) |
aadf09537c575d Shayne Chen 2020-10-22  852  		   FIELD_PREP(MT_TX_RATE_NSS, nss - 1);
aadf09537c575d Shayne Chen 2020-10-22  853  
c742cd1ffffaef Ben Greear  2021-11-18  854  	/* TODO:  Support per-skb txpower, p.15 of txpower doc, DW2 29:24. */
aadf09537c575d Shayne Chen 2020-10-22  855  	txwi[2] |= cpu_to_le32(MT_TXD2_FIX_RATE);
aadf09537c575d Shayne Chen 2020-10-22  856  
c742cd1ffffaef Ben Greear  2021-11-18  857  	/* Looks like this sets tx attempt to exactly 1.
c742cd1ffffaef Ben Greear  2021-11-18  858  	 * TODO:  Use td->tx_xmit_count, if in txo mode.
c742cd1ffffaef Ben Greear  2021-11-18  859  	 */
aadf09537c575d Shayne Chen 2020-10-22  860  	le32p_replace_bits(&txwi[3], 1, MT_TXD3_REM_TX_COUNT);
aadf09537c575d Shayne Chen 2020-10-22  861  	if (td->tx_rate_mode < MT76_TM_TX_MODE_HT)
aadf09537c575d Shayne Chen 2020-10-22  862  		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
aadf09537c575d Shayne Chen 2020-10-22  863  
c742cd1ffffaef Ben Greear  2021-11-18  864  	/* TODO:  Take tx_dynbw into account in txo mode. */
aadf09537c575d Shayne Chen 2020-10-22  865  	val = MT_TXD6_FIXED_BW |
aadf09537c575d Shayne Chen 2020-10-22  866  	      FIELD_PREP(MT_TXD6_BW, bw) |
aadf09537c575d Shayne Chen 2020-10-22  867  	      FIELD_PREP(MT_TXD6_TX_RATE, rateval) |
aadf09537c575d Shayne Chen 2020-10-22  868  	      FIELD_PREP(MT_TXD6_SGI, td->tx_rate_sgi);
aadf09537c575d Shayne Chen 2020-10-22  869  
aadf09537c575d Shayne Chen 2020-10-22  870  	/* for HE_SU/HE_EXT_SU PPDU
aadf09537c575d Shayne Chen 2020-10-22  871  	 * - 1x, 2x, 4x LTF + 0.8us GI
aadf09537c575d Shayne Chen 2020-10-22  872  	 * - 2x LTF + 1.6us GI, 4x LTF + 3.2us GI
aadf09537c575d Shayne Chen 2020-10-22  873  	 * for HE_MU PPDU
aadf09537c575d Shayne Chen 2020-10-22  874  	 * - 2x, 4x LTF + 0.8us GI
aadf09537c575d Shayne Chen 2020-10-22  875  	 * - 2x LTF + 1.6us GI, 4x LTF + 3.2us GI
aadf09537c575d Shayne Chen 2020-10-22  876  	 * for HE_TB PPDU
aadf09537c575d Shayne Chen 2020-10-22  877  	 * - 1x, 2x LTF + 1.6us GI
aadf09537c575d Shayne Chen 2020-10-22  878  	 * - 4x LTF + 3.2us GI
aadf09537c575d Shayne Chen 2020-10-22  879  	 */
aadf09537c575d Shayne Chen 2020-10-22  880  	if (mode >= MT_PHY_TYPE_HE_SU)
aadf09537c575d Shayne Chen 2020-10-22  881  		val |= FIELD_PREP(MT_TXD6_HELTF, td->tx_ltf);
aadf09537c575d Shayne Chen 2020-10-22  882  
cc91747be98f2a Shayne Chen 2021-04-12  883  	if (td->tx_rate_ldpc || (bw > 0 && mode >= MT_PHY_TYPE_HE_SU))
aadf09537c575d Shayne Chen 2020-10-22  884  		val |= MT_TXD6_LDPC;
aadf09537c575d Shayne Chen 2020-10-22  885  
cc91747be98f2a Shayne Chen 2021-04-12  886  	txwi[3] &= ~cpu_to_le32(MT_TXD3_SN_VALID);
aadf09537c575d Shayne Chen 2020-10-22  887  	txwi[6] |= cpu_to_le32(val);
c742cd1ffffaef Ben Greear  2021-11-18  888  
c742cd1ffffaef Ben Greear  2021-11-18  889  	if (msta->test.txo_active) {
c742cd1ffffaef Ben Greear  2021-11-18  890  		/* see mt7915_tm_set_tx_frames */
c742cd1ffffaef Ben Greear  2021-11-18  891  		static const u8 spe_idx_map[] = {0, 0, 1, 0, 3, 2, 4, 0,
c742cd1ffffaef Ben Greear  2021-11-18  892  						 9, 8, 6, 10, 16, 12, 18, 0};
c742cd1ffffaef Ben Greear  2021-11-18  893  		u32 spe_idx;
c742cd1ffffaef Ben Greear  2021-11-18  894  
c742cd1ffffaef Ben Greear  2021-11-18  895  		if (td->tx_spe_idx) {
c742cd1ffffaef Ben Greear  2021-11-18  896  			spe_idx = td->tx_spe_idx;
c742cd1ffffaef Ben Greear  2021-11-18  897  		} else {
c742cd1ffffaef Ben Greear  2021-11-18  898  			u8 tx_ant = td->tx_antenna_mask;
c742cd1ffffaef Ben Greear  2021-11-18  899  
c742cd1ffffaef Ben Greear  2021-11-18  900  			if (!tx_ant) {
c742cd1ffffaef Ben Greear  2021-11-18  901  				/* use antenna mask that matches our nss */
c742cd1ffffaef Ben Greear  2021-11-18  902  				tx_ant = GENMASK(nss - 1, 0);
c742cd1ffffaef Ben Greear  2021-11-18  903  			}
c742cd1ffffaef Ben Greear  2021-11-18  904  			spe_idx = spe_idx_map[tx_ant];
c742cd1ffffaef Ben Greear  2021-11-18  905  		}
c742cd1ffffaef Ben Greear  2021-11-18  906  		txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX, spe_idx));
c742cd1ffffaef Ben Greear  2021-11-18  907  	} else {
aadf09537c575d Shayne Chen 2020-10-22  908  		txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX,
78fc30a21cf117 Shayne Chen 2020-12-04 @909  						  phy->test.spe_idx));
c742cd1ffffaef Ben Greear  2021-11-18  910  	}
aadf09537c575d Shayne Chen 2020-10-22  911  }
aadf09537c575d Shayne Chen 2020-10-22  912  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--qMm9M+Fa2AknHoGS
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Qp80rbuH/wdOjAHK0ygCAA==

--qMm9M+Fa2AknHoGS--
