Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDDD6F1EBE
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 21:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346583AbjD1T21 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 15:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346570AbjD1T20 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 15:28:26 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E1849D2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 12:28:25 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38dec65ab50so242842b6e.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682710104; x=1685302104;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a6vzlKNk4RUiM+MhugYFPY8/fTDfT9NyXIgg3OMojQc=;
        b=IRyJN7GGzbldBp0Ue/yz0Qgdv9F8o9Rt/Etyc43HfLBjytxAZlK3bvQix2i8LAOC5f
         6KBjPyaLAnsAoGy+09mE0UhBoEzvBgRGWzQ/vVgJ3/Yo/GF99Un+CWcylW1jk69Qzt21
         JmS4Y43weRgxgaq2EVbWRe3W5pfeBfpnEQ++z3jJV8lR8iPmHFmkqvEoC9zFucO8MZe2
         a53qcOWXB99vZWjZTfqQ1KMyHeX6voGywdTlPFQDZ/V7D5AoNna/6IoI7kh17EGFOWTP
         3DC1bsmFCB+u+7lF24vjGrp1CiS3wmU2Wyydn4pxP1EstaGFnTcVyH4pjwrzysJftzGs
         BRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682710104; x=1685302104;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6vzlKNk4RUiM+MhugYFPY8/fTDfT9NyXIgg3OMojQc=;
        b=bAVLE1kQBFeUl3eziNYYUaYqYuf1uan+1Y3Fju8RNlpas8X/rVsUF5ME1feLlZk2va
         cEwvY4dV5cuNTg22dnTfQNkq3EWQCymUms9aINYmHcijMj+8hFwxgs5H60qjvHpQFKUI
         GbGWXWZP2uwQOeHOYstZHZXBzTWCW8Py3flYpLrOQcWTyLvbm2GlzaOeCF/N5/iMFssb
         4yaabACOcPlHYuZ//ijlmFy23ghhgDOwuJ95EjGnOiscu23JnGqlYPuMBCKQgAdIRQLm
         qE/r1pHu2nAuY2ZTSUsHZT9tuwyhaiS0lqD8M9bHwwMaA7GRlEwpcbbCpPZFuS/r/8LS
         op7w==
X-Gm-Message-State: AC+VfDySzy6DdyaE/QuL0YbEZwaULTMpodv9Q1UcUq5fFjPvU0Y/1LpB
        NMajiTbFHqu2i89NB3Nwqu7xKWZ3iC4=
X-Google-Smtp-Source: ACHHUZ7Ioq75RjaiRtu8MUv+f4O2l3MI79lh7AHM06IX+Roo6nxvpkhmnugLCpZjg6f/nKagn8c+xw==
X-Received: by 2002:aca:100f:0:b0:38e:880a:25c7 with SMTP id 15-20020aca100f000000b0038e880a25c7mr2925084oiq.25.1682710104713;
        Fri, 28 Apr 2023 12:28:24 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id p205-20020acaf1d6000000b00386eff32f58sm9165384oih.13.2023.04.28.12.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 12:28:24 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <0529ba07-db97-fe95-4ab8-aba47b8b0bc4@lwfinger.net>
Date:   Fri, 28 Apr 2023 14:28:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: rtw88: 8822cu (LM842) --> LOWER_UP link messages
Content-Language: en-US
To:     Gabriel Tisan <gabriel.tisan@gmail.com>,
        linux-wireless@vger.kernel.org
References: <CAD9ZU8BcYM_zZqFzTBFDQOoF0Jd3vNj4OWODOy+UZbWXCUwA7A@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAD9ZU8BcYM_zZqFzTBFDQOoF0Jd3vNj4OWODOy+UZbWXCUwA7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/28/23 08:56, Gabriel Tisan wrote:
> Hi !
> 
> I use a LM842 wifi stick on a Linux kernel 5.15 with last patches for
> rtw88 from linux-next applied.
> Firmware version is 9.9.15
> 
> When I connect LM842 as a station to an AP, after the link is up first
> time, it comes from time to time more LOWER_UP message.
> The stick is plugged and the connection to AP is still valid.
> 
> # ip -oneline -family inet monitor link
> 
> 5: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noqueue state DOWN
> group default \    link/ether 34:c9:f0:99:b6:a1 brd ff:ff:ff:ff:ff:ff
> 
> 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
> state DOWN group default \    link/ether 34:c9:f0:99:b6:a1 brd
> ff:ff:ff:ff:ff:ff
> 
> 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
> state DOWN group default \    link/ether 34:c9:f0:99:b6:a1 brd
> ff:ff:ff:ff:ff:ff
> 
> 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> \    link/ether
> 
> 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> noqueue state DORMANT group default \    link/ether 34:c9:f0:99:b6:a1
> brd ff:ff:ff:ff:ff:ff
> 
> 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> 
> 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> 
> 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> 
> 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
> state UP group default \    link/ether 34:c9:f0:99:b6:a1 brd
> ff:ff:ff:ff:ff:ff
> 
> 
> 
> 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> 
> 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> 
> 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> 
> 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> 
> 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> 
> 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> 
> 
> 
> 
> 
> Any idea what I can do ?
> 
> Did someone also reproduce that problem ?

No, I do not see that problem. When I run your command, I get

finger@localhost:~/rtw88>ip -oneline -family inet monitor link
12: wlp0s20u6i2: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
12: wlp0s20u6i2: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
12: wlp0s20u6i2: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether

My connection is very stable; however, my device is an 8822BU, not an 8822CU.

When the connection is dropped, what is logged? You can see that with a 'sudo 
dmesg | less' command.

Larry


