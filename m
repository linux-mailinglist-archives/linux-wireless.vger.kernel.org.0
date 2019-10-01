Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9772C3211
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfJALMm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:12:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48154 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730379AbfJALMl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569928360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6znhX1N4aAvrURLMYg6hXqxDVCehcDRMYi9CDR0nNOk=;
        b=QZByVpuA3CpAraj1hnsBaZtNocjY1zTx2vCgI7vvNKoQ+ZMM9sry5bs/bJd8YQZLpO9lzs
        UiHYossmpO5lGpgLxm0rv8q6nFQuaeONfqoDW2uWf8O+nCXuNGBxWEpuVcyewM9MVls1FO
        VWFxe9ktK55K42Py55k0RxQFN8iBlho=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-_Sy8g5zLOZyCaXztCKEgNw-1; Tue, 01 Oct 2019 07:12:36 -0400
Received: by mail-lj1-f197.google.com with SMTP id g88so1367093lje.10
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 04:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zZ/pd9oj4wAvGYTdQ/OGx4fwIKlP4XmIEduHUK58wJU=;
        b=LNWT+VzoxEFgmqeVRE+4Ie4ExiNVeGPSME0H4obKogr8qEww/oQjwhIsSqVXHT8om8
         P6Pd9KGOowq2Y3reDObp3TAqcXlsB+UU1xqMTOgJtqZxMWT2TJQRfWwu81JC51drIYeK
         y5QNoz32YQQbToWjDekWlwEENaw4ihxPLTfp2HgWAmwq31KeLUdE/bJDf/osnTdZNnNX
         vWR9znB392KOGMvdcN4lL7zIATZ5Z4KsVu8BBV/+ThDyhoNCh1KSEeg2J0/AqOgKb46w
         /lYhtcqI49HrM2HqrLqb/RfdRY4Bbbj/jJm4PMejupGGXufanAzxaEpSf/aOWb1IiTX9
         KKfg==
X-Gm-Message-State: APjAAAWv4DBfvNgY2UAvbcroAi2rmN6yMf34QxWove1embe+2pM9UcWz
        HvC0Yq2S+AJHKlm5gCPqWgo1Q/d+Cm6Dn2DLqzN00mSRggRFDlD0p5i9rVALFCXCDNPsf7vpYiT
        +inpwwPtIMgVMcXCbl1B2BOaQ4hA=
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr15279509lje.90.1569928355076;
        Tue, 01 Oct 2019 04:12:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxhkkENlNI0FQC6gVX5b0ZcgUDH9TsaLwCskuWRKzu9ls7BW6lt/f3WJleJapGd45dZd7+GIA==
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr15279497lje.90.1569928354882;
        Tue, 01 Oct 2019 04:12:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id l16sm3862134lja.34.2019.10.01.04.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 04:12:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 79DD318063D; Tue,  1 Oct 2019 13:12:33 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>, Aaron Hill <aa1ronham@gmail.com>,
        Lukas Redlinger <rel+kernel@agilox.net>,
        Oleksii Shevchuk <alxchk@gmail.com>
Subject: Re: [PATCH] mac80211: keep BHs disabled while calling drv_tx_wake_queue()
In-Reply-To: <bb98e67fd47effce9eada17bdf24a9d0b7102f31.camel@sipsolutions.net>
References: <1569924485-I3e8838c5ecad878e59d4a94eb069a90f6641461a@changeid> <87blv0visz.fsf@toke.dk> <bb98e67fd47effce9eada17bdf24a9d0b7102f31.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Oct 2019 13:12:33 +0200
Message-ID: <87wodou3by.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: _Sy8g5zLOZyCaXztCKEgNw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2019-10-01 at 12:53 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>>=20
>> > -=09=09=09spin_unlock_bh(&fq->lock);
>> > +=09=09=09spin_unlock(&fq->lock);
>> >  =09=09=09drv_wake_tx_queue(local, txqi);
>> > -=09=09=09spin_lock_bh(&fq->lock);
>> > +=09=09=09spin_lock(&fq->lock);
>>=20
>> Okay, so this will mean that the drv_wake_tx_queue() entry point will be
>> called with bhs disabled.
>
> Right.
>
>>  But there are lots of uses of
>> spin_{,un}lock_bh() in tx.c:
>
> [snip]
>
>> so won't that mean that the driver still gets bhs re-enabled after (for
>> instance) the first call to ieee80211_tx_dequeue()?
>
> No, local_bh_disable()/local_bh_enable() is re-entrant and nests fine.

Ah, right, gotcha. Hmm, in that case, would it be more clear to just add
an outer local_bh_disable()/local_bh_enable() to
___ieee80211_wake_txqs(). With this patch we're relying on the
mismatched use of _bh/non-_bh variants of the locking to ensure the bhs
stay off. Isn't that prone to breaking in the future?

Oh, and also, with just this patch, the additional drv_wake_tx_queue()
call for the vif TXQ at the bottom of __ieee80211_wake_txqs() will still
happen without bhs disabled, won't it?

-Toke

