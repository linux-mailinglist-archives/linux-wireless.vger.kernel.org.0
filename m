Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B1446B64
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 22:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfFNU5t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 16:57:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34023 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfFNU5o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 16:57:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so1482979plt.1
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 13:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Crq0nDZF9tOeX0bWwwm0JRIq5ybVrhhnr25YAZ6ufIk=;
        b=X0jCDx7F0SrYSQdEhdgb8qtSIoOnS+O7rIM5pCHI2fzNeLRWb108SwXatySqbdvLpu
         31wimHCq0BfcZCJIuWKv72X85SwLepwhMHxfqweuLbERfguUyRKocQW8zk+uteukHNJJ
         qYg7rZeaw8z2Nq9dskFhmlQWvR64rxNvdGmqqOIgm5WjjET3HzwOk4D7Px/2kN+IdBMH
         nT/IyyZbK7+X0ShOX+WB4iH4XGr+dZjq7477rgnyrCOYUAsjN8thUGBFtvJAA2P87JJA
         p5ntvIPO26V2ikr3/Qn3nEpT3oRhNTYmOL5QJvq17c5XUSfrQ28D81lxnUgl0FCa7AXm
         pgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Crq0nDZF9tOeX0bWwwm0JRIq5ybVrhhnr25YAZ6ufIk=;
        b=AgV+Y3QchuRzL2KXhB6Z4JWM19nkIVE+mOPe0WQrSB4RhsQGFBESESdocEcQDK7W4i
         fVDgncyfPwBGjLB10q2w/KKzeja18PBYSsdSdAYnGfE45pxk3WkwvwR/4ip34NUZRIBQ
         E9ToyniMYxZfm/TxlqWABN9qrs7n4GvbbmTlJ5n4KTuzeqHQt1519aksPYTtBdJkzLx9
         Z2sNgUZGb/nEC95UyHXae0zkmdUlFyQvirN1UEfg8rUvIv5OJ/Am/B263yC5n691Y4Bo
         cnPrhYhnam0GA4iXcXxh9uEhvaZ9yF1hNLAKcScYdUBimq2639iqQxahYLLcYk7k2Yws
         FqKw==
X-Gm-Message-State: APjAAAWhKU4Y2qGU/M170QYzZruOjatiMxgMJid6AEIGSWVVLOQB2xmI
        n774p6JC+Q/jGRxmCzZz3jTz/fgcYBrR//gDxuWHsw==
X-Google-Smtp-Source: APXvYqwc12Gjg3q9skOSADw86B+Ig7PVBJGMfmcIkBRi2fZRrjHVaP8V/as5dS2/3dv3WOPL1q50QL9DYJC3q6qfCg8=
X-Received: by 2002:a17:902:b696:: with SMTP id c22mr91154189pls.119.1560545862866;
 Fri, 14 Jun 2019 13:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190614171713.89262-1-nhuck@google.com> <CAKwvOd=jFYn=7NGPD8UDx3_g30qD+40bCjzmWJJSzmb6pNUusQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=jFYn=7NGPD8UDx3_g30qD+40bCjzmWJJSzmb6pNUusQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Jun 2019 13:57:31 -0700
Message-ID: <CAKwvOdnrvfthPcmnducqyOpbkFAQq+25eDXgehf_aWMAG=7CRg@mail.gmail.com>
Subject: Re: [PATCH] wl18xx: Fix Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>, eliad@wizery.com,
        arik@wizery.com
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 14, 2019 at 1:54 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Looking at drivers/net/wireless/ti/wl18xx/main.c, there 4 globally
> declared `struct ieee80211_iface_limit` but as your patch notes, only
> 2 are used.  The thing is, their uses are in a `struct
> ieee80211_iface_limit []`.

Sorry, that's not quite right; it's not a  `struct
ieee80211_iface_limit []` but a `struct ieee80211_iface_combination
[]`.  No idea what other values we'd put to add these limits to the
array.
-- 
Thanks,
~Nick Desaulniers
