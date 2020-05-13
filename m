Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7161F1D1E77
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390396AbgEMTDE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 15:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390021AbgEMTDD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 15:03:03 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D27AC061A0C
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 12:03:03 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u6so784991ljl.6
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 12:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Chzp3tbyXEmpa9DZODCBT8j/RcyA+WHDHn8SKIYvqlo=;
        b=JugjIFo8e41xcj1mBh50Kv4JJdwWswQdosSkw2SGo25NkR8diJgzxmSmAimUoPFy0g
         UqtufzWVyYpztDyGgk4HCi22Aw09xlnezrYm4PHhCJi+H8Ei8/tmkqX+byilYh/qSlsZ
         kQ2oFBqHEcL+58tiDWHOiXYpFBIpD7JYaeHj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Chzp3tbyXEmpa9DZODCBT8j/RcyA+WHDHn8SKIYvqlo=;
        b=QBWZrAU7P12Q3Rz+hnUMgcE/9T8OjCM6/iOEnRY+2xuoMwcgOX0Z0J3YTEYJeAr6Cj
         dCMS537o2iaNVSMNKam9LCj6NDIGdwtH8nFJ57KWbvVSoJzZIEsOJ/lw5eAc6pBt2EKi
         C2BpQdJrNOYv1l9sMzzTSsRhhelld+oePhcJkpDFCrGFk7maKbx2zclnkbH1yOSvwcZd
         VQgjngd3ti1UteUGpiiQx1zcR+G72rJDIGqzREZRqVCz/ARlIcLSrqPrEATuL8qQwA+i
         a9i+T/lIxxuOcEW+c8sZyS7hKR5vlfK6NDtUoAic0Xc6ZtsHRMwnpFblzjt6P/bxhuV0
         jPCQ==
X-Gm-Message-State: AOAM53195Ps8nFoENDcc1IpqUnercv4zczpzMm9HBMq3b+FarslESUrG
        2mFPf5ZQkCf07xSCEu5eNgSxWPVVxzM=
X-Google-Smtp-Source: ABdhPJw3/GaeW8nY+PkU4mrSNHtNQzdgl3HdqXYMA9ENA5qPnm59QXs3AkJgNghJ5vH4rE+W6gk/PA==
X-Received: by 2002:a2e:81d1:: with SMTP id s17mr323454ljg.91.1589396581801;
        Wed, 13 May 2020 12:03:01 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y8sm180925ljh.83.2020.05.13.12.03.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:03:00 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id u4so445000lfm.7
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 12:03:00 -0700 (PDT)
X-Received: by 2002:a19:ccce:: with SMTP id c197mr619201lfg.59.1589396579890;
 Wed, 13 May 2020 12:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190906185931.19288-1-navid.emamdoost@gmail.com>
 <CA+ASDXMnp-GTkrT7B5O+dtopJUmGBay=Tn=-nf1LW1MtaVOr+w@mail.gmail.com> <878shwtiw3.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <878shwtiw3.fsf@kamboji.qca.qualcomm.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 13 May 2020 12:02:48 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOgechejxzN4-xPcuTW-Ra7z9Z6EeiQ4wMrEowZc-p+uA@mail.gmail.com>
Message-ID: <CA+ASDXOgechejxzN4-xPcuTW-Ra7z9Z6EeiQ4wMrEowZc-p+uA@mail.gmail.com>
Subject: Re: [PATCH] ath9k: release allocated buffer if timed out
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 12:05 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> Actually it's already reverted in -next, nobody just realised that it's
> a regression from commit 728c1e2a05e4:
>
> ced21a4c726b ath9k: Fix use-after-free Read in htc_connect_service

Nice.

> v5.8-rc1 should be the first release having the fix.

So I guess we have to wait until 5.8-rc1 (when this lands in mainline)
to send this manually to stable@vger.kernel.org?

Brian
