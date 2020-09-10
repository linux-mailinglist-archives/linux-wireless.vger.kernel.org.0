Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B730726436C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgIJKNa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 06:13:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37624 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730556AbgIJKNY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 06:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599732802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+GdI4nxZ45re4YvFQZdBwKgPlubeZww9U/bSQOsUDPc=;
        b=cvP50EMRS4wAUyjx2QzaRFCNdIv22jmtAG/faQR2hIKrYj+d92OornbKy0KtKFB1VJuxha
        DB9J3DIAE/wl5wUi7vLWg8GJt2GRHZU3YvWYTrbtVoMDyoaillpitTkLsrP07W7tEoNMyK
        ACpDdkrALRAdKjbEpohIl1/aUrH7XmE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-d9Ea8ZTXOyK-lLcXhNuqKQ-1; Thu, 10 Sep 2020 06:13:20 -0400
X-MC-Unique: d9Ea8ZTXOyK-lLcXhNuqKQ-1
Received: by mail-wr1-f72.google.com with SMTP id i10so2075357wrq.5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 03:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+GdI4nxZ45re4YvFQZdBwKgPlubeZww9U/bSQOsUDPc=;
        b=XijFsu6sOG3pq8Cfyt9Ug+BHwJB384owhfUPOS97GwHRPhecis6gYP9OJeY6QX7swt
         GCSjmXYUfhD1719yHqIK1j53eUkNdcWNvlP1FkZAUVRe82hF27sJ2SD2ghR235+6O6xS
         NbEB/QNyVnK9kcrxtMrZluz7UKJ2Qb6Agx8yEBZ2BQDnRiUtymeyJGlnKHf/mMYerqTR
         RcwZLrljk1KDSwTv6UedpHAV9LeASTg34TNcDPwgyg+eF5988Vn65bzyDYiPJ6iTl5TF
         geeAUkvc+c+r7xkW3zvGMxb4fC4AJEkcQLgqhMkw8ZRsGktjvkLbiLDRtxPZZ+IdiTuq
         Ja/Q==
X-Gm-Message-State: AOAM532ruwhGXPEeQSYRr7C5QYaAfOVRGbVlelzIe0LJv9dO5kX/FFlZ
        em2zWm7aijMWin486X6CMvU8AWANYbP9N+Gyo65Q4xJ8ZpDKz18fWzMcbQpur/+UBgs2PAH2zX9
        2G2PaAqTbpZLTlFuT6ZhnkYOy2Y4=
X-Received: by 2002:a05:600c:2f8f:: with SMTP id t15mr8084703wmn.41.1599732799085;
        Thu, 10 Sep 2020 03:13:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybDuYmosp/8ZNSfvTE4PNzn9wVQmQrgKQXz6mcRfhXRX0d61nhHMDKryhW922y7nQJQUhwIA==
X-Received: by 2002:a05:600c:2f8f:: with SMTP id t15mr8084665wmn.41.1599732798651;
        Thu, 10 Sep 2020 03:13:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e18sm8372557wrx.50.2020.09.10.03.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:13:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7EC941829D4; Thu, 10 Sep 2020 12:13:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 5.9 1/2] mac80211: extend AQL aggregation estimation to
 HE and fix unit mismatch
In-Reply-To: <20200909115602.21783-1-nbd@nbd.name>
References: <20200909115602.21783-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 10 Sep 2020 12:13:17 +0200
Message-ID: <87ft7qaqiq.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> The unit of the return value of ieee80211_get_rate_duration is nanoseconds, not
> milliseconds.

s/milli/micro/ here, no?

> Adjust the duration checks to account for that.
> For higher data rates, allow larger estimated aggregation sizes, and add some
> values for HE as well, which can use much larger aggregates.
> Since small packets with high data rates can now lead to duration values too
> small for info->tx_time_est, return a minimum of 4us.

Fixes: tag?

-Toke

