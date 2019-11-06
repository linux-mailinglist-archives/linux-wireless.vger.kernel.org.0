Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02748F1B6D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2019 17:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfKFQis (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 11:38:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37665 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfKFQis (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 11:38:48 -0500
Received: by mail-qk1-f196.google.com with SMTP id e187so12435437qkf.4
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2019 08:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9gTkX/4CQRTxBR1vF+UZ78ZA2VnY+QyLggs9SIvFiI=;
        b=iKMbR4395fRYHXpOOZpYS3KcDAZcZlrRY7RMmHbtwHg5rnaarwfRTz2mcutjbIiPB/
         SeKYMaNY8boTtT4ZmT9yX5pqO9+zpnPJAGzR2G4yGoUk8NZ1+V3W5qpW6rrq9BqrqfTv
         jkYC3+3GewhiJwzuQI1Jqv6Oq3E2UTxaY+JnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9gTkX/4CQRTxBR1vF+UZ78ZA2VnY+QyLggs9SIvFiI=;
        b=kYzKtDcaN9XImjt3g9cILkboTBF+61aUGcRlrukygRIBg+zVrKJNpEw6QKtPkAEqkC
         cuRKGyudhxFcZ8a1zhnS/mr6pkJth0q69VOTBqG1S/5LwWvOfm3+XwKTjBTTIOAAvonG
         Y060/IV8Wq0DaU45W2BILrfCokXkdbDBAU0n1wjEf22fp8ALRAGBc71p0vK9Z8wo3SwF
         AlPbRd2yRCn0fMuUxbmkk2tUEhsINoiyJZN51TlFxM3wNI+IC7iupUuO+RRmh+g8gtbv
         QAvBGMYY5T7bz75sx0giiYHBIIwxSff9MsmUOcUM9ecK2NSqLxp+wCFN66R53kn85Ww3
         Iouw==
X-Gm-Message-State: APjAAAVRSuctHp/mx5nTbVWikk9/U03KP+XJByRU/pSKEBnqTjtVMH3k
        YsVQXDJKs+JEfcI3+TbV+SiouvvyoAY=
X-Google-Smtp-Source: APXvYqzsHK7T9nUavz6YwCmPgibotT12rKV4puB9cXTYoyTM1cF9VSIeR/b2YrHDwWBZUK3bzf83UQ==
X-Received: by 2002:a37:c44c:: with SMTP id h12mr2820039qkm.218.1573058326002;
        Wed, 06 Nov 2019 08:38:46 -0800 (PST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id v186sm11886398qkb.42.2019.11.06.08.38.44
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 08:38:45 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id p20so16086482qtq.5
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2019 08:38:44 -0800 (PST)
X-Received: by 2002:aed:2be2:: with SMTP id e89mr3215840qtd.161.1573058324338;
 Wed, 06 Nov 2019 08:38:44 -0800 (PST)
MIME-Version: 1.0
References: <20191105225751.1233-1-briannorris@chromium.org>
 <CA+ASDXM_5Q3LNyv_mbrG8d8Qo1iZZz2A2CFfvQqj9_Ta-q-wMA@mail.gmail.com> <786f623306ad462e3776236c94e83b5f2e0648ab.camel@sipsolutions.net>
In-Reply-To: <786f623306ad462e3776236c94e83b5f2e0648ab.camel@sipsolutions.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 6 Nov 2019 08:38:33 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMVJg0QSPzSiWFjoDH67yJ-NfYX4MQZUT3gaivx1SJ2aA@mail.gmail.com>
Message-ID: <CA+ASDXMVJg0QSPzSiWFjoDH67yJ-NfYX4MQZUT3gaivx1SJ2aA@mail.gmail.com>
Subject: Re: [PATCH] crda: Makefile: fix .so compilation line with some compilers
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        wireless-regdb@lists.infradead.org, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 6, 2019 at 12:12 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> On Tue, 2019-11-05 at 15:02 -0800, Brian Norris wrote:
> > Apparently wireless-regdb@ is subscribers only. I have since joined,
> > but I guess my patch bounced from that list... if I don't hear back in
> > a while, I may resend.
>
> The bigger question is who actually maintains crda now, if anyone ... :)

My mailbox tells me that as of about a year ago, Luis was still
merging patches. And his latest commit even claims it's "still
maintained":

    As if kernel v4.15 CRDA is no longer needed. Annotate this. The
    code will still be maintained to help older kernels.

Brian
