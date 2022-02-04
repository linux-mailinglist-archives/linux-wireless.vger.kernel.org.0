Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47F4AA329
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 23:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350168AbiBDWd6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 17:33:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:48541 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241600AbiBDWd5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 17:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644014037; x=1675550037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uf8KEKKcMkQwU490A/ltDNDtyX6BjanrwMvyTaGtG90=;
  b=Vm2ghJK81MDbH/+Wi1IN9ak7jTga5/Py+RlL5jSO/ZOvKWDribf5Le2D
   jPHszbPGlompbLu94kQzwKXfGequntSm5mfMquMhnF8/zSgr1KCItsau5
   B5KgaAByuZLLIhMqjxzR/H5zyrozIsTamfjnGXadS7CoXaUeXy6TQXc94
   nfDRxayi3i7pc1uOi3r3LMfS+sR5E+OrdC8STBuR6ep7QFFV3sDxJmFG8
   qPIeysmlQQdg+nvhDPbgkIt6LA4fLq9zx4ZQNr9VEexilg1XPWe7ywbKd
   X7KB9wjwu3//gQMGRWtuwgBwatCte5o03vhNzjg6KnR8Tq+Ei5beFMzW2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="309199550"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="309199550"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 14:33:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="566879818"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2022 14:33:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG79O-000YFh-PT; Fri, 04 Feb 2022 22:33:54 +0000
