Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD2D3122
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 21:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfJJTJi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Oct 2019 15:09:38 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:44947 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfJJTJi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Oct 2019 15:09:38 -0400
Received: by mail-io1-f44.google.com with SMTP id w12so16110249iol.11
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2019 12:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mCrXIYa4gogdAqsaBk84oKjK2AtmUCQtIH28diZ7r9k=;
        b=pk5JnlwZSMh+Bb7qxVTO01b9r8oqrSxQc9dLfJfR5904r6nRE5LfRQ4VatyXJHZNh1
         4lWYl2Rln506I1NEsW9NMN1y2fg+kbu9MxRbcFifwOCFkk0PBCXK++uM4WzdaXNnmfeo
         45DndbXA+UfvhpV5R9uIbVnRQgOZLLWEaIPel1qScZ3JNqEUZBW5U2b5QVG60cq3Cl/1
         9CdaXJQhq1bBFQC+dTAwsw1d/d0dHGpPQVh1YtirPOfq0yZu5I5EG7q4lrvVYNfdxcg+
         22o+c1TJF/x6+aU2okQ15nDEg5CxZde2rCn+rokLmxMCkR79hgXQlSuj1A/Km0vNLeNj
         ftzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mCrXIYa4gogdAqsaBk84oKjK2AtmUCQtIH28diZ7r9k=;
        b=QGtJIKDU1CNLd5/FMkitCtIWxymSduRMgtRwiOHDIzVV+4giVBK1rWyTc0tVt3rcsP
         tqQJxmG8L1IKTcmQzBAI4JF2EiYs9vbCsZQe8HX3A5xxUhHlmmAGFypiQvByg9PvAa4q
         1S5vj/2oyKzLUt79fcqHpbi/SbbOS3g2x9iU7Hcx95JDexQbTyt9aYKqT0O0VGghtew3
         p0jlXTzgs8uifvtF5aIazWTGNiLTDNJcNzIlYGOVYlGjUDpZIhfIVusBnVdWVAamNxL8
         puDze/dOQ0rK62aNXcoPt4ZJxTyPb2Gskdvad6JInh1IJMBKQbvYZQ+xwFtOTIol4nND
         MIfw==
X-Gm-Message-State: APjAAAWdaqvHcy/1xE4MCBoL+ci5qyOyMR4pyo1S5X/hZ9DeSFWyi/Hz
        m+VUMWUlCjoE1tiBi+HuDXXNblWJ+w7y6cF3hyk=
X-Google-Smtp-Source: APXvYqz08D2pv/LIC0FrCxEnZxeKdKiVS5hqv04WiqDidncBzeBUaDnfC99znh2ddiMRMw/p/WA/iaGLSrw7QBEYtj8=
X-Received: by 2002:a6b:ef0d:: with SMTP id k13mr24713ioh.232.1570734577635;
 Thu, 10 Oct 2019 12:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAKKzd-8jgQWTO2w589gMVJm3CaU-15wUER+fsqpYJJSeZL4RPg@mail.gmail.com>
 <CALLGbRKUZmZzBh9=YpJ+r_ts8aY+HXy159oviihSgqMEofOCRQ@mail.gmail.com>
 <CAKKzd-8aRFtdkK+E4-sXBid9jP_sAr0bGbdLYJ=sjb4iCsTAcw@mail.gmail.com>
 <7158fc76fe5ec091633b36b3218a8586960c19e2.camel@redhat.com>
 <CAKKzd--xon+8DY0=6pYF536SfGU9iXQeMvQ3huhT=8=Ap2bCBw@mail.gmail.com>
 <CAKKzd--_m8BZhjXkimAzGJ8TFF8-18zV61ykZEnGq_WX9Wrz8Q@mail.gmail.com> <CAKKzd--TAFqwuUcWyU1c5GTya8EQRN=Ob9TUuDwQ4AAMTDEAHw@mail.gmail.com>
In-Reply-To: <CAKKzd--TAFqwuUcWyU1c5GTya8EQRN=Ob9TUuDwQ4AAMTDEAHw@mail.gmail.com>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Fri, 11 Oct 2019 00:39:26 +0530
Message-ID: <CABPxzY+2mZ2=t8t9vD+ptu5WeZDRGtmn-p=EBSknunU3C5tWAQ@mail.gmail.com>
Subject: Re: Linux wireless times out at Google Starbucks location
To:     David Ho <davidkwho@gmail.com>
Cc:     Dan Williams <dcbw@redhat.com>,
        Steve deRosier <derosier@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 10, 2019 at 11:14 PM David Ho <davidkwho@gmail.com> wrote:
>
> Hi Dan, Steve,
>
> The issue was fixed by booting the latest 5.0.x upstream kernel !!!  I
> guess this has something to do with 5.0.0 and seems to have been fixed
> since then.   It appears I put too much faith in an LTS kernel...
>
> $ uname -a
> Linux mumble15 5.0.21-050021-generic #201906040731 SMP Tue Jun 4
> 07:33:07 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
Did you also updated to corresponding linux-firmware, that might have
solved the problem?
