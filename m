Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8439825787D
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 13:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHaLaw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 07:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgHaL3q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 07:29:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED644C061573
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 04:29:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w13so5572319wrk.5
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0u+EPrQfK0AxydlOs6CtleuBgm5nCSrhg2zUw7/Whi8=;
        b=pLMuh+DEycocPtxBg/E2jLLxzj/bkmsHFT2gagyR1wSOH6kZh6/8/nDG15oPNFekUb
         8dg0qXjC7xgvaTh+cmSeE0FodVlpAPeyFcQEwmd5GvHVU+unHDqcGNxHw3xmk+UB+3D8
         jwQrkkbE//dHKZBI8EMsjQf5Dx5db8lI8rgHX5KuLCWN2Oa64oL15xwS9LE71GwnyIQ+
         2QrfmXdKCSPREQvIE350NRRH/2oTedWOkLuN3EItQwbPHJutPQY70gPPpiAItqJrDjeP
         VkNuuIWE4/mgLHps9x4floWsxYp6YxqFsl/UjUfqEQQG6A3zXieKZcyRghKCu+gb01pm
         3Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0u+EPrQfK0AxydlOs6CtleuBgm5nCSrhg2zUw7/Whi8=;
        b=eqVgLaWTqqKPxd70OM7r9n/zfTer/1hFyfYxXb18IIJHFrCWB/vraWVLu9uNoPvTnp
         qZBHny4NxI322J491TmxXMX6w19DKL5ejkG1Bqa8hcFj9f8v2EqpoZs8tJUY4a02tOvJ
         TZgUXLbHPfDZVyu37v7NTXkk7GoWpQIcvfePxiuZe04Es3r/ItlJIoCqYTMJ4TplJ8y6
         BEha05kWrAnCYwQAVV1TULSAqMAVZgZpUZO3Kj5cXZuaUIcMRRg+TIulpUMxepefBw/H
         7inciID5EPTocIkCVob3xZo0fj+bxbI2UlrSr2/n2xG0/qEmzj+l45ygYP2OhjMF0cMo
         1/dg==
X-Gm-Message-State: AOAM5326+xiubk8hy5UsGOe5o48oMO2M4fIvTgBD5kCc2KxDdIz4jJKp
        jAFODnH4pAjIjRjfof+0ZSaxhg==
X-Google-Smtp-Source: ABdhPJzjqrnC6+rLKJz1yofVGNXxJrQXCUwg60HNyI/0p84+Xz72bXWjSy3HynmDfev4YKhX004jrg==
X-Received: by 2002:adf:fa0c:: with SMTP id m12mr1210145wrr.406.1598873383682;
        Mon, 31 Aug 2020 04:29:43 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c145sm11002646wmd.7.2020.08.31.04.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 04:29:42 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] wcn36xx: Set PHY into correct mode for 80MHz
 channel width
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
References: <20200829033947.2167817-1-bryan.odonoghue@linaro.org>
 <20200829033947.2167817-6-bryan.odonoghue@linaro.org>
 <CAMZdPi_YB7aurY_XsbPeqytPNBUteRkh+VH79mHfESL=rf5LGw@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <51f134b0-cde8-595b-b3b1-e6b3b5b151aa@linaro.org>
Date:   Mon, 31 Aug 2020 12:30:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMZdPi_YB7aurY_XsbPeqytPNBUteRkh+VH79mHfESL=rf5LGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 31/08/2020 11:08, Loic Poulain wrote:
> Hi Bryan,
> 
> On Sat, 29 Aug 2020 at 05:39, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> For the 80MHz channel we need to set the PHY mode to one of four PHY modes
>> that span the 80MHz range.
> 
> What about 40Mhz bonding?

The existing code handles 40MHz HT in wcn36xx_smd_join()


