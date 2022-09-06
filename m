Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B82C5ADF3C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 07:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiIFFyP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 01:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiIFFyB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 01:54:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D96FA30
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 22:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662443611; x=1693979611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7t4FyBVh42hW2ohs1YO1+wj8DBzLgsKLcAkHKLLIo6A=;
  b=ZNj7dH1xQSAnUqiQciSJRbMG7L0DUpDOpDKG/7pWHcjFmHT8GxLIGyH+
   TLRWGhAOP9iTcXZEr5AC0zu5CUaZaecYn+fzvRwtG5jRAjKmgCA7bfz9D
   chbTJ/RY2vT7mkGOQNOW+/eNYKZxM5ACm1YkZJvZgeFEG4HsiNOSGXz6V
   w/piai964aUHxh7A3BjsbbzTyKWeCDYWr1hgq3/J+sKpsx1nHIp6IEcwW
   lHVtriE5cmjRR7IU82YBlCpGF4kNCKlK8SIZUFQzxmoYGDR4XygSY/+yP
   s4qWKE8iP+UNhsYi93k+SRoBbiX9aC7bSsZpebiSKwI4qiRLMiAIjSO8r
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="360460163"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="360460163"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 22:53:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="675536454"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Sep 2022 22:53:10 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVRWI-0004qv-0y;
        Tue, 06 Sep 2022 05:53:10 +0000
Date:   Tue, 6 Sep 2022 13:52:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Jes.Sorensen@gmail.com,
        chris.chiu@canonical.com
