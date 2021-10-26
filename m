Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C6F43BBE4
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 22:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbhJZU5p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 16:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhJZU5o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 16:57:44 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F562C061570
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 13:55:20 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso524129otl.4
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 13:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yj8mugfCN9prV9vUEpfRDNEwqbFxyPg3l8N+4KJJ/8c=;
        b=hpcmsn/8pkc3429dzxHpOZQeRzA9KoGHkCH4lhOFWUG/qHTUw2EFldJf5rLs2OIsto
         pryv3k3TeyaBC/hQiGIyzmtCBm0BPB3x0ZA6ir7M9tXIphoWECXiEpc1Ei/C3S4aE7wN
         bxl+2iTNYUuWl5tPgh4BPP6TaBVhHJKY9zbRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yj8mugfCN9prV9vUEpfRDNEwqbFxyPg3l8N+4KJJ/8c=;
        b=KO7JjMVbdtbwxFcU4dQFYfwJKkCP+q76fQArZoXRowTyNcxstEpqg+3KmlQaO72rDf
         LwrbonmJv8Zuoh+LhcQEb1PZ5IDZcwPfdm8C2ScgcVjc2Wit6YsTwiMIIJyHLhEOmKeD
         QXAfg2f5nQySTkzKMdSMaRntW203XOcg1XQJ0DD62J+M0pdmvzEEsQYCWhSOFA/M5lrL
         NwBhMu/457Ix2EcsU/xU0HhpKvZqNswsuRgKUktjwNMHuzCWLoYc1D9tKSfbsiDKSnCT
         sjQdrDzrRVRVW3Z+NQM2vFFQJei0bDJ0WuFHdE5a5AZtax0wehdijMpy1gAC6xW8yUlx
         wDOg==
X-Gm-Message-State: AOAM5304mr4Nrq0HPqeaJMSi9i1ovFYp7Cj+braqFsc76lLCdYpUTPzi
        X62L/QUonzQRM0R6XhDpZ1lZIhHtcQxzig==
X-Google-Smtp-Source: ABdhPJxHqREIhDxyyejsPL6tEpaqF3Nzg+Ogly4h/sKJCB+MJ2ncsf0svcghKsqLOmkgO8LgiBdaKw==
X-Received: by 2002:a9d:63ca:: with SMTP id e10mr21717615otl.175.1635281719179;
        Tue, 26 Oct 2021 13:55:19 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id k26sm722312otp.42.2021.10.26.13.55.18
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 13:55:18 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id t4so440408oie.5
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 13:55:18 -0700 (PDT)
X-Received: by 2002:a05:6808:30a2:: with SMTP id bl34mr814574oib.77.1635281717770;
 Tue, 26 Oct 2021 13:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <YXKXf1cBjPWqD1Aw@elm.arvanta.net>
In-Reply-To: <YXKXf1cBjPWqD1Aw@elm.arvanta.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Oct 2021 13:55:06 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPExGHnDdZwvMGbZTTYB76Psy2JMTH7RTnvO1Zggh6c_w@mail.gmail.com>
Message-ID: <CA+ASDXPExGHnDdZwvMGbZTTYB76Psy2JMTH7RTnvO1Zggh6c_w@mail.gmail.com>
Subject: Re: [BUG] mwifiex sdio wifi crashes on samsung peach pi chromebook
To:     =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>
Cc:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Fri, Oct 22, 2021 at 4:20 AM Milan P. Stani=C4=87 <mps@arvanta.net> wrot=
e:
> On my chromebook samsung peach pi (exynos-5800) wifi driver stops to
> work at random time, sometimes after few hours and sometimes after day
> or two.

I don't have official recommendations, nor HW to test at the moment,
but for the record, Peach Pi should have Marvell SD 8797. You can see
what firmware Chrome OS used to ship for those devices here:

https://chromium.googlesource.com/chromiumos/third_party/marvell/+/HEAD/sd8=
797_uapsta.bin
https://chromium.googlesource.com/chromiumos/third_party/marvell/+log/HEAD/=
sd8797_uapsta.bin

Notably, the versioning there (e.g., W14-66-27-p18) suggests it's a
different branch (?) than what's currently provided in the main
linux-firmware (W14.68.29.p59). So you might give a try at replacing
the file in /lib/firmware/mrvl/. No guarantees though.

> kernel is mainline 5.14.4 without patches, but I recall that I noticed
> this crashes on older ones but can't remember exact version.

Did it ever work well? I'm curious if this was a kernel regression, or
perhaps just a long-standing firmware issue.

Brian
