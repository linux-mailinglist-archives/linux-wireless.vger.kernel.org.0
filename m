Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FBB2AED0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2019 08:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfE0Giw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 May 2019 02:38:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35739 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfE0Giv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 May 2019 02:38:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id l128so3477800qke.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 May 2019 23:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHxpS8GHNFczohBNmU/4hGO+nucs8Ap0lRCjYNwMm+U=;
        b=Z3+ujjmXN4PtI+z7DMZcCXWOgT9fcIZii2m6C0wngPB6ltt55kx7UFgpm7+ldQrDdb
         M9HmuXhYGolCOseNPBd7ucxDAawtYlZBROSShy6h8NougfZbYckdRpBmYVJikkNi923L
         Smw/6I1tZquqKSkMC+GlaX/KudPYUh5KQEz/iNSNqjqzZuSG90izIFke6A38g4dj7F0b
         0dZXj7k8AypGiyssOh4MtMsjYYcsKqdryGoMoqJMFP/l9wb9Bhy4yqM3LhnI/YHx29OA
         RIbQ3C7biSTc9TSPG2buxIE1BI0vC2Dz1yapS9vuzSJssE1e/f0hNVWOwMJ9Potc0teC
         fq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHxpS8GHNFczohBNmU/4hGO+nucs8Ap0lRCjYNwMm+U=;
        b=Y3+gF7iGe/RYXRBBnoxDo65ES3TcZwA7a9DZhB18QgASU8qbcUhfN21s5j+7DdX90E
         0npGvwBxquZQDIWmXUubO+xwIxFCfSUwz/L/MLfBA0Rrrr/Nv4CYgFyQXLKS7to+0Fnr
         PUqqi1qjQAZGsOKBf8Uy2/3H3GXRzu3Ys6kLpb0vJm5lIR5Y+nJ1No28qUNv8wdxV6jg
         nTbdddzMb0jIJqsNt3XJ8zGTB3c20+D5FqHKLwkZoosIPT6rCrPtDlQIIUIfvxCebBFd
         +g90zf1QZp4RFQrnojhlqXbKDCYCRvXu8/txLopqcxv1diFWDyRVog6vpXH3zfb7a8en
         a58A==
X-Gm-Message-State: APjAAAWQM+rFOjDwEFGV8lyLzBCKGvDDpr0xkzmX4I+UydnKG3TzB/74
        GLaZJJlaqrt/iNfwNZ9AKfSs+5FWmnh/pp6n4DGcldTX9jZuEA==
X-Google-Smtp-Source: APXvYqwXmCCSkefGNRFAEBLGtLWO8/FD3BjQ6UIoj//q1bJvMH9lNtKnGCPeUFP7BXWy7Q9aAj3RnvVKFLZBU3RFjug=
X-Received: by 2002:a05:620a:1ee:: with SMTP id x14mr650094qkn.70.1558939130658;
 Sun, 26 May 2019 23:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190503072146.49999-1-chiu@endlessm.com> <20190503072146.49999-3-chiu@endlessm.com>
 <CAD8Lp47_-6d2wCAs5QbuR6Mw2w91TyJ9W3kFiJHH4F_6dXqnHg@mail.gmail.com>
 <CAB4CAweQXz=wQGA5t7BwWYdwbRrHCji+BWc0G52SUcZFGc8Pnw@mail.gmail.com>
 <CAD8Lp46hcx0ZHFMUdXdR6unbeMQJsfyuEQ7hUFpHY2jU9R7Gcw@mail.gmail.com>
 <CAB4CAwf26pdCY7FJA5H7d1aEY2xpjSto4JxARwczmVJ==41yng@mail.gmail.com> <CAD8Lp47K0Jn2wotANdQV3kT9yPP7bLnVd0eYhWui-vNDOEXBTA@mail.gmail.com>
In-Reply-To: <CAD8Lp47K0Jn2wotANdQV3kT9yPP7bLnVd0eYhWui-vNDOEXBTA@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 27 May 2019 14:38:38 +0800
Message-ID: <CAB4CAwf7O9tyUwc+gPSZrBES+Bt7iTjhE1fbbVxYKqzjtmZBxw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] rtl8xxxu: Add watchdog to update rate mask by
 signal strength
To:     Daniel Drake <drake@endlessm.com>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 22, 2019 at 2:38 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Fri, May 10, 2019 at 2:37 AM Chris Chiu <chiu@endlessm.com> wrote:
> > I've verified that multiple virtual interface can not work simultaneously in
> > STA mode. I assigned different mac address for different vifs, I can only
> > bring only one interface up. If I want to bring the second vif up, it always
> > complains "SIOCSIFFLAGS: Device or resource busy".
>
> Interesting. Can you go deeper into that so that we can be more
> confident of this limitation?
>
> ieee80211_open() is the starting point.
> ieee80211_check_concurrent_iface() is one candidate to generate -EBUSY
> but from inspection, I don't think that's happening in this case,
> perhaps you can keep following through in order to figure out which
> part of the code is not allowing the 2nd STA interface to come up.
>
> Daniel

The -EBUSY is returned by the ieee80211_check_combinations() in the
ieee80211_check_concurrent_iface() function which is invoked each time
doing ieee80211_open().
The ieee80211_check_combinations() returns the -EBUSY because of
cfg80211_check_combinations() will iterate all interfaces of different types
then checks the combination is valid or not, which in this case the number
of interface combination accumulated by cfg80211_iter_sum_ifcombos is 0
when I'm trying to bring up the second station interface.

Chris
