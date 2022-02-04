Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782D84AA327
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 23:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350243AbiBDWdr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 17:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbiBDWdr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 17:33:47 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB52D210536
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 14:33:46 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id g26so8435371ybj.7
        for <linux-wireless@vger.kernel.org>; Fri, 04 Feb 2022 14:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcpkDjIJKrv82Leuo4xExF9LLjomqrJZLM+XhnZ0Cok=;
        b=J9LZf1u6Zp7ID4dVpPe0BwV1Iei94dHbaRbqGT9XDgAVKwB5N+pbAPg3RAhNESrE8r
         q2blg/zpqsNzm30eMzaZWxAwSAlDsZlqYW7TmdHCjrcpOoOnQ0T+LOBKcdZ1SGglkVQb
         eG2V851SiYzFoyVITQ9L4YJ39SmtFoJpqTeV4oX3yk1tuWBnQgkDrZcNnr+4CUvVBC+D
         D/2ZIhDLcxoSvkgL5RMm9OpVBDGRPUQZ0g2XkXL9v2NiQuEe7AfYVRgWfm6byXljY/2C
         N+49ZxkUqT0yG5JyT6Oc1w42mSSMWUAOIiM3UzjDq5nAlcjEFGqzu+2KcTB/ooX5DOG1
         Qs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcpkDjIJKrv82Leuo4xExF9LLjomqrJZLM+XhnZ0Cok=;
        b=4X2D6aiB66BmYsMtpuLTeAILvSfsX9R5MRULj7EObofXU0kJLD4xsTCPashG2R07mI
         SL7cxU0/9yFFR66fxSqojrnB/buey8OjWyxUpGPiFJLEyhv5jyGZQYd+0T+rCcvqdXn7
         CX6laK7pHX081pWMCl5YNjSjftuNdu/5ktDonskq8zmArWr9jltACjbYy+coiYci76n/
         dXfcIFgLq1etL7una225JO26u7V6CykJ/rCJwhDhnd7kCPTuOw8fy1XYs4sGymt4u2wu
         klwvZm2hf7XFv4q7DNTLwYtTzFYcg0x6/65GIIZovXQ+Ry983NfHVtfwLckmbjtVuilt
         YEDg==
X-Gm-Message-State: AOAM5311Igj+iSXF18sK0TBeHAFlEdWlJzS3fIVAyKvW5fnehqhLxASS
        uL22HMAHTg4pB5crGFnc1PwHQzf6B2zzgXtGbj8Px0qpUXh3GFccM4z6Uw==
X-Google-Smtp-Source: ABdhPJz6w7VSmcEF07HyZQVgRd/z2Y9RhAQYbPkyuJ1uYCyX0Vmpdgr6puZ7Q28gkRf4/TNZ16AhRoD0HAGhI+LJNuY=
X-Received: by 2002:a81:42:: with SMTP id 63mr1192592ywa.267.1644014025243;
 Fri, 04 Feb 2022 14:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20220204154730.166194-1-johan.almbladh@anyfinetworks.com> <d7494a948df4fddd6a5ae783558d31bce115f0ff.camel@sipsolutions.net>
In-Reply-To: <d7494a948df4fddd6a5ae783558d31bce115f0ff.camel@sipsolutions.net>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Fri, 4 Feb 2022 23:33:34 +0100
Message-ID: <CAM1=_QQL2D9WtC41NdRYYDeoWC_FRVr3xY_Yi6GdDR=6Bks4zg@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7915: fix injected MPDU transmission to not use
 HW A-MSDU
To:     Johannes Berg <johannes@sipsolutions.net>, nbd@nbd.name
Cc:     lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Feb 4, 2022 at 10:46 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2022-02-04 at 16:47 +0100, Johan Almbladh wrote:
> >
> > diff --git a/mt7915/mac.c b/mt7915/mac.c
> > index 08ee78f6..1848fa16 100644
> > --- a/mt7915/mac.c
>
> You should probably resend that with a full path.

Will do.

May I ask what tree is expected for mt76 patches? The kernel
MAINTAINERS file says nothing about it.

Johan
