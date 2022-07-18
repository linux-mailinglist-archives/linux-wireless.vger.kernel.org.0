Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FB5578BBA
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jul 2022 22:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiGRU35 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jul 2022 16:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiGRU3h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jul 2022 16:29:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC605BCB8
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 13:29:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w185so11693896pfb.4
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2K0FhOkxoPSlQLD2WY+lMGGddcsgjCNwFv767Hz5I6Y=;
        b=j3PfO4zEZFkjg7rbetiYnbs2c85iMYMuRNZdKXZNHmzaJZo9+opRNiu+O3nnTfY2DD
         6dq+IQX3dPLc9s+1V8WL7DGhcYytBFQ9jYkIIPggcm1B1UQ+8F2BXMWt4VNgKJSJHtZM
         p/Zo6epjXos66tBLEGzKwLq1E/jVEWE98cgJHSV25Bv/U6qMYbEJTdHHYCyY2WLmihFz
         eC0B2pwr1K/CPWjeTmNhbvmlUp2lw5qtvbvxTZVwZmE/UbwSZvmDVW25kisw/rJ7Ccro
         5VtOpI11uKASh9pEDduQL4eAzxuCbPSE7O3emKdy0UNr+lETW+VwnRGHZhPvi0f/jhRz
         1k3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2K0FhOkxoPSlQLD2WY+lMGGddcsgjCNwFv767Hz5I6Y=;
        b=2vazyjU8JObcmcHdCBQSMJaf5PYui/Z2Yzr/6zkv7VT0W/ZATTOoIfCkH3V834xLpM
         cpCl3QJso7Qc4GdKSNkGlUX4J9zMQ2ohhv9xN1qUo7MbC6dwYAF8KGgUpFyoxNKNWHiV
         nv6Sp1v2NMs7SPTOMVtCKB3+JmpZZ03/PnO0bafLM9kTDxE5nP1t1nZYOKvVIGrMcPrF
         L8SWQwwltAVNT4Hg4l2jrRZbctqqQrBturOMjw51PVmM+1kJ/D9svad52x+l3yw48LHD
         XSZtOt/5CbFw/idfZRzWIW+ezYNjfF7uLBa5+WQG1iRvqCSYoa0LOFX14GvGGTMPFMRf
         viXg==
X-Gm-Message-State: AJIora+kQchgreIYXy/e4btm2RgjCuLHK1bvxU22Q+xe5szOeQ0EYA5U
        DTuI8kPjaZ/4u5vMGIkam68=
X-Google-Smtp-Source: AGRyM1s0UovQ9K0yTeSUrmxZN8DBuSeiaiQnEKKL2MAUD48Yrud5qB4oIqy/I+AvKUH2iQYK+dJ7zA==
X-Received: by 2002:a05:6a00:238c:b0:52a:dcad:7847 with SMTP id f12-20020a056a00238c00b0052adcad7847mr30300376pfc.8.1658176176339;
        Mon, 18 Jul 2022 13:29:36 -0700 (PDT)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id z9-20020a631909000000b0041992864d69sm8497464pgl.77.2022.07.18.13.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 13:29:35 -0700 (PDT)
Message-ID: <0a2b1520-b5d2-8a19-b85b-62b7df77553d@gmail.com>
Date:   Mon, 18 Jul 2022 22:29:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] brcmfmac: prevent double-free on hardware-reset
Content-Language: en-US
To:     Danny van Heumen <danny@dannyvanheumen.nl>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
References: <id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl>
 <CAPDyKFpa6Z0Uhb0OnhMJ-KTQg5CQW93KMz1j1cQJS-Ho8FVhmQ@mail.gmail.com>
 <Jf288fBmG7i8omrWIg5n1dG3Ei2z8Cc-sPjQGVhBHbeHxN8OZYfMhPNX4kop3CpXz4dh7FBKtw-t29PO0MhIthA_030s1GhpnMlKjnAeies=@dannyvanheumen.nl>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <Jf288fBmG7i8omrWIg5n1dG3Ei2z8Cc-sPjQGVhBHbeHxN8OZYfMhPNX4kop3CpXz4dh7FBKtw-t29PO0MhIthA_030s1GhpnMlKjnAeies=@dannyvanheumen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/18/2022 7:17 PM, Danny van Heumen wrote:
> ------- Original Message -------
> On Thursday, July 14th, 2022 at 12:04, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
>> [..]
>>
>> That said, I think the $subject patch looks reasonable to me. So feel
>> free to add:
>>
>> Reviewed-by: Ulf Hansson ulf.hansson@linaro.org
> 
> I am a first-time contributor. Is this your way of saying that I should submit
> the patch somewhere other than 'linux-wireless@...'? I suppose this fix is not
> urgent enough for 'stable@...', or is it?
> 
> I would appreciate information on who will and/or how to follow-up.

Hi Danny,

The above means that Uffe is okay with the patch being included. Kalle 
Valo is the linux-wireless maintainer and he will apply the patch to the 
linux-wireless repo. The status of your patch can be monitored through 
patchwork [1].

By the way, you can add the Fixes: tag referring to the commit that 
introduced the issue. Not sure which one should be considered here, but 
it is either this one ...

Fixes: 9982464379e8 ("brcmfmac: make sdio suspend wait for threads to 
freeze")

... or ...

Fixes: 7836102a750a ("brcmfmac: reset SDIO bus on a firmware crash")

How to create the tag is described here [2]. With git configured 
properly you can simply do:

$ git log --pretty=fixes -1 <commit_sha1>

Stable patches have their additional rules [3]. The bus reset was added 
in kernel v5.9. Hope this helps.

Regards,
Arend

[1] 
https://patchwork.kernel.org/project/linux-wireless/patch/id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl/
[2] 
https://www.kernel.org/doc/html/v4.10/process/submitting-patches.html#describe-your-changes
[3] 
https://www.kernel.org/doc/html/v4.10/process/stable-kernel-rules.html#procedure-for-submitting-patches-to-the-stable-tree
