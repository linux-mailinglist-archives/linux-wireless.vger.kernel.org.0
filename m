Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C306D173
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2019 17:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfGRP6G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jul 2019 11:58:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43332 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRP6G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jul 2019 11:58:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id j11so5329379otp.10
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2019 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F00cTmFGt6n8/m4oYjVaV99suoKg+VkUVS+004D9gSU=;
        b=tBody5fhw0F+rAkYnSGoCyqIUeDaF9VnFN3DK9nWV0nscDekQuu597JrtZiuBPiRGF
         dPC1KJQu8zMHYzx2NEyfT09aCG1CckrbESICvSsSwzNXrIR22xqlcTFWnPC5YE3KKnmh
         OkglDw7HkAoWdMkMQtHvjmwvacA2h+9Ra/3ol7bKB89AY1maLwbRmo4cMPRYKHPzQryC
         w1BuUoeiX2pAMW3ClgtzcQ138KOlNduDMw817I3pyiIuZilq5iqXnaPq/f3OiaBxygUi
         msRMPNjxygSx17ZStGGoRm5MVAr7PgmshRl/l1IEESpPCjQoobtXqAptlFlM1uBiYRtf
         iPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F00cTmFGt6n8/m4oYjVaV99suoKg+VkUVS+004D9gSU=;
        b=HAtsFd/8ZihfUatxIamLMDApwzVYtJWb0JHHrBCWhspcEcYABhuLSoYF0GIQuxE4cI
         gxQknNO8DksdAyb75ZNmNRUeiQdevE9SNDrx8jRO1AGsiS2JdRwVO7+KrnTMCJNNSi2k
         pgrfwmoJspXJL9m7kJHp76F3Kw0Lj9XCs/0GHd1fP/YWHnUkr3Nvew+/Qg5ZcytTyD0y
         gK8D+cvfgE3vOcOtgZGkG2d+FRxvIzoxzZhqNZlxIXrR3s904/JF/Cd32kx+5Y5mriEP
         KacJAO9ki+fPPgsGkND5oID09d/dMvO7miB2DzJM02F81b+EaUnNedGacnbJzjz0/sMt
         oc3Q==
X-Gm-Message-State: APjAAAXEdMvV0wZ5hgSGOrp3cXi8qSCzDmfVT7SeYyvXsva09TDw20ON
        VgiI7IW7OynStmXO7Rxi1tsSCmgc
X-Google-Smtp-Source: APXvYqyH8R4j2W93IWNEv+Rrl47Wruhammct8BdZR7DiKinyr6wlrRKHpsaz3vXsFr9YLdWN3Dq0Rw==
X-Received: by 2002:a9d:7b4d:: with SMTP id f13mr21947270oto.164.1563465484935;
        Thu, 18 Jul 2019 08:58:04 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c64sm10731062otb.79.2019.07.18.08.58.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 08:58:04 -0700 (PDT)
Subject: Re: RTL8188ETV chip, r8188eu module and power management
To:     Anton Sviridenko <anton@picapica.im>,
        linux-wireless@vger.kernel.org
References: <20190717060609.GA21298@picapica.im>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <f0680746-0a0a-b33e-b4ef-246b08949d99@lwfinger.net>
Date:   Thu, 18 Jul 2019 10:58:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717060609.GA21298@picapica.im>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/17/19 1:06 AM, Anton Sviridenko wrote:
> 
> Hello
> 
> we are using FN-8112MET PCB module having RTL8188ETV chip on it.
> Device is running customized Linux version based on Linux 4.19 release.
> Driver module "r8188eu" is not modified, taken from vanilla sources as
> is.
> Wi-Fi connection is used occasionally, and rest of the time it is
> preferable to have minimal power consumption.
> 
> Such situation is observed:
> 
> 1) Linux kernel is started, driver module is not loaded
> 2) module "r8188eu" is loaded manually with parameters "rtw_power_mgnt=2
> rtw_enusbss=1"
> 3) device starts consuming more current (+20mA)
> 3) after the module is unloaded, current consumption remains at the same
> level
> 
> We still have to double-check this, but looks like driver module does
> not leave the device in the same state on module unload.
> 
> Few questions:
> 1) Is "r8188eu" driver from the mainline kernel the best possible option
> available for this chip?
> 
> 2) Where can I look for some documentation about kernel module
> parameters related to power management and their meanings?
> Source code is not very descriptive, and I was not able to google
> anything better, looks like this chip specifications are not available in
> public.
> 
> 3) Is there some option to completely poweroff this chip using software
> and then bring it back when needed?

1. No. There is a newer driver for the RTL8188EU chips at 
http://github.com/lwfinger/rtl8188eu.git. The v5.2.2.4 branch has what I think 
is the best.

2. The source code is the only documentation available.

3. The page at 
https://unix.stackexchange.com/questions/165447/turning-off-power-to-usb-port-or-turn-off-power-to-entire-usb-subsystem 
has some info on disabling USB hubs that support per-port power switching.

Larry



