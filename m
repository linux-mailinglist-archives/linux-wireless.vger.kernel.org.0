Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA2440AE7
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Oct 2021 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhJ3SLH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Oct 2021 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhJ3SLG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Oct 2021 14:11:06 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63902C061570
        for <linux-wireless@vger.kernel.org>; Sat, 30 Oct 2021 11:08:36 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x16-20020a9d7050000000b00553d5d169f7so16905152otj.6
        for <linux-wireless@vger.kernel.org>; Sat, 30 Oct 2021 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HtmEJT6/085hefLqlC/l4EXVy9+WuvmexfYarfEXUnE=;
        b=nYRvNj9LR+RqFJhYkJhixSeQWIg78aBSnwbBl5GIw+gA9843NOGTO5gv6ZX3UwqbjH
         jZXsEj5/Wjz6UwrlbV+3rMZPRLUTMSc7iExKyFByHoWs7t87G1xrPyOEcImoZqRuGxGL
         hXe4cabniWbcU0SmxjlItkLwC5r9le0iLxhC3uVcM9dQRUxp2MC9fbGrrQz73fJlq6Nj
         XDwSJFAixxEEHVCFVylq0W1uj+xqvPpQ1wmQfKWsiFVA141U/F38xfvwLb16+e2Nl8ZQ
         9sykcUByx6wGBYjnPUgSIukkJMf7SQKKNcIROpXK4GJoZonapPD7NfV6JtM9GhJK8Ylw
         R1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HtmEJT6/085hefLqlC/l4EXVy9+WuvmexfYarfEXUnE=;
        b=nS/Li+R6Gw0cx5mvJGD2ayK1hKrg0u6GU19B+WkgHH6GI8giFWrlXwAIFkBpa6IQ2S
         ks2c46MuvnkoeFJT7StonyoecxDMVTD7Iokt8qQXTj24CCZ0CDjX5ZvIEnixubQgQ/z7
         aW9cRmrmqwokD6FFPl3G9XngxA7q/4hH3keQ4+CiiGuxDCZ6amVD8ZoR9gsVF5vWycI0
         F/Fzla8zmSXvuhg3Wz4TAiu3ae7oKBxql5ntctPhwQ19stsByN91hmPAsuREHyPbRmxK
         +yZa7TBQVa++poMKi9B5z3FPF6L02PzcVd2+qCBzgJSGAGq6UIJgP7ZXtgNlY79eh5vb
         PABA==
X-Gm-Message-State: AOAM5311LPXpX17cWCAELhhZSxZC6Hnrf6Hz2WxVQqbP2+s8vHShPyHP
        zKMqZ0thnP1usc86ZqkoaaIDR5ybZ17aXz++
X-Google-Smtp-Source: ABdhPJzAUEOccpkzbs58NPUvEWrQ+qIscn1AWaTCFRXLxVwcowOhXDpwhJJAukdx4EO8x01Skqi17A==
X-Received: by 2002:a9d:4d04:: with SMTP id n4mr14496259otf.363.1635617315677;
        Sat, 30 Oct 2021 11:08:35 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::101e? (2603-8090-2005-39b3-0000-0000-0000-101e.res6.spectrum.com. [2603:8090:2005:39b3::101e])
        by smtp.gmail.com with ESMTPSA id m13sm1784432ooj.43.2021.10.30.11.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 11:08:35 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <7e39369a-2e27-cc82-9c90-ba7ce2554d86@lwfinger.net>
Date:   Sat, 30 Oct 2021 13:08:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: WiFi card not supported
Content-Language: en-US
To:     sladyrko@dir.bg, linux-wireless@vger.kernel.org
References: <1635611921690688929@dir.bg>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <1635611921690688929@dir.bg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/30/21 11:38, sladyrko@dir.bg wrote:
> Hello, I got a new laptop and my WiFi card is not discovered.
> This fixed it for me but it's inconvenient to make it every time I update kernel : https://github.com/lwfinger/rtw89 , please add the drivers in the kernel. Thank you.

I am already regretting publishing this E-mail address to the rtw89 users at 
GitHub!!

In the README.md at the GitHub repo is the statement:

"When you have problems where the driver builds and loads correctly, but fails 
to work, a GitHub issue is NOT the best place to report it. I have no idea of 
the internal workings of any of the chips, and the Realtek engineers who do will 
not read these issues. To reach them, send E-mail to 
linux-wireless@vger.kernel.org. Include a detailed description of any messages 
in the kernel logs and any steps that you have taken to analyze or fix the 
problem. If your description is not complete, you are unlikely to get any 
satisfaction. One other thing - your mail MUST be plain test. HTML mail is 
rejected."

Your description is far from complete. In particular, you fail to note what 
distro and version you are using. In addition, you are not reporting a failure 
of the driver.

Apparently, the following sequence, also from README.md, is too inconvenient for 
you:

cd ~/rtw89
git pull
make
sudo make install

In that case, you should research the use of DKMS (the configuration file is in 
the repo), or switch to a distro that already includes rtw89 in its kernel, or 
as a standard package. Two examples are openSUSE Tumbleweed (in kernel) and 
openSUSE Leap 15.3 (package). I am sure there are others, but like you, I do not 
like doing much research!

As to your request, a simple web search for "rtw89 linux"would have found the 
following:
https://www.phoronix.com/scan.php?page=news_item&px=Realtek-802.11ax-rtw89
https://www.newsbreak.com/news/2404818553553/realtek-802-11ax-wifi-driver-rtw89-queued-ahead-of-linux-5-16

Those articles report that the driver will be in kernel 5.16. That may not help 
you for some time, as most distros run kernels that are far from "Bleeding 
Edge". In addition, kernel 5.15 is not yet released. Once that happens, there 
will be at least 10 weeks more before 5.16 would be r3eleased.

Larry
