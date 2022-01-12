Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD08848C69F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 15:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354386AbiALO7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 09:59:16 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:34321 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347865AbiALO7N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 09:59:13 -0500
Received: by mail-lf1-f45.google.com with SMTP id o12so9184051lfk.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 06:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYAuM8HOGDeRUC7Hqp0NyJ455lxW9JhY9xMLbL7qB30=;
        b=pCfbX5k7r7thvTFp62Kn3JoTZeSmwrEuNSx5P8y0XFS1Re1yuXz2lhOOZ/kUXzCAoG
         07Lf+lNNjNuAAR7aYlO9U921CHP2imKbwJ432qK3WcYkcYo8RrZ0RXMTMbC/KX8I8jDD
         XuOABdVDq03XiufVyyMDn0xpHiL+Bf9SUBKLRRgKaIWwmZm/xFqo24zOd3jhtJe68bsn
         LiM9y3D1udnrLNTsMVbq9CJ8Kutt2PAFDauwdWiBN4ADWcpWgJ0ZQSWRGJ3quXtTtV0b
         2IGrZV665iF+Bz/LlEj6rhtW3jNoT7qw8zQEo0GNgezrpXT2MLa1oWYGUQTdZl2NVyg/
         mVAA==
X-Gm-Message-State: AOAM533zaR1PSDSVVfOiyRLWnU5VsOIxGE/4BcOEKiFxhIpI6WMWOKZN
        ShZLjNJECJo8sR9uEDtLhwNv2OkQXPfxxsq1jmNYMAbz3rI=
X-Google-Smtp-Source: ABdhPJykJV73ooVRV6H4SYycYK3IL4npfyQagdaAUr9f3lKKOu8NDIcR2LjqWV/vvTocb7z8QqoiiUiU/JqXXS/e+2k=
X-Received: by 2002:a05:6512:c0c:: with SMTP id z12mr114206lfu.48.1641999551045;
 Wed, 12 Jan 2022 06:59:11 -0800 (PST)
MIME-Version: 1.0
References: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
 <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net> <4c1089474bb5982aee82d58a9d300ca55e7e0c69.camel@intel.com>
In-Reply-To: <4c1089474bb5982aee82d58a9d300ca55e7e0c69.camel@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 12 Jan 2022 09:58:59 -0500
Message-ID: <CAJvTdKmXuzwhV+ExqPAAUTgOFk1dnU+CjnErgUgdfXp=vug_EQ@mail.gmail.com>
Subject: Re: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting 0x2000000.
To:     "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jan 12, 2022 at 4:05 AM Coelho, Luciano
<luciano.coelho@intel.com> wrote:

> There was some refactoring in this area, to move the initialization to
> the init phase, and that must be causing this.  I suspect this patch:
>
> commit 78a19d5285d93e281b40c3b8d5a959fbbd2fe006
> Author:     Miri Korenblit <miriam.rachel.korenblit@intel.com>
> AuthorDate: Thu Aug 5 14:21:56 2021 +0300
> Commit:     Luca Coelho <luciano.coelho@intel.com>
> CommitDate: Thu Aug 26 23:36:10 2021 +0300
>
>     iwlwifi: mvm: Read the PPAG and SAR tables at INIT stage
>
> ...which was introduced in v5.15.

good guess!
I have confirmed that upstream 5.14 works, and that 5.15 with the
commit above reverted works.
