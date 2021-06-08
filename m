Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2484539F110
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 10:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFHIjn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 04:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHIjm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 04:39:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794BFC061574
        for <linux-wireless@vger.kernel.org>; Tue,  8 Jun 2021 01:37:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g24so11478141pji.4
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jun 2021 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIri9kCofOoOLXZOxF6K2aAvR+DCRNO/EjptNrjwmC0=;
        b=xJQgFOW5VPPAQ1Dimyfflz+oVklcBFyTFZpUjTGxB1uUP/BioLERjmCj2Xu0//V0wW
         QpZgBi4sViwCQzcIx8IgY2JeLnWkFYgObwd4ZAykrErWjlUTec+3uh81/fl9DxBpB6Sw
         +1aOzhQFvAXbIVf+CewoJvhNiooCn5IJeA7Ep1XoxQHcPPPCYYz5meHlpZ7KdN+1NHrf
         g1mwLfurSZPaJ9d5rHwhmOwDSEr08D/oDzccsq1iiXPcXxVLjZMUOp4GttK1PKUywAg2
         YodIl8lw28caKUmm1PxHlRyvjOE8vXsohbdzuA3UUfA6DMAD65b4ZyHMdYU3KuhQ2bqK
         NwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIri9kCofOoOLXZOxF6K2aAvR+DCRNO/EjptNrjwmC0=;
        b=nGoo8pUiU3J17aLM8IopCcgkvBDqsLUMHSD76ifIgvs1UClb5cypylNeRQHxsUDxeN
         KhpEm07BD0L6E4NcRf/cP9sZqCdy2dYk2Yem5f+ApZt1IsZmSIc3aPamaVZJKByz78PL
         nVWPj35vLkmK23nKF8Vke4olMoYSuxbwAxy6lOM8WPObpgro9abKASXSeg5MxkNjewdH
         7tQf/C9r7Hw3zl0csNu36CS8nlf+OTRKDIbAxgqN01K8Oep+2vMVYJH0mGYUSE8AMikb
         S0GCgkE1+e9dOOWL2Qhy/MVO8/JYitEOA6bVl2M6aDQcCU8e9LYgB4+HJ0aFbMCVbcV0
         6nog==
X-Gm-Message-State: AOAM530C6XNXqhQffDxUJ06BAnzml7lyjaje6M5t4EYBh5mZ7+tG+46x
        rgYWe1y16/2AhijpIPdulCDJTVcaGJcrnxFqwPq639o17h1MiuQ6
X-Google-Smtp-Source: ABdhPJz+BSmdoRZ3oG1wx09tz9CAHaCiLiyjr+/x+s51kbbz40d2iS/z3BgzWTIAcD3GHGSLqCEF5eYE2JE87LU2kZk=
X-Received: by 2002:a17:902:d64e:b029:ef:8b85:d299 with SMTP id
 y14-20020a170902d64eb02900ef8b85d299mr21818436plh.27.1623141469979; Tue, 08
 Jun 2021 01:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210608040241.10658-1-ryazanov.s.a@gmail.com> <20210608040241.10658-8-ryazanov.s.a@gmail.com>
In-Reply-To: <20210608040241.10658-8-ryazanov.s.a@gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 8 Jun 2021 10:47:01 +0200
Message-ID: <CAMZdPi8OoAz-Tr4qXugBPNRhAUt3=co-qMouYvsKdyH8r8KS5w@mail.gmail.com>
Subject: Re: [PATCH 07/10] net: wwan: core: expand ports number limit
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 8 Jun 2021 at 06:02, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>
> Currently, we limit the total ports number to 256. It is quite common
> for PBX or SMS gateway to be equipped with a lot of modems. In now days,
> a modem could have 2-4 control ports or even more, what only accelerates
> the ports exhausing rate.
>
> To avoid facing the port number limitation issue reports, increase the
> limit up the maximum number of minors (i.e. up to 1 << MINORBITS).
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
