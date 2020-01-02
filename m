Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A469612E1D8
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2020 04:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgABDKZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jan 2020 22:10:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36800 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgABDKZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jan 2020 22:10:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id 19so42744967otz.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jan 2020 19:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIasqch99l8yTjEyV8QMiDGU+MfzGAS5V5xiGOoV6rI=;
        b=LWWLqL07KXfRCjBMo4n2mLxcE6WGIvBK4CO1fwS3Ri1nL6MgoXiXo50j5uikJPxEc4
         Els0i37FJZp4kgBIkn3fCzkWf8pHB1W/rg663kA5m90lV0lFl7pibDXQ524xTyWj8UDu
         pdmNf0mfmxoNukWXwuJ8HyTSy0wwoxgo/D3iaU9iESjj4R0Zb6dliz8oovimqRFhf2io
         d6ylHDKyevccpU94rqT9PfTJCk3CWU4r0yWAQudgA8A0+q/2fLmqe+TE9NwxC6Sy/Hqv
         o2pm6ZosDABXi+WfiMBOL7VmmrHrMuajL5gn4TEUsUA7mg6PGxcGqshJng67fxNI4689
         HGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIasqch99l8yTjEyV8QMiDGU+MfzGAS5V5xiGOoV6rI=;
        b=Lyk41gAuMm0OQ1oTcz4Jdz4N6N3nk4yMWmw4azawcoy+2k8Q2huamlLcFoXSSn8FLD
         wcsdC1lytTSozyCfO8MmEWjH/JMn8VZtKlm7rVCg/Xj6R/cNl7lwX/PlDSrDctdtIODE
         XBhqv10qwGWxW45w+GrC6RAqQfR8JGiWQP5FB/tU3Fewup94MyJ7i+7Oq5wWOOfAZ1I9
         Hl0jWfOM9ya37yEP6t5OIeEPUIoL3A2Tcd6daoleITc0YO7YMhaNrMQO9PALy1a3FHDe
         YBgpTTLhP9c+wEO3FLfK/AsIz+c53AKQR3XORyh30TVLTGIQT+2EJUufIJRzwq8FAWPD
         jxNw==
X-Gm-Message-State: APjAAAWtKDS4nBer8kgwZQ9IKq9IomflxxL02ie8mLtEfuXXcec4Ep2H
        DGWjWBj93XKwE3hD4Flcfx8FSM0nTEKL1h5lgHw=
X-Google-Smtp-Source: APXvYqz7UCTyYhrUAl4Ky4z7wXUXiP6hfcnFLVD07rtvwHDPSOl0LFsKbDU7QilW1KZ/Sqcclmz+SwQlMakS8c4zOd0=
X-Received: by 2002:a05:6830:1515:: with SMTP id k21mr73047367otp.177.1577934624441;
 Wed, 01 Jan 2020 19:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20191225120002.11163-1-wgong@codeaurora.org> <20191225120002.11163-2-wgong@codeaurora.org>
 <CAMrEMU-p3+HRZYW6TzXwZSwhxj9oJ9JW1Rg=ZysJ3fr0rm45Ng@mail.gmail.com> <5f6eb95de0f877b86b90d0c32d458d43@codeaurora.org>
In-Reply-To: <5f6eb95de0f877b86b90d0c32d458d43@codeaurora.org>
From:   Justin Capella <justincapella@gmail.com>
Date:   Wed, 1 Jan 2020 19:10:13 -0800
Message-ID: <CAMrEMU_eLfD6=7esrYJA4GnU=CcWgBey1QZL+-=RVoRUUcfZKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ath10k: add refcount for ath10k_core_restart
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of the atomic restart count, can the state be updated to
ATH10K_STATE_RESTARTING while holding
     mutex_unlock(&ar->conf_mutex);

I don't understand the bundles, but I wonder about the case when there
are multiple packets (n_rx_pkts) and if pkt_bundle_len might be the
one to check. Also if there needs to be a check that the len > sizeof
HTC HDR.

On Tue, Dec 31, 2019 at 1:37 AM <wgong@codeaurora.org> wrote:
>
> On 2019-12-25 23:14, Justin Capella wrote:
> > This does not only effect SDIO.
> >
> > Why a semaphore / count? Could the conf_mutex be held earlier, or
> > perhaps change the state to ATH10K_STATE_RESTARTING first?
> > ath10k_reconfig_complete is also called in mac.c when channel is
> > changed so
> patch v2:
> https://patchwork.kernel.org/patch/11313853/
> https://patchwork.kernel.org/patch/11313859/
