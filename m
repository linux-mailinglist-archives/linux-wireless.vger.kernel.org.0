Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAB3432462
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhJRRFP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 13:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhJRRFP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 13:05:15 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E13C061745
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 10:03:03 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id u5-20020a4ab5c5000000b002b6a2a05065so180730ooo.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vapiWb/xC/HRW5SVd0n9p5J20MNFCuAe3IsWE2MHhPY=;
        b=GqTp8rvXsmRgSRBgRe45CQVjz1yaUBVMoi36eb0mCXIkj3yNFhYbNyiHrgcQHnI0T7
         XubLveOeE7PZHLsJ+FyA3yQApHPHEy7QrG28bHcN2hx4Sz5FadDjXLdj4Df8+1/6iELu
         F06NmOHAYROdHylmOCvNQx/QGAP0exqVpShEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vapiWb/xC/HRW5SVd0n9p5J20MNFCuAe3IsWE2MHhPY=;
        b=aEGdcGm0jWlXnS0bVdirtU07BmUWl7Fgl2+CZF0nu3SxbFJ20em2u5laDJF/KHZSja
         QrFNsdBmXZdsTcQTXux3Jd0IJkX5yvYB6TUodTfD/3ejGh+ADeuHCK1UJxfUiNFts3wJ
         NALxPAhPbgQLMtF7WERHHW02HQ78L2ha39JuCg3jcwwSShJiZ2ZvTbaOihrkMWi5dFdr
         poEOcGcXbIb8315a8A32vLqIvMGoLMtUtK5mAgVxsaKnFlv+wY8BLJwEzIw8fi4o5LdI
         TUjdBI60qqo2bgvqzrvRKhe8FWzSiZylXRgl2NXn8HF4mdqq+xMmJ56jBMJR8UpjwJ7v
         eIXQ==
X-Gm-Message-State: AOAM533QoaAHhl4OgM98Nfg1Zto5SAMgr1Umbw81XoIJik0wgQiVt5AM
        Q/cCGhoQ7+mi/APjH9Mob12JM29IgbjKLQ==
X-Google-Smtp-Source: ABdhPJwjrkFBaj6DE09oDe3ZbTkweKpYdBknP875MWXdmsh5vfwhQR0X+ibpoAX0s3FjxivjFVAucg==
X-Received: by 2002:a4a:a38d:: with SMTP id s13mr771705ool.60.1634576581326;
        Mon, 18 Oct 2021 10:03:01 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id 3sm3135203oif.12.2021.10.18.10.02.59
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 10:03:00 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id y207so642723oia.11
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 10:02:59 -0700 (PDT)
X-Received: by 2002:a05:6808:30a2:: with SMTP id bl34mr36459oib.77.1634576579273;
 Mon, 18 Oct 2021 10:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211018063818.1895774-1-wanghai38@huawei.com> <163456107685.11105.13969946027999768773.kvalo@codeaurora.org>
In-Reply-To: <163456107685.11105.13969946027999768773.kvalo@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 18 Oct 2021 10:02:47 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMQhjOCwjVUcstx3GoZeqsFJ4e_6FCFos6Kqb34N66axg@mail.gmail.com>
Message-ID: <CA+ASDXMQhjOCwjVUcstx3GoZeqsFJ4e_6FCFos6Kqb34N66axg@mail.gmail.com>
Subject: Re: [PATCH net] mwifiex: Fix possible memleak in probe and disconnect
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Wang Hai <wanghai38@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, shenyang39@huawei.com,
        marcelo@kvack.org, linville@tuxdriver.com, luisca@cozybit.com,
        libertas-dev@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 18, 2021 at 5:45 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> mwifiex patches are applied to wireless-drivers, not to the net tree. Please be
> careful how you mark your patches.

Also, the driver being patched is "libertas" (a different Marvell
driver), not "mwifiex" -- so the subject line is doubly wrong.

Brian
