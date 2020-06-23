Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C396204E14
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 11:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbgFWJfi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 05:35:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34984 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731861AbgFWJfh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 05:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592904935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8t8l0WD94Z/o9FZCmgK8w3SYLMkPUSfPtqimevExj1Y=;
        b=Q1sihA3T7V19yelB4uGEd4tJkPaVAj17gEjuMaJoMtkWrh2Mz8AVX7vRbOxWLAEoA8NLEt
        ipS+NNvG4PBAir5cWSka3mboa6woHUv34qJF2wS7yJDFLLcoJMgd5MQM8atekcZ+mX3NID
        aIUnylrEoHOAafXt4jpJB/t7s1bENGs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-4YOFbT2SPBmOXvZ1qcHwuw-1; Tue, 23 Jun 2020 05:35:33 -0400
X-MC-Unique: 4YOFbT2SPBmOXvZ1qcHwuw-1
Received: by mail-wm1-f69.google.com with SMTP id l2so3259066wmi.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2020 02:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8t8l0WD94Z/o9FZCmgK8w3SYLMkPUSfPtqimevExj1Y=;
        b=ILqva1MTPCUuXVu2RVVpGhItb/ihuovih6BMQ+71CLOBOuf6OJg84MRGI808WxgAOe
         +S+yjNker8EGjKYxxcVotQnoK7yaEJTtxXTJABT9Sj73k0TCualUGW8yD0himo5cqYJP
         uUt3gKGE2eWAhdM6jB68Apyjhv4FFZibw285PbVPSGdAEiIJtExROkNEL457mHPSHBUR
         FYjCon5hVnZ7o5T6Wj4hcgqFkMNde7EcTsDjLRp4fvRQ8kwCz1J2cJkclyL6FyW9CX+n
         o7UyHfxyqAPORU864lxrSvrozm9J9+8wfPWHfhr5tfPmtfUlPoGeX5piC/zc1CSsYoX5
         0bzg==
X-Gm-Message-State: AOAM5339/EeoOkjyZB178WWfNPwXRsgfinIaI4mdl6jsMzQvc6IUiZuq
        U/GrTd3uapprAvoF6DDrf1okLfctPXtQFWdo9Xedyo4shgyhf0m+eWqA7un34+ImJCP0ggmU3vC
        XgtoAo7HbZaLIAj05TXe1aBWC4wA=
X-Received: by 2002:a5d:498f:: with SMTP id r15mr25651971wrq.175.1592904932339;
        Tue, 23 Jun 2020 02:35:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsicQl2Vu9aNjKz9oQUfQD432xl1fEWFRTaOXg+AmYhW46FIJpGg3JdpVCpS/DyoLNufYJ6w==
X-Received: by 2002:a5d:498f:: with SMTP id r15mr25651947wrq.175.1592904932056;
        Tue, 23 Jun 2020 02:35:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v24sm24963115wrd.92.2020.06.23.02.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 02:35:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F22B3181502; Tue, 23 Jun 2020 11:35:29 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Miguel Catalan Cid <miguel.catalan@i2cat.net>,
        make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org
Subject: Re: [Make-wifi-fast] Support for airtime scheduling using ath10k
In-Reply-To: <CAMHmoovK_m=Yd4uUPhsdHZ588+d1DF-fyS+uGKdRWvd33Q2u+A@mail.gmail.com>
References: <CAMHmoovK_m=Yd4uUPhsdHZ588+d1DF-fyS+uGKdRWvd33Q2u+A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 23 Jun 2020 11:35:29 +0200
Message-ID: <87zh8uruou.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miguel Catalan Cid <miguel.catalan@i2cat.net> writes:

> Hi,
>
> we are trying to apply different airtime weights to different stations in
> order to have some prioritization among connected stations. While this is
> working pretty well with ath9k, with ath10k we always obtain a fair
> distribution of the airtime (i.e. 50%-50% in the case of two stations),
> regardless of the airtime weight specified.
>
> E.g. STA1:
> RX: 0 us
> TX: 2295610622 us
>
> *Weight: 200*Deficit: VO: 256 us VI: 256 us BE: 34 us BK: 256 us
>
> E.g. STA2:
> RX: 0 us
> TX: 162597077 us

2295610622/162597077 ~= 14

which is not *too* far from the 20/1 ratio you've configured? Does the
ratio change at all when you change the weights (i.e., if they are
equal, do you get closer to a 50/50 split?).

Do the two stations have roughly the same signal strength / rate?

> *Weight: 10*Deficit: VO: 256 us VI: 256 us BE: 9 us BK: 256 us
>
> We are using Compex WLE650V5-18A cards.
>
> So, does ath10k support airtime scheduling? In such a case, do we need
> specific Wi-Fi cards?

It should. My guess would be that maybe you're not getting enough
backpressure for the scheduler to actually enforce things correctly. You
could try to look at the TXQ output and see if you actually have any
drops ('iw dev wlan0 station dump -v' and look at the drops/marks
columns).

What kernel version are you running? If it's not new enough to have AQL,
that might help moving the backlog to where the scheduler can do more
with it.

-Toke

