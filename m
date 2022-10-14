Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186695FEB51
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 11:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJNJF7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 05:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJNJF6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 05:05:58 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CBB17653B
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 02:05:56 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id v68so4264646vsb.1
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBIqq1Xi5W93aDTnMJKZQ4LXQmr3ZVtqfHaXUwd4JvE=;
        b=GiP693ulKhVPTgYIG3pDfYmrMwjYAzME8RFvm1ZoJzRz9Xv8h5qXZ4LZpBnUaA9pFe
         RNoN81pSDaEEQO1WvE0/KS83SvDBZ16rcAJuHH3PhlaBs95TbTpoBfQsif9hGO+5FI/j
         mqQu+UM838nSbIqAyi3T8p9v7Kv2mLlGegf6BiOorhycRtFHNoePLZuArqJKah5LV+GB
         kmvFX51vZa9AmwVwxFnIKOj/72V+4R77oE9M7vS8M73wr12jhTzCVg1O60ClMJRHGgnd
         zwoHgk28+nb6dt+VXV7S95934oqfR3fceWUU7Do4Jd/q8VYVwjyuAX9ayrVQlc/eyRN1
         DWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBIqq1Xi5W93aDTnMJKZQ4LXQmr3ZVtqfHaXUwd4JvE=;
        b=nBZsos8pv5AViGZysdOWP67ZsemgnjlIIYFJ/vXpNTSWs/BF4T7w5IXKv/pX/eXkiZ
         L2GIw+igCJjZWCAJcbNSAB/sdym66BkCnJa61+506CCaactygPOBRykTHEc1sSkIPe/I
         wJQa6fxcRB+I0RgiqSE3GdUP4VuT1rmC3VB0V1fFU9qcUNUDG15D471ELpfG/Na+FF3J
         rpe5m0YGAwWleB4BfNqTCCn9bKvAnXLJYJzHlhWbgha44hjGCgcrvnAYdRkrf7/n/gUu
         Sz6DChNN0jyFeczrEOzMhTpmO2JAFxGobcFSoyvwSFXJtWbY3L2JVev7iDjp2d9dHf5o
         6WBA==
X-Gm-Message-State: ACrzQf2z3IFGoGvZpTlW/TiRQpPbnu+eQEtP/Gbex86MN8cgjNR3DXQl
        akSUck27OUY4sFpuGTnKozcyQB1UaCjxUmIPWXBoyQ==
X-Google-Smtp-Source: AMsMyM7sriPSD4G5SD+wg9iy4SXUJgoayiZNOAEIsu1uhEU4o3lZO/+qnm8wqMM2Ne1qoLAhQOYN1SdyJHqc03/4Y3w=
X-Received: by 2002:a67:ac09:0:b0:39a:eab8:a3a6 with SMTP id
 v9-20020a67ac09000000b0039aeab8a3a6mr1915129vse.9.1665738355453; Fri, 14 Oct
 2022 02:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221012192348.2234478-1-linus.walleij@linaro.org>
In-Reply-To: <20221012192348.2234478-1-linus.walleij@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 14 Oct 2022 11:05:44 +0200
Message-ID: <CAMRc=MdY38HKaH3i8UjQF7xc7PAOnY0_8tgLaVj_MhPe0byg4g@mail.gmail.com>
Subject: Re: [PATCH] bcma: gpio: Convert to immutable gpio irqchip
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 12, 2022 at 9:25 PM Linus Walleij <linus.walleij@linaro.org> wr=
ote:
>
> This switches the BCMA gpio irqchip to be immutable.
>
> Tested on the D-Link DWL-6810AP.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>

Why is this here and not in drivers/gpio/?

Bart
