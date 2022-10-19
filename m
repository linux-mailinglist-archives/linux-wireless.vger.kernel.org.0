Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D174660397D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 08:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJSGDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 02:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJSGDg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 02:03:36 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C435BC2F
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 23:03:34 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-35befab86a4so158001547b3.8
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s5DB7EnWinUCVvHnFkWiifLYJ7ZYVSrywNKSXQZJdFI=;
        b=zVYtNmW6565ZCEXxTkDChTvQvHXVZBJgGadsGALKU3QKMGV7PrXldFeksaQiPFFwos
         gOa5LHUXC9ENeji5ixZomlslrjXs7gRNn5sa4/rC/7oX9vcohhS7XlO8sDMJLXWscr+q
         bF06XsYuYWzUbcYRDjzfQO7njw5hC0lUkvvqRBtzHG+VCf+kO0dojSk2HwepiWXgSYBP
         78G6I41n+j4b5oQ86dSQb0agTuBmkZQLAXpLW2ShZuHRDidswcSNmuHVA4Q/JlRHChj1
         CVLKFFo1MbwWbp2VHMZdc2bMjhHGPyCYYpL8L1H7itzUSN66IyZ5++j9CAcdb550Y7AK
         nt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5DB7EnWinUCVvHnFkWiifLYJ7ZYVSrywNKSXQZJdFI=;
        b=EMLeOfDfY9fpyEy9tsBT6vzyb+C6Z/p4VdKZ6eXo9HvXXY3YVwbQz+UybU6AsAF5f/
         h2CvcyGQuhDX80bGQJIMOmD8bHvqGDkFLfX6q6FxNrD31gxATK478JEuGOK1hX9Z3DmO
         5AN/1cjOGGI8CDatBiVQvqofyZJbpLZQ34Dk0NZ0plSL341F8YU8fDf3jxVdsOn7VgeW
         AMPMFej6cy+1lmqM9i+Qu6M+AW9IWs0KCACsinFJGB1drhgrsUkZxAHrI1bMjWxilKwj
         MCqxlnnb9dMMehMOb1FdSFdkagdOpyZPIXvDTkAjuo6AMDUN7ZKGfaJszF++wpCRm5Gm
         D0EQ==
X-Gm-Message-State: ACrzQf15tP855hIejP/9tEdr5vahVYFWQBv+lCv6UieVkX4v/0j9m8ki
        f3yngjqBoo+TwV0Q7VNbJsJjFlrqt9FIzohUt3Q3TQ==
X-Google-Smtp-Source: AMsMyM6pJW+QkixNplXOsyqax6puLF7anBgDILMTra0UqNAILCFqM+RlWPnUCA7ntqHj/xXFKBs5j8LsVWWer2PZbHY=
X-Received: by 2002:a81:4881:0:b0:361:5080:91fe with SMTP id
 v123-20020a814881000000b00361508091femr5409889ywa.485.1666159413839; Tue, 18
 Oct 2022 23:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org> <Y0hr9XTGAg8Q6K6y@google.com>
In-Reply-To: <Y0hr9XTGAg8Q6K6y@google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 19 Oct 2022 09:03:22 +0300
Message-ID: <CAA8EJppuGbDGb1D-yf2WL77U1bqx1QQStQeDArWmGFCUiOtnww@mail.gmail.com>
Subject: Re: [PATCH v1 00/15] create power sequencing subsystem
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ho,

On Thu, 13 Oct 2022 at 22:50, Matthias Kaehlcke <mka@chromium.org> wrote:
> Do you still plan to refresh this series?
>
> I know there have been multiple attempts to get something similar
> landed in the past 10 year or so. Your series didn't seem to get
> much pushback from maintainers, might be worth sending a refresh :)

Yes, I hope to return to it eventually. I just had no time for it lately.

> On Wed, Oct 06, 2021 at 06:53:52AM +0300, Dmitry Baryshkov wrote:
> > This is a proposed power sequencer subsystem. This is a
> > generification of the MMC pwrseq code. The subsystem tries to abstract
> > the idea of complex power-up/power-down/reset of the devices.
> >
> > The primary set of devices that promted me to create this patchset is
> > the Qualcomm BT+WiFi family of chips. They reside on serial+platform
> > or serial + SDIO interfaces (older generations) or on serial+PCIe (newer
> > generations).  They require a set of external voltage regulators to be
> > powered on and (some of them) have separate WiFi and Bluetooth enable
> > GPIOs.
> >
> > The major drawback for now is the lack of proper PCIe integration
> > At this moment support for PCIe is hacked up to be able to test the
> > PCIe part of qca6390. Proper PCIe support would require automatically
> > powering up the devices before the scan basing on the proper device
> > structure in the device tree. This two last patches are noted as WIP and
> > are included into the patchset for the purpose of testing WiFi on newer
> > chips (like qca6390/qca6391).
> >
> > Changes since RFC v2:
> >  - Add documentation for the pwrseq code. Document data structures,
> >    macros and exported functions.
> >  - Export of_pwrseq_xlate_onecell()
> >  - Add separate pwrseq_set_drvdata() function to follow the typical API
> >    design
> >  - Remove pwrseq_get_optional()/devm_pwrseq_get_optional()
> >  - Moved code to handle old mmc-pwrseq binding to the MMC patch
> >  - Split of_pwrseq_xlate_onecell() support to a separate patch
> >
> > Changes since RFC v1:
> >  - Provider pwrseq fallback support
> >  - Implement fallback support in pwrseq_qca.
> >  - Mmove susclk handling to pwrseq_qca.
> >  - Significantly simplify hci_qca.c changes, by dropping all legacy
> >    code. Now hci_qca uses only pwrseq calls to power up/down bluetooth
> >    parts of the chip.
> >
> >
> >
> >
> > _______________________________________________
> > ath10k mailing list
> > ath10k@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/ath10k



-- 
With best wishes
Dmitry
