Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44691377F2C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 11:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhEJJPp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 05:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhEJJPp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 05:15:45 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBF9C061574
        for <linux-wireless@vger.kernel.org>; Mon, 10 May 2021 02:14:39 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id 33so4990403uaa.7
        for <linux-wireless@vger.kernel.org>; Mon, 10 May 2021 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cf+N/JAKJmPE1kvrNVbyPIgWjo2nWT8Ib0zglPbc7UU=;
        b=heQQoRF4Bq2wpiivWKYCladAqOw+Tz+1t9GdHA5V3adUn8/T2WHsakAvQqriMnYmZq
         MV8/GN1ZulVY949J3udljZo3ksKPyLDsvb3/Xkk1l38Gu8fzoTfm7qqn23/HWfQM7RbW
         vuD+9rt5BxSTqZullX1bQDsb9PsH1qyRuikOcfI6dQKoarJU/y2eOyiOtVlXvoIoUqVp
         CsfnkiRGK8jmA1QE9E5YLpFL1Lme0xIlaFLXJcsMV45l8DzPI3GJry03VolShW3uavr2
         mYfOKmIZooUFIQUQ1X2kXsh4jaNAfaSSu8QNf+ZYBRGvfoCQesCNQNt5cuZlRh0A5ZkC
         yTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cf+N/JAKJmPE1kvrNVbyPIgWjo2nWT8Ib0zglPbc7UU=;
        b=SL14qhWicBXMMH+gdDuhOrNyHOdl84jU6IQI2CFCTUny1HvszJ5xHEvxPQfxlC+rdp
         UM1duWSu/japO4cGDV0LlMhma8viK1o/kn/Vud1CjR1UV0aRBYrgwQaZ74Awig/pw+nA
         IfnroVXctdgOdb7UXQ5Lil0Ob9Y67yiAneUgUOUuY8GUsC7KUhI3nvh5W0RU6oAFwws3
         msnDq2msyFslVz4Tae/woQ3X85iB5qQvGUJ0zIYh4wCzKJSnc5SDVXDEBnAUlHxafdRs
         NSsby4WSlXT3ZQxdcgLYp3Dt1Har1TsMHdOK4dVvApEcZ9BxSjgBI4jwnIGnuDOSLoTw
         EkNw==
X-Gm-Message-State: AOAM533avKGbnP6VZCkZGtdm+GneSXSkE+r02y99X3ZT77EOSwZF2o/j
        415Duq8Zd5I3T9pXW/7h4eDmS3+QWepMfiBcZlUexA==
X-Google-Smtp-Source: ABdhPJwehwD9fXlFKTSIGTTIkSmVCJiqMa9L4UCNAj8DRlyerJLuph/eT6zc7ge7jBc+/EFQDcx9e3HegAuS8kqPmPg=
X-Received: by 2002:a9f:35b3:: with SMTP id t48mr456263uad.129.1620638078520;
 Mon, 10 May 2021 02:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210509224226.348127-1-linus.walleij@linaro.org> <c5370b69-eac2-815e-27cb-f865a7885830@broadcom.com>
In-Reply-To: <c5370b69-eac2-815e-27cb-f865a7885830@broadcom.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 May 2021 11:14:02 +0200
Message-ID: <CAPDyKFq6PEx9YNF5VDjEy2giLOe=NJPxM2KCAWOOQxeGR_3jMw@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Obtain reset GPIO
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 10 May 2021 at 09:37, Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> + Uffe
>
> On 5/10/2021 12:42 AM, Linus Walleij wrote:
> > This grabs the reset GPIO and holds it de-asserted, if available.
> > Asserting this signal will make the SDIO card re-enumerate.
>
> looks ok to me, but could this also be done through SDIO power sequence
> stuff?

Yes, it certainly looks like that to me. It should be the mmc
host/core that manages the power on/off thingy for the SDIO card.

[...]

Kind regards
Uffe
