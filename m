Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFFAC88BE
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 14:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfJBMiT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 08:38:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38496 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBMiT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 08:38:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id u186so14772486qkc.5
        for <linux-wireless@vger.kernel.org>; Wed, 02 Oct 2019 05:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjGcad+/AEf/LQ6JW0XEmjTyfYLZoWupXny7/907quI=;
        b=BuKfaXOGJkGNN039Bc44rug88lxpIT8oI+YcKkFCeQMvnOv102ztRZn3SwNsZHcFQv
         v7EROximmU2mlCX6FLXNGJHwfUzzoPDW1Oefmyzg39aNXdAC6AqMjwoO6SjQWSKMbudq
         pulzcmolj9dCghigUJiI9p+w8GbPQEUDaHe5LWEgLwfyO809Zo30CTyP4flXdTA2I3RY
         3dd/olg1yHbQ8Rlvq3oSAIkPjSsWmdC7u4ispRQzoFBiHUl3b3bEcf6fEYPibxSXfieg
         0f2oFQcuZQN9y0NZeHXdfHBS1pUWGCf3klcTqlKVfpKC2auiBaZQSEjPN21VvEBadw8Y
         A0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjGcad+/AEf/LQ6JW0XEmjTyfYLZoWupXny7/907quI=;
        b=mco5aZ4L/mZ31gkZflGqb6xxoICOa8pw5uKGwq9jrO5KiXUz6VQUfrfHvqLFVgEVOn
         ut5E9bZi1da34fpKDeaZqChOvEdD4HdPu0Zw7JpFQShfgI9S6z/2aYt0rgkYhTDigRGA
         uuJ0m0xLz1yRUObu56D1PQVCS7XY6+fyGf8ySoXkaFslPTe0jbPTDyhFlWggJRhOmRYA
         yCzIef/9xH2ARvmxYoWXNYLGuUgXncte5SnU/mbR761OCIDLIEOOqnU4o9QVkTG7NEsX
         B0H32GYTIL9nqmDBMnkA+6Ywvf+UhLWjE56Qbqzk12mjoPKEGGjtL1T95+mcPUbX1RnO
         hqeQ==
X-Gm-Message-State: APjAAAVQrYO+YXzbada86eRjzpMGoxPx2HRzxGOKWG/WDtASmk4PlmGl
        BKrJV12s9R/obLRMrY43tT8tBFIHk+5aTcRIvMeGXg==
X-Google-Smtp-Source: APXvYqwgMZyCWyDd3fnNskodhxm92UgANHaXL7pTyigGGX+fmEMuqAfA/i/iU3ag6oSmB1WW21ZFh/8Qjlo/LOZHEqM=
X-Received: by 2002:a37:9c57:: with SMTP id f84mr3540760qke.250.1570019898066;
 Wed, 02 Oct 2019 05:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190911025045.20918-1-chiu@endlessm.com> <20191002042911.2E755611BF@smtp.codeaurora.org>
In-Reply-To: <20191002042911.2E755611BF@smtp.codeaurora.org>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 2 Oct 2019 20:38:07 +0800
Message-ID: <CAB4CAwdvJSjamjUgu2BJxKxEW_drCyRFVTbwN_v-suXc2ZjeAg@mail.gmail.com>
Subject: Re: [PATCH v2] rtl8xxxu: add bluetooth co-existence support for
 single antenna
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 2, 2019 at 12:29 PM Kalle Valo <kvalo@codeaurora.org> wrote:

> Failed to apply, please rebase on top of wireless-drivers-next.
>
> fatal: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h).
> error: could not build fake ancestor
> Applying: rtl8xxxu: add bluetooth co-existence support for single antenna
> Patch failed at 0001 rtl8xxxu: add bluetooth co-existence support for single antenna
> The copy of the patch that failed is found in: .git/rebase-apply/patch
>
> Patch set to Changes Requested.
>
> --
> https://patchwork.kernel.org/patch/11140223/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>

The failure is because this patch needs the 'enum wireless_mode' from another
patch https://patchwork.kernel.org/patch/11148163/ which I already submit the
new v8 version. I didn't put them in the same series due to it really
took me a long
time to come out after tx performance improvement patch upstream. Please apply
this one after https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2117331.html.
Thanks.

Chris
