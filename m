Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41DA6B23FA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 18:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbfIMQTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 12:19:36 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:36974 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387726AbfIMQTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 12:19:36 -0400
Received: by mail-pf1-f180.google.com with SMTP id y5so15633632pfo.4
        for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2019 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pr9i084+SPSEiYofIBlfjZkhUmH6yGU7WH7DED9IByo=;
        b=VI/D6shPQgrH7Pgxq9OBwGpQUiO2f+6FEuF/6IMzzlGNJqlFHaMWKWDMQdEO1n9UCM
         h5cpiUhb4qfoRGjYtPj6mVtxLJkLMsEXkiHOF7MNlzhXIX5eKHiF/QnMGr3Ao0S5h9bN
         hUETv5cDdDKEfom4/4jTzOxTuJs1jsaC7GPK7lPY3GjkvgIh0sTqv61+8d1IplLQztPD
         gKUH6J9eiYUqT7u9sSpv83JnqWI2X47975VukU+okFYk/nTiB9p+BkxdZgXpbXrCeLV/
         vFAnpWV4eo7zjYRZTnfO2fWnSeUpuI3V83vyZN/UFdaC6AOetpdF34jLCkd07HjsDDQm
         YRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pr9i084+SPSEiYofIBlfjZkhUmH6yGU7WH7DED9IByo=;
        b=gSF9J21hew/BTeAi0qYiGZX6hz8awcLH6SryJuKX0DqMkuZKyNyajNtlwdjhOp5OH7
         VGvMlPZPG8pB3nEsJ4ozDRVdTgcWUlg5eCatZ9AqfZ0pzFOfKFf93JDhlQsZOrOe64JS
         AAByyPd8udCaH4h39wxMkRmCGNdn9ESa9jTIuWb+VZzskec/pdWp5ARH9tF9nFOUrY0E
         JxSrsVLKJC8rYtIC6hPTYu4ESm5hqGPlxV0o9ktr5TMd91FPzMJaGbat7Cux5NjhGRVa
         jnkxvia9GdNcHmAwWTwYGqB+sg/YUIg85zR0qauAuqya0kzlyIj1KxaGkcqqdjPHty6/
         oM1A==
X-Gm-Message-State: APjAAAWihp+XExdsylUPV3uLV+anlZsKEP9uoGXkv4XQyfuLyrNxnwjF
        NWgKQgTXQ2iwDI5cezBTwR3lFreWeZ8=
X-Google-Smtp-Source: APXvYqz4uje6ipGm8NcTpOG2+HOTQ+KRmjp6yq3ku/ebT8fc9VnEellwJniJQsKUzYaKM8pG4UJOKQ==
X-Received: by 2002:a17:90a:37d1:: with SMTP id v75mr6207944pjb.33.1568391575039;
        Fri, 13 Sep 2019 09:19:35 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.googlemail.com with ESMTPSA id n10sm25527688pgv.67.2019.09.13.09.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Sep 2019 09:19:34 -0700 (PDT)
Message-ID: <844f1a1dc72ec73df5a86864b410bbc490c4abdd.camel@gmail.com>
Subject: Re: [RFC 0/4] Allow live MAC address change
From:   James Prestwood <prestwoj@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Fri, 13 Sep 2019 09:17:37 -0700
In-Reply-To: <87a7b8lciz.fsf@tynnyri.adurom.net>
References: <20190904191155.28056-1-prestwoj@gmail.com>
         <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
         <4c43ea6a74cacc61184bc5b1387fecaa40711369.camel@gmail.com>
         <4909a428ee6fef2bf8b0e61841bc88062f534b13.camel@sipsolutions.net>
         <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com>
         <87a7b8lciz.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On Fri, 2019-09-13 at 13:24 +0300, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> writes:
> 
> > I know 3ms doesn't seems like a lot but everything counts and from
> > my
> > testing this is even a further 20% improvement to doing so with
> > RTNL.
> > Plus the added simplicity to the userspace code/API. We have taken
> > a
> > lot of time to optimize IWD's connection times, and everything
> > counts.
> > The connection times are fast already, but when there is room for
> > improvement we will push for it, especially in situations like this
> > when the change is quite minimal and does not introduce much
> > complexity.
> 
> So what kind of _total_ connection times you get now?
> 

This really depends. Most of the optimizations I was referencing are
due to scanning optimizations and moving DHCP into IWD itself, but both
of these are kinda irrelevant in this case so I wont consider them.

With this change, looking at the time from CMD_CONNECT until EAPoL/key
setting has finished I calculated 111.4ms on average. This is about a
3.5x speed up from the current method (Power down + RTNL) which I
calculated to be 391.8ms average. Note, this is rough (averaged only 5
runs just now).

So the savings are still significant even if you look at the full
connection times. The difference between doing the MAC change with RTNL
vs CMD_CONNECT are not as drastic, but from my perspective I would say
what's the harm? Your gaining further speed ups with really no added
complexity.

Thanks,
James

