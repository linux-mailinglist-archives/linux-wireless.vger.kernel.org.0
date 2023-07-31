Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECDE769F08
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jul 2023 19:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjGaRLj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 13:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjGaRLX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 13:11:23 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A231BFB
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 10:07:50 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bc886d1504so2614773a34.0
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823247; x=1691428047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tCYRS/m8Q77d36u6kfavnC5HkEQ/XrhdoqYNeS7cQxc=;
        b=o8VWD1LnPEbcul3WjLm8DChDE0jv1hS233NFdBmNDsoRRDkGNRNk6BxeGVoHIsPXeg
         t2Sy6BX1smLc0QKr6kHXXKvCG9q9QjmjL28FhCynFOtLzUr0kBHDWgXt0zaIWVNnjAuP
         Lkxav6YxUb1JEfnrL49Z/gXXZSHso36U8dNEeRfbbyc7lajQG/oEJGAhUiKIdAH1tqYi
         Z3MASlPoS01hg+MASyuBJ5eJxd2kj4lTEGjVs0boFiub7Bpurd9n1y/iIi2ccesvmV91
         bRjrpiM7nPTN3eWGepYRin0XAQa1VaxtL0Co2JPxeIyx76KyPPliwdzVtnozGvMtiu0w
         PvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823247; x=1691428047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCYRS/m8Q77d36u6kfavnC5HkEQ/XrhdoqYNeS7cQxc=;
        b=Z+EZ0i74MHUYogclkJeACWrPUdZu0XWTFTC/UdjGfn5/Hxj7gnYLFiscXR33lqa0cg
         nTbo8vvid+XJswna9olgFF/RUzXF4kzNYvabKCWdu3TBeEBEg0onptRCGjktmWDFjR50
         5KPelHEuf0sQ1Xr6hmnVbQObGBvkE2WrgljjKDt/Odgikqr78AFs6kJrn6ESymUZay3V
         jGeTh3uY8dIMVKyJROcfWO8AvddTU9C8xPn2LlPSkX9fOBa/bPdtNIRE+MCkrYkILpdL
         WVhMN6s7hYWNeTsbAa01kOf75RDpp6vCqYXIsacq7PjbsAXUmRuv8LeHLhPB9JJ3BDIY
         CtNA==
X-Gm-Message-State: ABy/qLaKnmEtYWkFjizYXhaFbH0a6yUCLHWx1nxJl59sGFyQss3PP/GU
        51u5gGvMZSa5bjGwebaAGzKLOaKilZg=
X-Google-Smtp-Source: APBJJlEswqnPX9kWUEkkSNMgXvKdi2BYzbdA0XONxq9vWqvzv9yjRKJsVunxFyJL1nzdb1mYwzFEcg==
X-Received: by 2002:a05:6870:a411:b0:1b3:8d35:c85f with SMTP id m17-20020a056870a41100b001b38d35c85fmr12397366oal.1.1690823246742;
        Mon, 31 Jul 2023 10:07:26 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id f201-20020a4a58d2000000b005658aed310bsm2290460oob.15.2023.07.31.10.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 10:07:26 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <9c17bcb5-d0af-6927-764f-a26d5db36e06@lwfinger.net>
Date:   Mon, 31 Jul 2023 12:07:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: Problem with rtw8723ds
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Pkshih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <52233a6e-e880-5160-7042-5a0dcce21b03@lwfinger.net>
 <CAFBinCDgJM65WC2JenR46OEcPsW=4+3L5ei_Kr_88kGNrTT-Bw@mail.gmail.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAFBinCDgJM65WC2JenR46OEcPsW=4+3L5ei_Kr_88kGNrTT-Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/30/23 13:54, Martin Blumenstingl wrote:
> I have a few questions here:
> - is the wlan0 interface present?
> - does "$ ip link set up dev wlan0" do anything?
> - does "$ iw dev wlan0 scan" work?
> 
> Also do we know more about the host (e.g. which MMC/SDIO host driver
> is involved)?

Martin,

No, wlan0 is not set up. Anything referencing it will fail.

I have asked about the MMC/SDIO host, but the OP never responded to that 
question. The OP is an engineer, and not the best with software. His dmesg 
output lists the following:

mmc0: SDHCI controller on e0100000.mmc [e0100000.mmc] using ADMA
mmc1: SDHCI controller on e0101000.mmc [e0101000.mmc] using ADMA
sdhci-arasan e0101000.mmc: card claims to support voltages below defined range

That last line would indicate the pci-arasan controller. If that is not 
sufficient, how would we get that info?

The CPU is a Cortex-A9 dual-processor unit, and he is running Linux version 
5.4.0-xilinx (oe-user@oe-host). Dmesg also reports
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d

If you want to eliminate the middle man and ask the OP questions directly, the 
GitHub thread is
https://github.com/lwfinger/rtl8723ds/issues/41#issuecomment-1656990344

I have tried to get some logging of the SDIO traffic to see if I can find 
differences between the vendor and rtw88 drivers. Thus far, I have not made much 
progress.

One thing he has noted is that the LDO with the vendor driver is 1.25 V, but 
that rtw88 has it as low as 0.82 V. On one occasion, it was 1.22, but that made 
no difference.

Larry


