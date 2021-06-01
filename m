Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AB33970F9
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 12:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhFAKKy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 06:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhFAKKx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 06:10:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1852C061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 03:09:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m18so7840152wmq.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hCIPY4HDbLRRO1Z15dBmi3GOZSKm7silzJJPQLthE08=;
        b=w4sxOh5cQXQQdV86+hlfaL6mpao96OJQqZvPWP4qsrQSNwTwcxCTHN+gFkP9xG83Qm
         1G5hrFnOsIDZjHHKAFrf3XeCWm9SIDdIqhpQCzlFn+v/jNN2XCh5uxkqpqncGmkihZ1n
         3Dm4RNnweBiZvZ1NMPxucbDhRkCJtA3/KaruM3axL2koGCZdgrtcX36h5vTEWNiDiMlK
         CHUFCy+9qYQcPYuHpr2ewTMrCyRKUcsbyqsf5IOIUwoauVn1+U3dn818oXonOgHiIkDa
         fKLe4zFiy+RCHwgAFBIet+kRin7qAy4xQ68NFgE9L1jxyc4BAQjNVcEp09gG9PPw/1if
         8ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hCIPY4HDbLRRO1Z15dBmi3GOZSKm7silzJJPQLthE08=;
        b=WF8GEvVHBYbeHIP/Ny1JjKeyVz1Pl9qfOS4EZzZIkAlx+xhssHY4CEvKePjobyAtD+
         RjwfdKNaXgAZjkVbonVQPJZ3/A1eHJFHG2EEgrW1/s9KEPv89CzsXOEGUXtTH/xPlnW5
         fyRK0HlaSYZ4xarNwjc5y9lnlb+Ndp6ze3FHc7K8qcRqgophF3a9DRR6ObjtGYz3cqNk
         RZmrXtes9O0oTV+FRF3LWYQi855uwT0iRMaDStfYghbA4iklWRHYzYfWxF9pAeuCF/U6
         LJquMPudIKW2lSkCOPzCBWRXCaUrOze7ARADSg3i7M3e2aBjR/sulgJKvNoikr0iNLe0
         UfTw==
X-Gm-Message-State: AOAM530fcQDsXFdQzezAv/UrE1Xsg534IKxs591IR5umw9rF2qi9lGND
        Rxq3ZOGYkSgWg98KGJten/G3pQ==
X-Google-Smtp-Source: ABdhPJz9XBK4lPF7MZSAD8lPa8xd+I9UXsIEAkT9sKoaBaq9SrvYU5nBM3TX+I7YtPYKzxx0gHK7ig==
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr8549379wmj.125.1622542149663;
        Tue, 01 Jun 2021 03:09:09 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e27sm3063159wra.50.2021.06.01.03.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 03:09:08 -0700 (PDT)
Subject: Re: [PATCH v4 02/12] wcn36xx: Run suspend for the first ieee80211_vif
To:     Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
 <20210601024920.1424144-3-bryan.odonoghue@linaro.org>
 <CAMZdPi9VOPdz_4nhjDC1o49eobRPZRkniKtWc4ZLOiGEH3nP6w@mail.gmail.com>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <bf3c59db-83d5-d057-d525-780df77d71d2@nexus-software.ie>
Date:   Tue, 1 Jun 2021 11:10:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAMZdPi9VOPdz_4nhjDC1o49eobRPZRkniKtWc4ZLOiGEH3nP6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 01/06/2021 08:09, Loic Poulain wrote:
> Where is the balanced mutex_unlock?

Ah - I've mixed patch #2 and patch #3

