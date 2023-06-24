Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DF873C9B1
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jun 2023 10:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFXIhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jun 2023 04:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjFXIgj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jun 2023 04:36:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EDA2D65
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jun 2023 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687595763; x=1719131763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ihlOaCvGDOJ59fIBwkQn0dux20KYFVN9Z8xRUhmLkmY=;
  b=e8GlgFXB0VY5eIf71QAdOAoXr3jAkG/oNpyg7taCckrUVw16yDWmu1FU
   7uMxMqfo2NluXO6NbSAU0b0PzJg7JwFnhFvKAZ2OG8NDr0RAE0wsTlsQs
   GV+yxposmTRnNNkMLaYdEIbEyv/HEIu+/7K4RWRV3OS3yynreL7poGhEg
   4Kgwbs3oKGGJOkH4H1N0Fl7hmCna3yK18eDPW3u1tH91EzefY0y5CeZ5L
   AAq3+9/Gl5ZcCXLjzlH68zxQ4MirJ/YY/apuoIKoHtKn0RkR6i4BJxX1q
   JbAif9YB3AjsLul0waDMyDArpBHFKwfKwGAW3YN7rk541WLaa4m4B2aIh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="340521634"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="340521634"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 01:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="805448288"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="805448288"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jun 2023 01:35:56 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCykN-0008t0-1r;
        Sat, 24 Jun 2023 08:35:55 +0000
Date:   Sat, 24 Jun 2023 16:35:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     sean.wang@mediatek.com, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, sean.wang@mediatek.com,
        Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, arowa@google.org,
        frankgor@google.com, kuabhs@google.com, druth@google.com,
        abhishekpandit@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Jing Cai <jing.cai@mediatek.com>,
        Chris Lu <chris.lu@mediatek.com>
Subject: Re: [PATCH v7 3/3] Bluetooth: btusb: mediatek: add MediaTek
 devcoredump support
Message-ID: <202306241617.Dw81i6id-lkp@intel.com>
References: <ed1d0e9fe7758dac8a05dcff97c7dcb8e9b0be39.1687565769.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1d0e9fe7758dac8a05dcff97c7dcb8e9b0be39.1687565769.git.objelf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20230623]
[cannot apply to bluetooth/master wireless/main wireless-next/main linus/master v6.4-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-mediatek-com/Bluetooth-btmtk-introduce-btmtk-reset-work/20230624-100756
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/ed1d0e9fe7758dac8a05dcff97c7dcb8e9b0be39.1687565769.git.objelf%40gmail.com
patch subject: [PATCH v7 3/3] Bluetooth: btusb: mediatek: add MediaTek devcoredump support
config: x86_64-randconfig-a002-20230621 (https://download.01.org/0day-ci/archive/20230624/202306241617.Dw81i6id-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230624/202306241617.Dw81i6id-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306241617.Dw81i6id-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bluetooth/btmtk.c: In function 'btmtk_process_coredump':
>> drivers/bluetooth/btmtk.c:381:44: error: 'struct hci_dev' has no member named 'dump'
     381 |                 schedule_delayed_work(&hdev->dump.dump_timeout,
         |                                            ^~


vim +381 drivers/bluetooth/btmtk.c

   364	
   365	int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
   366	{
   367		struct btmediatek_data *data = hci_get_priv(hdev);
   368		int err;
   369	
   370		if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
   371			return 0;
   372	
   373		switch (data->cd_info.state) {
   374		case HCI_DEVCOREDUMP_IDLE:
   375			err = hci_devcd_init(hdev, MTK_COREDUMP_SIZE);
   376			if (err < 0)
   377				break;
   378			data->cd_info.cnt = 0;
   379	
   380			/* It is supposed coredump can be done within 5 seconds */
 > 381			schedule_delayed_work(&hdev->dump.dump_timeout,
   382					      msecs_to_jiffies(5000));
   383			fallthrough;
   384		case HCI_DEVCOREDUMP_ACTIVE:
   385		default:
   386			err = hci_devcd_append(hdev, skb);
   387			if (err < 0)
   388				break;
   389			data->cd_info.cnt++;
   390	
   391			/* Mediatek coredump data would be more than MTK_COREDUMP_NUM */
   392			if (data->cd_info.cnt > MTK_COREDUMP_NUM &&
   393			    skb->len > sizeof(MTK_COREDUMP_END) &&
   394			    !memcmp((char *)&skb->data[skb->len - sizeof(MTK_COREDUMP_END)],
   395				    MTK_COREDUMP_END, sizeof(MTK_COREDUMP_END) - 1)) {
   396				bt_dev_info(hdev, "Mediatek coredump end");
   397				hci_devcd_complete(hdev);
   398			}
   399	
   400			break;
   401		}
   402	
   403		if (err < 0)
   404			kfree_skb(skb);
   405	
   406		return err;
   407	}
   408	EXPORT_SYMBOL_GPL(btmtk_process_coredump);
   409	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
