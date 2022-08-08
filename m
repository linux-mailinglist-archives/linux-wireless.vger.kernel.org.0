Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAC258C5BB
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Aug 2022 11:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbiHHJi5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Aug 2022 05:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiHHJi4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Aug 2022 05:38:56 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAECB13D5B
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 02:38:55 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id c126-20020a4a4f84000000b004416429f45eso1535663oob.2
        for <linux-wireless@vger.kernel.org>; Mon, 08 Aug 2022 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DoRJRybDZuQI96UeUdmUSl77m45AzKMZ/u7oeYOdULs=;
        b=vE5DtJmI9g/ki/ISr/l5P4NnsuGfw8B1PdO+j3IA1ipsr/24qIjWIplkV+HUY+yHIv
         pAEydeEfWxea8+LkOiFj25CtaE7+p2U7JZIZhVvTF7U63u65hxy37zBVXImSqq5CRsZq
         iV4f8gQJGHRNvqzeIVV+DRCee6KzXKupjOcYtUI6Oo2Sz3NKXoSG+iHFC2iUUrGkvPPJ
         ca/siTZgH78OpQx39zolaUWXz4w8cYFiOF+xAayCplA5QnAbvjODYA6kT3GnYdCTQGfV
         IS88oTTvOnr4qS8E/Fic5hLQtpFPyJDWmkXkvq3ZicC06qJnQYcWrqHfziaPAZDjfqUh
         0c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DoRJRybDZuQI96UeUdmUSl77m45AzKMZ/u7oeYOdULs=;
        b=iE/piLKZ6qib2OYo7SajHkhc0J1uevPJPh5q8eGLK6ihkW0BMTfUaKz0M3LOfAyLaJ
         VrTfWLx9R08KjGvS6LpOkhUvsy0zQBeJEEAruVhlEN+AMgNeNN18Yv3X9gdqidBGbbTc
         MlI3MwVHgjfLYfVIBH5PuWlwTgcYQcnZwQqo99Y/oTzl94vz7h1bDnuLajUOvYo0STWC
         pEp2Rw8AhPOsvsuieb/FVI957xt5RPYK1UgmQg4dxDGcvbL8eM29KfSwAhegU/01OvtE
         7MkMUiNZ1rLUF5zKK7d0vVzX3SwFuUFjH7Uj4jOV0ITSqysW3nWZFNOIJhm9nKc2Yt/K
         Gvbw==
X-Gm-Message-State: ACgBeo2vwXwCxHIxv+G+W14EePxOY5LbLdyFzQsoXbgjoRWAhfTqe5AS
        aJ5bImv44C8C0m8zLgxTMX1vZD81WeDg9TEBMoEpFQ==
X-Google-Smtp-Source: AA6agR7F+cLW7xr3XqXxJZLpg/4JvuVexkHpCS2LDR8IgfdZUBYQt4+13zHhAIvXaXZHjilG0f9wlb1fty0uYacnENg=
X-Received: by 2002:a4a:d54a:0:b0:435:c4e7:77ce with SMTP id
 q10-20020a4ad54a000000b00435c4e777cemr6251905oos.67.1659951535274; Mon, 08
 Aug 2022 02:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220802172823.1696680-1-alex.coffin@matician.com>
 <20220802172823.1696680-2-alex.coffin@matician.com> <ff359bed-ddfa-9f18-e926-fad986b9918b@gmail.com>
In-Reply-To: <ff359bed-ddfa-9f18-e926-fad986b9918b@gmail.com>
From:   Alexander Coffin <alex.coffin@matician.com>
Date:   Mon, 8 Aug 2022 09:38:39 +0000
Message-ID: <CA+hUFcvJVkN6Z=x0paU3roCxOos6V7=L3gHoyCiOz4LKjhMWQQ@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: fix use-after-free bug
To:     Arend Van Spriel <aspriel@gmail.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I am resending this message as apparently it wasn't delivered to some
people as it was an HTML message. I apologize for the double email,
but I forgot to tell Gmail to use plain text only.

Arend,

> A commit message would have been nice...

> If there would be a commit message with some error report that proofs there is a use-after-free

I apologize for not including a longer commit message. I thought that
my stack trace in my first email would be sufficient, but looking back
I see how I should have clarified what was going wrong. What occurs is
that line 360 of core.c

> ret = brcmf_proto_tx_queue_data(drvr, ifp->ifidx, skb);

may be entirely completed (as in not only scheduled, but also the
entire transaction may have completed) by the time that `skb->len` is
invoked which means that skb will have been freed by the corresponding
later function (in this case brcmu_pkt_buf_free_skb if you see the
trace from my first email).

> We only get here when ret is zero.

Therefore this error only occurs when ret is zero, but skb may have
been freed after line 360, and before that line (369) if how the
kernel schedules tasks is very unfavorable.

> ndev->stats.tx_bytes += skb->len;

Please let me know if you need any further information.

Sorry,
Alexander Coffin
