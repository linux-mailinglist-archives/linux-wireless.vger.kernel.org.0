Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460E53E3B5A
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Aug 2021 18:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhHHQYp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Aug 2021 12:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhHHQYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Aug 2021 12:24:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D9FC061760
        for <linux-wireless@vger.kernel.org>; Sun,  8 Aug 2021 09:24:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g30so24548246lfv.4
        for <linux-wireless@vger.kernel.org>; Sun, 08 Aug 2021 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F9+smH8nyFFNHmNU0JQuCmJBat4ou6HiWHivLLf7U/o=;
        b=avwM7ZwWmJ4lBi/gmD8T+olCfTjnbzkXTER50hdejXrea7ACwwSe8pnXK6L9dTfn7M
         RnXvuTLojUlQtX4lLoHYyAf643DkPkUZDeJp6zCp/7lmZwzxLahWVMIuzwHmyH9uvsN1
         jsCkloOx0xTrG/yjtJ5tvjVtFHGAwhjKf8Bd2jki8+QYKVG5hyLMWbcjkPOOTxXCS03A
         4DmqQnA274xpH/Rnj/ABJbaKxvqMAc6ElI6p68lZp6S1C3f5LeJKxmylPZTsbBvY/TCl
         RsBhP+QCfV5MuixqNjFOpFy+qpqO5sYsHThijbkc+Blotdg0HxwszxGAQ/k+6YrUO3/W
         ZRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F9+smH8nyFFNHmNU0JQuCmJBat4ou6HiWHivLLf7U/o=;
        b=AtZInxuIiNxpMJO1H4gryeZDSuqy1lYyujO+sXwOPwft+/DOEZlW0Lg3PHvwvggWqP
         u0swxeQCMHSQv+4lt5WihVrFX4jV9EKVQMp1PC+cQ2c/JH3hm/gsMK7s46gijYtjlVyk
         XrHeeQHEcrdzvJ+RRPGbvIPch942EFzZmFPEqyhiasGgGAAUNq9IcMb2jhVqKiSpK2pZ
         9U0Dsts/8M+AlMt3SgDLajJMbYqY5XdOcBKxOmWFzkF9VoVg31UM87s5m4RYxU6l3Wog
         xg2rGEFPTitrcdPpp7hAz9YxN9PrVEaG2Lupg08/VThBjPKO42mjDCHrH7f+oLNtzNoX
         7JzA==
X-Gm-Message-State: AOAM531TblGhWV/rrKjxAAImtcePhqkzXG8q1Vf5oo01/iqbVB/yzgN6
        +crvC0ir4Pe1w0mje3eRnlw=
X-Google-Smtp-Source: ABdhPJxtdnYfD+ekPzO3VUAFX9/1yVDBaw2CG+NR2qscFbaLNwgXLdaM4JwZ4t/eJVM7ePdXRMG8lw==
X-Received: by 2002:ac2:4569:: with SMTP id k9mr14111455lfm.178.1628439863507;
        Sun, 08 Aug 2021 09:24:23 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id s18sm1328117lje.25.2021.08.08.09.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 09:24:23 -0700 (PDT)
Subject: Re: [PATCH v4] brcmfmac: firmware: Fix firmware loading
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-wireless@vger.kernel.org,
        Stefan Hansson <newbyte@disroot.org>
References: <20210808142857.7451-1-digetx@gmail.com>
Message-ID: <1cf18f9d-b723-3f7e-f18f-72afce9b1b9f@gmail.com>
Date:   Sun, 8 Aug 2021 19:24:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210808142857.7451-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

08.08.2021 17:28, Dmitry Osipenko пишет:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The patch that would first try the board-specific firmware
> had a bug because the fallback would not be called: the
> asynchronous interface is used meaning request_firmware_nowait()
> returns 0 immediately.
> 
> Harden the firmware loading like this:
> 
> - If we cannot build an alt_path (like if no board_type is
>   specified) just request the first firmware without any
>   suffix, like in the past.
> 
> - If the lookup of a board specific firmware fails, we get
>   a NULL fw in the async callback, so just try again without
>   the alt_path from a dedicated brcm_fw_request_done_alt_path
>   callback.
> 
> - Drop the unnecessary prototype of brcm_fw_request_done.
> 
> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Cc: Stefan Hansson <newbyte@disroot.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> ChangeLog v3->v4:
> - Added brcmf_fw_request_done_alt_path() callback to replace the
>   "tried_board_variant" variable, making code cleaner and errors
>   handled consistently.
> ChangeLog v2->v3:
> - Rename state variable to "tried_board_variant".
> ChangeLog v1->v2:
> - Instead of using a static variable, add a context variable
>   "tested_board_variant"
> - Collect Arend's review tag.
> - Collect Tested-by from Dmitry.
> ---
>  .../broadcom/brcm80211/brcmfmac/firmware.c    | 24 ++++++++++++++-----
>  1 file changed, 18 insertions(+), 6 deletions(-)

I'm now wondering whether we also need to specify the 
MODULE_FIRMWARE to cover the board binaries.

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 97ee9e2e2e35..e7150312d186 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -625,6 +625,9 @@ BRCMF_FW_DEF(4359, "brcmfmac4359-sdio");
 BRCMF_FW_CLM_DEF(4373, "brcmfmac4373-sdio");
 BRCMF_FW_CLM_DEF(43012, "brcmfmac43012-sdio");
 
+/* firmware including board-specific binaries */
+MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-sdio.*.bin");
+
 /* firmware config files */
 MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-sdio.*.txt");
 MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.*.txt");


