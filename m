Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A7D29DBB6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 01:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgJ2ANJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Oct 2020 20:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390749AbgJ2ANI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Oct 2020 20:13:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07837C0613CF
        for <linux-wireless@vger.kernel.org>; Wed, 28 Oct 2020 17:13:08 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v6so1018971lfa.13
        for <linux-wireless@vger.kernel.org>; Wed, 28 Oct 2020 17:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjZ0C47sBFE4E/dMNMwf9DAUHIodX8mtYvgDRoLI4EA=;
        b=YRSR+UuG72ciMnSbkIKW71fwluhc008uXS+zCtS9AHDFnFwQEIMMgP/YxKO2Dy1307
         WP7/iso+nlAS+anmA1lgk8lE/LiU6ECV1Z6zNFlM6NINwI35F0XF+CWuJQeINp59prgV
         jihocwVqHZpzzVYcqIAvrcvpd/gtQFCguDskE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjZ0C47sBFE4E/dMNMwf9DAUHIodX8mtYvgDRoLI4EA=;
        b=aet6K+b5jUsVjETw7dgK/nb8zQ2h9R4TwNt0O3DQ9/YtnVmjg1O0zMZBZCVjOhy2lH
         ZFIPbUyQDYm8KT7f+UrP3SW6tIqrHkC1RNaOdlatn9tM6YptI+vq47YLSGJAFKcZs0Z4
         PgOva9OsbUXZGBeUp2T4OFFSSbIbGWyXKhhZaskDtkHZu9o6d5ieHmwcU7e+qczGxnW6
         1917GVwGIGu7ExjqpJzoyb9R1qym6Eoxrkt8zGBZMNNGQPYnUr9TAany5/sOUVNbPVam
         /o38YK2lczvIkooXQa4uDVKGsVq8+1gO2zGrUXqqLptXsW1BR64P9Kd5tBbSM7NLG+no
         sivg==
X-Gm-Message-State: AOAM531ElZTRztTnrY7tHDdK1Ei5F8ejzciamVy4STX0MZxwm+UCI5cK
        O78h9DbHpofSttDWKtwEZ8B8xCE87X6/PQ==
X-Google-Smtp-Source: ABdhPJzuzO7SenUGMBmQPxDLY7XOQdg4kxaP+z8YWSgp035Cn+mTCfihBzUxEp13R7DwleEsVI2Oew==
X-Received: by 2002:ac2:5395:: with SMTP id g21mr523820lfh.330.1603930385227;
        Wed, 28 Oct 2020 17:13:05 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id f10sm124382ljn.87.2020.10.28.17.13.03
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 17:13:03 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id l28so1043728lfp.10
        for <linux-wireless@vger.kernel.org>; Wed, 28 Oct 2020 17:13:03 -0700 (PDT)
X-Received: by 2002:a19:c703:: with SMTP id x3mr502126lff.105.1603930383060;
 Wed, 28 Oct 2020 17:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201028142625.18642-1-kitakar@gmail.com>
In-Reply-To: <20201028142625.18642-1-kitakar@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 28 Oct 2020 17:12:51 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPX+fadTKLnxNVZQ0CehsHNwvWHXEdLqZVDoQ6hf6Wp8Q@mail.gmail.com>
Message-ID: <CA+ASDXPX+fadTKLnxNVZQ0CehsHNwvWHXEdLqZVDoQ6hf6Wp8Q@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: pcie: add enable_device_dump module parameter
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>, verdre@v0yd.nl
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 28, 2020 at 3:58 PM Tsuchiya Yuto <kitakar@gmail.com> wrote:
>
> The devicve_dump may take a little bit long time and users may want to
> disable the dump for daily usage.
>
> This commit adds a new module parameter enable_device_dump and disables
> the device_dump by default.

As with one of your other patches, please don't change the defaults
and hide them under a module parameter. If you're adding a module
parameter, leave the default behavior alone.

This also seems like something that might be nicer as a user-space
knob in generic form (similar to "/sys/class/devcoredump/disabled",
except on a per-device basis, and fed back to the driver so it doesn't
waste time generating such dumps), but I suppose I can see why a
module parameter (so you can just stick your configuration in
/etc/modprobe.d/) might be easier to deal with in some cases.

Brian
