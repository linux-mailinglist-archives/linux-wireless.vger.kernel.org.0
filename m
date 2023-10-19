Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1477D0373
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 22:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjJSUyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 16:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346549AbjJSUyg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 16:54:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0955C2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697748874; x=1729284874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9EfmPm5dXyJV8qls61vRMadilu++IgyKwr6GXvxqs2w=;
  b=GnnBJ4u+xlzL2U6mnkiwRWB15vXSu2ZFoPxq+q5edZnlBTdSunFZ7son
   l9zIla/5WtFINs0gt+ls0/M+YKTyXVFdOYDaMa8TdmTw8cmdquHpBLQ81
   84wHP0l9sPhST81i0yjqktzOb08vbFe61TP4aSFhv/p7gD49f/MHns4vZ
   bZBBYxTPzcfARiH8lUP8XQvYpHzSZ5UKCJH8iZhjIZGGcjLe3kQ0q5at7
   oTXX3i+Hai96mUuTcoskYXpabeebGDZZHLMhj1rOHATl2KFGbNV9QOxmY
   xZbN3mh10f6S16BqUpINvA+QkDI7VnF45dv9TyDkGJ7/efdrLZyDypRu4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="4974260"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="4974260"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 13:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="822978413"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="822978413"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Oct 2023 13:54:30 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qta2G-0002aa-0T;
        Thu, 19 Oct 2023 20:54:28 +0000
