Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66455AD229
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 05:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbfIIDVJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 23:21:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43403 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733187AbfIIDVJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 23:21:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id l22so14518758qtp.10
        for <linux-wireless@vger.kernel.org>; Sun, 08 Sep 2019 20:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1APyuoL4E37WTovMrQCB3X0aJMv3RbidiDKBxqUtBXc=;
        b=WU8feeNTtXXgbEAr9nj0dde4sd1QGb6WYvJqdi3szgnpJlcx4x7efPrN5MBJCIzyLS
         thFakJVEIlweE6w8bselGwKF5EAwkeGsV2O+PNQ21+GerGl33zHPNhjkRKkYRcFbzE1g
         eQIrMsoJ07wqc3ISuVrCxvXJlbpgB2EOs8KX7Sgdi6/zpaN44gtDQqQWkDI/J1cqgGdV
         l2YvrRbwzCcmZj6Dj13gErTRBBZGLhVLVa/Aa4HTlYY3/nm4NupKAffP5RkIdbkApBwW
         5N3zTzecc/1tL9AdLy5Iktlml49L71/TOLjW9wh4vbFWa/1qfDaBzetPaUrSqrVwp34Z
         IN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1APyuoL4E37WTovMrQCB3X0aJMv3RbidiDKBxqUtBXc=;
        b=Unj48XB6SfFlnAOj1ivoQLdJqTmBfAX3DfRElIlkYs8I9gDEchBlj/saojb2KFId1c
         hkHgb2iZjjFAM6U35YlyYXF1J4RxW/3lptsO6V5cDnZ0ygDfEcDwtE6nr/9AXOQSR0jn
         irp0bMDPq9+rX1sxO1Ew3m21XAg2gbOffj+kOiW3y5nxvB4YlQB3Rw5mKgWbORowBklk
         smcOx6/OBrFmA7FrBpiZkC7Ft71FlBY7dosA67Xyy03338gqC/hWLdhtiEOG+veVX/rZ
         aTnHuNIRt98QAeZlph9hq2zvXD1/ziC9ZjwKKgEnDE1mhqP83koBR4vpPWufB7MB0WPi
         h9Hg==
X-Gm-Message-State: APjAAAX4Gim+KBOtnjtlSInQhdFkaCuPCTsMR+KkOJ3hjD81uFYx2fjt
        B///Brj09pejcXzut/RtWBcJ8sT1KOh8/TYZVI2a6Q==
X-Google-Smtp-Source: APXvYqyJ+Ip5BXZiFI8YQVTogMVThGQbw+ynigoqHmn+TAtyr2RAIITxyd25f+jQpmxy/m3o884NMqs640oyb/KEauc=
X-Received: by 2002:ac8:7959:: with SMTP id r25mr21299115qtt.208.1567999266888;
 Sun, 08 Sep 2019 20:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190903053735.85957-1-chiu@endlessm.com> <CAB4CAwc5OBUWFThh__FedmG=fR-_1_GxUuiAb0J5yfU8c1aTfg@mail.gmail.com>
 <874l1p28su.fsf@codeaurora.org> <CAB4CAwfT58Twi-TdtyDMRx+vBQeJg6G5tnyxxC=eRZM14JykHQ@mail.gmail.com>
 <87tv9py7ns.fsf@codeaurora.org>
In-Reply-To: <87tv9py7ns.fsf@codeaurora.org>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 9 Sep 2019 11:20:56 +0800
Message-ID: <CAB4CAwd0zcNCWTGwLdDmskmpCYqtdLFAkh3M9ZOKZ7wCvXMwQw@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: add bluetooth co-existence support for single antenna
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 6, 2019 at 7:40 PM Kalle Valo <kvalo@codeaurora.org> wrote:

>
> See what I did. I didn't include hundreds of lines of unnecessary
> context from your previous email, instead I edited all that out to keep
> my mail short and precise. This is really important for fluent email
> discussions, as not all email clients filter out quotes automatically.

Thanks for pointing that out. I'll improve for the next.

Chris
