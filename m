Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88B1072D1
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 14:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKVNLZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 08:11:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59264 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726568AbfKVNLZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 08:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574428283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ziz1rmhnoCtR1XnrQHB6g4sPV108o8irTuOGKgQ874U=;
        b=J325zoJjdEFCE2qRHe/YPhiJO70ZsAWi7q7y8gnVFY1TJ4qoYu9T+Muj1Q8qQBxAkrxYlW
        10vUDH5oSKtUHeQFGX1vS+XhIR+eFpVmQLq7MNaCPZcnXxp0ZHENuHK6xjDcNbTU2DVWzs
        e56vxg9Bg3Yqa46NRsV4RN6FTPqFHpU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-OFVpi6x9MKWF2A7IP_N8jw-1; Fri, 22 Nov 2019 08:11:21 -0500
Received: by mail-lf1-f69.google.com with SMTP id z16so1751445lfb.23
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 05:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SRjn5luqZhMXEn1fe3I15uR5OcZDdd+xXrV1J0vpkzM=;
        b=bY2KjoaDuLcYW2jng8vpX0BH6ThqwE4rbL8hwJ42airfKwfM59XD98ZnRZSBkswePY
         NjO+Rp59UXYo/u3Ws4dfQohunSOOro1L4XqvPKxrtAC1ZQAyBbY3gPXU/cZOkgsEEuAJ
         uCUkjReARyGvl9Qgq07fv584nOtZncy5rw3cc2eRTfzcc3j71tf5hbuBN4+U4BVWCd83
         dBShRHc52kkvzLneLoQYHapLoDj1WIi0xujxO82feq4/zVoReQLiZcPdnS2EDE8LJlKK
         sagXsKNZz2ChwYTfFrc5U4BtX3BofRSmz/C5f6SivBLp9l6Q84Fe2ffNUwxE7qMnkLBw
         CWSA==
X-Gm-Message-State: APjAAAW+wNoRkR7BON7Zgf9zUdwIhQEHH7BMEkqG/2PAgRw9EFGPpTc3
        Lh3RICPMFJag2CY7eUEcUmmyxhiuZ35F1905IcEyPmE9Ao+lriqiFRSqeS1JxftrXNIX221fDju
        10zVc2DKk8PY3BQySQCX8vLcGFCk=
X-Received: by 2002:a2e:9104:: with SMTP id m4mr12589804ljg.63.1574428280254;
        Fri, 22 Nov 2019 05:11:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEMMFCPmNRYJYDLt08/wrK39XICDotm1W63bZGvjh38+wIjZXfT1jJroX8Yo9wK5RzadXg9A==
X-Received: by 2002:a2e:9104:: with SMTP id m4mr12589785ljg.63.1574428280109;
        Fri, 22 Nov 2019 05:11:20 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id d26sm3342002ljo.54.2019.11.22.05.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 05:11:19 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A99581800B9; Fri, 22 Nov 2019 14:11:18 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, nbd@nbd.name,
        yiboz@codeaurora.org, john@phrozen.org, lorenzo@kernel.org,
        rmanohar@codeaurora.org, kevinhayes@google.com
Subject: Re: [PATCH v11 2/4] mac80211: Import airtime calculation code from mt76
In-Reply-To: <dea9da1dd31900306c886c308c555691552290f5.camel@sipsolutions.net>
References: <20191119060610.76681-1-kyan@google.com> <20191119060610.76681-3-kyan@google.com> <3e7bea0cc643714ec90978a7999022544a39b118.camel@sipsolutions.net> <87tv6w3w92.fsf@toke.dk> <dea9da1dd31900306c886c308c555691552290f5.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 22 Nov 2019 14:11:18 +0100
Message-ID: <87imnc3vk9.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: OFVpi6x9MKWF2A7IP_N8jw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

>> Well, one calculates bitrates while the other calculates airtime? ;)
>
> :)
>
>> But yeah, I get what you mean. I think Felix went through quite some
>> pains to structure this code to avoid divisions in the fast path. I
>> guess that is the main blocker for cfg80211_calculate_bitrate() to be
>> used instead (assuming we do want to consolidate them eventually). Not
>> sure if that can be fixed easily though?
>
> We could also do it the other way around?

as in bitrate =3D 1/airtime? Dunno, maybe? How important is precision to
the bitrate calculations?

> Or maybe we should keep both and use them as a sanity check for each
> other :P

Hmm, yeah, it should be possible to write a selftest to iterate through
all rates and compare the output of each calculation, shouldn't it?
Where would be a good place to put that?

-Toke

