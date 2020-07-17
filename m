Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641F6223945
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 12:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgGQK3x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jul 2020 06:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgGQK3w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jul 2020 06:29:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFF6C061755
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jul 2020 03:29:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so16364783wmh.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jul 2020 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+rlV3BwufApFs6sVhzsLtKtBWycqJBDkxKSwwlz6u7M=;
        b=ax9Uwjs72/M3iN8Ohi8qWrurOgEEP3sfjOWaIicFhWhArdg7HsVMh4UkkD+Fbdn1jb
         SWR+yHwdOhmdo+CREnXdn/nYZKKWVntoo3xSYXP2P5j29Cy5T+dwiYS6+Cha7BdizHfG
         YSvoUtYUtPbCMk+jbM3qK6lafSOQuFeEk/MqnwpDbpZD5cT68bamz1JzFWJW7ou43KQQ
         cx5Jaghj80b5+L9Xs9cPtQ6SpH9Q5Y5Bb3Cd5pzQIytNo0O3m9jYX2Z1Y5M6KkKNSqB6
         17EgWOtGm2qrWzKFdaogdTBn2gXXlP7w0dPP/S9MRoBwoDNT6SeIYhn2as0crebmZCJi
         WI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+rlV3BwufApFs6sVhzsLtKtBWycqJBDkxKSwwlz6u7M=;
        b=Lnt/rb4OUzEsqC3FaYMH/EikjQjeqBbX4c4F7yr9AHdsDnTfk01EHE3lYWxf+tx/PR
         WekRHd6GYijJ7kaJfeNTN5yk/hhybGa6XUSJ64WzsOxhNfbVP9MDpZSH0SJ2lg257COh
         YBZ/nU6Da8CrWLCM0BAFq6HkE7Tyy2Derj5KXFeH6lUu4zd+kKvJB8jpBhHy7IG92A74
         gZ1V3aIgm5sbGXWasaRpEprFddtoiI1fcInK6dCMJEx+nqNB16wnxj5D771AyPJorncz
         mGvy2wQgjqz8kO8kZwfGnO6mvp4ifhxFUZ6sJEzAD5EvTjc4PvwWDqdD8d6atYJRwoMr
         w20A==
X-Gm-Message-State: AOAM531QyAz2V1qpBOUXc3jz92WXANEMsbkzoIKunwM3/TP6EYlj4g+n
        LBhhNPafBm+ZGXN5CCDpZYPkQXKx8EM=
X-Google-Smtp-Source: ABdhPJxAiI52BAtEfkMgde2avVeFn6oI6lZD3lz1CkKoXZrRHO1C7eUKd/E57BUQOhyIIaXBjABATg==
X-Received: by 2002:a1c:c242:: with SMTP id s63mr8573954wmf.146.1594981790568;
        Fri, 17 Jul 2020 03:29:50 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id u17sm14041778wrp.70.2020.07.17.03.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:29:50 -0700 (PDT)
Subject: Re: [PATCH 4/4] wcn36xx: Fix software-driven scan
To:     Loic Poulain <loic.poulain@linaro.org>, kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
 <1593524821-32115-4-git-send-email-loic.poulain@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <41512f00-8c9b-207d-807c-38d4b01938a5@linaro.org>
Date:   Fri, 17 Jul 2020 11:30:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593524821-32115-4-git-send-email-loic.poulain@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/06/2020 14:47, Loic Poulain wrote:
> For software-driven scan, rely on mac80211 software scan instead
> of internal driver implementation. The internal implementation
> cause connection trouble since it keeps the antenna busy during
> the entire scan duration, moreover it's only a passive scanning
> (no probe request). Therefore, let mac80211 manages sw scan.
> 
> Note: we fallback to software scan if firmware does not report
> scan offload support or if we need to scan the 5Ghz band (currently
> not supported by the offload scan...).
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>

Validated on a aqp8039/wcn3680b

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

