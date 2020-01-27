Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258DD14A3DD
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 13:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgA0M33 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 07:29:29 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:44677 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbgA0M33 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 07:29:29 -0500
Received: by mail-io1-f48.google.com with SMTP id e7so9713519iof.11
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 04:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bbXWrCOiDmmxcPPYrRBxk8fQ528le+/5Oq199urbbI=;
        b=tvBEIBYfcNAeDn9JbGcID9r9lCHJJdVw/PtjqtR7Ht7/ZchpBzcETp63CrLcc3YeO4
         64vxWxPHas8MNvdG9k9n6pl7YNQmExWc/xDTwQ4Kf3TXxrjhjkfw8q/InXBuTIcLu9zI
         ZnNx2aGn8RQpCqfnetg+KwgMs2XjT+MY7//m74R20WW3MHndyPo40QrvdWQlZuS0e6eQ
         wZU2r/DbhdXjLtMXvWQ9GjSuCHIQq8rZ2FATF928C4i3FknTuvVjGDFb+fQDmAK1uFRa
         Orop+tcb5TuCDmZ+3LGaL/vab/6JIm5c55kdA9VS8GXotmZVKYCQhYmvSmSSQEjciWNb
         0Qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bbXWrCOiDmmxcPPYrRBxk8fQ528le+/5Oq199urbbI=;
        b=SFuRLUzL8xKg/6rq2VgxA7KOKIt78l04gkt6L4u7zzYqt5j1JaCv8TC2pIFrNORdaA
         3p/pASJjp9cQGI8KMQlEBp2f9kY99IGFSVC7GlpFG2pqZ9ZV07yN5BF6OLlIfPNVOzcK
         8db6yuu02e+z0cNc7lGGQ1acaMs1imyLIcEKfyX45BEy2Ua0dwFyI9y21HOq/3ZaP1Sl
         bXtpg2eEJOfZbGHi+zM/gVZt6mY0rTjvID46FC0wsJMS0tdf8EIlEzISsPiah+rxBL6N
         RQZFHLZeWOwbjXxqZrZ4XRszWlJFrWVcTNd8KFaqAfjLLOE2ADQOm1+fKt634g0DBXXl
         /bUg==
X-Gm-Message-State: APjAAAVv8XQ2YXqtO+f7lIu9BhQHogFoMZN0qkcWtjC11aJ0KPq3g8Pv
        +vi3BKcHruQ6Zx1suzs5zujtC0rJvkGN1fFO1Ys=
X-Google-Smtp-Source: APXvYqzmRv9mFMxDRYl5wVPca5VTJ0i2cYqyRXj6Wk0jQzYyaey9GQfALzIJ+mJr76UP6//8rEtYpEqlLkNPkZhM1PQ=
X-Received: by 2002:a02:ad0a:: with SMTP id s10mr13259041jan.73.1580128168954;
 Mon, 27 Jan 2020 04:29:28 -0800 (PST)
MIME-Version: 1.0
References: <1567189484-27536-1-git-send-email-hanipouspilot@gmail.com>
 <20191029144815.GR30813@ubuntu-xps13> <20200127042500.GE3730@ubuntu-xps13>
In-Reply-To: <20200127042500.GE3730@ubuntu-xps13>
From:   Dmitry Tunin <hanipouspilot@gmail.com>
Date:   Mon, 27 Jan 2020 15:29:18 +0300
Message-ID: <CANoib0FRd5-rVgLJhgxuQk591uMSvG1ytxg87mWuKF6nbrnEdg@mail.gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: update regulatory rules for Kazakhstan (KZ)
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Hi Dmitry - it's been a while since I sent this last email. I wanted to
> check if you had any responses to my comments below, or if you intend to
> send a v3 patch.
>
> Thanks,
> Seth
>

Hi Seth

It looks like you found a lot more information about Kazakh regulations.
I have nothing to add and I agree with your comments. I had troubles
with my storage and I've lost the wireless-regdb tree.
So you can discard my patch or amend it as you like.

Regards,
Dmitry
