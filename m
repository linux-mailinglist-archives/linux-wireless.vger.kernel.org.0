Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B486A4A8CEB
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 21:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353933AbiBCUGM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 15:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbiBCUGM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 15:06:12 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C6DC061714
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 12:06:11 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so2493711oov.3
        for <linux-wireless@vger.kernel.org>; Thu, 03 Feb 2022 12:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mvbCLq95Z2AYKynX7vehuzxgREFElZC2SXeKnJOkLXs=;
        b=EROAtccY8TZ7KLcJZuse4xGNOAXtyyJCYViYSPt+OwAwx/ilzwAps5/nS/7HW9aT9I
         Zg0TF2SAPhwoqlPobWGapZ1eSdIl6AdvKa7OQ02l+WMntcP/2xOALPCbsFinVzyB+Jd0
         k9vlrXIkvaynSdmPvWQmCSSUMz0YZ7nRGgkbDaisbnQSOOgHnn7j0AXKnMnEuXMeCD/a
         thupZQyvlTII0RDhSmYfgxDk0a4km6lYj6tSwQPL21D1nH9JBmIxPQnzFM3FNdc9H23y
         mChtCyg3vE+5zEHhJUU+DANLn710/2671dycwLnBzfsyT56JtjBLZTUaa6eqCYFTE9rJ
         h43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mvbCLq95Z2AYKynX7vehuzxgREFElZC2SXeKnJOkLXs=;
        b=5j0vVtqWP6M3T3N7xJ9sG0s9mbw/NQy1zQC+gvlVGsPWG3v4uT9gg2NbYPcf0gY49/
         Di2M5+R3HHbUKoYSDryg3WHFjlMtOjKUDLP9GpRYFBQeQeIIWSoAU+6KJ6mDXcVyjq8P
         1tuQiP9k+NsQ1GFk4pui7xiO/Jt1VP929QaWl3dRZnmLkhtGqXKMmWZdZpavmgldDItD
         f6Q7OXzdliSBzi6bf6wazgn5wlzIfDLaeCUGio0y+dcV1lC9SCvsVoSiBEH6lGdtEQ+N
         sMMqn/WRqiyoMlBErNKLD3qaZVfDvPtYaDp51NbeXCKqdwD93eRVetY66RpReeRM60qF
         9CmQ==
X-Gm-Message-State: AOAM530lHIev4AQAqG9qzWwHi5JV94z9ROf6zkAg1BYJqfsykcnnhPdN
        CpXuvmDuJib+yFizo++9V1Lq5a3AXzg=
X-Google-Smtp-Source: ABdhPJzNFYdlT6JPtWZCqwzSBotUxKPgIzO7+Ee+V0K5MCD45ciIAVxGG/sz1c+UaUBbGqTE69OIbQ==
X-Received: by 2002:a05:6870:b210:: with SMTP id a16mr520186oam.184.1643918771250;
        Thu, 03 Feb 2022 12:06:11 -0800 (PST)
Received: from [192.168.1.103] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id bb16sm6664616oob.42.2022.02.03.12.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 12:06:10 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <ef7361eb-17ce-5ecf-a46a-a9f0c5aab35b@lwfinger.net>
Date:   Thu, 3 Feb 2022 14:06:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Funny log entries for rtw88_8821ce
Content-Language: en-US
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <c356d5ae-a7b3-3065-1121-64c446e70333@lwfinger.net>
 <32f2ece8acdb67f74757cb705e5467847d6bcae0.camel@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <32f2ece8acdb67f74757cb705e5467847d6bcae0.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/1/22 00:26, Pkshih wrote:
> Hi,
> 
> On Mon, 2022-01-31 at 16:53 -0600, Larry Finger wrote:
>> Ping-Ke and list,
>>
>> Within the last couple of days, I was testing rtw88 with an rtl8821ce card. I
>> noticed that whenever the device is not connected to an AP, the log is flooded
>> with messages like the following:
>> [130462.603539] rtw_8821ce 0000:02:00.0: stop vif ee:a4:95:4e:53:8b on port 0
>> [130463.116843] rtw_8821ce 0000:02:00.0: start vif aa:fc:19:66:5e:e2 on port 0
>> [130874.613430] rtw_8821ce 0000:02:00.0: stop vif aa:fc:19:66:5e:e2 on port 0
>> [130875.122641] rtw_8821ce 0000:02:00.0: start vif d2:e6:23:ba:98:76 on port 0
>> [131286.677828] rtw_8821ce 0000:02:00.0: stop vif d2:e6:23:ba:98:76 on port 0
>> [131287.192108] rtw_8821ce 0000:02:00.0: start vif 82:c4:33:96:2e:c6 on port 0\
> 
> I turn off UI network-manager, and it can show the same messages if I use
> 'ifconfig' to up and down the interfaces. I think add_interface()/remove_interface()
> are called by ieee80211_do_open()/ieee80211_do_stop() in my test cases.
> 
> Please check if your network-manager does the things. If so, check syslog to
> know why it does.

Utility journalctl show the following for a couple of cycles from start- to 
stop-vif:

Feb 03 12:02:10 localhost.localdomain NetworkManager[608]: <info> 
[1643911330.5997] device (wls1): supplicant interface state: disconnected -> 
interface_disabled
Feb 03 12:02:10 localhost.localdomain kernel: rtw_8821ce 0000:02:00.0: start vif 
9a:cd:df:5f:24:13 on port 0
Feb 03 12:02:10 localhost.localdomain NetworkManager[608]: <info> 
[1643911330.6179] device (wls1): supplicant interface state: interface_disabled 
-> disconnected
Feb 03 12:09:02 localhost.localdomain kernel: rtw_8821ce 0000:02:00.0: stop vif 
9a:cd:df:5f:24:13 on port 0
Feb 03 12:09:02 localhost.localdomain NetworkManager[608]: <info> 
[1643911742.0704] device (wls1): set-hw-addr: set MAC address to 
1A:73:93:A8:7E:9C (scanning)
Feb 03 12:09:02 localhost.localdomain kernel: rtw_8821ce 0000:02:00.0: start vif 
1a:73:93:a8:7e:9c on port 0
Feb 03 12:09:02 localhost.localdomain NetworkManager[608]: <info> 
[1643911742.5891] device (wls1): supplicant interface state: disconnected -> 
interface_disabled
Feb 03 12:09:02 localhost.localdomain NetworkManager[608]: <info> 
[1643911742.5946] device (wls1): supplicant interface state: interface_disabled 
-> disconnected
Feb 03 12:15:54 localhost.localdomain NetworkManager[608]: <info> 
[1643912154.0710] device (wls1): set-hw-addr: set MAC address to 
42:CB:4C:C7:CB:00 (scanning)
Feb 03 12:15:54 localhost.localdomain kernel: rtw_8821ce 0000:02:00.0: stop vif 
1a:73:93:a8:7e:9c on port 0

 From these log entries, I see no reason why there should be a stop-vif 412 
seconds after the interface is set from disabled to disconnected. This cycling 
does not cause any problems. Perhaps the statements that do the logging should 
be removed.

Larry
