Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9AD4EB12D
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Mar 2022 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbiC2QCB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 12:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbiC2QCA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 12:02:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2FD4E39E
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 09:00:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a30so16573106ljq.13
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YBCXQvdqkUI+N6wX/GhhbJMb7vkKVG7Akhg7ppXMy/E=;
        b=eIBAiNbVkzK6fvdDnW17tD6M5+vhQn1byetq3BRfmeBV+cEjnCNKUHAEWOX/4Xvgo3
         oiyrwq17nz01Qt3AjSR3MGd5/NjwpV+zyK8/+U6AzKYxy7GyDowSBVn4e10NbcOMIg1F
         MddiI5DPKWwyoETitbcTdjsWytvo91cDGrkrTip+7CP5GpQ8JjnJwBBSPhMlqNYrHK35
         rfxHexx68Yqy6l0V0ZrRzsZD/hCDO43ln2VPEefAXeeKiy1JDTgKahRcJiXppKxiNCtp
         mYMfc2NPr3Dyl7oHMeBsjqRbIy59qxREhW+iBR5W+TOQ8/5c9FB+vyWvqlLDQwmXFZXZ
         Yrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YBCXQvdqkUI+N6wX/GhhbJMb7vkKVG7Akhg7ppXMy/E=;
        b=o8r1CAfs4+hw+moUDn7qe9wethlvauQ0U9S76WR4mcbf7NPWmCKgbIbDE8S/qPORnY
         ybqUflA0YYDG7Zyw0x5iYqwJ9DG1uq0LezyfBZM6DzTLlZ8fmbFJTVNRVMQZYT7mchr4
         xiimp9FYGnUwFBiZ2d1RXU8q7/L57NlDmybVTlMPYTZCdO4uIBLjZ/8a5yQaL46j2NQs
         xz6PKc1QKXzI70nnVAPQw7xKeQsicTVg8YE9iHJ3o8j+4TpEZVdjnZybByC7+0uUKaTp
         tH3J13udvD0/QT8zQbSE9HCxqkMuXc8mmX6AAlBN8sOJ7xuC1Yvhc55SNEdmhUxiwNhD
         7lBA==
X-Gm-Message-State: AOAM53015dVfD4rt4OZ3zqt6uYgyI68TdWp+LQvDjGbCLDd1S1O8d7pL
        kb9E/Gqc8ggy/UyXkRpEvt8=
X-Google-Smtp-Source: ABdhPJzBT5v5dwQGGsY/H85KFOY9KneTZW5sK4ZlFEyqqt894YSC0V5eGj5iAQorXQLDi3xIjSBdZA==
X-Received: by 2002:a05:651c:1543:b0:249:a2bd:4a74 with SMTP id y3-20020a05651c154300b00249a2bd4a74mr3158875ljp.375.1648569613717;
        Tue, 29 Mar 2022 09:00:13 -0700 (PDT)
Received: from [192.168.1.244] (81-233-89-221-no75.tbcn.telia.com. [81.233.89.221])
        by smtp.gmail.com with ESMTPSA id p9-20020a056512312900b0044a5312dcbcsm2028709lfd.89.2022.03.29.09.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 09:00:07 -0700 (PDT)
Message-ID: <1ca2ff88-4751-acce-6202-abc7d22e4494@gmail.com>
Date:   Tue, 29 Mar 2022 18:00:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] ath10k: add support for MSDU IDs for USB devices
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        davem@davemloft.net, kuba@kernel.org
References: <20220327171340.7893-1-erik.stromdahl@gmail.com>
 <875yny1w8t.fsf@kernel.org>
From:   Erik Stromdahl <erik.stromdahl@gmail.com>
In-Reply-To: <875yny1w8t.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 3/28/22 07:28, Kalle Valo wrote:
> Erik Stromdahl <erik.stromdahl@gmail.com> writes:
> 
>> commit 93bbdec6683e1c8ba2cc4e6 ("ath10k: htt: support MSDU ids with
>> SDIO") introduced MSDU ID allocation in the htt TX path for high latency
>> devices. This feature needs to be enabled for USB as well in order to
>> have a functional TX path.
>>
>> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
> 
> On what hardware and firmware version did you test these patches? I'll
> then add the Tested-on tag:
> 
> https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#tested-on_tag
> 

Hardware: Linksys WUSB6100M
Fw version: QCA9377 hw1.0 USB 1.0.0.299

Above fw version is printed by the driver at startup:

ath10k_log_dbg: usb 1-3 firmware 1.0.0.299 booted

The firmware file can be obtained from here:
https://www.linksys.com/se/support-article?articleNum=198580
