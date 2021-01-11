Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F124F2F11C0
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 12:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbhAKLp5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 06:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbhAKLp5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 06:45:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAE7C061786
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jan 2021 03:45:15 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c124so13522584wma.5
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jan 2021 03:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kq2BYChqKF8bwxscQEMvKxiK0ZMhVQt2WZ5WnMw9HwA=;
        b=y/9uYpnr1aCQHPcanbNm2fhtkzOcBntCw5swBbKzXoxM2v6KscE+jvacJimtPJnPPl
         wjF70X5+lSq4Pe3b/w6LRftokWl2ZzU9in7NXlHoZWVyesnad4/m/CWXwmxpivSK5Trk
         UMqSFMHqEZNcZNy2C0zEhqVPzozhMNi0QX//0h5JoNQnzn2g3YQTaed96RNwjcuaUO/s
         pM9mn9AHPtvhjd7zYYF7FP+bOOW4JsRjVPkE9DZC+GQP84JsKpi9b0Vz/+q6DEuXw8+g
         ig+EbPOX7oDYU64plMFsLQ8Y4uijkeZNLus1zmL2lb7sBT+X8cEivK0OC0M3C5pgvkno
         4mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kq2BYChqKF8bwxscQEMvKxiK0ZMhVQt2WZ5WnMw9HwA=;
        b=nbf1ai3PiqQzaW4NVHPBl59+MRuonUZRzAOF7NuVI5OGRtIHk9X2mwg6cc07iuxOkl
         4vDOautn+d19LsiH8REDpUQrh85Fm2jJNv8LPWgd7Eb5k6FCnIP6/kIyNNgAinOgLKS9
         uA7TJs/A61Ljce/bbipuozdCdxZctQeDAQPBgS/iqZQmkEbyS4zDNsE4z1daBaKKak6M
         xvChYzPur1+7JYZr0UN2Pr5y9qeJX1Dvvjk7+x+I2zZ4ANvW9MeGsdJSt0gBZRLxHX3u
         mLvAp0LRgWD/H0TVJofygUS0XUCiUIcIq+fIkDsCxnI/WnWkZTzLNqsIhXf6Vv2SxtNk
         mXdQ==
X-Gm-Message-State: AOAM530Q9YdutqEg+YMPLOH29ARXgD2GCB5LxOVSyTHblj/+8ntVMT06
        xLsjop/N4kjdcZ+hA1+YN+bgXQ==
X-Google-Smtp-Source: ABdhPJxAAWCKyaUr9VIf9dK8+BKB5nTufcc4t1jvCp/cua0fuLC74WJ6B/CF2+VaQntuCjn1FE0cJA==
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr14339399wme.41.1610365514503;
        Mon, 11 Jan 2021 03:45:14 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m18sm23978474wrw.43.2021.01.11.03.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 03:45:13 -0800 (PST)
Subject: Re: [PATCH 11/13] wcn36xx: Do not suspend if scan in progress
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
 <20201228162839.369156-12-bryan.odonoghue@linaro.org>
 <87wnwjk8w7.fsf@codeaurora.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <d74c7eaa-3f3e-9eef-8c2a-59f5720c4232@linaro.org>
Date:   Mon, 11 Jan 2021 11:46:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <87wnwjk8w7.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/01/2021 11:31, Kalle Valo wrote:
> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
> 
>> If a scan is in progress do not attempt to enter into suspend. Allow the
>> scan process to quiesce before proceeding.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> Why? I would have considered the opposite and if we go to suspend we
> cancel the scan. No strong feelings, just don't see the need for scan
> results during suspend. But of course I might be missing something...

We need to be switched to the AP's channel when calling the suspend 
routine. During a s/w scan we switch off channel to scan for 100s of 
milliseconds.

If the suspend() routine is called while that is true, we suspend on the 
wrong channel.

So we would need to switch to the right channel explicitly in suspend 
but, at the moment wcn36xx_config() for switching channels and I thought 
it best to leave the channel switching logic in the one place.

I'm not opposed in principle to

- Entering suspend
- Switching to the last known active channel
- Suspending

---
bod
