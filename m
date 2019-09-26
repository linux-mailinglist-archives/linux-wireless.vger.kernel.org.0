Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB4EBF5BC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 17:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfIZPTT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 11:19:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47375 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfIZPTS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 11:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569511157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xceFySE/YPdpcHCuBlnpxqyBfL1iE5XunI8gt5xpca8=;
        b=YusMjvjTUINeoAHJ8z/lDwqRB3VNDm4NrmDlyLf/QZFJySHR+jbeFCx3pINR6H4oyvq5Tc
        0WKmG24u8cC/QWQXHK1y45hLoXanC6Ssn3l/9q6/kyFcVL21KpvVL4iKntmNNwUnhu9SnC
        HJHcS6r++gKWnftziTnEyxXiabVl+FA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-yGePz0zEMOqIGp_h2nm_Gw-1; Thu, 26 Sep 2019 11:19:15 -0400
Received: by mail-ed1-f69.google.com with SMTP id w12so1577729eda.6
        for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2019 08:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xceFySE/YPdpcHCuBlnpxqyBfL1iE5XunI8gt5xpca8=;
        b=TOrB5fZdVLymEKu+o2aElzeqAmndzrqktVdoJn+qUZ6h34Z72Fk7/SdhMdKuuu5dq2
         /jwn4xvVrmznbyM2fpPkQ9dB1TQIgriWlzT85oI6y7P+uR3UOIrKgBUGaiuCyb2/29j+
         Aw08kopGbM79t1E76AuTqD6f4imubwOcb495Trp+afYkP8JRIf2Lq+ljCTCLMvXuwdUl
         U0d7RttPx0Ad7mQuZTuINOsKDSu9E2Qu2MOwwFEK70v1G20Q0ARF0o6AZynTA3I4pBOA
         VBCL6Ez5clMwvbJUVO6OYDLELpQZsOuruChOWP5/H8zs1w/cuCsgrBI2CNuEEtpXp/be
         +qZA==
X-Gm-Message-State: APjAAAWZFEXqi+xpInU4mgrhgLnhTLtZDi2p51qAeQxK0sElcIIrZT9B
        Jt8kR8MY2VtdVi8dcqxbTwN/eSGrqqbZzC5j4aIUiITZa2jQyxioaUHyOTheFN/vsmAN1tC2Et8
        dESNmGWU/iDFrcMXtYUH20kHVw5g=
X-Received: by 2002:a50:eac4:: with SMTP id u4mr4381669edp.36.1569511154105;
        Thu, 26 Sep 2019 08:19:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyU2Sag81yJnJkanjkZUGsEowc1RpCAJLbQZgynp1b539aWCs4Um6kmNOh7efnwN7pIfRKQNg==
X-Received: by 2002:a50:eac4:: with SMTP id u4mr4381651edp.36.1569511153931;
        Thu, 26 Sep 2019 08:19:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id a36sm538730edc.58.2019.09.26.08.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 08:19:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8136218063D; Thu, 26 Sep 2019 17:19:12 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <b0239b81-e3db-1f10-22cb-ad06536b97a8@nbd.name>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <08f0ed6e-b746-9689-6dc8-7c0ea705666d@nbd.name> <87wodv19jl.fsf@toke.dk> <b0239b81-e3db-1f10-22cb-ad06536b97a8@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 26 Sep 2019 17:19:12 +0200
Message-ID: <87tv8z13wv.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: yGePz0zEMOqIGp_h2nm_Gw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2019-09-26 15:17, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Oh, right. Didn't know that could happen (I assumed those would be
>> flushed out or something). But if we're going to go with Kan's
>> suggestion of having per-station accounting as well as a global
>> accounting for the device, we could just subtract the station's
>> outstanding balance from the device total when it goes into powersave
>> mode, and add it back once it wakes up again. At least I think that
>> would work, no?
>Yes, I think that would work.

Great! Will incorporate that, then.

-Toke

