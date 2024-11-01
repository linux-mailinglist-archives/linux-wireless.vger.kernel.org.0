Return-Path: <linux-wireless+bounces-14794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32689B87BF
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 01:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B29B281704
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 00:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69DDBE4F;
	Fri,  1 Nov 2024 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nx0/be5E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B088A923
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730421362; cv=none; b=qH1ws8tKVpdHCUSsCchGIey+2DoKUKB1089dU6nKFfx+M621Tdr8Z5EkqVAtalQdWpugXmVp+9p0SzGvsZB6LDR2Tu4QkrcLWtIQztA/PIywsFYXrw0UiCzxuVH+i2vJSg/PnAnkpCohRpFelqIj+uZLFoPTGXpOxPZmJEmeW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730421362; c=relaxed/simple;
	bh=dRZxOx/+q+shYnipUBWB4pLWXNF1waprZeGhi6n17TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egwBK9V9wq73SjS8EHGH4v38h3AJGz+caqbVHA3PSBrLGZ9uXaIcWhnMjG2zYP5OOhfuTzHvGciKnkifCxsz5mUfWGfQoxfOfeNh+/4+kRyACoRKph0rQWAJhsPuGD8jZ5yp6wYQ/SAUlEOzD4bFZRLGwRPNQj7PmiYdgdRd2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nx0/be5E; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730421355; x=1761957355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dRZxOx/+q+shYnipUBWB4pLWXNF1waprZeGhi6n17TU=;
  b=nx0/be5EdaE6ov4zifHYrBTOpu8LN9+hxOs6mzPfe6qzAY9IhGqXdF6q
   tdIJSi2Bv/vfTWjJP6XWMBLtkh5xrrchWIw9Tf1UNFDsu5uxtg3Bidf6z
   M/o/uegkuKaNTYiVlCIKrGCl/foUtFXGxx6mo7bEzuKqbBRAzHP6qtGAX
   TdMyBs3f3t/ShunOAvp4oiZEOfu3rrqM3stq6rW1VDORpr1YTElA9sWNB
   fj8IZR20Fxs/hINW1oeDA+6Pz9WJElL4V9AhInvRb64d8oCMe2E9EWN5w
   fWcxWlWq9ltMEheyis2BO3rPDoBbp+Ca/iQonK6SbNoGzXTEgdE3u8bZu
   Q==;
X-CSE-ConnectionGUID: VBCrFBJRRiSXpCZmWwurCA==
X-CSE-MsgGUID: D3gtZfYGRDSO4HJ3//wgOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="29617915"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="29617915"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 17:35:54 -0700
X-CSE-ConnectionGUID: CeZ2DAFMR9eXB+tBByMARQ==
X-CSE-MsgGUID: yJRXsHuATxKhTFM+cNvtyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="82475356"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 31 Oct 2024 17:35:52 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6fdm-000gtO-0i;
	Fri, 01 Nov 2024 00:35:50 +0000
Date: Fri, 1 Nov 2024 08:35:22 +0800
From: kernel test robot <lkp@intel.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v4 7/7] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU
 drivers
Message-ID: <202411010825.Kzdw5VeV-lkp@intel.com>
References: <0b8e8093-8103-4999-86bf-0055ec52ea64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8e8093-8103-4999-86bf-0055ec52ea64@gmail.com>

