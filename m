Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3A0E24EF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 23:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403931AbfJWVJP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 17:09:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42059 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732586AbfJWVJP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 17:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571864954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2Bt+TeFORfohjlF3bqI3+Mu+yeYbBVrSueSOmuZILw=;
        b=LYC3Yyw8uwS259WWLUIauNHEQYWj+ZTaCvzECsD6Y54l+sBbIER67GK4jODVjb/4jS5tga
        I1oqSFE4MhkHeVCAPY9Txp7hby6NDIHm/uWP0xghzhyI27eUJoW7Zk/O6Y0JRQt9os9D/H
        oXA/nUi6JJqTw5POnX3GeufpUEFU00U=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-1hhKc0CgN66roA3cOsx91w-1; Wed, 23 Oct 2019 17:09:12 -0400
Received: by mail-lf1-f72.google.com with SMTP id k30so1428125lfj.5
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2019 14:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=j8uth/YyCcw2cd/AKaSr6zH2GVsN12xt/bp7qE7X9Ng=;
        b=B+NRPJ8+DEVY/5UNvi6Dsqrm4ErKu5RLcZI6vwEwF0NPa0YmBZpVZO3ckgZs4SqABZ
         de/EIVFR2x4a8eUEJeYhwBxNiXL7Ow9MyfYHgotgGBrVo+n2mFgXOBlttfJALOMi0GNd
         LYATFyjqna/+bJ1WEvqmg6KjDHDoiauLsU6g6kv71IwuuH/xJcEE+/fOQ6aOJKI0Q4LU
         e279RZhfL6rhKL6NZ9/KqW4Bwg5Lqo1Roxea5NOFJ79wtUr4tChg+ByD6wQhYQUyXEoO
         CcH57KcfRcAceHI1i5Jg4wzw7Aw3/3GV+3+avViFzr9J7OYvQFdSxwqkoqiuLC7MZucF
         xrXQ==
X-Gm-Message-State: APjAAAVTQNpW8JqXchb9Naz20JNihAsxBAWIM97suIRgAlqLFVqDiAN4
        Sj2/cOrOLVydi3khRtsSGWKJQ8w7CnQbVWvkgdy2ilhc8KB5evtO1VNFUsOXyBL6tqriWeEWn/w
        sdeWZv3tfFi8DhPvfOzhlElPc9V4=
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr24328846ljk.103.1571864950206;
        Wed, 23 Oct 2019 14:09:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYFFtiQHnJ5LqHgsHhFH7IcaoyXeT9h2Tuo3q9/5F1AX2go+DSXHCEgirMEaZeL4pFglNNZQ==
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr24328834ljk.103.1571864950024;
        Wed, 23 Oct 2019 14:09:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id z1sm9491454ljh.88.2019.10.23.14.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 14:09:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1DE0C1804B1; Wed, 23 Oct 2019 23:09:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v4 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <CA+iem5vU-K-+sSSeNugy5ZZF_nH5vuaXW3J_WC=1WWhdkHOgjw@mail.gmail.com>
References: <157148503415.2989444.7391437309981941226.stgit@toke.dk> <157148503865.2989444.7118792679603045723.stgit@toke.dk> <CA+iem5sy16=xMZjJi1nKHrxP_xWHk-86G=ZLwtMMb04EOt5tQA@mail.gmail.com> <871rv5ovwr.fsf@toke.dk> <CA+iem5tZ95Jd9htLEdAJMubuFeWeUibK9MhTnTHLWNucX6_cRg@mail.gmail.com> <87tv7znact.fsf@toke.dk> <87lftbn60t.fsf@toke.dk> <CA+iem5vU-K-+sSSeNugy5ZZF_nH5vuaXW3J_WC=1WWhdkHOgjw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Oct 2019 23:09:08 +0200
Message-ID: <877e4vmaob.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 1hhKc0CgN66roA3cOsx91w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>>
>> Aha! Turns out I was doing the sta lookup completely wrong in
>> ieee80211_report_used_skb(); so anything frames that were dropped and
>> went through there would not get its airtime subtracted correctly. Will
>> send a v6 with a fix :)
>
> Awesome, thanks! That looks very promising.  The symptom I see with
> previous patch is the interface's pending airtime count looks fine, but t=
he
> station's airtime get wrong, either due to airtime is credited to the wro=
ng
> station or wrong AC.

Right, if the interface count is fine that means it's not a missing call
to the subtraction. So hopefully it will be fixed with v6 :)

-Toke

