Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26CB1193F89
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 14:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgCZNPN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 09:15:13 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:35543 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbgCZNPN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 09:15:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585228512; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=p8e+V1RjNThFUhCLpNoZ5DCB/JxOR/HQEKV9PjEzIJg=;
 b=Dm3K602/OtCxzl+U2L7dCVuL6BkQSBi6NZQt7mWoP17/eQvtto9oYlKkQS3SfjZtgAfaxQf2
 P90y9Gc96oEwO2l9o4KzkDK9nXErftJyMV4PJxh9n2zh4BBUwYyDVpLPCgmFOne2fLOa1FJf
 OKmc/fBGUpgKqq8lKwFi14BYu+8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7caadb.7fc707a6c1f0-smtp-out-n03;
 Thu, 26 Mar 2020 13:15:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 708CAC43637; Thu, 26 Mar 2020 13:15:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ssreeela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9AB83C433D2;
        Thu, 26 Mar 2020 13:15:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 26 Mar 2020 18:45:06 +0530
From:   ssreeela@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Lei Wang <leiwa@codeaurora.org>,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Rick Wu <rwu@codeaurora.org>
Subject: Re: [PATCH] ath10k: enable VHT160 and VHT80+80 modes
In-Reply-To: <20200326095907.5326BC433BA@smtp.codeaurora.org>
References: <1585148169-2320-1-git-send-email-ssreeela@codeaurora.org>
 <20200326095907.5326BC433BA@smtp.codeaurora.org>
Message-ID: <812e84a585ed3aeda9aa54f7d2b14e93@codeaurora.org>
X-Sender: ssreeela@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-03-26 15:29, Kalle Valo wrote:
> Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> wrote:
> 
>> From: Lei Wang <leiwa@codeaurora.org>
>> 
>> Set right channel frequencies in VHT160 mode according to the VHT160
>> interoperability workaround added as part of IEEE Std 802.11™-2016 in
>> "Table 9-252—VHT Operation Information subfields", band_center_freq2
>> corresponds to CCFS1 in Table 9-253. Previous implementation
>> (band_center_freq2 = 0 for VHT160) is only deprecated.
>> 
>> Enable VHT80+80 mode and set the proper peer RX nss value for VHT160 
>> and
>> VHT80+80 mode.
>> 
>> Based on patches by Sebastian Gottschall:
>> 
>> https://lkml.kernel.org/r/20180704095444.662-1-s.gottschall@dd-wrt.com
>> 
>> https://lkml.kernel.org/r/20180704120519.6479-1-s.gottschall@dd-wrt.com
>> 
>> Tested: qca9984 with firmware ver 10.4-3.10-00047
>> 
>> Co-developed-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>> Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>> Co-developed-by: Rick Wu <rwu@codeaurora.org>
>> Signed-off-by: Rick Wu <rwu@codeaurora.org>
>> Signed-off-by: Lei Wang <leiwa@codeaurora.org>
>> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
> 
> Fails to build on GCC 8.1. Did you test this?
> 
> In file included from ./include/asm-generic/bug.h:5,
>                  from ./arch/x86/include/asm/bug.h:83,
>                  from ./include/linux/bug.h:5,
>                  from ./include/net/mac80211.h:16,
>                  from drivers/net/wireless/ath/ath10k/mac.h:10,
>                  from drivers/net/wireless/ath/ath10k/mac.c:8:
> In function 'ath10k_peer_assoc_h_vht',
>     inlined from 'ath10k_peer_assoc_prepare' at
> drivers/net/wireless/ath/ath10k/mac.c:2790:2:
> ./include/linux/compiler.h:350:38: error: call to
> '__compiletime_assert_2631' declared with attribute error:
> BUILD_BUG_ON failed: ((((((~(((0UL)))) - ((((1UL))) << (3)) + 1) &
> (~(((0UL))) >> (64 - 1 - (5))))) + (1ULL <<
> (__builtin_ffsll((((~(((0UL)))) - ((((1UL))) << (3)) + 1) &
> (~(((0UL))) >> (64 - 1 - (5))))) - 1))) & ((((((~(((0UL)))) -
> ((((1UL))) << (3)) + 1) & (~(((0UL))) >> (64 - 1 - (5))))) + (1ULL <<
> (__builtin_ffsll((((~(((0UL)))) - ((((1UL))) << (3)) + 1) &
> (~(((0UL))) >> (64 - 1 - (5))))) - 1))) - 1)) != 0
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                       ^
> ./include/linux/compiler.h:331:4: note: in definition of macro
> '__compiletime_assert'
>     prefix ## suffix();    \
>     ^~~~~~
> ./include/linux/compiler.h:350:2: note: in expansion of macro
> '_compiletime_assert'
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>   ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro
> 'compiletime_assert'
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:49:3: note: in expansion of macro 
> 'BUILD_BUG_ON_MSG'
>    BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
>    ^~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:81:3: note: in expansion of macro 
> '__BF_FIELD_CHECK'
>    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
>    ^~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath10k/mac.c:2631:4: note: in expansion of
> macro 'FIELD_PREP'
>     FIELD_PREP(WMI_PEER_NSS_80_80MHZ_MASK, (rx_nss - 1));
>     ^~~~~~~~~~
> ./include/linux/compiler.h:350:38: error: call to
> '__compiletime_assert_2627' declared with attribute error:
> BUILD_BUG_ON failed: ((((((~(((0UL)))) - ((((1UL))) << (0)) + 1) &
> (~(((0UL))) >> (64 - 1 - (2))))) + (1ULL <<
> (__builtin_ffsll((((~(((0UL)))) - ((((1UL))) << (0)) + 1) &
> (~(((0UL))) >> (64 - 1 - (2))))) - 1))) & ((((((~(((0UL)))) -
> ((((1UL))) << (0)) + 1) & (~(((0UL))) >> (64 - 1 - (2))))) + (1ULL <<
> (__builtin_ffsll((((~(((0UL)))) - ((((1UL))) << (0)) + 1) &
> (~(((0UL))) >> (64 - 1 - (2))))) - 1))) - 1)) != 0
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                       ^
> ./include/linux/compiler.h:331:4: note: in definition of macro
> '__compiletime_assert'
>     prefix ## suffix();    \
>     ^~~~~~
> ./include/linux/compiler.h:350:2: note: in expansion of macro
> '_compiletime_assert'
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>   ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro
> 'compiletime_assert'
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:49:3: note: in expansion of macro 
> 'BUILD_BUG_ON_MSG'
>    BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
>    ^~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:81:3: note: in expansion of macro 
> '__BF_FIELD_CHECK'
>    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
>    ^~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath10k/mac.c:2627:4: note: in expansion of
> macro 'FIELD_PREP'
>     FIELD_PREP(WMI_PEER_NSS_160MHZ_MASK, (rx_nss - 1));
>     ^~~~~~~~~~
> make[5]: *** [drivers/net/wireless/ath/ath10k/mac.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [drivers/net/wireless/ath/ath10k] Error 2
> make[3]: *** [drivers/net/wireless/ath] Error 2
> make[2]: *** [drivers/net/wireless] Error 2
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
> 
> Patch set to Changes Requested.

Hi Kalle,

I checked the build. Build was successful with GCC version 4.8.
Will fix the error and update the patch.

Thanks,
Sowmiya Sree
