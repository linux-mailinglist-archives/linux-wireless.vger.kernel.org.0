Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A812548F74A
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jan 2022 15:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiAOOVy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jan 2022 09:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiAOOVw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jan 2022 09:21:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F496C06161C
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jan 2022 06:21:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w12-20020a17090a528c00b001b276aa3aabso1411210pjh.0
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jan 2022 06:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KB+YKcK9bH8isu/7YqR7JEWYdJ9QOZErjM6DoIFx478=;
        b=KYhJH0jVHlIjWTFJfBTTChxruJ5sVbo6gD20GVJqMAvNYUFC0aHviug72kb26Nhv8y
         2tHO6gfMM00iM9boi68XLoctocGXkipyZ0xx6UkXVcdwjVzw9GLbu/JSLS/yqnHxp5Ht
         iDYcF/aSSQgYJOn6zV7aW/0AcOuixJQTXlETZ9jFUMGaOImNaig7kAlw8qqp3+AXagfz
         h/+qenB2N/zEm+cjqtubWGEgnMatfikjJopgvR4m7ZBwWgHb42+FZ2Lh8v04jL5Fa1FK
         nqF5Wj6tfqHvHc96uQngJ0TlUiSDJmAHtPqgcCNDfKQmEu18BMmL2ZBKMixOW5o2szTi
         pMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KB+YKcK9bH8isu/7YqR7JEWYdJ9QOZErjM6DoIFx478=;
        b=XO3u9gDIUL0GoabJLmpBSjh+D3FxYjsRCgBYC8sNfzrRlhFeGhzyNJjZbOJMCbFC5/
         a9Wz53s3h8tlrcmOgHabNFVygE7/0NroySfkzwYuufDNMlAkmE44Z49FB/sZvkWGQJrg
         t2qgj3q1hr491cj88fGPUr9J1DdriK/8fpWuv6URzPDOGy2hZbC3YWNHNa5c+PXkZUTW
         9L9rZ/FB+eGvy0UsMAl/cEMkLUAHeRtYff8ntDV+DazpADgVIyGiJqvEbnzDZ2xU8M0C
         kY6a2+sW5AWX2Q2CaC/KBQcK0m9V8kKI0L/DrrMyluEooFI3FC0AIgoq5qxyDQ/IwCnG
         szkw==
X-Gm-Message-State: AOAM533T8nFSJ4uFDNNqqtILajq8gFWW+OjchyayKcpljxTDRJfT4WGX
        EhSQCiEcCQItDH86XnoChqVagbAuQSxwTjtefnTb2Oq0956chQ==
X-Google-Smtp-Source: ABdhPJzWU4coJqMJbBA0NWC9dPY+Ss8qaTD+DSo1xflaXMYkvOJMumo4YTlQSwehO1M4UP/Dyof1WWTP0Z3RKsA7KVg=
X-Received: by 2002:a17:902:6b02:b0:149:9c7d:3ae7 with SMTP id
 o2-20020a1709026b0200b001499c7d3ae7mr14498313plk.51.1642256511713; Sat, 15
 Jan 2022 06:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20220115001646.3981501-1-bryan.odonoghue@linaro.org> <20220115001646.3981501-2-bryan.odonoghue@linaro.org>
In-Reply-To: <20220115001646.3981501-2-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Sat, 15 Jan 2022 15:19:44 +0100
Message-ID: <CAMZdPi_nXSQoaa83U-WOHCa4b+Kz_WmERT1V9ABgzUb0QYj-3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] wcn36xx: Implement get_snr()
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        benl@squareup.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 15 Jan 2022 at 01:14, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> The wcn36xx BD phy descriptor returns both Received Signal Strength
> Information (RSSI) and Signal To Noise Ratio (SNR) with each delivered BD.
>
> The macro to extract this data is a simple-one liner, easily imported from
> downstream. This data will be useful to us when implementing
> mac80211-ops->get_survey().
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
