Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32B8514200
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 07:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354289AbiD2FxV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 01:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349487AbiD2FxU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 01:53:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98861B1AA3
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 22:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D456ECE3023
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 05:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0555C385AF;
        Fri, 29 Apr 2022 05:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651211398;
        bh=xJePtlHHxfCeXvoi3vaEmotZA6RhqZcuC+RCv+7KKWg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZXtuLhyImTLJKRu2ApJ4PU8gAUWPSKcjRnTg9rOP+JPDjDxvWsz3cJsUeskp5dUzC
         8sh8mA8IUG+HZowMdZxyeZZ88pRL9Tq+bLh3UwgEBYlFX0JQo6aTbxh2aG8KsReCx0
         Vg96qTFcjjaTPz4ClGDALHlRHQskx1Cj7kyY6Y67/b5JlLE/j0wE+ma9nEWmen4+ee
         ZT/oJc4TfQ89sOlo9lwk0IW1s6bZDnPk8AVBuOlNB7uoxhV1Vo7PzEZHnWNW4xHdXJ
         3a4r8sw5yg2BjIA2u9n6TGKRqVw7eConqp4bdtezA9aHxoYZwIy+5PR5Z7UzQ6PQpt
         pW9xISJ0bKdtQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Srinivasan Raju <srini.raju@purelifi.com>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [linux-next:master 5852/7483] drivers/net/wireless/purelifi/plfxlc/chip.c:33:14: sparse: sparse: cast to restricted __le16
References: <202204290641.UGDfvg2b-lkp@intel.com>
Date:   Fri, 29 Apr 2022 08:49:54 +0300
In-Reply-To: <202204290641.UGDfvg2b-lkp@intel.com> (kernel test robot's
        message of "Fri, 29 Apr 2022 06:12:58 +0800")
Message-ID: <87bkwkfngd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   bdc61aad77faf67187525028f1f355eff3849f22
> commit: 68d57a07bfe5bb29b80cd8b8fa24c9d1ea104124 [5852/7483] wireless:
> add plfxlc driver for pureLiFi X, XL, XC devices
> config: alpha-allmodconfig
> (https://download.01.org/0day-ci/archive/20220429/202204290641.UGDfvg2b-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 11.3.0
> reproduce:
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         #
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=68d57a07bfe5bb29b80cd8b8fa24c9d1ea104124
>         git remote add linux-next
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout 68d57a07bfe5bb29b80cd8b8fa24c9d1ea104124
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0
> make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir
> ARCH=alpha SHELL=/bin/bash drivers/net/wireless/purelifi/plfxlc/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>>> drivers/net/wireless/purelifi/plfxlc/chip.c:33:14: sparse: sparse:
>>> cast to restricted __le16
>>> drivers/net/wireless/purelifi/plfxlc/chip.c:36:31: sparse: sparse:
>>> incorrect type in assignment (different base types) @@ expected
>>> unsigned short [usertype] beacon_interval @@ got restricted __le16
>>> [usertype] @@
>    drivers/net/wireless/purelifi/plfxlc/chip.c:36:31: sparse:     expected unsigned short [usertype] beacon_interval
>    drivers/net/wireless/purelifi/plfxlc/chip.c:36:31: sparse:     got restricted __le16 [usertype]
>
> vim +33 drivers/net/wireless/purelifi/plfxlc/chip.c
>
>     27	
>     28	int plfxlc_set_beacon_interval(struct plfxlc_chip *chip, u16 interval,
>     29				       u8 dtim_period, int type)
>     30	{
>     31		if (!interval ||
>     32		    (chip->beacon_set &&
>   > 33		     le16_to_cpu(chip->beacon_interval) == interval))
>     34			return 0;
>     35	
>   > 36		chip->beacon_interval = cpu_to_le16(interval);
>     37		chip->beacon_set = true;
>     38		return plfxlc_usb_wreq(chip->usb.ez_usb,
>     39				       &chip->beacon_interval,
>     40				       sizeof(chip->beacon_interval),
>     41				       USB_REQ_BEACON_INTERVAL_WR);
>     42	}
>     43	

Srinivasan, please submit a patch to fix this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
