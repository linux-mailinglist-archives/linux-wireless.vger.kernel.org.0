Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6899CBDE54
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 14:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405795AbfIYMwr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 08:52:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41692 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732452AbfIYMwq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 08:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569415965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAxkE1h5ax6Fw7x83rQJVKg6nF9IOu73qh/OcRTyCUM=;
        b=RBg5vSSUHOtdGSVlApDsNSQjFDYy//xqBQbRMCuCPJiWcuq/yzzmjFsrVWLlKkM8FufA9x
        0qp52DAfRAFFW936C6tgpbboro8VsDnqbks9GVrcPHu+HxCykA0P6DCdmQ4U+52mj5AQ0n
        H52gfkP6AbXdSULzbSkiKt5aoUuOW18=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-8Tk1wGIkN_OjwrWm0aHLMA-1; Wed, 25 Sep 2019 08:52:43 -0400
Received: by mail-lf1-f69.google.com with SMTP id y27so814911lfg.21
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2019 05:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RAxkE1h5ax6Fw7x83rQJVKg6nF9IOu73qh/OcRTyCUM=;
        b=NNqm9X70nwbJUsadXrc5Od5QI09AAUcv3DMaQhH0Mpkzm5DgXNp8b28CNGGV5DZ8wr
         fVACrN91xRqUyP3vmwkiNCnrdiaOsUqYLDpek3x/U3QzdnbpdT9NUZJAQB+2Ud8Vb02O
         f4vLx8UkunsdWALMk/BlF/HZb35Gw1niQt3uFGDT5qAEuHFnBd5Eimgoh7aITwAO2BZe
         dW+2v4AXdEMM1yDSn35mr/OPnjpZ4JmG4OTE/BLIQuZKv67tH6spYskUI8MJdKSZAjAQ
         6UANJ+5pBLJH/GlrOhqNm9QU7S+yMfXDMJh7pxHvvv9fAJ5rC3IWYH+bhVgJ+2CT310W
         d+eA==
X-Gm-Message-State: APjAAAXSOFNlpDU9niYNAjwtlK0S8SsvCE78ZVHNIuPKIAjW5+0gdrWG
        YWlJeYK7Cv/b97vCoSGjsNFknQ807+ZcQOdhBgnIXxcTKnBth6YiMFX7i4GQSxDXub/Ebj5Pm/I
        +pub53SwR6PT0UiD80r8vsWgQHmU=
X-Received: by 2002:a2e:6e04:: with SMTP id j4mr5754586ljc.99.1569415961692;
        Wed, 25 Sep 2019 05:52:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDu6srlULdJ6FcUoQhtVcUpzhekdTROR9PDW2pnqEP42W3cf8lyFlaLcAbuTgcVyv31wAOpw==
X-Received: by 2002:a2e:6e04:: with SMTP id j4mr5754561ljc.99.1569415961476;
        Wed, 25 Sep 2019 05:52:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id q66sm1181957ljq.101.2019.09.25.05.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 05:52:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9D6A218063D; Wed, 25 Sep 2019 14:52:39 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <8c5a3a011f03d4dd4165b838a2b8bc72@codeaurora.org>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <2f6b649dcb788222e070ebb5593918c7@codeaurora.org> <87y2yc3ieb.fsf@toke.dk> <8c5a3a011f03d4dd4165b838a2b8bc72@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 25 Sep 2019 14:52:39 +0200
Message-ID: <87mues35d4.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 8Tk1wGIkN_OjwrWm0aHLMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> On 2019-09-25 16:11, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>=20
>>> So if it is going to work together with virtual time based mechanism=20
>>> in
>>> the future, the Tx criteria will be met both of below conditions,
>>>         1. Lower than g_vt
>>>         2. Lower than IEEE80211_AIRTIME_QUEUE_LIMIT
>>=20
>>> Are we going to maintain two kinds of airtime that one is from
>>> estimation and the other is basically from FW reporting?
>>=20
>> Yes, that was my plan. For devices that don't have FW reporting of
>> airtime, we can fall back to the estimation; but if we do have FW
>> reporting that is most likely going to be more accurate, so better to
>> use that for fairness...
>
> Do you mean we will use airtime reported by FW to calculate=20
> local->airtime_queued in case we have FW reporting airtime?

No, the opposite; if the firmware can't report airtime, we can use the
estimated values to feed into report_airtime() for the fairness
calculation...

-Toke

