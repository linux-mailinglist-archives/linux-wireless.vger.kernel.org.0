Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EE13E0C1F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 03:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhHEBfX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 21:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhHEBfW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 21:35:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654E8C061765
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 18:35:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id m9so4853745ljp.7
        for <linux-wireless@vger.kernel.org>; Wed, 04 Aug 2021 18:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AjXSLkd7H7YYDtJulH4krIQq1Y0iBImwf2ezdniIkdA=;
        b=sHJcB4jXI1zcgqPOZbIRAPp1vjrO3w4XLO+80yQ1MuSzVrAV1xXi4+raix9RC4NhxR
         U5NGLYnBmO98IShasDNXUY7XCt02jwep11JHfp9yDdK2Eg9rUiv1b5cMFXGwZUN6mnih
         Gr0jul6O94GONM1N3GP2bbkBnqwI5MaWXW9EFM4euqjtgRfvjmFPB66ll06X7Cf07c4s
         uFxxwc8uyVPKRPN/Dz8LzXKbiGSPeOEVC87x3UBHIBpShnrjhhHwJgBt2v1otbyfGyh4
         ebJOkkxwL4VnvIcSzcEpMtIyjjrsJpgno2wWvtQk4a1nlM+q/2cQtZG7iS1vvW48Br2d
         /PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AjXSLkd7H7YYDtJulH4krIQq1Y0iBImwf2ezdniIkdA=;
        b=WRMJsT5mrNuG9Dy69/1/c14/9NbIlTE2IcQRHpyUrtRLY5HAIrwmy2fGvZTxMm393n
         r2wCk8EhkeytocY9XXaz6lYH4bO2HdIAopyUqoodYybeCsQYFjSv6ZuJWtbWkfQF4Fwl
         P0CuIAC21y48+JRkUzaaDECP07QE3N+3H1y1+dRjWYlT584cmuzjfVtsq0UoT7Hi+vIb
         dMk4v31VROzrrhkceSe99KZE6JSJraFdTyt5I84CsjXk2/2pfFRjq70urZBNvjuf9in7
         dqumOrKK9TMzhMdtZD974rKWd5EOSU5vb3M877yNNuveIXOI2zrX15jlhAL4nrGc5Klz
         3+cA==
X-Gm-Message-State: AOAM533MlNrYAHh6J8yCljYDKyRr0SRlj9VjXnRuUwa9062Z/oNldt0r
        vhe4ySU8HhbfH5DGXRLV6ss=
X-Google-Smtp-Source: ABdhPJxJs0S5Dx9r0YKKkwk2cKGfGp76xrV0JclngteQaqi1YprULQ3XX9G3z8R7SUfkqenjL+DDhA==
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr1357805ljj.329.1628127306755;
        Wed, 04 Aug 2021 18:35:06 -0700 (PDT)
Received: from [192.168.2.145] (46-138-65-182.dynamic.spd-mgts.ru. [46.138.65.182])
        by smtp.googlemail.com with ESMTPSA id y3sm280964ljj.121.2021.08.04.18.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 18:35:06 -0700 (PDT)
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
Message-ID: <74e24409-aeb2-5297-6888-7af2b1126ccd@gmail.com>
Date:   Thu, 5 Aug 2021 04:35:05 +0300
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
> +	bool tested_board_variant;

What about s/tested/tried/?

>  	void (*done)(struct device *dev, int err, struct brcmf_fw_request *req);
>  };
>  
> -static void brcmf_fw_request_done(const struct firmware *fw, void *ctx);
> -
>  #ifdef CONFIG_EFI
>  /* In some cases the EFI-var stored nvram contains "ccode=ALL" or "ccode=XV"
>   * to specify "worldwide" compatible settings, but these 2 ccode-s do not work
> @@ -638,11 +637,25 @@ static int brcmf_fw_request_firmware(const struct firmware **fw,
>  	return request_firmware(fw, cur->path, fwctx->dev);
>  }
>  
> -static void brcmf_fw_request_done(const struct firmware *fw, void *ctx)
> +static void brcmf_fw_request_done_first(const struct firmware *fw, void *ctx)

Is it really worthwhile to rename this function? There is no "done_second".
