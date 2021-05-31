Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02B7396516
	for <lists+linux-wireless@lfdr.de>; Mon, 31 May 2021 18:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhEaQWv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 12:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232032AbhEaQUj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 12:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622477938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YLnEZKcyplB9xsryKJCg8SzrgCnIXv7qAarCswMipR8=;
        b=eTKlzfwfQ6RvwRroXkaiuMP4s1+h7O95Tm7eioa0Tat9yPcTBo/Ctn9MhWEa97uaFy309N
        CaEA1jD3lN257O/KMyxeGU4AlvaYNin+YmUiRRdewN64zPHJwfci10VBmSKGDEtpb13QcL
        XjFe9DU4eJtWuI1bIp7m54JjSRWy17Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-kplG6xfXO6qwUJQCXNBbYw-1; Mon, 31 May 2021 12:18:57 -0400
X-MC-Unique: kplG6xfXO6qwUJQCXNBbYw-1
Received: by mail-ed1-f72.google.com with SMTP id da10-20020a056402176ab029038f0fea1f51so6405384edb.13
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 09:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YLnEZKcyplB9xsryKJCg8SzrgCnIXv7qAarCswMipR8=;
        b=ng++wc8toD47gggZYyee2ffCG5QW+o/lAGN/pusbRtqXET4vqpsmxS0Cc9WfX1A+d0
         N1uG7eJfNBq9V3i+rcTdtXnYtiDZzGRE6S0ZwzCNd7ggAOl3IoF4RiJDH08SQ+YtfZ+R
         tuKM6heMH6NeeCzKLFRYEd0mzFjLGNR23flJYbDsxiKRg72Q6NawX7agyAk4OTFs4AF+
         MIeCAySBfdp5MRDKaBbnL1f8M3NiUN0WyPW7ZcqS20d09d4Ct6ifpuGVtsIO5xTlf6Ru
         B80mEyz19+0XrvfaQPFceUqqiaB37Jvs72QWCz1thy8L4NDmcaKtySdlMOtOqfkOtIFv
         FIGg==
X-Gm-Message-State: AOAM530p7DJGqN1BJM7WxUOFl/Snb+EWgR18PS0ULqTEbbErYHjyVnQH
        qEKlUk9vL42fenhjmqccJGlrSn1Q1Vm4v4Qi/KI406ILeRGHlEKKWFKxBMqsSqqo4cowir3q2Xm
        KNfqYwODa6vQeiOCzXPi3lM4Yi2Q=
X-Received: by 2002:a17:906:3181:: with SMTP id 1mr24227590ejy.36.1622477935851;
        Mon, 31 May 2021 09:18:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl/RjX3G4Deo/dgx73jB8JHOfaipgrZtE5yNPO3Z+6UroDJijCkZ7aqtNq+5xehBQZfN0T5Q==
X-Received: by 2002:a17:906:3181:: with SMTP id 1mr24227576ejy.36.1622477935694;
        Mon, 31 May 2021 09:18:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x13sm3922085ejj.21.2021.05.31.09.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:18:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4867D180724; Mon, 31 May 2021 18:18:54 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Bhavesh Kamani <bhavesh.kamani.wireless@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: Ath9k : Frag attacks
In-Reply-To: <CACrnO3sRZYYYZthyErNQyhOwpMcuFo5qb_XyBJeu6K6f-R_k2Q@mail.gmail.com>
References: <CACrnO3trnUTj+vsi3BGtR_HqR98ppod8thY76XFLzdc5SaXJ8Q@mail.gmail.com>
 <CACrnO3sRZYYYZthyErNQyhOwpMcuFo5qb_XyBJeu6K6f-R_k2Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 31 May 2021 18:18:54 +0200
Message-ID: <87o8cqdggh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bhavesh Kamani <bhavesh.kamani.wireless@gmail.com> writes:

> Hi Team,
>
> Any thoughts/opinion on this?

My guess would be that the fixes to mac80211 would cover ath9k, but I
haven't looked at it in enough detail to say for sure...

-Toke

