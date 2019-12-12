Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8E0811CB7F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 11:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfLLK4B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 05:56:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40489 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728722AbfLLK4B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 05:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576148159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVuBPnfR/HUS/yWuKBmjrvaEvLDIt8r0mtmDvQvQWOM=;
        b=SPoaXexcXAin6DISTlAke9DPfLwqgE3PckrWK32etpHRdEh92ogRXnAIQirGOH1OC+XStZ
        NQw91gBF5eY0F7Ko0GfpS204rvDkLhfxEYub0uAai+kk8hl9Cc56aKOLb/Il+sIp7x4x+I
        x6+3QFYKOJnE5tvKjdO7uszPeS3uFiw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-glD_z920OUq6RNAENiWV2w-1; Thu, 12 Dec 2019 05:55:56 -0500
X-MC-Unique: glD_z920OUq6RNAENiWV2w-1
Received: by mail-lf1-f72.google.com with SMTP id t74so490073lff.8
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2019 02:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GVuBPnfR/HUS/yWuKBmjrvaEvLDIt8r0mtmDvQvQWOM=;
        b=gpVNN16MmDr5LSlzvfA6oN8BAgK0TWDtJHSMRbhB7VlrS7++KI3usyDbjmiFMd2u4e
         tgLn8461RMx5/IsgN6q9WpD2quSLu1hWfcQO0PGuaT5b88kv4hc4hytFbDIGnR2S98mW
         9j0TTdOGIm3xBZs4xkMYlbm5oGYVYOniRMYl9YqsZ6epdgTAFi1dudikNIsQ9CYPR74y
         Ueq+RkGPU19cQL+0Yd9aBYnirPTkhvxdRiYR9HQSLuYlfBHtWlfMQqbWgsLBZLkIXz3J
         XqiVkfP2Rb3Ctyqrirs+TrRY8RxZCv/ssoIZia2bF6HdMN3cbfpvv/M6ScLPUZ1dDXa0
         08hA==
X-Gm-Message-State: APjAAAU4hhyPFT6+waP+TKZrDmdMaJMvYktliFXu0yR/QtkkGPtIpYfA
        qRWh5G8jkIVP6HSfN7sfZAaxxCxo4FrBvJhDX5xolFpXAvk3kNi/CKn+JUGpqlPNhP8EwmVuez+
        p2Sg2gFVsnEWfPjB8ExofTb0daT8=
X-Received: by 2002:a2e:6e03:: with SMTP id j3mr5586820ljc.27.1576148154770;
        Thu, 12 Dec 2019 02:55:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQulJb9cL64aWnAVkDEjCXAkMtslsz6volfbLipNj/bndQRMaE4qy42O8bTfWr0N4Tt16Qug==
X-Received: by 2002:a2e:6e03:: with SMTP id j3mr5586810ljc.27.1576148154561;
        Thu, 12 Dec 2019 02:55:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v26sm2783102lfq.73.2019.12.12.02.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:55:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7FE311819EA; Thu, 12 Dec 2019 11:55:52 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jens Axboe <axboe@kernel.dk>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Steve French <smfrench@gmail.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: iwlwifi warnings in 5.5-rc1
In-Reply-To: <5d82fa60fa8170c6a41e87650785ba008da11826.camel@sipsolutions.net>
References: <ceb74ea2-6a1b-4cef-8749-db21a2ee4311@kernel.dk> <d4a48cbdc4b0db7b07b8776a1ee70b140e8a9bbf.camel@sipsolutions.net> <87o8wfeyx5.fsf@toke.dk> <e65574ac1bb414c9feb3d51e5cbd643c2907b221.camel@sipsolutions.net> <87d0cugbe5.fsf@toke.dk> <5d82fa60fa8170c6a41e87650785ba008da11826.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 12 Dec 2019 11:55:52 +0100
Message-ID: <87sglpert3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2019-12-11 at 15:55 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>>=20
>> > On Wed, 2019-12-11 at 15:09 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>> > > If we're doing this on a per-driver basis, let's make it a proper
>> > > NL80211_EXT_FEATURE and expose it to userspace; that way users can at
>> > > least discover if it's supported on their device. I can send a patch
>> > > adding that...
>> >=20
>> > Sure. Just didn't get to that yet, but if you want to send a patch
>> > that's very welcome. I have to run out now, will be back in the evening
>> > at most.
>>=20
>> Patch here (for those not following linux-wireless):
>> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D215107
>
> Thanks!
>
> Maybe I should roll that into a single patch so it's actually easier to
> apply as a bugfix while keeping ath10k on AQL for 5.5, otherwise it
> could be argued that the ath10k patch is a feature for -next ...

Yeah, good point. Since it seems I'm sending a v2 anyway, I'll combine
the two for that...

-Toke

