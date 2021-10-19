Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E24F432B31
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 02:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhJSA2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 20:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSA2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 20:28:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AFEC06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 17:26:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r10so44349149wra.12
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 17:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=9p8k4W16yh2rAlFMXFXO/asOzC99hZZfp/jxSe+3iQ8=;
        b=JAJ1V9DMShBRDjCWfaSpHvr+re6vXZfIoll+S5weD8HorrVJiwk/3NzIqwVGcd9udt
         lTEcxMw0uW74DIi/Iro6ppIvXGPPyDDv6QuXDanhEHPAWk7rD/7pA51e6UbYsp9ZIPOT
         1fO5ZzMQqjmlRZg/kdaLR8GjJQ5CWMz1fTV65AbnyRpZjAn3nxYWgueMmN1ptZvbv/Re
         96N3s2SgGQ8UuVVur8WQ/hYcU5J5vXf8C0y6uz91UQJLSt8C753Hp6qSNYC88Ii2l32G
         K9GuWBkGdhxxoVv9bxQvzh7CUzrxgeWVJNNF6XvdL/AimSm71DjZtrwt0GPWI4e5dgf8
         dJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=9p8k4W16yh2rAlFMXFXO/asOzC99hZZfp/jxSe+3iQ8=;
        b=YYeBMugyBffLcTz2IQVm/IgvCgWeOEQJE5/+IY/2nt8thvnN9JQU65+H6oPKdLUSgN
         7C3kXgyrMBaSLuPNtU4HNEceLho26PkdkIdyh3ENeORf6Jv7cb9BHwlEtwZsps4QAPwt
         p+jxtY+XgMrXrFkkAHyw+hrQPyn4gTWZIL6EcdzBmq1tNxigU3dnuTa49bRH7cYmG92w
         +VK46PbakOGJ+ympsZRVlywDTWiaEm2rXZzeJ4AZxmKFdJKbEpbL5YO9x0ErdajKeTC8
         yuMZ47dE3R6b2kV+KJcz1GQzdC2hhxEHn5LEKW2NOvmPisAptlkde/PcG+6/9fZ4V0F5
         +K6w==
X-Gm-Message-State: AOAM531+0RTxTH7z+loHmdvrkjScvydnQ7uQkEmDG0xqMBR1JNnK3rM3
        zmeLXIM+X/lZAt78a80ca60a/w==
X-Google-Smtp-Source: ABdhPJyljTcUObqFlaEmWM9yICbkss0kziqVClkI9ELFQ5FHeSJfG6/wnG9Ns6ThnwrNLOSkeyAwig==
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr39507452wrv.171.1634603199874;
        Mon, 18 Oct 2021 17:26:39 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm2751818wrr.60.2021.10.18.17.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 17:26:39 -0700 (PDT)
Message-ID: <5a325d84-0d02-237b-a0a3-9eddd2e481de@linaro.org>
Date:   Tue, 19 Oct 2021 01:28:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 1/2] wcn36xx: Correct band/freq reporting on RX
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>, kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1634554678-7993-1-git-send-email-loic.poulain@linaro.org>
 <d2128789-646f-1e02-0dd2-a9ac14b37cf7@linaro.org>
In-Reply-To: <d2128789-646f-1e02-0dd2-a9ac14b37cf7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 18/10/2021 23:51, Bryan O'Donoghue wrote:
> On 18/10/2021 11:57, Loic Poulain wrote:
>>           ieee80211_is_probe_resp(hdr->frame_control))
>>           status.boottime_ns = ktime_get_boottime_ns();
> 
> I think this is dangling in your tree, doesn't apply cleanly for me anyway
> 
> Other than that
> 
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Hmm.

I'm told by a colleague with access to a router that has channel 144 - I 
do not BTW - that 144 is not showing up with the firmware offload scan.

We should probably hold off on applying for the time being :(

---
bod
