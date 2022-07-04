Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D128565912
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiGDOz2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbiGDOzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 10:55:20 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15D326EA
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 07:55:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id q11so13143744oih.10
        for <linux-wireless@vger.kernel.org>; Mon, 04 Jul 2022 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AL1mPhVwmqgJOq4qBoavxTjoFGTeQkOD1tCi+AVbiLI=;
        b=OfseH1nRO3Jhooo1XwoMlHNkLecQ8JNg+o1fw2mV+Y2roP7mtL0xnfzcC509L+dbu5
         cBuW67YxSTEHA1wj4zEjdjJHHfS/7haqkxoaMY9IUtDb5NH2BP/bpUCYRbkKrBOpJui8
         ++TDjXCRWiAeo6/OJ43ZI0fA7MWhhb6zdzfkW5bcRKO7t+thuKX+S9oZHpBg5c4B9t03
         k+Sqv7cwHoTgPBbAE4ZJsnSQ6QMgeQLfNTqbil7bakzQklfgQaMw9/hn1QLw0HTUHwto
         xleYClw7LU0npcYWzGSCaRYMY9gFf4syicBt/Vliw6RYWQ3ho8f0CX/lm+b7iWFsobeg
         arlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AL1mPhVwmqgJOq4qBoavxTjoFGTeQkOD1tCi+AVbiLI=;
        b=O0oScDYilWQzqotQxjSw29vsEPNxGwKbZhG8G4y/KeRTcBYNRW6sEnXUbTQ1FPhcAJ
         z4mqZyyoQfKkQZvfLusDg3ng0EIDESVW3Z5FHVjTtIWzJNnv+ko786IoG/jgmphzyFWd
         Tjh/gH4eDxPffLUQS+MbNHRNLveZyIyM6EFr4OzB7VAvNwjuTqL+EiNo3rLaNjG4bovx
         RJRKdeTiL5H9KlQxeM0GPzZt2ZXr6LJre/ZkrbLbFJzK4iMSUT6C0sZOwqWSZtmsXb3t
         Uj4RqMWSMJlfclq312ndw/1S8Rn7/zCyq3AGh0vqSEJwNZ1Aw+prCPODHxsb1qjIxbm0
         1eiw==
X-Gm-Message-State: AJIora8KsJM20FoGyGZAxQxxc9DqdGwMUWcL6ttmRVn3wIg7jEmRsVpI
        r7MBNYxNrXhAOpYu0LDtwAgJQO5riMQ=
X-Google-Smtp-Source: AGRyM1tH8ubM0DVWCIEC6AqMeC5OLf1/BYBU2WjpFDTzTvsakiPl3NfoLFDKy3w7nbQADjIo2I5HKQ==
X-Received: by 2002:a05:6808:103:b0:334:f9b1:ede2 with SMTP id b3-20020a056808010300b00334f9b1ede2mr17027045oie.54.1656946511799;
        Mon, 04 Jul 2022 07:55:11 -0700 (PDT)
Received: from [192.168.1.108] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id x20-20020a056870b41400b0010830c24aaasm9688851oap.56.2022.07.04.07.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 07:55:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <c2410812-ae12-6e31-4496-40644eacf0bd@lwfinger.net>
Date:   Mon, 4 Jul 2022 09:55:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: BUG: b43: ssb init failed with pcmcia bus
Content-Language: en-US
To:     =?UTF-8?B?5bCk5pmT5p2w?= <yxj790222@163.com>,
        linux-wireless@vger.kernel.org
References: <107e64a6.54f2.181c946ea99.Coremail.yxj790222@163.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <107e64a6.54f2.181c946ea99.Coremail.yxj790222@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/4/22 07:54, 尤晓杰 wrote:
> 
> I got 802.11b card debian sid(Linux debian 5.18.0-2-686-pae #1 SMP PREEMPT_DYNAMIC Debian 5.18.5-1 (2022-06-16) i686 GNU/Linux
> ) reconised it. But ssb could not be reconised
> dmesg:
> [ 1268.029113] pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
> [ 1268.029646] pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 21)
> [ 1268.117186] ssb: Failed to switch to core 0
> [ 1268.117225] ssb-pcmcia 0.0: Initialization failed (0, -16)
> [ 1268.117232] ssb-pcmcia: probe of 0.0 failed with error -16
> allan@debian:~$

That combination of outputs and the -EBUSY (-16) error means that the driver was 
unable to read or write a configuration variable at SSB_PCMCIA_ADDRESSX, where X 
is 0, 1, or 2.

There is a possibility that your card is broken. Please post the portion of the 
output of the command 'sudo lspci -nn -xxx' that describes the b43 device.

Larry
