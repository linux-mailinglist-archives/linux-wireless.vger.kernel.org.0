Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1008D1977C7
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2020 11:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgC3JXD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Mar 2020 05:23:03 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53550 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727841AbgC3JXD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Mar 2020 05:23:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585560182; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=YFBdAzzo7+yb9xd0OHuyOAoYZCtYb0OdPlc71GVj/eE=;
 b=NsM1g+gS1HKtiYfnu7+slfXZX73Xsv6NO5W/faZEY/YgW10Y4jF5saBNuEOyWUA7jQu6Q9tP
 XEkIsOo7UPIFCeM7jOnc9TIFyjFu0deYI2h9O1xYe5CAGAkRXwC94OYWc4usAN8Os2UYa6Ym
 OUjqG1tLrvsYFNUrgUp5IMPsevM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e81ba6e.7f90c35cb928-smtp-out-n04;
 Mon, 30 Mar 2020 09:22:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 19E94C433BA; Mon, 30 Mar 2020 09:22:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ssreeela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FA49C433F2;
        Mon, 30 Mar 2020 09:22:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 30 Mar 2020 14:52:53 +0530
From:   ssreeela@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lei Wang <leiwa@codeaurora.org>, Rick Wu <rwu@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: enable VHT160 and VHT80+80 modes
In-Reply-To: <87bloi2g6h.fsf@kamboji.qca.qualcomm.com>
References: <1585148169-2320-1-git-send-email-ssreeela@codeaurora.org>
 <20200326095907.5326BC433BA@smtp.codeaurora.org>
 <812e84a585ed3aeda9aa54f7d2b14e93@codeaurora.org>
 <87bloi2g6h.fsf@kamboji.qca.qualcomm.com>
Message-ID: <158d2bdf5027a494d14cfdd6134b9c6f@codeaurora.org>
X-Sender: ssreeela@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-03-27 16:55, Kalle Valo wrote:
> ssreeela@codeaurora.org writes:
> 
>> On 2020-03-26 15:29, Kalle Valo wrote:
>>> Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> wrote:
>>> 
>>>> From: Lei Wang <leiwa@codeaurora.org>
>>>> 
>>>> Set right channel frequencies in VHT160 mode according to the VHT160
>>>> interoperability workaround added as part of IEEE Std 802.11™-2016 
>>>> in
>>>> "Table 9-252—VHT Operation Information subfields", band_center_freq2
>>>> corresponds to CCFS1 in Table 9-253. Previous implementation
>>>> (band_center_freq2 = 0 for VHT160) is only deprecated.
>>>> 
>>>> Enable VHT80+80 mode and set the proper peer RX nss value for
>>>> VHT160 and
>>>> VHT80+80 mode.
>>>> 
>>>> Based on patches by Sebastian Gottschall:
>>>> 
>>>> https://lkml.kernel.org/r/20180704095444.662-1-s.gottschall@dd-wrt.com
>>>> 
>>>> https://lkml.kernel.org/r/20180704120519.6479-1-s.gottschall@dd-wrt.com
>>>> 
>>>> Tested: qca9984 with firmware ver 10.4-3.10-00047
>>>> 
>>>> Co-developed-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>>>> Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>>>> Co-developed-by: Rick Wu <rwu@codeaurora.org>
>>>> Signed-off-by: Rick Wu <rwu@codeaurora.org>
>>>> Signed-off-by: Lei Wang <leiwa@codeaurora.org>
>>>> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
>>> 
>>> Fails to build on GCC 8.1. Did you test this?
>>> 
>>> In file included from ./include/asm-generic/bug.h:5,
>>>                  from ./arch/x86/include/asm/bug.h:83,
>>>                  from ./include/linux/bug.h:5,
>>>                  from ./include/net/mac80211.h:16,
>>>                  from drivers/net/wireless/ath/ath10k/mac.h:10,
>>>                  from drivers/net/wireless/ath/ath10k/mac.c:8:
>>> In function 'ath10k_peer_assoc_h_vht',
>>>     inlined from 'ath10k_peer_assoc_prepare' at
>>> drivers/net/wireless/ath/ath10k/mac.c:2790:2:
>>> ./include/linux/compiler.h:350:38: error: call to
>>> '__compiletime_assert_2631' declared with attribute error:
> 
> [...]
> 
>> I checked the build. Build was successful with GCC version 4.8.
>> Will fix the error and update the patch.
> 
> Great, thanks. Here's how I installed GCC 8.1 from crosstool:
> 
> listings: https://www.kernel.org/pub/tools/crosstool/
> 
> wget
> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_64-gcc-8.1.0-nolibc-x86_64-linux.tar.xz
> pushd /opt/cross/
> tar -xf ~/tmp/crosstool/x86_64-gcc-8.1.0-nolibc-x86_64-linux.tar.xz
> 
> In top level create GNUMakefile:
> 
> CROSS_COMPILE=/opt/cross/gcc-8.1.0-nolibc/x86_64-linux/bin/x86_64-linux-
> include Makefile

Thanks for the info. Will check the build with GCC 8.1 and resend.

Regards,
Sowmiya Sree
