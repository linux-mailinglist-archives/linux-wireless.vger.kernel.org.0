Return-Path: <linux-wireless+bounces-11589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71205955D80
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 18:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C371C2816C7
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 16:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1284C13D638;
	Sun, 18 Aug 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+GSdI9M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AAE47F69;
	Sun, 18 Aug 2024 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723999878; cv=none; b=ArI2jIKC74bWeudWiuQx0VdkqpdERTL6QIRMciEvawOOHRBOwC2dm8HSy3r8ARhhYOiV4qQD0Zat10M0XH9i2jy3jNJLKP0ddqOCo4Dn9Od2dGNYAz0ELDMQcsGO/FIy1Gtri+ed8JETkytY8gmqsexR/DSrkFNtyFgJpr+E50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723999878; c=relaxed/simple;
	bh=yVQWqSEC8Gwxg7IPz5Vp48C/kUYAtl5c2WC3tiuYVJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+1QQHFPZOCGnjB8QHAuY7oh/w+JlfsV4MPZl4+sPYNwJ403lkMJAC89VirOgyZkDTzAUqWHUaCUZ0J7E6wuIQx7JeNdpzgYOldftMH1bFf+weba/d4lw49dDfF07fS1yOx3NcUw8BAqc9yaoRsd2WiOIePN37ERaukOn2dEZj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+GSdI9M; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723999875; x=1755535875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yVQWqSEC8Gwxg7IPz5Vp48C/kUYAtl5c2WC3tiuYVJI=;
  b=h+GSdI9MrMyk5G5IThq3dh/V2xrt9bv9MGTTsl3KyWqXgkDuIJ4QGi7v
   aa9GZMQba87fadRNI7zPkkKuAJzH4LX6SzHOx30HeL2A0eOmqIy71F4ak
   j14D8JmcytwfHadJa9GLKcJ1+GcMFlBFniHyRwdY8nl98BvpyCM9VnAfk
   K4jEjoVCPG92whAzNslWKq467R0fobpV9wkb3ck00YGdI/optzdbZ4Ewy
   PhBJQnaMHSaUcNrX7K4Ke2+Hdx4NCrAwrhcWG85sXzWI+Ec3ZeDWU5YbP
   e9YkkrVAX7rsNYE/Fz3eNQcYfi+NLl5jbzIbQiUyHE2zkhz905pkcnFFp
   Q==;
X-CSE-ConnectionGUID: lDsZdTbBR2mCVHh47vhYgA==
X-CSE-MsgGUID: DgzzYCSCQ0O277bokwwMFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="21865958"
X-IronPort-AV: E=Sophos;i="6.10,157,1719903600"; 
   d="scan'208";a="21865958"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 09:51:14 -0700
X-CSE-ConnectionGUID: 9teRCEblT+mpzpyGO3RXOg==
X-CSE-MsgGUID: GLtv0lxqTkiYinhNkkgmRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,157,1719903600"; 
   d="scan'208";a="60429914"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Aug 2024 09:51:13 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfj7W-0008LW-0O;
	Sun, 18 Aug 2024 16:51:10 +0000
Date: Mon, 19 Aug 2024 00:50:22 +0800
From: kernel test robot <lkp@intel.com>
To: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
Subject: Re: [PATCH 2/3] iwlwifi: mvm: Enclose multi-statement macro in a do
 while
Message-ID: <202408190044.FGyKKgGE-lkp@intel.com>
References: <959e76da152811a723415545a3cf6ab1d8e17fbc.1723963126.git.soyjuanarbol@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <959e76da152811a723415545a3cf6ab1d8e17fbc.1723963126.git.soyjuanarbol@gmail.com>

