Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EFC57004B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 13:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiGKLXl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 07:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiGKLXB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 07:23:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD1A33E0C
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657536627; x=1689072627;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FrHCt7v4t8SfV2FTg1+5hc8IdkFlNL97VHF6bgRLOKM=;
  b=d3V1J6BKF/2RJhaMqzATqzccIeSEKHGCo8Poqtf6Vh4DeiH/l/NjIYpH
   2YbIa0/RzBH7Ika7z5x7Okf54mf2Dn5z2UXt3kiRUxlvG0ZwuUjHm9Oj3
   hcL/eRDDDNEsRLM1k94LeuPB2b35dumAow3h0KPi1uSRbT7Xsn8xguOrP
   IvuI8uvkR73lxw4IxvnqE8CsEV+VHjRelzocPXpvX8XEIKrDQWnrw3K5M
   OISIJ5pMOpLNERSthqT4GwhS7eGOeB2+WiyRjQ7MoRuhBpTXbumMdobDm
   d7stV0H1sr5w0m3sqPgGddnvjz2k3WDbMmEX5HGkDIrWcD370v+iKk2qh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="285373121"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="285373121"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 03:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="544965711"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2022 03:50:24 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAqzg-0000h3-05;
        Mon, 11 Jul 2022 10:50:24 +0000
Date:   Mon, 11 Jul 2022 18:49:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeongik Cha <jeongik@google.com>
Cc:     kbuild-all@lists.01.org, Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [wireless-next:main 6/6]
 drivers/net/wireless/mac80211_hwsim.c:1431:37: warning: cast to pointer from
 integer of different size
Message-ID: <202207111835.B5zUbIhZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
head:   4ee186fa7e40ae06ebbfbad77e249e3746e14114
commit: 4ee186fa7e40ae06ebbfbad77e249e3746e14114 [6/6] wifi: mac80211_hwsim: fix race condition in pending packet
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220711/202207111835.B5zUbIhZ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=4ee186fa7e40ae06ebbfbad77e249e3746e14114
        git remote add wireless-next https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
        git fetch --no-tags wireless-next main
        git checkout 4ee186fa7e40ae06ebbfbad77e249e3746e14114
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/mac80211_hwsim.c: In function 'mac80211_hwsim_tx_frame_nl':
>> drivers/net/wireless/mac80211_hwsim.c:1431:37: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1431 |         info->rate_driver_data[0] = (void *)cookie;
         |                                     ^
   drivers/net/wireless/mac80211_hwsim.c: In function 'hwsim_tx_info_frame_received_nl':
>> drivers/net/wireless/mac80211_hwsim.c:4213:30: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    4213 |                 skb_cookie = (u64)txi->rate_driver_data[0];
         |                              ^


vim +1431 drivers/net/wireless/mac80211_hwsim.c

