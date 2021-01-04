Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9686F2E964D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 14:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhADNs5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 08:48:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbhADNs4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 08:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609768050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=alsvQ5AkRVWdbT884MhE4BQi2ioKtED9xn0hUg9kkGo=;
        b=Uw/rugs9CIyXsTyWuDWRHriCTp1u+7yOV048qqBdIMtEfEw1irRuA1YKpktUYPX1e0cC4D
        QyAnSYXoConCrUS+lcQHl8gDlEY6znYeeU11weIQZS4i9ji8Evz35n5rZynl8PWUgOVT3S
        CujZtwaQvtJD7Hfj9Af9402iHyrJEjQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-R8IwlwAvNtW-LeFktj4wgQ-1; Mon, 04 Jan 2021 08:47:28 -0500
X-MC-Unique: R8IwlwAvNtW-LeFktj4wgQ-1
Received: by mail-wm1-f70.google.com with SMTP id g198so4976453wme.7
        for <linux-wireless@vger.kernel.org>; Mon, 04 Jan 2021 05:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=alsvQ5AkRVWdbT884MhE4BQi2ioKtED9xn0hUg9kkGo=;
        b=ZsP7qVI5sJ7FGXqiF+oyb4K7ac9w3nXQj6J3nVG0NAAMqAn1W37gM1bHyyM2c3pIeF
         F5eEIHiR4hxRfs+yKiH/uJik8BmVkrIfhmLj4XOKgR4lQ2X7KWOZx8NERymO8GmeROO7
         cpRtvfTE+WnSu6430nPXZncwxl8zCuD7ZA/C5H7qfe25/0hCK9ry+DYy0BLfrISdrjb+
         izqFOTqYnry9tibamAufrZ8vi3mrfDSX7QC2jgiceLm8elvGzl0z9+OgvMpMhoTj28zO
         /D3IEQhsmg4uST3YgwbdXuRxfxeLk2aMGkizpmCmJGv4M6+QfnEBj9KnFzkLCdXFx6Jx
         AYyg==
X-Gm-Message-State: AOAM530JH6KNbrpNbZ9fqUXVQ0fjM3todnBCJi6fxFYB1lGh2Tvw5zqF
        IdzNCYf9HhtRu/Vj6HiRO4/FZS1F7TJm+Fs8lMkYUImzeB51gZeHZIseRVAAnNYazvzemT7U0+k
        5lNtvPMGIVxRpuOJoqcMDA0Nio00=
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr26677713wmi.128.1609768047457;
        Mon, 04 Jan 2021 05:47:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyq48eiOA07sLh3wYvzxkIwMA0zAnW+SBdtS8uW7uahA78xoqiVVUFWAn9hXh3C9Ntp+IDSCg==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr26677700wmi.128.1609768047248;
        Mon, 04 Jan 2021 05:47:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h29sm102127020wrc.68.2021.01.04.05.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 05:47:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 50BA0180065; Mon,  4 Jan 2021 14:47:26 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>, kyan@google.com,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH mac80211-next] mac80211: introduce aql_enable node in
 debugfs
In-Reply-To: <CAJ0CqmVq2+poxg_V6pMCh2CFuqt3dwUW3x6eF=J0ek_uX5k6yQ@mail.gmail.com>
References: <0ad278def3875fc2c60b4898daa3f0d53288c168.1608975795.git.lorenzo@kernel.org>
 <87y2h8525a.fsf@toke.dk>
 <CAJ0CqmVq2+poxg_V6pMCh2CFuqt3dwUW3x6eF=J0ek_uX5k6yQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 04 Jan 2021 14:47:26 +0100
Message-ID: <87pn2k4xw1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>>
>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>
>> > Introduce aql_enable node in debugfs in order to enable/disable aql.
>> > This is useful for debugging purpose.
>>
>> Don't mind having a switch, although I wonder if it would be better to
>> overload the existing debugfs file (e.g., a threshold of 0 could disable
>> everything?) so as not to clutter up debugfs too much?
>>
>> -Toke
>>
>
> You mean to consider 0 as a special value to disable aql, right? I
> would prefer to have a dedicated switch for it since I guess it is
> clearer for users (but I can live with it :) )

Yeah, maybe a bit clearer but at the cost of clutter. I dunno, not a
strong preference either way; I guess Johannes can make the call :)

-Toke

