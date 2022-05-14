Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FED52736B
	for <lists+linux-wireless@lfdr.de>; Sat, 14 May 2022 20:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiENSJR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 May 2022 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiENSJQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 May 2022 14:09:16 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7046E01F
        for <linux-wireless@vger.kernel.org>; Sat, 14 May 2022 11:09:14 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n24so13901557oie.12
        for <linux-wireless@vger.kernel.org>; Sat, 14 May 2022 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=9VxSQhrcxP+Zxiex+/IGfZgunbN+QMPUuJtoX8ADJq0=;
        b=gwi8wGZKaAhyEL2N8U2FdTZRADeWgto+anF1Hh8tRJwSSQjeEhaDwQcYwrSGkxXZ0W
         BCnI9tOAs0bAF5kUYusrUQSQ0N5RSoYQ3/USaCh27tau0QhOVZfZuHOhEDaS7aLc+8HU
         dnKwj/A8/ag0Bg+w26MOFg3Sej3B3TuZ/jPyZHQMU3KUEXOu07NXmArf+6PcFmy7olm0
         vbJ5cYaHQt6BfVv3iaGLTcz2U1ovsCpDQleUmuoPAW9taQVe1uBMhabIY1Twl1gBjcLw
         6rGUvCe89RNNnWV+75sAC5j4pzGeBBWu97+HuM7nEEnWLTSnqUukEukd9a1Lk7nzb96O
         Mcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=9VxSQhrcxP+Zxiex+/IGfZgunbN+QMPUuJtoX8ADJq0=;
        b=iyzYpirR/qMF1oqABFsPijPH0TpRokd9ZOK7jEjV1vJUHDjgX2MlUSfn8hXhA8v2+r
         HfDzbhek/FFFcVFBZbCJFU8ELGi+1/auvijrseGlpEzeBMoW6qBTj1IEcUT5DazdFzfD
         VfwYDaJvCRriVV5WTgNgwfteK3ANqA/f6xfYNoQFQlDMM8lQpwmy7gQqxgWqmmTGBfDM
         ZZkG35ezgobIEzCuAynnfQ4DlelS0uhO/K+dH0GOIEmqHZIAeK28/PgzBs88gKbfGjUd
         +dEyWTakMtdaBZPSiyYHZKquuMZcWP3n972IiIkLZo0PuIKUlT+5arfHp6fDRQV4zTGi
         JpDQ==
X-Gm-Message-State: AOAM533ooM+ibjHhfdyHHPxgORTx4B3oLZDDcQuinnXBGDNg+BEcj/Dn
        ptgWJ15QA186Htn2RmSREKhCag==
X-Google-Smtp-Source: ABdhPJwrvgAl50ASW9OPusxZQgrhHauO8CR+M14xcbBoh7KOYWtJ47rV3oDIQEF/CrNs8vca+izgNw==
X-Received: by 2002:a05:6808:98f:b0:325:d44d:62d6 with SMTP id a15-20020a056808098f00b00325d44d62d6mr10052930oic.145.1652551754058;
        Sat, 14 May 2022 11:09:14 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id y127-20020aca3285000000b00328e70cae5csm774163oiy.43.2022.05.14.11.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 11:09:13 -0700 (PDT)
Message-ID: <3bf28d29-f841-81f7-68f8-3fb7f9c274bf@kali.org>
Date:   Sat, 14 May 2022 13:09:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] ath10k: do not enforce interrupt trigger type
Content-Language: en-US
From:   Steev Klimaszewski <steev@kali.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Govind Singh <govinds@codeaurora.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
References: <20220513151516.357549-1-krzysztof.kozlowski@linaro.org>
 <87zgjl4e8t.fsf@kernel.org> <3d856d44-a2d6-b5b8-ec78-ce19a3686986@kali.org>
In-Reply-To: <3d856d44-a2d6-b5b8-ec78-ce19a3686986@kali.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 5/14/22 12:05 AM, Steev Klimaszewski wrote:
>
> On 5/13/22 10:57 AM, Kalle Valo wrote:
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
>>
>>> Interrupt line can be configured on different hardware in different 
>>> way,
>>> even inverted.  Therefore driver should not enforce specific trigger
>>> type - edge rising - but instead rely on Devicetree to configure it.
>>>
>>> All Qualcomm DTSI with WCN3990 define the interrupt type as level high,
>>> so the mismatch between DTSI and driver causes rebind issues:
>>>
>>>    $ echo 18800000.wifi > /sys/bus/platform/drivers/ath10k_snoc/unbind
>>>    $ echo 18800000.wifi > /sys/bus/platform/drivers/ath10k_snoc/bind
>>>    [   44.763114] irq: type mismatch, failed to map hwirq-446 for 
>>> interrupt-controller@17a00000!
>>>    [   44.763130] ath10k_snoc 18800000.wifi: error -ENXIO: IRQ index 
>>> 0 not found
>>>    [   44.763140] ath10k_snoc 18800000.wifi: failed to initialize 
>>> resource: -6
>> So you tested on WCN3990? On what firmware version? I can add the
>> Tested-on tag if you provide that.
>>
> Hello Krzystof, Kalle,
>
> I have seen this issue as well on a Lenovo Flex 5G, which has a WCN3990:
>
> wcn3990 hw1.0 target 0x00000008 chip_id 0x00000000 sub 0000:0000
> kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
> firmware ver  api 5 features wowlan,mgmt-tx-by-reference,non-bmi crc32 
> b3d4b790
> htt-ver 3.86 wmi-op 4 htt-op 3 cal file max-sta 32 raw 0 hwcrypto 1
>
> With this patch applied, I no longer see the error message in the 
> commit message, when I unbind/bind when wifi stops working.
>
> Tested-by: Steev Klimaszewski <steev@kali.org>
>
> -- Steev
>
Apologies for the second email - I've tested this now on both the Lenovo 
Flex 5G, as I have seen the issue on it as well, as well as on the 
Lenovo Yoga C630, where I did not but I did have issues with attempting 
to rebind the device, prior to this patch.

Firmware version for the Flex 5G is

qmi chip_id 0x30224 chip_family 0x4001 board_id 0xff soc_id 0x40060000
qmi fw_version 0x32080009 fw_build_timestamp 2020-11-16 14:44 
fw_build_id 
QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.0.c8-00009-QCAHLSWSC8180XMTPLZ-1

Firmware version on the Yoga C630 is

qmi chip_id 0x30214 chip_family 0x4001 board_id 0xff soc_id 0x40030001
qmi fw_version 0x2009856b fw_build_timestamp 2018-07-19 12:28 
fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1

