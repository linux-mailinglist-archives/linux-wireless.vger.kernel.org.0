Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0958D1F1067
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2020 01:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgFGXWc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Jun 2020 19:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgFGXWc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Jun 2020 19:22:32 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6A6C061A0E
        for <linux-wireless@vger.kernel.org>; Sun,  7 Jun 2020 16:22:31 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a137so13693293oii.3
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2020 16:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rKb5lx9yybdPkCK9fIZtGUvCVMd0apjYRKjaSx9Ljy4=;
        b=mLMHNqKT2gPEDfxYpYmZFdlCvYpPSWhvPx5ZDtYxympDaZW0V+GDtnLXZAMJVXD6Da
         mZBdrER71eRbUgZnkW1t6KZlIQ1pxMukK+ASdp9t5EOwhRicp0S4jDS/6yCLw2RJdO9W
         WVxAbWEFsZ9Ia1NByxo7SYNRXYW8wvKVWcagaFN10MiR9AL3+NoroA1Z1XMr98Pc0kgl
         ZF+lDVBcrE2bbyU6wF1AFRykKd9jniqg4zWHdjCdv5E9AwV3wPmKKuZvMsasPX3CSwH6
         ZOeDNrtaBQi+zxLSHWJ2ebOBTAGZR3YiL0VCLOUEmQmyEzPvdEhiMpzlihdV9YTvIlap
         5hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rKb5lx9yybdPkCK9fIZtGUvCVMd0apjYRKjaSx9Ljy4=;
        b=GiBfrtGzCFuoavN0cym0Vdy9NwCjzO5vF6Y10CbkASpz/5E2ktbj71PY6xVMT75Ky2
         Agzavp+H/XQ7VYvsSYH0ODmG5jyAfds7sP9a0e6c8ako9IjnV9uMK06i5HQ4zsFynLAF
         ifg/SYF3ipl8pdzcqxz6L9k7mHI8RVHsMaCSEQ/XpELq6ppRcc42W/LkYbuQm0OymEco
         GMpyfpYYJlXWnNenWzKiMOE3gbgkirT/ajgYbWXnyuFpJKYOQKsL0BuTJ2k5QUCrUCOF
         f2GKqFwZNsJOXOYVOY4OGpGsFc8NOB9CQE/QRB7x4E+k791q3Ll9Vk1AOLKWjwTdP3UG
         TzDA==
X-Gm-Message-State: AOAM533t/O+K6OM7LCJFybgG4/vdsaDbNfYF4LAr3YKM62bWdOxjZ81Q
        H7O/9wiiI/Z0kuts85GRYV6o4DGi
X-Google-Smtp-Source: ABdhPJzz3x9Ndc/q39AoMlbDOnt2svu6U0OyAwMHbSO8KdgOcxkwuoY+QCsU/zzFtb3KFgkfI3NWuA==
X-Received: by 2002:aca:4889:: with SMTP id v131mr9016938oia.83.1591572150918;
        Sun, 07 Jun 2020 16:22:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id a9sm1161373otr.15.2020.06.07.16.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 16:22:30 -0700 (PDT)
Subject: Re: Many errors on dmesg and weak signal with driver rtw_8822be on
 Kubuntu 20.04
To:     Lorenz Bonat <lorenzbonat2@gmail.com>,
        linux-wireless@vger.kernel.org
References: <CABcAdhgcbNWMRh5t7_dH_d2-nrTV0xwjR-Zu3e8cfF29SnM4kg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <11df4abb-0bb5-e59f-2687-d5608b7bcb19@lwfinger.net>
Date:   Sun, 7 Jun 2020 18:22:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CABcAdhgcbNWMRh5t7_dH_d2-nrTV0xwjR-Zu3e8cfF29SnM4kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/7/20 3:39 PM, Lorenz Bonat wrote:
> To whom it may concern,
> I am using the last available driver on the lwfinger github
> repository(https://github.com/lwfinger/rtlwifi_new/) for the RTL8822be
> adapter. I am using kernel 5.7.0 and my laptop is an HP Envy x360
> ag000xx series. I persistently have struggled with the signal
> stability of this chip, and it continues to spit out errors into the
> dmesg log. The signal strength is lower than in Windows 10, and when I
> try to speedtest my internet connection I see a lot of variance
> between runs.
> 
> The internet is unusable when surfing the web, and it is very annoying.
> 
> I have opened an issue on the repository of lwfinger, i will link it
> for you because there are a lot of explanations there already.
> https://github.com/lwfinger/rtlwifi_new/issues/607
> 
> I am attaching a file with all the dmesg entry outputted by the
> rtw_8822be module(dmesg | grep rtw). I have noticed that I receive a
> lot of "timed out to flush queue 1" errors and after a while the
> driver crashes and I receive a "purge skb(s) not reported by firmware"
> warning.
> 
> If you need more information please let me know, and I will provide
> them. I am willing to test any experimental driver if you want to send
> me some material to test.

Lorenz,

I do not see any attached material. Did you forget?

For the rest of readers: The GitHub repo containing the rtw88 drivers is 
essentially what is found at wireless-drivers-next with 2 exceptions: 1. 
Conditional compilation needed to account for kernel API changes is added, and 
2. I gnerally apply any patches sent by the Realtek authors as soon as they are 
posted in this ML. When there are fixes due to reviews, I update the sources.

Larry
