Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA8402F1E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 21:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346052AbhIGTtU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 15:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhIGTtT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 15:49:19 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356CFC061575
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 12:48:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x10-20020a056830408a00b004f26cead745so492965ott.10
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=w+pEkVJd/h+WI+7Ik9xWqY+Z8oL6sb51sITpdGLwuE0=;
        b=ZfXkyFLoNLwSCxIt2lcXw2d4jOGw2BhBPBTFYcXhipfSjLsFGRUgNK6ftpTAP5TXWq
         ruwHEv5trPt3h2I/CyAqcbyOo83YrThS3Kjacjot2cOxAKpRgjgr1lQizsZ7yTchvihV
         ErsPeqGVBrbrrKzNFlwtX95iDjPuVYP5wRuiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=w+pEkVJd/h+WI+7Ik9xWqY+Z8oL6sb51sITpdGLwuE0=;
        b=biunq9gVN7kQbKm63YNQq7JUSpECbNlx6BBJ6PTC0Pr1FTsauBd2INc82CK1qgJaaS
         Xqd1q9gwaZrqFdylLqutwojylBu6FowMZWv5kW7u+AYSrxNYdgGFc3QhIrrj/75BMT8H
         qjojJq6Cx3SGEx+6pIEyKwtdqtyrwDntLS1sIhy6CLW96hIEiOrDfALQH8UUT5TS9y2H
         iEivrRLp+zkVFdjNyvIKqBvyGMhbTudmFgh/EHTXqVnZJIssx2/jeAdkS0VXyIqtFeMd
         zNH0VzytTtRUo0A0VTOb64REbgfZlWXCSlvGCMO77KJCrZIKmtYsl4ge6jYqBIuswsjI
         pTbw==
X-Gm-Message-State: AOAM531mDtgNQr0EriSa9xRD/obpgtub+q8dZptEv9DRsRnuQ8kYsTiN
        MrjLDJkT+57j+l0L2oGzdHhkCRVBYgPd6xwnKI369w==
X-Google-Smtp-Source: ABdhPJxksUjTUTa8Exx6uQm/t3KaU/loUjkBf+4L6i+ATrGe4465p6dpfz+D435OVm1pzqfNM6HNZXNRx4Iq1MprmqA=
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr58677otp.159.1631044092581;
 Tue, 07 Sep 2021 12:48:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Sep 2021 19:48:11 +0000
MIME-Version: 1.0
In-Reply-To: <YTe+a0Gu7O6MEy2d@google.com>
References: <20210905210400.1157870-1-swboyd@chromium.org> <YTe+a0Gu7O6MEy2d@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 7 Sep 2021 19:48:11 +0000
Message-ID: <CAE-0n52d_GBh70pSDXTrVkD5S6akP4O9YcE4tVRKZcvLtLZSmg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Don't always treat modem stop events as crashes
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        Youghandhar Chintala <youghand@codeaurora.org>,
        Abhishek Kumar <kuabhs@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Quoting Matthias Kaehlcke (2021-09-07 12:32:59)
> On Sun, Sep 05, 2021 at 02:04:00PM -0700, Stephen Boyd wrote:
> > @@ -1740,10 +1805,19 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
> >               goto err_fw_deinit;
> >       }
> >
> > +     ret = ath10k_modem_init(ar);
> > +     if (ret) {
> > +             ath10k_err(ar, "failed to initialize modem notifier: %d\n", ret);
>
> nit: ath10k_modem_init() encapsulates/hides the setup of the notifier,
> the error message should be inside the function, as for _deinit()

Sure. I can fix it. I was also wondering if I should drop the debug
prints for the cases that don't matter in the switch statement but I'll
just leave that alone unless someone complains about it.
