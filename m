Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5DA13C8AA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 17:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAOQEG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 11:04:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41569 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOQEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 11:04:05 -0500
Received: by mail-io1-f68.google.com with SMTP id m25so2722738ioo.8
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2020 08:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t2xBhXzleIdfKvE3vvgdZ+bpOSyO6wtsZg7uA/deBo0=;
        b=mZaZoKPghE4pkJJxBHU/PusPMrirqKN8HOPM1jYhS/mzWGXBdSFAiobcApddDFhHGl
         SUoQ77gwUq1G8PWexyQ7ZiRaPP2hLrcj+i9T9QjhL68TxcNFMpohzTejNnQTS9ZARzUE
         1OzZbfg5xNhR9G8SYrqH+InA+TNB2gfwVZvcIuy8NqlMhCg64PI1lrpOS2EzJW4EsIhg
         MB5VT6EF16j/OXNVwWDheSXwa8Y2ClxlQrvskdkDIA2vS9aivV7ePIT0KjdxJ763yZJv
         hrAJ21Ya2fxpL7356sBEtd9dCxssGZNXKWJLtRwaqU6KHWlr2A/KPvd5q8tzXASnprxA
         WhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t2xBhXzleIdfKvE3vvgdZ+bpOSyO6wtsZg7uA/deBo0=;
        b=CHetSdkR5LlzGuAbFqbnfllWRLsLEkw/VcADgA71c/uWhMssznK602ydXtk+5/a65Q
         BBdj5Lex0VR2ZX/UQQ5qZLOF4+betpqk42/TyZm5KrJOqLJmJZRX7UdqcBicNXflb6FO
         MonjZ5yrnbAZty9P90Tl6tu9tLiEUX3rFwcBa5FyrqaGvbZySe5ENr7Djv7tIZ2+lDvI
         hAuxSfoVXcG27MkKp8STJo4eE+K1yskMpJv9zQNliUthnbLSQ29Rkj4af1UrQGD40aID
         dfkDYi7pvU9A8d+gYKBV35XqY50a7thTBDTf17daAe4qswCo4WUu7z/QAZr0ByAhncTS
         O7TQ==
X-Gm-Message-State: APjAAAVuYZattg9WjWK5kGgMmN7FKqXhQS9QHb+0FqOKhzVpSpWaBp7e
        G3PcTZwaMZh5dllWkUQPTnXxGfQ/fLYkWHFnxH2vlw==
X-Google-Smtp-Source: APXvYqzYl7uWtLeaTQOHt+NWSr+1mZ1K56JUoCENH2EXGA4WdU9ip84AUI9sYdAa8/4ddwXNDJtCVvf+Q3CjcldYo04=
X-Received: by 2002:a6b:7310:: with SMTP id e16mr22797101ioh.107.1579104245107;
 Wed, 15 Jan 2020 08:04:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:a0b:0:0:0:0:0 with HTTP; Wed, 15 Jan 2020 08:04:04 -0800 (PST)
In-Reply-To: <20200115150123.7612-1-Orr.Mazor@tandemg.com>
References: <20200115150123.7612-1-Orr.Mazor@tandemg.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 15 Jan 2020 17:04:04 +0100
Message-ID: <CAKR_QVJkVSCuzZWgOxxmkffTYG3pgX4ZX_vvw-6Th5=tvs7ovg@mail.gmail.com>
Subject: Re: [PATCH] cfg80211: Fix regulatory data is reset in case all phys
 have disconnected
To:     Orr Mazor <orr.mazor@tandemg.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 15/01/2020, Orr Mazor <orr.mazor@tandemg.com> wrote:
> In case no one is occupying a wiphy, all past regulatory data will be lost
> as a result of reset to world reg domain.
>
> This includes any channel that is currently in NOP time as well as
> in AVAILABLE state.
>
> This means that after detecting a radar on a channel the user might be
> able to simply reset hostapd and get back to that channel,
> this is a major issue.
>
> To solve this I have added a check before doing any resets.
>
> If the user (for example: hostapd) asks for a regdomain and we are
> already in that regdomain, than we shouldn't reset that regdomain in case
> of wiphy disconnection (for example: hostapd reset or killed).
>
> That way the regulatory data will be saved as long as we are
> in the same regdomain.
>
> Since in that case we will anyway get back to the same regdomain
> the only difference is we will now save the regulatory data,
> won't lose it, and as a result won't get back to a channel that a radar
> was detected on until NOP will be finished, as should be.
>
> Signed-off-by: Orr Mazor <Orr.Mazor@tandemg.com>
> ---
>  net/wireless/reg.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
> index d18cc05061a0..5049c487950b 100644
> --- a/net/wireless/reg.c
> +++ b/net/wireless/reg.c
> @@ -3180,6 +3180,16 @@ static void restore_regulatory_settings(bool
> reset_user, bool cached)
>  	}
>  	spin_unlock(&reg_indoor_lock);
>
> +	/* If the user asks for a regdomain and we are
> +	 * already in that regdomain, than we shouldn't reset
> +	 * the regdomain in the case of wiphy disconnection.
> +	 */
> +	if (cached && !reset_user &&
> +	    (!IS_ERR_OR_NULL(cfg80211_user_regdom)) &&
> +	    (!regdom_changes(cfg80211_user_regdom->alpha2))) {
> +		return;
> +	}
> +
>  	reset_regdomains(true, &world_regdom);
>  	restore_alpha2(alpha2, reset_user);
>
> --
> 2.17.1
>
>

Which device have you tested this on?
