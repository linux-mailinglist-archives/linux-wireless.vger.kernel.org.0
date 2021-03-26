Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7242734AB4F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 16:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCZPSZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 11:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCZPSV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 11:18:21 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3D9C0613AA
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 08:18:21 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso5498603oti.11
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e8uBgMkfNqo9yhCPDMpz02/2sQVZiKk/oqix+XMFtdw=;
        b=B85ILbC1LAjhLTUmq8lvnJ5KoZbGaM8YxHYRQZ3od9mwTUvtPPJbFd+7twqy8KXKzH
         FfhMDoMv+mK0XdC0UEnJDRoGqoAKQcmup0U5rfx/V0Q1ggaMPt7ATawlbeaeYA/m82wR
         FFTaOMUHM4jDFJrhsCy6XsSd56+vpckn1M7hnH7coSnewfvEICsg2L7uReX6OocjMkrA
         rx0985Cpo+i7X/qVZ0aZHhPexXoLx8qmfpsVP1PNNgD9yF6RI4jDcdWg9QhLM4/g7qva
         p6hTRsEvaemOyfr9Qls7/ljKGZXFuxPv6bgfBc5UFVmrt5l1IKzlKICw9QnkwvG6LlRr
         UZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8uBgMkfNqo9yhCPDMpz02/2sQVZiKk/oqix+XMFtdw=;
        b=mv+sOpvilo9pLDIfbwN8dgjveVeLpfqB0JZtziumxc9CDCEN3Mi6FbuehT6LjwAZol
         fXt25TKbsNUmNrw+vgxlOfjbZ/In1nALJQe0Se4f/z5y6emOsHXZj3YggSPyndQANx3E
         D7n6skvOezeQFA7PXrVvbR9uIMA3SYV0POoU4Z3J2hCyX71NQS+yR+E8PDzGxu6Up2Xf
         Hsb1yBTaJGcjTK1+X3TZomNad9zotmMeDuH9Kv1R8uZhaPBjfeORzEdr6kIZJ7Eza6Bw
         RjmO8blzYn3UHLZ+BtdhJrBgflgyQPfJXQTvT91oJs4FdAkCA3GSvf09Elot4XTCzAoK
         2/rQ==
X-Gm-Message-State: AOAM532Su8RdgV4umhYm8+lgNr1vtFcOIW0kF+JmBmL28Vdv2k8nVcmx
        BhymElCaqVeJBci6QKVhBzgualKYOXU=
X-Google-Smtp-Source: ABdhPJxJloF2cTR1kqG31aFOGaarVxFv2UufebSe1WIdW5ZvzF4W6gbwxcvSaNsyNWXu3huXjYHyEw==
X-Received: by 2002:a05:6830:20da:: with SMTP id z26mr12373984otq.74.1616771900244;
        Fri, 26 Mar 2021 08:18:20 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h20sm1847916oor.8.2021.03.26.08.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 08:18:19 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: RTL8821CE 802.11ac PCIe Wireless Network Adapter - Not handled
 properly by the rtw_8821ce dirver on Kernel 5.11.6-1
To:     Michal TOMA <michaltoma@sicoop.com>, linux-wireless@vger.kernel.org
References: <2846955.Y2WTrdj9rP@linux-9g0r.site>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <b9ea29a4-675f-6fec-954e-2878e2e8285f@lwfinger.net>
Date:   Fri, 26 Mar 2021 10:18:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2846955.Y2WTrdj9rP@linux-9g0r.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/26/21 7:16 AM, Michal TOMA wrote:
> The RTL8821CE driver doesn't work on several recent kernels (probably since
> 5.9).
> 
> 
> journalctl -b | grep 8821
> mars 19 22:49:13 localhost kernel: rtw_8821ce 0000:07:00.0: Firmware version
> 24.8.0, H2C version 12
> mars 19 22:49:13 localhost NetworkManager[639]: <info>  [1616190553.7766]
> rfkill2: found Wi-Fi radio killswitch (at
> /sys/devices/pci0000:00/0000:00:1d.4/0000:07:00.0/ieee80211/phy0/rfkill2)
> (driver rtw_8821ce)
> mars 19 22:49:13 localhost kernel: rtw_8821ce 0000:07:00.0 wlp7s0: renamed
> from wlan0
> mars 19 22:49:14 localhost kernel: rtw_8821ce 0000:07:00.0: start vif
> 28:39:26:ab:b4:5d on port 0
> mars 19 22:49:14 localhost kernel: rtw_8821ce 0000:07:00.0: stop vif
> 28:39:26:ab:b4:5d on port 0
> mars 19 22:49:14 localhost kernel: rtw_8821ce 0000:07:00.0: start vif
> 7a:36:c4:26:1d:f1 on port 0
> mars 19 22:56:07 linux.local kernel: rtw_8821ce 0000:07:00.0: stop vif
> 7a:36:c4:26:1d:f1 on port 0
> mars 19 22:56:07 linux.local kernel: rtw_8821ce 0000:07:00.0: start vif
> c2:a0:c3:48:17:58 on port 0
> mars 19 23:03:00 linux.local kernel: rtw_8821ce 0000:07:00.0: stop vif
> c2:a0:c3:48:17:58 on port 0
> mars 19 23:03:00 linux.local kernel: rtw_8821ce 0000:07:00.0: start vif
> ae:92:06:47:50:83 on port 0
> mars 19 23:09:52 linux.local kernel: rtw_8821ce 0000:07:00.0: stop vif
> ae:92:06:47:50:83 on port 0
> ...
> And continues like this indefinitely
> 
> uname -a
> Linux linux.local 5.11.6-1-default #1 SMP Thu Mar 11 16:11:36 UTC 2021
> (7358b30) x86_64 x86_64 x86_64 GNU/Linux
> 
> rfkill list
> 0: ideapad_wlan: Wireless LAN
>          Soft blocked: no
>          Hard blocked: no
> 1: ideapad_bluetooth: Bluetooth
>          Soft blocked: no
>          Hard blocked: no
> 2: phy0: Wireless LAN
>          Soft blocked: no
>          Hard blocked: no
> 

I want to add a bit to this report as I have been helping Michal on an openSUSE 
bugzilla thread. His driver comes from my repo at 
https://GitHub.com/lwfinger/rtw88.git. That code corresponds to wireless-next 
with fixes for kernel API changes. The repo provides 8822ce code that works 
perfectly on my machine.

I do not have an 8821ce cdhip, thus I cannot verify this directly. What would be 
helpful is for the Realtek devs to suggest debug parameters that would yield 
information as to why the driver does not attempt to authenticate, but 
immediately stops the vif.

Thanks,

Larry

