Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D27B487D03
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 20:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiAGT3M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jan 2022 14:29:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:29519 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232106AbiAGT3M (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jan 2022 14:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641583752; x=1673119752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E2Si7o9RIAAEYdrCtYYfcYtGZ6HwKFG1nOR0mMvP4Ww=;
  b=YKfhuR5S1I0NjtcuXU0HVRL9HVMM8gl2xgUMosIgT6oCxxeD58G+17dB
   D6B6vRPaBh6jc1e8OzpyPZDWe/vBY1WgNq3GksAAIZq4eXIVO4Hb/4Qjn
   pmO6Lk0Z7Cncy/Fl6FKWHR3IdjSChucbiyBi7h4KvoM2q6VIqvWTwHtv/
   oRopTyvyLw2FwRt99yv6CZoN1X/xLYGtwW7HX6H4aZzBCBI4RMxcPQVWp
   wcdzXE/bgW4O0LgOSrk3X+g2KTvP/Ge0ar3245k0yeBnVhloEPCxJXzuW
   CR5uFiVzkHwgSHUuO2bb9VluKow9LrapCXp9J1twU0QxFkamgIQVVj+vB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="329270020"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="329270020"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:29:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="689895410"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Jan 2022 11:29:09 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5uvE-000IyK-E4; Fri, 07 Jan 2022 19:29:08 +0000
Date:   Sat, 8 Jan 2022 03:28:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, loic.poulain@linaro.org,
        benl@squareup.com, bryan.odonoghue@linaro.org
Subject: Re: [PATCH 4/4] wcn36xx: Add SNR reporting via get_survey()
Message-ID: <202201080336.Ut3ffMZu-lkp@intel.com>
References: <20220107153323.1807905-5-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107153323.1807905-5-bryan.odonoghue@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bryan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on kvalo-wireless-drivers-next/master]
[also build test WARNING on kvalo-ath/ath-next next-20220107]
[cannot apply to kvalo-wireless-drivers/master v5.16-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Bryan-O-Donoghue/wcn36xx-Add-spectrum-survey-reporting/20220107-233226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220108/202201080336.Ut3ffMZu-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/81c9665c3b1b0b2167717fbd52c32b5ea0f215af
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Bryan-O-Donoghue/wcn36xx-Add-spectrum-survey-reporting/20220107-233226
        git checkout 81c9665c3b1b0b2167717fbd52c32b5ea0f215af
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/wireless/ath/wcn36xx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/wcn36xx/main.c:1360:5: warning: no previous prototype for 'wcn36xx_get_survey' [-Wmissing-prototypes]
    1360 | int wcn36xx_get_survey(struct ieee80211_hw *hw, int idx,
         |     ^~~~~~~~~~~~~~~~~~


vim +/wcn36xx_get_survey +1360 drivers/net/wireless/ath/wcn36xx/main.c

  1359	
> 1360	int wcn36xx_get_survey(struct ieee80211_hw *hw, int idx,
  1361			       struct survey_info *survey)
  1362	{
  1363		struct wcn36xx *wcn = hw->priv;
  1364		struct ieee80211_supported_band *sband;
  1365		struct wcn36xx_chan_survey *chan_survey;
  1366		unsigned long flags;
  1367	
  1368		sband = wcn->hw->wiphy->bands[NL80211_BAND_2GHZ];
  1369		if (idx >= sband->n_channels) {
  1370			idx -= sband->n_channels;
  1371			sband = wcn->hw->wiphy->bands[NL80211_BAND_5GHZ];
  1372		}
  1373	
  1374		if (!sband || idx >= sband->n_channels)
  1375			return -ENOENT;
  1376	
  1377		spin_lock_irqsave(&wcn->survey_lock, flags);
  1378	
  1379		chan_survey = &wcn->chan_survey[idx];
  1380		survey->channel = &sband->channels[idx];
  1381		survey->noise = chan_survey->rssi - chan_survey->snr;
  1382		survey->filled = 0;
  1383	
  1384		if (chan_survey->rssi > -100 && chan_survey->rssi < 0)
  1385			survey->filled |= SURVEY_INFO_NOISE_DBM;
  1386	
  1387		if (survey->channel == wcn->channel)
  1388			survey->filled |= SURVEY_INFO_IN_USE;
  1389	
  1390		spin_unlock_irqrestore(&wcn->survey_lock, flags);
  1391	
  1392		 wcn36xx_dbg(WCN36XX_DBG_MAC,
  1393			     "ch %d rssi %d snr %d noise %d filled %x freq %d\n",
  1394			     HW_VALUE_CHANNEL(survey->channel->hw_value),
  1395			     chan_survey->rssi, chan_survey->snr, survey->noise,
  1396			     survey->filled, survey->channel->center_freq);
  1397	
  1398		return 0;
  1399	}
  1400	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
