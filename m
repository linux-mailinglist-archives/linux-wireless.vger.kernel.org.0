Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0376798191
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 07:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbjIHFgB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Sep 2023 01:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIHFgA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Sep 2023 01:36:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E95719AB
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 22:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694151356; x=1725687356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RorTQrQboReTQY01ayidMAcwqSmkqQs9BqJbd0Do9Lg=;
  b=AdasrKfl+AOfNHmILsSevAna6/mUb/GUpejYtRtr7Ps1z+NeLhWSrPIy
   2X1fn9YDNqO/q3a0KXm5SZoTkIr/A/f/+E8VfN719V66gGew2GmYY6fyk
   lltCejzjd3Cu1PpVvyjuMUWedPNm0t8dF8sHBW1MRRGG5ymo7AWoKkV2D
   KLFOjSLq5dQX/XUJ1IwL3IhBY6uWSvmgqCa4C1ZQVK1ttrZYd+vVV8sjF
   NxscEkvtHxZCZ2vw9sm6YVtDDdIvR5MmtHtA9dAPK+kFjJTICuJ0ibKCP
   cYHK/WT1wfA9ME5Y8jbu5OWoTREPw7xV5qTtiNy/Vswe7XTr4Js5S4ETM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="367827873"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="367827873"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 22:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="885520782"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="885520782"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2023 22:35:35 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeU9k-0001xV-2W;
        Fri, 08 Sep 2023 05:35:48 +0000
Date:   Fri, 8 Sep 2023 13:35:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     sean.wang@mediatek.com, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        sean.wang@mediatek.com, Soul.Huang@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        jsiuda@google.com, arowa@google.org, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7921: fix the wrong rate selected in fw
 for the chanctx driver