Subject: Re: [PATCH] wifi: rtl8xxxu: Support new chip RTL8188FU
Message-ID: <202209061336.yU2hQRkV-lkp@intel.com>
References: <5dec7f70-0c1f-b487-3e3c-35394e2adc49@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dec7f70-0c1f-b487-3e3c-35394e2adc49@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bitterblue,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless/main]
[also build test WARNING on wireless-next/main linus/master v6.0-rc4 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitterblue-Smith/wifi-rtl8xxxu-Support-new-chip-RTL8188FU/20220906-101029
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220906/202209061336.yU2hQRkV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/66afb88c63c40850c518e4cecea4b211a01e0373
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bitterblue-Smith/wifi-rtl8xxxu-Support-new-chip-RTL8188FU/20220906-101029
        git checkout 66afb88c63c40850c518e4cecea4b211a01e0373
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/wireless/realtek/rtl8xxxu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:508:6: warning: no previous prototype for 'rtl8188fu_config_channel' [-Wmissing-prototypes]
     508 | void rtl8188fu_config_channel(struct ieee80211_hw *hw)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:647:6: warning: no previous prototype for 'rtl8188fu_init_aggregation' [-Wmissing-prototypes]
     647 | void rtl8188fu_init_aggregation(struct rtl8xxxu_priv *priv)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c: In function 'rtl8188fu_phy_iq_calibrate':
>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:1233:25: warning: variable 'path_b_ok' set but not used [-Wunused-but-set-variable]
    1233 |         bool path_a_ok, path_b_ok;
         |                         ^~~~~~~~~
   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c: At top level:
>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:1550:6: warning: no previous prototype for 'rtl8188fu_power_off' [-Wmissing-prototypes]
    1550 | void rtl8188fu_power_off(struct rtl8xxxu_priv *priv)
         |      ^~~~~~~~~~~~~~~~~~~


vim +/rtl8188fu_config_channel +508 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c

   507	
 > 508	void rtl8188fu_config_channel(struct ieee80211_hw *hw)
   509	{
   510		struct rtl8xxxu_priv *priv = hw->priv;
   511		u32 val32;
   512		u8 channel, subchannel;
   513		bool sec_ch_above;
   514	
   515		channel = (u8)hw->conf.chandef.chan->hw_value;
   516	
   517		/* Set channel*/
   518		val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_MODE_AG);
   519		val32 &= ~MODE_AG_CHANNEL_MASK;
   520		val32 |= channel;
   521		rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_MODE_AG, val32);
   522	
   523		/* Spur calibration */
   524		rtl8188f_spur_calibration(priv, channel);
   525	
   526		/* Set bandwidth mode */
   527		if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_20 ||
   528		    hw->conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
   529		    hw->conf.chandef.width == NL80211_CHAN_WIDTH_40) {
   530			val32 = rtl8xxxu_read32(priv, REG_FPGA0_RF_MODE);
   531			val32 &= ~FPGA_RF_MODE;
   532			val32 |= hw->conf.chandef.width == NL80211_CHAN_WIDTH_40;
   533			rtl8xxxu_write32(priv, REG_FPGA0_RF_MODE, val32);
   534	
   535			val32 = rtl8xxxu_read32(priv, REG_FPGA1_RF_MODE);
   536			val32 &= ~FPGA_RF_MODE;
   537			val32 |= hw->conf.chandef.width == NL80211_CHAN_WIDTH_40;
   538			rtl8xxxu_write32(priv, REG_FPGA1_RF_MODE, val32);
   539	
   540			/* RXADC CLK */
   541			val32 = rtl8xxxu_read32(priv, REG_FPGA0_RF_MODE);
   542			val32 |= GENMASK(10, 8);
   543			rtl8xxxu_write32(priv, REG_FPGA0_RF_MODE, val32);
   544	
   545			/* TXDAC CLK */
   546			val32 = rtl8xxxu_read32(priv, REG_FPGA0_RF_MODE);
   547			val32 |= BIT(14) | BIT(12);
   548			val32 &= ~BIT(13);
   549			rtl8xxxu_write32(priv, REG_FPGA0_RF_MODE, val32);
   550	
   551			/* small BW */
   552			val32 = rtl8xxxu_read32(priv, REG_OFDM0_TX_PSDO_NOISE_WEIGHT);
   553			val32 &= ~GENMASK(31, 30);
   554			rtl8xxxu_write32(priv, REG_OFDM0_TX_PSDO_NOISE_WEIGHT, val32);
   555	
   556			/* adc buffer clk */
   557			val32 = rtl8xxxu_read32(priv, REG_OFDM0_TX_PSDO_NOISE_WEIGHT);
   558			val32 &= ~BIT(29);
   559			val32 |= BIT(28);
   560			rtl8xxxu_write32(priv, REG_OFDM0_TX_PSDO_NOISE_WEIGHT, val32);
   561	
   562			/* adc buffer clk */
   563			val32 = rtl8xxxu_read32(priv, REG_OFDM0_XA_RX_AFE);
   564			val32 &= ~BIT(29);
   565			val32 |= BIT(28);
   566			rtl8xxxu_write32(priv, REG_OFDM0_XA_RX_AFE, val32);
   567	
   568			val32 = rtl8xxxu_read32(priv, REG_OFDM_RX_DFIR);
   569			val32 &= ~BIT(19);
   570			rtl8xxxu_write32(priv, REG_OFDM_RX_DFIR, val32);
   571	
   572			val32 = rtl8xxxu_read32(priv, REG_OFDM_RX_DFIR);
   573			val32 &= ~GENMASK(23, 20);
   574			val32 |= BIT(21);
   575			if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_20 ||
   576			    hw->conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
   577				val32 |= BIT(20);
   578			else if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_40)
   579				val32 |= BIT(22);
   580			rtl8xxxu_write32(priv, REG_OFDM_RX_DFIR, val32);
   581	
   582			if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_40) {
   583				if (hw->conf.chandef.center_freq1 >
   584				    hw->conf.chandef.chan->center_freq) {
   585					sec_ch_above = 1;
   586					channel += 2;
   587				} else {
   588					sec_ch_above = 0;
   589					channel -= 2;
   590				}
   591	
   592				/* Set Control channel to upper or lower. */
   593				val32 = rtl8xxxu_read32(priv, REG_CCK0_SYSTEM);
   594				val32 &= ~CCK0_SIDEBAND;
   595				if (!sec_ch_above)
   596					val32 |= CCK0_SIDEBAND;
   597				rtl8xxxu_write32(priv, REG_CCK0_SYSTEM, val32);
   598	
   599				val32 = rtl8xxxu_read32(priv, REG_DATA_SUBCHANNEL);
   600				/*
   601				 * It doesn't make sense to clear only bits 0-3,
   602				 * but this is what the vendor driver does.
   603				 */
   604				val32 &= ~GENMASK(3, 0);
   605				if (sec_ch_above)
   606					subchannel = (2 << 4) | 2;
   607				else
   608					subchannel = (1 << 4) | 1;
   609				val32 |= subchannel;
   610				rtl8xxxu_write32(priv, REG_DATA_SUBCHANNEL, val32);
   611	
   612				val32 = rtl8xxxu_read32(priv, REG_RESPONSE_RATE_SET);
   613				val32 &= ~RSR_RSC_BANDWIDTH_40M;
   614				rtl8xxxu_write32(priv, REG_RESPONSE_RATE_SET, val32);
   615			}
   616	
   617			/* RF TRX_BW */
   618			val32 = channel;
   619			if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_20 ||
   620			    hw->conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
   621				val32 |= MODE_AG_BW_20MHZ_8723B;
   622			else if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_40)
   623				val32 |= MODE_AG_BW_40MHZ_8723B;
   624			rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_MODE_AG, val32);
   625	
   626			/* FILTER BW&RC Corner (ACPR) */
   627			if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_20 ||
   628			    hw->conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
   629				val32 = 0x00065;
   630			else if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_40)
   631				val32 = 0x00025;
   632			rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_RXG_MIX_SWBW, val32);
   633	
   634			if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_20 ||
   635			    hw->conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
   636				val32 = 0x0;
   637			else if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_40)
   638				val32 = 0x01000;
   639			rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_RX_BB2, val32);
   640	
   641			/* RC Corner */
   642			rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x00140);
   643			rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_RX_G2, 0x01c6c);
   644		}
   645	}
   646	
 > 647	void rtl8188fu_init_aggregation(struct rtl8xxxu_priv *priv)
   648	{
   649		u8 agg_ctrl, rxdma_mode, usb_tx_agg_desc_num = 6;
   650		u32 agg_rx, val32;
   651	
   652		/* TX aggregation */
   653		val32 = rtl8xxxu_read32(priv, REG_DWBCN0_CTRL_8188F);
   654		val32 &= ~(0xf << 4);
   655		val32 |= usb_tx_agg_desc_num << 4;
   656		rtl8xxxu_write32(priv, REG_DWBCN0_CTRL_8188F, val32);
   657		rtl8xxxu_write8(priv, REG_DWBCN1_CTRL_8723B, usb_tx_agg_desc_num << 1);
   658	
   659		/* RX aggregation */
   660		agg_ctrl = rtl8xxxu_read8(priv, REG_TRXDMA_CTRL);
   661		agg_ctrl &= ~TRXDMA_CTRL_RXDMA_AGG_EN;
   662	
   663		agg_rx = rtl8xxxu_read32(priv, REG_RXDMA_AGG_PG_TH);
   664		agg_rx &= ~RXDMA_USB_AGG_ENABLE;
   665		agg_rx &= ~0xFF0F; /* reset agg size and timeout */
   666	
   667		rxdma_mode = rtl8xxxu_read8(priv, REG_RXDMA_PRO_8723B);
   668		rxdma_mode &= ~BIT(1);
   669	
   670		rtl8xxxu_write8(priv, REG_TRXDMA_CTRL, agg_ctrl);
   671		rtl8xxxu_write32(priv, REG_RXDMA_AGG_PG_TH, agg_rx);
   672		rtl8xxxu_write8(priv, REG_RXDMA_PRO_8723B, rxdma_mode);
   673	}
   674	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
