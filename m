Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB502A1318
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 03:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgJaCrV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 22:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaCrV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 22:47:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D6C0613D5
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 19:47:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z1so3897482plo.12
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 19:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e98FhQCbBFLStXhsPwRQARl8mlhgWix04TFsaLfXM94=;
        b=ILq/aDMIfhUW3zwy9UbPSoYCqiQqjgMdbje4fg6SEC0rpf2z8PiC1sjyDNKtRhTRqM
         2Dwj1Lpc/+IW4s1SVa/XTsDy9lJ/hAdH5l7sI7qZM2Nt2GqX129L39pbYasdS24mRl6F
         YLSAz47wM7YFkeb3c9Lyo/gClj2m0bocP5xI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e98FhQCbBFLStXhsPwRQARl8mlhgWix04TFsaLfXM94=;
        b=k6BbT/tFk78xJa/aK1Lhg/MiOt+9q1jFJhNcOSTXkobB6vHeHQAv2Prsfeb6fTTYUx
         CeJFtniTwmQrfQudY7Gbm/QKfifEP7nFFLwsiyHIgaqN8LjL5sLVVCKyJ1fv/rLHHW0J
         Qs79rx4q6UKNkHPBxnsLtKtpt7q+ccBBf+YIU/+/cl2c+noCuddFnhEZf67G3YyKEpg3
         5QyFwVywZdVyCf4Q/wSeecT6ae+WM5kt0e94Zld4mc8xc5EmsqPKN8I/0HxvUVvcUw/t
         aqNJ+cHcUTQjjcwjk50hGr3wMs/e4Ba6ruCW9WijH0huSW4/uQApGj1R3BdAT2xK4Ed+
         7Bgg==
X-Gm-Message-State: AOAM533aVRBRbUOCehNzQ/1c669/otYBiT2S012s6g2LO5jGH5b3fFX7
        KH3nkIrs6O8pqxt9wDD6XicGtQ==
X-Google-Smtp-Source: ABdhPJzpxiZ56yTdzo63V0FwL0O0Az/jHv4XaNs5YOuHPFqnwr7HaXvEKywaEVFJoqpC4d1UejjhiA==
X-Received: by 2002:a17:902:ba91:b029:d5:c5ce:9bab with SMTP id k17-20020a170902ba91b02900d5c5ce9babmr12005490pls.48.1604112440761;
        Fri, 30 Oct 2020 19:47:20 -0700 (PDT)
Received: from kuabhs-cdev.c.googlers.com.com (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with ESMTPSA id b2sm4711830pgg.2.2020.10.30.19.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 19:47:20 -0700 (PDT)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     kuabhs@chromium.org
Cc:     ath10k@lists.infradead.org, briannorris@chromium.org,
        cjhuang@codeaurora.org, dianders@chromium.org,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power limitations.
Date:   Sat, 31 Oct 2020 02:46:31 +0000
Message-Id: <20201031024631.1528113-1-kuabhs@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201030205639.1452712-1-kuabhs@chromium.org>
References: <20201030205639.1452712-1-kuabhs@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: kuabhs@chromium.org

There are few more additional comments here.
> + * @NL80211_CMD_SET_SAR_SPECS: SAR power limitation configuration is
> + *     passed using %NL80211_ATTR_SAR_SPEC.
> + *

This command requires NL80211_ATTR_IFINDEX, probably should be better to add
this in the comment ?

> +static int
> +nl80211_put_sar_specs(struct cfg80211_registered_device *rdev,
> +                     struct sk_buff *msg)
> +{
> +       struct nlattr *sar_capa, *specs, *sub_freq_range;
> +       u8  num_freq_ranges;
> +       int i;
> +
> +       if (!rdev->wiphy.sar_capa)
> +               return 0;
> +
> +       num_freq_ranges = rdev->wiphy.sar_capa->num_freq_ranges;
> +
> +       sar_capa = nla_nest_start(msg, NL80211_ATTR_SAR_SPEC);
> +       if (!sar_capa)
> +               return -ENOSPC;

I see some places nla_nest_start_noflag being used and here nla_nest_start.
Whats the specific reason to do that ? In the newer Kernel versions, I believe
nla_nest_start is preferred.

> +               power = nla_get_u8(spec[NL80211_SAR_ATTR_SPECS_POWER]);
> +               sar_spec->sub_specs[specs].power = power;
> +
> +               /* if NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX isn't present,
> +                * then the power applies to all bands. But it's only valid
> +                * for the first entry.
> +                */
> +               if (!spec[NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX]) {
> +                       if (specs) {
> +                               err = -EINVAL;
> +                               goto error;
> +                       } else {
> +                               sar_spec->sub_specs[specs].freq_range_index =
> +                                       NL80211_SAR_ALL_FREQ_RNAGES;
> +                               specs++;
> +                               break;
> +                       }
> +               }

Here I see you are assigning same power to all freq band if for the first band
the freq index is not provided. Is there any specific reason to only check the first
here ? Probably this logic should move into specific drivers. Thoughts ?

-Abhishek
