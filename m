Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6582BBC4D
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Nov 2020 03:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgKUCmo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 21:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKUCmo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 21:42:44 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3576C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 18:42:43 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id k26so12819294oiw.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 18:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yqqwrdQhKQXDBEKtAOCqAG/1CMSBr1y6lPpHeYVMEM=;
        b=KfLODqSV4PuG0dJ0+3kSnv47luSgI0IYt8W+WWaDuruPwNs2y6FnCoAqh1PQiYN8jC
         5lrcz6n+srku0z5DEigiN16UYjVYnz8HJ+SgorkSwY9fNiCuhpjh6mgnEdM6zBA0TR3I
         PiS4dxRrV1YEHxQSMTD+ACTy01MbZQF/9ma8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yqqwrdQhKQXDBEKtAOCqAG/1CMSBr1y6lPpHeYVMEM=;
        b=Wi/tQ484tCBo6//Aeawe6ToxOx1arbH0HSgS8Rh/3HqnVgllJnJq/VjFINxFgbXA/R
         O9RdNJf1dEuhY8stxRszL5/IDCreF7b1VC+XI1EFODm8SDKIolGIXeFG5KcgHdVc9Q0R
         T9HvpfGfoExZsdkTQIJ9V/VqnDY5SD7vL0aMAPClTmgAslu9uqleBi0Pz5BmH4sNHAGE
         Apx5mUo9nNfKqHCLU1PKHKrx9wDq/ckpepH+whs8H/7m2sjx9OVdJUSli0bnTpNVG7ef
         6sEa6+gIVimwCql7J+9SvwbrT/PoCXsq76Hw6Kax9Bf3OGO0ZhfnJoMqLg+XaOM8e1QA
         3HsA==
X-Gm-Message-State: AOAM531FXoUhShxUcyJkM7cAWp8NIGmn2YAmELkzbC72VVPmJ+LSUzQW
        UvbolUIfQpJzH29rJDNg1QgDmIFcrVCdUg==
X-Google-Smtp-Source: ABdhPJwJECeTlCzwm6xEc4fYH+6FXrwfcTHdBpTfD9K2sxVv9C9LR0KZLmCq0Y+T88MD3f3G5KNijA==
X-Received: by 2002:aca:4849:: with SMTP id v70mr8837921oia.103.1605926562547;
        Fri, 20 Nov 2020 18:42:42 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id d13sm2439692oth.59.2020.11.20.18.42.41
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 18:42:41 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id n11so10660398ota.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 18:42:41 -0800 (PST)
X-Received: by 2002:a05:6830:2083:: with SMTP id y3mr17292905otq.203.1605926560878;
 Fri, 20 Nov 2020 18:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20201120085312.4355-1-cjhuang@codeaurora.org> <20201120085312.4355-2-cjhuang@codeaurora.org>
In-Reply-To: <20201120085312.4355-2-cjhuang@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 20 Nov 2020 18:42:27 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMRPRPD0XFJeHTRv3Bc13VFehkyDoYHQfaA0cP-STDOLg@mail.gmail.com>
Message-ID: <CA+ASDXMRPRPD0XFJeHTRv3Bc13VFehkyDoYHQfaA0cP-STDOLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] nl80211: add common API to configure SAR power limitations.
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Abhishek Kumar <kuabhs@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Nov 20, 2020 at 12:53 AM Carl Huang <cjhuang@codeaurora.org> wrote:
>
> NL80211_CMD_SET_SAR_SPECS is added to configure SAR from
> user space. NL80211_ATTR_SAR_SPEC is used to pass the SAR
> power specification when used with NL80211_CMD_SET_SAR_SPECS.
>
> Wireless driver needs to register SAR type, supported frequency
> ranges to wiphy, so user space can query it. The index in
> frequency range is used to specify which sub band the power
> limitation applies to. The SAR type is for compatibility, so later
> other SAR mechanism can be implemented without breaking the user
> space SAR applications.
>
> Normal process is user space quries the SAR capability, and
> gets the index of supported frequency ranges and associates the
> power limitation with this index and sends to kernel.
>
> Here is an example of message send to kernel:
> 8c 00 00 00 08 00 01 00 00 00 00 00 38 00 2b 81
> 08 00 01 00 00 00 00 00 2c 00 02 80 14 00 00 80
> 08 00 02 00 00 00 00 00 08 00 01 00 38 00 00 00
> 14 00 01 80 08 00 02 00 01 00 00 00 08 00 01 00
> 48 00 00 00
>
> NL80211_CMD_SET_SAR_SPECS:  0x8c
> NL80211_ATTR_WIPHY:     0x01(phy idx is 0)
> NL80211_ATTR_SAR_SPEC:  0x812b (NLA_NESTED)
> NL80211_SAR_ATTR_TYPE:  0x00 (NL80211_SAR_TYPE_POWER)
> NL80211_SAR_ATTR_SPECS: 0x8002 (NLA_NESTED)
> freq range 0 power: 0x38 in 0.25dbm unit (14dbm)
> freq range 1 power: 0x48 in 0.25dbm unit (18dbm)
>
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>

I think the API is reasonably clear and usable. I'm a little skeptical
that the complexity related to indexes is absolutely necessary [1],
but at least you make clear what should happen in the case of missing
indexes (treated as "max"). But you've addressed my concerns, I think:

Reviewed-by: Brian Norris <briannorris@chromium.org>

I haven't done the most thorough review on the implementation pieces
(and ath10k), but I at least wanted to put my thoughts out there.

Thanks,
Brian

[1] By the way, you aren't checking for duplicates; so users could
pass the same index many times, and it's not clear from the API
definition what should happen. It seems the current implementation is
that you'll just use the last value provided.
