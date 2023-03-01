Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D632A6A75ED
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 22:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCAVJy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 16:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCAVJv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 16:09:51 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D7951FA0
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 13:09:49 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id c11so11948506oiw.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Mar 2023 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=L2gHLgGpsJRHcEeke/8tuR+sT34km4XZ/OVsaYoJqbk=;
        b=QD34THeowjW4Ja9DLltfuJQuY+4XQq7WuHobusp05rcJJizL2n5uUkEItG4ktX3Ro5
         uOimsj3jsEJ/h1PuurGA+YtnF1kb6WnAGIGlKN5O9e9xhgm4hg7ChKuhkD79433uJazq
         FEq3ZRYsFRRbGnyckP3ZYLvke8lfwI8RlTV4bNQ13k0q3+3JdYVO5+Z9Y8xXSNZjLMW2
         nO1QLyreIx1+ROjQj32FbfGG4M1SuQQ7z6LFMII2XV9pBN8vjVXc3okzve0ZEecFNLGg
         tQQnb9kHK72qWEK/70p+pvWGNhikQsRAUhpXUJLk2O66qAUhke0a+kQHzsDVEgoAvkmR
         2ioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2gHLgGpsJRHcEeke/8tuR+sT34km4XZ/OVsaYoJqbk=;
        b=uvo7nEvvuS8QDE/sqq6DE4UaeU48UFHUUsJqUylHp7siDnRU037Fbdodvh1YnsFfuL
         6xuzWAYNB9d22yPafVH+CA8BSUjyocs/eIGECeOYqJ1WK6L6lr2o+1I5GP1axNEq70i5
         Y8XbUoh1DFNHZdwUq6th1E97onWJoHWeQRSBfTftCXoTUWEvVN3iQzUDcQv2FaCJCGpO
         0X4ZNQo2pPGME2gvgtGsGAzjy4SmfNyN4jhDb77wHVqr/8XUwdj/cEeo2oEtE/c8oJp8
         iGxeCrYcbkCTtXtwr3iDnPwh6BJAio+I7chGceOaXOGsMCLaUnjTxdxV0OSSqv9Mn/tF
         FVyg==
X-Gm-Message-State: AO0yUKVkIkRNi5epLZcznWZgRT53lSMmqqnqWqix7KnDThp/P/sJBkPe
        xGJiJJ/iTj8MAYBFGqm8NwPgfgG5cjQ=
X-Google-Smtp-Source: AK7set/OC4BbuZM1ExsYICFsyubZEs6TXWZOT/SuccOWQY5z8+k1wCazUECzXRzSYqL39/yqlihJSg==
X-Received: by 2002:aca:1016:0:b0:383:e383:f265 with SMTP id 22-20020aca1016000000b00383e383f265mr3730672oiq.19.1677704988198;
        Wed, 01 Mar 2023 13:09:48 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id a20-20020a544e14000000b00383eaea5e88sm6380599oiy.38.2023.03.01.13.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 13:09:47 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <75f9b50e-f140-ef7e-4a3e-c92b6f9bf867@lwfinger.net>
Date:   Wed, 1 Mar 2023 15:09:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Hangs with NetworkManager and rtw8723_de with kernel 6.1
Content-Language: en-US
To:     =?UTF-8?Q?Fran=c3=a7ois_Valenduc?= <francoisvalenduc@gmail.com>,
        linux-wireless@vger.kernel.org
References: <b8fa3770-7164-e6bf-4d8d-8ba8fd78057c@gmail.com>
 <8f436927-7587-028d-fc1e-4a3103e0e866@lwfinger.net>
 <7f59d087-9c17-d16f-fa50-e16aba563385@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <7f59d087-9c17-d16f-fa50-e16aba563385@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/1/23 13:15, François Valenduc wrote:
> Good evening,
> 
> For sure, I am using the kernel driver in gentoo or in systemrescue. Can you 
> explain how I could obtains the logs when the crash occurs ?

François,

The best way is to use netconsole, which requires another Linux computer 
(target) connected to your network, and a wired connection on the computer under 
test. The documentation is at 
https://www.kernel.org/doc/html/latest/networking/netconsole.html.

That writeup is not easy to follow, but you need to do the following:
1. Install netconsole or nc depending on your distro on your target computer.
2. Run the command 'nc -u -l -p 6665' or 'netconsole -u -l -p 6665' depending on 
your distro.
3. Learn the IP address of the target computer using 'ip address'.
4. Know the network name of your wired connection on the test computer.
5. Create an options file in /usr/lib/modprobe.d/50-netconsole.conf. This line 
should contain the following line:
options netconsole netconsole="@/<name from step4>,@<address from step 3>/"
My computer contains options netconsole netconsole="@/enp0s25,@192.168.1.51/"
6. Force module netconsole to be loaded at boot. How to do that is distro 
dependent. You will need to explore that on your own.

Reboot the test computer in the configuration that fails. If setup correctly, 
the console dump will appear on the target computer.

Good luck.

Larry


