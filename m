Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E10BEBC3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 07:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392589AbfIZF5h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 01:57:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55811 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730840AbfIZF5h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 01:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569477456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Yu/mX+8B9QuHL4hN9k+El6bWskPSkNQA2rcFqy57vI=;
        b=fUbvH6JNDS1nCfR9fDMAdhav5PcRrNT+pj9bOeFph/Qe3Ct9QfhRPEOTJfJ83+aLpHjKp2
        MeU2PDSlLdURpyo9gXcZT3+K8RZKyez15d6uV//rj26c/CQPS/41A9XPNSkXsk+4WiMwco
        TwCLbkwIldir2OCucCaK8lT4n3oHqPs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-hNSTKXA9OkWwLJBdCJ6LSA-1; Thu, 26 Sep 2019 01:57:34 -0400
Received: by mail-ed1-f72.google.com with SMTP id c23so621686edb.14
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2019 22:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ucadyRpb1IAjd+Ci9gbzaePonwLnfEH0c/EZa1gvDYA=;
        b=DWj/+VLjfSfPuMcPp9NUt1nMNpNtu5R0Mv+nl0DKWCaEwUEBGcesU90y6Qko/k3w38
         qDrof9Txmw8GxIgjPxGRici6K+eLgVKtzKFtQNYQyo+yNjH7jTsJTapYV4Tm1jWC/N1v
         +mg9iaJ2F9R5Zbr6hLZluNvt+K1S1Wk5i4inBEpitUzxAz0xfXJ6YqV6IUlbgC2WYejl
         3+bPl/vpC0ha3ZAHhLaxVgbOKsjwo4MT+Ajca3VnoUQFlKBYZHLDsJNPv80GbODzeW8B
         of++/Tm0hzAXbYEqgG8gP7SWRgeWVapZyPCc02LCsmdL+FB9jTB5ydl8GpKhPlMpBDJz
         WAxA==
X-Gm-Message-State: APjAAAUtQqiV3cAJGtFLY51zdBkViRjWVcOSBcfd2l44tqL9zB8Es/B+
        sa0cu0nU7DmrN8un3P4m7b0bQDFx75Jwe3LD355cb6JkwiIzLCiou5JCwlehocevgX3zTrDBz4k
        uWbV1o5hFqWKmwykTJJ4DkcThiXY=
X-Received: by 2002:a17:906:c4b:: with SMTP id t11mr1560880ejf.131.1569477453454;
        Wed, 25 Sep 2019 22:57:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzZQkbrsuzYGBmNMjgwjNSUZV1jZsLX07Efpokm64PxqfNa8lwKXgeX06dISnqxi1DS0IQbZA==
X-Received: by 2002:a17:906:c4b:: with SMTP id t11mr1560865ejf.131.1569477453244;
        Wed, 25 Sep 2019 22:57:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id v8sm257914edi.49.2019.09.25.22.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 22:57:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D82D318063D; Thu, 26 Sep 2019 07:57:31 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Yibo Zhao <yiboz@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <CA+iem5uGU0mQ=37dvp-pnvyk_T9o5cp7vOpsi90U9X-rMjtZ5w@mail.gmail.com>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <2f6b649dcb788222e070ebb5593918c7@codeaurora.org> <87y2yc3ieb.fsf@toke.dk> <8c5a3a011f03d4dd4165b838a2b8bc72@codeaurora.org> <87mues35d4.fsf@toke.dk> <CA+iem5sg-YpkBX4VQPzqibN0YApMxtwFsGqjK2cUUrxD_52zPw@mail.gmail.com> <CA+iem5uGU0mQ=37dvp-pnvyk_T9o5cp7vOpsi90U9X-rMjtZ5w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 26 Sep 2019 07:57:31 +0200
Message-ID: <87k19v38hg.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: hNSTKXA9OkWwLJBdCJ6LSA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> > Do you mean we will use airtime reported by FW to calculate
>>
>> > local->airtime_queued in case we have FW reporting airtime?
>> No, the opposite; if the firmware can't report airtime, we can use the
>> estimated values to feed into report_airtime() for the fairness
>> calculation...
> The local->airtime_queued is the 'future' airtime for the packet
> pending the queue. It can't be replaced by the after the fact airtime
> reported from firmware for the frames transmitted.

No, but on tx_completion we could do something like this:

airtime =3D CB(skb)->tx_time ?: CB(skb)->tx_time_est;
ieee80211_report_airtime(sta, airtime);

That way, if the driver sets the tx_time field to something the firmware
reports, we'll use that, and otherwise we'd fall back to the estimate.

Of course, there would need to be a way for the driver to opt out of
this, for drivers that report out of band airtime like ath10k does :)

-Toke

