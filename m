Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465516071FB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 10:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJUIUW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 04:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJUIUT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 04:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5C38C010
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 01:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBF7361DDF
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 08:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF98C433B5;
        Fri, 21 Oct 2022 08:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666340416;
        bh=AL7mXijTs6cQLRrsvSBh0aBo019UQxlKxyn5vhQ+MhM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TwMlRFBPBMzrJvbmMOfgbS+lp/iyywdV5zNYOm6pWMY5RUERn1yX3jVPQEFSJ2CJn
         nKnrVgC72ZN7Trmqo4pP8Td6rAajwkHDE3MGL0XBdcrB2cYzBzT91/zQ+/xEfRSFSr
         H1eTJ9drKNyRnic98r76bPjyws5kjKwp45Z06UZVO6niW63lfPDkRFukBB7PR0t/JI
         LD6O/hm8aCaSlErEyuFHKv2qf4P8aECkMADkTRKf7nvTn1vZT/wDGb1KEPloyvrIam
         Lj0rUafs4Hl0BiDppBbQ3fh4PNxNNTpWAGEErQrJTvKh8KN777UNGYjhuRoJ4B1jJO
         j5PHjzHpJOpXA==
From:   Kalle Valo <kvalo@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Bitterblue Smith <rtl8821cerfe2@gmail.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [linux-next:master 637/2652] drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:432:7: warning: variable 'hw_ctrl_s1' is used uninitialized whenever 'if' condition is false
References: <202210211531.zEaM6hBM-lkp@intel.com>
Date:   Fri, 21 Oct 2022 11:20:10 +0300
In-Reply-To: <202210211531.zEaM6hBM-lkp@intel.com> (kernel test robot's
        message of "Fri, 21 Oct 2022 15:43:30 +0800")
Message-ID: <87edv1lhad.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   4d48f589d294ddc5e01d3b0dc7cecc55324c05ca
> commit: c888183b21f36a247bb166ca9365705611bea847 [637/2652] wifi: rtl8xxxu: Support new chip RTL8188FU
> config: i386-allyesconfig
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c888183b21f36a247bb166ca9365705611bea847
>         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout c888183b21f36a247bb166ca9365705611bea847
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/ drivers/net/wireless/ath/ath11k/ drivers/net/wireless/realtek/rtl8xxxu/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:432:7: warning: variable 'hw_ctrl_s1' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>                    if (hw_ctrl) {
>                        ^~~~~~~
>    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:440:7: note: uninitialized use occurs here
>                    if (hw_ctrl_s1 || sw_ctrl_s1) {
>                        ^~~~~~~~~~
>    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:432:3: note: remove the 'if' if its condition is always true
>                    if (hw_ctrl) {
>                    ^~~~~~~~~~~~~
>    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:415:45: note: initialize the variable 'hw_ctrl_s1' to silence this warning
>            bool do_notch, hw_ctrl, sw_ctrl, hw_ctrl_s1, sw_ctrl_s1;
>                                                       ^
>                                                        = 0
>    1 warning generated.

Bitterblue, could you submit a patch to fix this, please?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
