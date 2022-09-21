Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840C75BF595
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 06:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIUEv2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Sep 2022 00:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIUEvP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Sep 2022 00:51:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943A97D7B5
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 21:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663735873; x=1695271873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tK1G83lpUXpBfuNWxqj1/s9rzFCDfy2sxFXDGRdSRZQ=;
  b=bxeMPy2gflyTj5kJFP+QRxH0Ll9xpyRqSnO18sNSmbnULqoMpwGEcqyL
   K7W2NVeLxitjqHT2NEV+PP+1zGoR3TMgV7j9VIwjmKwd/5VYzaxVVAQe9
   zTiR5Vv6yx1nJo+bhxWSDSdIRbkv/lsbE19cgCrb/d+m7rRGTZvEczyBa
   YIVm5NagQQTkGgJRzA4Dr6o+Sk3wVHh5XSQDOzI52y+PffYuHmNqVF7pp
   GCvswJAoW8Nr50Aq/4JpkZiHVYDXfa/uN59dFT4w1ooxIxEnKdFdWuYT4
   gigTNRF2ZQxt8M6Ej3sGuWgJ0InGoCKSocMxvVVLBUUniQZePHZiAUcKJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="298617836"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="298617836"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 21:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="619197890"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Sep 2022 21:51:04 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oarhP-0003F3-1c;
        Wed, 21 Sep 2022 04:51:03 +0000
Date:   Wed, 21 Sep 2022 12:50:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ian Lin <ian.lin@infineon.com>, linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        Double.Lo@infineon.com, ian.lin@infineon.com
Subject: Re: [PATCH 1/3] brcmfmac: Support DPP feature
Message-ID: <202209211219.PmRhFKDc-lkp@intel.com>
References: <20220921015951.16178-2-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921015951.16178-2-ian.lin@infineon.com>
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
[also build test WARNING on wireless/main linus/master v6.0-rc6 next-20220920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Lin/brcmfmac-Support-DPP-feature-series/20220921-101658
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220921/202209211219.PmRhFKDc-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a4592ec96782290389bab0b4ca9cd9bc0ae4672a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ian-Lin/brcmfmac-Support-DPP-feature-series/20220921-101658
        git checkout a4592ec96782290389bab0b4ca9cd9bc0ae4672a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c: In function 'brcmf_p2p_tx_action_frame':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1587:13: warning: variable 'action_frame_len' set but not used [-Wunused-but-set-variable]
    1587 |         u16 action_frame_len;
         |             ^~~~~~~~~~~~~~~~


vim +/action_frame_len +1587 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c

  1564	
  1565	
  1566	/**
  1567	 * brcmf_p2p_tx_action_frame() - send action frame over fil.
  1568	 *
  1569	 * @p2p: p2p info struct for vif.
  1570	 * @af_params: action frame data/info.
  1571	 * @vif: vif to send
  1572	 *
  1573	 * Send an action frame immediately without doing channel synchronization.
  1574	 *
  1575	 * This function waits for a completion event before returning.
  1576	 * The WLC_E_ACTION_FRAME_COMPLETE event will be received when the action
  1577	 * frame is transmitted.
  1578	 */
  1579	static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
  1580					     struct brcmf_fil_af_params_le *af_params,
  1581					     struct brcmf_cfg80211_vif *vif
  1582					     )
  1583	{
  1584		struct brcmf_pub *drvr = p2p->cfg->pub;
  1585		s32 err = 0;
  1586		struct brcmf_fil_action_frame_le *action_frame;
> 1587		u16 action_frame_len;
  1588	
  1589		action_frame = &af_params->action_frame;
  1590		action_frame_len = le16_to_cpu(action_frame->len);
  1591	
  1592		brcmf_dbg(TRACE, "Enter\n");
  1593	
  1594		reinit_completion(&p2p->send_af_done);
  1595		clear_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
  1596		clear_bit(BRCMF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
  1597	
  1598		err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
  1599						sizeof(*af_params));
  1600		if (err) {
  1601			bphy_err(drvr, " sending action frame has failed\n");
  1602			goto exit;
  1603		}
  1604	
  1605		p2p->af_sent_channel = le32_to_cpu(af_params->channel);
  1606		p2p->af_tx_sent_jiffies = jiffies;
  1607	
  1608		if (test_bit(BRCMF_P2P_STATUS_DISCOVER_LISTEN, &p2p->status) &&
  1609		    p2p->af_sent_channel ==
  1610		    ieee80211_frequency_to_channel(p2p->remain_on_channel.center_freq))
  1611			p2p->wait_for_offchan_complete = false;
  1612		else
  1613			p2p->wait_for_offchan_complete = true;
  1614	
  1615		brcmf_dbg(TRACE, "Waiting for %s tx completion event\n",
  1616			  (p2p->wait_for_offchan_complete) ?
  1617			   "off-channel" : "on-channel");
  1618	
  1619		wait_for_completion_timeout(&p2p->send_af_done, P2P_AF_MAX_WAIT_TIME);
  1620	
  1621		if (test_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status)) {
  1622			brcmf_dbg(TRACE, "TX action frame operation is success\n");
  1623		} else {
  1624			err = -EIO;
  1625			brcmf_dbg(TRACE, "TX action frame operation has failed\n");
  1626		}
  1627		/* clear status bit for action tx */
  1628		clear_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
  1629		clear_bit(BRCMF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
  1630	
  1631	exit:
  1632		return err;
  1633	}
  1634	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
