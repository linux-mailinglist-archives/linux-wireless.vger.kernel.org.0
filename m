Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8F54741E0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 12:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhLNL46 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 06:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbhLNL45 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 06:56:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8420C06173F
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 03:56:56 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u17so31984790wrt.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 03:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UYofgct3PZij7xbQa35VKZK/aZ8f/hyUCR1w0Dz7WRo=;
        b=zkWweRWX0yMoh6KHoIsCP8XlYBlX90Ei2fMePDQpbAS9PdSjDZ0fbmWNpglUTbk8ta
         +R6IrDTiv1hHgaeXoDKvaU2+J53A5kGor76mZoJ+o4OiYNI7ck6oO8xg4X7gLXLmBd/p
         rMzYnZL7ilSH6cVrC5BczNyute5oPY9uUBC7Mel0pFuSgoQdAOIM6HtJK3tgoWfrQ2Ys
         v2GHXm7YtPs3zLI2GwjBNiqKgTLA/V3VHjvC0HEDyLB8TTCUiQv/YfI6YRCmgbOHTTXU
         H0CBcWIg0WcPXdZobhzfMljvWTfZ5EvK9fdZ69i6ffQKzg2R1v7oHgEF372gjAaH2b7O
         8UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UYofgct3PZij7xbQa35VKZK/aZ8f/hyUCR1w0Dz7WRo=;
        b=5lfhd+bgiWL8kcFcveJ2h7NTusYvBymHvF6oZWrTub235m88S9HcUX682i9lTqKeRF
         o5+jYQD5NEmZWSlNuSCUu0GBDdQXyhteI1XgRIgEdp4vXpUkcXxjRGtpo86iIjhqQOpJ
         FNqVSqWXyzVgcXy/Q1lk2Eag04XzH+gXO5vYHjtsq4+2JNL/t+4CyFtlFWV8szou97LJ
         XE3/SFFPwEi/0SJnuLWdhORlfehY6thHby4L8VhAu3okSS27X7bC8fRcXT7s3CJSwWSC
         W7nwlmU46PyarxwnTWcaYnhRJqz900sMH8rZBEtVjBTtuC7eE8rrH3UADk+tEXf2Fetz
         cB6Q==
X-Gm-Message-State: AOAM532KKuJaq1hRVfN1YH8obSt6qAlIPeP8iZc36dlykvermiCCsvyZ
        l8Khzt45Yj3GbSiP32/VEP5//A==
X-Google-Smtp-Source: ABdhPJx5QR7/HK/lUMwumUYpJLIMfqG4gyQv/KqxoyOIKosruoIoeZAIa8+pqhRxfarLNYqxAjSI3g==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr5245441wru.380.1639483015287;
        Tue, 14 Dec 2021 03:56:55 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e11sm8354877wrq.28.2021.12.14.03.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 03:56:54 -0800 (PST)
Message-ID: <a7a3dfd9-03c0-e7bb-1b5f-e387adfe2ecd@linaro.org>
Date:   Tue, 14 Dec 2021 11:59:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 3/3] wcn36xx: Implement downstream compliant beacon
 filtering
Content-Language: en-US
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        benl@squareup.com
References: <20211213135127.1656258-1-bryan.odonoghue@linaro.org>
 <20211213135127.1656258-4-bryan.odonoghue@linaro.org>
 <CAMZdPi82xqRGn+oZwVX5wgutEDO1qpufSra2oBW9S4pALHHAdw@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAMZdPi82xqRGn+oZwVX5wgutEDO1qpufSra2oBW9S4pALHHAdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14/12/2021 10:31, Loic Poulain wrote:
> Shouldn't this be configured only if the vif type is NL80211_IFTYPE_STATION?

It shouldn't make a difference since BMPS will only be reached by an STA 
but, I have no objection to adding the if.

---
bod
