Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508A167DF75
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jan 2023 09:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjA0Irx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Jan 2023 03:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjA0Irw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Jan 2023 03:47:52 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBFC9757
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jan 2023 00:47:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso2884270wms.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jan 2023 00:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YAjXmwk1x99crswBLoztPVjTMQo0TWbhtFaOuaefFpg=;
        b=sgVcP+HYC8/PumGjTBslJK+Fm6tY3mPAsR2M5YXg7CWnU1X3QUtzE0qtwGLjBdCg3e
         eh+emEu/FTTs8p5NIf/9hvBo3I8rVuhZrmk2pLLxqN0jXeJ1oxjMETjsA08RvPvwp2R8
         MqKDcMJOJEvI8snx9w35PnL3u3xJmvqaUjA6mKoQj3HdlvcFrGV3BqfL1q+L8zwvbqqW
         PtkR/7HASCQUmv7kGOg5XA1rAof8poeb+HyczXTx62y9xDqa/q6OEDpEKVhC0DOCRGoB
         N7IJOtuhzfn97nLV+8sJwUCjwB6iGsERruXDvQIT1p3Sp+lcSrsVdVyCqzuy7rDp6UvV
         4LHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAjXmwk1x99crswBLoztPVjTMQo0TWbhtFaOuaefFpg=;
        b=hcUU5IHYWvsIjCDP/zgK8CEL/wBw9ezzFLkDTnVsikVg/vDXeW0bkVf+vYHT610qS1
         ySDZHjT90XDeVYhSdbL8AR6mOUyXCeToU1ngWWqedxG8kQ03tadQ5h6+MtUSiwv5Sy0/
         asVrJpCRG/QGsIM2GN66B7ZTAL93RMOsJnOKyujKjdT1ZiBVxnPsRgTap70bRQyf/81p
         6Dmc1M47ukiOZMuqKWgnwKQmyq1r3YBbMnTBpvH07fLfbTjN0UndAFHiRdQYes5h1F5o
         rIORJDUyT49Q+Yd2fAGdcNE4LcoonN2Lt3IdaS93Ny5ebwz5zOAfko7lqNnoYt57cq5v
         rc6Q==
X-Gm-Message-State: AO0yUKW35/pAI3WZgbJ3YVtHFSbW/Ph9DCc6iFk/gT6CXFoGIuG9UHkR
        68RsfCAH5ZQsX8JThs9J2NDNkxQVZsX4pFmt
X-Google-Smtp-Source: AK7set/wMnfLn7hvAh6pV+9S6aVWZoLm4JL4Cw1Jq8PedxXE7NxReQHkBv90Wyy9FzAIHvxMwhvqyw==
X-Received: by 2002:a05:600c:3b82:b0:3dc:37bf:c634 with SMTP id n2-20020a05600c3b8200b003dc37bfc634mr1422499wms.15.1674809268950;
        Fri, 27 Jan 2023 00:47:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v23-20020a05600c4d9700b003cfa81e2eb4sm3674626wmp.38.2023.01.27.00.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 00:47:48 -0800 (PST)
Message-ID: <ff2a546c-e650-75b8-de2e-d682b9c79624@linaro.org>
Date:   Fri, 27 Jan 2023 09:47:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] dt-bindings: leds: Document Bluetooth and WLAN
 triggers
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Lee Jones <lee@kernel.org>
Cc:     patchwork-bot+bluetooth@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        robh@kernel.org
References: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
 <167460363944.4058.4676712965831302643.git-patchwork-notify@kernel.org>
 <Y9FG5Wg0PmP4zfV6@google.com>
 <CABBYNZJEU-GD5J6K8_Ur4PWLvP10VNJGP7e_43H0=W3DOS=PNw@mail.gmail.com>
 <Y9IzMWnOq+r2/4V2@google.com>
 <CABBYNZ+Na7os7D_C_iV22UhyhobxiETjKkngPWVr14QAph6DfQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABBYNZ+Na7os7D_C_iV22UhyhobxiETjKkngPWVr14QAph6DfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 26/01/2023 21:46, Luiz Augusto von Dentz wrote:
> Hi Lee,
> 
> On Thu, Jan 26, 2023 at 12:00 AM Lee Jones <lee@kernel.org> wrote:
>>
>> On Wed, 25 Jan 2023, Luiz Augusto von Dentz wrote:
>>
>>> Hi Lee,
>>>
>>> On Wed, Jan 25, 2023 at 7:16 AM Lee Jones <lee@kernel.org> wrote:
>>>>
>>>> On Tue, 24 Jan 2023, patchwork-bot+bluetooth@kernel.org wrote:
>>>>
>>>>> Hello:
>>>>>
>>>>> This patch was applied to bluetooth/bluetooth-next.git (master)
>>>>> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>>>>>
>>>>> On Sun, 22 Jan 2023 11:47:27 +0100 you wrote:
>>>>>> Add the missing trigger patterns for Bluetooth and WLAN activity, which
>>>>>> are already in active use.
>>>>>>
>>>>>> While at it, move the mmc pattern comment where it belongs, and restore
>>>>>> alphabetical sort order.
>>>>>>
>>>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>>>
>>>>>> [...]
>>>>>
>>>>> Here is the summary with links:
>>>>>   - [v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
>>>>>     https://git.kernel.org/bluetooth/bluetooth-next/c/ef017002b93b
>>>>
>>>> Why are you taking LED patches through the Bluetooth tree?
>>>
>>> I assume there isn't a tree dedicated to dt-bindings/leds
>>
>> % ./scripts/get_maintainer.pl -f Documentation/devicetree/bindings/leds/common.yaml
>>  Pavel Machek <pavel@ucw.cz> (maintainer:LED SUBSYSTEM,in file)
>>  Lee Jones <lee@kernel.org> (maintainer:LED SUBSYSTEM)
>>  Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>>  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>>  Jacek Anaszewski <jacek.anaszewski@gmail.com> (in file)
>>  linux-leds@vger.kernel.org (open list:LED SUBSYSTEM)
>>  devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>>  linux-kernel@vger.kernel.org (open list)
> 
> Well this doesn't tell us what parts of the dt_bindings have a
> dedicated tree and which doesn't, 

There is no such "parts" anywhere. I don't understand that remark and
how is related here. This is a list of maintainers for this file. Why
information are you missing in MAINTAINERS? And why bindings would be
special (e.g. you don't miss this information for other parts of kernel)?

>>
>>> anyway I'd be happy if the dt-bindings patches
>>> would be handled elsewhere.
>>
>> Yep, we got this. :)
> 
> So if it starts with dt-binding: prefix shall we ignore? Or is just
> for dt-bindings: leds? Or perhaps we can just ignore patches received
> as CC: rather than directly To: field.

What was exactly unclear in my response? The bindings for your subsystem
are for you. Bindings for other subsystems are not for you. dt-bindings:
leds: are for leds suubsystem. dt-bindings: mfd: are for mfd subsystem.
If the prefix is incorrect because people make mistakes, the paths point
to it - Documentation/devicetree/bindings/SUBSYSTEM_OR_HARDWARE_CLASS/....


Best regards,
Krzysztof

