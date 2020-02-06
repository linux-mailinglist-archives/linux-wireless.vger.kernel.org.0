Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E846A1540D8
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 10:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgBFJGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Feb 2020 04:06:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35925 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBFJGO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Feb 2020 04:06:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so2409307pgc.3
        for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2020 01:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4RynK7w8Kq0Gq9hAjA+cxirM1DbsL41DcrGIncObWvM=;
        b=aSIIbx6q6J6hPnmcGBrpJRS0EyyKA6DVS2XhbswrAV6GBAXYJsYyM/dpkiOI/zn/7i
         0J26pznOtIXScy0eZ/3E4UNNaBFkvwWcpBA2t5rUp1wsXupG7NWt8A5MqMmfG7cBADYF
         N0vj2uSGpAOFQPtpyFH3YzZcw4SIAP5a1aCgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4RynK7w8Kq0Gq9hAjA+cxirM1DbsL41DcrGIncObWvM=;
        b=LUznzQ90O0b56CcUIujgpz9xHs1HrOgKlKCX40azdN0SD3Zq+isbuTYn7m5ZGhnOjn
         ASzIImR4lhdGD3O9A6J50KnpMe7Go5uWsAipUJFnpmFU2DtGpb+qIo+KSE1ckWJOhrAW
         Mz0hQe8G6vw39lovhoP+Y915O/r77OF2a3paA04GJgfk0b57hRdctOCx01WQrPtch7bs
         0MSv70+fjMuTZlhu8LhbCQZhswfffzKMCXyAd/6xcintzD8CZYWtbXQBw4E0Uds7lzkU
         ohSk4wwZhU639UK30iQpfB9iFVVAKedjawF9c6Ogj/6vuA0lwfGK13vbgLIGeL/SfptN
         ChXg==
X-Gm-Message-State: APjAAAWRNbiXR+FNg3gpTgYtxY7S3C/nN1lkh+L3LDgTXogzUaL5eK5O
        WQt+JUcRM+/YtypTGZhlwRbFYg==
X-Google-Smtp-Source: APXvYqzaHQLXE9+0hu6EfgcBw+SXgWUoy8yHrJl8R3tAjNQkUnwqlkekCyLTb50h17SGcTw7GHS51g==
X-Received: by 2002:aa7:9629:: with SMTP id r9mr2721446pfg.51.1580979973935;
        Thu, 06 Feb 2020 01:06:13 -0800 (PST)
Received: from [10.176.68.75] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id b1sm2412225pfp.44.2020.02.06.01.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 01:06:13 -0800 (PST)
Subject: Re: [PATCH V2 1/3] nl80211: add support for setting fixed HE
 rate/gi/ltf
To:     John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Miles Hu <milehu@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20200204103514.18111-1-john@phrozen.org>
 <4bf4c267-bfc2-1a04-f2d6-541f086e72c0@broadcom.com>
 <1b74ca8c-3bed-6296-5b3d-1ece82b4a56e@phrozen.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5d96b4b5-dcbd-30da-754c-685619ea671e@broadcom.com>
Date:   Thu, 6 Feb 2020 10:06:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1b74ca8c-3bed-6296-5b3d-1ece82b4a56e@phrozen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 2/6/2020 10:04 AM, John Crispin wrote:
> On 06/02/2020 09:58, Arend Van Spriel wrote:
>> On 2/4/2020 11:35 AM, John Crispin wrote:
>>> From: Miles Hu <milehu@codeaurora.org>
>>>
>>> This patch adds the nl80211 structs, definitions, policies and parsing
>>> code required to pass fixed HE rate, gi and ltf settings.
>>>
>>> Signed-off-by: John Crispin <john@phrozen.org>
>>> Signed-off-by: Miles Hu <milehu@codeaurora.org>
>>> ---
>>> Changes in V2
>>> * add more policies
>>> * reoder enums
>>> * remove incorrect he_cap from ieee80211_supported_band
>>
>> Not seeing the change listed above or am I missing something?
>>
>> Regards,
>> Arend
> 
> Hi Arend,
> that is the delta to V1 as per Johannes's feedback. Not additional 
> code/features

Guess I was missing context ;-)

Thanks,
Arend
