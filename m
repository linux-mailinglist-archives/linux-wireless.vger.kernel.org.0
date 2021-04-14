Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D5A35FA2E
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 20:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351654AbhDNSCO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 14:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351651AbhDNSCN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 14:02:13 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F70C061574
        for <linux-wireless@vger.kernel.org>; Wed, 14 Apr 2021 11:01:52 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so20138453otb.7
        for <linux-wireless@vger.kernel.org>; Wed, 14 Apr 2021 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yn/PbffScubEYwUJk+Nb2pelGj/oy4tLnjEEtcAklfg=;
        b=fbbfkg8gaGFUs0z/a3QGhhjsdNwuUbtOZEOKMh4tSvc0ZTyFNPTEq0ABdYRUybXbPr
         4GNQ0n2fEfD8B0OpD6lBEi9OLL3Ymult40Dll88lXLZ3tN/ESoRikYiIZvuk59A0Rtjl
         LqnwS6fg/iPBIHEJD2MPalDAhIZzhNi81g1DAfeoXIlGpXH2MU1Z6feNSOS13D/19wpq
         E4Yc4/M7AVYwFVhe7K/gA9KkuEBh7fCtbe/6o3GTL77RAPNsiqfm1dQYp7SIC8tVd6Im
         r+wP7QjYqbGXRROWGt57rn2qQADHEeveGcQYcyGIxpVg7RsY3NVdztwg8nLkTYWEseJE
         YsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yn/PbffScubEYwUJk+Nb2pelGj/oy4tLnjEEtcAklfg=;
        b=batawTfB3D9BzfcdZtb0NO9o1fFJFhYA5OytHSRB1qyM9qGZKDgQ4uB39kTKa3SHPL
         367+HRXgVdrsOh+1qr1SSCBTEN+/G6FXLQcJyv43HmrlTx4v7SPlIQTgah5zO7SfkFhX
         jEyvTgyKsaajX8HbjPizzuH3dpnemqjA+r4a4xWXvXupaYcugiAsbZ1etxhZdJmSsRJm
         4v9wQs5h9e59cjtW0PH/4hWzUe+vlzXA17ulJzpudRfEuLdxQsFjm8xu/9tbsTJmgdwA
         FVcbbOw6P6BIZKSW+RyFARPUXTFBnsphQ3bccY6NqTKKKR52HQqNVLy2WIdAXSHzk4QL
         gCzg==
X-Gm-Message-State: AOAM5306H8UDKZgy5kR6zlH+RoQc+Uy0YupOWM5JC8go8Fvycad32/mv
        oaYhLcka8sjjUOJ4iHu6ZQzEQlxAzgE=
X-Google-Smtp-Source: ABdhPJxYd0vF+Fo9d2uwi4QxJtcaVC5RUGDPDRPOoQDZcU1+cUjhgFFX9KWBM63fSRLOBLFijmIxRw==
X-Received: by 2002:a9d:590e:: with SMTP id t14mr33017877oth.1.1618423311168;
        Wed, 14 Apr 2021 11:01:51 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id a11sm70905otf.18.2021.04.14.11.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 11:01:50 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [Bug report] - RTL8821CE 802.11ac PCIe Wireless Network Adapter -
 Not handled properly by the rtw_8821ce dirver on Kernel 5.11.11
To:     Michal TOMA <michaltoma@sicoop.com>, linux-wireless@vger.kernel.org
References: <2562248.KvEgbkE9EU@linux-9g0r.site>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <c0afc587-b8f8-8bae-5589-92ebac536c9e@lwfinger.net>
Date:   Wed, 14 Apr 2021 13:01:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <2562248.KvEgbkE9EU@linux-9g0r.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/14/21 4:12 AM, Michal TOMA wrote:
> The RTL8821CE driver doesn't work on several recent kernels (probably since
> 5.9).
> 
> 
> journalctl -b | grep rtw
> avril 10 14:18:41 localhost kernel: rtw_8821ce 0000:07:00.0: Firmware version 24.8.0, H2C version 12
> avril 10 14:18:41 localhost NetworkManager[682]: <info>  [1618057121.6199] rfkill2: found Wi-Fi radio killswitch (at /sys/devices/pci0000:00/0000:00:1d.4/0000:07:00.0/ieee80211/phy0/rfkill2) (driver rtw_8821ce)
> avril 10 14:18:41 localhost kernel: rtw_8821ce 0000:07:00.0 wlp7s0: renamed from wlan0
> avril 10 14:18:42 localhost kernel: rtw_8821ce 0000:07:00.0: start vif 28:39:26:ab:b4:5d on port 0
> avril 10 14:18:42 localhost kernel: rtw_8821ce 0000:07:00.0: stop vif 28:39:26:ab:b4:5d on port 0
> avril 10 14:18:42 localhost kernel: rtw_8821ce 0000:07:00.0: start vif 5a:f0:11:63:85:65 on port 0
> avril 10 14:25:35 Host-001 kernel: rtw_8821ce 0000:07:00.0: stop vif 5a:f0:11:63:85:65 on port 0
> avril 10 14:25:35 Host-001 kernel: rtw_8821ce 0000:07:00.0: start vif 32:45:38:02:34:09 on port 0
> avril 10 14:32:28 Host-001 kernel: rtw_8821ce 0000:07:00.0: stop vif 32:45:38:02:34:09 on port 0
> avril 10 14:32:28 Host-001 kernel: rtw_8821ce 0000:07:00.0: start vif c2:5c:03:32:bc:19 on port 0
> avril 10 14:39:21 Host-001 kernel: rtw_8821ce 0000:07:00.0: stop vif c2:5c:03:32:bc:19 on port 0
> avril 10 14:39:21 Host-001 kernel: rtw_8821ce 0000:07:00.0: start vif de:9c:ac:b2:58:ae on port 0
> avril 10 14:46:14 Host-001 kernel: rtw_8821ce 0000:07:00.0: stop vif de:9c:ac:b2:58:ae on port 0
> avril 10 14:46:14 Host-001 kernel: rtw_8821ce 0000:07:00.0: start vif 46:5c:c2:91:f8:7f on port 0
> ...
> And continues like this indefinitely
> 
> uname -a
> Linux Host-001 5.11.11-1-default #1 SMP Tue Mar 30 17:57:52 UTC 2021 (dbc4a02) x86_64 x86_64 x86_64 GNU/Linux
> 
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

Please copy file dmesg.txt from 'dmesg > dmesg.txt' to some pastebin that I can 
access. The sending of only lines with rtw in them may miss some valid information.

Larry
