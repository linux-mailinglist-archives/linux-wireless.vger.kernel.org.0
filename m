Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1EC3DA7
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 19:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfJARBU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 13:01:20 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:42015 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729864AbfJARBT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 13:01:19 -0400
Received: by mail-lj1-f173.google.com with SMTP id y23so14134736lje.9
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uD/wtsOUtAiuwHPnfertm4Y+ipE9kgBw/61YeeXaS38=;
        b=ExcRSLE6pi2cVH+BCE+l+ey5SdeNFm75anjMHpkkVyDzAkaYS8t/PBjiroCagX3ZxK
         umv+7YXBBKSKgfcI9g7hhMnoQt303ckKx3KYrhxp6Y+ZANr5+KAISajS5fw7+un4hUXm
         hWeme7I8puo2DeozAmFdUzZZNWy1CyBOaDttZ716PXxecsCQx60/4hJP2w10bizt2PY2
         ODeSVp2uQDQ1wfT9jNeQJRVQ6LwH6KTbXzT94e2Hiyi08f9q+h0sKp97HpLvDGIR1Jb4
         ngiD8xOMuVQs9vMWUJ72DEBkegJGIEc6mMGevB+j6yuBoMO2PF5Hdum/Vu+ikkJlSbhJ
         gU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uD/wtsOUtAiuwHPnfertm4Y+ipE9kgBw/61YeeXaS38=;
        b=JiFU6niyx/wUrUcLmhocbcyZ6Pa+xdWGBAeN488k5WpfNsLGqwsuxH11q5iTOZnRmw
         CvF3Z+C/5vKFH29ST5a1jD6CmFzYU0zCMIZmTZaFyIgasQCa3p46ZKZtKqSmdD9GUi4S
         I33SD+fUmBpaycEEw2ZjGX9h/96JQslykGjl5G3UZqEloxWhOmBJiEtlNFP9FYOsrta1
         nunyS6umBg59jZShkFqxxtyxjGM31AP2mV9+71HYyhyqIOzrkt1dVYM7uoDxfyee6Ntv
         zCCHIHqUoWCw7hbtwgojgfnPr4swNZhVesqP+TXfn5iw/3JBLAwyqJ5mD7RkF8V4s3j5
         fHEA==
X-Gm-Message-State: APjAAAVJXs+X+3ZD3VKOZ7iqvqj06GbqT+SNZ9c+MAnhRU/A22hts3rk
        tXghI4w1M+Z7HtS5CKHRH9telgvB+75XTyNVX48=
X-Google-Smtp-Source: APXvYqzXIjoh6j8R6wyKbTnhDH248/Z9RNJnIdlNFSbny1km3ekIiDHjX/wxHe7mm+YCSNMHaRFK/u2KDdOOee38wiM=
X-Received: by 2002:a2e:9059:: with SMTP id n25mr9505259ljg.134.1569949277911;
 Tue, 01 Oct 2019 10:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
 <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
 <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com>
 <80d9c12986ec0a13c34672ca1c16f37cae0cc096.camel@sipsolutions.net>
 <CABPxzYLrTC3kS86iyfq+RY=XEgjedu2MWPtn+i+H50jPz3oh3w@mail.gmail.com>
 <39d646206446159a2b0a67ee7d8667483ade0733.camel@sipsolutions.net>
 <CABPxzYL0i+YbKh-xMXsS-xWeQvwfFUvv7vGhugM1e+OFMOSHSg@mail.gmail.com>
 <CAK8U23bbiGhmDg-ChDJtbRVVc_6njVdoUjfAhqM+V3yfQXTC4Q@mail.gmail.com>
 <CABPxzY+8Jjvjv0x79yzo+rL3nONTZSkROK1T+gMqq5nhXb=7-g@mail.gmail.com>
 <CAK8U23bb9C+16zuGi+uAYxUg-goddiSZfDAJUYeC1Xpu=jud+Q@mail.gmail.com>
 <df3b53f157e113e309360ed40b1f36b9f08f4d8c.camel@sipsolutions.net>
 <CAK8U23YMeFcQPLfWTMijyJaiX1V+NO9FWmq70nhS+bLVNxFYkg@mail.gmail.com> <616a319e4b8623508f6cd00fcfca8303f494a2de.camel@sipsolutions.net>
In-Reply-To: <616a319e4b8623508f6cd00fcfca8303f494a2de.camel@sipsolutions.net>
From:   Ramon Fontes <ramonreisfontes@gmail.com>
Date:   Tue, 1 Oct 2019 14:01:06 -0300
Message-ID: <CAK8U23Yrdw8dtO2jDQMMECWpnp=8LEOPqbfL5NQt4sjz3VjsDQ@mail.gmail.com>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Bob Copeland <me@bobcopeland.com>,
        Krishna Chaitanya <chaitanya.mgit@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Now that I look at that, I think most likely the reason is commit
> 119f94a6fefc ("cfg80211: Address some corner cases in scan result
> channel updating") which was backported to the 4.18 series.

The problem is now fixed! :)
Thank you so much for your support Johannes.

Sorry for my ignorance but where can I follow up with these wmediumd changes?
https://p.sipsolutions.net/6c52392b5e31d9d1.txt

Btw, I've created a PR for this in the Bob's repo:
https://github.com/bcopeland/wmediumd/pull/21/files

--
Ramon Fontes