Date:   Fri, 20 Oct 2023 04:54:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     oe-kbuild-all@lists.linux.dev, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com, shayne.chen@mediatek.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 10/12] wifi: mt76: mt7996: add wed rx support
Message-ID: <202310200405.OmWXdxOx-lkp@intel.com>
References: <c82411ec41af772cc6e3244662c7de7c04096b15.1697445996.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c82411ec41af772cc6e3244662c7de7c04096b15.1697445996.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on next-20231019]
[cannot apply to wireless/main linus/master v6.6-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/wifi-mt76-mmio-move-mt76_mmio_wed_-init-release-_rx_buf-in-common-code/20231017-141921
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/c82411ec41af772cc6e3244662c7de7c04096b15.1697445996.git.lorenzo%40kernel.org
patch subject: [PATCH v2 10/12] wifi: mt76: mt7996: add wed rx support
config: csky-randconfig-002-20231020 (https://download.01.org/0day-ci/archive/20231020/202310200405.OmWXdxOx-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310200405.OmWXdxOx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310200405.OmWXdxOx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/mediatek/mt76/mt76x02.h:12,
                    from drivers/net/wireless/mediatek/mt76/mt76x02_usb.h:9,
                    from drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c:6:
   drivers/net/wireless/mediatek/mt76/mt76.h: In function 'mt76_token_get':
>> drivers/net/wireless/mediatek/mt76/mt76.h:1672:38: error: 'struct mtk_wed_device' has no member named 'wlan'
    1672 |                 start = dev->mmio.wed.wlan.nbuf;
         |                                      ^
--
   In file included from drivers/net/wireless/mediatek/mt76/mt7615/../mt76_connac.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt7615/../mt76_connac_mcu.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h:11,
                    from drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c:12:
   drivers/net/wireless/mediatek/mt76/mt7615/../mt76.h: In function 'mt76_token_get':
>> drivers/net/wireless/mediatek/mt76/mt7615/../mt76.h:1672:38: error: 'struct mtk_wed_device' has no member named 'wlan'
    1672 |                 start = dev->mmio.wed.wlan.nbuf;
         |                                      ^
--
   In file included from drivers/net/wireless/mediatek/mt76/mt76x0/../mt76x02.h:12,
                    from drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h:20,
                    from drivers/net/wireless/mediatek/mt76/mt76x0/main.c:9:
   drivers/net/wireless/mediatek/mt76/mt76x0/../mt76.h: In function 'mt76_token_get':
>> drivers/net/wireless/mediatek/mt76/mt76x0/../mt76.h:1672:38: error: 'struct mtk_wed_device' has no member named 'wlan'
    1672 |                 start = dev->mmio.wed.wlan.nbuf;
         |                                      ^
--
   In file included from drivers/net/wireless/mediatek/mt76/mt7921/../mt76_connac.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt7921/../mt76_connac_mcu.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt7921/../mt792x.h:10,
                    from drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:6:
   drivers/net/wireless/mediatek/mt76/mt7921/../mt76.h: In function 'mt76_token_get':
>> drivers/net/wireless/mediatek/mt76/mt7921/../mt76.h:1672:38: error: 'struct mtk_wed_device' has no member named 'wlan'
    1672 |                 start = dev->mmio.wed.wlan.nbuf;
         |                                      ^
--
   In file included from drivers/net/wireless/mediatek/mt76/mt76x2/../mt76x02.h:12,
                    from drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h:23,
                    from drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h:11,
                    from drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c:6:
   drivers/net/wireless/mediatek/mt76/mt76x2/../mt76.h: In function 'mt76_token_get':
>> drivers/net/wireless/mediatek/mt76/mt76x2/../mt76.h:1672:38: error: 'struct mtk_wed_device' has no member named 'wlan'
    1672 |                 start = dev->mmio.wed.wlan.nbuf;
         |                                      ^
--
   In file included from drivers/net/wireless/mediatek/mt76/usb_trace.h:10,
                    from drivers/net/wireless/mediatek/mt76/usb_trace.c:10:
   drivers/net/wireless/mediatek/mt76/mt76.h: In function 'mt76_token_get':
>> drivers/net/wireless/mediatek/mt76/mt76.h:1672:38: error: 'struct mtk_wed_device' has no member named 'wlan'
    1672 |                 start = dev->mmio.wed.wlan.nbuf;
         |                                      ^
   In file included from drivers/net/wireless/mediatek/mt76/usb_trace.h:86:
   include/trace/define_trace.h: At top level:
   include/trace/define_trace.h:95:42: fatal error: ./usb_trace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   compilation terminated.
--
   In file included from drivers/net/wireless/mediatek/mt76/mt76x02.h:12,
                    from drivers/net/wireless/mediatek/mt76/mt76x02_trace.h:10,
                    from drivers/net/wireless/mediatek/mt76/mt76x02_trace.c:10:
   drivers/net/wireless/mediatek/mt76/mt76.h: In function 'mt76_token_get':
>> drivers/net/wireless/mediatek/mt76/mt76.h:1672:38: error: 'struct mtk_wed_device' has no member named 'wlan'
    1672 |                 start = dev->mmio.wed.wlan.nbuf;
         |                                      ^
   In file included from drivers/net/wireless/mediatek/mt76/mt76x02_trace.h:87:
   include/trace/define_trace.h: At top level:
   include/trace/define_trace.h:95:42: fatal error: ./mt76x02_trace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   compilation terminated.
--
   In file included from drivers/net/wireless/mediatek/mt76/trace.h:10,
                    from drivers/net/wireless/mediatek/mt76/trace.c:10:
   drivers/net/wireless/mediatek/mt76/mt76.h: In function 'mt76_token_get':
>> drivers/net/wireless/mediatek/mt76/mt76.h:1672:38: error: 'struct mtk_wed_device' has no member named 'wlan'
    1672 |                 start = dev->mmio.wed.wlan.nbuf;
         |                                      ^
   In file included from drivers/net/wireless/mediatek/mt76/trace.h:111:
   include/trace/define_trace.h: At top level:
   include/trace/define_trace.h:95:42: fatal error: ./trace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   compilation terminated.
--
   In file included from drivers/net/wireless/mediatek/mt76/mt76_connac.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt792x.h:10,
                    from drivers/net/wireless/mediatek/mt76/mt792x_trace.h:10,
                    from drivers/net/wireless/mediatek/mt76/mt792x_trace.c:10:
   drivers/net/wireless/mediatek/mt76/mt76.h: In function 'mt76_token_get':
>> drivers/net/wireless/mediatek/mt76/mt76.h:1672:38: error: 'struct mtk_wed_device' has no member named 'wlan'
    1672 |                 start = dev->mmio.wed.wlan.nbuf;
         |                                      ^
   In file included from drivers/net/wireless/mediatek/mt76/mt792x_trace.h:51:
   include/trace/define_trace.h: At top level:
   include/trace/define_trace.h:95:42: fatal error: ./mt792x_trace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   compilation terminated.
--
   In file included from drivers/net/wireless/mediatek/mt76/mt7615/../mt76_connac.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt7615/../mt76_connac_mcu.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h:11,
                    from drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h:10,
                    from drivers/net/wireless/mediatek/mt76/mt7615/trace.c:10:
   drivers/net/wireless/mediatek/mt76/mt7615/../mt76.h: In function 'mt76_token_get':
>> drivers/net/wireless/mediatek/mt76/mt7615/../mt76.h:1672:38: error: 'struct mtk_wed_device' has no member named 'wlan'
    1672 |                 start = dev->mmio.wed.wlan.nbuf;
         |                                      ^
   In file included from drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h:56:
   include/trace/define_trace.h: At top level:
   include/trace/define_trace.h:95:42: fatal error: ./mt7615_trace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   compilation terminated.


vim +1672 drivers/net/wireless/mediatek/mt76/mt76.h

  1665	
  1666	static inline int
  1667	mt76_token_get(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
  1668	{
  1669		int token, start = 0;
  1670	
  1671		if (mtk_wed_device_active(&dev->mmio.wed))
> 1672			start = dev->mmio.wed.wlan.nbuf;
  1673	
  1674		spin_lock_bh(&dev->token_lock);
  1675		token = idr_alloc(&dev->token, *ptxwi, start, start + dev->token_size,
  1676				  GFP_ATOMIC);
  1677		spin_unlock_bh(&dev->token_lock);
  1678	
  1679		return token;
  1680	}
  1681	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
