Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82AF744D8A
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jul 2023 14:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjGBMNa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jul 2023 08:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGBMN3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jul 2023 08:13:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB0E73;
        Sun,  2 Jul 2023 05:13:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666ecf9a081so2787053b3a.2;
        Sun, 02 Jul 2023 05:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688300006; x=1690892006;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vudbneyh5amlB4z/hjEg2kh8mq89mabibesrDE7OD1s=;
        b=DQF0vQEwTZm8Zhqubzz0/nOFbE7PT5ekj0ujozi8GUbmatpmKXwlNUYv+O1k6lfCrp
         u9q3sKI2PYPwl/rQgddi/YqX0Mq3s9kE5pFJcWoqi/DLoqe9JpDl1ML2etydSY/07g9C
         w1l2alCysL3UL9ia8c/NuzaNYzyweUjqvSD/IIq62aQ18EHhQyy9t0fAaxfA61itBDlv
         YvsVkhPZmrhxqaLehOhExG2nxfFfW/MQtmwQzHDBIuHZADL+KQJtqorCL7pPRlLqQmtU
         SS47Vwu3OV+xOxfagSLq1XXSBteqYfPoJ35Kd2z7YxrngyY/KlX5PBgcMkI/T7XqCw2c
         DdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688300006; x=1690892006;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vudbneyh5amlB4z/hjEg2kh8mq89mabibesrDE7OD1s=;
        b=KYykWC7KQnQiB0sk5jyj8ic64zLUaMmRzUYcCdB9YhZ3VZJSoe4o+Mn99LW7VUzfOq
         gBE0Hol/vn4MW4bUP7tZtGbmZ+yVltOBU2p35QZcEett62u51rT1b+PJ8wh9VMqUSLha
         U/C3isWvB8C/pOoIzFVbj7Ii5reWuWDyG50DanUaAD8PukpUfOpe0TRW5zmISi4EA18k
         v0Ml3nogCZkiTl7bN27cRenavn6JM8/s+BFN5cYvJkx1UzHnmjhbR6x92aOtgFvFXU42
         AOwMeAPAwnHPUrMwj26pVXjEhEX69yHef9KqaJEXteLG6Yut0MsFcdpjWEFAYCFozA03
         JplA==
X-Gm-Message-State: ABy/qLYI8Ly1dxIkLbpDBnhmqFfp1rPuIEPOgxnjHZwjlFj+SZtrplsM
        2GDFoB9JKtqcTzWZjyxsadY=
X-Google-Smtp-Source: APBJJlGAwoTaYP/5ZAs1gTB/kctY9tt1kXkLpAl+wW0iwuTI7cUuoIUoFng9hsTELVCezx4xSv5i2Q==
X-Received: by 2002:a05:6a00:1341:b0:674:6dd4:8337 with SMTP id k1-20020a056a00134100b006746dd48337mr11833992pfu.12.1688300006187;
        Sun, 02 Jul 2023 05:13:26 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x14-20020a056a00270e00b005d22639b577sm8566434pfv.165.2023.07.02.05.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 05:13:25 -0700 (PDT)
Message-ID: <a5cdc7f8-b340-d372-2971-0d24b01de217@gmail.com>
Date:   Sun, 2 Jul 2023 19:13:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        =?UTF-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= 
        <pinkflames.linux@gmail.com>,
        Nate Watterson <nwatters@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Linux IO Memory Management Unit <iommu@lists.linux.dev>
Cc:     Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: iwlwifi causes dma-iommu.c:693 __iommu_dma_unmap since commit
 19898ce9cf8a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]: Quoting from it:

> Since commit 19898ce9cf8a the iwlwifi has generated three possibly identical kernel stack traces for me. Because I only use the Bluetooth but not the Wi-Fi functionality, this is not a big deal for me but I thought such an issue is worth reporting nontheless.
> 
> All three traces point at **drivers/iommu/dma-iommu.c:693 __iommu_dma_unmap+0x150/0x160**.
> 
> I'm attaching to this bug report the three stack traces along with other possibly relevant dmesg parts. Sorry in advance for not cutting at the cut here markers which resulted in considerably longer text but I suspected that the PCI, ACPI, memory and possibly iwlwifi related messages may be of importance, too. If I should cut the stack traces out and attach them as three distinct files (and diff to see if there's any change between them) let me know. I can provide a full (but redacted) dmesg output of a git master build, if required as well.
> 
> I did try booting a much more recent git master build with *iommu.passthrough=0 iommu.strict=0* on the kernel command line but that did not seem to make any difference.
> 
> ```
> 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2 is the first bad commit
> commit 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Wed Jun 21 13:12:07 2023 +0300
> 
>     wifi: iwlwifi: split 22000.c into multiple files
>     
>     Split the configuration list in 22000.c into four new files,
>     per new device family, so we don't have this huge unusable
>     file. Yes, this duplicates a few small things, but that's
>     still much better than what we have now.
>     
>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>     Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
>     Link: https://lore.kernel.org/r/20230621130443.7543603b2ee7.Ia8dd54216d341ef1ddc0531f2c9aa30d30536a5d@changeid
>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
>  drivers/net/wireless/intel/iwlwifi/Makefile     |   1 +
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 939 +-----------------------
>  drivers/net/wireless/intel/iwlwifi/cfg/ax210.c  | 452 ++++++++++++
>  drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 523 +++++++++++++
>  drivers/net/wireless/intel/iwlwifi/cfg/sc.c     | 214 ++++++
>  drivers/net/wireless/intel/iwlwifi/iwl-config.h |   2 +
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |   3 +
>  7 files changed, 1206 insertions(+), 928 deletions(-)
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/bz.c
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/sc.c
> ```
> 

See Bugzilla for the full thread and attached dmesg.

Anyway, I'm adding it to regzbot to ensure that it doesn't fall through
cracks unnoticed:

#regzbot introduced: 19898ce9cf8a33 https://bugzilla.kernel.org/show_bug.cgi?id=217622
#regzbot title: dma-iommu.c:693 __iommu_dma_unmap bug trace due to 22000.c split

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217622

-- 
An old man doll... just what I always wanted! - Clara
