Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2793A7BE5D2
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 18:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376809AbjJIQEc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 12:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376485AbjJIQEb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 12:04:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62E891
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696867470; x=1728403470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xVGqlS7LaCbb3n5Sy3qivv+XPMNzDr8YRZEIm/seggk=;
  b=RgRvaRO9Yh6yDjqcoJqE8GbuiwAx3Z4H1LDBJhoXYciVTxIKYBSdCbN6
   nD/JhbakBPkVDTorhQL90Gb4dHywupfAPLgYjnYwUOs7S9CmYTVm6QP2m
   ywg0SHPXAH/534f0JBS3NtrQ/p5fw/4Fv60nSWC1vrpLg9AXjIV6d05bZ
   aFH/juXz0lsgt5oIZIqoowC+80lK9KrakCjZa/u0Y0anFGfWzXD7uAQW5
   dkKEovFqiXwLA5xuLKBtOGit5zCcA6vf8YT+v3/wfSzHpLToD1wo4GZIK
   QK6qpBWpCydH0Nk05ysku/OFxVqnhDZkWn6t2HbZlu9Mb/b+6dlA8Cflh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="363527659"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="363527659"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 09:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084361024"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="1084361024"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Oct 2023 09:02:56 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpsib-0000Ku-2u;
        Mon, 09 Oct 2023 16:02:53 +0000
Date:   Tue, 10 Oct 2023 00:02:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org,
        kvalo@kernel.org, quic_jjohnson@quicinc.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
        quic_lingbok@quicinc.com
Subject: Re: [PATCH v5 1/4] wifi: ath12k: add TAS capability for WCN7850
Message-ID: <202310092349.fe3kN7bp-lkp@intel.com>
References: <20231009090149.247211-2-quic_lingbok@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009090149.247211-2-quic_lingbok@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lingbo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3b961e3a412d9d4b70418f53d07847af0a7ea376]

url:    https://github.com/intel-lab-lkp/linux/commits/Lingbo-Kong/wifi-ath12k-add-TAS-capability-for-WCN7850/20231009-170444
base:   3b961e3a412d9d4b70418f53d07847af0a7ea376
patch link:    https://lore.kernel.org/r/20231009090149.247211-2-quic_lingbok%40quicinc.com
patch subject: [PATCH v5 1/4] wifi: ath12k: add TAS capability for WCN7850
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231009/202310092349.fe3kN7bp-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310092349.fe3kN7bp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310092349.fe3kN7bp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath12k/acpi.c:109:6: warning: no previous prototype for 'ath12k_acpi_remove_notify' [-Wmissing-prototypes]
     109 | void ath12k_acpi_remove_notify(struct ath12k_base *ab)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ath12k_acpi_remove_notify +109 drivers/net/wireless/ath/ath12k/acpi.c

   108	
 > 109	void ath12k_acpi_remove_notify(struct ath12k_base *ab)
   110	{
   111		acpi_remove_notify_handler(ACPI_HANDLE(ab->dev),
   112					   ACPI_DEVICE_NOTIFY,
   113					   acpi_dsm_notify);
   114	}
   115	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
