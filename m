Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC23C406C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 20:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfJASwe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 14:52:34 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44431 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJASwe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 14:52:34 -0400
Received: by mail-oi1-f193.google.com with SMTP id w6so15375263oie.11
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9WrnDQpH4+ip9dnq0xOQp/XGiF9kPZUoIf51QLDlIfY=;
        b=ATMwdhsXNEO2gsQB0wK9HgyOfA0XRpwJ7k8I7nxCPwwX/F+mJk1PwhA8DWhIyFAouz
         0zsDFdwCIe+MoPNp4piemnJHU2JArhRz6Dpq7TXm8LZ28vmk/3AkjK5RtiIXAiv6Cd1g
         R85uDMLEQH25xpknnTRI5U7aY5I4UyoBu93KQyr1UY9LQY79dgxI7q+OfHFEDSDHrwE0
         eyAAMmtj8VrQ0Cft4r+8lZZ0MnY0Xk2R2fT97fgJwoergD2TsaW/iu8sWkToNDcAZYgz
         ZcQxje0qOHH/jhkON1p2jFLywRwFP7To6w7dw/1NusU7hmT8pQ8U3aB2PGhHCZ9vTWA/
         hzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9WrnDQpH4+ip9dnq0xOQp/XGiF9kPZUoIf51QLDlIfY=;
        b=A4kmpVraIuiMtCDPF29myUwU1yT408tWT66FEPqvh3IrbdEDvjw4OtwBEy2uUL96kg
         atl8HPBl7PRS0/SVlBy4gFbFZKWz0ID4BxMv0S8CH2jsT5QEW/HHevE/GdAl1S1lIK/K
         DjVnWmOMO2nz2sbAU6UevJW7VepYnK+ZxcTaYbWh1KTj31gU19NwiunVW0IXB7QQo8x6
         RIK0z4LnOS9H6Dyz1JnPFZNKmH5aQUjNXs0pJGDmsyv1ym0P5ZW0FhstEN0/ZseTvXc6
         hVaPCx8L/bPf/Ypq31ZddLlweqbFHCKoxdoE3IKZkwZ0EDYC91VOr8HBr+rSIhoAJJpz
         ewQQ==
X-Gm-Message-State: APjAAAVMIbp9AAmfr8mbqcK893bnJmHxpT4ZwUIQeR30iogu6FPeqCAw
        BYLRzF6KCm+o9mEhqTlx4Ut5+iM5
X-Google-Smtp-Source: APXvYqz/l9u65xy9pil4ikq4CX2Es4tME11WMn/ehh+RejBjxBLtpRm3FSY2m0YRO1zrNETauVZiNg==
X-Received: by 2002:aca:f444:: with SMTP id s65mr4993450oih.71.1569955953030;
        Tue, 01 Oct 2019 11:52:33 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id e2sm4806963otk.6.2019.10.01.11.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 11:52:32 -0700 (PDT)
Subject: Re: Support for RTL8188FU
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-wireless@vger.kernel.org
References: <20191001160305.qrl4nt2jmdsogaaz@linutronix.de>
 <3af284c7-ee46-dd42-9549-de55feae2528@lwfinger.net>
 <20191001174612.4kj3mt3h5epidyyk@linutronix.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <b958b669-a683-d7cd-6bbf-bfe3e674f62d@lwfinger.net>
Date:   Tue, 1 Oct 2019 13:52:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001174612.4kj3mt3h5epidyyk@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/1/19 12:46 PM, Sebastian Andrzej Siewior wrote:
> On 2019-10-01 11:47:44 [-0500], Larry Finger wrote:
>> A quick Internet search shows me that the RTL8188FU is a low-cost chip used
>> on Raspberry PI and other similar low-cost systems.
>>
>> The USB group at Realtek is notorious for their lack of support for Linux
>> drivers. The ones they release have lots of dead code used for Windows and
>> FreeBSD drivers, and they have lots of code that applies to other chips.
>> With other drivers that I have placed at GitHub, some of the commits that
>> remove dead code will remove as many of 10K lines.
> 
> yeah, seen that.
> 
>> You should be able to find the code that differs between 8188EU and 8188FU
>> to see what is different.
> 
> So you would recommend to try to merge it to the staging driver.

If that is what you read, that is not what I meant.

The staging driver is really old and does not support nl80211 and friends. If 
you are willing to undertake a 6 to 12-month rewrite of the driver you have, and 
it supports RTL8188EU, then a replacement of the staging driver would be what 
you should do. If you do not want to make that kind of time commitment, then a 
GitHub repo would be your best bet; however, GitHub already has 5 such repos for 
the rtl8188fu. As far as I can tell, none of them are yours.

The first thing I would do is clone the v5.2.2.4 branch of lwfinger/rtl8188eu at 
GitHub, add the USB ID for your device, and see if that works. I expect it will. 
If so, that would get you quite a ways toward the changes needed to get that 
driver into staging.

Larry
