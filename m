Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 639C7ED3BA
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2019 16:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfKCPlN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Nov 2019 10:41:13 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32905 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfKCPlN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Nov 2019 10:41:13 -0500
Received: by mail-oi1-f195.google.com with SMTP id m193so12076665oig.0
        for <linux-wireless@vger.kernel.org>; Sun, 03 Nov 2019 07:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pXhuA35rV7ePG1ZIKtF2LtLpDJmiH43i0riiT8j/X8E=;
        b=LacAWruNYAs0mN+2zhicL76VH4wHceFdtxzrgIX92VdC+6MvXP6NlOwxCC9H5KGcz0
         U7n5ZRpXBDJmjgwmr9J9G5moEG8XqwT06pfxUp+kdD1rke7+poF+3GmKafLvsFDDdEvJ
         5hsqV+DmPdgMKMmHvXA3mgm3ZEmpsQmzFwTHNmPCIWEC4PQDVdKgSvYPnYvzYHNApyX8
         8SSYB7HGv8bieSkUYkwO9HhV6DEcz513kSuBHpkUfW2xmZxs7QZfcs7xdhE1AxzLxIYm
         44Xm+ufQHjvXOL+MXyuQu+6RHNpOTZ4Dl1/bcYn3y6KM6In40Gmdr4Aa2oP4NlJWAOXm
         AvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pXhuA35rV7ePG1ZIKtF2LtLpDJmiH43i0riiT8j/X8E=;
        b=g6nunEYPCEKbBNtU0YPX8uHGuTW+3zYprE/eDqAFMKDwbqSkj+rlc9a+Fk+1gbvzpG
         OvZso+VDtKIBBVFtxjbrRv9slmoICAm1oYve3HzgRaYl+sSludBugyORlbkV4tN1DBJz
         Ti1xyOTj+9iIBRwb5e5YYs8cfqIThGTlhs8pd8DIHvmAFju1AVfh6APatgd29aY4PpHa
         oeChtlzkEA2PbBYxYfzVvbQ2prk11w5BPtg0W/d3U0Hq7v3O5l8I8SwRBhtrvB8AsiOv
         f3aFHfv+7kPp8MHppxPZKH01F9hgC2fLj6nV9k7SJqE2rdhb26O3MW3YXJZb2YNL88g/
         xSrg==
X-Gm-Message-State: APjAAAVig//owV08KDLEC85C87E8+CzGTGWyZTnGpDzYl67o6mHGjBzH
        nSLinW/X/2srE7VJX2yyd3Yasg+friwUN9owDbY=
X-Google-Smtp-Source: APXvYqzVwdDHlxyHof1UTcJvZLebd1Pk+1m7LeWL3Rg+Q+Q/Qi9i5zKZh2aQt1UExSCVt/2TFDtcp/BKokmK5ltDPKI=
X-Received: by 2002:a05:6808:658:: with SMTP id z24mr1706463oih.50.1572795672058;
 Sun, 03 Nov 2019 07:41:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:384:0:0:0:0:0 with HTTP; Sun, 3 Nov 2019 07:41:11 -0800 (PST)
In-Reply-To: <20191103144749.GA8889@redhat.com>
References: <20191028212244.GA2590@makrotopia.org> <20191029091857.GB3571@redhat.com>
 <20191029100503.GA1228@makrotopia.org> <20191102154639.GA4589@redhat.com>
 <20191102174227.GA1250@makrotopia.org> <20191103144749.GA8889@redhat.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Sun, 3 Nov 2019 16:41:11 +0100
Message-ID: <CAKR_QV+LkUU2+G7z8um7RpSbi0ANfRGe_TeoGky+U9ff=8sOZA@mail.gmail.com>
Subject: Re: [PATCH] rt2800: remove erroneous duplicate condition
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03/11/2019, Stanislaw Gruszka <sgruszka@redhat.com> wrote:
> On Sat, Nov 02, 2019 at 06:42:27PM +0100, Daniel Golle wrote:
>> > This was changed by:
>> >
>> > commit c2e28ef7711ffcb083474ee5f154264c6ec1ec07
>> > Author: Tomislav Po=C5=BEega <pozega.tomislav@gmail.com>
>> > Date:   Thu Dec 27 15:05:25 2018 +0100
>> >
>> >     rt2x00: reduce tx power to nominal level on RT6352
>> >
>> > and I think it is correct.
>>
>> Ah, ok, that's a bit funny, because it means that this change actually
>> never made any difference, because the codepath wasn't executed.
>
> Yes, this was used/tested on patched rt2x00 driver that switch to this
> different codepath. Now it will be used by default :-)
>
> Stanislaw
>
>

Hi

For your reference: rt2x00: reduce tx power to nominal level on RT6352

iPA/eLNA - fixes too high power output
ePA/eLNA - doesn't have any effect
iPA/iLNA - not tested
