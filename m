Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69252CFFD1
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 00:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLEXsg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Dec 2020 18:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLEXsg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Dec 2020 18:48:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86FAC0613D4
        for <linux-wireless@vger.kernel.org>; Sat,  5 Dec 2020 15:47:55 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j13so5296201pjz.3
        for <linux-wireless@vger.kernel.org>; Sat, 05 Dec 2020 15:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uwC74So0VIQhkorqNpUlWrJVjiiB1IsHz63e4kDdeJM=;
        b=ES7M2zkWiADyPQbLN5Ce4gTvOAMPLurzzw5iEPX2rvypfDUx+QXwQkyD6bTzKSKWFb
         rwEwqHotAaXk3Ng9RUn8QKi+1OxiRfrrH2O7xHuZEPelVc+s0hLq2aoAX3pBJ2VWDDZS
         +/6R2j6bRqU1NtclhUxQ426VoQq9Edq3MVQLYxNc2m3eU/4CB5NFDmoJi+Tu2Z7ZUirL
         Ud5MYrdtdlS8W5QoJ/mEq+VA+zCwkdbZf3da+p9htqsn1RKQ2GF8k1lOYG0Cv/xgC2sl
         arMqCBmJ/AG8jrxWFYckAo7n6JA6Suhq+TFOOFDaE97jIDGs647+CqZT5X5AJb/JXrR/
         Fesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uwC74So0VIQhkorqNpUlWrJVjiiB1IsHz63e4kDdeJM=;
        b=MPVVOAH3ZgjbezFmduSiqqo3Us/XnIvPywRy9k115X7yTw11nP2N1tedU8fmOTpZLb
         55ufLZ/S4DpD13KhTJ94lHdxXnt3LL8wSWyzfX6xnPK1Ndaqpw9G0P2/OhcCCUmu1Vsr
         rBF2Z1TIeFPo+sCTF86BjeDueXAdRXLjC97vcA57nENrG2xmtGprKj+quvH0Y8iPwJYU
         5pc/QYidgpqoEmoZm2XRRl5CP1YSLzLwfTObFCYrUsPSWmiaukCtIBDBDUarutO282Od
         AVP7QenM9Q3EitZHfEvpHUa5MS+FBm5S6yw+m6J7S8sukbZjvGhcVgIo3CPeijTUHTCK
         0rIg==
X-Gm-Message-State: AOAM531/eAb4qhOCKLwbkVetV1ebC+F5FKLu1/2QdX8S08OAfNFcALsI
        F+Drzja0T0tcQTuOltz3gyijj7a2W0c=
X-Google-Smtp-Source: ABdhPJxubugN/zOu7TLkVSto+OYS1SBP68sAxBiZADhyYtAnYhexVGiSg1g/KC/exNPfXORSi5gJkw==
X-Received: by 2002:a17:90b:2317:: with SMTP id mt23mr10357805pjb.2.1607212075223;
        Sat, 05 Dec 2020 15:47:55 -0800 (PST)
Received: from mua.localhost (99-7-172-215.lightspeed.snmtca.sbcglobal.net. [99.7.172.215])
        by smtp.gmail.com with ESMTPSA id w2sm6172801pjb.22.2020.12.05.15.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 15:47:54 -0800 (PST)
Subject: Re: wifi dongle connected to USB/pci card, seen in hardware, but no
 wl* device created; udev, driver, &/or config?
From:   PGNet Dev <pgnet.dev@gmail.com>
To:     samuel@sieb.net, linux-wireless@vger.kernel.org
References: <95c76758-485b-aad4-62d2-95ce24f1108c@gmail.com>
 <79883ce0-9313-10b4-214a-27be35888bee@sieb.net>
Message-ID: <27d25649-2f5a-5818-6b2c-ef134cb3394b@gmail.com>
Date:   Sat, 5 Dec 2020 15:47:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <79883ce0-9313-10b4-214a-27be35888bee@sieb.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/5/20 1:51 PM, Samuel Sieb wrote:

> On 12/5/20 1:25 PM, PGNet Dev wrote:

>>      lsusb | grep 008

>>          Bus 008 Device 003: ID 0bda:b812 Realtek Semiconductor Corp. RTL88x2bu [AC1200 Techkey]

> 

> There are a couple of available options:

> https://github.com/cilynx/rtl88x2bu

> https://github.com/RinCat/RTL88x2BU-Linux-Driver

> 

>> existing default udev rules aren't creating a wlan device; I'd expected that they would ...

> 

> The device can only be created if there's a driver to create it.



::facepalm::

well, it certainly help if I'd not just googled for ac1200 but ALSO paid attention to the fact I'd installed  88x2*a*u!



> https://github.com/aircrack-ng/rtl8812au



with CORRECT driver



> https://github.com/RinCat/RTL88x2BU-Linux-Driver





dkms-installed, on boot



dmesg | grep wl

    [   22.083177] RTW: rtw_ndev_init(wlan0) if1 mac_addr=44:01:bb:33:c4:1c

    [   22.318059] rtl88x2bu 8-4:1.0 wlp2s0u4: renamed from wlan0



iw dev

phy#0

         Interface wlp2s0u4

                 ifindex 3

                 wdev 0x1

                 addr 44:01:bb:33:c4:1c

                 type managed

                 txpower 42949572.96 dBm



hwinfo --wlan | egrep "Device:|Modules:|File:"

   Device: usb 0xb812 "802.11ac NIC"

   Driver Modules: "88x2bu"

   Device File: wlp2s0u4



pebkac. again.



thx o/
