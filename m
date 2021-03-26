Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4164349EE6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 02:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCZBpF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Mar 2021 21:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhCZBoh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Mar 2021 21:44:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251CEC06174A
        for <linux-wireless@vger.kernel.org>; Thu, 25 Mar 2021 18:44:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x16so4126344wrn.4
        for <linux-wireless@vger.kernel.org>; Thu, 25 Mar 2021 18:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4k9/YVO7KI31daG7qZvaePTDi7aU8GogM6IRPa36ntU=;
        b=RPtNsWWN5VJsb/LH7A6Tzk9l8ix6mG2t5hERqpnwVGXLgPGZw4dPA4B6foDGG1cnlo
         Uk+f0mkCM1bKGDCVf2Ll2Jyv9Vp6I+2uWBtPhCEnZ28/BZX2vobhUvaUXhH/i3en3rdM
         +wf9QU5LFyPDjJ31q+0Q9CNUdIPwqJaJ/XcDCEIgn38Il+LY+v7lX5p/iYXfiH+rkF1I
         XEHvMR+q46yA6nrtLyvpPhB7p/tRPoR0oKlpHFh0PuWmku11ZEmlq7bGYRdlaycRXzoC
         60ShHNKi3vuAU+/BJK+7wjrSUSEfFElAMIUg1yv34Ags1SKihkonL5Yt6DFgv5S+Ut+K
         aVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4k9/YVO7KI31daG7qZvaePTDi7aU8GogM6IRPa36ntU=;
        b=jfnNq9R7B6vNJLieM2SlMt6KyDtU1zF4MUWqWmDzcLE4Qqc5s/5Q7sWO4tADQV9KFG
         Qyo3R5uv+1WgGGMNTbMJ6JEhwwHiBoC/e+9TOo6xZ2/e2i03Zft8JJPFilg0RcsPCx79
         SOVzzjAMzDYjNBozKPQ5h7vbQqQlseFj5t/gP3H6JA5g9xAcyQTeLS3x6jTGLTptRmOK
         /VIxEdmC/tPl6LiDOt6bM5zgCa7LCZmR0wR97EdxuKE5OD7LRnlpdM0VjKy3zQ3Ubcrw
         qkO+7PH48jAvVSzbmMlwPvlPCokEQDnIC2O/rrS7ebULxGnrh2Gz3o8yiFuCNyjPAhcv
         Tmuw==
X-Gm-Message-State: AOAM5339UjttfpHWF9ui1BbqLb5CY+DreW+6OX1KsiLCPB3z9T4aD2EI
        sAMS4m4CRR92PDjUtqzMB/SjVg==
X-Google-Smtp-Source: ABdhPJyqa5HVcJxcQ9lfa+wpIg4SntoiIj8+4tQxIujLm3c8Mmz8xAYrcvYaJIlkbw8WDu1TJuyoYg==
X-Received: by 2002:a5d:6cd2:: with SMTP id c18mr11849921wrc.330.1616723075820;
        Thu, 25 Mar 2021 18:44:35 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j123sm8394891wmb.1.2021.03.25.18.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 18:44:35 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] wcn36xx: Enable downstream consistent Wake on
 Lan
To:     Benjamin Li <benl@squareup.com>, kvalo@codeaurora.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     shawn.guo@linaro.org, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
 <3f28186b-d6d3-590f-2dad-b0e00faf2872@squareup.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <79d01338-e7a0-324b-ade2-aa09edb7387e@linaro.org>
Date:   Fri, 26 Mar 2021 01:46:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3f28186b-d6d3-590f-2dad-b0e00faf2872@squareup.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/03/2021 19:52, Benjamin Li wrote:
> Independently re-tested on Square Terminal with WCN3680B using these steps
> on a recently rebased tree (last month).

appreciated
