Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAF23E0C2C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 03:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbhHEBpB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 21:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbhHEBpB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 21:45:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A66C061798
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 18:44:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h9so4876901ljq.8
        for <linux-wireless@vger.kernel.org>; Wed, 04 Aug 2021 18:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EKlnp45pcNqPON8PnE65HNTmjyovSu1kzs8bqYr1SpE=;
        b=SPBB7ytNsoAC7LvJoToTUNikQHk1/XBSLm8lv/lb6jIqH9pdXJlupdV6UsrWuVfy5U
         Qd+0JJZOGnhTWbRYyQzmEAvQY6CzqPx+npU5rYe1KL1KW0pIFF4O+2pKCrBERWmCsL1n
         HCJ/UQiYxhIU4F9VoBtoXjVw6R7NC3V+ek1pk5NHQh+Gk/uzMEMv3spMDcfP+m/NCRiK
         Lee3I2l1AGTt6MB9gf+ZlVncTXCwCe3fQuYk+KLEkce5pEuEkVejDATUQm7W+r9vcD9G
         dWX38GiB3pHf8BBATHAaCfshgHQOC4f8au8vcpcL/4ELKZaYyEfqrHX4my2sqP2G7yt1
         0JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EKlnp45pcNqPON8PnE65HNTmjyovSu1kzs8bqYr1SpE=;
        b=cEUElxpq+Et8Vm8SxdKDWblC37Ms3wkVsk+F5ogKYtcJvvxx+xQ+FEZU0ZOz7Oyxte
         1DG+aBzBW2ide9Gka5y01uWeLuAbrk5Crc8iy2ZerncVirFU/o2ZezMI/6Ggq2BAytyL
         UNhv7t0JoZI1WE6pUVKlH5jHFsQCidbxtFD1nYE/UItDrmG379F+KAgsH9NvzCRPeGqs
         MvkS+5uTsxsdIhCC9VwZq+tdlrAZ+36TM2qxFu6qWxv/aDG16q9+irxE8LKIYiChDPz6
         O+4QcY7JRPcHROO/tX1dxjVphpQxYY/xTgoQ6nfWLjvbN1v6L3z+UziaIO/xBlMQ9Hb3
         D/sw==
X-Gm-Message-State: AOAM531j/9JrhcNdPDhDqWKFgJdlAcsQnS2u8HE8OGs+nxs54CDZqT72
        0BPNQR/TZMT/v3laUH+7HzI=
X-Google-Smtp-Source: ABdhPJwan1jWHlxdvquCwGdqwJ8Z0XOZe2dtJZGiRINivi/UmrI+gOWQ0NhuxGfd7FgsrosbanoVsw==
X-Received: by 2002:a2e:80c6:: with SMTP id r6mr1446262ljg.138.1628127884872;
        Wed, 04 Aug 2021 18:44:44 -0700 (PDT)
Received: from [192.168.2.145] (46-138-65-182.dynamic.spd-mgts.ru. [46.138.65.182])
        by smtp.googlemail.com with ESMTPSA id q13sm352718lfu.272.2021.08.04.18.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 18:44:44 -0700 (PDT)
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
Message-ID: <0f439074-83ea-087d-7eec-aa6d4d3d4689@gmail.com>
Date:   Thu, 5 Aug 2021 04:44:43 +0300
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
> +		fwctx->tested_board_variant = false;

This shouldn't be really needed, isn't it?

>  		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
>  					      fwctx->dev, GFP_KERNEL, fwctx,
> -					      brcmf_fw_request_done);
> +					      brcmf_fw_request_done_first);
>  		kfree(alt_path);
> -	}
> -	/* Else try canonical path */
> -	if (ret) {


> +	} else {
> +		fwctx->tested_board_variant = true;
>  		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
>  					      fwctx->dev, GFP_KERNEL, fwctx,
> -					      brcmf_fw_request_done);
> +					      brcmf_fw_request_done_first);
>  	}
>  	if (ret < 0)
> -		brcmf_fw_request_done(NULL, fwctx);
> +		brcmf_fw_request_done_first(NULL, fwctx);

This "else" can be replaced with:

if (!alt_path || ret < 0)
	brcmf_fw_request_done(NULL, fwctx);
