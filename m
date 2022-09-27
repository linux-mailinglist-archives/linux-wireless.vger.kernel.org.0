Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79C55ECD24
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 21:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiI0TtM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 15:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiI0TtK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 15:49:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB111B8692
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 12:49:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c30so13440776edn.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 12:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Kh9VhIbAqqpxrVaH6TD1pxAYzrcHTMunAiWw8OIGpgY=;
        b=FXOF5xQbqiWiV6NpDNOV1N0Hy/FMkLJBPhG21qpeYHRrgsXCdQGf57SaVp/DbH4ww7
         mraHmttKzhgdGZsptG692XsVBkulWxjP6OCJdXfs77BOGd9STtCSMs1QTw/w0HZMx2kJ
         +zhEE859BgmwoyWXbxZqGGF/6c5zyuJ7CMyKbG44Qig/mWtnJRZlbeb96rOMbHK0mi0w
         GSBLqL1zeF9GSH2HsP7lXznxjf14WF91/zXSEjsvHg7KiMrLcb84ErjoPOOIBfe9bTbb
         UlxGbtlOCAI5CpWrDepMvCZ+UteBP6jlqihbaWnEVQmSx66Z6lfWnyycO1DOiQJgF3Bl
         W3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Kh9VhIbAqqpxrVaH6TD1pxAYzrcHTMunAiWw8OIGpgY=;
        b=jHlFMKoexREGbf6ZAGJwh67MAx5kGCtsHa8jegktRy0eV6QskrsIYaBGoIarVEY5Uh
         w1dwdkU0AuiwXz8yHrd9FY8g3Nr2Vo8rTMP214VyqV5HWbEMu/RH+qhiVtuiU45+yyes
         AZ4fIXtl3/PGE8Y78wRC0uIaxyihAuexSM4BAIf9JoBmSp8wgzJl9tulhcVZqSHH7+HF
         cD8zqJ9m7jD0gYIn9/Tbm2RACUILBQ9nGhACtJm5a9454fhMY55URnZi2i0hIn0XBh7L
         Pceck9QUQt1qjeAdeoFtWW8Cyv34lVhOBXYVEg3X1LVNkTU4WgBn0bvKKucpcyxEcMDg
         Gliw==
X-Gm-Message-State: ACrzQf3PYURAk4TpJ0WX8dEzMiq6KYek6TV5pcrIhmAqxl71ZmmxsC87
        zMKyn+4QitE43m4FVen5vIU=
X-Google-Smtp-Source: AMsMyM4oVwbxVu8sw60dixBDA6QVU9GUdhIM0DIezDH464CHnpKf+vvfh/5bnnzLfZqqkKGfh6TGbw==
X-Received: by 2002:aa7:c689:0:b0:457:2012:2374 with SMTP id n9-20020aa7c689000000b0045720122374mr15907788edq.229.1664308147880;
        Tue, 27 Sep 2022 12:49:07 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7d9c2000000b00457c321454asm1511927eds.37.2022.09.27.12.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 12:49:06 -0700 (PDT)
Message-ID: <5ba1e0f4-6eda-43bb-d426-e2a9447cd06e@gmail.com>
Date:   Tue, 27 Sep 2022 22:49:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/4] wifi: rtl8xxxu: gen2: Turn on the rate control
Content-Language: en-US
To:     Jes Sorensen <jes.sorensen@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     chris.chiu@canonical.com, Barry Day <briselec@gmail.com>
References: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
 <78cec57b-2678-acf3-99b3-271e0f9bdbad@gmail.com>
 <ac73924f-4c52-b8e6-1628-e34fc673a35d@gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <ac73924f-4c52-b8e6-1628-e34fc673a35d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/09/2022 19:53, Jes Sorensen wrote:
> On 9/18/22 08:35, Bitterblue Smith wrote:
>> Inform the firmware when connecting to a network. This makes the
>> firmware enable the rate control, which makes the upload faster.
>>
>> Don't inform the firmware when disconnecting from a network, because
>> that makes reconnecting impossible for some reason:
> 
> Have you dug through the vendor driver to see what it does here?
> 
> Thanks,
> Jes
> 

I hadn't investigated, but since you asked :) I looked into it today.

The vendor driver doesn't do anything weird. Our report_connect
function *should* work.

And it turns out it does work! I restored the original form of the
function to test something and reconnecting worked. I couldn't
reproduce the problem anymore. Not much has changed in rtl8xxxu since
the last time I tried this, so it was easy to find the reason: fixing
the queue selection [0] fixed the reconnecting problem. Before, it was
sending the auth attempts using queue 0x7 (TXDESC_QUEUE_VO). With the
queue selection fix it uses queue 0x12 (TXDESC_QUEUE_MGNT). Perhaps
queue 0x7 is not functional when the firmware knows it's not connected
to a network?

I guess I have to send a different patch for this now.

[0] https://lore.kernel.org/linux-wireless/7fa4819a-4f20-b2af-b7a6-8ee01ac49295@gmail.com/
