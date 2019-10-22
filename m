Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC20EDFE84
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 09:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbfJVHl4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 03:41:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49298 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbfJVHl4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 03:41:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 589AC608CC; Tue, 22 Oct 2019 07:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571730115;
        bh=5kAA4mT4aDnapzUXO5WJEhUXAaVmmYUWJy95iQGq4f8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=c+5iGDG6tmX50bb7aMJuOz+tS2miCFDtz8F2TNhaW5UJNg4KJh3C80EXt5O7f6P+R
         5UbTPxPjMq8KEx/pfljd6WX/5yqlu4P2+E9zkvvUh2ONFM+tgBZV4Apgwk1OAcM/cB
         YC1WZJp5QoOO3Db/yE9ZTcWhXX5xdGsP9CxpLa+E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA5A3607C3;
        Tue, 22 Oct 2019 07:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571730108;
        bh=5kAA4mT4aDnapzUXO5WJEhUXAaVmmYUWJy95iQGq4f8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ikhToIN9IbxSHfDqmzh4SWMj8nxa0czwF9LJxO/RiXtE3Hmc+ZwrcHZ780BoXzMnI
         8ZNT0SY+ccHvWQwOSr80/12xXYLNtx4e0H0ejSGhplIV1L5x4YuODJGEVcon434W20
         tKLNy3MXX5eqiStmJfY8cASRetZsdEj/mWfhyENs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA5A3607C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Kan Yan <kyan@google.com>, make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Yibo Zhao <yiboz@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v4 0/2] Implement Airtime-based Queue Limit (AQL)
References: <20191011022413.176208-1-kyan@google.com>
        <87wod7y9ui.fsf@kamboji.qca.qualcomm.com>
        <87sgnvy9c2.fsf@kamboji.qca.qualcomm.com>
        <CA+iem5uLYFVQjPaE1QDKc6c+eKz8Xd4LbwczYXOBKP3q+HHdBg@mail.gmail.com>
        <87r236tbgz.fsf@kamboji.qca.qualcomm.com> <878speqh75.fsf@toke.dk>
Date:   Tue, 22 Oct 2019 10:41:43 +0300
In-Reply-To: <878speqh75.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Mon, 21 Oct 2019 16:57:50 +0200")
Message-ID: <87zhhtjkg8.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Kalle Valo <kvalo@codeaurora.org> writes:
>
>> (please don't top post)
>>
>> Kan Yan <kyan@google.com> writes:
>>
>>> I believe Toke will integrate this with his version and move the
>>> estimating pending airtime part to mac80211, so maybe in the next
>>> version, ath10k change is no longer required.
>>
>> What do you mean? Are you saying that I can drop this patch:
>>
>> [v4,2/2] ath10k: Enable Airtime-based Queue Limit (AQL)
>>
>> https://patchwork.kernel.org/patch/11184783/
>
> Yes, we're trying to do it all in mac80211. See
> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D190333

Thanks, I dropped this patch now.

--=20
Kalle Valo
