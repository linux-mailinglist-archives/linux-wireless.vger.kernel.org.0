Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 811241715B0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 12:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgB0LH7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 06:07:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45056 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728761AbgB0LH6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 06:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582801678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bR8yx4+VHxBq4L4tV6VbkYwJF0ukCwDF5ztmto9ZSJg=;
        b=GrFXZkrF+5l/FLsXp0WSfaxmCCl2bnN894LsPeuToYYT7uFtodEIhN6BXo5/YJoziEsh+G
        HWaG1Jc5IggF4Rlz1sagGJHPY8cnHdDt5+K5g17lFHHsEZkXGUy//09TfIzPfFgCVQcqQL
        87gK/ZOmXNtx69TtxG1sCbomMlg094o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-bfdXdIjHMu-ZvWfETmEEmA-1; Thu, 27 Feb 2020 06:07:56 -0500
X-MC-Unique: bfdXdIjHMu-ZvWfETmEEmA-1
Received: by mail-wr1-f72.google.com with SMTP id o9so1159406wrw.14
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2020 03:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bR8yx4+VHxBq4L4tV6VbkYwJF0ukCwDF5ztmto9ZSJg=;
        b=fvHYDOK+pSMHMv+GBG1HiQuxknLLaU4W3oJ4PZYEtB4p3bb98t/5qh15JN4S80YqXV
         fLKaRMRU0gieEozRs8EqfuRXb/k3WP7c5Nrp7l2HuZ7BoMiRguR25ho6V4W/atNG2Bur
         OXFcMM126atvp0us7QIFnda6DuvSjfyuMlyVghM9JENaW92KaHBqVfflOZS2r+8g8WPj
         X/8QUPUJ26aihu7H+0jdATrMqiLhcZhXgpe55lRkwTalgWO3BtCPO8kabws79BzysQUb
         lbcjjwtrO69rDAf6S/A7rmhlhR8XjGDulKt/wMQZpANZcHpnHbdVKw/era4UsUkEuDMT
         bz3A==
X-Gm-Message-State: APjAAAUzn3o2aLLvvqKdBKXr2uiOdllxTZGPVNVbVCdHR8VALHcsg/Cc
        ap0VwMIvErS9DpP3O/sVhfYLwr4BbCIk5SlulG56LbFgemyduXf5XCQlEuZEXyqmXcdy0ChqocG
        hb6JsM66UVgMlOAE676LMdyl9aPo=
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr4898351wmf.56.1582801675089;
        Thu, 27 Feb 2020 03:07:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxS8/QHS53GhPVQqHMpjggmy9YBMte88hrxHe1c+bQZYjVxXsno6nwIiPQ2XWQk6pzEZQ3fHw==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr4898323wmf.56.1582801674826;
        Thu, 27 Feb 2020 03:07:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h71sm8218971wme.26.2020.02.27.03.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 03:07:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AC5CA180362; Thu, 27 Feb 2020 12:07:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v11 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <cedd9fa8-e6ff-be64-d013-4243cb2fd85f@nbd.name>
References: <20191119060610.76681-1-kyan@google.com> <20191119060610.76681-5-kyan@google.com> <789d592c-5b1b-b785-6d9c-86b7cc7d57f4@nbd.name> <87k149xbb4.fsf@toke.dk> <CA+iem5vcz4PqJR+hj9CyS4pJMD4RpNz2RHxQyUy+-qT9y2WhyQ@mail.gmail.com> <cedd9fa8-e6ff-be64-d013-4243cb2fd85f@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 27 Feb 2020 12:07:53 +0100
Message-ID: <87o8tkwanq.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

>> Not sure I fully understand your concerns here. The AQL budget is per
>> STA, per TID, so frames queued in the driver's special queue for one
>> station won't impact another station's budget. Those frames are
>> counted towards the per interface pending airtime, which could trigger
>> AQL to switch to use the lower queue limit. In this case, that could
>> be the desirable behavior when there is heavy traffic.
> Yes, the per interface limit is what I'm concerned about. I'm not sure
> if it will be an issue in practice, it's just something that I noticed
> while reviewing the code.

Ah, right. Note that it's not a hard limit, though; it's just a
threshold for when the per-station limit switches to a smaller value.
The idea is that when there are many stations with outstanding data,
each station's latency will be higher since they have to also wait for
their turn to transmit. And so we compensate for this by lowering each
station's queue limit, since the hardware is unlikely to become idle
when there are many stations to send to.

The lower limit is still 5ms of data, though, so there should still be
enough for a full aggregate queued for each station. Arguably the limit
could actually be made *smaller*: On a very busy network with lots of
stations transmitting at once, IMO we *don't* want to send full-sized
aggregates as that will add up to way too much latency. Better to
sacrifice a bit of network efficiency to raise responsiveness :)

-Toke

