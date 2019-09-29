Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654C4C1902
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2019 20:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfI2Sme (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Sep 2019 14:42:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58514 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728755AbfI2Sme (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Sep 2019 14:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569782550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2E2ADouX7tBrXQ2QYSqBbU5xaMdk1UTKQKzocuIs0k=;
        b=YHzkpJuyWKEI0SOnzyUqgNI+aWs/tbkSAKgy6ZHXOmEbEsgXe6JC3xK3AdBfK9UtB4opVJ
        2bncx/EW38+ooldfwmEdcTvnEmiq3uA/3hEvGBK4Gu+fMn8RcwRzTz17cl1kKRUA3WSfG1
        tl7+YaXQmO+Bv2b3wCNfgMC3Ahsl2xw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-WQwW9ENePjeQFbiyuEj0Rg-1; Sun, 29 Sep 2019 14:42:29 -0400
Received: by mail-lj1-f198.google.com with SMTP id p14so2278110ljh.22
        for <linux-wireless@vger.kernel.org>; Sun, 29 Sep 2019 11:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=keD5mw/bNhy0hQKG9pGlW4ZQ+qajGxzrnXF4W+CFyW8=;
        b=COeL0NiAz8vUKancx9YfmnWZG9/sbvRcc90m6jL1T37iHM7xJxeeTCaBVlAS0DvWOX
         Kn5t+clYwrq8HIxRJkFOE3d2vSav0gxhKWm/IM+Uvmf2flQ13iQt5Sa8wTkG1Q/P0/7E
         /zGpbjYK0U0sgtv1AZoNZJn3oUxp5nfbJ+BjCCq/AMlYi6j2mwrd1DLAlLm2kK2GiWwp
         cuZrlReQy6cP5VfMl4/B4AaOCmHZXn8PKiqTL4N1yjZ4s+fdiLl1FoBTNoa1fq8yZJx6
         pkdsz244p2eZ/MJu5Zj0IXH9AGuBzVglIgpXzEDTdgfWdHCQkg3niD73DAPHEWEaUTcX
         yUWQ==
X-Gm-Message-State: APjAAAVDRApORGTaLUDIEnY4la5hEYh4AmwOFSAE0GJt+uyeyafzaWwr
        oBuWdIE5Ljvw1pEMOjGZjbQEQ7+o7nuJWOs1MVEBNzbQlJzUoKQNntRW3VQ/YVjvera/51Hsu9U
        LaEf8CxAyWP+ETbPDZUmIy/MI8sU=
X-Received: by 2002:a2e:96d8:: with SMTP id d24mr9946298ljj.138.1569782547353;
        Sun, 29 Sep 2019 11:42:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+ZT/UfWrFq5jlBZWct8pq0P5sEr1a3N8MjkrgbNfX6iju09i+oFcMAVtVAx+BvcaqgXBYtg==
X-Received: by 2002:a2e:96d8:: with SMTP id d24mr9946291ljj.138.1569782547197;
        Sun, 29 Sep 2019 11:42:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id r6sm2401807lfn.29.2019.09.29.11.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:42:26 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9167518063D; Sun, 29 Sep 2019 20:42:24 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 2/2] mac80211: minstrel_ht: replace rate stats ewma with a better moving average
In-Reply-To: <20190929154646.90901-2-nbd@nbd.name>
References: <20190929154646.90901-1-nbd@nbd.name> <20190929154646.90901-2-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 29 Sep 2019 20:42:24 +0200
Message-ID: <87zhinx7u7.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: WQwW9ENePjeQFbiyuEj0Rg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Rate success probability usually fluctuates a lot under normal conditions=
.
> With a simple EWMA, noise and fluctuation can be reduced by increasing th=
e
> window length, but that comes at the cost of introducing lag on sudden
> changes.
>
> This change replaces the EWMA implementation with a moving average that's
> designed to significantly reduce lag while keeping a bigger window size
> by being better at filtering out noise.
>
> It is only slightly more expensive than the simple EWMA and still avoids
> divisions in its calculation.
>
> The algorithm is adapted from an implementation intended for a completely
> different field (stock market trading), where the tradeoff of lag vs
> noise filtering is equally important. It is based on the "smoothing filte=
r"
> from http://www.stockspotter.com/files/PredictiveIndicators.pdf.
>
> I have adapted it to fixed-point math with some constants so that it uses
> only addition, bit shifts and multiplication
>
> To better make use of the filtering and bigger window size, the update
> interval time is cut in half.
>
> For testing, the algorithm can be reverted to the older one via
> debugfs

This looks interesting! Do you have any performance numbers from your
own testing to share? :)

-Toke

