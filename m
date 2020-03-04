Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1371797A9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 19:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgCDSQ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 13:16:57 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:41467 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDSQ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 13:16:57 -0500
Received: by mail-ot1-f52.google.com with SMTP id v19so2974756ote.8
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2020 10:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9l24NwWideSR/oTp7GyG1gnhVYej621q+eOUDXiKQIY=;
        b=TpiqkORbDFarCxJHM/4QhXjmpoNVY490yoC1Z8Lwi6rjcyfqK7OKQ8Z1+gKEEA6Vb4
         Wz/NSHP+GAZmZEMrH9SghUjiKSCQkepnDEOPEznTz6F+QsxvjegSF0vz1CgxtFntrr+G
         NC+G99Y+3mCwxd6XdaTCipwqiLdWLkdVJuAshGXBDmFtiGRLVFiio0I/qnV8DOcIgjMG
         DvTG0LoWe3H9zvFfv/SurQkDgUTCYqyWtxdayosfPHkWqyfjZug2Yj/XWFh1WW06n84W
         t6qBNiZxU2ueU3jW7oExB2WZjPD19oHLxVGaMcCG6DFRPukatCvpnJmra7J94ByLsEAR
         AlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9l24NwWideSR/oTp7GyG1gnhVYej621q+eOUDXiKQIY=;
        b=jN4lqekTKipEQn4oHzDU/1bQfWS9zn8FH6iXdzFTx1XsaVesWL4LeNR8dItWSPkcTk
         2eB8xHZvy3pquP8fbWduSW7CP1AnVcjawQ10QOSxH4BlXbyEejoFxYXSZAqA8Y6qiByY
         CpzujTYD/ngJ64J6bkEPMG6QVpMwNaTla4ZpSDoFX/BBm7CteVylC2ybfnIiMP8C8m9V
         tMQp1HPhDVxh9ZKn3gUqr5hYPuxRS6pNdMCRtJI4OGEJygk/w7lFE2gCOYx7MXYPPI0X
         9NPwRI0cHYvf7DDaRXV41NURk3vAzhRsD+u0Ll8QZSqu4vbeYrjRHo3wH4uwKzNstu8u
         OXBg==
X-Gm-Message-State: ANhLgQ368r0fb4fjsR+il3joYgEcX8EP2DIlXW3HGa2lxl/KZIDXNGnz
        9aGwYGE2vzBtDoF/nF8csu5CCLos
X-Google-Smtp-Source: ADFU+vuZdp2q59O0tCR1BjpHmOl0s5//Z9A49vGkZmHflRnLDweKAQN/K2ysGyZshHfy62YLVKOMnw==
X-Received: by 2002:a05:6830:110:: with SMTP id i16mr3279327otp.189.1583345816236;
        Wed, 04 Mar 2020 10:16:56 -0800 (PST)
Received: from [192.168.1.120] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id j4sm1029657oie.14.2020.03.04.10.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:16:55 -0800 (PST)
Subject: Re: Support for RTL8188FU
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-wireless@vger.kernel.org
References: <20191001160305.qrl4nt2jmdsogaaz@linutronix.de>
 <3af284c7-ee46-dd42-9549-de55feae2528@lwfinger.net>
 <20191001174612.4kj3mt3h5epidyyk@linutronix.de>
 <b958b669-a683-d7cd-6bbf-bfe3e674f62d@lwfinger.net>
 <20200304102152.a25cczvat2mujxwa@linutronix.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <9c6717de-5ffc-47dc-6db7-7e070cbc41b9@lwfinger.net>
Date:   Wed, 4 Mar 2020 12:16:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304102152.a25cczvat2mujxwa@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/4/20 4:21 AM, Sebastian Andrzej Siewior wrote:
> On 2019-10-01 13:52:30 [-0500], Larry Finger wrote:
>> The first thing I would do is clone the v5.2.2.4 branch of
>> lwfinger/rtl8188eu at GitHub, add the USB ID for your device, and see if
>> that works. I expect it will. If so, that would get you quite a ways toward
>> the changes needed to get that driver into staging.
> 
> Adding the id didn't help. I added "hal/Hal8188FPwrSeq.o" next to
> "hal/Hal8188EPwrSeq.o". Some parts were different.
> After loading the firmware the driver said that the firmware wasn't
> active. So I tweaked the firmware loading part a little. The signature
> of the firmware in my driver is 0x88F0 instead of 0x88E0 and the
> "normal-nic" firmware has 20306 bytes. By loading the "other" firmware
> the firmware and driver says that it is "alive".
> I disabled the "IOL" bits (like rtw_IOL_applied() which returns false).
> It took long and didn't seem to succeed. My driver lacks most of the
> code, rtw_IOL_applied() isn't referenced anyway and the ifdef isn't set.
> 
> I would continue to add more pieces in order to get it working unless
> you have a different advice.

I have no further advice. There are quite likely a number of routines that will 
differ as the 8188FU chip is quite likely a lot different from the 8188EU, even 
though both are 802.11n devices.

Larry

