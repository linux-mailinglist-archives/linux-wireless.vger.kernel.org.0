Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FBC451531
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 21:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350900AbhKOU13 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 15:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245032AbhKOTSY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 14:18:24 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D9BC0F26FC
        for <linux-wireless@vger.kernel.org>; Mon, 15 Nov 2021 10:07:10 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id v3so36602069uam.10
        for <linux-wireless@vger.kernel.org>; Mon, 15 Nov 2021 10:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vB+zIqT8j5KAmMYaveBxOOzpPrma7xI98QigkHD3iI=;
        b=gqe8QktpnI8roZW6KYNIJ8/Y3W+h9FdUQFhjv4LLFmF4r7WVG9lQsHrTF7svpN/BhL
         2Xob79i9j88j+sounItEVWNvwgCaWLLPsSgBmQpNwGiwSD3CMI6G1N+c+SNztt6lRJhq
         RnW1tLqHJB8fk398dIQWe2hWIhhK9+dEU/REir4/MBQ01ZYGmbFOEMhsI7ynzhPeu9sx
         FfTDaMuJIl2td637xy+xG08kPkQkElJdaq3BlghkTYoulKa4zPkkkJfQmR9a+BRNy7yI
         X2wr41kZxvxoqj0xjsGtHKZ59G/oSb1OZFT92U7MPMGvTR+RFzY1dUbte74f3hAG25Ek
         WDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vB+zIqT8j5KAmMYaveBxOOzpPrma7xI98QigkHD3iI=;
        b=wX0pa1rAuZlG/wVcNVN9UjakN4j3NldZLbsIGrw0OzsWalcS8rG1GjRN0vj2I1ZsDZ
         JkoM7DX8mEDidnUTxQ5OeDDOsoXQNdG9SGEg2hxP/i5qR8VHmhlBYU7iPzdS6hm0Ap+y
         RY9uML46iF4c0xDLgYgXdR0EGpLBQ/4iLj9e789BFbDxZnP+yhb67nTsiZWpmIY1Lqmi
         VJQYhFWxQEA7RbsdYO3/qtW0fAGIcQ/jNZzSzwgk651TiepciNBEd1dtQ5liY9dYVdNo
         iH+QWa14bseWmYfJk5c9gO2cdd8mCjOsSCzQ8w4epvKqfKo94gEBPXHZexm/lCh/Oh+L
         t57Q==
X-Gm-Message-State: AOAM531+Ncz+cVDQ6IW/N5VJZDiPICLPsdpmt0j8AKg3reCg4mt+ZWsr
        QIGIyHGscNyx1O3AOGUUjVqE9HOvE7n+NkZJC5Y=
X-Google-Smtp-Source: ABdhPJxtzClkhrcNVb3o9Us9cwloMc1jwPxkiagE/ZZvAFUP3jjEaER5poFGYF/dubVwUxM6DtNzsmV1eKWoBnKMs1g=
X-Received: by 2002:ab0:6f47:: with SMTP id r7mr1012299uat.85.1636999629868;
 Mon, 15 Nov 2021 10:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20210915160422.2839595-1-festevam@denx.de>
In-Reply-To: <20210915160422.2839595-1-festevam@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 15 Nov 2021 15:06:59 -0300
Message-ID: <CAOMZO5AYUxJg4bWudT3L1P=qNR2UBcNR1zmjCf5O9_ExyPw4ww@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Clean the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE flag
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Fabio Estevam <festevam@denx.de>, wgong@codeaurora.org,
        ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        erik.stromdahl@gmail.com, alagusankar@silex-india.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On Wed, Sep 15, 2021 at 1:05 PM Fabio Estevam <festevam@denx.de> wrote:
>
> On an imx6dl-pico-pi board with a QCA9377 SDIO chip, the following
> errors are observed when the board works in STA mode:
>
> Simply running "ssh user@192.168.0.1" causes:
>
> [   55.824159] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
> [   55.832169] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
> [   55.838529] ath10k_sdio mmc1:0001:1: failed to push frame: -12
> [   55.905863] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
> [   55.913650] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
> [   55.919887] ath10k_sdio mmc1:0001:1: failed to push frame: -12
>
> and it is not possible to connect via ssh to the other machine.
>
> One user inspected the size of frames on Wireshark and reported
> the followig:
>
> "I was able to narrow the issue down to the mtu. If I set the mtu for
> the wlan0 device to 1486 instead of 1500, the issue does not happen.
>
> The size of frames that I see on Wireshark is exactly 1500 after
> setting it to 1486."
>
> Clearing the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE avoids the problem and
> the ssh command works successfully after that.
>
> Tested with QCA9377 SDIO with firmware WLAN.TF.1.1.1-00061-QCATFSWPZ-1.
>
> Fixes: 2f918ea98606 ("ath10k: enable alt data of TX path for sdio")
> Signed-off-by: Fabio Estevam <festevam@denx.de>

A gentle ping on this one.
