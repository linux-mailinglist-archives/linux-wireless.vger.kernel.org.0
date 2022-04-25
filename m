Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5C750E8DE
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Apr 2022 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244702AbiDYS5V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Apr 2022 14:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbiDYS5U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Apr 2022 14:57:20 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD3FC6EF7
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 11:54:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id t6-20020a056830224600b00605491a5cd7so11394813otd.13
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yaCTjN5CZzui2ztqLkxvGGCYTFHIuiGBpbp3r9GpozM=;
        b=L4K++dPQRP+MDKtfMHchKPwefz1Mk5XkaIVfDC5UgwCSxVRbl8+VCMBFGhXXyigOFF
         b3Yjvi2VpRRnsVtMX32hY+SiEuIvgLnKyn3k6xyGLFzJyTeFX6czxPd7GO/CIEhhooCJ
         ulZXlRslJqczsGJMoOIXoEVfXD2T7C4ylx0vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yaCTjN5CZzui2ztqLkxvGGCYTFHIuiGBpbp3r9GpozM=;
        b=NJHji3eALrEUtBSV6axyiKhqVS09ATlBNVYtpExwsS4j5PzEGlRGjfqdlAIUxFFYNc
         Kqq8OqIZwXMaOym4U71N6kaMvbQ4+Kmd2SP/BckLqcubICn4830xpxGtmNXMVnOmO6lB
         C26NqIFQc3t7pf3x7JF+quWv1NqzD+wQ6WwQ0Wh5rRdvDFtAhr3R17+HzWhWp+93M98X
         cP5Y1zGZUWsSjSrBO2D0KvewLWY+JismeCbc7FM2308aracaUrz9PpJdDjHckOswkHPV
         dIATmlNZ5JwJmMv7kzZCbT7xQC7TT7zfTlj1T6g2MqCQeaAM7Ltlt3KqOEfRGW5UYkHI
         jzrQ==
X-Gm-Message-State: AOAM531QmJgmZgq6QRTIn5k3VC1Y5Jv3yCWR7zLeQ30BSYuBk7Peqg8h
        g2jIuIoc8JMO/Z1dKzgy2gRgHAplZ/5IjA==
X-Google-Smtp-Source: ABdhPJxkX3S/0aaXlZRXz+sRGU1b39S8Ynp8dVoXvZ3qwgucWnw5+Y2aUhC3MhnxbQZmAV55nYClhw==
X-Received: by 2002:a05:6830:1404:b0:605:46c8:3b4e with SMTP id v4-20020a056830140400b0060546c83b4emr6869648otp.293.1650912852947;
        Mon, 25 Apr 2022 11:54:12 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com. [209.85.160.52])
        by smtp.gmail.com with ESMTPSA id a11-20020a056830008b00b0060546411473sm4076173oto.75.2022.04.25.11.54.11
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 11:54:12 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so17040283fac.7
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 11:54:11 -0700 (PDT)
X-Received: by 2002:a05:6870:4201:b0:e6:47c4:e104 with SMTP id
 u1-20020a056870420100b000e647c4e104mr11422188oac.257.1650912851468; Mon, 25
 Apr 2022 11:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200527165718.129307-1-briannorris@chromium.org> <YmPadTu8CfEARfWs@xps>
In-Reply-To: <YmPadTu8CfEARfWs@xps>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 25 Apr 2022 11:54:00 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPeJ6fD9hvc0Nq_RY05YRdSP77U_96vUZcTYgkQKY9Bvg@mail.gmail.com>
Message-ID: <CA+ASDXPeJ6fD9hvc0Nq_RY05YRdSP77U_96vUZcTYgkQKY9Bvg@mail.gmail.com>
Subject: Re: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
To:     Patrick Steinhardt <ps@pks.im>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Patrick,

On Sat, Apr 23, 2022 at 3:52 AM Patrick Steinhardt <ps@pks.im> wrote:
> This revert is in fact causing problems on my machine. I have a QCA9984,
> which exports two network interfaces. While I was able to still use one
> of both NICs for 2.4GHz, I couldn't really use the other card to set up
> a 5GHz AP anymore because all frequencies were restricted. This has
> started with v5.17.1, to which this revert was backported.
>
> Reverting this patch again fixes the issue on my system. So it seems
> like there still are cards out there in the wild which have a value of
> 0x0 as their regulatory domain.
>
> Quoting from your other mail:
>
> > My understanding was that no QCA modules *should* be shipped with a
> > value of 0 in this field. The instance I'm aware of was more or less a
> > manufacturing error I think, and we got Qualcomm to patch it over in
> > software.
>
> This sounds like the issue should've already been fixed in firmware,
> right?

See the original patch:
https://git.kernel.org/linus/2dc016599cfa9672a147528ca26d70c3654a5423

"Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029."

That patch was only tested for QCA6174 SDIO, and the 6174 firmware has
since been updated. So none of that really applies to QCA9984. I
suppose your device was also not working before v5.6 either, and IIUC,
according to Qualcomm your hardware is a manufacturing error (i.e.,
invalid country code).

I don't know what to tell you exactly, other than that the original
patch was wrong/unnecessary (and broke various existing systems) so it
should be reverted. I'm not quite sure how to fix the variety of
hardware out there (like yours) that may be using non-conforming
EEPROM settings. It would seem to me that we might need some more
targeted way of addressing broken hardware, rather than changing this
particular default workaround. I'm honestly not that familiar with
this Qualcomm regulatory stuff though, so my main contribution was
just to suggest reverting (i.e., don't break what used to work); I'm
not as savvy on providing alternative "fixes" for you.

(That said: I *think* what's happening is that in the absence of a
proper EEPROM code, ath drivers fall back to a default=US country
code, and without further information to know you're compliant,
regulatory rules disallow initiating radiation (such as, an AP) on
5GHz.)

>  I've added the relevant dmesg
> snippets though in case I'm mistaken:

With what kernel? That looks like pre-v5.17.1. The "broken"
(post-5.17.1) logs might be a bit more informative.

Sorry,
Brian
