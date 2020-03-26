Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3969A193C6E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 10:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgCZJ7S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 05:59:18 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:26382 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727697AbgCZJ7R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 05:59:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585216756; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=QzM855rs5LMFz/JxZbe1l1lDacKdVQUuIt7ztjoVwIA=;
 b=OenWvSOzfJD3PNicz71E8lSgCFGSd501XwuUclWNevaplUUfRKjT4rxV/c4r8jbjZ9xoC8/U
 9ZmkZRrFziJ+s3AWyZigN3wHjfQ9WffRqSqwVwc1Dlsea+zWMfPUQLwAgV8qqNp+g5lKi089
 fNu0t5n1C2lpU4pxIiGA0vq8Tjc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7c7ceb.7fb70ee2fc38-smtp-out-n01;
 Thu, 26 Mar 2020 09:59:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ACE80C43637; Thu, 26 Mar 2020 09:59:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13B82C433F2;
        Thu, 26 Mar 2020 09:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13B82C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ath10k: enable VHT160 and VHT80+80 modes
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1585148169-2320-1-git-send-email-ssreeela@codeaurora.org>
References: <1585148169-2320-1-git-send-email-ssreeela@codeaurora.org>
To:     Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Lei Wang <leiwa@codeaurora.org>,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Rick Wu <rwu@codeaurora.org>,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200326095907.ACE80C43637@smtp.codeaurora.org>
Date:   Thu, 26 Mar 2020 09:59:07 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> wrote:

> From: Lei Wang <leiwa@codeaurora.org>
> 
> Set right channel frequencies in VHT160 mode according to the VHT160
> interoperability workaround added as part of IEEE Std 802.11™-2016 in
> "Table 9-252—VHT Operation Information subfields", band_center_freq2
> corresponds to CCFS1 in Table 9-253. Previous implementation
> (band_center_freq2 = 0 for VHT160) is only deprecated.
> 
> Enable VHT80+80 mode and set the proper peer RX nss value for VHT160 and
> VHT80+80 mode.
> 
> Based on patches by Sebastian Gottschall:
> 
> https://lkml.kernel.org/r/20180704095444.662-1-s.gottschall@dd-wrt.com
> 
> https://lkml.kernel.org/r/20180704120519.6479-1-s.gottschall@dd-wrt.com
> 
> Tested: qca9984 with firmware ver 10.4-3.10-00047
> 
> Co-developed-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
> Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
> Co-developed-by: Rick Wu <rwu@codeaurora.org>
> Signed-off-by: Rick Wu <rwu@codeaurora.org>
> Signed-off-by: Lei Wang <leiwa@codeaurora.org>
> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>

Fails to build on GCC 8.1. Did you test this?

In file included from ./include/asm-generic/bug.h:5,
                 from ./arch/x86/include/asm/bug.h:83,
                 from ./include/linux/bug.h:5,
                 from ./include/net/mac80211.h:16,
                 from drivers/net/wireless/ath/ath10k/mac.h:10,
                 from drivers/net/wireless/ath/ath10k/mac.c:8:
In function 'ath10k_peer_assoc_h_vht',
    inlined from 'ath10k_peer_assoc_prepare' at drivers/net/wireless/ath/ath10k/mac.c:2790:2:
./include/linux/compiler.h:350:38: error: call to '__compiletime_assert_2631' declared with attribute error: BUILD_BUG_ON failed: ((((((~(((0UL)))) - ((((1UL))) << (3)) + 1) & (~(((0UL))) >> (64 - 1 - (5))))) + (1ULL << (__builtin_ffsll((((~(((0UL)))) - ((((1UL))) << (3)) + 1) & (~(((0UL))) >> (64 - 1 - (5))))) - 1))) & ((((((~(((0UL)))) - ((((1UL))) << (3)) + 1) & (~(((0UL))) >> (64 - 1 - (5))))) + (1ULL << (__builtin_ffsll((((~(((0UL)))) - ((((1UL))) << (3)) + 1) & (~(((0UL))) >> (64 - 1 - (5))))) - 1))) - 1)) != 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
./include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
    prefix ## suffix();    \
    ^~~~~~
./include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:49:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
   ^~~~~~~~~~~~~~~~
./include/linux/bitfield.h:81:3: note: in expansion of macro '__BF_FIELD_CHECK'
   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
   ^~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath10k/mac.c:2631:4: note: in expansion of macro 'FIELD_PREP'
    FIELD_PREP(WMI_PEER_NSS_80_80MHZ_MASK, (rx_nss - 1));
    ^~~~~~~~~~
./include/linux/compiler.h:350:38: error: call to '__compiletime_assert_2627' declared with attribute error: BUILD_BUG_ON failed: ((((((~(((0UL)))) - ((((1UL))) << (0)) + 1) & (~(((0UL))) >> (64 - 1 - (2))))) + (1ULL << (__builtin_ffsll((((~(((0UL)))) - ((((1UL))) << (0)) + 1) & (~(((0UL))) >> (64 - 1 - (2))))) - 1))) & ((((((~(((0UL)))) - ((((1UL))) << (0)) + 1) & (~(((0UL))) >> (64 - 1 - (2))))) + (1ULL << (__builtin_ffsll((((~(((0UL)))) - ((((1UL))) << (0)) + 1) & (~(((0UL))) >> (64 - 1 - (2))))) - 1))) - 1)) != 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
./include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
    prefix ## suffix();    \
    ^~~~~~
./include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:49:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
   ^~~~~~~~~~~~~~~~
./include/linux/bitfield.h:81:3: note: in expansion of macro '__BF_FIELD_CHECK'
   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
   ^~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath10k/mac.c:2627:4: note: in expansion of macro 'FIELD_PREP'
    FIELD_PREP(WMI_PEER_NSS_160MHZ_MASK, (rx_nss - 1));
    ^~~~~~~~~~
make[5]: *** [drivers/net/wireless/ath/ath10k/mac.o] Error 1
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [drivers/net/wireless/ath/ath10k] Error 2
make[3]: *** [drivers/net/wireless/ath] Error 2
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11458023/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
