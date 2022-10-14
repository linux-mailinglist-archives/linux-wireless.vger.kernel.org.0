Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF1E5FEB53
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 11:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJNJIh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 05:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJNJId (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 05:08:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00B92B25B
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 02:08:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a13so6044224edj.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IqumXCEVYuWRkK7x4wtTFGNl141XgbbmIdAjil0lpk=;
        b=cZh/DaKe3WD0cQs4mMURaAfCOM3fzh4r0PsoYF7ztIvMuxT/Y4QYSKFVoQX8dOmkhW
         afrpC2MYjYCXhtObmCqpmaoogXJBxnbeIvJZlW0/Uam5h4sp92wu//hQVabDc9c8P5P1
         hl6dkn4YqBuG168xK+8nHXiBMmBnl+3aiIDTBeEGZgHujxUZGiZeFkWOrTC2g8/7kq/H
         OhMN5EOVQADyVFjcYNqVUcyBT2BnDpxN3O1FJUEfzjmq5ttxMFmDzzE20SJ4QO0TJxbX
         LVDQMtHVnMPoGi9geTJqmakkMD4fy5tKKaUHK4pKXcf3w1J+dnsS7fT1QyBBTrgBUqD+
         FOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IqumXCEVYuWRkK7x4wtTFGNl141XgbbmIdAjil0lpk=;
        b=wL3Jran3xhkx8eO2158rW6kr0hOVwrAIy/kX4LunujNdLFq3igdH0qpCviLmZYrIEV
         ZqN2bViTML8ySPTy3f3hqx+cHMEN8fEnLG5u41Ry0S/LlEfe7uYgfIpe2woIoAoT8/ie
         PE+NC6vw5XvOzheUA4q48MxM0TqXRo0yLPDFs0LARmYgw8pCm2y0h/dKCefTOaNleOFN
         NV3Urr0urp1zSZfI2tcFqQ8HqUyZkQqc5IUx4mh0doiJqX3i0anQnQyLQRk2mxPAOuPp
         y3TbarsHTc+cTbDAurJ4IyGzDacjzq4e2f5GAcR5yX4sR/ZevrHRpmR1Bf6wAuJmAk2w
         FW8Q==
X-Gm-Message-State: ACrzQf2Zd9UBNsM4URwAYUAmg1DFa7ecXUEHTrLrL88l8ckp1Vky4eMa
        VxuFIjKtdFgBRh7MGeOMpuzDieI/ftzLw4wW7WwyFbTfno0=
X-Google-Smtp-Source: AMsMyM5hALvc9CQ8utY4epgcSwHtPjVZpfV+UTVs1Ks+wkYsDznhn/7pGwhngqmIP8sPCFYZYImZTuz2N3Xi4YjLJ4s=
X-Received: by 2002:aa7:cd4f:0:b0:458:6077:c3ac with SMTP id
 v15-20020aa7cd4f000000b004586077c3acmr3499746edw.32.1665738511439; Fri, 14
 Oct 2022 02:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221012192348.2234478-1-linus.walleij@linaro.org> <CAMRc=MdY38HKaH3i8UjQF7xc7PAOnY0_8tgLaVj_MhPe0byg4g@mail.gmail.com>
In-Reply-To: <CAMRc=MdY38HKaH3i8UjQF7xc7PAOnY0_8tgLaVj_MhPe0byg4g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Oct 2022 11:08:20 +0200
Message-ID: <CACRpkdZuBJbHrAmvM=DFwfseFvcCLbmxcwowdQ3HyhZC+b_PRg@mail.gmail.com>
Subject: Re: [PATCH] bcma: gpio: Convert to immutable gpio irqchip
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 14, 2022 at 11:05 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Wed, Oct 12, 2022 at 9:25 PM Linus Walleij <linus.walleij@linaro.org> =
wrote:
> >
> > This switches the BCMA gpio irqchip to be immutable.
> >
> > Tested on the D-Link DWL-6810AP.
> >
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> > Cc: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
>
> Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> Why is this here and not in drivers/gpio/?

I don't remember exactly but I think it was that it would needlessly
expose all of the gory BCMA details into a global header so it was
the lesser evil.

Yours,
Linus Walleij
