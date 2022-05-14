Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC95273C2
	for <lists+linux-wireless@lfdr.de>; Sat, 14 May 2022 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiENTdD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 May 2022 15:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiENTdA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 May 2022 15:33:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458851B7AD
        for <linux-wireless@vger.kernel.org>; Sat, 14 May 2022 12:32:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u23so19749039lfc.1
        for <linux-wireless@vger.kernel.org>; Sat, 14 May 2022 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kp0Ug+v47eYzPgOz78fUjRwt+4E0szT91XbUKkpzJNM=;
        b=QxxS4zLUOUc0+G26Yxyf7dONLWgYv6cOWDEjnYu6pEqztoiHpdY1879HogFxMYf3cB
         TiFfbHyPqGk85haRsY0hVr7mDDlPnW1xt7E7wEmz0rXeHXH6wDzo7Z7HwX6qy3sFYDqX
         21r0Q3g9lIpF987HbI6re1TWydYMqDFemtKHa8AsWxJdkyOEjdhMiNSbGGStWI+16gyN
         S3KsPjoyOrWk3zDZHfeOV2RHClwpegfOvPUKjV2GgD0xC6AHqZGWJIMHR+xDg9/6wX3n
         IDdTDqxJhy5Q7pnMRKDn3BVABk+TJkLki8/Xwb2IStC7dKzGsVIftbPuTNY1D6YQKqt5
         0zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kp0Ug+v47eYzPgOz78fUjRwt+4E0szT91XbUKkpzJNM=;
        b=8J01C1lihLHOSvCAmkjX5TzWLiPd9+YKkhWbCunrdiUwk4a6MDxKEFgmygEeP1nA96
         Bn2zw8JdzLgDB1KDPmHVjUSODBNmVhbo4xXspQgijQpD4HhsDk/DfsSy5V4gGaKCUVsi
         heddgw00UMAre6wyIIR9UNEXYWZ4n5EmAu9xghgkcoa/EGUUeYRIjL0uuiCBF3ptRT3j
         B05oiOTkOdcVyiFmtvvor/S8Ucv18F5YDlNAStbLOwHKSdLqp4EN8GK8cj1jABY53ZpJ
         ygd6As431Qa5mLrmaxfxCchSzTnQ+ti89DNNVh5sjqKZ9oqAPCbHXkbjLEBpEXhW3ieO
         5VJQ==
X-Gm-Message-State: AOAM533w3ElOpTbFdAYOKwTPW69Qry1JvorBSmIWjLwlFk42x9pUhWSI
        zGeeGZQxvqRY23sdWtfIFRCzJg==
X-Google-Smtp-Source: ABdhPJwdd8au+0vtvbq641vlyNJC2kEfL2SQBgdGtBNTNwL3G5mE3kPWcMxnmCspEplTbp0aLzodzw==
X-Received: by 2002:a05:6512:3a86:b0:472:6287:6994 with SMTP id q6-20020a0565123a8600b0047262876994mr7659273lfu.16.1652556775666;
        Sat, 14 May 2022 12:32:55 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w21-20020ac24435000000b0047255d211ddsm788920lfl.268.2022.05.14.12.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 12:32:55 -0700 (PDT)
Message-ID: <042e7478-dce3-7e78-e6fd-27251338fce8@linaro.org>
Date:   Sat, 14 May 2022 21:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ath10k: do not enforce interrupt trigger type
Content-Language: en-US
To:     Steev Klimaszewski <steev@kali.org>, Kalle Valo <kvalo@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
References: <20220513151516.357549-1-krzysztof.kozlowski@linaro.org>
 <87zgjl4e8t.fsf@kernel.org> <3d856d44-a2d6-b5b8-ec78-ce19a3686986@kali.org>
 <3bf28d29-f841-81f7-68f8-3fb7f9c274bf@kali.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3bf28d29-f841-81f7-68f8-3fb7f9c274bf@kali.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14/05/2022 20:09, Steev Klimaszewski wrote:

>> wcn3990 hw1.0 target 0x00000008 chip_id 0x00000000 sub 0000:0000
>> kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
>> firmware ver  api 5 features wowlan,mgmt-tx-by-reference,non-bmi crc32 
>> b3d4b790
>> htt-ver 3.86 wmi-op 4 htt-op 3 cal file max-sta 32 raw 0 hwcrypto 1
>>
>> With this patch applied, I no longer see the error message in the 
>> commit message, when I unbind/bind when wifi stops working.
>>
>> Tested-by: Steev Klimaszewski <steev@kali.org>
>>
>> -- Steev
>>
> Apologies for the second email - I've tested this now on both the Lenovo 
> Flex 5G, as I have seen the issue on it as well, as well as on the 
> Lenovo Yoga C630, where I did not but I did have issues with attempting 
> to rebind the device, prior to this patch.
> 
> Firmware version for the Flex 5G is
> 
> qmi chip_id 0x30224 chip_family 0x4001 board_id 0xff soc_id 0x40060000
> qmi fw_version 0x32080009 fw_build_timestamp 2020-11-16 14:44 
> fw_build_id 
> QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.0.c8-00009-QCAHLSWSC8180XMTPLZ-1
> 
> Firmware version on the Yoga C630 is
> 
> qmi chip_id 0x30214 chip_family 0x4001 board_id 0xff soc_id 0x40030001
> qmi fw_version 0x2009856b fw_build_timestamp 2018-07-19 12:28 
> fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1
> 

Thanks for testing, much appreciated!


Best regards,
Krzysztof
