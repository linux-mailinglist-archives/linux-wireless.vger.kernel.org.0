Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340FF33B1CE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 12:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhCOL4P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 07:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCOLzn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 07:55:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66964C061762
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 04:55:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d15so8535772wrv.5
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 04:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UBBDD7je+wI0/qiKCUfZNAvigmk/8+/BAZtG2/aOZUg=;
        b=N6ELYpJLg5vlEAT6sqrROQLbdwsOsBevNnuE1QAd64cpsbT2g6NOOVkNMlLkpjlNqX
         Br6C5E9Rc3Qx8yPhMvDmcoy+7TG3KcWOQBvh7ElglfGJpd8SYGqYIdvXAhgQsf7XPsWJ
         kF8JJQkdBSVlneQBgBIRmYX63R4HhWYHThWBoXA/TNOX+1pSozIu4xIpAMtXKXj4hoa6
         CXK4tVZ7AO2OjFZYR+cm1sS4p+cBirnN4n4Um28WwDOBhCSglEsI1I6PSyFklCc8qqA3
         2jfNJNPEvJj3AA1SZqz2eYQuNKjR5dwwjVpZfylxyXWIPmMvL8JBr6YTUos+3ZaDCCKT
         CR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UBBDD7je+wI0/qiKCUfZNAvigmk/8+/BAZtG2/aOZUg=;
        b=JMbck4FOZqJn/rmSVwyvgurJDbIK73wWJX8CLhZzAK8LDkmYgg/d2hhHLO6RG13Rxz
         On6Cdt/sLy6CWPpI3Po+TdY8AV86jyu8YHq5tWqD6O4FU+j3MRh0FIW2jixxf1X6GBDI
         saKRdyzdFUY0npWuOYlaFkjNO9K7+megrLloZMlw5HObokByNQlYwRFnsXSK2Sd6eI7w
         ZTjYx7rg1DGq4UA+gmpAJCJYvuZntMLe0gPgHyK6fE1ts/sw2ytE4vABIMxkKdlOWPYH
         lRROEbrc6AAeReGvCz9XROsvp20PbKjNFew7KZ/JWnDDUbA8DcvbU4Cvd26bxaVFNBaQ
         pbQw==
X-Gm-Message-State: AOAM532R8SPxixWO0ujqtajixYBu8cSlCO4/Ue2WPEHZg6eOB60F26e6
        SefCq3SyKq5mJX72jTgzYl4bJuXTNOFAb/7C
X-Google-Smtp-Source: ABdhPJy4XVY2mbl2fd/VclnvxuPs8C0fJP8y0Wfrk3vqPCi08hsBk6Z9IGpwuWyg48giiBKXkeYgRQ==
X-Received: by 2002:a5d:61c9:: with SMTP id q9mr26501561wrv.219.1615809342141;
        Mon, 15 Mar 2021 04:55:42 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b131sm12406644wmb.34.2021.03.15.04.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 04:55:41 -0700 (PDT)
Subject: Re: [PATCH 5/5] arm64: dts: qcom: msm8916: Enable modem and WiFi
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
References: <20210312003318.3273536-1-bjorn.andersson@linaro.org>
 <20210312003318.3273536-6-bjorn.andersson@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <0c7e402a-6c68-87f3-1ac3-bfb071926831@linaro.org>
Date:   Mon, 15 Mar 2021 11:57:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312003318.3273536-6-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/03/2021 00:33, Bjorn Andersson wrote:
> firmware-name = "qcom/msm8916/WCNSS_qcom_wlan_nv.bin";

On the Linaro debian build I have to do this

+       firmware-name = "wlan/prima/WCNSS_qcom_wlan_nv.bin";

---
bod
