Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D294391F1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 11:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhJYJIU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 05:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhJYJIT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 05:08:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D4C061745
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 02:05:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m22so8214255wrb.0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 02:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cNXCepX+q4Z8flK+e607d2EIOPTdLNfsIAA9uW0a6FQ=;
        b=UkdgIeQHI6yyLkhSM8YHOAHRbI3EHyb5QCnCk3x31MBQ0LjyTc7XCRJdx2z4MfRiqL
         7mCTKLbwlfvU4+zlaejQE60E3CJQ3uvb1JEs1TZDMdwOWtfCUTFKG8QzztcDRtGw4DVV
         ojFu1A8WZEzSXiLGDPmU6O8Jei8o7O6ezsd+d4AOtcvtHNbI1+/RZ+VpMubOXB9/aRoh
         QFxr4hZpdOLDn2CuALHYEXOHZ6QMfABDnaHb50tsxAn1gsOOfEBeNbzmN9qO+riVjGBL
         b7wZps/rPGseE0Ud8B52joY7M5LbsC3aGVjP6MjE4E3RHiKKVQCL20MuuX5mUOd/Ooey
         eNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cNXCepX+q4Z8flK+e607d2EIOPTdLNfsIAA9uW0a6FQ=;
        b=XLw5s8qkh8d1qPJbq/rC11Ly9ntg3o/GCzLPBt0nkAFZnCv8KZMQVpysmaQ1opx7EX
         6kqRw5fkWPATgq7h6fcKmUmMtrrMLScsPibqr/bgQ6rDpqRPf3cyLlZyMoNC/TDQDAPF
         UmtNIN6M9MeP5qhqt+HZZeozpmVquMDfEzgpt7wq+oLE3GYeVw3jiHiBXWpdLxuitxzl
         820GtPAyOXgVSRk2wP32JgcrP3uGfGfOOOY4BUQLE/iYWsEIUAHlU131JPjxAFnM+x1Q
         kx6VM0i4mUtAX5LwmULf1DBHX1aM+2tQErh5/nl/rvJpDvRhnIyisnv780dtrDQJe+K8
         iVdA==
X-Gm-Message-State: AOAM532tC2532lXhCOG8sNOOn885H5uSP6O/qIIXSvtIVAZZQqmjS7/3
        1wBd3SaWghFXYIBiieNYq60mqg==
X-Google-Smtp-Source: ABdhPJzOyeUyUvfQaq4xuV1EefgEcgmwWUmsXcM+gXl4OZ9LvSB2w4xyj6xXv49Ud5HZphhveQlKLw==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr22252606wrz.20.1635152755868;
        Mon, 25 Oct 2021 02:05:55 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s8sm15814633wrr.15.2021.10.25.02.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 02:05:27 -0700 (PDT)
Message-ID: <fad96461-d8cd-374a-062d-2ff541928198@linaro.org>
Date:   Mon, 25 Oct 2021 10:07:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 0/1] wcn36xx: Revert firmware link monitoring
Content-Language: en-US
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org
References: <20211022141008.2846454-1-bryan.odonoghue@linaro.org>
 <874k95eba3.fsf@codeaurora.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <874k95eba3.fsf@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/10/2021 09:52, Kalle Valo wrote:
> Avoid using acronyms as much as possible, PS meaning power save might
> not be clear for everyone.
> 
> And please try to be more specific, I'm not sure what power save feature
> you are meaning here. (802.11 protocol power save, BMPS or what?)

Yep - the issue is on an Open AP when we enter BMPS link monitoring 
stops working.

I'll make that clear in a resend
