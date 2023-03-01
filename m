Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265C36A6965
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 10:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCAJDu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 04:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCAJDl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 04:03:41 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E428869
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 01:03:25 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so16509359pjb.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Mar 2023 01:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7kLFJAEhf38Z91ErKT+SpxGk8u9CKv5JjAsWvmwSh1U=;
        b=kFV6gWvUnLZUgZ3rx1fWN6XsMVZGaOvEhSfcLg/s8cO8hXYZcsfYyMQVpM1nPe0baw
         9ArjHkD/rTNKS5uasdrwh9EyO2HLnFSdTwYbjkFKAu3WyoU4IHt3Tz34CYydA9oO369D
         BObp7hV6riaekilNuiKshaOLfMCvvMGnhgoDEztu+nfov0YCkeX/+HL/23Yn7jAZ8k5x
         NMf4axghp3wg1SxSNbK2DtkVk61xSTsSv7ln/oLuupE6mXwtZ4StRepp85j7sHIy6sLP
         gDU3wf3dZ189e0zn3+AZIZ/STcotbaSfkInW+N3RhCLw3z5qel277LPsO3bAKE4Pkh8k
         BMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kLFJAEhf38Z91ErKT+SpxGk8u9CKv5JjAsWvmwSh1U=;
        b=uUZ6Q12QD5xv71wHdtMSn9N0yWkY/QrcBMxm3pk90GU0ajWHUdJ9lcWk3CXjAU3vFT
         G5JTOYhDedsvJEUX+U7/vbiY2+OGGpQCOZPTZNFW13MzFE3PUoOF9u3/GUUMPb9W6Zs9
         FUuEUkfT+oX1E+Ze5sJ4MH3sm1QepiUmT4mTOh8nzxvh6rZwXCwX9igq3tIjjAIv0cVI
         CRNauJbvZkBtYNJXjDAtokdQD/RcOrZMsnnNGMxPT7XZSs4V1Rjk7/BtCR0zBGrgH6GQ
         LC34l1r3xg9sJS/14UZQZwpKFEqwTUy64pfnVcLiOhUoos++Im9t68pLQ94mZKBPIV6A
         uAXA==
X-Gm-Message-State: AO0yUKXMfvWGB+L/vRvoD7KqONag+wNolp16UpMe2BB9ceyzki86lrQo
        0USgQyhu9T8H6G+fY3sYxDSVtqOYtSsb+Cvafa3ddg==
X-Google-Smtp-Source: AK7set/EtY+OG6oXO/oVlz80z4XiEM8n0HHmXdl5DR+0gJsIWwZvMhJ6meksEeV5+DLgP3I/bf83eA0yaUAqAI17xbc=
X-Received: by 2002:a17:902:e5d0:b0:19a:fa2f:559e with SMTP id
 u16-20020a170902e5d000b0019afa2f559emr3823016plf.3.1677661405158; Wed, 01 Mar
 2023 01:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
 <Y0hr9XTGAg8Q6K6y@google.com> <CAA8EJppuGbDGb1D-yf2WL77U1bqx1QQStQeDArWmGFCUiOtnww@mail.gmail.com>
 <10237323.nUPlyArG6x@steina-w>
In-Reply-To: <10237323.nUPlyArG6x@steina-w>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Mar 2023 10:02:48 +0100
Message-ID: <CAPDyKFq7NFx_cwTZajqjOnRsjJ1i-F0ip+b0ZjFUcOdLjMJSkQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/15] create power sequencing subsystem
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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

On Wed, 1 Mar 2023 at 09:17, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> sorry for being late to the party.
>
> Am Mittwoch, 19. Oktober 2022, 08:03:22 CET schrieb Dmitry Baryshkov:
> > Ho,
> >
> > On Thu, 13 Oct 2022 at 22:50, Matthias Kaehlcke <mka@chromium.org> wrote:
> > > Do you still plan to refresh this series?
> > >
> > > I know there have been multiple attempts to get something similar
> > > landed in the past 10 year or so. Your series didn't seem to get
> > > much pushback from maintainers, might be worth sending a refresh :)
> >
> > Yes, I hope to return to it eventually. I just had no time for it lately.
>
> I just found this thread while searching for power sequencing devices in
> Linux. From what I understand this is transforming the existing mmc pwrseq
> drivers into generic ones. What is the intention of this new subsystem? What
> is it supposed to address?
> In my case I have an LTE module attached via USB, but in order to use it I
> need to perform several steps:
> 1. apply power supply
> 2. Issue a reset pulse(!), the length actually defines whether its a reset or
> poweroff/on
> 3a. wait for a GPIO to toggle
> 3b. wait a minimum time
> 4a. device will enumerate on USB
> 4b. device can be access using UART
>
> This is something required to actually see/detect the device in the first
> place, thus it cannot be part of the device driver side.
> Is this something pwrseq is supposed to address?

Yes, this is one of those typical use-cases for discoverable buses
that we need to add support for, in one way or the other.

>
> Best regards,
> Alexander

[...]

Kind regards
Uffe