Hi Bitterblue,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.12-rc5 next-20241031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitterblue-Smith/wifi-rtw88-Add-rtw8812a_table-c-h/20241031-023323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/0b8e8093-8103-4999-86bf-0055ec52ea64%40gmail.com
patch subject: [PATCH v4 7/7] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20241101/202411010825.Kzdw5VeV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411010825.Kzdw5VeV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411010825.Kzdw5VeV-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                             REG_RFE_CTRL_E
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:338:37: error: 'REG_IQK_COM64' undeclared (first use in this function)
     338 |                 rtw_write32(rtwdev, REG_IQK_COM64, 0xfa000000);
         |                                     ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:346:61: error: 'REG_IQKA_END' undeclared (first use in this function)
     346 |                         iqk_ready = rtw_read32_mask(rtwdev, REG_IQKA_END, BIT(10));
         |                                                             ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:377:50: error: 'REG_RX_IQC_AB_A' undeclared (first use in this function)
     377 |                         rtw_write32_mask(rtwdev, REG_RX_IQC_AB_A,
         |                                                  ^~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: In function 'rtw8821a_iqk':
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:415:42: error: 'REG_CCASEL' undeclared (first use in this function)
     415 |                 rtw_write32_mask(rtwdev, REG_CCASEL, BIT(31), 0x0);
         |                                          ^~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:419:37: error: 'REG_AFE_PWR1_A' undeclared (first use in this function); did you mean 'REG_AFE_CTRL_4'?
     419 |                 rtw_write32(rtwdev, REG_AFE_PWR1_A, 0x77777777);
         |                                     ^~~~~~~~~~~~~~
         |                                     REG_AFE_CTRL_4
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:420:37: error: 'REG_AFE_PWR2_A' undeclared (first use in this function); did you mean 'REG_AFE_CTRL_4'?
     420 |                 rtw_write32(rtwdev, REG_AFE_PWR2_A, 0x77777777);
         |                                     ^~~~~~~~~~~~~~
         |                                     REG_AFE_CTRL_4
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:422:37: error: 'REG_RX_WAIT_CCA_TX_CCK_RFON_A' undeclared (first use in this function)
     422 |                 rtw_write32(rtwdev, REG_RX_WAIT_CCA_TX_CCK_RFON_A, 0x19791979);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:425:42: error: 'REG_3WIRE_SWA' undeclared (first use in this function)
     425 |                 rtw_write32_mask(rtwdev, REG_3WIRE_SWA, 0xf, 0x4);
         |                                          ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:430:42: error: 'REG_CK_MONHA' undeclared (first use in this function)
     430 |                 rtw_write32_mask(rtwdev, REG_CK_MONHA, GENMASK(26, 24), 0x7);
         |                                          ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:435:49: error: 'RF_MODE_TABLE_ADDR' undeclared (first use in this function)
     435 |                 rtw_write_rf(rtwdev, RF_PATH_A, RF_MODE_TABLE_ADDR, RFREG_MASK,
         |                                                 ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:437:49: error: 'RF_MODE_TABLE_DATA0' undeclared (first use in this function)
     437 |                 rtw_write_rf(rtwdev, RF_PATH_A, RF_MODE_TABLE_DATA0, RFREG_MASK,
         |                                                 ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:439:49: error: 'RF_MODE_TABLE_DATA1' undeclared (first use in this function)
     439 |                 rtw_write_rf(rtwdev, RF_PATH_A, RF_MODE_TABLE_DATA1, RFREG_MASK,
         |                                                 ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:442:49: error: 'RF_TXA_PREPAD' undeclared (first use in this function)
     442 |                 rtw_write_rf(rtwdev, RF_PATH_A, RF_TXA_PREPAD, RFREG_MASK,
         |                                                 ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:444:49: error: 'RF_RXBB2' undeclared (first use in this function)
     444 |                 rtw_write_rf(rtwdev, RF_PATH_A, RF_RXBB2, RFREG_MASK, 0x8a001);
         |                                                 ^~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:445:37: error: 'REG_DAC_RSTB' undeclared (first use in this function)
     445 |                 rtw_write32(rtwdev, REG_DAC_RSTB, 0x00008000);
         |                                     ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:446:42: error: 'REG_TXAGCIDX' undeclared (first use in this function)
     446 |                 rtw_write32_mask(rtwdev, REG_TXAGCIDX, BIT(0), 0x1);
         |                                          ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:448:37: error: 'REG_IQK_COM00' undeclared (first use in this function)
     448 |                 rtw_write32(rtwdev, REG_IQK_COM00, 0x29002000);
         |                                     ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:450:37: error: 'REG_IQK_COM32' undeclared (first use in this function)
     450 |                 rtw_write32(rtwdev, REG_IQK_COM32, 0xa9002000);
         |                                     ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:452:37: error: 'REG_IQK_COM96' undeclared (first use in this function)
     452 |                 rtw_write32(rtwdev, REG_IQK_COM96, 0x00462910);
         |                                     ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:458:45: error: 'REG_OFDM0_XB_TX_IQ_IMBALANCE' undeclared (first use in this function)
     458 |                         rtw_write32(rtwdev, REG_OFDM0_XB_TX_IQ_IMBALANCE,
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:465:45: error: 'REG_TSSI_TRK_SW' undeclared (first use in this function)
     465 |                         rtw_write32(rtwdev, REG_TSSI_TRK_SW, 0x68163e96);
         |                                             ^~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:470:37: error: 'REG_OFDM0_XA_TX_IQ_IMBALANCE' undeclared (first use in this function)
     470 |                 rtw_write32(rtwdev, REG_OFDM0_XA_TX_IQ_IMBALANCE, 0x18008c10);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:472:37: error: 'REG_OFDM0_A_TX_AFE' undeclared (first use in this function)
     472 |                 rtw_write32(rtwdev, REG_OFDM0_A_TX_AFE, 0x38008c10);
         |                                     ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:473:37: error: 'REG_RFECTL_A' undeclared (first use in this function); did you mean 'REG_RFE_CTRL_E'?
     473 |                 rtw_write32(rtwdev, REG_RFECTL_A, 0x00100000);
         |                                     ^~~~~~~~~~~~
         |                                     REG_RFE_CTRL_E
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:474:37: error: 'REG_IQK_COM64' undeclared (first use in this function)
     474 |                 rtw_write32(rtwdev, REG_IQK_COM64, 0xfa000000);
         |                                     ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:482:49: error: 'RF_TXMOD' undeclared (first use in this function)
     482 |                 rtw_write_rf(rtwdev, RF_PATH_A, RF_TXMOD, 0x7fe00,
         |                                                 ^~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: In function 'rtw8821a_coex_cfg_ant_switch':
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:751:40: error: 'REG_GNT_BT' undeclared (first use in this function)
     751 |                 rtw_write8_set(rtwdev, REG_GNT_BT, BIT_PTA_SW_CTL);
         |                                        ^~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:751:52: error: 'BIT_PTA_SW_CTL' undeclared (first use in this function)
     751 |                 rtw_write8_set(rtwdev, REG_GNT_BT, BIT_PTA_SW_CTL);
         |                                                    ^~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:754:40: error: 'PTA_CTRL_PIN' undeclared (first use in this function)
     754 |                            share_ant ? PTA_CTRL_PIN : DPDT_CTRL_PIN);
         |                                        ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:754:55: error: 'DPDT_CTRL_PIN' undeclared (first use in this function)
     754 |                            share_ant ? PTA_CTRL_PIN : DPDT_CTRL_PIN);
         |                                                       ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: At top level:
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:836:10: error: 'const struct rtw_chip_ops' has no member named 'power_on'
     836 |         .power_on               = rtw88xxa_power_on,
         |          ^~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:836:35: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
     836 |         .power_on               = rtw88xxa_power_on,
         |                                   ^~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:836:35: note: (near initialization for 'rtw8821a_ops')
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:836:35: error: invalid initializer
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:836:35: note: (near initialization for 'rtw8821a_ops.<anonymous>')
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:837:10: error: 'const struct rtw_chip_ops' has no member named 'power_off'
     837 |         .power_off              = rtw8821a_power_off,
         |          ^~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:837:35: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
     837 |         .power_off              = rtw8821a_power_off,
         |                                   ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:837:35: note: (near initialization for 'rtw8821a_ops')
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:914:25: error: 'REG_RXIGI_A' undeclared here (not in a function); did you mean 'REG_RX_GAIN_EN'?
     914 |         [0] = { .addr = REG_RXIGI_A, .mask = 0x7f },
         |                         ^~~~~~~~~~~
         |                         REG_RX_GAIN_EN
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:920:18: error: 'const struct rtw_rfe_def' has no member named 'pwr_track_tbl'
     920 |                 .pwr_track_tbl  = &rtw8821a_rtw_pwr_track_tbl, },
         |                  ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:920:35: error: initialization of 'const struct rtw_table *' from incompatible pointer type 'const struct rtw_pwr_track_tbl *' [-Werror=incompatible-pointer-types]
     920 |                 .pwr_track_tbl  = &rtw8821a_rtw_pwr_track_tbl, },
         |                                   ^
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:920:35: note: (near initialization for 'rtw8821a_rfe_defs[0].agc_btg_tbl')
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:1112:15: error: 'RTW_CHIP_TYPE_8821A' undeclared here (not in a function); did you mean 'RTW_CHIP_TYPE_8821C'?
    1112 |         .id = RTW_CHIP_TYPE_8821A,
         |               ^~~~~~~~~~~~~~~~~~~
         |               RTW_CHIP_TYPE_8821C
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:1130:22: warning: unsigned conversion from 'int' to 'unsigned char' changes value from '256' to '0' [-Woverflow]
    1130 |         .page_size = 256,
         |                      ^~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:1143:26: error: 'REG_LSSI_WRITE_A' undeclared here (not in a function)
    1143 |         .rf_sipi_addr = {REG_LSSI_WRITE_A, REG_LSSI_WRITE_B},
         |                          ^~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:1143:44: error: 'REG_LSSI_WRITE_B' undeclared here (not in a function)
    1143 |         .rf_sipi_addr = {REG_LSSI_WRITE_A, REG_LSSI_WRITE_B},
         |                                            ^~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:1152:10: error: 'const struct rtw_chip_info' has no member named 'hw_feature_report'
    1152 |         .hw_feature_report = false,
         |          ^~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:1153:10: error: 'const struct rtw_chip_info' has no member named 'c2h_ra_report_size'
    1153 |         .c2h_ra_report_size = 4,
         |          ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:1153:31: warning: initialized field overwritten [-Woverride-init]
    1153 |         .c2h_ra_report_size = 4,
         |                               ^
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:1153:31: note: (near initialization for 'rtw8821a_hw_spec.max_power_index')
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:1154:10: error: 'const struct rtw_chip_info' has no member named 'old_datarate_fb_limit'
    1154 |         .old_datarate_fb_limit = true,
         |          ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:1157:26: warning: initialized field overwritten [-Woverride-init]
    1157 |         .ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:1157:26: note: (near initialization for 'rtw8821a_hw_spec.ampdu_density')
   cc1: some warnings being treated as errors
--
     337 |         rtw_write32(rtwdev, REG_DAC_RSTB, 0x00008000);
         |                             ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:338:34: error: 'REG_TXAGCIDX' undeclared (first use in this function)
     338 |         rtw_write32_mask(rtwdev, REG_TXAGCIDX, BIT(0), 0x1);
         |                                  ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:339:34: error: 'REG_INIDLYB' undeclared (first use in this function)
     339 |         rtw_write32_mask(rtwdev, REG_INIDLYB, BIT(0), 0x1);
         |                                  ^~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:340:29: error: 'REG_IQK_COM00' undeclared (first use in this function)
     340 |         rtw_write32(rtwdev, REG_IQK_COM00, 0x29002000); /* TX (X,Y) */
         |                             ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:341:29: error: 'REG_IQK_COM32' undeclared (first use in this function)
     341 |         rtw_write32(rtwdev, REG_IQK_COM32, 0xa9002000); /* RX (X,Y) */
         |                             ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:342:29: error: 'REG_IQK_COM96' undeclared (first use in this function)
     342 |         rtw_write32(rtwdev, REG_IQK_COM96, 0x00462910); /* [0]:AGC_en, [15]:idac_K_Mask */
         |                             ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:348:45: error: 'REG_OFDM0_XB_TX_IQ_IMBALANCE' undeclared (first use in this function)
     348 |                         rtw_write32(rtwdev, REG_OFDM0_XB_TX_IQ_IMBALANCE, 0x821403e3);
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:349:45: error: 'REG_TXPITMB' undeclared (first use in this function)
     349 |                         rtw_write32(rtwdev, REG_TXPITMB, 0x821403e3);
         |                                             ^~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:360:37: error: 'REG_TSSI_TRK_SW' undeclared (first use in this function)
     360 |                 rtw_write32(rtwdev, REG_TSSI_TRK_SW, 0x68163e96);
         |                                     ^~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:361:37: error: 'REG_RXPITMB' undeclared (first use in this function); did you mean 'REG_RXPKTNUM'?
     361 |                 rtw_write32(rtwdev, REG_RXPITMB, 0x68163e96);
         |                                     ^~~~~~~~~~~
         |                                     REG_RXPKTNUM
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:377:29: error: 'REG_OFDM0_XA_TX_IQ_IMBALANCE' undeclared (first use in this function)
     377 |         rtw_write32(rtwdev, REG_OFDM0_XA_TX_IQ_IMBALANCE, 0x18008c10);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:379:29: error: 'REG_OFDM0_A_TX_AFE' undeclared (first use in this function)
     379 |         rtw_write32(rtwdev, REG_OFDM0_A_TX_AFE, 0x38008c10);
         |                             ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:380:29: error: 'REG_INTPO_SETA' undeclared (first use in this function)
     380 |         rtw_write32(rtwdev, REG_INTPO_SETA, 0x00000000);
         |                             ^~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:382:29: error: 'REG_TXTONEB' undeclared (first use in this function)
     382 |         rtw_write32(rtwdev, REG_TXTONEB, 0x18008c10);
         |                             ^~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:384:29: error: 'REG_RXTONEB' undeclared (first use in this function)
     384 |         rtw_write32(rtwdev, REG_RXTONEB, 0x38008c10);
         |                             ^~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:385:29: error: 'REG_INTPO_SETB' undeclared (first use in this function)
     385 |         rtw_write32(rtwdev, REG_INTPO_SETB, 0x00000000);
         |                             ^~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:391:37: error: 'REG_RFECTL_A' undeclared (first use in this function); did you mean 'REG_RFE_CTRL_E'?
     391 |                 rtw_write32(rtwdev, REG_RFECTL_A, 0x00100000);
         |                                     ^~~~~~~~~~~~
         |                                     REG_RFE_CTRL_E
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:392:37: error: 'REG_RFECTL_B' undeclared (first use in this function); did you mean 'REG_RFE_CTRL_E'?
     392 |                 rtw_write32(rtwdev, REG_RFECTL_B, 0x00100000);
         |                                     ^~~~~~~~~~~~
         |                                     REG_RFE_CTRL_E
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:393:37: error: 'REG_IQK_COM64' undeclared (first use in this function)
     393 |                 rtw_write32(rtwdev, REG_IQK_COM64, 0xfa000000);
         |                                     ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:404:62: error: 'REG_IQKA_END' undeclared (first use in this function)
     404 |                                                              REG_IQKA_END,
         |                                                              ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:408:62: error: 'REG_IQKB_END' undeclared (first use in this function)
     408 |                                                              REG_IQKB_END,
         |                                                              ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:515:41: error: 'RF_TXMOD' undeclared (first use in this function)
     515 |         rtw_write_rf(rtwdev, RF_PATH_A, RF_TXMOD, 0x7fe00,
         |                                         ^~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:561:37: error: 'REG_RFE_PINMUX_A' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     561 |                 rtw_write32(rtwdev, REG_RFE_PINMUX_A, 0x77777717);
         |                                     ^~~~~~~~~~~~~~~~
         |                                     REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:562:37: error: 'REG_RFE_INV_A' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     562 |                 rtw_write32(rtwdev, REG_RFE_INV_A, 0x00000077);
         |                                     ^~~~~~~~~~~~~
         |                                     REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:563:37: error: 'REG_RFE_PINMUX_B' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     563 |                 rtw_write32(rtwdev, REG_RFE_PINMUX_B, 0x77777717);
         |                                     ^~~~~~~~~~~~~~~~
         |                                     REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:564:37: error: 'REG_RFE_INV_B' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     564 |                 rtw_write32(rtwdev, REG_RFE_INV_B, 0x00000077);
         |                                     ^~~~~~~~~~~~~
         |                                     REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw8812a.c: In function 'rtw8812a_do_iqk':
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:809:33: error: 'REG_CCASEL' undeclared (first use in this function)
     809 |         rtw_write32_set(rtwdev, REG_CCASEL, BIT(31));
         |                                 ^~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:810:38: error: 'REG_RFECTL_A' undeclared (first use in this function); did you mean 'REG_RFE_CTRL_E'?
     810 |         reg_cb8 = rtw_read32(rtwdev, REG_RFECTL_A);
         |                                      ^~~~~~~~~~~~
         |                                      REG_RFE_CTRL_E
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:811:38: error: 'REG_RFECTL_B' undeclared (first use in this function); did you mean 'REG_RFE_CTRL_E'?
     811 |         reg_eb8 = rtw_read32(rtwdev, REG_RFECTL_B);
         |                                      ^~~~~~~~~~~~
         |                                      REG_RFE_CTRL_E
   drivers/net/wireless/realtek/rtw88/rtw8812a.c: At top level:
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:899:10: error: 'const struct rtw_chip_ops' has no member named 'power_on'
     899 |         .power_on               = rtw88xxa_power_on,
         |          ^~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8812a.c:899:35: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
     899 |         .power_on               = rtw88xxa_power_on,
         |                                   ^~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:899:35: note: (near initialization for 'rtw8812a_ops')
>> drivers/net/wireless/realtek/rtw88/rtw8812a.c:899:35: error: invalid initializer
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:899:35: note: (near initialization for 'rtw8812a_ops.<anonymous>')
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:900:10: error: 'const struct rtw_chip_ops' has no member named 'power_off'
     900 |         .power_off              = rtw8812a_power_off,
         |          ^~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:900:35: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
     900 |         .power_off              = rtw8812a_power_off,
         |                                   ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:900:35: note: (near initialization for 'rtw8812a_ops')
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:977:25: error: 'REG_RXIGI_A' undeclared here (not in a function); did you mean 'REG_RX_GAIN_EN'?
     977 |         [0] = { .addr = REG_RXIGI_A, .mask = 0x7f },
         |                         ^~~~~~~~~~~
         |                         REG_RX_GAIN_EN
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:978:25: error: 'REG_RXIGI_B' undeclared here (not in a function); did you mean 'REG_RX_GAIN_EN'?
     978 |         [1] = { .addr = REG_RXIGI_B, .mask = 0x7f },
         |                         ^~~~~~~~~~~
         |                         REG_RX_GAIN_EN
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:984:18: error: 'const struct rtw_rfe_def' has no member named 'pwr_track_tbl'
     984 |                 .pwr_track_tbl  = &rtw8812a_rtw_pwr_track_tbl, },
         |                  ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:984:35: error: initialization of 'const struct rtw_table *' from incompatible pointer type 'const struct rtw_pwr_track_tbl *' [-Werror=incompatible-pointer-types]
     984 |                 .pwr_track_tbl  = &rtw8812a_rtw_pwr_track_tbl, },
         |                                   ^
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:984:35: note: (near initialization for 'rtw8812a_rfe_defs[0].agc_btg_tbl')
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:987:18: error: 'const struct rtw_rfe_def' has no member named 'pwr_track_tbl'
     987 |                 .pwr_track_tbl  = &rtw8812a_rtw_pwr_track_tbl, },
         |                  ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:987:35: error: initialization of 'const struct rtw_table *' from incompatible pointer type 'const struct rtw_pwr_track_tbl *' [-Werror=incompatible-pointer-types]
     987 |                 .pwr_track_tbl  = &rtw8812a_rtw_pwr_track_tbl, },
         |                                   ^
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:987:35: note: (near initialization for 'rtw8812a_rfe_defs[1].agc_btg_tbl')
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:990:18: error: 'const struct rtw_rfe_def' has no member named 'pwr_track_tbl'
     990 |                 .pwr_track_tbl  = &rtw8812a_rtw_pwr_track_rfe3_tbl, },
         |                  ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:990:35: error: initialization of 'const struct rtw_table *' from incompatible pointer type 'const struct rtw_pwr_track_tbl *' [-Werror=incompatible-pointer-types]
     990 |                 .pwr_track_tbl  = &rtw8812a_rtw_pwr_track_rfe3_tbl, },
         |                                   ^
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:990:35: note: (near initialization for 'rtw8812a_rfe_defs[3].agc_btg_tbl')
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:1018:15: error: 'RTW_CHIP_TYPE_8812A' undeclared here (not in a function); did you mean 'RTW_CHIP_TYPE_8821C'?
    1018 |         .id = RTW_CHIP_TYPE_8812A,
         |               ^~~~~~~~~~~~~~~~~~~
         |               RTW_CHIP_TYPE_8821C
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:1036:22: warning: unsigned conversion from 'int' to 'unsigned char' changes value from '512' to '0' [-Woverflow]
    1036 |         .page_size = 512,
         |                      ^~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:1049:26: error: 'REG_LSSI_WRITE_A' undeclared here (not in a function)
    1049 |         .rf_sipi_addr = {REG_LSSI_WRITE_A, REG_LSSI_WRITE_B},
         |                          ^~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:1049:44: error: 'REG_LSSI_WRITE_B' undeclared here (not in a function)
    1049 |         .rf_sipi_addr = {REG_LSSI_WRITE_A, REG_LSSI_WRITE_B},
         |                                            ^~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:1058:10: error: 'const struct rtw_chip_info' has no member named 'hw_feature_report'
    1058 |         .hw_feature_report = false,
         |          ^~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:1059:10: error: 'const struct rtw_chip_info' has no member named 'c2h_ra_report_size'
    1059 |         .c2h_ra_report_size = 4,
         |          ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:1059:31: warning: initialized field overwritten [-Woverride-init]
    1059 |         .c2h_ra_report_size = 4,
         |                               ^
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:1059:31: note: (near initialization for 'rtw8812a_hw_spec.max_power_index')
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:1060:10: error: 'const struct rtw_chip_info' has no member named 'old_datarate_fb_limit'
    1060 |         .old_datarate_fb_limit = true,
         |          ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:1063:26: warning: initialized field overwritten [-Woverride-init]
    1063 |         .ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8812a.c:1063:26: note: (near initialization for 'rtw8812a_hw_spec.ampdu_density')
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +836 drivers/net/wireless/realtek/rtw88/rtw8821a.c

