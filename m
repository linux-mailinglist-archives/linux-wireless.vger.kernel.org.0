Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267CB56BB8
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfFZORr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 10:17:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40672 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZORr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 10:17:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9F0FA60E5D; Wed, 26 Jun 2019 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561558665;
        bh=zAeObv87GMP12NToeipB2vCY+x5lGwzIQdd4Ta53uwc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LvXnSaHQ2Pp3gw/INmFtFN/2+HzahQ/VkcqAaV0kqFtpaTWE4n7/6+OqaE/2X3H+w
         NmztRhtkmNvoNvA3GCu1XNRnefcateejmSA01W57EzCNVZil4wtKOjTTwu4hRFNOeV
         0PQa0i9zN3UxpGEdwrBESRkQpr5O7QRHWPE3Wnqg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF90F60E5D;
        Wed, 26 Jun 2019 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561558663;
        bh=zAeObv87GMP12NToeipB2vCY+x5lGwzIQdd4Ta53uwc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EwxHwI7ik+3eUKQcOdkR3Rf+iL2og8Bh6mRb0WbKEn2uW65lkPyTtPDTpJVVQ1Hh0
         lzbczBB7/aAhuw3zvovIk33+7j+oxqKStuuukEX3tXfIt7zV3BglwpJDtFW0QXPwpz
         k1xXIRENZXw/QikA9Uy5iedNv4FQcotRf7hDY80Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF90F60E5D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] carl9170: fix enum compare splat
References: <20190608144947.744-1-chunkeey@gmail.com>
        <1601416.I41mb68Wgz@debian64>
        <87a7ef9jp2.fsf@kamboji.qca.qualcomm.com>
        <4392478.8kWN0Ehzps@debian64>
Date:   Wed, 26 Jun 2019 17:17:39 +0300
In-Reply-To: <4392478.8kWN0Ehzps@debian64> (Christian Lamparter's message of
        "Thu, 20 Jun 2019 16:41:00 +0200")
Message-ID: <87o92kmnwc.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> On Tuesday, June 18, 2019 2:11:53 PM CEST Kalle Valo wrote:
>> Christian Lamparter <chunkeey@gmail.com> writes:
>> > On Monday, June 10, 2019 9:06:30 AM CEST Kalle Valo wrote:
>> >> Christian Lamparter <chunkeey@gmail.com> writes:
>> >>=20
>> >> > This patch fixes a noisy warning triggered by -Wenum-compare
>> >> >
>> >> > |main.c:1390:31: warning: comparison between =E2=80=98enum nl80211_=
ac=E2=80=99
>> >> > |	and =E2=80=98enum ar9170_txq=E2=80=99 [-Wenum-compare]
>> >> > |  BUILD_BUG_ON(NL80211_NUM_ACS > __AR9170_NUM_TXQ);
>> >> > |                               ^
>> >> > | [...]
>> >> >
>> >> > This is a little bit unfortunate, since the number of queues
>> >> > (hence NL80211_NUM_ACS) is a constant based on the IEEE 802.11
>> >> > (much like IEEE80211_NUM_ACS) and __AR9170_NUM_TXQ is more or
>> >> > less defined by the AR9170 hardware.
>> >>=20
>> >> Is the warning enabled by default? TBH I'm not seeing how useful this
>> >> warning is for kernel development.
>> >
>> > It is included in the "-Wall" (which is coming from "KBUILD_CFLAGS"=20
>> > in the main Makefile).
>> >
>> > I tried debian's gcc starting from 4.6 to the lastest 8.3. They all
>> > complain about it in various degrees.
>> >
>> > https://gcc.gnu.org/onlinedocs/gcc-4.6.0/gcc/Warning-Options.html#Warn=
ing-Options
>>=20
>> Ok, odd that I haven't noticed this warning. Maybe I have been just
>> blind.
>
> Sorry. No, I messed up there. I made a patch back in the day during the s=
pectre
> mac80211 patches that I kept in my tree for the driver. But I now remembe=
r that
> I never published those because of that exact "warning".
> These lines are coming from there.
>=20=20
>> >> > --- a/drivers/net/wireless/ath/carl9170/main.c
>> >> > +++ b/drivers/net/wireless/ath/carl9170/main.c
>> >> > @@ -1387,7 +1387,7 @@ static int carl9170_op_conf_tx(struct ieee802=
11_hw *hw,
>> >> >  	int ret;
>> >> >=20=20
>> >> >  	BUILD_BUG_ON(ARRAY_SIZE(ar9170_qmap) !=3D __AR9170_NUM_TXQ);
>> >> > -	BUILD_BUG_ON(NL80211_NUM_ACS > __AR9170_NUM_TXQ);
>> >> > +	BUILD_BUG_ON((size_t)NL80211_NUM_ACS > (size_t)__AR9170_NUM_TXQ);
>> >>=20
>> >> IMHO this just makes the code worse. Does it make sense to workaround
>> >> (stupid) compiler warnings like this?
>> >
>> > True. What's worse: This isn't really code. The BUILD_BUG_ON Macro is =
there
>> > to guard but it's getting compiled away. I could also just drop it.
>>=20
>> Either way is fine for me. If the GCC (by default) emits a warning for
>> this we need to silence that warning, so in that respect I guess we
>> should apply this. Unless better solutions come up, of course :)
>
> Note: I dropped this patch from patchwork. So, there's nothing that
> needs to be done now ;)

Thanks, except I would prefer that I drop the patch myself :) In
numerous cases I have been wondering there a patch has disappeared and
only after a while I realise the submitter deleted the patch altogether
(which also destroys the conversation from patchwork etc). IMHO that's
really bad UX in patchwork, I should file a bug report about that.

So in general it's enough to say "Kalle, please drop the patch" and I'll
do the rest.

> Well, except OT: Would you mind adding the QCA4019 boardfiles that
> have accumulated over the past six-ish months?

Yeah, those are in my queue. But I'll first want to implement a script
so that I don't need to manually add all of them and I just haven't
found the time for that.

--=20
Kalle Valo
