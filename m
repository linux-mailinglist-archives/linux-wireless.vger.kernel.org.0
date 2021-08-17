Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146E03EF1D6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 20:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhHQS25 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 14:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhHQS24 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 14:28:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BB9C061764
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 11:28:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bo18so570485pjb.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OHvEnRLjEptuXUny5W4npQ32FfB7O0orXAKt62vh8N8=;
        b=kb1GGIfC2AwwPHWIg2EYbOMqnZrAq0UN9UsBtZXo9d58E+f0KHUr4+G4eicSMPELGG
         PZomt7Ks/3ZcNYm1xtNv6/J+8LeC0HijyDPkrQDDkYY74B7XC5k2s25THt1D0T8Rum6z
         fw7JqCECPjZedbWG7TC47k3t0sPvyU1kw87sbzAonHyHXyNfdlyjrRmcn6DM7H+LmPBx
         9mcl5TorbTq2GN9ajA+4VdiZY+RAzskCyw8b9gCxqY12785/b8WHAglf0NDsZntVNcFq
         BvHTEfmr1kco0dbuIv6r/BSQNnuIGMEaHh79LaOO7I9RqVYo9T9UdM+H8JqDU3CMoHUV
         tuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OHvEnRLjEptuXUny5W4npQ32FfB7O0orXAKt62vh8N8=;
        b=QJt0UIy1c/z/5XuUs5yUHv1FbaZyifk5Pm9UAdHu3PbqGe1ZErhoejHKZy/U+D4TFR
         sEKlwfVgYiZ/Y3yh9eJ+ml6cPiwTLkQqMXBkZKTBwrS5zbB1goj0diKO4slmCl/Bt8y9
         XKYoypv4CoGtzYcZAL0r64YPJu6XHeJSBYutR5ybd5fT7z70d2kHHbmtCAON0NXz4iGB
         4IzDtrCdxVzITED2YRGXfSANiUhFkVWZlqKlnHN8/KjKUNPkoN+sJrg83X7EddUpX057
         HGOp1sxrwDPOlFqTZy9FsdJldjwbrlcY8OkhcdkknUk7jOqKLQ2G1AeFtrgjetD1GyNf
         8UXg==
X-Gm-Message-State: AOAM53304ypbjN/gDe6tuFOM8kyIge+ytweWe8iSGCydicPDrhgKfOwW
        sydh07hkhUNgAdt3hh/Wow8=
X-Google-Smtp-Source: ABdhPJwmzUMaCwXYicrFH4VwP7h05OQCtQNqSXX9DS1SQlsWFWV0f4BXtsmh4+YD36t+84rr3Qp/cA==
X-Received: by 2002:a62:ee16:0:b029:2fe:ffcf:775a with SMTP id e22-20020a62ee160000b02902feffcf775amr4775601pfi.59.1629224902831;
        Tue, 17 Aug 2021 11:28:22 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id p17sm3383296pfh.33.2021.08.17.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:28:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 17 Aug 2021 08:28:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        SHA-cyfmac-dev-list@infineon.com,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH] brcmfmac: Set SDIO workqueue as WQ_HIGHPRI
Message-ID: <YRv/xUlC5sIMbCxI@slm.duckdns.org>
References: <20210802170904.3116223-1-sean.anderson@seco.com>
 <e6eb89af-b81e-b96e-70a6-c9498eb681fd@seco.com>
 <17b551dc6e0.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
 <c5bba530-1002-a3fa-322a-1045bf7ee4c2@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5bba530-1002-a3fa-322a-1045bf7ee4c2@seco.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

On Tue, Aug 17, 2021 at 02:21:55PM -0400, Sean Anderson wrote:
> > While I understand the obvious gain it seems like a wrong move to me. What if all workqueues in the kernel would start using this flag? I bet the gain above would be negated and all are equal in the eyes of .. the kernel
> 
> Is there an official policy on what counts as high-priority? Using some
> very-scientific methodology [1], it seems like most high-priority
> workqueues are in drivers/net and fs. Making these queues high-priority
> seems to be commonplace. For example, in fe101716c7c9 ("rtw88: replace
> tx tasklet with work queue"), Po-Hao Huang remarks:

I think this is actually a good candidate for HIGHPRI. As you noted, stuff
which interacts with hardware in latency sensitive manner with impact on
observable performance is one of the common use cases. The alternatives
would be doing it from hard/softirqs which are higher priorities anyway.

Thanks.

-- 
tejun
