Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80570D31E1
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 22:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfJJUU4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Oct 2019 16:20:56 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:46248 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUU4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Oct 2019 16:20:56 -0400
Received: by mail-io1-f46.google.com with SMTP id c6so16549964ioo.13
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2019 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPkNNGeagVj1CLX70B/TcJzGtTxszLuPgR2FHE+kuIc=;
        b=iuSmkh4Cpxz19gsiGFuL0ZVrlKtDWP2mKMwadZ7OuQ/hzMQO2nzK2snzfFePzYICWC
         3oJz0l6T61ApxyoMQQIMsh2Z1e5DJQJbGMW16rZCnPM4x//pAMsCdIGJzykq9LdP69qK
         eiy5YfTKhoGLjVoAq5dDRTpFE2bpYIgEBmVHGo+h0K4Q4NNDHv5LPdI+NkZcBOb8mcZc
         gQqBui3i27Fkg0Sl0JdCcskFzaTmXHE8w3t0SB8qr6B3j+QYGxSNWF7Bp411p/AkAhVq
         Rohq01/7lpQ6YNvY2jRbE7ESHPWQaJHc+1h6m+hKDfhm8F6yMJfRlvJSeuZGFr8pnHMM
         5Zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPkNNGeagVj1CLX70B/TcJzGtTxszLuPgR2FHE+kuIc=;
        b=c5EHmRdH1zp4kM/65vMHYpLOm29Ne+zQX3Sa/pRY4mpyH8ia5k9UzHLvleCntpZ/Mt
         4oeifbCdxED8RcQjMi9G8i1eJa3nSbdq1OF2XlWNNdObOBqAFkPGLGGSavUmJYMobT1h
         Dt32aYJQRB6Y2SrpFD4K72+GDKibg4Cnh2LY1Ge5i0LMNLCd3fkyZbqun1FcxTOqnmI4
         ncciAkx0L0qDlJ4VujXxyBetNI2y6SwWM2Ui896vtUu/1WBD3KZrEMYI7ixt93o97fge
         d4gmViB4x6b1nSKJCUnQGSZ14f22IZiAxro2HQORdn/iC8nMJAmkyymV/+qOBowRD9r9
         MEZA==
X-Gm-Message-State: APjAAAVltSFiVNWnDvURuSs1ovJpPkyemI3khAyrfCJWlWep+DgL36zZ
        w+7ZB3aW/vhFWXKWt4VSVErWv8pR1OjIjRDRc/U=
X-Google-Smtp-Source: APXvYqzyI2vMq8QgfrM8GdgBDQjMus11f9YGid7QgzGSh9iNYheEPq/UgvLwDE875OeVNZVEZPSCItjsujY379yW4Tw=
X-Received: by 2002:a02:c4d8:: with SMTP id h24mr13338162jaj.27.1570738854176;
 Thu, 10 Oct 2019 13:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKKzd-8jgQWTO2w589gMVJm3CaU-15wUER+fsqpYJJSeZL4RPg@mail.gmail.com>
 <CALLGbRKUZmZzBh9=YpJ+r_ts8aY+HXy159oviihSgqMEofOCRQ@mail.gmail.com>
 <CAKKzd-8aRFtdkK+E4-sXBid9jP_sAr0bGbdLYJ=sjb4iCsTAcw@mail.gmail.com>
 <7158fc76fe5ec091633b36b3218a8586960c19e2.camel@redhat.com>
 <CAKKzd--xon+8DY0=6pYF536SfGU9iXQeMvQ3huhT=8=Ap2bCBw@mail.gmail.com>
 <CAKKzd--_m8BZhjXkimAzGJ8TFF8-18zV61ykZEnGq_WX9Wrz8Q@mail.gmail.com>
 <CAKKzd--TAFqwuUcWyU1c5GTya8EQRN=Ob9TUuDwQ4AAMTDEAHw@mail.gmail.com>
 <CABPxzY+2mZ2=t8t9vD+ptu5WeZDRGtmn-p=EBSknunU3C5tWAQ@mail.gmail.com> <CAKKzd-91BbanxTRQf--EeLBpPvZg-X5kcAx1tohVKJ4sxC=pDg@mail.gmail.com>
In-Reply-To: <CAKKzd-91BbanxTRQf--EeLBpPvZg-X5kcAx1tohVKJ4sxC=pDg@mail.gmail.com>
From:   David Ho <davidkwho@gmail.com>
Date:   Thu, 10 Oct 2019 13:20:43 -0700
Message-ID: <CAKKzd-_MLGXVYuV1k7K6PGE_T50MzrXbENeM7FWsFHA+LNr_uQ@mail.gmail.com>
Subject: Re: Linux wireless times out at Google Starbucks location
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     Dan Williams <dcbw@redhat.com>,
        Steve deRosier <derosier@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 10, 2019 at 12:09 PM Krishna Chaitanya
<chaitanya.mgit@gmail.com> wrote:
>
> Did you also updated to corresponding linux-firmware, that might have
> solved the problem?

Nothing else was changed other than the kernel being booted from grub;
 I would have said that otherwise.
