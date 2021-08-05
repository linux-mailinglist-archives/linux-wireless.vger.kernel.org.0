Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180B13E0C0E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 03:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbhHEBXL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 21:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhHEBXK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 21:23:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16215C061765
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 18:22:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f42so7776205lfv.7
        for <linux-wireless@vger.kernel.org>; Wed, 04 Aug 2021 18:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bltuF2//lN0RwIpoXHj2UV+Rix6dkOwcfgrgodgcNKU=;
        b=SOcFGwbYGP8hHZN3D0wa465sPwYS4qM2o+sLsTBBSVw7rLDeCdfh7lJ9CfHUWQ1+HJ
         pF1Izy7LrOOgCORK4rRx0r27QnWeWIfqecapncdT+8acxLrWzH6AlRxeKL1Mw/rsQM7Q
         NPjBPtYtg2ZmP/UrIo59mnzQBAKL4nZ3WVDWdO0+ChVtdPcmJibiWbadiQVVEIFy0RWr
         ew9gz/TQhCPp0Y3V5mY50jp0YUR/5Uq0vXmS19AZk38WE4SDqz7TQWZzgN7u9dDVaiZo
         jd2O5rc6Ox+xebiDaHLUyaFxS8NYBzFxznglmC82NeP1oiD4pc3Y3C1DyURwF3UbUJ/k
         Xs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bltuF2//lN0RwIpoXHj2UV+Rix6dkOwcfgrgodgcNKU=;
        b=YsrybrIj6YPcNtKmzv6GCGtkNTn6SUGGI+0Lamina0LaRrV/hnQV72ZxU/EXH8u51c
         Gy7QEOaO8A5vUwzMLKVCSB9HqYO12e/KfwHk9Tg+XR+d8wmuT7t/3EDDC7TdWBWzNsB0
         z29rlWMPb8d73kCYWw86ltK6v8hU8pGKFwzU0tpoPtJnpYVnfgx5un5R1E8ogEb6xGVx
         XUsabgT7xbB/L2JGvieh9t+xAujzn8lGhiItXSvCkwUoKfI8hkSC85B7XnuMBUO7Z8LK
         U4LZ9lOZjj1V42Z60rtaAkVOJNeUdEXA9oSrhrRQGjrJWl4y2o+JS3thfifE0qIxW6cQ
         fs8Q==
X-Gm-Message-State: AOAM531qIe2ukJLjhEH5K/0wFfHHISjtXNKIGMwnaeqebdh2oADKnZHQ
        2U9b/NM57pfCguWdZpTMcSE=
X-Google-Smtp-Source: ABdhPJzS3nS8Gho9+oTdcPrkF8eY0dxe2Je3c4ng5pEefQkrTZ/bo5Z2fqWsgNxD+q+e6pLxzj3agg==
X-Received: by 2002:a05:6512:61c:: with SMTP id b28mr1582481lfe.415.1628126574105;
        Wed, 04 Aug 2021 18:22:54 -0700 (PDT)
Received: from [192.168.2.145] (46-138-65-182.dynamic.spd-mgts.ru. [46.138.65.182])
        by smtp.googlemail.com with ESMTPSA id q66sm288817ljb.83.2021.08.04.18.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 18:22:53 -0700 (PDT)
Subject: Re: [PATCH v2] brcmfmac: firmware: Fix firmware loading
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Stefan Hansson <newbyte@disroot.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
References: <20210804153434.3429348-1-linus.walleij@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <67ba8440-8f39-daa0-ef39-e506007fd46a@gmail.com>
Date:   Thu, 5 Aug 2021 04:22:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804153434.3429348-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

04.08.2021 18:34, Linus Walleij пишет:
> +static void brcmf_fw_request_done_first(const struct firmware *fw, void *ctx)
>  {
>  	struct brcmf_fw *fwctx = ctx;
> +	struct brcmf_fw_item *first = &fwctx->req->items[0];
>  	int ret;
>  
> +	/* Something failed with the first firmware request, such as not
> +	 * getting the per-board firmware. Retry this, now using the less
> +	 * specific path for the first firmware item, i.e. without the board
> +	 * suffix.
> +	 */
> +	if (!fw && !fwctx->tested_board_variant) {
> +		fwctx->tested_board_variant = true;
> +		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
> +					      fwctx->dev, GFP_KERNEL, fwctx,
> +					      brcmf_fw_request_done_first);
> +		return;

The original code was proceeding on error. Is this a typo here?

if (!ret)
	return;
