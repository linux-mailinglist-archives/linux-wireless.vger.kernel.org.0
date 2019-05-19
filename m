Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C322797
	for <lists+linux-wireless@lfdr.de>; Sun, 19 May 2019 19:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfESRTf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 May 2019 13:19:35 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51407 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfESRTf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 May 2019 13:19:35 -0400
Received: by mail-wm1-f54.google.com with SMTP id c77so9494926wmd.1
        for <linux-wireless@vger.kernel.org>; Sun, 19 May 2019 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xkxGVcb/77uzRi9cmphx8JSnSWCsLlQ9QImuGf0r2IE=;
        b=ROhtCdJa3qfV4yIDib/kA/GIp9fvd/eUOPU0QV9RHfkHv5jrn3sjqY4sQTSk0SuL7Y
         LcDwxcsJfXBr5QImgbNR+rcXHsS3ylkU6rOKAUhQp+ESPqIQpEHwqYR1/PLbp1Q0THYF
         1mFBR2trT/inMXu+7ZE2Ox2UOAcC+lhrEkpsuq1Jc6D/Fpbv+Sr4tiuX1m0PkpoGfx9L
         A5ObRv19kw26fl6dNazvVwWWiuCMCcfYSZp2XTTSmMVAu3LjENEcnJ3JRbVJNAB6J35d
         XeCWIiHBKTkIvOyY7aJORquGYX6n2pg33ZZrtU5dy0RPq2M+ZRTbUV8Kxu6voR5IgJx9
         /Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xkxGVcb/77uzRi9cmphx8JSnSWCsLlQ9QImuGf0r2IE=;
        b=kpwrzGNFf06DHUy9jkVHMZ1zJYddIQzigadCeg49gp9yxtzxjC3LTXdW8EgeH4v+Fc
         xlnf4XHhK97DNnQdwEYik8MUfMVXawq7tL6W2JTPlpt8njzlHIG6jB3lFcn8gOapNPEs
         tENs3ZpiuhLUk5S7KVp7MhtNnCTPedKZCw50XyEnj1Jw78BFk8DPCw8KXSK2WNwEk8Iv
         iKvXWx37Re+QXV+vYVs0d/PlU2ikjFvJzPReByPq5SnF1KShf6lHnOcvxesWNVGZ++QS
         j1CJyVqX3fz+YOV3mggG/D+onk5Mrvtm971sPSCMSD/ZhtTcg6EyXm3/LoEhjgZzbVBU
         hlmw==
X-Gm-Message-State: APjAAAUcQCOgLVjJx0O4vdNkOdN8xbP/Rm4QHvG7ywfvYjYsYY0Wu7/E
        MZR7OcEqjLjAqihL0Vyays9R1FklaLi/mw==
X-Google-Smtp-Source: APXvYqySHDycEg9IZP1aFaVeWvf5z9VF77Q8YdVuLrMQgpB2nEfMz9SfosOPjJphGWXmphBWq6KejA==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr2347418wml.31.1558284414974;
        Sun, 19 May 2019 09:46:54 -0700 (PDT)
Received: from [172.19.45.184] (static-186-95-145-212.ipcom.comunitel.net. [212.145.95.186])
        by smtp.googlemail.com with ESMTPSA id s11sm26734340wrb.71.2019.05.19.09.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 09:46:53 -0700 (PDT)
Subject: Re: NXP NFC version and ACPI
To:     sedat.dilek@gmail.com
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        oleg.zhurakivskyy@intel.com, clement.perrochaud@effinnov.com,
        charles.gorand@effinnov.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
 <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com>
 <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org>
 <CA+icZUXDLQKyTH-_pPi7A2=Bu5ratwab930Fcecrdr4NtMnFcw@mail.gmail.com>
 <27f2ce02-8deb-384f-af10-7737b703770a@linaro.org>
 <CA+icZUVaBdswfmRfbRtdVJY8ymeDOwDSFEf7G6jneqEmpW84bg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <525160f3-a76c-4b45-2e05-c27aaabbf74d@linaro.org>
Date:   Sun, 19 May 2019 18:46:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+icZUVaBdswfmRfbRtdVJY8ymeDOwDSFEf7G6jneqEmpW84bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


FYI, when I tried to make the NFC work on my x280, I tried the module at:

https://github.com/jr64/nxp-pn5xx

AFAIR, it finally worked somehow.

May be you can cross check with your series and the change in this
module to find out what could be missing? (I can do that but it will be
certainly easier for you spot something in the code you wrote).

I can experiment your changes in my laptop if needed.


On 14/05/2019 16:59, Sedat Dilek wrote:
> On Tue, May 14, 2019 at 10:17 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> [...]
> 
> Just for the records:
> 
> root@iniza:~# rfkill --output ID,TYPE
> ID TYPE
>  0 bluetooth
>  1 nfc
>  2 wlan
>  3 bluetooth
> 
> root@iniza:~# rfkill list nfc
> 1: nfc0: NFC
>         Soft blocked: no
>         Hard blocked: no
> 
> - Sedat -
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

