Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128027930C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbfG2SaO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 14:30:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39915 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387573AbfG2SaO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 14:30:14 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hsAPU-00035X-7v
        for linux-wireless@vger.kernel.org; Mon, 29 Jul 2019 18:30:12 +0000
Received: by mail-io1-f71.google.com with SMTP id z19so68507119ioi.15
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2019 11:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IjjQyJKiTolFtpi7W316O0yFOFziBtrDSeHnM1CYpSc=;
        b=qmyC/tmk1CEzolFoJrdCH8Ae1fLNNRE1ctD+Su3e7Gi+CZQF6lNCRfxEiSc1wqb6Ye
         WOxQ8/dV8TytKq3T+m4vCwuiSzi18TCbVyS8eES0ype3TBJNoY7QQI6bCKAYaobw8pI5
         lH1WTody5jT/jgCwUxFQPoAbGW2eXVvm3qRMOt5XQ6/2jNtQt/+oAnGFPpz860nctUv/
         /ZsuLcHxX1qm8ERclZ573dGSn2K0E+uYXbR3EojLx6zOo8fmdAc8N2WyrEs2/AYCxdC0
         hhpl2xh/zafPVrxlWDKVPzupa2eu99frn3MPPqyrUsJCO4/jaXHcQBNOxdHITvO4oudQ
         lQDw==
X-Gm-Message-State: APjAAAWDPYhHSSSGcsb8HmVZnUK6/7tl74UCfluAWGVUgGQ015kcuAPv
        lvrGNtg4rdPNPJOspg4eAzGFqG1a66MpkHkyi0noNU/ZPTMD7UWS8CduiW51Z2H2H2kBK4JRtH+
        qu7zsMAdw3YJqaXvRggNKRdsEcU7UCKJTXO98Ti0lXO/u
X-Received: by 2002:a5e:cb06:: with SMTP id p6mr34472175iom.79.1564425011070;
        Mon, 29 Jul 2019 11:30:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzFyuwzS6N7xNKc8+WNZZcut0VXlV7ZkMhhC+mxGtzN3GGyX6UAZVq4dQWHy3s3RMgaSAwmJA==
X-Received: by 2002:a5e:cb06:: with SMTP id p6mr34472152iom.79.1564425010765;
        Mon, 29 Jul 2019 11:30:10 -0700 (PDT)
Received: from localhost ([162.223.5.78])
        by smtp.gmail.com with ESMTPSA id f20sm48805254ioh.17.2019.07.29.11.30.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 11:30:10 -0700 (PDT)
Date:   Mon, 29 Jul 2019 14:30:09 -0400
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Dmitry Tunin <hanipouspilot@gmail.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: wireless-regdb: Update regulatory rules for Russia (RU) on 5GHz
Message-ID: <20190729183009.GD21772@ubuntu-xps13>
References: <CANoib0Hn9uNnk5vpjEJUiGriD5rHuDc7xxLFj3r8ij6ALSxcag@mail.gmail.com>
 <CANoib0Et3gLu2gGYeWracV4v7tgWj8qhtO7w_c8TSJ+CE-gjMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANoib0Et3gLu2gGYeWracV4v7tgWj8qhtO7w_c8TSJ+CE-gjMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 29, 2019 at 09:05:06PM +0300, Dmitry Tunin wrote:
> I made an error while editing. The correct section is
> 
> country RU:
> (2402 - 2482 @ 40), (20)
> (5170 - 5350 @ 160), (23), NO-OUTDOOR
> (5650 - 5850 @ 160), (23), NO-OUTDOOR
> # 60 GHz band channels 1-4, ref: Changes to NLA 124_Order №129_22042015.pdf
> (57000 - 66000 @ 2160), (40), NO-OUTDOOR

Thanks. I haven't had time to look over the document to verify your
proposed changes, but I would encourage you to go ahead and send a
patch. I will try to look this over soon.

Thanks,
Seth

> 
> вт, 23 июл. 2019 г. в 00:53, Dmitry Tunin <hanipouspilot@gmail.com>:
> >
> > The db entry looks like this now
> >
> > country RU: DFS-ETSI
> > (2402 - 2482 @ 40), (20)
> > (5170 - 5250 @ 80), (20), AUTO-BW
> > (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> > (5650 - 5730 @ 80), (30), DFS
> > (5735 - 5835 @ 80), (30)
> > # 60 GHz band channels 1-4, ref: Changes to NLA 124_Order №129_22042015.pdf
> > (57000 - 66000 @ 2160), (40)
> >
> >
> > This doesn't look correct. The regulation document is here
> > http://rfs-rf.ru/upload/medialibrary/c1a/prilozhenie-1-k-resheniyu-gkrch-_-16_36_03.pdf
> >
> > According to the regulation document issued Feb 29 2016, there
> > frequencies should look like this:
> >
> > country RU:
> > (2402 - 2482 @ 40), (20)
> > (5170 - 5330 @ 160), (23), NO-OUTDOOR
> > (5650 - 5835 @ 160), (23), NO-OUTDOOR
> > # 60 GHz band channels 1-4, ref: Changes to NLA 124_Order №129_22042015.pdf
> > (57000 - 66000 @ 2160), (40), NO-OUTDOOR
> >
> > Note that there was never a DFS requirement in Russia, but always was
> > NO-OUTDOOR on 5GHz.
> > Maximum power is 200mW that is ~23dBm on all 5GHz channels.
> > Also Russia has never been regulated by ETSI.
> >
> > If this looks good, I can send a patch if needed.
