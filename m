Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008C937A478
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 12:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEKKXQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 06:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhEKKXP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 06:23:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA6CC06175F
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 03:22:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s6so22184321edu.10
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 03:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmTpaJGbdRDVabZ/Ya/snqIhQgVbSrIzekeHrdrwMYI=;
        b=gr6ABjLbHUzUXY182Vs6Ufiv8nW6iU41UhcGlhr4t2Y1qM75yRwcxCUrzTMFwzyDee
         gz+2KxabVUkpBgv3+Vujwch4b9+9tMDqHBPM5v8NdqS6AnTjR+nzHup/OgdDH2pDCBlc
         0QRmfk3W0C40+ubymSdM8cJgJ/MNY/sPMbIQTDr5jjNuu+L7wTDg9Wfk8RyPALXwZE8Z
         hoTh40EdI+evead0YMXFHbvQ5ZPTX5B7e7OEV2untHHfkTN/GevLElwsN1GaA5eH15Qb
         Bb319haX6Bc9Mn4tvwJBgy6EtDOogO6isMpcl0FV/adzPSfBSzxDYJQ13QPZwd5gGwRx
         EuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmTpaJGbdRDVabZ/Ya/snqIhQgVbSrIzekeHrdrwMYI=;
        b=NDJDCxR4YWA/jkvZKI66iou9iGhsdEZ/yBcBBaS7mZChgdZkj2QxuHrSyx9KD2c+d2
         3+rgPc/BZs7Wvp9QrnpJEhmpvRDmdG758vv5LzriaqZ7tx5/jYifpXc/o09c9C6NMSpJ
         jzA9WF+IMXfygjYn4Pd03pSCDyAnHAa5M/R+W9AoQEubGuBVgQtFK2CcRyYM58QwGyBA
         jXyg6ZhkUkOWvtr715LRXlINmijhWYjVWbkENmWDBBR/z2/ExQXKGybCiioEX/9xZocp
         S3g5oanva+YunxesF0pFHYwt+huI5S/mByfvJ698WMgbdsuiUPTFkILh9QysmChrs/D1
         JxSg==
X-Gm-Message-State: AOAM5304wKSmtDofBAmMFKxzje1Ei6AlgclnLIBp0/42ZT/jOViEM84E
        SKGXYN6TYmKRa8FH/i/n8U2Vzl7u9gs7SoXoJg==
X-Google-Smtp-Source: ABdhPJw1p7rnLMKksuPaAzR6xbE58mkpd6GcxYyyQVohKHv2wtPQ+nfzNFaKQakMQh0IHqpnN9XB9eolH5Q2HrUoybE=
X-Received: by 2002:aa7:cf19:: with SMTP id a25mr35833312edy.231.1620728525645;
 Tue, 11 May 2021 03:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210504212828.815-1-rsalvaterra@gmail.com> <20210505045044.GA735251@wp.pl>
 <CALjTZvYZ8Rr-UFyqFststt+vG+Ei1avUvPVxQwHe72QU0NEeKA@mail.gmail.com>
 <20210505092542.GA757514@wp.pl> <CALjTZvausPmK+AubwcV71b1Vi+JxN23fM-AfUr1+jRD+NbnW1g@mail.gmail.com>
 <20210505132513.GA759295@wp.pl> <CALjTZvaQjGDc2iO7gLvTzXp1xWs78UqFVFxdGVD9ta971bRYSQ@mail.gmail.com>
 <ab30bf35-b05b-685f-2b31-5d211f896e2e@canonical.com>
In-Reply-To: <ab30bf35-b05b-685f-2b31-5d211f896e2e@canonical.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Tue, 11 May 2021 11:21:54 +0100
Message-ID: <CALjTZvZje0BNj8Vjxjjn8Lmxrhj5N2-o8ZJJASd-0TZOBZZJFA@mail.gmail.com>
Subject: Re: [RFC PATCH] mt7601u: make the driver work again
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, lorenzo@kernel.org,
        kuba@kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Colin,

On Tue, 11 May 2021 at 11:16, Colin Ian King <colin.king@canonical.com> wrote:
>
> If reverting the above patches does not work, I suspect a bisect is
> required to corner the exact reason.

Sure, I was just trying to be as lazy as possible, but I guess there's
no way around it. :)

Thanks,
Rui
