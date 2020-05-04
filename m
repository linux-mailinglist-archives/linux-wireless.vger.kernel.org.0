Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA261C40BA
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 19:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgEDREP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 13:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729851AbgEDREP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 13:04:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CE3C061A0E
        for <linux-wireless@vger.kernel.org>; Mon,  4 May 2020 10:04:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so10421456ljl.6
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2020 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylw/rVQ5uqDbHMoBEoqRYKRrSFsR0xjBGTCKci2YdMA=;
        b=XEYCKlpcxCa4Yj1hBe1EPO8dgoDM2lJYKR9mj/CVqv5dDTLl+4T8bazaW1eLrSHqCj
         TourY/FU0op5zaB6vPTBwaemfEu/JcWi7QaTZa5Ay6rctmHyqAQv06t6XNI0saMrXiG/
         Fj8XwttesOC1EtU7rbpbTUZbRpZTDorDCE2og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylw/rVQ5uqDbHMoBEoqRYKRrSFsR0xjBGTCKci2YdMA=;
        b=Mjoi/e77THf4X9kXiVFzXRbbqxVfrZWCMJrg/3+6JBWrdrA6wreCYKtZdM5yvyefy4
         L/kQsqQ2BmWOGo3S55Uqu5Qb4+Hzl7/PjyAksuhXpwg47WDu5hhINIW+YAsEELWQx40L
         YajOBIyQsUSUrQHhJz4E7wPGodgbdyOeTHDJS1yco/UPeMyCaMFHXsnhAq5nYi0nXtF2
         XTPOSuAzu3j7MYetEXzrn63Bpyw6PF18tqTz0RZ1jxkgQdmqKwunSuyH6hJ58llxKqvj
         MfF1fpsFQUSGjP6YMRJ50CGgpt1UKEze/O4rEZ5yGT0pGmaz/l7lmqAZWptq5medaTOT
         O9lg==
X-Gm-Message-State: AGi0PuaphVemgp9WhmBFtIypi6lq7yf8eplJE13OexLfXie6ZGWS6BCZ
        j6Jdje27Hm/kAsHZDSCPRf7UA5/KdpA=
X-Google-Smtp-Source: APiQypJbEqsAsJt/YS1KfMoMS+C6ewAFPa0SbUTcML2MiYPMfLW6dlY0ZXuXcIUBCSpb7cWHxkTnsQ==
X-Received: by 2002:a2e:8999:: with SMTP id c25mr11025990lji.73.1588611852665;
        Mon, 04 May 2020 10:04:12 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y20sm1422218lfl.66.2020.05.04.10.04.11
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 10:04:11 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id e25so10448076ljg.5
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2020 10:04:11 -0700 (PDT)
X-Received: by 2002:a05:651c:390:: with SMTP id e16mr10921197ljp.186.1588611851101;
 Mon, 04 May 2020 10:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <79591cab-fe3e-0597-3126-c251d41d492b@web.de> <20200504144206.GA5409@nuc8i5>
 <882eacd1-1cbf-6aef-06c5-3ed6d402c0f5@web.de>
In-Reply-To: <882eacd1-1cbf-6aef-06c5-3ed6d402c0f5@web.de>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 4 May 2020 10:03:59 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOJ2CSzdgos4Y8Wd7iZjRUkrMN=Ma0_-ujG8bihGzPKkQ@mail.gmail.com>
Message-ID: <CA+ASDXOJ2CSzdgos4Y8Wd7iZjRUkrMN=Ma0_-ujG8bihGzPKkQ@mail.gmail.com>
Subject: Re: [PATCH] net: rtw88: fix an issue about leak system resources
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dejin Zheng <zhengdejin5@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Markus is clearly not taking the hint, but FYI for everyone else:)

On Mon, May 4, 2020 at 8:00 AM Markus Elfring <Markus.Elfring@web.de> wrote:
> > BTW, In the past week, you asked me to change the commit comments in my
> > 6 patches like this one. Let me return to the essence of patch, point
> > out the code problems and better solutions will be more popular.
>
> I would appreciate if various update suggestions would become nicer somehow.

Markus is not really providing any value to the community. Just search
for his recent mail history -- it's all silly commit message
nitpicking of little value. He's been blacklisted by a number of
people already:

https://lkml.kernel.org/lkml/20190919112937.GA3072241@kroah.com/

Some people continue to humor him, but it's mostly just a waste of
their time, as this has been going on for years. Just look at searches
like this, and tell me whether they produce anything useful:

https://lkml.kernel.org/lkml/?q=%22markus+elfring%22&o=5000

Brian