6e3d6ca16319d4 Benjamin Beichler 2018-01-10  1346  
7882513bacb176 Javier Lopez      2011-06-01  1347  static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
7882513bacb176 Javier Lopez      2011-06-01  1348  				       struct sk_buff *my_skb,
626c30f9e77354 Weilun Du         2021-05-06  1349  				       int dst_portid,
626c30f9e77354 Weilun Du         2021-05-06  1350  				       struct ieee80211_channel *channel)
7882513bacb176 Javier Lopez      2011-06-01  1351  {
7882513bacb176 Javier Lopez      2011-06-01  1352  	struct sk_buff *skb;
7882513bacb176 Javier Lopez      2011-06-01  1353  	struct mac80211_hwsim_data *data = hw->priv;
7882513bacb176 Javier Lopez      2011-06-01  1354  	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) my_skb->data;
7882513bacb176 Javier Lopez      2011-06-01  1355  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(my_skb);
7882513bacb176 Javier Lopez      2011-06-01  1356  	void *msg_head;
7882513bacb176 Javier Lopez      2011-06-01  1357  	unsigned int hwsim_flags = 0;
7882513bacb176 Javier Lopez      2011-06-01  1358  	int i;
7882513bacb176 Javier Lopez      2011-06-01  1359  	struct hwsim_tx_rate tx_attempts[IEEE80211_TX_MAX_RATES];
6e3d6ca16319d4 Benjamin Beichler 2018-01-10  1360  	struct hwsim_tx_rate_flag tx_attempts_flags[IEEE80211_TX_MAX_RATES];
4ee186fa7e40ae Jeongik Cha       2022-07-04  1361  	u64 cookie;
7882513bacb176 Javier Lopez      2011-06-01  1362  
7882513bacb176 Javier Lopez      2011-06-01  1363  	if (data->ps != PS_DISABLED)
7882513bacb176 Javier Lopez      2011-06-01  1364  		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
7882513bacb176 Javier Lopez      2011-06-01  1365  	/* If the queue contains MAX_QUEUE skb's drop some */
7882513bacb176 Javier Lopez      2011-06-01  1366  	if (skb_queue_len(&data->pending) >= MAX_QUEUE) {
f5d32a7b107134 Colin Ian King    2021-10-26  1367  		/* Dropping until WARN_QUEUE level */
2155c3f82327bd Ben Greear        2014-10-22  1368  		while (skb_queue_len(&data->pending) >= WARN_QUEUE) {
b7bc9679e4dffe Ben Greear        2014-09-25  1369  			ieee80211_free_txskb(hw, skb_dequeue(&data->pending));
2155c3f82327bd Ben Greear        2014-10-22  1370  			data->tx_dropped++;
2155c3f82327bd Ben Greear        2014-10-22  1371  		}
7882513bacb176 Javier Lopez      2011-06-01  1372  	}
7882513bacb176 Javier Lopez      2011-06-01  1373  
58050fce353093 Thomas Graf       2012-06-28  1374  	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_ATOMIC);
7882513bacb176 Javier Lopez      2011-06-01  1375  	if (skb == NULL)
7882513bacb176 Javier Lopez      2011-06-01  1376  		goto nla_put_failure;
7882513bacb176 Javier Lopez      2011-06-01  1377  
7882513bacb176 Javier Lopez      2011-06-01  1378  	msg_head = genlmsg_put(skb, 0, 0, &hwsim_genl_family, 0,
7882513bacb176 Javier Lopez      2011-06-01  1379  			       HWSIM_CMD_FRAME);
7882513bacb176 Javier Lopez      2011-06-01  1380  	if (msg_head == NULL) {
62b093b375e3c1 Lubomir Rintel    2017-09-18  1381  		pr_debug("mac80211_hwsim: problem with msg_head\n");
7882513bacb176 Javier Lopez      2011-06-01  1382  		goto nla_put_failure;
7882513bacb176 Javier Lopez      2011-06-01  1383  	}
7882513bacb176 Javier Lopez      2011-06-01  1384  
354210f8046cc8 Bob Copeland      2015-12-19  1385  	if (nla_put(skb, HWSIM_ATTR_ADDR_TRANSMITTER,
354210f8046cc8 Bob Copeland      2015-12-19  1386  		    ETH_ALEN, data->addresses[1].addr))
633c938940cdb7 David S. Miller   2012-04-01  1387  		goto nla_put_failure;
7882513bacb176 Javier Lopez      2011-06-01  1388  
7882513bacb176 Javier Lopez      2011-06-01  1389  	/* We get the skb->data */
633c938940cdb7 David S. Miller   2012-04-01  1390  	if (nla_put(skb, HWSIM_ATTR_FRAME, my_skb->len, my_skb->data))
633c938940cdb7 David S. Miller   2012-04-01  1391  		goto nla_put_failure;
7882513bacb176 Javier Lopez      2011-06-01  1392  
7882513bacb176 Javier Lopez      2011-06-01  1393  	/* We get the flags for this transmission, and we translate them to
7882513bacb176 Javier Lopez      2011-06-01  1394  	   wmediumd flags  */
7882513bacb176 Javier Lopez      2011-06-01  1395  
7882513bacb176 Javier Lopez      2011-06-01  1396  	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)
7882513bacb176 Javier Lopez      2011-06-01  1397  		hwsim_flags |= HWSIM_TX_CTL_REQ_TX_STATUS;
7882513bacb176 Javier Lopez      2011-06-01  1398  
7882513bacb176 Javier Lopez      2011-06-01  1399  	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
7882513bacb176 Javier Lopez      2011-06-01  1400  		hwsim_flags |= HWSIM_TX_CTL_NO_ACK;
7882513bacb176 Javier Lopez      2011-06-01  1401  
633c938940cdb7 David S. Miller   2012-04-01  1402  	if (nla_put_u32(skb, HWSIM_ATTR_FLAGS, hwsim_flags))
633c938940cdb7 David S. Miller   2012-04-01  1403  		goto nla_put_failure;
7882513bacb176 Javier Lopez      2011-06-01  1404  
626c30f9e77354 Weilun Du         2021-05-06  1405  	if (nla_put_u32(skb, HWSIM_ATTR_FREQ, channel->center_freq))
4f86ed8f87c07b Ben Greear        2014-10-27  1406  		goto nla_put_failure;
4f86ed8f87c07b Ben Greear        2014-10-27  1407  
7882513bacb176 Javier Lopez      2011-06-01  1408  	/* We get the tx control (rate and retries) info*/
7882513bacb176 Javier Lopez      2011-06-01  1409  
7882513bacb176 Javier Lopez      2011-06-01  1410  	for (i = 0; i < IEEE80211_TX_MAX_RATES; i++) {
7882513bacb176 Javier Lopez      2011-06-01  1411  		tx_attempts[i].idx = info->status.rates[i].idx;
6e3d6ca16319d4 Benjamin Beichler 2018-01-10  1412  		tx_attempts_flags[i].idx = info->status.rates[i].idx;
7882513bacb176 Javier Lopez      2011-06-01  1413  		tx_attempts[i].count = info->status.rates[i].count;
6e3d6ca16319d4 Benjamin Beichler 2018-01-10  1414  		tx_attempts_flags[i].flags =
6e3d6ca16319d4 Benjamin Beichler 2018-01-10  1415  				trans_tx_rate_flags_ieee2hwsim(
6e3d6ca16319d4 Benjamin Beichler 2018-01-10  1416  						&info->status.rates[i]);
7882513bacb176 Javier Lopez      2011-06-01  1417  	}
7882513bacb176 Javier Lopez      2011-06-01  1418  
633c938940cdb7 David S. Miller   2012-04-01  1419  	if (nla_put(skb, HWSIM_ATTR_TX_INFO,
7882513bacb176 Javier Lopez      2011-06-01  1420  		    sizeof(struct hwsim_tx_rate)*IEEE80211_TX_MAX_RATES,
633c938940cdb7 David S. Miller   2012-04-01  1421  		    tx_attempts))
633c938940cdb7 David S. Miller   2012-04-01  1422  		goto nla_put_failure;
7882513bacb176 Javier Lopez      2011-06-01  1423  
6e3d6ca16319d4 Benjamin Beichler 2018-01-10  1424  	if (nla_put(skb, HWSIM_ATTR_TX_INFO_FLAGS,
6e3d6ca16319d4 Benjamin Beichler 2018-01-10  1425  		    sizeof(struct hwsim_tx_rate_flag) * IEEE80211_TX_MAX_RATES,
6e3d6ca16319d4 Benjamin Beichler 2018-01-10  1426  		    tx_attempts_flags))
6e3d6ca16319d4 Benjamin Beichler 2018-01-10  1427  		goto nla_put_failure;
6e3d6ca16319d4 Benjamin Beichler 2018-01-10  1428  
7882513bacb176 Javier Lopez      2011-06-01  1429  	/* We create a cookie to identify this skb */
4ee186fa7e40ae Jeongik Cha       2022-07-04  1430  	cookie = (u64)atomic64_inc_return(&data->pending_cookie);
959eb2fd70df86 Johannes Berg     2015-11-06 @1431  	info->rate_driver_data[0] = (void *)cookie;
08f4cbb8f207e2 Nicolas Dichtel   2016-04-26  1432  	if (nla_put_u64_64bit(skb, HWSIM_ATTR_COOKIE, cookie, HWSIM_ATTR_PAD))
633c938940cdb7 David S. Miller   2012-04-01  1433  		goto nla_put_failure;
7882513bacb176 Javier Lopez      2011-06-01  1434  
7882513bacb176 Javier Lopez      2011-06-01  1435  	genlmsg_end(skb, msg_head);
5d44fe7c9808c5 Erel Geron        2020-03-05  1436  
5d44fe7c9808c5 Erel Geron        2020-03-05  1437  	if (hwsim_virtio_enabled) {
5d44fe7c9808c5 Erel Geron        2020-03-05  1438  		if (hwsim_tx_virtio(data, skb))
5d44fe7c9808c5 Erel Geron        2020-03-05  1439  			goto err_free_txskb;
5d44fe7c9808c5 Erel Geron        2020-03-05  1440  	} else {
f21e4d8ed16bb9 Martin Willi      2016-05-14  1441  		if (hwsim_unicast_netgroup(data, skb, dst_portid))
f2831e2007810b Bob Copeland      2015-02-05  1442  			goto err_free_txskb;
5d44fe7c9808c5 Erel Geron        2020-03-05  1443  	}
7882513bacb176 Javier Lopez      2011-06-01  1444  
7882513bacb176 Javier Lopez      2011-06-01  1445  	/* Enqueue the packet */
7882513bacb176 Javier Lopez      2011-06-01  1446  	skb_queue_tail(&data->pending, my_skb);
2155c3f82327bd Ben Greear        2014-10-22  1447  	data->tx_pkts++;
2155c3f82327bd Ben Greear        2014-10-22  1448  	data->tx_bytes += my_skb->len;
7882513bacb176 Javier Lopez      2011-06-01  1449  	return;
265dc7f0964e4d Jouni Malinen     2009-12-04  1450  
7882513bacb176 Javier Lopez      2011-06-01  1451  nla_put_failure:
f2831e2007810b Bob Copeland      2015-02-05  1452  	nlmsg_free(skb);
f2831e2007810b Bob Copeland      2015-02-05  1453  err_free_txskb:
62b093b375e3c1 Lubomir Rintel    2017-09-18  1454  	pr_debug("mac80211_hwsim: error occurred in %s\n", __func__);
b7bc9679e4dffe Ben Greear        2014-09-25  1455  	ieee80211_free_txskb(hw, my_skb);
2155c3f82327bd Ben Greear        2014-10-22  1456  	data->tx_failed++;
7882513bacb176 Javier Lopez      2011-06-01  1457  }
7882513bacb176 Javier Lopez      2011-06-01  1458  

:::::: The code at line 1431 was first introduced by commit
:::::: 959eb2fd70df86a089e9e31be654462235952a24 mac80211_hwsim: stop using pointers as cookies

:::::: TO: Johannes Berg <johannes.berg@intel.com>
:::::: CC: Johannes Berg <johannes.berg@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
