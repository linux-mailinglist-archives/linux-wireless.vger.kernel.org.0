Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD884A06E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 14:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFRML6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 08:11:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55308 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRML6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 08:11:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3F3EE60F38; Tue, 18 Jun 2019 12:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560859917;
        bh=KfCnw3BVdOv41YIYSBo2kR5D87lZt7ShHdxRwALs5jU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kuYrnw1ckQW9fBNmUHF/UrLAqPyl+b81xNo5DJT2bjn3ItCIPT6arv2NVr3rRF6wV
         c0Chkmb676XEphGQaP4jR5RJMzrdbcNYZSi0DJp38Nn5GhnGYrBTJ8UStgaqayUDL0
         /um+HtuIr1QEkHe3OYI4F7yKW86X+rCVl12ZYLsc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77FCC60867;
        Tue, 18 Jun 2019 12:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560859916;
        bh=KfCnw3BVdOv41YIYSBo2kR5D87lZt7ShHdxRwALs5jU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=N9+XITxwd+FgiUIplP5tCH7KjBpHN2eMOCb7+WgYq3pBy9GBj9jQmwBv4oslLaSFL
         7hjGrn4AC7wlf+xSJ6ElF2AtXxFXVugGKr0dywTS8DIMTr+iCp+n86h+/vkaiwRn6u
         6KU2ZJ0Yg1ljCokZvkcGo97Y0CKuPhn3erViULC8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77FCC60867
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] carl9170: fix enum compare splat
References: <20190608144947.744-1-chunkeey@gmail.com>
        <87pnnlncll.fsf@codeaurora.org> <1601416.I41mb68Wgz@debian64>
Date:   Tue, 18 Jun 2019 15:11:53 +0300
In-Reply-To: <1601416.I41mb68Wgz@debian64> (Christian Lamparter's message of
        "Mon, 10 Jun 2019 13:45:31 +0200")
Message-ID: <87a7ef9jp2.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> On Monday, June 10, 2019 9:06:30 AM CEST Kalle Valo wrote:
>> Christian Lamparter <chunkeey@gmail.com> writes:
>>=20
>> > This patch fixes a noisy warning triggered by -Wenum-compare
>> >
>> > |main.c:1390:31: warning: comparison between =E2=80=98enum nl80211_ac=
=E2=80=99
>> > |	and =E2=80=98enum ar9170_txq=E2=80=99 [-Wenum-compare]
>> > |  BUILD_BUG_ON(NL80211_NUM_ACS > __AR9170_NUM_TXQ);
>> > |                               ^
>> > | [...]
>> >
>> > This is a little bit unfortunate, since the number of queues
>> > (hence NL80211_NUM_ACS) is a constant based on the IEEE 802.11
>> > (much like IEEE80211_NUM_ACS) and __AR9170_NUM_TXQ is more or
>> > less defined by the AR9170 hardware.
>>=20
>> Is the warning enabled by default? TBH I'm not seeing how useful this
>> warning is for kernel development.
>
> It is included in the "-Wall" (which is coming from "KBUILD_CFLAGS"=20
> in the main Makefile).
>
> I tried debian's gcc starting from 4.6 to the lastest 8.3. They all
> complain about it in various degrees.
>
> https://gcc.gnu.org/onlinedocs/gcc-4.6.0/gcc/Warning-Options.html#Warning=
-Options

Ok, odd that I haven't noticed this warning. Maybe I have been just
blind.

>> > --- a/drivers/net/wireless/ath/carl9170/main.c
>> > +++ b/drivers/net/wireless/ath/carl9170/main.c
>> > @@ -1387,7 +1387,7 @@ static int carl9170_op_conf_tx(struct ieee80211_=
hw *hw,
>> >  	int ret;
>> >=20=20
>> >  	BUILD_BUG_ON(ARRAY_SIZE(ar9170_qmap) !=3D __AR9170_NUM_TXQ);
>> > -	BUILD_BUG_ON(NL80211_NUM_ACS > __AR9170_NUM_TXQ);
>> > +	BUILD_BUG_ON((size_t)NL80211_NUM_ACS > (size_t)__AR9170_NUM_TXQ);
>>=20
>> IMHO this just makes the code worse. Does it make sense to workaround
>> (stupid) compiler warnings like this?
>
> True. What's worse: This isn't really code. The BUILD_BUG_ON Macro is the=
re
> to guard but it's getting compiled away. I could also just drop it.

Either way is fine for me. If the GCC (by default) emits a warning for
this we need to silence that warning, so in that respect I guess we
should apply this. Unless better solutions come up, of course :)

--=20
Kalle Valo
