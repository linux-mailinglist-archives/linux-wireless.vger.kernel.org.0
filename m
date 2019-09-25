Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310C5BD99E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 10:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634044AbfIYILQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 04:11:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31039 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634024AbfIYILP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 04:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569399073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H5j3oKikjWd/GFL/yTQQfZvWkrIpbvVCnx997hnY+NU=;
        b=NaqC7WgWNRKAviTWeZhgJMn8wWynbeI1ioLaDQWa2iHymo8xkEua2KkYxpfVbgJ24mIZui
        G5mXRJMxymRu7zPRuDTLyTt2D7xc2B2iemcUzq/1xUllA8KYBpDRXO2/fO9kG4+iPjXhmr
        GR2fwhkBkzOvDtxt5ajb0mu21/41a5g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-KT8HOrB-M1OoVk5q63JG0w-1; Wed, 25 Sep 2019 04:11:11 -0400
Received: by mail-wm1-f70.google.com with SMTP id t185so1532964wmg.4
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2019 01:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FF+TG94B/K1rpPfAPH78lOMh36aUB89zAzE6f7nuppk=;
        b=LvU+obsdgjU1xkXHxlEK1YV42nMXpEUnwCTKlpJXjqpqr+K3BrxYBGyGQTeuPfjX6C
         OTldZZlWPHAI5CHqg8RXSCgKXDSWDFmhaF+qlH/jGhd8ZswIAMDMwrtKlXl3u+8yJwBv
         vh9ebEDi1VNg8uJ5ub/CdoIFd5bxCQXOQfWUBOOAKWGYBKHh3ZurWt6DChNmPIE7VLvd
         kCEikurEANx86y+awD62UVFof8TqqJZ16u+L/9r7AuCeA01vVDNUP641oX3IhGWjvBsb
         EIXR6Ojwh3i18cHlJUspc4nrP+2k9HfFDN3uu1HwbBNL8Qirn38zZHxg0f1whme+ZwdE
         xbgA==
X-Gm-Message-State: APjAAAUSKyj0/xfd/KewOwF+g1fY/uMU2ryYm+YROvqebWm48c2U2beq
        LM+Ws2KcNpAo0YKW1xtpYU/nErPi9n+t14ubT5yA5BhqGy/bNVOvkvaLEolPBk/j+/TDdPpH5jp
        sg9IjdaqoRZf6/FM7kB5OvWtpdrk=
X-Received: by 2002:a1c:3281:: with SMTP id y123mr5817224wmy.34.1569399070202;
        Wed, 25 Sep 2019 01:11:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy/rPqlcv9OUDGl3pYBZnN8fH0fTTUx0H2m+tcBh4NPRNkX3Qv6OPWXIuOWTy7yacxBIK66VA==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr5817203wmy.34.1569399069987;
        Wed, 25 Sep 2019 01:11:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id r18sm864579edl.6.2019.09.25.01.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 01:11:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 56A4C18063D; Wed, 25 Sep 2019 10:11:08 +0200 (CEST)
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
In-Reply-To: <2f6b649dcb788222e070ebb5593918c7@codeaurora.org>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <2f6b649dcb788222e070ebb5593918c7@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 25 Sep 2019 10:11:08 +0200
Message-ID: <87y2yc3ieb.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: KT8HOrB-M1OoVk5q63JG0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> So if it is going to work together with virtual time based mechanism in=
=20
> the future, the Tx criteria will be met both of below conditions,
>         1. Lower than g_vt
>         2. Lower than IEEE80211_AIRTIME_QUEUE_LIMIT

> Are we going to maintain two kinds of airtime that one is from=20
> estimation and the other is basically from FW reporting?

Yes, that was my plan. For devices that don't have FW reporting of
airtime, we can fall back to the estimation; but if we do have FW
reporting that is most likely going to be more accurate, so better to
use that for fairness...

> Meanwhile, airtime_queued will also limit the situation that we only
> have a station for transmission. Not sure if the peak throughput will
> be impacted. I believe it may work fine with 11ac in chromiumos, how
> about 11n and 11a?

Well, we will need to test that, of course. But ath9k shows that it's
quite possible to run with quite shallow buffers, so with a bit of
tuning I think we should be fine. If anything, slower networks need
*fewer* packets queued in the firmware, and it's *easier* for the host
to keep up with transmission.

> Anyway, I think this approach will help to improve performance of the=20
> virtual time based mechanism since it makes packets buffered in host=20
> instead of FW's deep queue. We have observed 2-clients case with=20
> different ratio in TCP fails to maintain the ratio because the packets=20
> arriving at host get pushed to FW immediately and thus the airtime=20
> weight sum is 0 in most of time meaning no TXQ in the rbtree. For UDP,=20
> if we pump load more than the PHY rate, the ratio can be maintained=20
> beacuse the FW queue is full and packtes begin to be buffered in host=20
> making TXQs staying on the rbtree for most of time. However, TCP has its=
=20
> own flow control that we can not push enough load like UDP.

Yes, fixing that is exactly the point of this series :)

-Toke

