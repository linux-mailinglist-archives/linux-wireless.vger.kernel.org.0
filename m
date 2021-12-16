Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437D1477303
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 14:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhLPNTU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 08:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhLPNTT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 08:19:19 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18583C06173E
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 05:19:19 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t18so44106582wrg.11
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9BNP8+sIEFVb2MhSAcAnd1YOOpvRtAWkUcQgdcFFjnk=;
        b=Vc5wpsVx8rqQbRmiDUFj2eUE0HD2OEbzGmuLfyEpoy+oP06LfrGkraYJUO+V9BNkmb
         FLX74prDAUFDH6VwYhiNciuOtMfyaj+uOU5cJABzcM8OVhmTch82RIIs7/D/A0vSy0E7
         idR9xyJ+1oeTmQlwjOPtS8jsxJrX61sAStVC+l3qLzE2H9p1fAZH+smgaTxPIXjpYOs9
         m+rjl+4hUNzZcdpoujX/Vv03bBTG4kGtvMTRWLZo2/XLeg9QYDzkl1PNq9QJmrSw78Q7
         wnHN0/WydbrFkaQL6nLeewMhXEXkZ5EZXDkuRkG09WO2UVucXUgCiuLFk1kqEFvPQHh5
         J7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9BNP8+sIEFVb2MhSAcAnd1YOOpvRtAWkUcQgdcFFjnk=;
        b=rkDaUABHI9WVVzyLQ6ZemXeh3rnzw8L3PD7GnBtJ+6kyLvza5wPP7X1LQRhQAus2n1
         koDLwkpQ6usg3Vp20CUcoYPligqVgoO1hV5ogwMxJyEyPNB1XdaWqqjyJJSEk1+1Ua+2
         gnWnRY1G/IlEp06ZxaFFpwtDbZjx1K6GcZuTeZLMFKPzbysheZn5wHYKbUw6FGjaQ6Pt
         DJEoVqDvep1AuJ1nUqjp2LVUhYc9J5N7NLR0gNI5lL6I6Izt0vijhndZW2u5pdITrgsT
         vV94eQjPNb1SXihwOd8LgDdfStlcdtbz35AoJUq4QxprdRwbLDBgjygb2BbYtoCx64wi
         LNCQ==
X-Gm-Message-State: AOAM533kcbXqWr4d//d32iotND1egXB2+0xbtncRIXJaxiuJSFuhO671
        DNaYxKtD8TPZiwRwQnE0PxEtOg==
X-Google-Smtp-Source: ABdhPJyrFqiEUnLJlHhmFkcfnGARIaAhHdD57tsX2NlwZdV/EbUIMFfb83xYvh/pU3dHZLfexm0PEw==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr9022149wrp.226.1639660757671;
        Thu, 16 Dec 2021 05:19:17 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b10sm5506527wrt.36.2021.12.16.05.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 05:19:16 -0800 (PST)
Message-ID: <425d1fee-f0f1-7548-2c2a-853e8f2e256b@linaro.org>
Date:   Thu, 16 Dec 2021 13:21:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 3/3] wcn36xx: Implement downstream compliant beacon
 filtering
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, loic.poulain@linaro.org,
        benl@squareup.com
References: <20211214134630.2214840-1-bryan.odonoghue@linaro.org>
 <20211214134630.2214840-4-bryan.odonoghue@linaro.org>
 <87ilvodenr.fsf@codeaurora.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <87ilvodenr.fsf@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16/12/2021 10:31, Kalle Valo wrote:
> I don't think the term downstream is clear for everyone, I guess with
> that you mean the prima driver? I would prefer to use "prima driver" in
> commit logs, I can change it and no need to resend because of this.

OK np thanks for zapping the comments directly.

Noted for future reference :g/downstream/s//prima\ driver/g

---
bod
