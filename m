Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8422623053
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 17:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKIQkN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 11:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiKIQkJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 11:40:09 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C1B1AF0C
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 08:40:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id b2so48279060eja.6
        for <linux-wireless@vger.kernel.org>; Wed, 09 Nov 2022 08:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKQQLbeg7eAQAwz5t2sIdkNfAdER2CbXB5FfXfdjF94=;
        b=Ox0nG4VLf7gchvOEt1bHyxZM1/cPWv9ihfY5Uh8PFlrjKaL+b2njR0Js41JBl2W6Pu
         SWnkTRIJgYcIQ5brigi/hQc81X7sADJ+0NHHqAG9SaThlJ2IaGS7/St1CYBS/GGYcLz8
         IqCBmvAdahsaiMZSngNrxv4zM2448jn1ixTfHdyjx7DsMndbzrPDI+7BR34VmRQtHhyU
         VNSHw6rJxx29DpE36lIkqVfMCiEl7yNZ2qghRZ7hPNaycPgxLWYFPp6Iesa9xZh5YuFp
         0grrEfLjuN8LJReLT6DVNoUms2VhnOcxYvVrSDLy5Gu/h45EgaApqIpVhMGZ2n2Kd3sL
         srQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKQQLbeg7eAQAwz5t2sIdkNfAdER2CbXB5FfXfdjF94=;
        b=g3fNXJOjcVHNlGCh5bxNst1XhGXYgakG2c0t9ExGQ+G+PxJiokM3wQlDEScu4JFEP2
         DcIXPKB4whWinm/rA2NvNYtvxel8B2ta5023C7C2O9UGqKwwhKs4Oug6lkGyaBqpoN5q
         9UIHFMzds3RXGVdTFzg1Q5NOp9h8aO/AEjTWzu0K9qbM106WBaH4WIPXV3FeT86/SJ+k
         lM4/FVplqTPxxHqDtoudcHWQZy4gCkLlU+DVeT9JvFXqWlwUUZ/NNpPekvmsMpmLZ9+4
         3/jQn8iGrkhEeyEXECOnM/OPbf9FcOzkGiKRzQCn5E/DTV9ipiWRrw3VnpEDU6RaN9Tp
         z9/w==
X-Gm-Message-State: ACrzQf0L+fXEgcO3MEXJa8gWz4q6Ln5ii0XvT55dLF4OQ/0rVaMOcULW
        KEn5bqSIj6gw9dnfW9U/NRE=
X-Google-Smtp-Source: AMsMyM7iL0Q66TYUJH6wERpewULJ0Dvpelio5QnmSd/ukKz+0TN5TC3lYR2Qy+Cfy2+A5+YREaNyFw==
X-Received: by 2002:a17:907:2bd9:b0:7ad:c301:a799 with SMTP id gv25-20020a1709072bd900b007adc301a799mr53060105ejc.713.1668012007326;
        Wed, 09 Nov 2022 08:40:07 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id eg23-20020a056402289700b00461aca1c7b6sm7259478edb.6.2022.11.09.08.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 08:40:07 -0800 (PST)
Message-ID: <55da7e44-b93a-c24f-0c52-d8ea6deb5e39@gmail.com>
Date:   Wed, 9 Nov 2022 18:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/3] wifi: rtl8xxxu: Name some bits used in burst init
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <91f59414-86f7-f0ed-a138-19f0ab63bb0b@gmail.com>
 <c357973fd0e547e69c03a8d7cfc092d2@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <c357973fd0e547e69c03a8d7cfc092d2@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 09/11/2022 02:41, Ping-Ke Shih wrote:
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Wednesday, November 9, 2022 2:54 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH 1/3] wifi: rtl8xxxu: Name some bits used in burst init
>>
>> Names provided by Ping-Ke Shih.
> 
> Ha. That looks weird to see my name in commit message. Could you say
> "use descriptive names instead of magic number" or something like that?
> 
Of course, I'll change that.

