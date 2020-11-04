Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB4B2A6C27
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 18:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKDRtA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 12:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDRtA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 12:49:00 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93650C0613D3
        for <linux-wireless@vger.kernel.org>; Wed,  4 Nov 2020 09:48:59 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id l10so2903523lji.4
        for <linux-wireless@vger.kernel.org>; Wed, 04 Nov 2020 09:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orVig7Wifn1IowwYdHFDpXZ5VaPV3H3NYuo5PPJM4jI=;
        b=Jcc3jFXHyqgLo3lfz5oXL0Iz9oOlpEO+0esGyBGgto1G8Dr4JCzldsqjNDECJrl5Io
         vLWVifJvsTiu7DwKhul4sfMpPBRnj02nRSiQj0INlkbD238IXOamP5RX9IB66jZJwrKm
         cjMVJ5unfp4ZPvvBdzK1uAJkLUlHcVnTDQdKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orVig7Wifn1IowwYdHFDpXZ5VaPV3H3NYuo5PPJM4jI=;
        b=cSZUHA8tHZzkEDrmXBW61UcjPt00VsKOeemkt2+YDwyJvsytVxQUgXxn3rxiG4Od4v
         aFVzMh47p9UnGENCNAnB1t3oH45kGNaelLhjcSbESU6l0cWfdwDSQbXRQN6IPV2+Btn8
         2m5jKgWZ/06n1Hc2iBp0ltAmn0hFjbEuW/8JcQ0tVAJgYm58P0VsaUt67nX3gvt+GK6L
         DVNh1b/ubmxdvn+4RmMzq3BUIon0ZXY/bZijZRdBumScYlFCr6832gnexBYB0xBcV5JM
         WPDqh7HLnC131Gao/4ZGTMY+LhKRubJGWkKFL/iso7ieLpjsmAB1vvbc1Oq5E0Mi+5IZ
         6D/w==
X-Gm-Message-State: AOAM531f0u1ZofDucSvi5V7oaSqlwH7Ilr6xiaZyZf2cnZx9aDJqwVQe
        BiHFGYa3tXTin+lwEZE0BWb3bvsWSmA0cw==
X-Google-Smtp-Source: ABdhPJz93F8t1dGflPaTlWhEbMBFRDMj2VzNQ0vCE0VTvsELJpgBGZnh+yTnaEY5qGoItKfM9d0WdA==
X-Received: by 2002:a2e:b0cc:: with SMTP id g12mr12013652ljl.403.1604512137588;
        Wed, 04 Nov 2020 09:48:57 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y27sm573591ljm.74.2020.11.04.09.48.56
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 09:48:56 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id i6so28322133lfd.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Nov 2020 09:48:56 -0800 (PST)
X-Received: by 2002:a19:a40c:: with SMTP id q12mr9492677lfc.541.1604512136127;
 Wed, 04 Nov 2020 09:48:56 -0800 (PST)
MIME-Version: 1.0
References: <1600753775-4745-1-git-send-email-cjhuang@codeaurora.org>
 <6649b0c2ff988c2ae8723ea633f86cc12da43d95.camel@sipsolutions.net> <d424aa0e80ac55e511ddb33b41d40fea@codeaurora.org>
In-Reply-To: <d424aa0e80ac55e511ddb33b41d40fea@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 4 Nov 2020 09:48:43 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNAXo=p=_MbNXG+Mma37v5b6gAPySsXpNh6CC+L_gLnXQ@mail.gmail.com>
Message-ID: <CA+ASDXNAXo=p=_MbNXG+Mma37v5b6gAPySsXpNh6CC+L_gLnXQ@mail.gmail.com>
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power limitations.
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Abhishek Kumar <kuabhs@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 4, 2020 at 12:44 AM Carl Huang <cjhuang@codeaurora.org> wrote:
> On 2020-09-28 20:36, Johannes Berg wrote:
> > On Tue, 2020-09-22 at 13:49 +0800, Carl Huang wrote:
> >> +struct cfg80211_sar_freq_ranges {
> >> +    u8 index;
> >
> > Does an index here make sense?
> >
> With agreement from Google, it's OK to remove it.

I'm not sure "Google" is the arbiter of the nl80211 API, even if we
are the current planned users ;)

But I think I agree with Johannes, that given the other plans (user
space must send all bands all the time; dropping the "apply to all
bands" support), an index isn't really necessary in either the user
space API or the internal representation handed down to drivers. All
bands should be specified, in order.

Brian

> >> +    u32 start_freq;
> >> +    u32 end_freq;
> >> +};
