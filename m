Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67EF7C3BFF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbfJAQrs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 12:47:48 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40293 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388662AbfJAQrq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 12:47:46 -0400
Received: by mail-ot1-f45.google.com with SMTP id y39so12149160ota.7
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rtH4flkGLzSQDKOG2O9GV3LBBnYAtYncpACnXjB6wQ0=;
        b=e4DVS4BHsXZz9GzNjYaQEtC/KyrDY9t31hk+EzhM21sukusp0rcVu27MbsVTjsoHcG
         qwYOkSHQhbEy6+oMFLX26pZUATQgLYh9uUn3Z/vqqR9FiMtzUPoy6NpsXkLykx3WsELC
         7+3RuFiZhcjrGpInhKBVGV6/hFV5VelSYp2ZOBJKUOFn48GypSs9XpeqSOlrNp6bVA1D
         t3yH2Raj61ynrhhxZ1D9QMt0CVhXptGLne9pc5vQhD8GqwbSfBeaHWf4HSorlooGZ/zX
         vuGcTDkHCLo5+e/k8x6uAbSfGMxUnIvYHzvxv0fzVwVNs9t7tdTFePp8jalDAqp7nwci
         ED8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rtH4flkGLzSQDKOG2O9GV3LBBnYAtYncpACnXjB6wQ0=;
        b=W4cD77iWJtBPG4Yy4JLpy/ZRon6AgQbuDUTekiIM3+m831s9yl+VRxD7CcLBZR1eZf
         PPEmjKhWxEvMd3ZKkI3E+gkzpz+yoc9ReBHj4TGfmgZR8yH1AvE0jfpNYwZZr0yXPeAy
         Hh+sPxrWWlbiNuv0zH3VoShtD4iORBk+L8npHQZjMCMNBX1v9iLokkdVq/dEd5IbQr6x
         zCJcr6K3gLz9BCOsFKiSj8GfKExDtcnfD5aw2lFHsSMpqQoeRHKqCw9OJ/H/tDYK07cS
         uCTkDS1FQeLT2Vi0LHSlkRdv2Ludoo27qh/ilstDNRLqONtOiLBvF/DO/6mQRn1IS/CA
         L1wA==
X-Gm-Message-State: APjAAAUyFubA9OBHwF7sjh0lXVYEAvjnXPfCjOei7todz88hlHJvgLl0
        ctm1EPqinfaZmPJTWZJo20dp0CRn
X-Google-Smtp-Source: APXvYqyv7PiJHXYF0GoVPl250yHO51pTOh3BwmF6f8mNqDHEN6Aop7J622ILF+zgJB1r2vlzINYnvw==
X-Received: by 2002:a05:6830:618:: with SMTP id w24mr4276836oti.13.1569948466135;
        Tue, 01 Oct 2019 09:47:46 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id q6sm4462571oth.76.2019.10.01.09.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 09:47:45 -0700 (PDT)
Subject: Re: Support for RTL8188FU
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-wireless@vger.kernel.org
References: <20191001160305.qrl4nt2jmdsogaaz@linutronix.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <3af284c7-ee46-dd42-9549-de55feae2528@lwfinger.net>
Date:   Tue, 1 Oct 2019 11:47:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001160305.qrl4nt2jmdsogaaz@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/1/19 11:03 AM, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> I'm looking into support for RTL8188FU with the vendor driver next to
> me. There is a driver called rtl8188eu in staging. Is there a way to
> figure out the difference between E and F?
> Then there is rtl8xxxu outside of staging claiming to support
> RTL8188[CR]U. No idea what C & R is and how much difference there is
> towards F or E.
> 
> Any suggestions what would be the best way towards support for the F
> chip?

A quick Internet search shows me that the RTL8188FU is a low-cost chip used on 
Raspberry PI and other similar low-cost systems.

The USB group at Realtek is notorious for their lack of support for Linux 
drivers. The ones they release have lots of dead code used for Windows and 
FreeBSD drivers, and they have lots of code that applies to other chips. With 
other drivers that I have placed at GitHub, some of the commits that remove dead 
code will remove as many of 10K lines.

You should be able to find the code that differs between 8188EU and 8188FU to 
see what is different.

The 8188RU is a special variant of the 8188EU. I have no idea what an 8188CU is.

Your only starting point is the driver that is next to you!

Larry
