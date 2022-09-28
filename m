Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605B75EE277
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiI1RBP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiI1RBG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 13:01:06 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9BC83BEB
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 10:01:03 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id g130so16020289oia.13
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=rn+ow99BafmPBQGhTIc0d8H/HlzCwL+vr+zqIlMiBHM=;
        b=qcDYI65NC64nMde1RfhuLIyIxGa3KVV5gZb5YbvoM4XcGUN7KfdPL5eXCWnY8BTNLh
         YseaQKlkNj/tZqslhx9WPENWWKoitCYxxpZvU+7q9YjdwVMxs9aK/zGHVCVdnW/keJIm
         RggnOiKXoL1g5P6hVvembz6WpZHUgn89WZsk5jrWmPqQBZVikvVw2NwZuQ0OOtUrLk9G
         VEifPTYZHKu1aGAKltlXPO9Y/+sqZJjkh3aStwLN74nM9hpVAyFJFXSzVmdLSHIGXcXj
         vuH02CssNxOjgunA+t//T60+tTZjVfINea/XcUgxWWuCtvYgF98zh8FINJ3DO8e4btXQ
         TeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=rn+ow99BafmPBQGhTIc0d8H/HlzCwL+vr+zqIlMiBHM=;
        b=Wyhvi3YdQvwTSi3svOXj4687ynBrKwBjeqqH1s05YbmAj4n0JR+yBkhHGET07s9EdH
         Twcu2R3JxmkbBn2HOuZz8bLq8va6qS9Ti8qp4B6PX4yIRm9tpJsSS7Ys9RRP7Ppf7DSq
         sJzVjwrKfOziVMxRyTVUnveJf9zOisKBEOk4QfQqOM+QCMCB2EkzFrURVs5XLotgTQNx
         L10cDQ5HCN80kILcV9Xoevh960L+3LCc1kBU20QubUIIvLGphQt/bn9Ah12H5yGs8Zx8
         aepy11+4m6EJmPdvZiOCuDicY4xpoIJoPCJazrWqW26sye66xTjdti6WNV86t/rHqh1o
         RDuw==
X-Gm-Message-State: ACrzQf3ajeE1wB76GM2NE6mnykiXHBfY05XAzdv/8S0kuOl8fiJQCNhB
        Vi71vRwM8FfYD1RfYuh37vmEPcq6Vwc=
X-Google-Smtp-Source: AMsMyM72Yuq70RXcglpN3F7UEsl2qdiZcOTJAFIQl81z7Hi+DhOLI+qviD8/cVjUafo0SbTxZ2rPVw==
X-Received: by 2002:a05:6808:1c2:b0:350:2b01:f324 with SMTP id x2-20020a05680801c200b003502b01f324mr4826276oic.56.1664384462678;
        Wed, 28 Sep 2022 10:01:02 -0700 (PDT)
Received: from [10.62.118.123] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id i19-20020a4adf13000000b004767df8f231sm2073682oou.39.2022.09.28.10.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:01:02 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <d47effbe-3582-7b26-f0d2-27109caa174e@lwfinger.net>
Date:   Wed, 28 Sep 2022 12:01:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: rtw_8723de Realtek driver issue in Debian 11.5 Bullseye Kernel
 version 5.10.0-18-amd64
Content-Language: en-US
To:     Mariano Vedovato <marianovedovato@hotmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <SN4PR22MB3271BACF8FD2F57BEDDACC4EAC549@SN4PR22MB3271.namprd22.prod.outlook.com>
 <SN4PR22MB32711526F087B9898CED953DAC549@SN4PR22MB3271.namprd22.prod.outlook.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <SN4PR22MB32711526F087B9898CED953DAC549@SN4PR22MB3271.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/28/22 08:46, Mariano Vedovato wrote:
> Hi,
> A few months ago I updated the system from Debian 10 to 11. Always in Debian I had to do the Wifi driver installation manually, the last one that did works I downloaded from https://github.com/lwfinger/rtw88.
> 
> But, a few days ago, I had to do a clean install. So I downloaded Debian 11.5 and again I did the manual installation of the driver.
> In this case, when I reboot the laptop the operating system loading is stuck in "Started Display Manager".
> But, if I login in rescue mode, and of course uninstall the driver, the I can logon normally to the system but without WiFi!
> 
> I was investigating a lot, but it seems there is a problem with that kernel version and my driver (there is not a new version of the driver for my wifi card rtl8723de) because if I do the installation again, but before rebooting I try what the README of driver says:
> 
> sudo modprobe -r rtw_8723de         #This unloads the module
> sudo modprobe -r rtw_core
> 
> Due to some pecularities in the modprobe utility, two steps are required.
> 
> sudo modprobe rtw_8723de            #This loads the module
> 
> Only a single modprobe call is required to load.
> 
> I can use Wifi (in fact I am writing right now this email with WiFi working smoothly!), but again in the next reboot the initializing is stuck. No errors I could read in logs.
> 
> So, I think that my workaround: "poweroff - poweron, system loading stuck - force poweroff - poweron in rescue mode - uninstall driver - reboot - logon on system - install driver again and use WiFi like a normal person"
> is not enough efficiently.
> 
> Kindly ask to you (it  indicates from instructions README of driver) if there is a solution for this issue?
> 
> BTW, I tried to install Ubuntu 22.04 with Kernel 5.16.xx and the WiFi works fine, but I'm a Debian user since Debian 5 and I don't think to leave it and I have no money to buy another Laptop for the moment!
> 
> If you need something from my side to do a deeper investigation, please ask me.

If you want the external driver rather than the one built into the kernel, you 
need to blacklist the kernel version. The names of the drivers were carefully 
chosen to allow this.

Search for "Linux blacklist" to see how to do this. By the way, this  sort of 
question should have been asked in a GitHub issue rather than by way of this 
mailing list.

Larry


