Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274D8393451
	for <lists+linux-wireless@lfdr.de>; Thu, 27 May 2021 18:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhE0QyK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 May 2021 12:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhE0QyJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 May 2021 12:54:09 -0400
Received: from mail-ed1-x564.google.com (mail-ed1-x564.google.com [IPv6:2a00:1450:4864:20::564])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E1BC061760
        for <linux-wireless@vger.kernel.org>; Thu, 27 May 2021 09:52:35 -0700 (PDT)
Received: by mail-ed1-x564.google.com with SMTP id r11so1588822edt.13
        for <linux-wireless@vger.kernel.org>; Thu, 27 May 2021 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mWC0KOOb2mz4yNzyrkqwQS6Vzaaz4jcMPp0At66McsM=;
        b=SEmjWPgdibLJX/K6hE5J3GzLbpt+qL8epkfMXiYPJc7u7mcS46/lPMJTpYU1X+HGk5
         rmw59rW3UykXpTpUfr3bBPMoDRsZE7CCIEARjAnNJjEmgesFfeMWRcQ2x5L0xKuMmHWC
         X0lGk4EvOowIMK2SublKkFf1FNkmqcPKh2aqqFeQyA3h/6JonijkNDpKaXB1UVcHhsrZ
         bCVUfgkPh4pa799sTlBZRholLpy6kJtIp+MKXq4v2mlsdCTgKQi3dLXs6DY4BdO2BkXm
         54otYxRfQEMFNBRmsYTKqHulUTYI3FD2FWSN/mmKbLDWjZd//ZEZeSkopuNz110EXPyG
         fovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mWC0KOOb2mz4yNzyrkqwQS6Vzaaz4jcMPp0At66McsM=;
        b=RjCim/rv9oRymUi48MvzPl6RQc3ZGqUWXF+aHLCebzDhQJ6CMxg/mpolNp3O2he/Me
         zkLYHgSIpRCwwtrkR5hXr77+Xub4gYqCSKL+c5zrfObPhhg8OqV/nIfo+gKgcK5MqaYA
         HIe9b+XTS/CtNCZw2VVaNM8YeaGRIUXs1cLgAM4SsDDxoPkX/+DMqD6xhim+tJr+eXNH
         S0nEmygvsn2JYFWv/V/k9SSD+BOjwccx2Iqe+84TBxSyyMRxhDHqCs2rPeF0npcH3gh2
         yWS6u+MW20tShnEnaPG0xmzC99dKVsp/uTmEp0Tz9zcU4Nnf6fpdVJGYwwFAAgvSKGwC
         chOQ==
X-Gm-Message-State: AOAM531uS711UPGOhn7UZ7azgWK2Io1LDymvWQvlMjrZDZeBF6IA/elt
        zCo6wbi8nx5nixjAmGHTEVGwttM6y2+jkeKVCgxUEtQ79eTRM6JF6T2sWWa7vfY5G9FatuK2yoB
        Tp44ga8c7Ru2kzh7ZeDK+DboF+ZSb1wkvHIG1r2+8Ul15q1YWb6FiKE3H6efQ3ij/6cagJ2z+EQ
        yqR9wQpGy3YCh/YbbnvU/ubfoQ3Kw1Ow==
X-Google-Smtp-Source: ABdhPJyRIDcn/nCOOhoQLXK46urvwnpEOOHEMTjbOX1XNK4pPO1S62BevGgpHEcSUkbVlCvvwNtcTWaVzcxn
X-Received: by 2002:a05:6402:50d1:: with SMTP id h17mr5446344edb.199.1622134353381;
        Thu, 27 May 2021 09:52:33 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id w11sm210974ede.8.2021.05.27.09.52.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 27 May 2021 09:52:33 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.13.122] (port=32794)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1lmJFI-00089q-UK; Thu, 27 May 2021 18:52:33 +0200
Subject: Re: [PATCH] rsi: Fix TX EAPOL packet handling against iwlwifi AP
To:     Marek Vasut <marex@denx.de>, netdev@vger.kernel.org
Cc:     Angus Ainslie <angus@akkea.ca>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Kepplinger <martink@posteo.de>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Siva Rebbagondla <siva8118@gmail.com>,
        linux-wireless@vger.kernel.org
References: <20201015111616.429220-1-marex@denx.de>
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
Message-ID: <ba9013a8-38e4-f1ee-05a7-c3cf668bf449@flowbird.group>
Date:   Thu, 27 May 2021 18:52:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201015111616.429220-1-marex@denx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Marek,

I've just run into the same problem (on -5.4) and found your (now 
merged) patch


On 15/10/2020 13:16, Marek Vasut wrote:
> In case RSI9116 SDIO WiFi operates in STA mode against Intel 9260 in AP mode,
> the association fails. The former is using wpa_supplicant during association,
> the later is set up using hostapd:
>
> iwl$ cat hostapd.conf
> interface=wlp1s0
> ssid=test
> country_code=DE
> hw_mode=g
> channel=1
> wpa=2
> wpa_passphrase=test
> wpa_key_mgmt=WPA-PSK
> iwl$ hostapd -d hostapd.conf
>
> rsi$ wpa_supplicant -i wlan0 -c <(wpa_passphrase test test)
>
> The problem is that the TX EAPOL data descriptor RSI_DESC_REQUIRE_CFM_TO_HOST
> flag and extended descriptor EAPOL4_CONFIRM frame type are not set in case the
> AP is iwlwifi, because in that case the TX EAPOL packet is 2 bytes shorter.
>
> The downstream vendor driver has this change in place already [1], however
> there is no explanation for it, neither is there any commit history from which
> such explanation could be obtained.
>

I get this using 2 RSI9116 s, for both AP and STA using hostapd.
Comparing packet captures in the working and non working (without your 
patch) case shows that
the working case has a 802.11 QOS header whereas the non working case 
does not, hence the 2 byte difference.
The size of the EAPOL data is the same, it's the previous header that 
causes the problem...

This whole use the message size to determine the messages to ACK seems 
very fragile...

Regards,


Martin




