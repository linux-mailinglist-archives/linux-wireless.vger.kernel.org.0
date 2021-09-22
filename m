Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48769415346
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 00:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbhIVWVk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Sep 2021 18:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238243AbhIVWVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Sep 2021 18:21:39 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576E7C06175F
        for <linux-wireless@vger.kernel.org>; Wed, 22 Sep 2021 15:20:09 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso5731617ota.8
        for <linux-wireless@vger.kernel.org>; Wed, 22 Sep 2021 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=W1rGCIVVi5108Q/9A0D4D81PogphtnHZcZGcFwI/n8c=;
        b=lZ4jjQH4J53Sq0uWmOts31WHzdVOUeHYBNZoeXCSt/k2qPrrnZTnHDbYNMBlz8l4Qq
         Unjn4X6mERv1brEkuIx2MTq8Jcgf4Snag6St/qVIUgqGuOWTxjZ0amqF3P1smySdlYGV
         kH72kD8YBInkfTk5jrxD/6aKPnltlPHQyj2hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=W1rGCIVVi5108Q/9A0D4D81PogphtnHZcZGcFwI/n8c=;
        b=akWU4id0K47Bgc91nMT79p7llFghKiVgohbc5kI7bal4KttsY2yhXrvaTQuga2YxLg
         BRap5Zh2eTxfsu+7UwcJ5xGvOVzGqYVz/+MBc/8qJhTchjj07SqH4Ow7tCz2oRrG91RH
         P/g6QD6/mA9AAj0LJJ3w5jOgq6ASuL5rwx3d6DKvEmWivA1l22lh8Temen9oNyu7MpGV
         u04HZ6b9fWif2k3huh8mJhY6+ucVjvNXuPIP86naEPKhGUd9bTUIhNRoKoLEl4o4/8sT
         Aoya8E96+mhVZqM3doIyx0IDsgvYLctpiT9Nu8UTjOLCiKoUweRT/MsDSZhT6X8T/+c/
         0W8g==
X-Gm-Message-State: AOAM5323j4NO+tAPb8eWVXXA/BB41lSFgpj766I+C7cGpQ5F1mIZM+9z
        K54h8ySgZ9l1DZ+14yxE7sxkl3H0vvq+aAmaqdR8qw==
X-Google-Smtp-Source: ABdhPJxDmhv2Wk4xS4LtcVnjVmDgD0uv50Ee3G6tTvQATi7KZyc3eV2KcY6vd/PwCbVrxO/pvQ+fcQrosyCBMLqNaLA=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr1388223otn.126.1632349208588;
 Wed, 22 Sep 2021 15:20:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Sep 2021 15:20:07 -0700
MIME-Version: 1.0
In-Reply-To: <002501d7af73$ae0a7620$0a1f6260$@codeaurora.org>
References: <002501d7af73$ae0a7620$0a1f6260$@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 22 Sep 2021 15:20:07 -0700
Message-ID: <CAE-0n52DcCwcdR07fvMLrj=RJFtNthy0FdWmt1gBWiD9eLrOvQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Don't always treat modem stop events as crashes
To:     pillair@codeaurora.org
Cc:     ath10k@lists.infradead.org, govinds@codeaurora.org,
        kuabhs@chromium.org, kvalo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        youghand@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Quoting pillair@codeaurora.org (2021-09-21 22:35:34)
>
>
> On 9/5/21 4:04 PM, Stephen Boyd wrote:
>
> > +static int ath10k_snoc_modem_notify(struct notifier_block *nb, unsigned long
[...]
>
> > +
>
> > +          return NOTIFY_OK;
>
> > +}
>
>
>
> Thanks for posting the patch. It would be preferable to use a different flag
> instead of ATH10K_SNOC_FLAG_UNREGISTERING,
>
> since we are not unloading the ath10k driver.
>
>

Ok. I'll make a new flag ATH10K_SNOC_FLAG_MODEM_STOPPED and test that as
well.
