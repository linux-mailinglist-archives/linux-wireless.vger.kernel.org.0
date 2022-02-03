Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48C54A86C8
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 15:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346041AbiBCOoh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 09:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242202AbiBCOod (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 09:44:33 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACAAC06173B
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 06:44:33 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d3so2273594ilr.10
        for <linux-wireless@vger.kernel.org>; Thu, 03 Feb 2022 06:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tbhWRIOFYjgUC3Vb98+hQGA2AlTDbAX5g/E/ZuVec74=;
        b=E27QQ6wJuL3UmwpE9CQ6NCKwnrzvDVkIRvP3x9Jl3bZ48yhcJ5NgrprOkYYGCFF2dj
         sU7eOgR6FVApzEGit7UGjFPEK98K9huPKdypWNhgcRz72QgkP8NMMaPtSaQG8Y/DZFcw
         jV9Er86XWBIaAYokQXo3xujUImU9yG4PKbqDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbhWRIOFYjgUC3Vb98+hQGA2AlTDbAX5g/E/ZuVec74=;
        b=W+EkXFcBzOJqKhjihlVb9UzCEZGbLYw7oBRg9igluE0bBy/TdbemKVLQGVZFlWiGW9
         Psr9AdBuQ/69K7iQhpzKS98XXZtNdZYpHDBjDHTrMl06I3kdFm6XEfusT0H3/1v1n9zp
         O538lBpq/R/Xb15SdgYi0BUUcKmKZSV5T7qoa3jM+wZQDHd7M8P/wJBEbvGVVBX1t/c9
         /iseb/bwtRztorlZ0+W4eIJS/fophjKTDFI/nzGDinnY0Lt35P7vuGI0CjEaSDAuIGx+
         HlTbe8wxmHkm7iZSFpjrtpLtKr5oVBlQkJNnydpHw+Fp2b6tlno0b8l9Vg0LyuFR8cDT
         UxhQ==
X-Gm-Message-State: AOAM531nrqU7dUspg0IekQx73urO3744wRAzzlkdP6xOIEC8Qf/Xd6kp
        3ftogOrZS//8ZfNTokznh/pLWGwV8qepUQ==
X-Google-Smtp-Source: ABdhPJzgbklfD/xSxd/E44mVCiBw2lneBkB9UghTpkZeeE74YoVwF+t2QvKGgR8GUfa50cydmeTjZA==
X-Received: by 2002:a92:ca0f:: with SMTP id j15mr12698589ils.189.1643899472383;
        Thu, 03 Feb 2022 06:44:32 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id c9sm22255873ile.38.2022.02.03.06.44.31
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 06:44:31 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id y84so3572287iof.0
        for <linux-wireless@vger.kernel.org>; Thu, 03 Feb 2022 06:44:31 -0800 (PST)
X-Received: by 2002:a02:3b67:: with SMTP id i39mr17234458jaf.50.1643899470709;
 Thu, 03 Feb 2022 06:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20220121064427.32059-1-quic_youghand@quicinc.com> <20220121064427.32059-2-quic_youghand@quicinc.com>
In-Reply-To: <20220121064427.32059-2-quic_youghand@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Feb 2022 06:44:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W-kPfnL2jB7bw4SSC=8hBfZg4kq7=rsHHCxDRj6yaSeQ@mail.gmail.com>
Message-ID: <CAD=FV=W-kPfnL2jB7bw4SSC=8hBfZg4kq7=rsHHCxDRj6yaSeQ@mail.gmail.com>
Subject: Re: [RFC 1/2] ath10k: Set tx credit to one for wcn3990 snoc based devices
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, quic_pillair@quicinc.com,
        Abhishek Kumar <kuabhs@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, Jan 20, 2022 at 10:44 PM Youghandhar Chintala
<quic_youghand@quicinc.com> wrote:
>
> -       htc->total_transmit_credits = __le16_to_cpu(msg->ready.credit_count);
> +       if (ar->hw_params.tx_credit_limit)
> +               htc->total_transmit_credits =
> +                       __le16_to_cpu(HTC_HOST_MAX_CREDIT_COUNT);
> +       else
> +               htc->total_transmit_credits =
> +                       __le16_to_cpu(msg->ready.credit_count);

Apparently 0-day had a bit of a problem with the syntax above. See
<https://crrev.com/c/3435607>. Basically you don't need the
__le16_to_cpu() around the constant HTC_HOST_MAX_CREDIT_COUNT.

-Doug