113f5244025fcf Bitterblue Smith 2024-10-30  834  
113f5244025fcf Bitterblue Smith 2024-10-30  835  static const struct rtw_chip_ops rtw8821a_ops = {
113f5244025fcf Bitterblue Smith 2024-10-30 @836  	.power_on		= rtw88xxa_power_on,
113f5244025fcf Bitterblue Smith 2024-10-30  837  	.power_off		= rtw8821a_power_off,
113f5244025fcf Bitterblue Smith 2024-10-30  838  	.phy_set_param		= NULL,
113f5244025fcf Bitterblue Smith 2024-10-30  839  	.read_efuse		= rtw88xxa_read_efuse,
113f5244025fcf Bitterblue Smith 2024-10-30  840  	.query_phy_status	= rtw8821a_query_phy_status,
113f5244025fcf Bitterblue Smith 2024-10-30  841  	.set_channel		= rtw88xxa_set_channel,
113f5244025fcf Bitterblue Smith 2024-10-30  842  	.mac_init		= NULL,
113f5244025fcf Bitterblue Smith 2024-10-30  843  	.read_rf		= rtw88xxa_phy_read_rf,
113f5244025fcf Bitterblue Smith 2024-10-30  844  	.write_rf		= rtw_phy_write_rf_reg_sipi,
113f5244025fcf Bitterblue Smith 2024-10-30  845  	.set_antenna		= NULL,
113f5244025fcf Bitterblue Smith 2024-10-30  846  	.set_tx_power_index	= rtw88xxa_set_tx_power_index,
113f5244025fcf Bitterblue Smith 2024-10-30  847  	.cfg_ldo25		= rtw8821a_cfg_ldo25,
113f5244025fcf Bitterblue Smith 2024-10-30  848  	.efuse_grant		= rtw88xxa_efuse_grant,
113f5244025fcf Bitterblue Smith 2024-10-30  849  	.false_alarm_statistics	= rtw88xxa_false_alarm_statistics,
113f5244025fcf Bitterblue Smith 2024-10-30  850  	.phy_calibration	= rtw8821a_phy_calibration,
113f5244025fcf Bitterblue Smith 2024-10-30  851  	.cck_pd_set		= rtw88xxa_phy_cck_pd_set,
113f5244025fcf Bitterblue Smith 2024-10-30  852  	.pwr_track		= rtw8821a_pwr_track,
113f5244025fcf Bitterblue Smith 2024-10-30  853  	.config_bfee		= NULL,
113f5244025fcf Bitterblue Smith 2024-10-30  854  	.set_gid_table		= NULL,
113f5244025fcf Bitterblue Smith 2024-10-30  855  	.cfg_csi_rate		= NULL,
113f5244025fcf Bitterblue Smith 2024-10-30  856  	.fill_txdesc_checksum	= rtw8821a_fill_txdesc_checksum,
113f5244025fcf Bitterblue Smith 2024-10-30  857  	.coex_set_init		= rtw8821a_coex_cfg_init,
113f5244025fcf Bitterblue Smith 2024-10-30  858  	.coex_set_ant_switch	= rtw8821a_coex_cfg_ant_switch,
113f5244025fcf Bitterblue Smith 2024-10-30  859  	.coex_set_gnt_fix	= rtw8821a_coex_cfg_gnt_fix,
113f5244025fcf Bitterblue Smith 2024-10-30  860  	.coex_set_gnt_debug	= rtw8821a_coex_cfg_gnt_debug,
113f5244025fcf Bitterblue Smith 2024-10-30  861  	.coex_set_rfe_type	= rtw8821a_coex_cfg_rfe_type,
113f5244025fcf Bitterblue Smith 2024-10-30  862  	.coex_set_wl_tx_power	= rtw8821a_coex_cfg_wl_tx_power,
113f5244025fcf Bitterblue Smith 2024-10-30  863  	.coex_set_wl_rx_gain	= rtw8821a_coex_cfg_wl_rx_gain,
113f5244025fcf Bitterblue Smith 2024-10-30  864  };
113f5244025fcf Bitterblue Smith 2024-10-30  865  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

