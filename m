Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8572A1778
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 13:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgJaMr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Oct 2020 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgJaMrZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Oct 2020 08:47:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE15C0613D5
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 05:47:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 13so5181346wmf.0
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 05:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ULHt/HLkEloXEc+vkERr50FTC5butW7FdB3x9XpmiXk=;
        b=yG5R1n92+epvZvHmA4i9XKZwXJf5jsmaEvMNhz3/pUH7sdwA22293e2zdJUF0E2MPT
         aXqW2IRNJd8Bq8D0jQ8jtl1u0xfqaRQv+hQP6relAVmMUlhzWBQX0BibCqWLF6TllnrE
         VRWB0vfPGeLbpXVtVoZvEMfE+xZnO+bm6MALqK1jCr+7os5IJJsL/NvrV46V72FXsfmO
         1ERdtlH0/y+rqWwfPH6D44GzA9xvfKDt/WjiwQBeH7zPhl1X4KaYTwYkkQkoUOUJaLCq
         M9Cn9SK34zFzoXUmGcj+eyi0Woa7khDKEa2Rqs2DzzhDsaa7pHA5NnsocJzk5fQ8rFcs
         Ac0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ULHt/HLkEloXEc+vkERr50FTC5butW7FdB3x9XpmiXk=;
        b=WHQ2kED/V1jCl/3Rv3b9MgTr1rudyMsQELHlUeR4z4uDc4LWsM4t5rQRDVh/8eKUIh
         37dJr2D5D9LYblVYAiyFKIbWtxInN8+u7eSWyGwZNujeuw1Sa+zB4NKIk3RyzfA+GPCI
         ZLNjzK8AN5DdzW3PvBNGEPeeW2+gIhj/n366lYd1aIt6vMSDiEvZkJrkZ5CLSM1rybZH
         87EaJUCwkiuGo+oCfE3YeHlxFZ+lLpgcHlGZenCZahohdABC4HyHxQeSHeV7ShsJGdQE
         NTgD9B23kl/05UkWyjrdPExvkBsRTkhoNCtUNCTIUt0eequrve3fCmbm3G9exAp0dY9B
         YKRw==
X-Gm-Message-State: AOAM533R+6NkXNaGZSOteQhZD0qABWQzX4Fyt0BnQqGOUpFEB3MY1t1s
        G7xs1QHGbiDIdm+ONxg2Hd3LJw==
X-Google-Smtp-Source: ABdhPJxaRfS3+ldonZSHIRWiuZnSH9mQQpxTi7u+J7jHLf9XrNRxdtJJdOex7J6TLpzLBcumGLnuFw==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr8338227wmj.112.1604148442904;
        Sat, 31 Oct 2020 05:47:22 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id z6sm8004924wmi.1.2020.10.31.05.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 05:47:22 -0700 (PDT)
Subject: Re: [PATCH 1/3] wcn36xx: Set LINK_FAIL_TX_CNT non zero on
 wcn3620/wcn3660
To:     Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
References: <20201031022311.1677337-1-bryan.odonoghue@linaro.org>
 <20201031022311.1677337-2-bryan.odonoghue@linaro.org>
 <CAMZdPi9cOzGb8ursDU5Y6XbY7gP9-_f+LhAv7bRVLZZQgy6JJg@mail.gmail.com>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <f7ed1146-bbf2-7cd8-6548-8a27218629fe@nexus-software.ie>
Date:   Sat, 31 Oct 2020 12:48:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZdPi9cOzGb8ursDU5Y6XbY7gP9-_f+LhAv7bRVLZZQgy6JJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 31/10/2020 09:33, Loic Poulain wrote:
> Could you set the value to the minimum value described in the
> downstream driver (i.e 1000)?

Agreed.
Seems reasonable
