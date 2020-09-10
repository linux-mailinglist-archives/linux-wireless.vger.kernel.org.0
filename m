Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76F26492B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 17:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbgIJP4V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731516AbgIJPzV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:55:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090DBC0617A4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:54:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so7242723wrw.11
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AOxwJq+yWUZD+luTWXeI1wH9PdSPOQMP94YFX6uESZc=;
        b=lK4KQPVcjB2ltKBrmehZzIosd3GpgARTanFz5JTQlQBH6bSfVTI/govAV8LAKLRPKX
         ExldC1xLzuqOgFvMZNwvZu6YF/dMwzgqUPp7sKU4HeiuduYrZ7N/4/iqKTUZFTE1YG+I
         D3/e0H46jNZRItsLmqCgEWH165WSU+1wbLj/exR4qPZR8/XGLkS8JhyCr/MNO5iWFPNQ
         zSx19JcZrr1kzIg6v5axCWfAYsiM2wP8okIEuYbroxwaNlsHFr/iCBd+uQEvE7u+o6aa
         YsJX1v1eRfMpinyNbv+TlU0IHocOGMUUkuJ5+uZt8pm6XHA8VVyDQZzv/Q0JfS5kzZb6
         qefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AOxwJq+yWUZD+luTWXeI1wH9PdSPOQMP94YFX6uESZc=;
        b=kgX7N5zmKQjAsTVQFb720keS4oE75rwAjbXnz2txBmiD2CJTYVDJMaKpvpT2VpsPrX
         vcPb1zTPlwdDDoK9HrlTQsKwZF6BWxFj/PJy2dSAUU5j+SkMTavngSqeJhTWlC+nMlLK
         FrKFuWpK2vK3yg6kplmBELFnLcWcAg5hVs9FirircNuan3yp06m1nUTEeOPD3hmBa5HI
         6Ahkh5AsGdK/mxXzLI7RnP4ecYIl/MiOe9cCbHb3hZSvBrsF3xzpOf2i3sn1Ct9cgjuW
         zMYc1hQXSjqQlh+GHsMtyFLbACVQS21J4+vZ8kvT1CMEAZhKmfwJX/YUcNbaZv0uRcKT
         Nbiw==
X-Gm-Message-State: AOAM533WXYN8Qj+szkkyk0kPexb2LVFQ9ce4A8fYQG4tM/VKuB1AeWUM
        7e11vHgeHNPsR2qMI8QD3T/kaQ==
