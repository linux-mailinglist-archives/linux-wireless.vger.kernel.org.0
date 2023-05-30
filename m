Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D54716CED
	for <lists+linux-wireless@lfdr.de>; Tue, 30 May 2023 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjE3Sza (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 14:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjE3SzZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 14:55:25 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54092107
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 11:55:23 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6af6b6837acso3522747a34.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472922; x=1688064922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iJvIEXk615iakzxoojFW7R7YqEq2wqqW+hs+JWcxl5M=;
        b=g3o1k0nT2WHO+zyFMi1vOP8riTu1C2/rLmqXQitxQ2gcflB60TN8E9/J+zhLBFB4Jh
         xIaqQjwM8WY8/UotgJFiK/hlLVmRCGLS3hS3BKloYHU7npO/wx+41x4nQZHAeOXY8CIB
         T6k7u3NKx9A6iNfh0rZvM+TVw1WF9rl/V7n8jZfbvrmwGJea+/O5SeObtEK3ccdW8n1u
         2g0kpjsPy2reI36qyEG58j8RPdfxoGBrmfQejTSldShD6JIkvDeJSUqtgnIV8M3n2k4Y
         FfWxp12zLHODIyO64yuoWGzedQH80luhNMixI1+7nOCMsoc6B3iOoWE47ymhzzDXMLVV
         uNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472922; x=1688064922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJvIEXk615iakzxoojFW7R7YqEq2wqqW+hs+JWcxl5M=;
        b=W+NWqet17KFEJrQ0wf8p6mpHMqGJ8mh+uh/gUmKZzaxO5UvBn52XHLACXXfDFcp8af
         r91zXojDQuOgpaZCbSIm64FRtVHl6sG164a/xQ95a7XNfI7eiDffQHUg38Sxdu8N0gQT
         60zrNHMr3GFUb8FKlc2yu6Q6uFeyt5rIO6Xf9Y+Rl/jOTzTGaAqkAshaj3pVPsmBa/tA
         11+nAz6PyhSJ1ZHGj23R7QPdSv9eAVbMiyxUVwYDToBRbZHDxd/EYn4oKSzt9Q3AbVxF
         buBZPfxRgw6jXnOP+/CSHipdD+/ffapOEB7qDRTC0r2w2Ci/+ndUaWnxMgxtapLMBh/y
         Y8qg==
X-Gm-Message-State: AC+VfDwgjy/yP8Og2RtKIgTFcXgeOdoThLNcAYtWj9Q0mI8B6Pk0wNdd
        4RrajFF1q3PkyxlH9Iajysg=
X-Google-Smtp-Source: ACHHUZ4e0lBeH8oIXR8PpTxCTXAVP5HCWffbgEEs1x0R58QuIb0KQ1u7tpyxKj/RJ/fX8HIpcfsImA==
X-Received: by 2002:a05:6830:1355:b0:6af:9900:1a87 with SMTP id r21-20020a056830135500b006af99001a87mr67110otq.29.1685472922477;
        Tue, 30 May 2023 11:55:22 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id z3-20020a4ab603000000b005559f182cd6sm5440826oon.12.2023.05.30.11.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 11:55:22 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <bee18794-8c4a-2af9-cf1c-807969be3dd2@lwfinger.net>
Date:   Tue, 30 May 2023 13:55:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] rtlwifi: rtl8188ee: drop RTX_POWER_BEFORE_IQK_A and
 RTX_POWER_AFTER_IQK_A reads
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Dmitriy Antipov <Dmitriy.Antipov@softline.com>
References: <20230530155446.555091-1-dmantipov@yandex.ru>
 <b747b45e-e176-4c55-0886-abfcb1e33717@lwfinger.net>
 <09191d90-c29d-bdf5-4192-19553f8911fd@yandex.ru>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <09191d90-c29d-bdf5-4192-19553f8911fd@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/30/23 13:26, Dmitry Antipov wrote:
> On 5/30/23 20:42, Larry Finger wrote:
> 
>> I do not know the answer to this question either, but how does
>> your tool know that the statements between the first read and
>> the second have not caused the firmware to change the contents > of the BB 
>> registers?
> 
> This tool is a static analysis software and has no special knowledge
> about any particular hardware. So I do not strongly insist on this
> change which should be treated as a subject to more detailed consideration.
> 
> I've noticed 6c75eab0417b9e5b05a18dbfc373e27a8ef876d8 where rtl_get_bbreg()
> is preserved but the result is ignored. Would the similar thing be a kind
> of a cleanup for this case as well?
> 

Yes, you could ignore the output from rtl_get_bbreg() for lines 1484 and 1485.

Larry

