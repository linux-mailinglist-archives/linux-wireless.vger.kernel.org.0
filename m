Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E887460DF
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 16:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfFNOeD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 10:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbfFNOeD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 10:34:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BD0420866;
        Fri, 14 Jun 2019 14:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560522841;
        bh=qs+H/9wcj8KVbAQQa5bX9XNIbXcmQ93GCYDK2C1bEu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A5vqwWA0kAWlizHYni3KBxa+0qYvqHQGNhSsiMswr0utmE3bbmZSHSunWH7zybQqA
         zUirveB/aWpXz7GOcQ3HOwh+4W0zusj3yO4XifQKIAbO7Vi9PSsgzX7fSXmEwMkF9h
         0pJtz4nmCInH3V6XPkqCIGuHwaBgABKaqHdc8p5I=
Date:   Fri, 14 Jun 2019 16:33:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-wireless@vger.kernel.org
Subject: Re: [mac80211-next:master 17/20]
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:3317:3: error: 'const struct
 rate_control_ops' has no member named 'remove_sta_debugfs'; did you mean
 'add_sta_debugfs'?
Message-ID: <20190614143359.GA11550@kroah.com>
References: <201906142122.HSTAYprn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906142122.HSTAYprn%lkp@intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 14, 2019 at 09:17:28PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
> head:   499169fb3a5a27b8322cdd559a09e79e390c211b
> commit: d3f7e94bc458dd1b20bef591ee2b82e2ae631858 [17/20] mac80211: remove unused and unneeded remove_sta_debugfs callback
> config: xtensa-allyesconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout d3f7e94bc458dd1b20bef591ee2b82e2ae631858
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=xtensa 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/net/wireless/intel/iwlwifi/dvm/rs.c:3317:3: error: 'const struct rate_control_ops' has no member named 'remove_sta_debugfs'; did you mean 'add_sta_debugfs'?
>      .remove_sta_debugfs = rs_remove_debugfs,
>       ^~~~~~~~~~~~~~~~~~
>       add_sta_debugfs

Did you apply my "[PATCH 3/5] iwlwifi: dvm: no need to check return
value of debugfs_create function" patch also to this tree?  The 5th
patch in the series depended on it :(

thanks,

greg k-h


> >> drivers/net/wireless/intel/iwlwifi/dvm/rs.c:3317:24: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>      .remove_sta_debugfs = rs_remove_debugfs,
>                            ^~~~~~~~~~~~~~~~~
>    drivers/net/wireless/intel/iwlwifi/dvm/rs.c:3317:24: note: (near initialization for 'rs_ops.get_expected_throughput')
>    cc1: some warnings being treated as errors
> --
> >> drivers/net/wireless/intel/iwlwifi/mvm/rs.c:4138:3: error: 'const struct rate_control_ops' has no member named 'remove_sta_debugfs'; did you mean 'add_sta_debugfs'?
>      .remove_sta_debugfs = rs_remove_sta_debugfs,
>       ^~~~~~~~~~~~~~~~~~
>       add_sta_debugfs
> >> drivers/net/wireless/intel/iwlwifi/mvm/rs.c:4138:24: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>      .remove_sta_debugfs = rs_remove_sta_debugfs,
>                            ^~~~~~~~~~~~~~~~~~~~~
>    drivers/net/wireless/intel/iwlwifi/mvm/rs.c:4138:24: note: (near initialization for 'rs_mvm_ops_drv.get_expected_throughput')
>    cc1: some warnings being treated as errors
> --
> >> drivers/net//wireless/intel/iwlegacy/4965-rs.c:2815:3: error: 'const struct rate_control_ops' has no member named 'remove_sta_debugfs'; did you mean 'add_sta_debugfs'?
>      .remove_sta_debugfs = il4965_rs_remove_debugfs,
>       ^~~~~~~~~~~~~~~~~~
>       add_sta_debugfs
> >> drivers/net//wireless/intel/iwlegacy/4965-rs.c:2815:24: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>      .remove_sta_debugfs = il4965_rs_remove_debugfs,
>                            ^~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net//wireless/intel/iwlegacy/4965-rs.c:2815:24: note: (near initialization for 'rs_4965_ops.get_expected_throughput')
>    cc1: some warnings being treated as errors
> 
> vim +3317 drivers/net/wireless/intel/iwlwifi/dvm/rs.c
> 
> 631ad703b drivers/net/wireless/iwlwifi/dvm/rs.c      Johannes Berg   2014-01-20  3305  
> 631ad703b drivers/net/wireless/iwlwifi/dvm/rs.c      Johannes Berg   2014-01-20  3306  static const struct rate_control_ops rs_ops = {
> b481de9ca drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-25  3307  	.name = RS_NAME,
> b481de9ca drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-25  3308  	.tx_status = rs_tx_status,
> b481de9ca drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-25  3309  	.get_rate = rs_get_rate,
> fe6b23dd3 drivers/net/wireless/iwlwifi/iwl-agn-rs.c  Reinette Chatre 2010-02-22  3310  	.rate_init = rs_rate_init_stub,
> b481de9ca drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-25  3311  	.alloc = rs_alloc,
> b481de9ca drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-25  3312  	.free = rs_free,
> b481de9ca drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-25  3313  	.alloc_sta = rs_alloc_sta,
> b481de9ca drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-25  3314  	.free_sta = rs_free_sta,
> 93dc646ad drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-27  3315  #ifdef CONFIG_MAC80211_DEBUGFS
> 93dc646ad drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-27  3316  	.add_sta_debugfs = rs_add_debugfs,
> 93dc646ad drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-27 @3317  	.remove_sta_debugfs = rs_remove_debugfs,
> 93dc646ad drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-27  3318  #endif
> b481de9ca drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-25  3319  };
> b481de9ca drivers/net/wireless/iwlwifi/iwl-4965-rs.c Zhu Yi          2007-09-25  3320  
> 
> :::::: The code at line 3317 was first introduced by commit
> :::::: 93dc646adb94127ca1c2e74275a85265ec57b9af [PATCH] iwlwifi: add debugfs framework to rate scale
> 
> :::::: TO: Zhu Yi <yi.zhu@intel.com>
> :::::: CC: David S. Miller <davem@sunset.davemloft.net>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


