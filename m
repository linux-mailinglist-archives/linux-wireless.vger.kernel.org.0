Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A70D1714D4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 11:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgB0KRQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 05:17:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60846 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728680AbgB0KRQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 05:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582798634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6cHViURCnyaA04HbDOwPN4x7F/IzyCt5NThZd0ymuHg=;
        b=IiFx8UaH//aG2x1uZ7wa2SgJaDoVIoG8vSuNAx+c4MzBOz7dfJEg+BdPtXe4/V2+9orSNv
        fSYIXEZqtFfARamKcTa702ZZdJRjOXOI6Y47h8zKfau4eLAGlGZmEz5/6ioe90dLrdR25L
        mH+Rp8Xymvp+EtVcR+pu6K603syChAc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-1ajPdoT0OpGVoVRvwiH0sA-1; Thu, 27 Feb 2020 05:17:08 -0500
X-MC-Unique: 1ajPdoT0OpGVoVRvwiH0sA-1
Received: by mail-wr1-f71.google.com with SMTP id 72so1107067wrc.6
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2020 02:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6cHViURCnyaA04HbDOwPN4x7F/IzyCt5NThZd0ymuHg=;
        b=U5jYM0EYIlU2hTwb7tgSxd4A4ZJBSOfjAx/MZeolVY/hZy4OPD8c3srjcehkTyq9F8
         Aa6riz2ghGL6iRCnf7xB6L+Sx3FpRwq6go1/VfkJAtjPzjSzM8NJJboUPQTUGZDErJn0
         GZsj18Lowm+M+P7/CsywPDRdJ5hWNJMka46VNGv1TsPF66INAzi9SlCIGg+NOIrtxhdS
         XxodRIvA2UCIOj/zp5PsF9Ci6h7X2hRtekK1mB+ygoLNwCjvK39VtqTemOA/E5zjs+ox
         bEe7jfCSYQ5ypFNs4m4rKMO5Uiy8eYzcSzoCAQ9++IaQTFvUZcEZtCoWHONxBaExpDAE
         MZtg==
X-Gm-Message-State: APjAAAUPdec0YymgtBXhugI3geYR+XhUG0cEk+I9gZVXNrmzwOU9BLs7
        ZFTNSSbAV4dpFTUGlaj8wDKpIYBZ7afHld5ezYC35iccq1hxnqnVqrUwmMbaVPzhhJ6uLgJCjSM
        HRv2B8tjoijE0xyw+sc5H3wwzGn8=
X-Received: by 2002:a1c:38c7:: with SMTP id f190mr4256837wma.94.1582798627390;
        Thu, 27 Feb 2020 02:17:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyr76tDTisRMWVLc1Qqj9VVSwpf7gt3eGTCEoI9WVe0SmI/2My10BjYcOOGXcrjYURxfYTVeg==
X-Received: by 2002:a1c:38c7:: with SMTP id f190mr4256808wma.94.1582798627098;
        Thu, 27 Feb 2020 02:17:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q3sm7043082wmj.38.2020.02.27.02.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 02:17:06 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E10FB180362; Thu, 27 Feb 2020 11:17:05 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Justin Capella <justincapella@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        make-wifi-fast@lists.bufferbloat.net, nbd@nbd.name,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>, lorenzo@kernel.org,
        rmanohar@codeaurora.org, kevinhayes@google.com,
        Kan Yan <kyan@google.com>
Subject: Re: [PATCH v11 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <CAMrEMU8FkUkoTB95K8cbBgcrUBPmE0cy6yUcROLTw1_BuSCKuQ@mail.gmail.com>
References: <20191119060610.76681-1-kyan@google.com> <20191119060610.76681-5-kyan@google.com> <CAMrEMU8FkUkoTB95K8cbBgcrUBPmE0cy6yUcROLTw1_BuSCKuQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 27 Feb 2020 11:17:05 +0100
Message-ID: <8736awxrku.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Justin Capella <justincapella@gmail.com> writes:

>> ieee80211_report_used_skb(). As an optimisation, we also subtract the
>> airtime on regular TX completion, zeroing out the value stored in the
>> packet afterwards, to avoid having to do an expensive lookup of the station
>> from the packet data on every packet.
>>
>> This patch does *not* include any mechanism to wake a throttled TXQ again,
>> on the assumption that this will happen anyway as a side effect of whatever
>> freed the skb (most commonly a TX completion).
>
> I recall a recent patch for ath10k sdio that disabled tx
> acknowledgement for performance gains and am wondering if that will be
> problematic? Presumably not since it would be caught at the dequeue,
> but thought I'd ask-- wondering what the effect of failed tx's or
> block acknowledgement is on this stuff I'll need to study the code
> some more
>
> https://lore.kernel.org/linux-wireless/0101016eb1903db0-ef7063b4-0f42-4a01-8886-327541e6c1a4-000000@us-west-2.amazonses.com/T/#t

It looks like that patch will just end up disabling AQL (because packets
will be immediately completed as far as mac80211 is concerned) and
replace it with whatever that credit-based scheme does? No idea how that
will impact latency; you should go ask the developers of that series! As
usual, the patch description only mentions throughput numbers :/

-Toke

