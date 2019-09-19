Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1EB7002
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 02:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfISAVE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 20:21:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38829 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbfISAVE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 20:21:04 -0400
Received: by mail-io1-f66.google.com with SMTP id k5so3528633iol.5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2019 17:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LGFJWhNRpfPDkxQiLAsv0dpfSscHnJEMTZIfgTSOTVI=;
        b=CqweiLWhfGBlt+91VHeB760UcD+rMvZZbhWwfMPVFcPgkX918x6xWHiurUfnK3RhF+
         Tbl377hvInemif/ryImLaiz9voLiYlm4G17wQd6ulThTe2+bclqGMJKy1+e/gOOWilZp
         zTRdfwkJDuyQ9EELbryO0YYB+CGADeStnAc51M0og8ihys1CklaKZusB2VgxIwPkX5dS
         8EkdXU6qB1zdwKo0HxXjDs2Z5GX1jf71j1O4oAO5d2fAhTIRZD9CNKCJQ2Z7e6cDk7ev
         VmVq9o80z3RNajnmHtTc7ywkuI0kTAyFHrvV9baJSFoYPW0Milqp3+hzLJG0Jw6Fz++u
         nyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGFJWhNRpfPDkxQiLAsv0dpfSscHnJEMTZIfgTSOTVI=;
        b=fEF0lwiLNykaQVpEiK05uRheGbQ2tIvH411a6Jqq0//iS3YI9uIX78SdG/OVOFx8Dg
         Mcy02BS0P/VSiOpcgxkuMWDHEryePzQ5Q4hhb/DqRhZriOJx99pT2FjU5lk1Bk1KULky
         cwL1nU5JqExuKvG8F5LU99bBDgBA0b2tbF5BTdXEI1IX8laTaRg4ZnAZgyf7I2ZW6V0/
         kamEIWZRuPd5IZQXT+f3tucqYoFK9uEgzugUJJ/WQGXoXQGkXi7cJyIqGCbMIOMVDR9S
         YOOC5HjHB/C1E3J3eFKTsN88kDrRFcdg2YkHVojJgqTpNby3Q3hvkWoqSxoFdJ4i1G8/
         o39A==
X-Gm-Message-State: APjAAAWJisgixNZPuVmzkBB1EYhprQfOxOVvtJGt4NW1DHk62o4ljJlO
        /Jm6VdPRgYf2SwakOvWCedDNjZScOSk=
X-Google-Smtp-Source: APXvYqz7yySgx822+qGRpN9SqkD8SIzOGoBt8C3gItOFhf8H0MW6E9R4noYo1YWRp04AOMFd8Vm3Tg==
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr8199933iop.181.1568852462525;
        Wed, 18 Sep 2019 17:21:02 -0700 (PDT)
Received: from hash.lan ([2607:fea8:5ac0:1dd8::d25])
        by smtp.gmail.com with ESMTPSA id e139sm5903756iof.60.2019.09.18.17.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:21:01 -0700 (PDT)
Received: from bob by hash.lan with local (Exim 4.92.2)
        (envelope-from <me@bobcopeland.com>)
        id 1iAkBw-00063c-Ue; Wed, 18 Sep 2019 20:21:00 -0400
Date:   Wed, 18 Sep 2019 20:21:00 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Balaji Pothunoori <bpothuno@codeaurora.org>,
        johannes@sipsolutions.net,
        Ashok Raj Nagarajan <arnagara@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v4 3/3] ath10k: add support for controlling tx power to a
 station
Message-ID: <20190919002100.GA28186@localhost>
References: <1553856587-21611-1-git-send-email-bpothuno@codeaurora.org>
 <20190402223709.GB8910@localhost>
 <871rwdbu1p.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rwdbu1p.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 18, 2019 at 04:41:54PM +0300, Kalle Valo wrote:
> Bob Copeland <me@bobcopeland.com> writes:
> > - on A, changed the global tx power limit to 1 dBm
> >   -> result: signal level dropped to ~ -95 dBm
> >
> > Reading the description above, now I'm wondering if the txpower is
> > max(sta-power,global-power)?  If so, that seems a bit unintuitive to me,
> > or at least isn't what I hoped for.  I'd prefer to have per-sta power
> > setting override the global power.
> 
> Balaji, please reply to Bob's questions. I missed this thread while
> applying v5, sorry Bob.

Just to follow-up, I ran more experiments since writing the above
email and it didn't look like it was doing max() either -- at least
on my hardware/firmware combo it had no effect at all that I could tell.

I did verify that the wmi update went through to the firmware.

I can't remember now, but I may have been testing mesh mode in case
that makes a difference.

-- 
Bob Copeland %% https://bobcopeland.com/
