Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED0E84938
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 12:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfHGKPI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 06:15:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51497 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfHGKPH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 06:15:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so81238045wma.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2019 03:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=66mw8zgko1g9v95XH5VdtRjvtXtL8Yk9Tl0zDOaXYPo=;
        b=NsGdbdBRkNwMiyTOR9/fgYM1OXj2xLmEQEQlpFBGIDLBElauI82i1FTHp4/qU9Exu4
         duqMMdq6k/Dz042deO8DRqRpTswFOuInjem7WeLUCv7vgROe2ZwmTJfwmJqHHjviGj+5
         WSc1HWrjzjRJncDty5wePpvmb2z4CG9mNbXlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=66mw8zgko1g9v95XH5VdtRjvtXtL8Yk9Tl0zDOaXYPo=;
        b=aaWHxa/+AqiOyk3ogCa4fA8/R+kp2IW2zEUF5S7A3DFtkCpguMXZ+RffqZOD5XMNxS
         HNulJDJLX40WYigr2Dv/oqipSfmK8grjhZN7+OmeId8iOcpsPmr6uAyOrd2Uyb2JYpN1
         vN0p/mehNJ375K/NX/6m9Q1mphIgSRqQaBWbDVh+7IMOhBf4rEb/mpuAJWwF1ptWHRJ5
         hud91LyqBAaSGNYSF9FWDwkCP6v4+XYeZ1XxXa550p+UPvCRLlX5tWf/E2Royz/zEwAL
         4sg8BLJ1WlMwkTLnJUAbDxLE5B7Kfbb4AesRLEWWpWl2lwWDpzZhjFzB0szEnC7qsF6b
         B+xA==
X-Gm-Message-State: APjAAAWYDD1ZMvYCCvfKlCMwWbyd4qFr558YA0R20vXG5xxAjQv32QSf
        dDqnvyPkPKqDlfc9laANhCLoMw==
X-Google-Smtp-Source: APXvYqxP8CoDyqWnPK/VCy/jm5vsOjhe/vuNbqPE+IrCqhjgY69TKmiukONN2KwxCQWfPNqAmZZoQw==
X-Received: by 2002:a1c:20c8:: with SMTP id g191mr4680177wmg.55.1565172905545;
        Wed, 07 Aug 2019 03:15:05 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id f2sm82628673wrq.48.2019.08.07.03.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 03:15:04 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] rtw88: RTL8822C: add WoW firmware v7.3
To:     Tony Chuang <yhchuang@realtek.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "briannorris@chromium.org" <briannorris@chromium.org>
References: <1565167700-22501-1-git-send-email-yhchuang@realtek.com>
 <1565167700-22501-2-git-send-email-yhchuang@realtek.com>
 <3307e4b7-c92d-e1d2-b896-26e45fb69a9b@broadcom.com>
 <F7CD281DE3E379468C6D07993EA72F84D188A068@RTITMBSVM04.realtek.com.tw>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <7bbbe3be-1f6f-8f38-45f3-54f25a5b2f38@broadcom.com>
Date:   Wed, 7 Aug 2019 12:15:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D188A068@RTITMBSVM04.realtek.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/7/2019 11:53 AM, Tony Chuang wrote:
>> From: Arend Van Spriel [mailto:arend.vanspriel@broadcom.com]
>>
>> On 8/7/2019 10:48 AM, yhchuang@realtek.com wrote:
>>> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>>
>>> Add WoW firmware to support entering Wake on WirelessLAN mode
>>>
>>> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>> ---
>>>
>>> v1 -> v2
>>>      * update WHENCE file for new added firmware
>>>
>>>    WHENCE                    |   1 +
>>>    rtw88/rtw8822c_wow_fw.bin | Bin 0 -> 138720 bytes
>>>    2 files changed, 1 insertion(+)
>>>    create mode 100755 rtw88/rtw8822c_wow_fw.bin
>>
>> Just wondering: Is this a good approach? What firmware should distros
>> pick? Is there a trade-off affecting other wifi functionality when using
>> WoW firmware?
>>
> 
> If distros want to use WOW, they should pick both.
> 
> For Realtek devices such as RTL8822CE, it needs to "change/re-download"
> the wow firmware to suspend with WOW functionalities. When resume,
> switch back to normal firmware to run "normally".
> 
> I think the reason is the firmware size restriction. For newer devices,
> maybe there is a larger space for firmware, and we don't need to swap
> the FW like this :)

Interesting approach and I would mention this in the commit message or 
add a README in rtw88 folder explaining it. Not sure whether distros 
look at commit messages.

Regards,
Arend
