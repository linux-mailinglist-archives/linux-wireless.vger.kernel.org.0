Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340E494C2B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 19:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfHSR6B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 13:58:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34250 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHSR6B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 13:58:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so2502639otp.1;
        Mon, 19 Aug 2019 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SPx17Q+G7qGGeLjARILuLl6TW51F+Z4DXKMa+q1QhGQ=;
        b=NCQb6hAhIGnsCpdzTs7j+nh0saNaP8AahXNLtJPcx1sEJlMVEaUUkdrJHEOBuIqTgZ
         NVXt998/bfTuQbaaYo1B+BNvEiAzmXxkp16nsDCBJQXJqaUEsn9Kewve9kBgmWebj8uT
         wbCqB6FZAGC/j9q+MVM0GZR2/9a5bLDKbneZhY59ofsCMutEW9ZpxeJSgArfpJTFGthB
         OXpUIP0rRSGRaZKM3oYHTEhTjfsdTR6crmS++gVDdHmqCYXY9ULwIj6pcQU3ZOAaJumZ
         JY/sfkFIud7yT9Uh5B1Nv3KEOMdktqW34TQke4QfT1EARCsB2CxEbY9QrVAv2a7zVGKf
         7fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SPx17Q+G7qGGeLjARILuLl6TW51F+Z4DXKMa+q1QhGQ=;
        b=P5/L+h3Xj3hdYocZ3W4390+jU6iz9Zk7fQi9y2xjaPtkdp6DHgfLWtc3oZzyenKdOx
         MQ8NcRjQrDaRS7q87vEQFrxRCpO3Kvgn08Z53VOm7ma7UkUON09IHNb/vg3MMFn2WcvF
         ICG6WY0na7fD51XI1VRjFJIhRIom+CSLSW9858cwE6pDY0I0OLSnXDBhBUPeW5Ha1iCB
         gBLwsYUja3bw0Ievl0KkdxWZ1ex5PZm/tIUsbZl8aVH3uxKVvG3X3LQLUOkjuTHmfapX
         i/EmW2hVUX+ZZH+pwSFnjn5LAGtX/SqCxTXJX1qaFWActs2yxnajZoJj6yLn1K37TorK
         XWZQ==
X-Gm-Message-State: APjAAAVq6qGLbhHXduDL5yZiUNd9js7pFYCBiD833B8XIJfv8jWbXLSX
        a2JLY31LxnbQDu0KfzGC27nXfa6r
X-Google-Smtp-Source: APXvYqyoPbNGTmlnGTEcpz7fO0lq6n2L2EKn43BGGRvx/2q3Uayz1zGl3G1y2NZkto8hfZQLFmFHeQ==
X-Received: by 2002:a05:6830:1592:: with SMTP id i18mr13058312otr.86.1566237480027;
        Mon, 19 Aug 2019 10:58:00 -0700 (PDT)
Received: from [192.168.1.153] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 20sm5706479oth.43.2019.08.19.10.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 10:57:59 -0700 (PDT)
Subject: Re: [PATCH 2/2] staging: rtl8192e: rtllib_crypt_ccmp.c: Use crypto
 API ccm(aes)
To:     Christina Quast <contact@christina-quast.de>,
        ard.biesheuvel@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Anushka Shukla <anushkacharu9@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zach Turner <turnerzdp@gmail.com>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
References: <20190816065936.12214-1-contact@christina-quast.de>
 <20190816065936.12214-3-contact@christina-quast.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <767c52c9-71ba-6639-631d-6f3cb0d6951c@lwfinger.net>
Date:   Mon, 19 Aug 2019 12:57:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816065936.12214-3-contact@christina-quast.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/16/19 1:59 AM, Christina Quast wrote:
> Use ccm(aes) aead transform instead of invoking the AES block cipher
> block by block.
> 
> Signed-off-by: Christina Quast <contact@christina-quast.de>
> ---
>   drivers/staging/rtl8192e/Kconfig             |   1 +
>   drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 187 ++++++++-----------
>   2 files changed, 78 insertions(+), 110 deletions(-)

Tested-by: Larry Finger <Larry.finger@lwfinger.net>

This change for the RTL8192E works. I do not have the hardware for testing the 
equivalent change for r8192u, but as the changes look the same, that one is 
likely OK as well.

Thanks for the change,

Larry
