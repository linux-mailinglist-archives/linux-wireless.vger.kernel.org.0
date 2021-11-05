Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1113444641B
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Nov 2021 14:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhKEN2l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Nov 2021 09:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhKEN2k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Nov 2021 09:28:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D2BC061714
        for <linux-wireless@vger.kernel.org>; Fri,  5 Nov 2021 06:26:00 -0700 (PDT)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mizED-0007tg-Qy; Fri, 05 Nov 2021 14:25:57 +0100
Message-ID: <6366d9bd-9752-dbc2-8970-442bdc6e8eea@leemhuis.info>
Date:   Fri, 5 Nov 2021 14:25:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-BZ
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        regressions@lists.linux.dev, Kalle Valo <kvalo@codeaurora.org>,
        Exuvo <exuvo@exuvo.se>
References: <bff7d309-a816-6a75-51b6-5928ef4f7a8c@exuvo.se>
 <20190927080303.GA7667@redhat.com>
 <CA+GwT0B5SyRZnGLqwqOeuJK4CWMVc=dKaWre9VN8KQC6kBzKGw@mail.gmail.com>
 <20191203075736.GA701@redhat.com>
 <d74dab51-3a84-9035-d89e-ea8f63e89198@exuvo.se>
 <a8eeb0bc-95da-291a-7fb9-5d15d1174c27@exuvo.se>
 <c22673af-40e0-3af2-5ab7-69b23fc03598@exuvo.se>
 <f935dc15-08bd-2e28-fc1b-b27634c618be@exuvo.se>
 <87czop5j33.fsf@tynnyri.adurom.net>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: rt2x00 regression
In-Reply-To: <87czop5j33.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1636118760;0098c353;
X-HE-SMSGID: 1mizED-0007tg-Qy
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lo, this is your Linux kernel regression tracker speaking.

On 01.10.21 08:56, Kalle Valo wrote:
> (adding regressions list for easier tracking)

Thx for this, that's how it got on the radar of regzbot, my Linux kernel
regression tracking bot:
https://linux-regtracking.leemhuis.info/regzbot/regression/87czop5j33.fsf@tynnyri.adurom.net/


> Exuvo <exuvo@exuvo.se> writes:
> 
>> I would like to get this resolved, is there any more information you need from me?
>>
>> I have been manually patching this all year with:
>>
>> drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>> - if (rt2x00dev->num_proto_errs > 8)
>> -    return true;
>>
>> It seems to just be some part of rt2800_load_firmware that is not
>> supported on my device and generating errors but it has been running
>> without problems in AP mode with daily usage.
> 
> [...]
> 
>>>>>>>> This most likely is the problem introduced by commit:
>>>>>>>>
>>>>>>>> commit e383c70474db32b9d4a3de6dfbd08784d19e6751
>>>>>>>> Author: Stanislaw Gruszka <sgruszka@redhat.com>
>>>>>>>> Date:   Tue Mar 12 10:51:42 2019 +0100
>>>>>>>>
>>>>>>>>      rt2x00: check number of EPROTO errors
>>>>>>>>
>>>>>>>> Plase check below patch that increase number of EPROTO checks
>>>>>>>> before marking device removed. If it does not help, plese
>>>>>>>> check if reverting above commits helps.
> 
> Should we do a revert? Can someone submit that including an explanation
> of the regression.

Afaics nothing happened since then. Or did I miss anything? How can we
get the ball rolling again?

Stanislaw, is there anything Exuvo (who offered to help afaics) could
test to get us closer to a fix?

Ciao, Thorsten

P.S.: I have no personal interest in this issue and watch it using
regzbot. Hence, feel free to exclude me on further messages in this
thread after the first reply, as I'm only posting this mail to hopefully
get a status update and things rolling again.

#regzbot poke
