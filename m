Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93816C0A4F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 07:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCTGA5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 02:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCTGAr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 02:00:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD5E1CF62
        for <linux-wireless@vger.kernel.org>; Sun, 19 Mar 2023 23:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9943B80D38
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 06:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5061BC433D2;
        Mon, 20 Mar 2023 06:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679292043;
        bh=3GM8t361YjEkmaPN7P78S+nv1eJsGHXiIlh/lQR2zpM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ghOwE/7qg38eqmg6OLzC1IBsG4wxIUoin341b1zYQX//WO2L1i8a+XmRfidmfkBec
         nSXSsX9NM6oeNXWm7PvITtpkCIKq5/IfbPNFlLi/kjSiYVJzJu3ByOKjcsGf7Szmx4
         khJUl0yPdMJQrkd0n0ebvr53yPORk2NwOnQPTmd9ShPrYy2K9p72PpMNkyDz9R4H4a
         ZW1F5jYRUs9Pu3/2+nxG3s49mmFdXYHt7/1JpWQxdx8sPL35ZJq9ecP71gUAcwAuvz
         flNVpOHByP395k6slqkuFD6f047FYsQtP45iqOSx846cqmewcHcxv51lbnqMsogCxu
         j9cLVHUOwKlnQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [linux-next:master 2761/4036] drivers/net/wireless/legacy/ray_cs.c:628:17: warning: 'strncpy' specified bound 32 equals destination size
References: <202303161521.jbGbaFjJ-lkp@intel.com>
Date:   Mon, 20 Mar 2023 08:00:40 +0200
In-Reply-To: <202303161521.jbGbaFjJ-lkp@intel.com> (kernel test robot's
        message of "Thu, 16 Mar 2023 15:40:55 +0800")
Message-ID: <873560hshj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

kernel test robot <lkp@intel.com> writes:

> Hi Kalle,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   6f72958a49f68553f2b6ff713e8c8e51a34c1e1e
> commit: 298e50ad8eb8fa12ea68bb2da45bb8ef4edcd0ec [2761/4036] wifi:
> move raycs, wl3501 and rndis_wlan to legacy directory
> config: parisc-allmodconfig
> (https://download.01.org/0day-ci/archive/20230316/202303161521.jbGbaFjJ-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=298e50ad8eb8fa12ea68bb2da45bb8ef4edcd0ec
>         git remote add linux-next
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout 298e50ad8eb8fa12ea68bb2da45bb8ef4edcd0ec
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> make.cross W=1 O=build_dir ARCH=parisc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/misc/
> drivers/net/mdio/ drivers/net/wireless/legacy/ drivers/pci/controller/
> drivers/rtc/ drivers/thermal/mediatek/ drivers/tty/serial/
> drivers/usb/host/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303161521.jbGbaFjJ-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In function 'init_startup_params',
>        inlined from 'ray_init' at drivers/net/wireless/legacy/ray_cs.c:506:2:
>>> drivers/net/wireless/legacy/ray_cs.c:628:17: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>      628 |                 strncpy(local->sparm.b4.a_current_ess_id, essid, ESSID_SIZE);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is an old warning, it just reappeared as I moved ray_cs to a
different directory.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
