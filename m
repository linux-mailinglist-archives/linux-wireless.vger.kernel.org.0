Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6428A1F4
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Oct 2020 00:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbgJJWwK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Oct 2020 18:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731219AbgJJTEj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Oct 2020 15:04:39 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD626C05BD3B
        for <linux-wireless@vger.kernel.org>; Sat, 10 Oct 2020 09:38:53 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 16so13705114oix.9
        for <linux-wireless@vger.kernel.org>; Sat, 10 Oct 2020 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MQQ/jRESABxwI/WtB8zpE5AOWGyAZftN8tLdO8kRPqA=;
        b=TieKerPpcZwNJcGubqKKWPGJ0Nrj2yIai9+xtk0phpykgJAwcOdpmmvS7YzJAbbA7w
         dDO305Sv4GWJM9wiG/rjc/wQJSgg/sOnM4G/Gm3HgglEz53toZCAfNOXBU8i2yutK8b/
         7Ygi0pF5zWGfJUgCw9kKKPpNDHR49mX/pIn9xl9tITgbO4LgMLCSI8eW1aR20vVpVPAG
         PnYVyhnolT3IMlcUSfgI7utcO5hbmTTp9RHTUDh2O7+g9CnmWu7Wewi2ozuUy9/sP2Qm
         rHgCmILNhzzcETbL9oz8F9Yw5POKmMcV2IUuw9uASfJLMK4IISIn/Vpb8XrJnUdBy6Ng
         o9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MQQ/jRESABxwI/WtB8zpE5AOWGyAZftN8tLdO8kRPqA=;
        b=a3W0spDcjLKa7ztrVXTYdBVNg/zS9YTmsJXPdb++b4hgxvHxt2NHBWDCztkrF+F2Qo
         pSmA4eUcU5TOZGp6DEBH7ukBCziZ4ckK8Tlr/tXLlF+cBk5RHlsOCa2AxCmRquISaE/F
         GckxpqKqCOhnDAUWamyuulA9aIEbGebc+u9OsNCBvxlBzemsltQXsfdNzDFPGJZNPyRc
         fRauwuET6t+sLFB41x6mTw6JMtIxY5+3zsfx4D7rmOClMO5lhGUqB7ZRgl97P5ajdfgY
         pAdUt0oKpQow0hIQFEuFmt23xFgiWcAEZy3R+g9Kn90NXy4/eajKXe1jbAoGnj7B3lc8
         yY2g==
X-Gm-Message-State: AOAM532wQJ74kfvni1D+x0DLalTLzhFDWUnmSKLCtssIFkcGdoN/0Jti
        Yi+Bcq/+EzAvaqqI5VmNezABOZDmkCY=
X-Google-Smtp-Source: ABdhPJx9I7ps/ubdKIU3mk9FDBuspb3UX8sJzWa/S0RGBEAzKXzVMiJMh9H0EbPvtpn2bvLXEWO6vQ==
X-Received: by 2002:aca:3655:: with SMTP id d82mr6091403oia.75.1602347932835;
        Sat, 10 Oct 2020 09:38:52 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id r188sm979499oia.13.2020.10.10.09.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 09:38:52 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: 8812ae driver
To:     Mal C <mak.abonne@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CALfyEABV3CYnd5h9epd0b00gs-p78y2dTVETcHHFnix1nYxfmg@mail.gmail.com>
 <8991aaee-2ff5-0e85-b7c0-347050a4ff59@lwfinger.net>
 <CALfyEABiZ7J6suNLQR6AW0eU3SS_oot08-Yz9xiZ5G7HtTya6A@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <2837dc8e-00b1-7a3e-21ac-833f6c8a08d9@lwfinger.net>
Date:   Sat, 10 Oct 2020 11:38:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CALfyEABiZ7J6suNLQR6AW0eU3SS_oot08-Yz9xiZ5G7HtTya6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/9/20 5:14 PM, Mal C wrote:
> Hi Larry,
> 
> Thank you for getting back to me. Here are the outputs. I am on 5.8 kernel. I've 
> tried blacklisting the "rtl8821ae" preinstalled maodule in order to allow the 
> 8812au to take over but it seems to do nothing. Also, I have tried unbinding 
> from usr/src but the echo command keeps returning a "no such device" error. I 
> really appreciate any time and advice you can provide.
> 
> 
> -Mal
> 
> 
> 
> On Fri, Oct 9, 2020 at 5:01 PM Larry Finger <Larry.Finger@lwfinger.net 
> <mailto:Larry.Finger@lwfinger.net>> wrote:
> 
>     On 10/9/20 2:05 PM, Mal C wrote:
>      > Hello Larry,
>      >
>      > I hope this email finds you well.
>      >
>      > I found your email on github and wanted to reach out to first thank you for
>      > making the drivers and also to see if you could provide some advice.
>      >
>      > I'm using asus pce-ac51 which has the 8812ae chipset and I just cannot
>     seem to
>      > get the driver and all working properly. Initially, I was running linux
>     mint on
>      > a machine that I just built a few months ago. For some reason, the module
>     would
>      > only work if I ran the install script and rebooted. Then, after that
>     session,
>      > the module would be forgotten and I would have to go through the same
>     process
>      > again. Then it stopped working altogether, even with the install and reboot.
>      >
>      > Now, I am running the newest manjaro release and have just tried to
>     install your
>      > module again. I followed all of the steps exactly and had no issues, but
>     there
>      > is no recognition at all of the wifi card.
>      >
>      > I am wondering if you have encountered this problem before and if you
>     might have
>      > any advice. My only idea is that there might be a dependency issue with some
>      > other wifi module that came with the manjaro installation but it's just a
>     guess.
> 
>     Normally, I do not answer private E-mail, and I probably will not answer any
>     more of yours. If you want an answer, CC linux-wireless@vger.kernel.org
>     <mailto:linux-wireless@vger.kernel.org>!
> 
>     First of all, I did not write the driver. I only make it available to persons
>     running older kernels. The only other instance of the driver not working was
>     from a guy that actually had an Atheros chip, not a Realtek one.
> 
>     Once the driver is installed, it should continue to work for that kernel. A
>     change in the kernel would force it to be reloaded. I am assuming that your
>     kernel is older than 5.9. If that is not true, then you need to use the driver
>     in the kernel.
> 
>     Please post the output of 'lspci -nn' and check the output of 'dmesg | less'
>     for
>     any mention of "rtw".
> 

Where are the answers to my questions? If you want my help, then you need to 
participate!!!!

The rtl8812ae chip is driven by the rtl8821ae driver. An 8812au is a USB device, 
whereas the ones that end in an "e" are PCIe devices. Do you really think that 
they will interfere?

Larry