Hi Juan,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juan-Jos-Arboleda/iwlwifi-mvm-Improve-code-style-in-pointer-declarations/20240818-145152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/959e76da152811a723415545a3cf6ab1d8e17fbc.1723963126.git.soyjuanarbol%40gmail.com
patch subject: [PATCH 2/3] iwlwifi: mvm: Enclose multi-statement macro in a do while
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240819/202408190044.FGyKKgGE-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408190044.FGyKKgGE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408190044.FGyKKgGE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c: In function 'iwl_mvm_decode_he_phy_ru_alloc':
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1051:9: error: expected ';' before 'while'
    1051 |         while (0);
         |         ^~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1053:9: note: in expansion of macro 'CHECK_BW'
    1053 |         CHECK_BW(20);
         |         ^~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1051:9: error: expected ';' before 'while'
    1051 |         while (0);
         |         ^~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1054:9: note: in expansion of macro 'CHECK_BW'
    1054 |         CHECK_BW(40);
         |         ^~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1051:9: error: expected ';' before 'while'
    1051 |         while (0);
         |         ^~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1055:9: note: in expansion of macro 'CHECK_BW'
    1055 |         CHECK_BW(80);
         |         ^~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1051:9: error: expected ';' before 'while'
    1051 |         while (0);
         |         ^~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1056:9: note: in expansion of macro 'CHECK_BW'
    1056 |         CHECK_BW(160);
         |         ^~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1071:1: error: expected 'while' before 'static'
    1071 | static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
         | ^~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1252:13: error: invalid storage class for function 'iwl_mvm_decode_eht_ext_mu'
    1252 | static void iwl_mvm_decode_eht_ext_mu(struct iwl_mvm *mvm,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1362:13: error: invalid storage class for function 'iwl_mvm_decode_eht_ext_tb'
    1362 | static void iwl_mvm_decode_eht_ext_tb(struct iwl_mvm *mvm,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1409:13: error: invalid storage class for function 'iwl_mvm_decode_eht_ru'
    1409 | static void iwl_mvm_decode_eht_ru(struct iwl_mvm *mvm,
         |             ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1478:13: error: invalid storage class for function 'iwl_mvm_decode_eht_phy_data'
    1478 | static void iwl_mvm_decode_eht_phy_data(struct iwl_mvm *mvm,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1595:13: error: invalid storage class for function 'iwl_mvm_rx_eht'
    1595 | static void iwl_mvm_rx_eht(struct iwl_mvm *mvm, struct sk_buff *skb,
         |             ^~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1738:13: error: invalid storage class for function 'iwl_mvm_rx_he'
    1738 | static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
         |             ^~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c: In function 'iwl_mvm_rx_he':
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1784:17: error: implicit declaration of function 'iwl_mvm_decode_he_phy_data'; did you mean 'iwl_mvm_decode_eht_phy_data'? [-Werror=implicit-function-declaration]
    1784 |                 iwl_mvm_decode_he_phy_data(mvm, phy_data, he, he_mu, rx_status,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 iwl_mvm_decode_eht_phy_data
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c: In function 'iwl_mvm_decode_he_phy_ru_alloc':
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1865:13: error: invalid storage class for function 'iwl_mvm_decode_lsig'
    1865 | static void iwl_mvm_decode_lsig(struct sk_buff *skb,
         |             ^~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1901:13: error: invalid storage class for function 'iwl_mvm_rx_get_sta_block_tx'
    1901 | static void iwl_mvm_rx_get_sta_block_tx(void *data, struct ieee80211_sta *sta)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1917:13: error: invalid storage class for function 'iwl_mvm_rx_fill_status'
    1917 | static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
         |             ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2561:1: error: expected declaration or statement at end of input
    2561 | }
         | ^
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2561:1: error: expected declaration or statement at end of input
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2561:1: error: expected declaration or statement at end of input
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2561:1: error: expected declaration or statement at end of input
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c: At top level:
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2517:6: warning: 'iwl_mvm_rx_bar_frame_release' defined but not used [-Wunused-function]
    2517 | void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2503:6: warning: 'iwl_mvm_rx_frame_release' defined but not used [-Wunused-function]
    2503 | void iwl_mvm_rx_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2370:6: warning: 'iwl_mvm_rx_monitor_no_data' defined but not used [-Wunused-function]
    2370 | void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2038:6: warning: 'iwl_mvm_rx_mpdu_mq' defined but not used [-Wunused-function]
    2038 | void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
         |      ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:987:1: warning: 'iwl_mvm_decode_he_phy_ru_alloc' defined but not used [-Wunused-function]
     987 | iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:935:13: warning: 'iwl_mvm_decode_he_mu_ext' defined but not used [-Wunused-function]
     935 | static void iwl_mvm_decode_he_mu_ext(struct iwl_mvm *mvm,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1051 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c

   934	
 > 935	static void iwl_mvm_decode_he_mu_ext(struct iwl_mvm *mvm,
   936					     struct iwl_mvm_rx_phy_data *phy_data,
   937					     struct ieee80211_radiotap_he_mu *he_mu)
   938	{
   939		u32 phy_data2 = le32_to_cpu(phy_data->d2);
   940		u32 phy_data3 = le32_to_cpu(phy_data->d3);
   941		u16 phy_data4 = le16_to_cpu(phy_data->d4);
   942		u32 rate_n_flags = phy_data->rate_n_flags;
   943	
   944		if (FIELD_GET(IWL_RX_PHY_DATA4_HE_MU_EXT_CH1_CRC_OK, phy_data4)) {
   945			he_mu->flags1 |=
   946				cpu_to_le16(IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_RU_KNOWN |
   947					    IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_CTR_26T_RU_KNOWN);
   948	
   949			he_mu->flags1 |=
   950				le16_encode_bits(FIELD_GET(IWL_RX_PHY_DATA4_HE_MU_EXT_CH1_CTR_RU,
   951							   phy_data4),
   952						 IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_CTR_26T_RU);
   953	
   954			he_mu->ru_ch1[0] = FIELD_GET(IWL_RX_PHY_DATA2_HE_MU_EXT_CH1_RU0,
   955						     phy_data2);
   956			he_mu->ru_ch1[1] = FIELD_GET(IWL_RX_PHY_DATA3_HE_MU_EXT_CH1_RU1,
   957						     phy_data3);
   958			he_mu->ru_ch1[2] = FIELD_GET(IWL_RX_PHY_DATA2_HE_MU_EXT_CH1_RU2,
   959						     phy_data2);
   960			he_mu->ru_ch1[3] = FIELD_GET(IWL_RX_PHY_DATA3_HE_MU_EXT_CH1_RU3,
   961						     phy_data3);
   962		}
   963	
   964		if (FIELD_GET(IWL_RX_PHY_DATA4_HE_MU_EXT_CH2_CRC_OK, phy_data4) &&
   965		    (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) != RATE_MCS_CHAN_WIDTH_20) {
   966			he_mu->flags1 |=
   967				cpu_to_le16(IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH2_RU_KNOWN |
   968					    IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH2_CTR_26T_RU_KNOWN);
   969	
   970			he_mu->flags2 |=
   971				le16_encode_bits(FIELD_GET(IWL_RX_PHY_DATA4_HE_MU_EXT_CH2_CTR_RU,
   972							   phy_data4),
   973						 IEEE80211_RADIOTAP_HE_MU_FLAGS2_CH2_CTR_26T_RU);
   974	
   975			he_mu->ru_ch2[0] = FIELD_GET(IWL_RX_PHY_DATA2_HE_MU_EXT_CH2_RU0,
   976						     phy_data2);
   977			he_mu->ru_ch2[1] = FIELD_GET(IWL_RX_PHY_DATA3_HE_MU_EXT_CH2_RU1,
   978						     phy_data3);
   979			he_mu->ru_ch2[2] = FIELD_GET(IWL_RX_PHY_DATA2_HE_MU_EXT_CH2_RU2,
   980						     phy_data2);
   981			he_mu->ru_ch2[3] = FIELD_GET(IWL_RX_PHY_DATA3_HE_MU_EXT_CH2_RU3,
   982						     phy_data3);
   983		}
   984	}
   985	
   986	static void
 > 987	iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
   988				       struct ieee80211_radiotap_he *he,
   989				       struct ieee80211_radiotap_he_mu *he_mu,
   990				       struct ieee80211_rx_status *rx_status)
   991	{
   992		/*
   993		 * Unfortunately, we have to leave the mac80211 data
   994		 * incorrect for the case that we receive an HE-MU
   995		 * transmission and *don't* have the HE phy data (due
   996		 * to the bits being used for TSF). This shouldn't
   997		 * happen though as management frames where we need
   998		 * the TSF/timers are not be transmitted in HE-MU.
   999		 */
  1000		u8 ru = le32_get_bits(phy_data->d1, IWL_RX_PHY_DATA1_HE_RU_ALLOC_MASK);
  1001		u32 rate_n_flags = phy_data->rate_n_flags;
  1002		u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK_V1;
  1003		u8 offs = 0;
  1004	
  1005		rx_status->bw = RATE_INFO_BW_HE_RU;
  1006	
  1007		he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN);
  1008	
  1009		switch (ru) {
  1010		case 0 ... 36:
  1011			rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_26;
  1012			offs = ru;
  1013			break;
  1014		case 37 ... 52:
  1015			rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_52;
  1016			offs = ru - 37;
  1017			break;
  1018		case 53 ... 60:
  1019			rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
  1020			offs = ru - 53;
  1021			break;
  1022		case 61 ... 64:
  1023			rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_242;
  1024			offs = ru - 61;
  1025			break;
  1026		case 65 ... 66:
  1027			rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_484;
  1028			offs = ru - 65;
  1029			break;
  1030		case 67:
  1031			rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_996;
  1032			break;
  1033		case 68:
  1034			rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
  1035			break;
  1036		}
  1037		he->data2 |= le16_encode_bits(offs,
  1038					      IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET);
  1039		he->data2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRISEC_80_KNOWN |
  1040					 IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET_KNOWN);
  1041		if (phy_data->d1 & cpu_to_le32(IWL_RX_PHY_DATA1_HE_RU_ALLOC_SEC80))
  1042			he->data2 |=
  1043				cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRISEC_80_SEC);
  1044	
  1045	#define CHECK_BW(bw) \
  1046		do { \
  1047			BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_ ## bw ## MHZ != \
  1048				     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS); \
  1049			BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_ ## bw ## MHZ != \
  1050				     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS) \
> 1051		while (0);
  1052	
  1053		CHECK_BW(20);
  1054		CHECK_BW(40);
> 1055		CHECK_BW(80);
> 1056		CHECK_BW(160);
  1057	
  1058		if (he_mu)
  1059			he_mu->flags2 |=
  1060				le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK_V1,
  1061							   rate_n_flags),
  1062						 IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW);
  1063		else if (he_type == RATE_MCS_HE_TYPE_TRIG_V1)
  1064			he->data6 |=
  1065				cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_KNOWN) |
  1066				le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK_V1,
  1067							   rate_n_flags),
  1068						 IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW);
  1069	}
  1070	
