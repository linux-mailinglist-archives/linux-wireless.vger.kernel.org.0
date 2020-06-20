Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35619202640
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2020 21:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgFTTyT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jun 2020 15:54:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41109 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgFTTyT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jun 2020 15:54:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id a21so11789468oic.8
        for <linux-wireless@vger.kernel.org>; Sat, 20 Jun 2020 12:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mSZSOgNJqAeiUhDsCdi5iNeYTkN8QF0BhmzV8CqCvhY=;
        b=ky7CwRVgniouiu69jJyfTcsIgF8deWPxj0+yCCg0fOv2O8LNrY7N4hY766i/KJo/WA
         2fJ2jQjl+iuIPgWjGwM/9cb0hZZCSucD+w+eF0df6IKR8dxoe6oKEOMfn9SipCdelAv0
         HvKA18yGuC6LzXmnPoriu43jR2HOXUX700evlDFtDgEm86yyv/hmLTHdRxFChXfgMf+p
         o1g1AHkRG9xyzXyLmMUBCtPdttI5NLtwhYcXxnAZkc7+LBr3g04Z+L1xBqxt16IlyNRY
         H5elbaKXv1V2rZyNr6qw2xNdkQARt2bbJzG2GA6xAT4Q9XoVHBtvyje27FXCWxDrmk/A
         210A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mSZSOgNJqAeiUhDsCdi5iNeYTkN8QF0BhmzV8CqCvhY=;
        b=Xku5+F1bMineSQLmjlSinbINRZhR5zmM4pKWp0UFLkj+BHjGh6oryPzP7ZAtECvdR0
         hKdEd0wAtVfiiS/hKQxX1f8upuApa2rD6T4fwg/V+4vMXPiGHjeCKsgCpZVuT7ebKxYe
         1R27XpNVHJZCZR1QU8zDG9YNp4HeTogeYvX6CCI7GHThdjeeVI2rzZ42dCu0egBWDko+
         UZR0KnMZKJ7bdVtfItSaWB8kh0t0/gYWeXoV476bKBZJ8fCGaJrjMWohqPdVWRtWO0Ri
         0rx4KAZN3oiTHpg5F7iU4CS+uvtXJrAVyTEpdSFpTWJfVH4VeW5nkaR05PdNqA4buENc
         Pu+w==
X-Gm-Message-State: AOAM532CutCG0GC7YzIYGFUEb9lyTLxkt/nzNGNF/68pQ6/h2iNzOQlk
        ZGe+BcnnFGns1i1/SStr6dxXnawI
X-Google-Smtp-Source: ABdhPJxCznaaxaGL+14q8JiBUOjF86gnDyghXa0FK8KZ9IMnO9Rzob+6KBGvtceCTPVm7caAHePN/Q==
X-Received: by 2002:a54:4006:: with SMTP id x6mr7303824oie.148.1592682797007;
        Sat, 20 Jun 2020 12:53:17 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id e6sm2132539otk.51.2020.06.20.12.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 12:53:16 -0700 (PDT)
Subject: Re: [PATCH v1] rtw88: pci: disable aspm for platform inter-op with
 module parameter
To:     yhchuang@realtek.com, kvalo@codeaurora.org
Cc:     kernel@iuliancostan.com, linux-wireless@vger.kernel.org, i@outv.im,
        trevor@shartrec.com
References: <20200605074703.32726-1-yhchuang@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <5def4c90-5143-68f1-201f-b0590f85dde6@lwfinger.net>
Date:   Sat, 20 Jun 2020 14:53:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200605074703.32726-1-yhchuang@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/5/20 2:47 AM, yhchuang@realtek.com wrote:
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Some platforms cannot read the DBI register successfully for the
> ASPM settings. After the read failed, the bus could be unstable,
> and the device just became unavailable [1]. For those platforms,
> the ASPM should be disabled. But as the ASPM can help the driver
> to save the power consumption in power save mode, the ASPM is still
> needed. So, add a module parameter for them to disable it, then
> the device can still work, while others can benefit from the less
> power consumption that brings by ASPM enabled.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=206411
> [2] Note that my lenovo T430 is the same.

As someone who maintains these drivers in a GitHub repo so that users of older 
kernels can have access to them, I am in favor of this module option. Only a 
very few cases would need to disable ASPM, and I see no reason for everyone else 
to use additional power as would be needed with automatic disabling. Adding a 
new machine to some quirk list would be more difficult than merely telling a 
novice user how to turn ASPM off for their system.

In case someone is collecting machines that would need a quirk, I found another 
one as shown in https://github.com/lwfinger/rtlwifi_new/issues/622. That one is 
a Lenovo Thinkpad E490.

Larry




