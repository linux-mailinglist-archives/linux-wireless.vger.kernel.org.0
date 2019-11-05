Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBBDF01C6
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 16:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389936AbfKEPoi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 10:44:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50214 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389571AbfKEPoh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 10:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572968676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1/q7BiIB8b1cyuMhdVc5aAXyCctDZO9DybQWX2Tc5c=;
        b=KPIlV5gr7rMKfq+uKlSEAowjh1dMoR022RHOoeCO6iCal2G2jhnk9bV7j7hsP8r8ii0i1v
        Vhcu2v6mE8Qj+qnzqb/B+BzTOcxEzUgSuZQKcK4QV/mkeNsbKFwHw6t1FHCywphbFIWNG3
        s6i0p22BO3TTlgF4HvkhFP1xUagTifI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-isKg_gmOOAqYjF_nAN489A-1; Tue, 05 Nov 2019 10:44:32 -0500
Received: by mail-lf1-f69.google.com with SMTP id y188so3596328lfc.6
        for <linux-wireless@vger.kernel.org>; Tue, 05 Nov 2019 07:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=X1/q7BiIB8b1cyuMhdVc5aAXyCctDZO9DybQWX2Tc5c=;
        b=ogfEL22CZWLFvvqQ5AHuT0PuIEcaEgQJY+7g1cTSSt3FpwS8rfonvOqlcIKhkaGDdd
         vGWrb29oC4zWzu3Ot8JATesV/r9OonMGq9zWnYHNzcrSR3zZOEQnq4Rj3+TWIYoya2La
         h4gn3ZPHT+eDt0+qcAUy8rkt8CBI7LuH57kWVQoqkRZEknUrf8msyt1z9PXdu7OKYTu6
         7dZSxwYsDfcu51riqMS+1AXtuBECiP/1qUcJuDBKdjZBHrQybtqdUDzpFosFF5Kc2sXL
         KsPF9ZwxWj+FKvIijGE+ya5EBqg4ROAc9/+uY1xf0YvVVUXEvWwMJ7IJOAcv75UToGXH
         AAQA==
X-Gm-Message-State: APjAAAVFklZ0wNfFgzpKFKeyMKkoy3K1b+b2lt8jDL/FKV3ZYus1b/PK
        UKZ4lvrfGp6DCqhRjhGntvBYImaKh9Fagx4dFBf3hZyCpMIpI1sn6WuC90RZc0wA5HiqDQ8lawM
        X/s/AtrLXcvPJ1fbmeNeTAARAb24=
X-Received: by 2002:a2e:7d17:: with SMTP id y23mr5334977ljc.228.1572968670395;
        Tue, 05 Nov 2019 07:44:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3Uy5Ey6tOLvuS+ahx50BI/TjtAuWUQ21cULxdKmhVp/bsB6up1WBk0VtT/BWPvEIY36YVrQ==
X-Received: by 2002:a2e:7d17:: with SMTP id y23mr5334964ljc.228.1572968670204;
        Tue, 05 Nov 2019 07:44:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id a14sm8550604lff.44.2019.11.05.07.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 07:44:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D7F211818B5; Tue,  5 Nov 2019 16:44:28 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: fq_init() allocation
In-Reply-To: <d35e6687d4e5ae32647d8b3534be5084725bbee2.camel@sipsolutions.net>
References: <d35e6687d4e5ae32647d8b3534be5084725bbee2.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 05 Nov 2019 16:44:28 +0100
Message-ID: <878soujpk3.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: isKg_gmOOAqYjF_nAN489A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> Hi,
>
> fq_init() in mac80211 allocates something like 1/2 MB of memory in a
> kmalloc() call and I see it failing frequently in our automation now ...
> Could we move that to vmalloc()?

Sure, don't see why not. The qdisc allocators all use kvmalloc() for the
same purpose, so I guess we can just switch fq_init() to that as well.
I'll send a (one-character :)) patch...

-Toke

