Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84172A0FD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 19:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjFIRLy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 13:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjFIRLw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 13:11:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D1A3C33;
        Fri,  9 Jun 2023 10:11:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51491b87565so3375673a12.1;
        Fri, 09 Jun 2023 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686330692; x=1688922692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbYIw9tUAYWWQYDm2hFNShk0R2ieZOPDUqTCunugD/A=;
        b=k2mhiJUDrPJ76VLaEaKbjJ/hz3WPVGtjxVdkafO4KOn+RTACjDdx5aaGQav+/cbCOq
         1OMWHVJBaMB8ADDgpzpSG6zm83yVEgjiYbARcbSf77VpeVqrJynS+cBIguI242sF7XSv
         e35YSHXJKUk3C/vTXUL+4mdSW7vJgujXhsaPyIixMdXDEIXDgIMZpwQ9K9yzS1RWfcuT
         0r+EbEWkO4SkoiqHoptCuQIp0v1ZCI4EpxiGW1N9fW/w2DBWYZI26i4l4qAipmfvWxaN
         GJfILye+6Jj8or91eyCSO0de8nEM1ZmQID++CDmTgA8yzgzBo+KntXmJ2ynEpoqhVMGz
         ek8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686330692; x=1688922692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbYIw9tUAYWWQYDm2hFNShk0R2ieZOPDUqTCunugD/A=;
        b=YGz5EHFRGxvg0vCSb8YNqBOuPlKFnA7Dal7V+TzCk33ksvBzwMXlvSKzTAEJTeYGMg
         T0TB6cnK8ufnuYghEeNkPrHVrZbq2DQfdHn1ulmDb9m1wQWutV/tL2N7Z7GuLvjneMBT
         dBH6nInkScByJpO9aYXfk9AWf78BMLUzCStTeOQ22eHW6c/pQBiRPlVEVhgty8u85doX
         CpxFnHcqh/KfONdiv+lkuxUsRam5lv4LrkfDCJVycSmZ7bWqDpH0fvZEESLD/UQkVcO+
         w2nUqamqFLnKcyQbY4MWEX7919xzF7WPG5houTXV14gBE1r7ZiSg4IInKS3Hy0JawG1l
         EgZA==
X-Gm-Message-State: AC+VfDwOqeHuY7NTtZ2+maS+hG9wMV/dS9vB9WoyK8gXompT1c6H6ao9
        vQRElEa9z6mXBrMiQ3HLvU4mjAnKBZY=
X-Google-Smtp-Source: ACHHUZ4+hTREUq2MAVjfeoHl9XRMnmtbKRLp1dSQWatMZz/rqBIwfUm0F4ppoWKXbON0L/AabZjEHg==
X-Received: by 2002:aa7:c1c5:0:b0:516:4394:244f with SMTP id d5-20020aa7c1c5000000b005164394244fmr1437097edp.12.1686330691851;
        Fri, 09 Jun 2023 10:11:31 -0700 (PDT)
Received: from shift.daheim (pd9e2959c.dip0.t-ipconnect.de. [217.226.149.156])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7dd48000000b0051499320435sm2016281edw.14.2023.06.09.10.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:11:31 -0700 (PDT)
Received: from localhost ([127.0.0.1])
        by shift.daheim with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1q7fca-001jV8-1i;
        Fri, 09 Jun 2023 19:11:30 +0200
Message-ID: <54175c04-00f3-0094-7b70-3d08c0ab9d71@gmail.com>
Date:   Fri, 9 Jun 2023 19:11:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/2] dt-bindings: net: ath11k: add ieee80211-freq-limit
 property
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, kvalo@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <a3075482150d342f71ec235badacec32cdd6c553.1686300243.git.chunkeey@gmail.com>
 <20230609165104.GA1257474-robh@kernel.org>
Content-Language: de-DE
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20230609165104.GA1257474-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/9/23 18:51, Rob Herring wrote:
> On Fri, Jun 09, 2023 at 10:44:54AM +0200, Christian Lamparter wrote:
>> This is an existing optional property that ieee80211.yaml/cfg80211
>> provides. It's useful to further restrict supported frequencies
>> for a specified device through device-tree.
>>
>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> index 7d5f982a3d09..91bf69c2df01 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> @@ -58,6 +58,8 @@ properties:
>>       minItems: 1
>>       maxItems: 2
>>   
>> +  ieee80211-freq-limit: true
>> +
> 
> You need a ref to ieee80211.yaml as well.

Yes. will fix that.

(Related to that: ath10k already supported ieee80211-freq-limit since 2018
but not in the binding. will post a separate patch shortly)

Regards,
Christian

