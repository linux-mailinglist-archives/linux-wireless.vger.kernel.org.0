Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EFD24860B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgHRN3S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 09:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHRN3P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 09:29:15 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58433C061389
        for <linux-wireless@vger.kernel.org>; Tue, 18 Aug 2020 06:29:15 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i6so15240328edy.5
        for <linux-wireless@vger.kernel.org>; Tue, 18 Aug 2020 06:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/8JqP5xraEKSHHZGoDj+vjF99sYDGHUefoYyYGCBL8=;
        b=TgKHac/hasJ9rRL7NVm7GUOX0yWpzbcbqg+Q2tIbgFUUyT3rmF/ArPwTBEiG/ILvXE
         9Q7yt0xNjb1NEyl9sod+8MXgeD3AXd9WR9Jo566zf2KROBWqR+cTR8o7wgjOxJa0gZwD
         Pyow0bdED4Lq9YHy6fPRjl/mzrdbfazZV/6BonwZYBhfMMI++QufUWgbg58RdqVqTYHA
         NyXAIfemW6nht6l1cuza8r1Jbk0gL/IFIK6AEpLK6FfNnQYPleHuf8kArdqijEg+HrdQ
         vFvBR2o7yF9q0EbmqeTmDO71hIh9JgI2O8ESOsMcvLxdEJVo1ZfGO3Dd/rZVFs3ErJ2Y
         ENYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/8JqP5xraEKSHHZGoDj+vjF99sYDGHUefoYyYGCBL8=;
        b=I2hqAdF/O70PdbV+6lT/rqAFWfrhzwuLWRl77oniJuzxulJu2z4pqXyqRyfwryEO5d
         DmTzG1Z3sxkblGYsNY2rRwS7rqtzjhu1X9ZyojV1FotooYzxEDIYfnhEvXinV1lbfetO
         +WbeFT8I0EuCeVt8v7aBXlXYn2tdrwPij4BJ0al+MwX3P1IGv0RrGl+DzWTrDI5S3/TX
         flVs4i0Jin7ZOasSX6zMFflXkStoTVMPTWF+5grp8+rz7fgam6GsAJZki8Hn7W8z9VH/
         3jF4hDO+IZ0rcwH8t1QS7jjmL+g7fBUxOUTDPZaVGi/kgIzmyFH3lvcdwgXL7HOCOWEY
         LtzA==
X-Gm-Message-State: AOAM532f2PVeSEwnQRBT1Zqb2PccsKBM6uIdeOi0Dh9w4Pu9sUYulvmP
        vbwa11SFFVINLAeVVBnlS9wZiXXOfdDzQG/tH5uniEhL8Ug=
X-Google-Smtp-Source: ABdhPJzfz8AouqqovFEWWTAYuKWH7TGLPeSyYIEKyNBMKZKt8Q/GAjahqiSrVTwJUsagTW/5TmUScE+mzaiafArCOWo=
X-Received: by 2002:aa7:d983:: with SMTP id u3mr20556861eds.366.1597757353833;
 Tue, 18 Aug 2020 06:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <1597680075-18723-1-git-send-email-loic.poulain@linaro.org> <87pn7ojx8g.fsf@codeaurora.org>
In-Reply-To: <87pn7ojx8g.fsf@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 18 Aug 2020 15:34:16 +0200
Message-ID: <CAMZdPi9sQ2BM4G2cSKNfE06fOtvOtgb+ELqAkxUJdtLbuoeYzQ@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: Fix software-driven scan
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 18 Aug 2020 at 08:15, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Loic Poulain <loic.poulain@linaro.org> writes:
>
> > For software-driven scan, rely on mac80211 software scan instead
> > of internal driver implementation. The internal implementation
> > cause connection trouble since it keep the antenna busy during
> > the entire scan duration, moreover it's only a passive scanning
> > (no probe request). Therefore, let mac80211 manages sw scan.
> >
> > Note: we fallback to software scan if firmware does not report
> > scan offload support or if we need to scan the 5Ghz band (currently
> > not supported by the offload scan...).
> >
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>
> What changed since v2? Please always include a changelog so that I don't
> need to guess what you have changed in the patch. No need to resend, a
> reply is enough.

Yes sorry, this patch has been rebased on ath master and squashed with
Bryan's fix:
     wcn36xx: Set sw-scan chan to 0 when not associated
No additional changes have been made on top of the initial patches.

Regards,
Loic
