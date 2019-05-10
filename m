Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965F9199C5
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfEJIhE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 04:37:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44836 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfEJIhE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 04:37:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id f24so1261314qtk.11
        for <linux-wireless@vger.kernel.org>; Fri, 10 May 2019 01:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6q0OaTNhxy4z4NJtiUVwPY8QmQQzdj/ZZVApy0GJMI4=;
        b=iELlAWp8uu1w9QKiqsaCDDQUQZVz8W7Axyi1mnxbi0BiAfs+E4txY0WxHylQWI7/Ie
         kEl6z5C/Emaw0fQRI6D7NkEJhoFhEmattbkSrZj6CnA4samxPOlYRqcjwt0uyWUpXOwt
         MSCK8uPjMuzMjgx7xg4cIRI4vmsDnrucQVGgHCeFPGyUkUxqw6aAeChk/AFFHS7mw7F6
         sMMJz+grUiuBh91XLPH5oEAuTVGufIx5c7IRSYlZnveFOb3HVEKgbP8rPku1Ktqebwmb
         zU7I/kHcwWHm8kcSyzf8eHN2KGexnO6N3bBc3Xy9+xssu+OtLg6gop+0xBAWBoQ4Bd5m
         BsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6q0OaTNhxy4z4NJtiUVwPY8QmQQzdj/ZZVApy0GJMI4=;
        b=R+/B2SBP46uxRD42qoFUPVeQMRQE1D2OB50kvcogtPyMMBidVFt9Elw4ZopZs4FLYG
         WdsOHddYUBhMfzjEwgTEBmdQ1YiVatffSAaRiDw1oJKQSKrD3J5NjZRimNgOce9Jmf4a
         mvnEGroXUIdMJLeGoeuDY3t9NYvg3X+JfvQ6vUV1hFgHry9Tht53Xq8H/kIqeImqFgzR
         IshiJlXre9HMEpttcY+bj0IpVyclDR/lpYMRt6w+vw5UxIuIW9FVpim9UoeXckd5SJvy
         FagqJPj56tnlOEJDu41NuE02tzZr5ibe1oTopP9z+Fv/shOpL+qgXBCa5cBPAtML3nNx
         cNGg==
X-Gm-Message-State: APjAAAVauE2VWhSNifCQqBuf8ASn3Zu8uJeq0iWf1TsiGKcuv5x5SO6h
        j6CHYIn7jyWZn0EIvrlKB7Zq8bADRUlWWUZkGXAbkLo9+Ac4Kg==
X-Google-Smtp-Source: APXvYqw4qHdkcVnmbbairiiIOuet0C5L8KHTlEuaG0iO/gCejSKaySvSBAsfB9wxI2MBrau5nbVgefJaBuBg8UnoKPA=
X-Received: by 2002:a0c:8a93:: with SMTP id 19mr820888qvv.7.1557477423165;
 Fri, 10 May 2019 01:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190503072146.49999-1-chiu@endlessm.com> <20190503072146.49999-3-chiu@endlessm.com>
 <CAD8Lp47_-6d2wCAs5QbuR6Mw2w91TyJ9W3kFiJHH4F_6dXqnHg@mail.gmail.com>
 <CAB4CAweQXz=wQGA5t7BwWYdwbRrHCji+BWc0G52SUcZFGc8Pnw@mail.gmail.com> <CAD8Lp46hcx0ZHFMUdXdR6unbeMQJsfyuEQ7hUFpHY2jU9R7Gcw@mail.gmail.com>
In-Reply-To: <CAD8Lp46hcx0ZHFMUdXdR6unbeMQJsfyuEQ7hUFpHY2jU9R7Gcw@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 10 May 2019 16:36:51 +0800
Message-ID: <CAB4CAwf26pdCY7FJA5H7d1aEY2xpjSto4JxARwczmVJ==41yng@mail.gmail.com>
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

On Thu, May 9, 2019 at 7:24 PM Daniel Drake <drake@endlessm.com> wrote:
>
> On Thu, May 9, 2019 at 5:17 PM Chris Chiu <chiu@endlessm.com> wrote:
> > I need the vif because there's seems no easy way to get RSSI. Please
> > suggest if there's any better idea for this. I believe multiple vifs is for AP
> > mode (with more than 1 virtual AP/SSIDs) and the Station+AP coexist
> > mode. But the rtl8xxxu driver basically supports only Station mode.
>
> Yes, the driver only lets you create station interfaces, but it lets
> you create several of them.
> I'm not sure if that is intentional (and meaningful), or if its a bug.
> Maybe you can experiment with multiple station interfaces and see if
> it works in a meaningful way?
>
> Daniel

I've verified that multiple virtual interface can not work simultaneously in
STA mode. I assigned different mac address for different vifs, I can only
bring only one interface up. If I want to bring the second vif up, it always
complains "SIOCSIFFLAGS: Device or resource busy". But I'm sure that
STA vif can coexist with monitor mode vif. So I may need to add the code
login to make the watchdog only work with the vif in STA mode. Then I
can also store vif in the rtl8xxxu_priv structure if we presume it only works
for station mode. Anyone can suggest whether if this assumption is correct
or not?

Chris
