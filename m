Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF99254E178
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jun 2022 15:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376782AbiFPNIQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jun 2022 09:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376754AbiFPNIP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jun 2022 09:08:15 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2332228F
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jun 2022 06:08:14 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id w2so2085972ybi.7
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jun 2022 06:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aM7W+IbTZllbP9bwce2OF7b7/jySkDE1I5FfH7XqgI8=;
        b=UTLscLa01r4NO1+RKlggp8DofMmfPmN4Lzkv0wYG/b2NhhS5SvPkgr8eEGMEF0mA6A
         G9++dkrA4kLgQj3DYQ5drnMY2r8f5JCd3JP0odAnSldrWIVm9RzLfK7Kp1LXRtxgZNAQ
         AetaZIC5JTDM9ey+zcceqkQmKyQfbXrdgk+q00+yoLhu1W9DbB3BVTXN3qjvBpNDG0cQ
         sON6MwzCZVdRx3Amg0Xnf0SpnJQLEWg9zMpR6A65BCErCoSpJ7kY3j/uD25nATZnCJR+
         VOMAUlWh5q1aN9SvTQwsBoRu9jy2QB0enXth95XdWSWfAq6jHa4M1oMpOcHUgVn8AaXG
         o7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aM7W+IbTZllbP9bwce2OF7b7/jySkDE1I5FfH7XqgI8=;
        b=eNdhVUYLWjnGZKHZALCn0G/KFMtueT9XkhNh5C+DSrA04ShIvlxb686riWTmBmnxis
         k7+ZfquXNU4g5AwnKRQw+FkYEBmxNjoDHGB7IIEfcJg45w+sojrRZQKiOcY6f+fTNTmZ
         CchseEwvcxTugYFfi/4LgqXYe9+7Uuvo5od/nmfy+PifLbSu9CD8vp42biFm35DCyIEM
         TuOomfbr+fMy5KdrCdrPBefuMCbD1VQuOL8Jz/GFkd1rMOkJwx1DI8JgLQpbFMp9u28N
         y38So5MyQq0ByD3D8AmlxZhDNQ0gh709YVOy0RGmaKnf95WcJ+gOCP4/VaPEE4kq380k
         Av4Q==
X-Gm-Message-State: AJIora9vks5C3a/YpzGu3MxZEmaPNKpXCp0pKqjpKp/q7zUBmfrg/dF0
        xU+PYxAktZO4AO6c2xckLiNq7Qcsf7TPyPcHmzvAQA==
X-Google-Smtp-Source: AGRyM1sBxZbJmj9a876qlle2c/oXPEieXxih42drJWPUKceAzphyazmenHwI16MLVIVXYgZ0/mh2wxhlduQHve8rsUM=
X-Received: by 2002:a25:8387:0:b0:664:7589:27b9 with SMTP id
 t7-20020a258387000000b00664758927b9mr5242155ybk.291.1655384893665; Thu, 16
 Jun 2022 06:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <YqrhsKcjEA7B2pC4@kili>
In-Reply-To: <YqrhsKcjEA7B2pC4@kili>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jun 2022 15:08:02 +0200
Message-ID: <CACRpkdYpzGJ7Q4jp4R_cozRVfQBnY2vnEmDbChKLQYUBWjiz5A@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: use strreplace() in brcmf_of_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, Len Baker <len.baker@gmx.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 16, 2022 at 9:54 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The for loop in brcmf_of_probe() would ideally end with something like
> "i <= strlen(board_type)" instead of "i < board_type[i]".  But
> fortunately, the two are equivalent.
>
> Anyway, it's simpler to use strreplace() instead.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
