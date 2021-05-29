Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6B6394D26
	for <lists+linux-wireless@lfdr.de>; Sat, 29 May 2021 18:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhE2QoF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 May 2021 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhE2QoE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 May 2021 12:44:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EACC061574;
        Sat, 29 May 2021 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=GUgNXBxqYWqu9GY6i+HqQcaAimI5I1IommHJDJJi9ik=; b=gUtj7G1QyVNTYyWCNV+eKAKepk
        EQjm0sDjdRCC3rex68Mdp2XrcN7kYKYYZQPbWbmdhPxxHaEo7X4xPPRXSWR/I2dA3vXiL6xjV1Ln0
        nE1IdpaG8/5p8biTlMNBnfvthr2mywcThDmJvCW33SrX9XitglzQi3OzHbSISDk7zmVGv9bdkAoN5
        O/dAewf9onDjaWoK04bS+fL/EXRjrmS0PoVVGvCPz/MlE6Vb4NyLl6tdfe18gGeOKE99DgTGHrAAh
        ta8MreMtTzx1/MIYyik5URiQ9FDSrEQY4UaC3VPb301btVLbcxbM2R5kcLvlT439p7EWOue+vYxCN
        GHAW99Qg==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ln22b-007ZLU-D9; Sat, 29 May 2021 16:42:25 +0000
Subject: Re: [PATCH] wireless: carl9170: fix LEDS build errors & warnings
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <20210529071523.2044-1-rdunlap@infradead.org>
 <CAK8P3a2mmQvsK+geQCGAOjZ4r2S9E4AUkWaT2coKW2AL8ZOAYg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <197640e7-ee32-a26e-fc2f-791d13555a4d@infradead.org>
Date:   Sat, 29 May 2021 09:42:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2mmQvsK+geQCGAOjZ4r2S9E4AUkWaT2coKW2AL8ZOAYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/29/21 5:10 AM, Arnd Bergmann wrote:
> On Sat, May 29, 2021 at 9:16 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> kernel test robot reports over 200 build errors and warnings
>> that are due to this Kconfig problem when CARL9170=m,
>> MAC80211=y, and LEDS_CLASS=m.
> 
> I think this avoids the build problems, but it's not really logical:
> 
>> --- linux-next-20210528.orig/drivers/net/wireless/ath/carl9170/Kconfig
>> +++ linux-next-20210528/drivers/net/wireless/ath/carl9170/Kconfig
>> @@ -17,9 +17,7 @@ config CARL9170
>>  config CARL9170_LEDS
>>         bool "SoftLED Support"
>>         depends on CARL9170
>> -       select MAC80211_LEDS
>> -       select LEDS_CLASS
>> -       select NEW_LEDS
>> +       select MAC80211_LEDS if LEDS_CLASS=y || LEDS_CLASS=MAC80211
>>         default y
>>         help
>>           This option is necessary, if you want your device' LEDs to blink
> 
> The point of the option is to enable LED support, but now it doesn't do that
> when LEDS_CLASS is a loadable module and MAC80211 is built-in.
> 
> I think a more sensible solution would be to follow the example of
> 
> config MT76_LEDS
>         bool
>         depends on MT76_CORE
>         depends on LEDS_CLASS=y || MT76_CORE=LEDS_CLASS
>         default y

Looks good. I'll send a v2.

thanks.

-- 
~Randy
