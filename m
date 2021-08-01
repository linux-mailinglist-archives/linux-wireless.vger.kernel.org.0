Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E2D3DCB66
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Aug 2021 13:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhHALka (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Aug 2021 07:40:30 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19405 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbhHALk3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Aug 2021 07:40:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627818022; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=UEHyeA8hFuWa6WhjoGvQluG3o+baaT+h7h95goKvli8=; b=JqlUlmKxXUonzTrNp+PTciKBDn3IoH+J7lsoFCLsNDidu2zWur1Q972tdn6tCCGbwpI85Uv6
 fjI3a86X4a9tYp60GsSDwCrhkG6qHVnSkzqMQmYq57qhFvPABWXQ2rtD1ovdPfJ6JAadYDfF
 yr2MYKNQM7/QX23lX+TDITbC75M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61068821290ea35ee6c148f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 01 Aug 2021 11:40:17
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4ECAAC43145; Sun,  1 Aug 2021 11:40:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5458DC433D3;
        Sun,  1 Aug 2021 11:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5458DC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, kbuild-all@lists.01.org,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bob Copeland <me@bobcopeland.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath5k: fix building with LEDS=m
References: <20210722105501.1000781-1-arnd@kernel.org>
        <202107231625.xoQHseuJ-lkp@intel.com>
        <CAK8P3a2RJOxX5884A1bfzDzzF-n48YdQ=zu7yS=LnBB5vAEYeg@mail.gmail.com>
Date:   Sun, 01 Aug 2021 14:40:10 +0300
In-Reply-To: <CAK8P3a2RJOxX5884A1bfzDzzF-n48YdQ=zu7yS=LnBB5vAEYeg@mail.gmail.com>
        (Arnd Bergmann's message of "Fri, 23 Jul 2021 10:58:05 +0200")
Message-ID: <87fsvte6lh.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(oddly linux-wireless was dropped, adding it back in hopes that
patchwork sees this)

Arnd Bergmann <arnd@kernel.org> writes:

> On Fri, Jul 23, 2021 at 10:41 AM kernel test robot <lkp@intel.com> wrote:
>>
>> All errors (new ones prefixed by >>):
>>
>>    mips-linux-ld: drivers/net/wireless/ath/ath5k/led.o: in function
>> `ath5k_register_led.constprop.0':
>> >> led.c:(.text+0x58): undefined reference to `led_classdev_register_ext'
>>    mips-linux-ld: drivers/net/wireless/ath/ath5k/led.o: in function
>> `ath5k_unregister_leds':
>> >> led.c:(.text+0x1d8): undefined reference to `led_classdev_unregister'
>> >> mips-linux-ld: led.c:(.text+0x208): undefined reference to
>> >> `led_classdev_unregister'
>
> Ok, nevermind then, please ignore my patch. I don't see this
> particular build failure on
> my randconfig test box, which probably means I have some other patch
> applied that
> avoids this. I may get back to this in the future but can't figure it
> out at the moment.
>
> My feeling now is that the 'select' should just be removed entirely, and then
> we can have an 'if (!IS_ENABLED(CONFIG_MAC80211_LEDS)) return 0;'
> in ath5k_register_led().
>
>        Arnd

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
