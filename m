Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F012EF7C4
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jan 2021 19:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbhAHS5R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jan 2021 13:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbhAHS5R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jan 2021 13:57:17 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF2CC061381
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jan 2021 10:56:36 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id d8so10642657otq.6
        for <linux-wireless@vger.kernel.org>; Fri, 08 Jan 2021 10:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wipb4FPX3bTdTVKpwn/KYHAX82u7BTnn/fZ7hqXDLqI=;
        b=THH9uboyQMMI9mzdEMgfNLNIcniNV8FWWQxM1kIeZpCw++id8QgdxCczJ7dRxzvsWz
         /Ag/8zTwCaI+4e9BodranCIvis2yv2/F7ptt+6YFMBU7GFbDQ5ShYnxIkgUz0BpAY7sr
         45LitgFkqXP/8zazOn7uvbSNMxqMVTu5UNXT9uoEMwc3jdCYbrYAhhm7KIwK4ic5OkEK
         nev7PMVBB5WLgNtPcuGO2Dsy+j1n4wK8X6FHgoCBPmVGS5piVFKZkIZjFEh30KvDne0J
         ExLYGuCJe2nOi6PjDybic8JlCtCeBtxj633hZ/osHgvqQW2FAq+5+08poJ5UCnM/S0Y3
         h0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wipb4FPX3bTdTVKpwn/KYHAX82u7BTnn/fZ7hqXDLqI=;
        b=G4F6hdg11vakg5XJYTroFHfyjRjjPTzsKJHxOuDM9rfs6RxSl4m9CuVb9ToY9XGrQf
         77G092kf8ht4LtMa+eFynVY9ehvO8F8Qgdh6ylP9i0bvSFOiuBzt9HRdMLvYF5EIte3/
         +xnuQQzyz7Ls7E+4T6376KZzlrEJpjD21sqtTZ7a2bdKBl1xZE4t2+JHLIBTWCLtrVVD
         H97F4kCAP0j1TQ8SqD2b+OCqQulznL/LYJqHIkajZn1YT29PXXaRSSpFsx2RTKfcDm1u
         zWQrRtYRzVRjwsqeZAXjSM3YR0qPDjOn+6M9khL6oG5gqKPMGdGzfjsxkIxeFowhVam7
         4Igw==
X-Gm-Message-State: AOAM530Z8fB9fxPvrCOV0EM7ZHRYizWAWY0+1RN04mxrNReIbUCzNvr7
        rQvnelggKAMB0F3HjkXFj88ILz+gJUY=
X-Google-Smtp-Source: ABdhPJxnLvHPHO6ts+6+Y3UPJ2qPJs+ZQBWJzu+/7PnmCgqweQZCcNDbKa6Nnlz3Te7j+jBZfHVluw==
X-Received: by 2002:a9d:4d8b:: with SMTP id u11mr3554522otk.13.1610132196073;
        Fri, 08 Jan 2021 10:56:36 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id m3sm1969035ots.72.2021.01.08.10.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 10:56:35 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: ntl8821ce driver is not working on my thinkpad E580
To:     =?UTF-8?B?5rip57Kk5Y2O?= <huadiw@gmail.com>,
        linux-wireless@vger.kernel.org
References: <CAOMh3odt=hRexbeUT=xmhZcgZk4czbxSFDv5s=tFS+VUVaMBDQ@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <7b32a59f-6453-af40-cfc5-b4bd7953066c@lwfinger.net>
Date:   Fri, 8 Jan 2021 12:56:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAOMh3odt=hRexbeUT=xmhZcgZk4czbxSFDv5s=tFS+VUVaMBDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/7/21 11:39 PM, 温粤华 wrote:

You have multiple drivers installed:

> 05:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8821CE
> 802.11ac PCIe Wireless Network Adapter
> Subsystem: Lenovo RTL8821CE 802.11ac PCIe Wireless Network Adapter
> Flags: bus master, fast devsel, latency 0, IRQ 151, IOMMU group 15
> I/O ports at b000 [size=256]
> Memory at f2100000 (64-bit, non-prefetchable) [size=64K]
> Capabilities: <access denied>
> Kernel driver in use: rtw_8821ce
> Kernel modules: rtw_8821ce, 8821ce

That 8821ce, wherever it comes from, MUST be blacklist3ed.

Some addition suggestions regarding your original E-mail. When you include the 
entire dmesg output, all of that information goes to thousands of subscribers. 
What a waste of bandwidth. If you think it is important, upload it to some 
public pastebin site and include the link. That way, only the small number of 
subscribers have to actually download it.

Larry
