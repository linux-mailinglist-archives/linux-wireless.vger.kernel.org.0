Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6441C250C86
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 01:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHXXuw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 19:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHXXus (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 19:50:48 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044A3C061574
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 16:50:48 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id d20so3169830ual.13
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpNbOLmyVly5rQt5gm+Vds/mrJ6L/yJijI7cBZKl+DY=;
        b=eKUrinQ6cqWF1TJCKRqfwUJ7Kh9JtC7c/z89jyLKI8FY/tvbQK05Fby0sd+WY1xnP8
         urnHhPjl7uVTBy0TGxtzjX/WGFD14mYONx2CyrPYDkaSEn69+CYfXCqZ3tFM2QgVkBC2
         X0QqIA4UpKkNqJM6JnCVfmRdvNcVjI+GNmr7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpNbOLmyVly5rQt5gm+Vds/mrJ6L/yJijI7cBZKl+DY=;
        b=j42ezjIW3PkECKplSthVicWZDXsosmEif5NcOx59fLQhMBUkYQQSKOqmOMJSVxz3Z1
         On0k0yM15C6RLC+pTwZlrM4t1R3GtLMGge0IgGTZ3aaGGaibqxOFHfE3FP6f+S0Ixfj7
         ba98emcDfmxbxMQib9c+umfSZ4kyuxAIoddweXH9nq/SYA+Q00m8bwh2wmq9w7HlGSnw
         k4Y8YhvnnGowEMKuWUDuS0x6wj2j05LNJCcHQKuLtJ7VWyhw+MMe6kLxmOJcZjsR8394
         X7eSsPPp69yAWoaJMRWINhCzIEEHEnC5Zd0fwdNUH0u43jKfXJEsCZ28SA9dXB9QSjTZ
         5azQ==
X-Gm-Message-State: AOAM530AIF/lo1SwA63ejKzLQTBWPItkrOyLAuxcmtQc17dFI+Tnrl62
        U/KnefU4cAyf8bgd+rJyzoSD10Eqn5yHGw==
X-Google-Smtp-Source: ABdhPJyma9A+XHM9YhLB6Xx8QU5yDfRdJ/BIOeJYm7bVIaAD6Q1D7ZWHwggGZI3CO2adqFF+LBWGNw==
X-Received: by 2002:ab0:4d54:: with SMTP id k20mr3929874uag.142.1598313047020;
        Mon, 24 Aug 2020 16:50:47 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id j20sm1729244ual.9.2020.08.24.16.50.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 16:50:45 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id b16so5062269vsl.6
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 16:50:45 -0700 (PDT)
X-Received: by 2002:a05:6102:213a:: with SMTP id f26mr3942441vsg.6.1598313045280;
 Mon, 24 Aug 2020 16:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <1593194502-13164-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1593194502-13164-1-git-send-email-pillair@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Aug 2020 16:50:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WTnULQs5skJiXfp+srsx5e8DeqW3uu2SEDVGoEmP2O1g@mail.gmail.com>
Message-ID: <CAD=FV=WTnULQs5skJiXfp+srsx5e8DeqW3uu2SEDVGoEmP2O1g@mail.gmail.com>
Subject: Re: [PATCH 0/2] ath10k: Add chain-1 voltage regulator voting
To:     Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Fri, Jun 26, 2020 at 11:02 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> Add the support to vote for the chain-1
> voltage regulator for WCN3990. This is
> added as an optional property.
>
> Rakesh Pillai (2):
>   dt: bindings: Add new regulator as optional property for WCN3990
>   ath10k: Add support for chain1 regulator supply voting
>
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 4 +++-
>  drivers/net/wireless/ath/ath10k/snoc.c                         | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)

This series is marked as "Awaiting Upstream" in patchwork.  I don't
see anything blocking it landing now.

-Doug