Message-ID: <202309081348.IepiSKwy-lkp@intel.com>
References: <4b2ee1382896dd7ff27ecbef6e1ad496edccd3ad.1694129223.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b2ee1382896dd7ff27ecbef6e1ad496edccd3ad.1694129223.git.objelf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5 next-20230907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-mediatek-com/wifi-mt76-mt7921-fix-the-wrong-rate-selected-in-fw-for-the-chanctx-driver/20230908-073344
base:   linus/master
patch link:    https://lore.kernel.org/r/4b2ee1382896dd7ff27ecbef6e1ad496edccd3ad.1694129223.git.objelf%40gmail.com
patch subject: [PATCH] wifi: mt76: mt7921: fix the wrong rate selected in fw for the chanctx driver
config: i386-randconfig-016-20230908 (https://download.01.org/0day-ci/archive/20230908/202309081348.IepiSKwy-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309081348.IepiSKwy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309081348.IepiSKwy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c:833:44: error: no member named 'ctx' in 'struct mt76_vif'
           struct cfg80211_chan_def *chandef = mvif->ctx ?
                                               ~~~~  ^
   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c:834:17: error: no member named 'ctx' in 'struct mt76_vif'
                                               &mvif->ctx->def : &mphy->chandef;
                                                ~~~~  ^
   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c:1375:44: error: no member named 'ctx' in 'struct mt76_vif'
           struct cfg80211_chan_def *chandef = mvif->ctx ?
                                               ~~~~  ^
   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c:1376:17: error: no member named 'ctx' in 'struct mt76_vif'
                                               &mvif->ctx->def : &phy->chandef;
                                                ~~~~  ^
   4 errors generated.


vim +833 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c

   826	
   827	void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
   828				     struct ieee80211_sta *sta,
   829				     struct ieee80211_vif *vif,
   830				     u8 rcpi, u8 sta_state)
   831	{
   832		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 > 833		struct cfg80211_chan_def *chandef = mvif->ctx ?
   834						    &mvif->ctx->def : &mphy->chandef;
   835		enum nl80211_band band = chandef->chan->band;
   836		struct mt76_dev *dev = mphy->dev;
   837		struct sta_rec_ra_info *ra_info;
   838		struct sta_rec_state *state;
   839		struct sta_rec_phy *phy;
   840		struct tlv *tlv;
   841		u16 supp_rates;
   842	
   843		/* starec ht */
   844		if (sta->deflink.ht_cap.ht_supported) {
   845			struct sta_rec_ht *ht;
   846	
   847			tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
   848			ht = (struct sta_rec_ht *)tlv;
   849			ht->ht_cap = cpu_to_le16(sta->deflink.ht_cap.cap);
   850		}
   851	
   852		/* starec vht */
   853		if (sta->deflink.vht_cap.vht_supported) {
   854			struct sta_rec_vht *vht;
   855			int len;
   856	
   857			len = is_mt7921(dev) ? sizeof(*vht) : sizeof(*vht) - 4;
   858			tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_VHT, len);
   859			vht = (struct sta_rec_vht *)tlv;
   860			vht->vht_cap = cpu_to_le32(sta->deflink.vht_cap.cap);
   861			vht->vht_rx_mcs_map = sta->deflink.vht_cap.vht_mcs.rx_mcs_map;
   862			vht->vht_tx_mcs_map = sta->deflink.vht_cap.vht_mcs.tx_mcs_map;
   863		}
   864	
   865		/* starec uapsd */
   866		mt76_connac_mcu_sta_uapsd(skb, vif, sta);
   867	
   868		if (!is_mt7921(dev))
   869			return;
   870	
   871		if (sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he)
   872			mt76_connac_mcu_sta_amsdu_tlv(skb, sta, vif);
   873	
   874		/* starec he */
   875		if (sta->deflink.he_cap.has_he) {
   876			mt76_connac_mcu_sta_he_tlv(skb, sta);
   877			mt76_connac_mcu_sta_he_tlv_v2(skb, sta);
   878			if (band == NL80211_BAND_6GHZ &&
   879			    sta_state == MT76_STA_INFO_STATE_ASSOC) {
   880				struct sta_rec_he_6g_capa *he_6g_capa;
   881	
   882				tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE_6G,
   883							      sizeof(*he_6g_capa));
   884				he_6g_capa = (struct sta_rec_he_6g_capa *)tlv;
   885				he_6g_capa->capa = sta->deflink.he_6ghz_capa.capa;
   886			}
   887		}
   888	
   889		tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
   890		phy = (struct sta_rec_phy *)tlv;
   891		phy->phy_type = mt76_connac_get_phy_mode_v2(mphy, vif, band, sta);
   892		phy->basic_rate = cpu_to_le16((u16)vif->bss_conf.basic_rates);
   893		phy->rcpi = rcpi;
   894		phy->ampdu = FIELD_PREP(IEEE80211_HT_AMPDU_PARM_FACTOR,
   895					sta->deflink.ht_cap.ampdu_factor) |
   896			     FIELD_PREP(IEEE80211_HT_AMPDU_PARM_DENSITY,
   897					sta->deflink.ht_cap.ampdu_density);
   898	
   899		tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra_info));
   900		ra_info = (struct sta_rec_ra_info *)tlv;
   901	
   902		supp_rates = sta->deflink.supp_rates[band];
   903		if (band == NL80211_BAND_2GHZ)
   904			supp_rates = FIELD_PREP(RA_LEGACY_OFDM, supp_rates >> 4) |
   905				     FIELD_PREP(RA_LEGACY_CCK, supp_rates & 0xf);
   906		else
   907			supp_rates = FIELD_PREP(RA_LEGACY_OFDM, supp_rates);
   908	
   909		ra_info->legacy = cpu_to_le16(supp_rates);
   910	
   911		if (sta->deflink.ht_cap.ht_supported)
   912			memcpy(ra_info->rx_mcs_bitmask,
   913			       sta->deflink.ht_cap.mcs.rx_mask,
   914			       HT_MCS_MASK_NUM);
   915	
   916		tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_STATE, sizeof(*state));
   917		state = (struct sta_rec_state *)tlv;
   918		state->state = sta_state;
   919	
   920		if (sta->deflink.vht_cap.vht_supported) {
   921			state->vht_opmode = sta->deflink.bandwidth;
   922			state->vht_opmode |= (sta->deflink.rx_nss - 1) <<
   923				IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
   924		}
   925	}
   926	EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_tlv);
   927	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
