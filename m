Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565F4254340
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 12:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0KOD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 06:14:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28178 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgH0KOD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 06:14:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598523242; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=T0hxNss97w1gKnoS1lwhQb/6iS91tqXpvmxIfynmkys=; b=uO1XG1VyO94RrSIEpf3IlRJ1p6NpqR6QOnJ9oK5FcLxVV6MDWaGBt5WpouheMjZujqVtEUQK
 fpWVuJMotNSyo3G/3liGyeOWKQqXvCGZVN/TC87PP0xMT8/xM4uv+98rqHmnDCoW4o8iv2Fd
 yHWC9oZCTsx9Zj8cGqI3DmfxQCg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f4787162fd6d21f0aa0a943 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 10:12:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C4D5C43387; Thu, 27 Aug 2020 10:12:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43BA6C433CB;
        Thu, 27 Aug 2020 10:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43BA6C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     Wen Gong <wgong@codeaurora.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
References: <20200730124923.271429-1-alsi@bang-olufsen.dk>
        <c21bfe94-2de8-8178-7762-5a9b068a0e4a@bang-olufsen.dk>
Date:   Thu, 27 Aug 2020 13:12:34 +0300
In-Reply-To: <c21bfe94-2de8-8178-7762-5a9b068a0e4a@bang-olufsen.dk> ("Alvin
        \=\?utf-8\?Q\?\=C5\=A0ipraga\=22's\?\= message of "Thu, 27 Aug 2020 09:59:20 +0200")
Message-ID: <87r1rsbdnx.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alvin =C5=A0ipraga <alsi@bang-olufsen.dk> writes:

> Hi Kalle,
>
> On 7/30/20 2:49 PM, Alvin =C5=A0ipraga wrote:
>> This reverts commit 2dc016599cfa9672a147528ca26d70c3654a5423.
>>
>> Per Atheros documentation to manufacturers, the EEPROM regulatory domain
>> code 0x0 must always map to "US". In particular, it should not map to a
>> custom world regulatory domain. For references, see [1] and [2] below.
>> Furthermore, __ath_regd_init() has a specific condition to set the
>> country code to "US" in this case, which emits the following log
>> message:
>>
>> [    7.814307] ath: EEPROM indicates default country code should be used
>>
>> The patch being reverted mistakenly maps 0x0 to the custom world
>> regulatory domain 0x64 - the most restrictive of the world regulatory
>> domains. The premise of the patch is that in the case of EEPROM
>> regulatory domain code 0x0, ath_is_world_regd() should return true. But,
>> as stated above, 0x0 should not map to a world regulatory domain, and so
>> the function should return false. The original behaviour, whereby
>> NL80211_REGDOM_SET_BY_COUNTRY_IE is ignored, was correct according to
>> the manufacturer's intent and should not have been changed.
>>
>> [1] https://wireless.wiki.kernel.org/en/users/drivers/ath#the_0x0_regula=
tory_domain
>> [2] http://article.gmane.org/gmane.linux.kernel.wireless.general/38410
>>
>> Fixes: 2dc016599cfa ("ath: add support for special 0x0 regulatory domain=
")
>> Cc: Wen Gong <wgong@codeaurora.org>
>> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
>> Cc: linux-wireless@vger.kernel.org
>> Tested-on: QCA9880 hw2.0 PCI 10.2.4-1.0-00047
>> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>> ---
>>   drivers/net/wireless/ath/regd.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> Do you have any feedback on this patch? No problem if you simply have
> not looked yet - I am not sure what kind of lead time to expect on the
> list. But without the patch, a (correctly) programmed 0x0 (US) card
> will not be able to operate on 5GHz channels without some hacking. I
> have cited some references to justify reverting this patch, so I would
> like to know if anything further should be done to get this into
> future kernels?
>
> I wonder also if Wen Gong could comment, whose patch I am reverting in
> the first place. Maybe there is something I am missing?

I'm working on it, I just need to check something internally first.

BTW, Brian submitted an identical revert first so I'm planning to use
his patch instead of yours:

https://patchwork.kernel.org/patch/11573585/

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
