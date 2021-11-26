Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ABC45F4B5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 19:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbhKZSi7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 13:38:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241163AbhKZSg7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 13:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637951625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nq509O5VJBBOh3nT7tIsqnK6MK6HxW/KOgVMn9NaI7c=;
        b=Jagzb+Cd2Dpo+0TQA4j7f7lz4dKbGnfor6IRAYQJZvMxR3tNwtbc3ooqyY59Qnv5KpC5Tk
        8chUF6fCnTA08q9BnLZ3IaSf+A2iy3RnhPlZ9FcScOKLqqTVtScZ8ar26BLKifj+y0cJnd
        Sq8Sy6YfjAbjcFAbK/iTqhtniU3BL/0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-40-U-LOOHODPUqC9lZhLwtxrA-1; Fri, 26 Nov 2021 13:33:44 -0500
X-MC-Unique: U-LOOHODPUqC9lZhLwtxrA-1
Received: by mail-ed1-f71.google.com with SMTP id eg20-20020a056402289400b003eb56fcf6easo8565287edb.20
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 10:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Nq509O5VJBBOh3nT7tIsqnK6MK6HxW/KOgVMn9NaI7c=;
        b=YenWHUFoQnzgtx5RBp/Frvkb17qIJ+0KHRtMIKLdINSL813jBc0VM1+GzH5NZ4wUDt
         rJOOdRdjo7yZzqAEoCZojtw57hPDOR7trAPmMOJttKQX1QrX2S6f0pf7u8FNzMJ0IvHz
         YbrZOSiRFIS1DO78BZiUyiiYgvS4CYHUgBilqtYvW3HbZrFrbcRwN6BTpMF/bUo6Bo3R
         Es4LT1dDycLHRVPSnge1fYkwOFySLUMdyg06oe+A1wKQrYc7cyrwALgjuDsg1do+5lXo
         +Apvf4mY9LE5K+EDk+LTxcIY84zzEXmecwUkSTMPlkerybstMl4AVkN7+vYav6RGpkCd
         qvDw==
X-Gm-Message-State: AOAM530jwqPLkIVaVbjMsbx1M2idipsdIBUh3T3EBhxWVLrarfJZXW5T
        Fi6TFCPBwFHvVK9dVSmL08/jyWlKXDFlly+zrdlV64U5rcsIBj40t7NRy9mKMnntAwQa85ccSKF
        KZgf9ckeaZKhtu8ZF1iGkFJRymXY=
X-Received: by 2002:a05:6402:1d50:: with SMTP id dz16mr48314631edb.309.1637951622668;
        Fri, 26 Nov 2021 10:33:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrEvKz5z8quBxIX6dxS95sO6nr347xEpoRJ/+f1sWE9m6gld50yPdn8Q0dtjDtcuDbAuDQ3Q==
X-Received: by 2002:a05:6402:1d50:: with SMTP id dz16mr48314582edb.309.1637951622242;
        Fri, 26 Nov 2021 10:33:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ji14sm3585539ejc.89.2021.11.26.10.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 10:33:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E6F731802A0; Fri, 26 Nov 2021 19:33:39 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: Re: [PATCH] ath9k: switch to rate table based lookup
In-Reply-To: <878rxb3qus.fsf@codeaurora.org>
References: <20211125121652.6073-1-jelonek.jonas@gmail.com>
 <878rxcb4q2.fsf@toke.dk> <87a6hrwg1f.fsf@tynnyri.adurom.net>
 <CAChE-vTktHRW1JR8s1NNnLOqfBihd=5T2qXDsQDyBeecw95U0g@mail.gmail.com>
 <878rxb3qus.fsf@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Nov 2021 19:33:39 +0100
Message-ID: <87lf1aahrw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Jonas Jelonek <jelonek.jonas@gmail.com> writes:
>
>>> And how did you test this? Are both PCI and USB devices affected?
>>
>> I tested this on a 8devices Rambutan with QCA9558 SoC, but didn=E2=80=98t
>> explicitly test this with a USB device. I am not sure whether the
>> ath9k_htc is affected. First I tested this without the patch to get a
>> reference for comparison. I connected three devices via WiFi 2.4GHz
>> and 5GHz, generated traffic multiple times with iperf3 and captured
>> the rc_stats for each station. Then I applied the patch and did the
>> same again. The throughput was overall the same like without the
>> patch, compared to the first run of each station. Rate selection
>> worked fine, the stats were nearly identical, same rates selected in
>> both runs.
>
> Thanks. Can someone review this from ath9k_htc point of view?

Pretty sure ath9k_htc devices do rate control in the firmware. Certainly
ath9k_htc sets the HAS_RATE_CONTROL flag in mac80211, and the only calls
to ath_set_rates are from within xmit.c, which is not used by ath9k_htc.
So I think we're fine as far as that is concerned...

-Toke

