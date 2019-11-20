Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84013103744
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 11:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfKTKOQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 05:14:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55619 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728581AbfKTKOQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 05:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574244855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEKvOxmr/7NLtoqif+lmbtJ5Ka/hKgAKqI6KOkdaNss=;
        b=SLhxv7etBxUSKCeFKWjplR4RoH1gKThm7ppVoafVgJUGRGsM8/Ev9pv3zXjOcIZVStIhtF
        s7kkzhaEKmQqMLeiVhoRVCVB8hMkTKw4h1q1NRRtkvTZ6eZa/IYHiFEL7N1R+kbdN/EL52
        c8pi7sk8C+RTq3EForONwLhmYNDypqg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-_y19TmpCPzil4uxMXHaOjg-1; Wed, 20 Nov 2019 05:14:12 -0500
Received: by mail-lj1-f197.google.com with SMTP id 70so4712992ljf.13
        for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2019 02:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fKMBRKKpaoMlSII2moNkw+zJtmUVNSbZ+F1avrH659c=;
        b=qeXNxEEGOIOLYMfElFXAaaH7XjCtUNd9HxW8eIQPuKNyFZSTwPGnjuIecauhlhN0AM
         JP2got0rgmaC6td9pPRtC6qobFzZEzZOUCtc4ml42dVQnS3i0K0ylsQ/lH4b4Ex+DZMI
         p9l2h+0oW9Dms1LRYXYNJ87xdnLTZuioIz8hnbRHGeuF/wJ+PPCKXo8jo6tIBOKYJemo
         oPekxAPUenB5A9oazjESVkjfpijK99nSl1EGQ1dnxH72Y0VTuPKUvdRy8c/dDuUoJIoj
         1Ig18+o8h9GGrO97S9Mr1Y755imeMJD92vOBDqR+pfUrz051HNiIoSev+2kvNMGUH/5T
         NkMw==
X-Gm-Message-State: APjAAAXj14acUSG4Q/nbOCBaKKQvboYt7MXCJkhH2sfiVkeFa+nE2B47
        myH1ZIZQrpArZW/9vPrfRP6E8wuNKTlJZ4ffMD68saO7FWl2MFgNewSAe0xLyl1GwnNuNDldoQn
        iVD54s1ocEJ08oG9HR/X3aMoDlH4=
X-Received: by 2002:a2e:3009:: with SMTP id w9mr2069288ljw.74.1574244850944;
        Wed, 20 Nov 2019 02:14:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqzz0j0GllypMuFTfk3eJAjjpWU8fCBRAYfRKxpQqC34cMGuViFXOmq9cdjSIMsSAsHugcf9LA==
X-Received: by 2002:a2e:3009:: with SMTP id w9mr2069278ljw.74.1574244850800;
        Wed, 20 Nov 2019 02:14:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id u184sm12021852lja.86.2019.11.20.02.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 02:14:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E696918190F; Wed, 20 Nov 2019 11:14:08 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>, Dave Taht <dave.taht@gmail.com>
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [Make-wifi-fast] [PATCH v8 0/2] Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <CA+iem5uVJFcCYpJfhker-48XPrOf3a+NWr-nKnBtGmLX2yB_Lg@mail.gmail.com>
References: <20191115014846.126007-1-kyan@google.com> <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com> <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com> <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com> <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com> <CA+iem5uVJFcCYpJfhker-48XPrOf3a+NWr-nKnBtGmLX2yB_Lg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Nov 2019 11:14:08 +0100
Message-ID: <8736eiam8f.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: _y19TmpCPzil4uxMXHaOjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> Those were lovely, thanks!!!! Big win. Since you are on patch v10
>> now.... Any chance you could turn ecn on and off and give it a go
>> again in your next test run?
>>
>>
>> Also:
>>
>> --step-size=3D.04 --socket-stats # the first is helpful to gain more
>> detail, the second as to the behavior of the tcp stack.
>
> Thanks for the feedback! I will do more tests in a few days.
>
>
>> Secondly - and AFTER this patchset stablizes, I'd like us to look into
>> returning the codel default to 10ms or less
>> from it's currently 20ms or worse setting. Tis another easy test
>
> Smaller CoDel "target" doesn't work well with wireless because the
> dequeue behavior in wireless driver is very bursty. It is quite often
> dequeues dozens of packets in one burst after one large aggregation is
> completed, so smaller CoDel "target" can cause unnecessary packet
> drop.

It would be interesting to get some samples of the actual sojourn time
as seen by CoDel in mac80211. Might be doable with bpftrace...

-Toke

