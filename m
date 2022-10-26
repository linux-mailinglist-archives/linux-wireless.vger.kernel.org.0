Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF5B60DC8F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Oct 2022 09:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiJZHw5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 03:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiJZHw4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 03:52:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5699B72EE1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 00:52:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x2so12873887edd.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H0pXDkr8BhWuSRbn+U4cGpySXMm0X5XzRPdb1+ze0UI=;
        b=ysNEiNxSBNApvffAHHOuO/eLyhjgNAk6LoDjFG4pZg841xspBM6xBJuT+ZdIO8jCJk
         mzUS4EizDacexZPQ6dZsTclm8ndwV75C4cO4mPS1p7TvEg3A+K2sNYgV2c3c5tBWPHjm
         uGQK2Raw3ytixExP8b7Y/nOidOrSVtOeYxQ4KeIod4F2YkjHe87vtoztRLqD9ka+F/lI
         NyMRQ4AtrJqNU1+SqzHplhGy7M7TYnuYl/x+85EH8IbAvzpot+oJ1Y26EGQSLfqneLFC
         QISOjFEY/K0lwgSsLfUNnQDQ4ILdV/5EH3bDhTburYV0TIvhSRR591xI2J2u3awNV7RZ
         t4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0pXDkr8BhWuSRbn+U4cGpySXMm0X5XzRPdb1+ze0UI=;
        b=tQ0SD3doDgxw59HoSHKeZn6CxJpDilSMk1NBRs6kHhxqy/lii7x4I4rbJuxgeRjr/I
         tzLnWXYrcjqtDVpB8OjIQco6cEaybvCQKUM5JsyIqp35NI69ghbc2W8jZUhi9ZzUEH3W
         8Se3EKA+WvFkigoZsUEcFj70D+w0GiawO16oMg1EnbUR9E5IqK8xnHDNlVUZH5CEShoS
         iAxXqw0gw7sUMJspRPs2wZdOwmez3vTd/zRGnIPtUA+Gjn8PBRRFwTszq9b31dn0+uAg
         4Gmh403wFXTDvhqlTzLBZVxMwNgi2hlk1Xjznd6MU+bh0pmXwR+odd74B1mNTV0IT5+y
         M8Ug==
X-Gm-Message-State: ACrzQf1jZMHsTSgnclU9uaHRZ2w2NaH3bhv8vGgDCUq/5487FQr2/PWX
        wyYGzAc4tFsI/3ltdHaKY/DF/6N7Sp6ylejvyKeHOA==
X-Google-Smtp-Source: AMsMyM4esl6Z6DPDzYZB12DjzU8xJpOyAu80URHioxerGWeLfWa7dyApBy5IUjqjg+fMQWivyFKYc9TXJT/Aa0wiMAw=
X-Received: by 2002:a05:6402:1d55:b0:45f:c87f:c753 with SMTP id
 dz21-20020a0564021d5500b0045fc87fc753mr31887330edb.32.1666770773908; Wed, 26
 Oct 2022 00:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221024124002.10120-1-linus.walleij@linaro.org>
 <1840a6374e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <87wn8ny8b0.fsf@kernel.org>
In-Reply-To: <87wn8ny8b0.fsf@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Oct 2022 09:52:42 +0200
Message-ID: <CACRpkdbdziYcMpBij22ryTvAX776ShXFkzD1_WfXq5fUiwVSVQ@mail.gmail.com>
Subject: Re: [PATCH] brcm80211: brcmsmac: Drop BMCMA consistency check
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 25, 2022 at 10:09 PM Kalle Valo <kvalo@kernel.org> wrote:

> Arend Van Spriel <arend.vanspriel@broadcom.com> writes:
>
> > On October 24, 2022 2:40:08 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> >> The driver looks up the BCMA parent GPIO driver and checks that
> >> this succeeds, but then it goes on to use the deprecated GPIO
> >> call gpio_is_valid() to check the consistency of the .base
> >> member of the BCMA GPIO struct. Surely this belongs in the
> >> BCMA driver: we cannot have all drivers performing cosistency
> >
> > Should be: consistency
> >
> >>
> >> checks on the internals of things they are passed.
> >
> > Apart from the typo in the subject and missing wifi: prefix (replace
> > 'brcm80211' by 'wifi')...
>
> I can fix those.

I am sending a combined patch with this and the other bcma patch
because they happen to depend on each other. Dunno how to tag
a patch that affects bcma and brcn80211 at the same time so you
will probably have to edit it anyway.

Yours,
Linus Walleij
