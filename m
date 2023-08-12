Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88A1779E3E
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Aug 2023 10:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjHLImK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Aug 2023 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLImI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Aug 2023 04:42:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A4E2684
        for <linux-wireless@vger.kernel.org>; Sat, 12 Aug 2023 01:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691829730; x=1723365730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pQKF6xXJnW38bRdKHnATqtBgpYbclGlvHTbo9KWLmsk=;
  b=QwuDEAlsimQqgbUmEdV6R2sNnFOr+yibJMFCDIiNVb+c8iOae6BrWreL
   9GOX2pZDdKLc73F5YeuEuinS2dmM+mHp3H7arEOxDSadviUoe90D7KkR9
   loB6yeAUIiQTbcVQSHbPGVB3VRRv0EAvf+hs3SEwstelGr6G0oXoGSnIs
   Rm35LZia4jBTExrTc3NAx034VxbXk7Ff83i9yTgPocKFBWW3eVllofo2D
   TkpqjLRXucp+HhlJELr2a4xUIGUQtrCH+1om7oV4ZDnSEbC1MKvikx8uN
   dmbGNxWwPSC0n5GNlCriU1OyFpgqJPphqXIrJo6wtEy8tGk64yZwsg78b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="402795721"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="402795721"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 01:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="979443397"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="979443397"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Aug 2023 01:42:08 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUkCF-0008QO-1g;
        Sat, 12 Aug 2023 08:42:07 +0000
Date:   Sat, 12 Aug 2023 16:41:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prasurjya.Rohansaikia@microchip.com, linux-wireless@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Ajay.Kathat@microchip.com,
        claudiu.beznea@microchip.com
Subject: Re: [PATCH] wifi: wilc1000: Added back-off algorithm to balance tx
 queue packets.
Message-ID: <202308121630.OJIJ2i9a-lkp@intel.com>
References: <20230810184633.94338-1-prasurjya.rohansaikia@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810184633.94338-1-prasurjya.rohansaikia@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prasurjya-Rohansaikia-microchip-com/wifi-wilc1000-Added-back-off-algorithm-to-balance-tx-queue-packets/20230811-024902
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20230810184633.94338-1-prasurjya.rohansaikia%40microchip.com
patch subject: [PATCH] wifi: wilc1000: Added back-off algorithm to balance tx queue packets.
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230812/202308121630.OJIJ2i9a-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308121630.OJIJ2i9a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308121630.OJIJ2i9a-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/microchip/wilc1000/netdev.c: In function 'wilc_txq_task':
>> drivers/net/wireless/microchip/wilc1000/netdev.c:147:21: warning: variable 'timeout' set but not used [-Wunused-but-set-variable]
     147 |         signed long timeout;
         |                     ^~~~~~~


vim +/timeout +147 drivers/net/wireless/microchip/wilc1000/netdev.c

   142	
   143	static int wilc_txq_task(void *vp)
   144	{
   145		int ret;
   146		u32 txq_count;
 > 147		signed long timeout;
   148		struct wilc *wl = vp;
   149	
   150		complete(&wl->txq_thread_started);
   151		while (1) {
   152			if (wait_for_completion_interruptible(&wl->txq_event))
   153				continue;
   154			if (wl->close) {
   155				complete(&wl->txq_thread_started);
   156	
   157				while (!kthread_should_stop())
   158					schedule();
   159				break;
   160			}
   161			do {
   162				ret = wilc_wlan_handle_txq(wl, &txq_count);
   163				if (txq_count < FLOW_CONTROL_LOWER_THRESHOLD) {
   164					int srcu_idx;
   165					struct wilc_vif *ifc;
   166	
   167					srcu_idx = srcu_read_lock(&wl->srcu);
   168					list_for_each_entry_rcu(ifc, &wl->vif_list,
   169								list) {
   170						if (ifc->mac_opened &&
   171						    netif_queue_stopped(ifc->ndev))
   172							netif_wake_queue(ifc->ndev);
   173					}
   174					srcu_read_unlock(&wl->srcu, srcu_idx);
   175				}
   176				if (ret != WILC_VMM_ENTRY_FULL_RETRY)
   177					break;
   178				/* Back off from sending packets for some time.
   179				 * schedule_timeout will allow RX task to run and free
   180				 * buffers. Setting state to TASK_INTERRUPTIBLE will
   181				 * put the thread back to CPU running queue when it's
   182				 * signaled even if 'timeout' isn't elapsed. This gives
   183				 * faster chance for reserved SK buffers to be freed
   184				 */
   185				set_current_state(TASK_INTERRUPTIBLE);
   186				timeout = schedule_timeout(msecs_to_jiffies(TX_BACKOFF_WEIGHT_MS));
   187			} while (ret == WILC_VMM_ENTRY_FULL_RETRY && !wl->close);
   188		}
   189		return 0;
   190	}
   191	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