Date:   Sat, 5 Feb 2022 06:33:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] mac80211_hwsim: check TX and STA bandwidth
Message-ID: <202202050604.dzCxQjWk-lkp@intel.com>
References: <20220204174105.5026d3892bf6.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204174105.5026d3892bf6.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.17-rc2 next-20220204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Johannes-Berg/mac80211_hwsim-check-TX-and-STA-bandwidth/20220205-004233
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dcb85f85fa6f142aae1fe86f399d4503d49f2b60
config: hexagon-randconfig-r041-20220204 (https://download.01.org/0day-ci/archive/20220205/202202050604.dzCxQjWk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/99f1c0b151e550eed22429c2eb48876108bf3de7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Johannes-Berg/mac80211_hwsim-check-TX-and-STA-bandwidth/20220205-004233
        git checkout 99f1c0b151e550eed22429c2eb48876108bf3de7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/net/wireless/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/mac80211_hwsim.c:1631:26: warning: variable 'confbw' set but not used [-Wunused-but-set-variable]
           enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
                                   ^
   1 warning generated.


vim +/confbw +1631 drivers/net/wireless/mac80211_hwsim.c

  1620	
  1621	static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
  1622				      struct ieee80211_tx_control *control,
  1623				      struct sk_buff *skb)
  1624	{
  1625		struct mac80211_hwsim_data *data = hw->priv;
  1626		struct ieee80211_tx_info *txi = IEEE80211_SKB_CB(skb);
  1627		struct ieee80211_hdr *hdr = (void *)skb->data;
  1628		struct ieee80211_chanctx_conf *chanctx_conf;
  1629		struct ieee80211_channel *channel;
  1630		bool ack;
> 1631		enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
  1632		u32 _portid, i;
  1633	
  1634		if (WARN_ON(skb->len < 10)) {
  1635			/* Should not happen; just a sanity check for addr1 use */
  1636			ieee80211_free_txskb(hw, skb);
  1637			return;
  1638		}
  1639	
  1640		if (!data->use_chanctx) {
  1641			channel = data->channel;
  1642			confbw = data->bw;
  1643		} else if (txi->hw_queue == 4) {
  1644			channel = data->tmp_chan;
  1645		} else {
  1646			chanctx_conf = rcu_dereference(txi->control.vif->chanctx_conf);
  1647			if (chanctx_conf) {
  1648				channel = chanctx_conf->def.chan;
  1649				confbw = chanctx_conf->def.width;
  1650			} else {
  1651				channel = NULL;
  1652			}
  1653		}
  1654	
  1655		if (WARN(!channel, "TX w/o channel - queue = %d\n", txi->hw_queue)) {
  1656			ieee80211_free_txskb(hw, skb);
  1657			return;
  1658		}
  1659	
  1660		if (data->idle && !data->tmp_chan) {
  1661			wiphy_dbg(hw->wiphy, "Trying to TX when idle - reject\n");
  1662			ieee80211_free_txskb(hw, skb);
  1663			return;
  1664		}
  1665	
  1666		if (txi->control.vif)
  1667			hwsim_check_magic(txi->control.vif);
  1668		if (control->sta)
  1669			hwsim_check_sta_magic(control->sta);
  1670	
  1671		if (ieee80211_hw_check(hw, SUPPORTS_RC_TABLE))
  1672			ieee80211_get_tx_rates(txi->control.vif, control->sta, skb,
  1673					       txi->control.rates,
  1674					       ARRAY_SIZE(txi->control.rates));
  1675	
  1676		for (i = 0; i < ARRAY_SIZE(txi->control.rates); i++) {
  1677			u16 rflags = txi->control.rates[i].flags;
  1678			/* initialize to data->bw for 5/10 MHz handling */
  1679			enum nl80211_chan_width bw = data->bw;
  1680	
  1681			if (txi->control.rates[i].idx == -1)
  1682				break;
  1683	
  1684			if (rflags & IEEE80211_TX_RC_40_MHZ_WIDTH)
  1685				bw = NL80211_CHAN_WIDTH_40;
  1686			else if (rflags & IEEE80211_TX_RC_80_MHZ_WIDTH)
  1687				bw = NL80211_CHAN_WIDTH_80;
  1688			else if (rflags & IEEE80211_TX_RC_160_MHZ_WIDTH)
  1689				bw = NL80211_CHAN_WIDTH_160;
  1690	
  1691			if (WARN_ON(hwsim_get_chanwidth(bw) > hwsim_get_chanwidth(data->bw)))
  1692				return;
  1693		}
  1694	
  1695		if (skb->len >= 24 + 8 &&
  1696		    ieee80211_is_probe_resp(hdr->frame_control)) {
  1697			/* fake header transmission time */
  1698			struct ieee80211_mgmt *mgmt;
  1699			struct ieee80211_rate *txrate;
  1700			/* TODO: get MCS */
  1701			int bitrate = 100;
  1702			u64 ts;
  1703	
  1704			mgmt = (struct ieee80211_mgmt *)skb->data;
  1705			txrate = ieee80211_get_tx_rate(hw, txi);
  1706			if (txrate)
  1707				bitrate = txrate->bitrate;
  1708			ts = mac80211_hwsim_get_tsf_raw();
  1709			mgmt->u.probe_resp.timestamp =
  1710				cpu_to_le64(ts + data->tsf_offset +
  1711					    24 * 8 * 10 / bitrate);
  1712		}
  1713	
  1714		mac80211_hwsim_monitor_rx(hw, skb, channel);
  1715	
  1716		/* wmediumd mode check */
  1717		_portid = READ_ONCE(data->wmediumd);
  1718	
  1719		if (_portid || hwsim_virtio_enabled)
  1720			return mac80211_hwsim_tx_frame_nl(hw, skb, _portid, channel);
  1721	
  1722		/* NO wmediumd detected, perfect medium simulation */
  1723		data->tx_pkts++;
  1724		data->tx_bytes += skb->len;
  1725		ack = mac80211_hwsim_tx_frame_no_nl(hw, skb, channel);
  1726	
  1727		if (ack && skb->len >= 16)
  1728			mac80211_hwsim_monitor_ack(channel, hdr->addr2);
  1729	
  1730		ieee80211_tx_info_clear_status(txi);
  1731	
  1732		/* frame was transmitted at most favorable rate at first attempt */
  1733		txi->control.rates[0].count = 1;
  1734		txi->control.rates[1].idx = -1;
  1735	
  1736		if (!(txi->flags & IEEE80211_TX_CTL_NO_ACK) && ack)
  1737			txi->flags |= IEEE80211_TX_STAT_ACK;
  1738		ieee80211_tx_status_irqsafe(hw, skb);
  1739	}
  1740	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