X-Google-Smtp-Source: ABdhPJzVypMay9TKR18542OR+V5e48VLz62uFAcT5o84gnpvqdZiP3aQPCodvv3n82njCxBY3Y6SEw==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr9545489wrt.267.1599753279723;
        Thu, 10 Sep 2020 08:54:39 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id a85sm4355398wmd.26.2020.09.10.08.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 08:54:39 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] wcn36xx: Miscellaneous updates
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     shawn.guo@linaro.org, loic.poulain@linaro.org
References: <20200910150845.2179320-1-bryan.odonoghue@linaro.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <84a86a12-62d2-cc94-95b3-34b360ad4255@nexus-software.ie>
Date:   Thu, 10 Sep 2020 16:55:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910150845.2179320-1-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/09/2020 16:08, Bryan O'Donoghue wrote:
> This series is seven in a set of seven to add support for wcn3680 at 802.11ac
> data-rates.
> 
> This set marks functions previously declared non-static as static. In order
> to facilitate granular standalone commits and avoid single patch
> code-bombs. A series of functions were previously declared non-static.
> Antecedent changes have made use of those functions so we can now mark them
> static.
> 
> In a similar theme of cleanup, I've added on a fix for some whitespace
> damage in main.c and smd.c which while not strictly related to wcn3680 I've
> opted to throw into the bucket under a "miscellaneous update" title.
> 
> Hope that's OK.
> 
> V5:
> - No change to V4 but need to send the set again so that
>    prerequisite-patch-id makes sense to the build robot here.
> 
> V4:
> - No functional change.
>    Sending out full set again using --base=ath-202009090652 to aid kernel
>    test robot
> - https://lore.kernel.org/linux-wireless/20200908183424.2871101-1-bryan.odonoghue@linaro.org/T/#t
> 
> V3/RESEND:
> - Messed up my .git/config resending from my @linaro.org address
> 
> Bryan O'Donoghue (2):
>    wcn36xx: Mark internal smd functions static
>    wcn36xx: Ensure spaces between functions
> 
>   drivers/net/wireless/ath/wcn36xx/main.c |  1 +
>   drivers/net/wireless/ath/wcn36xx/smd.c  | 65 +++++++++----------------
>   2 files changed, 23 insertions(+), 43 deletions(-)
> 
> 
> base-commit: 160b351d75cb50a0dd2abf9b63e1891935aa9e4a
> prerequisite-patch-id: 9a4ac7faca179f6594c9b3a115ee69a2da540a69
> prerequisite-patch-id: 183286f9c22d1aaa12f356651224e6b337ef1938
> prerequisite-patch-id: af468d413daaf8d2aad195fcb43c6e66390d8468
> prerequisite-patch-id: 08122a9557904ce5358f52dd08cc33270fa202c1
> prerequisite-patch-id: 82e0b7c5b2e9fa80baca001cce12577d98e306a9
> prerequisite-patch-id: 8ee7f5bd6cb5b7b7d713947b554ad93bb90d8230
> prerequisite-patch-id: d05c2253e4523b05b2e43491aa13ceeef68fd2f0
> prerequisite-patch-id: 8be29513d3efa64df15297bcf81ec3db55088ee1
> prerequisite-patch-id: d267dcd834afad75a69bcd2adcccfdad6566a7ba
> prerequisite-patch-id: 47145acae6e24e8e6580fca1dbddfbec24f7b50b
> prerequisite-patch-id: 8c66bccb923be821cf109a3a0d3a1a028edb4930
> prerequisite-patch-id: d0f5f3769b2963208fd2348840726fa1d3501b63
> prerequisite-patch-id: 746f63cf58fa3bf62736435c81dba2558aba8e81
> prerequisite-patch-id: 375bb7847ae74c63d2eacdbd0d73371aef1546fe
> prerequisite-patch-id: 8a598e22a08b0ec233d0ec56eeb53673eb1b8feb
> prerequisite-patch-id: b0eba574ddc35ecec2d0e39c0d3351d1b260420e
> prerequisite-patch-id: 143a1019813b7e4974a67e9eea1f1d599c0fdfdf
> prerequisite-patch-id: f66d9fe9eb731272b825c9430c15dca89d6c6129
> prerequisite-patch-id: c8c2d2dd1452c357f73fc4c92e5b564d59a05562
> prerequisite-patch-id: 273c13464a69354d32790ed7509472d9c2b11231
> prerequisite-patch-id: adbde1c98b85a16a6500b4210d4f055b9493418c
> prerequisite-patch-id: 559b6f9af6b26f860896dea4c7eb385ba9bdf0d5
> prerequisite-patch-id: 94c091c0c78b754d4c842a097a6db126bf6e770f
> prerequisite-patch-id: f2e549349c09f4675775b40bf9bb9b1f2bec6db8
> prerequisite-patch-id: c3a6aa788141f5b8782d28dac264470c8081bb97
> prerequisite-patch-id: 452450f26295dc4fc48dec07ba85538d78bae4b4
> prerequisite-patch-id: 8e7850077db9ec00df9be4fe3e0e4a4e8b06fbba
> prerequisite-patch-id: 233db8337812d9d34f99b41ccebd8758a6ada6d9
> prerequisite-patch-id: 0bbaaf402d2dd50a50aaa6505e5d10e743cf03e5
> 

Is there any reason these emails are percolating through this list so 
slowly ?

http://lists.infradead.org/pipermail/wcn36xx/2020-September/thread.html
