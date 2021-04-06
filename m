Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2636D3550E0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Apr 2021 12:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245100AbhDFK3k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Apr 2021 06:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245152AbhDFK31 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Apr 2021 06:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617704958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wg+Qsk3mUaTch+EdHlTVig0ZhqGWGJ8RIwAka3brbAM=;
        b=TQFMg+/fhZg27w241dbUY16r18+Y2mF77KwLmyt7yXSZdutzdj4CTvK6OyiB0KPcbT58SJ
        iC7pZaxZkZ8IDN2p03N9OrSYcR4kvacMDvf46Nh5CziWCLxO9kSaQtViOsUQgVzJRkzGKs
        VSlQmiGjJTHlSMo1IB4JVRBrduV42oc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-cnROmt6dMIKuNDECkCn3ZQ-1; Tue, 06 Apr 2021 06:29:16 -0400
X-MC-Unique: cnROmt6dMIKuNDECkCn3ZQ-1
Received: by mail-ed1-f70.google.com with SMTP id t27so10164736edi.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Apr 2021 03:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wg+Qsk3mUaTch+EdHlTVig0ZhqGWGJ8RIwAka3brbAM=;
        b=YI8hIhAefF787Yi3JDnh6IyaLDC9lc7tnc6IieDcbuPqZFxOvyk3tH1s72etaFkNwk
         Qeki8EuRyMw60F8QVQZ6dydZG3g2O6yF/069qgf9V01Ssht4+neyIAoFO1h5jBPUPBNT
         WeKVViD9w3IBAg4HWNLomk3VjE4Ucd2IHdTxjlwThxRYx5mMzhHmYZ23UOwPVHCD/i9F
         lWtBp8KL4OEfa3uKL1mx92cZcqrIFjIS4kLNGWwNw+z9nPoACOfoVgcqnFbVWm2T621T
         Tp/CCgaCLcuXWSpiEodk+0yWVM2fbvaWIKPqkjgOg2eaBcyVzasGnylbXYMKqPTtBzeQ
         +1/w==
X-Gm-Message-State: AOAM530A+bryjEuIQ1y7NEKEMz7cgZfZtjFzysKdeDvJo1BAc9Xz2+XX
        OaG0Y9nAlxnV7liXUEB0aERLobidejAvFcQJxe4oBMFXsC5tKmSO6qfB638Eam9sh6eckLKsD13
        hNlD7qOCFyby7SYnC8RRf5SOGVAs=
X-Received: by 2002:aa7:d697:: with SMTP id d23mr10662329edr.127.1617704955235;
        Tue, 06 Apr 2021 03:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPV7e84T5I9crkaEQDl+KtGwjfFJ7Q8A9DRrdVvAPV23mFBSI4g7lXrld92GYlIRqmXceW8Q==
X-Received: by 2002:aa7:d697:: with SMTP id d23mr10662319edr.127.1617704955126;
        Tue, 06 Apr 2021 03:29:15 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b22sm13312374edv.96.2021.04.06.03.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 03:29:14 -0700 (PDT)
Subject: Re: [PATCH 5.12 regression fix resend 1/1] brcmfmac: p2p: Fix
 recently introduced deadlock issue
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
References: <20210405205429.19304-2-hdegoede@redhat.com>
 <20210406101705.38F85C43463@smtp.codeaurora.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5e80c41e-016c-eee5-0b23-d1b4d0d7d6b6@redhat.com>
Date:   Tue, 6 Apr 2021 12:29:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210406101705.38F85C43463@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 4/6/21 12:17 PM, Kalle Valo wrote:
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Commit a05829a7222e ("cfg80211: avoid holding the RTNL when calling the
>> driver") replaced the rtnl_lock parameter passed to various brcmf
>> functions with just lock, because since that commit it is not just
>> about the rtnl_lock but also about the wiphy_lock .
>>
>> During this search/replace the "if (!rtnl_locked)" check in brcmfmac/p2p.c
>> was accidentally replaced with "if (locked)", dropping the inversion of
>> the check. This causes the code to now call rtnl_lock() while already
>> holding the lock, causing a deadlock.
>>
>> Add back the "!" to the if-condition to fix this.
>>
>> Cc: Johannes Berg <johannes.berg@intel.com>
>> Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> This is already applied:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=bd83a2fc05ed323d7ae38443a6d2e253ef1c4237

But it is not yet in 5.12-rc6, even though this is a regression fix for a
regression introduced in 5.12. What is the plan to get this into 5.12 ?

Regards,

Hans

