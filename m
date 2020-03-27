Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB08519564D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 12:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgC0LZX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 07:25:23 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:32621 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbgC0LZX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 07:25:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585308322; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=v00esGDG7LHWpQKV3144KDgvmPjIbXzlLvEwUmYlamQ=; b=rC08UyfYsr9ZFBzKV2DTHbevMM6QlCWxi48etv6NE6MWM0xdWw8Z6FOkmnukomsjz/C1/SeJ
 JTXc57A4g722jqQWZNEziVA5OVacddi/En5PHXcwlKUoYlACAjIcxJKbvcQxCAJ16/KqpLFr
 dLCVuMqmTqOpIa+262J/1QEGyUo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7de29c.7f07fb275308-smtp-out-n05;
 Fri, 27 Mar 2020 11:25:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 108CFC433D2; Fri, 27 Mar 2020 11:25:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7806FC433F2;
        Fri, 27 Mar 2020 11:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7806FC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ssreeela@codeaurora.org
Cc:     Lei Wang <leiwa@codeaurora.org>, Rick Wu <rwu@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: enable VHT160 and VHT80+80 modes
References: <1585148169-2320-1-git-send-email-ssreeela@codeaurora.org>
        <20200326095907.5326BC433BA@smtp.codeaurora.org>
        <812e84a585ed3aeda9aa54f7d2b14e93@codeaurora.org>
Date:   Fri, 27 Mar 2020 13:25:10 +0200
In-Reply-To: <812e84a585ed3aeda9aa54f7d2b14e93@codeaurora.org>
        (ssreeela@codeaurora.org's message of "Thu, 26 Mar 2020 18:45:06
        +0530")
Message-ID: <87bloi2g6h.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ssreeela@codeaurora.org writes:

> On 2020-03-26 15:29, Kalle Valo wrote:
>> Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> wrote:
>>
>>> From: Lei Wang <leiwa@codeaurora.org>
>>>
>>> Set right channel frequencies in VHT160 mode according to the VHT160
>>> interoperability workaround added as part of IEEE Std 802.11=E2=84=A2-2=
016 in
>>> "Table 9-252=E2=80=94VHT Operation Information subfields", band_center_=
freq2
>>> corresponds to CCFS1 in Table 9-253. Previous implementation
>>> (band_center_freq2 =3D 0 for VHT160) is only deprecated.
>>>
>>> Enable VHT80+80 mode and set the proper peer RX nss value for
>>> VHT160 and
>>> VHT80+80 mode.
>>>
>>> Based on patches by Sebastian Gottschall:
>>>
>>> https://lkml.kernel.org/r/20180704095444.662-1-s.gottschall@dd-wrt.com
>>>
>>> https://lkml.kernel.org/r/20180704120519.6479-1-s.gottschall@dd-wrt.com
>>>
>>> Tested: qca9984 with firmware ver 10.4-3.10-00047
>>>
>>> Co-developed-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>>> Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>>> Co-developed-by: Rick Wu <rwu@codeaurora.org>
>>> Signed-off-by: Rick Wu <rwu@codeaurora.org>
>>> Signed-off-by: Lei Wang <leiwa@codeaurora.org>
>>> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
>>
>> Fails to build on GCC 8.1. Did you test this?
>>
>> In file included from ./include/asm-generic/bug.h:5,
>>                  from ./arch/x86/include/asm/bug.h:83,
>>                  from ./include/linux/bug.h:5,
>>                  from ./include/net/mac80211.h:16,
>>                  from drivers/net/wireless/ath/ath10k/mac.h:10,
>>                  from drivers/net/wireless/ath/ath10k/mac.c:8:
>> In function 'ath10k_peer_assoc_h_vht',
>>     inlined from 'ath10k_peer_assoc_prepare' at
>> drivers/net/wireless/ath/ath10k/mac.c:2790:2:
>> ./include/linux/compiler.h:350:38: error: call to
>> '__compiletime_assert_2631' declared with attribute error:

[...]

> I checked the build. Build was successful with GCC version 4.8.
> Will fix the error and update the patch.

Great, thanks. Here's how I installed GCC 8.1 from crosstool:

listings: https://www.kernel.org/pub/tools/crosstool/

wget https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_=
64-gcc-8.1.0-nolibc-x86_64-linux.tar.xz
pushd /opt/cross/
tar -xf ~/tmp/crosstool/x86_64-gcc-8.1.0-nolibc-x86_64-linux.tar.xz

In top level create GNUMakefile:

CROSS_COMPILE=3D/opt/cross/gcc-8.1.0-nolibc/x86_64-linux/bin/x86_64-linux-
include Makefile

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
