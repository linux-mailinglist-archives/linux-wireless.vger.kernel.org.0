Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3C52D61A4
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 17:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbgLJQWH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 11:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbgLJQWG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 11:22:06 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90928C0613CF;
        Thu, 10 Dec 2020 08:21:26 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g18so4682547pgk.1;
        Thu, 10 Dec 2020 08:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yxk9HNh5qdQCgFQ8rZtWSxHI6tHLmq1Eu2GPGLWvZ5E=;
        b=cV8z8C4P/M6JHKbpfAkcV0wDHdahPPY8wHp8+9M0T+cX89praIif9OBdDcuWp7RWN2
         CzrKvuP56h2PyJv6SZlYUATExb7r7LEkgNZC9mAK7s+AktVOEVLsyZk5T/kp40TH/EN6
         iKDwV9HPkQPnSOp2N2o3rAjlDJaPW+rieBKj7TMzGoYbk4A5DCPM6zqvTurkc7ngMU5R
         3cJJiirmoJYJZLJCVbAkcgtgfhNIVgkJfErP39awC6IS9kYULnX0aR6B4KF6D9QvwcYx
         8uKfRuRC5QvhIbMC5MLGTZwdNK6oUpGv+7daQW9BIad5D5hqi6oK5WGPPn5DBj6m8Xj+
         ZJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yxk9HNh5qdQCgFQ8rZtWSxHI6tHLmq1Eu2GPGLWvZ5E=;
        b=I0WA/XCKzS34eE7/hSctaVIn2kC2ADJixlqKLOsWqBHMwNa5jfsnBt8yyBJv3uZ/ti
         Ivvv8afltdKM6oEkA5B6SSRGx86Q9Ir5z2XUqeLClX58xj7IQZs+83k80ywnwVyevH3e
         fgin1pTy+Kz+o8vhrqHikTFAle3PVMO08TAtXSJ6E0GO/HoyQnzb6c2AtoJUCgeHsccf
         7T9BmFJJNys20UaFgRIeqfXAWFX9fwo4T9UkjyEV2/ILqwg+YulRM7tgDxr9zrbhFEFD
         w2akGIlb7PjqNT7UILBfHHjma2YjK35h7PiqtPxj5pMEmIxky63hNCfpJSaH/k4GRHaF
         062Q==
X-Gm-Message-State: AOAM531JSTnSeTwKwT8yZcs8+uuGar/6SK5GTZ6uq6WCXnG6Wg8aCkHb
        0bqxjIEOg3ESGjHj9FdYOGs7DiPOrcuq96pMtw==
X-Google-Smtp-Source: ABdhPJxM30sLbsxiVwit0Q3WhUIn4k7KJrgXTbroXpsQ8hoC6mnwQ/TFp1F919TI146UgOVGzkfEQGqO1NwKkzeQ/cs=
X-Received: by 2002:a17:90a:bf88:: with SMTP id d8mr8570693pjs.124.1607617286155;
 Thu, 10 Dec 2020 08:21:26 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
 <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
 <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com>
 <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <CANUX_P1=yuPkK5BzJ99oniMiCgB0z98yNYUSw4_qk2Vg7ucoRQ@mail.gmail.com>
 <CALjTZvYZEbgfLEzxQdafJT6CFz76prA4+YM2EGA8k5Dgn3gigw@mail.gmail.com>
 <CANUX_P1YWSudJfwyuFVg-qdBHwQvQJiZayZBMY8E4it0qwB5Hw@mail.gmail.com>
 <CANUX_P0sOAdRjOgg=ogAHmQdTXp5UKyW2XQQRComa4Rv3Y-toQ@mail.gmail.com> <CALjTZvYfJVjxRO4Avc3rV+W+HO-vBABxwF=UUETzDeNv_QBbhg@mail.gmail.com>
In-Reply-To: <CALjTZvYfJVjxRO4Avc3rV+W+HO-vBABxwF=UUETzDeNv_QBbhg@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 10 Dec 2020 16:21:15 +0000
Message-ID: <CALjTZvZybsB3unK8X0WcA7kLF60=36F2senz6fEoJS6VVx6Hwg@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, again,

I haven't tested any patch or bisected, but I have another data point.
I built and tested Linux 5.8.18, with the same firmware, and it is
working correctly. I reduced the test case to just rfkilling the
connection, which showed the register dump immediately (before that I
was using the airplane toggle on the keyboard, which isn't working
correctly, it disables and immediately reenables the radio, for some
unfathomable reason).
So, now I'm inclined to believe this is some sort of race condition
between rfkill and pending transactions.

Thanks,
Rui
