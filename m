Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D8154EBB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 14:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfFYMY4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 08:24:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59950 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfFYMYz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 08:24:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CD70D613A8; Tue, 25 Jun 2019 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561465495;
        bh=wcviFzRjwE9qVWQfUCBPP0SzLhVDmXOQAQFqIOx4xBs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eANUgBhdPXM/obw7lcUzpWTbnLBFpNRn63haiuwKcGvV/84oBQ37qEza+acmst5QT
         GyKwiQAjnrvqhpBXl6vLidThRfK7iZmYmbrmb3yWW31vHwUR2Xm7o+Nj0gLljGSCNP
         QM77rg8lOcvSj37YrbRs/WzGCGa/teBNoswkCIKg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29E4B613A8;
        Tue, 25 Jun 2019 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561465491;
        bh=wcviFzRjwE9qVWQfUCBPP0SzLhVDmXOQAQFqIOx4xBs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CLpyaWKglbB1cT8I2ksC+GT09KmI2oNBcTnaWfG2nH+QJ5sqlc6p765EJA8R54/mz
         UPJc03Vub0SVM1YjH+6tVQy467o6gR/DysEBLZRJQZKInaQ/v4SNlKFvXjWge8lAEW
         Q/xBd6x2xUsOdwCnQmUhPRgB+zRp3cL8gc6j9+1g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29E4B613A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Michael =?utf-8?Q?B=C3=BCsch?= <m@bues.ch>,
        H Buus <ubuntu@hbuus.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ssb/gpio: Remove unnecessary WARN_ON from driver_gpio
References: <946c86bf-7e90-a981-b9fc-757adb98adfa@hbuus.com>
        <20190610204927.2de21c9a@wiggum>
        <87v9wus164.fsf@kamboji.qca.qualcomm.com>
        <CAOiHx=k_KPgXqJYjSeUFVS3pae1CGBGS9STnTuAfNyvak2k08w@mail.gmail.com>
Date:   Tue, 25 Jun 2019 15:24:47 +0300
In-Reply-To: <CAOiHx=k_KPgXqJYjSeUFVS3pae1CGBGS9STnTuAfNyvak2k08w@mail.gmail.com>
        (Jonas Gorski's message of "Tue, 25 Jun 2019 14:10:33 +0200")
Message-ID: <871rzhrgxc.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Gorski <jonas.gorski@gmail.com> writes:

> On Tue, 25 Jun 2019 at 12:06, Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Michael B=C3=BCsch <m@bues.ch> writes:
>>
>> > The WARN_ON triggers on older BCM4401-B0 100Base-TX ethernet controlle=
rs.
>> > The warning serves no purpose. So let's just remove it.
>> >
>> > Reported-by: H Buus <ubuntu@hbuus.com>
>> > Signed-off-by: Michael B=C3=BCsch <m@bues.ch>
>>
>> For some reason patchwork (or pwcli script) didn't like this patch so
>> manually applied to wireless-drivers-next:
>>
>> e73e43246da6 ssb/gpio: Remove unnecessary WARN_ON from driver_gpio
>>
>> I have a faint recollection that I had a similar problem with another
>> patch from Michael, did we ever conclude what was the issue?
>
> Yes [1], a bug in kernel.org's version of patchwork.

Ah, that was it. Thanks!

> The fix was included in v2.1.1; latest is v2.1.3. kernel.org is
> (still) at v2.1.0. Maybe it's time to poke helpdesk?

Indeed, that would be a good idea. Apparently v2.1.0 was released a year
ago:

https://github.com/getpatchwork/patchwork/releases

So if your or anyone else has time, please do report to kernel.org
helpdesk and hopefully they can help.

--=20
Kalle Valo