> 1071	static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
  1072					       struct iwl_mvm_rx_phy_data *phy_data,
  1073					       struct ieee80211_radiotap_he *he,
  1074					       struct ieee80211_radiotap_he_mu *he_mu,
  1075					       struct ieee80211_rx_status *rx_status,
  1076					       int queue)
  1077	{
  1078		switch (phy_data->info_type) {
  1079		case IWL_RX_PHY_INFO_TYPE_NONE:
  1080		case IWL_RX_PHY_INFO_TYPE_CCK:
  1081		case IWL_RX_PHY_INFO_TYPE_OFDM_LGCY:
  1082		case IWL_RX_PHY_INFO_TYPE_HT:
  1083		case IWL_RX_PHY_INFO_TYPE_VHT_SU:
  1084		case IWL_RX_PHY_INFO_TYPE_VHT_MU:
  1085		case IWL_RX_PHY_INFO_TYPE_EHT_MU:
  1086		case IWL_RX_PHY_INFO_TYPE_EHT_TB:
  1087		case IWL_RX_PHY_INFO_TYPE_EHT_MU_EXT:
  1088		case IWL_RX_PHY_INFO_TYPE_EHT_TB_EXT:
  1089			return;
  1090		case IWL_RX_PHY_INFO_TYPE_HE_TB_EXT:
  1091			he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN |
  1092						 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE2_KNOWN |
  1093						 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE3_KNOWN |
  1094						 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE4_KNOWN);
  1095			he->data4 |= le16_encode_bits(le32_get_bits(phy_data->d2,
  1096								    IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE1),
  1097						      IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE1);
  1098			he->data4 |= le16_encode_bits(le32_get_bits(phy_data->d2,
  1099								    IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE2),
  1100						      IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE2);
  1101			he->data4 |= le16_encode_bits(le32_get_bits(phy_data->d2,
  1102								    IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE3),
  1103						      IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE3);
  1104			he->data4 |= le16_encode_bits(le32_get_bits(phy_data->d2,
  1105								    IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE4),
  1106						      IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE4);
  1107			fallthrough;
  1108		case IWL_RX_PHY_INFO_TYPE_HE_SU:
  1109		case IWL_RX_PHY_INFO_TYPE_HE_MU:
  1110		case IWL_RX_PHY_INFO_TYPE_HE_MU_EXT:
  1111		case IWL_RX_PHY_INFO_TYPE_HE_TB:
  1112			/* HE common */
  1113			he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_LDPC_XSYMSEG_KNOWN |
  1114						 IEEE80211_RADIOTAP_HE_DATA1_DOPPLER_KNOWN |
  1115						 IEEE80211_RADIOTAP_HE_DATA1_BSS_COLOR_KNOWN);
  1116			he->data2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRE_FEC_PAD_KNOWN |
  1117						 IEEE80211_RADIOTAP_HE_DATA2_PE_DISAMBIG_KNOWN |
  1118						 IEEE80211_RADIOTAP_HE_DATA2_TXOP_KNOWN |
  1119						 IEEE80211_RADIOTAP_HE_DATA2_NUM_LTF_SYMS_KNOWN);
  1120			he->data3 |= le16_encode_bits(le32_get_bits(phy_data->d0,
  1121								    IWL_RX_PHY_DATA0_HE_BSS_COLOR_MASK),
  1122						      IEEE80211_RADIOTAP_HE_DATA3_BSS_COLOR);
  1123			if (phy_data->info_type != IWL_RX_PHY_INFO_TYPE_HE_TB &&
  1124			    phy_data->info_type != IWL_RX_PHY_INFO_TYPE_HE_TB_EXT) {
  1125				he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_UL_DL_KNOWN);
  1126				he->data3 |= le16_encode_bits(le32_get_bits(phy_data->d0,
  1127								    IWL_RX_PHY_DATA0_HE_UPLINK),
  1128							      IEEE80211_RADIOTAP_HE_DATA3_UL_DL);
  1129			}
  1130			he->data3 |= le16_encode_bits(le32_get_bits(phy_data->d0,
  1131								    IWL_RX_PHY_DATA0_HE_LDPC_EXT_SYM),
  1132						      IEEE80211_RADIOTAP_HE_DATA3_LDPC_XSYMSEG);
  1133			he->data5 |= le16_encode_bits(le32_get_bits(phy_data->d0,
  1134								    IWL_RX_PHY_DATA0_HE_PRE_FEC_PAD_MASK),
  1135						      IEEE80211_RADIOTAP_HE_DATA5_PRE_FEC_PAD);
  1136			he->data5 |= le16_encode_bits(le32_get_bits(phy_data->d0,
  1137								    IWL_RX_PHY_DATA0_HE_PE_DISAMBIG),
  1138						      IEEE80211_RADIOTAP_HE_DATA5_PE_DISAMBIG);
  1139			he->data5 |= le16_encode_bits(le32_get_bits(phy_data->d1,
  1140								    IWL_RX_PHY_DATA1_HE_LTF_NUM_MASK),
  1141						      IEEE80211_RADIOTAP_HE_DATA5_NUM_LTF_SYMS);
  1142			he->data6 |= le16_encode_bits(le32_get_bits(phy_data->d0,
  1143								    IWL_RX_PHY_DATA0_HE_TXOP_DUR_MASK),
  1144						      IEEE80211_RADIOTAP_HE_DATA6_TXOP);
  1145			he->data6 |= le16_encode_bits(le32_get_bits(phy_data->d0,
  1146								    IWL_RX_PHY_DATA0_HE_DOPPLER),
  1147						      IEEE80211_RADIOTAP_HE_DATA6_DOPPLER);
  1148			break;
  1149		}
  1150	
  1151		switch (phy_data->info_type) {
  1152		case IWL_RX_PHY_INFO_TYPE_HE_MU_EXT:
  1153		case IWL_RX_PHY_INFO_TYPE_HE_MU:
  1154		case IWL_RX_PHY_INFO_TYPE_HE_SU:
  1155			he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN);
  1156			he->data4 |= le16_encode_bits(le32_get_bits(phy_data->d0,
  1157								    IWL_RX_PHY_DATA0_HE_SPATIAL_REUSE_MASK),
  1158						      IEEE80211_RADIOTAP_HE_DATA4_SU_MU_SPTL_REUSE);
  1159			break;
  1160		default:
  1161			/* nothing here */
  1162			break;
  1163		}
  1164	
  1165		switch (phy_data->info_type) {
  1166		case IWL_RX_PHY_INFO_TYPE_HE_MU_EXT:
  1167			he_mu->flags1 |=
  1168				le16_encode_bits(le16_get_bits(phy_data->d4,
  1169							       IWL_RX_PHY_DATA4_HE_MU_EXT_SIGB_DCM),
  1170						 IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_DCM);
  1171			he_mu->flags1 |=
  1172				le16_encode_bits(le16_get_bits(phy_data->d4,
  1173							       IWL_RX_PHY_DATA4_HE_MU_EXT_SIGB_MCS_MASK),
  1174						 IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_MCS);
  1175			he_mu->flags2 |=
  1176				le16_encode_bits(le16_get_bits(phy_data->d4,
  1177							       IWL_RX_PHY_DATA4_HE_MU_EXT_PREAMBLE_PUNC_TYPE_MASK),
  1178						 IEEE80211_RADIOTAP_HE_MU_FLAGS2_PUNC_FROM_SIG_A_BW);
  1179			iwl_mvm_decode_he_mu_ext(mvm, phy_data, he_mu);
  1180			fallthrough;
  1181		case IWL_RX_PHY_INFO_TYPE_HE_MU:
  1182			he_mu->flags2 |=
  1183				le16_encode_bits(le32_get_bits(phy_data->d1,
  1184							       IWL_RX_PHY_DATA1_HE_MU_SIBG_SYM_OR_USER_NUM_MASK),
  1185						 IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_SYMS_USERS);
  1186			he_mu->flags2 |=
  1187				le16_encode_bits(le32_get_bits(phy_data->d1,
  1188							       IWL_RX_PHY_DATA1_HE_MU_SIGB_COMPRESSION),
  1189						 IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_COMP);
  1190			fallthrough;
  1191		case IWL_RX_PHY_INFO_TYPE_HE_TB:
  1192		case IWL_RX_PHY_INFO_TYPE_HE_TB_EXT:
  1193			iwl_mvm_decode_he_phy_ru_alloc(phy_data, he, he_mu, rx_status);
  1194			break;
  1195		case IWL_RX_PHY_INFO_TYPE_HE_SU:
  1196			he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BEAM_CHANGE_KNOWN);
  1197			he->data3 |= le16_encode_bits(le32_get_bits(phy_data->d0,
  1198								    IWL_RX_PHY_DATA0_HE_BEAM_CHNG),
  1199						      IEEE80211_RADIOTAP_HE_DATA3_BEAM_CHANGE);
  1200			break;
  1201		default:
  1202			/* nothing */
  1203			break;
  1204		}
  1205	}
  1206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

