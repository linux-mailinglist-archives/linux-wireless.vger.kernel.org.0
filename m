Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69670211B73
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 07:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgGBFSA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jul 2020 01:18:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60297 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBFR7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jul 2020 01:17:59 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jqrbh-0003dv-Mw
        for linux-wireless@vger.kernel.org; Thu, 02 Jul 2020 05:17:57 +0000
Received: by mail-pj1-f70.google.com with SMTP id j17so17076055pjy.8
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2020 22:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HK+2Za4zK5fVmc7KxGsxdyfecqHnw9DWqJC/EC7WLtA=;
        b=hmf9NRMnqhKXEzlKGRd+rpdR5i960/K5ZJJOb62IdN7LLHqrs5WVEhsA5zBxMq9Zah
         y0JiL26xfjsS1xzYHDwnULrN9yKaxGbxiRN+aqOKkPQVOCCnXyOtneiy7J8OFB3vUBNl
         d7PEu698cm/lgFRcgSWuiglNIXNj96jHF0jr3TS8ts7Xd6o8PWQOHkVTuSj05WTKXvZW
         fCMPMvutB339ipD6qes+5QpMeZZvSgvxCVfya7qZb7SJy9d4MzoynepOF6yperFq8Rwe
         fTMwJ8XU3KsseTDvQgzC3/Vi9tUTWHKU3I9xEfFB4veuxlum8tcCkmwIzACvJO3N+xpL
         FEhw==
X-Gm-Message-State: AOAM531N4RAnMHIjnscKl7GG8kei9tUF4OXMz/sF4lG0yB2Raez/T9tI
        Jyv8tWlj831sqAF6szEIz4QKL/8XzNfv8T+l3ah6UtgLNpvzhOe0lK3lv4nDo7XU9HQB9Ikcj+p
        H62HpeFBKkqIHGwRp25v1dKFXP1IqVmrEDse5b7J7o7qa
X-Received: by 2002:a17:902:7008:: with SMTP id y8mr26002176plk.84.1593667076046;
        Wed, 01 Jul 2020 22:17:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMvtw9mYQcsyZ322dQ+4/hpi/efbzBY+k6hvhxJqhDyzEkp5DM9H9lUBi7EgpfavcLQ+JD/Q==
X-Received: by 2002:a17:902:7008:: with SMTP id y8mr26002154plk.84.1593667075686;
        Wed, 01 Jul 2020 22:17:55 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id u20sm7438630pfk.91.2020.07.01.22.17.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 22:17:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 5/5] rtw88: 8821c: Add 8821CE to Kconfig and Makefile
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <fb3241a02b6744e6aa59886b5ef53245@realtek.com>
Date:   Thu, 2 Jul 2020 13:17:52 +0800
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <1DDA5620-4979-4772-B2B2-AA7BD86F5168@canonical.com>
References: <20200603094218.19942-1-yhchuang@realtek.com>
 <20200603094218.19942-6-yhchuang@realtek.com>
 <bec7010d-e979-da0a-0ce1-88fc872c1eec@lwfinger.net>
 <fb3241a02b6744e6aa59886b5ef53245@realtek.com>
To:     Tony Chuang <yhchuang@realtek.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> On Jun 16, 2020, at 19:07, Tony Chuang <yhchuang@realtek.com> wrote:
> 
>> On 6/3/20 4:42 AM, yhchuang@realtek.com wrote:
>>> From: Tzu-En Huang <tehuang@realtek.com>
>>> 
>>> Since 8821C code is ready, we can build it.
>>> 
>>> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
>>> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> 
>> I added this code to the rtw88 GitHub repository that I maintain. I do not have
>> an 8821CE card and have no way to test it; however, there is at least one user.
>> 
>> That user has built the driver and gets the firmware loaded, but runs into the
>> following:
>> 
>> [   12.378158] rtw_8821ce 0000:02:00.0: Firmware version 24.5.0, H2C
>> version 12
>> [   12.404834] rtw_8821ce 0000:02:00.0: rfe 2 isn't supported
>> [   12.404937] rtw_8821ce 0000:02:00.0: failed to setup chip efuse info
>> [   12.404939] rtw_8821ce 0000:02:00.0: failed to setup chip information
>> 
> 
> I need to check the devices with RFE type 2. I am not sure if they are supported.
> But you can try to add RFE 2 in rtw8821c.c, that can probably work.

I added RFE2 to the rfe_defs table:

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index c41c61ee2fb6..73f3b9f1ae31 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1219,6 +1219,7 @@ static const struct rtw_intf_phy_para_table phy_para_table_8821c = {
 
 static const struct rtw_rfe_def rtw8821c_rfe_defs[] = {
        [0] = RTW_DEF_RFE(8821c, 0, 0),
+       [2] = RTW_DEF_RFE(8821c, 0, 0),
 };
 
 static struct rtw_hw_reg rtw8821c_dig[] = {

However, the driver triggers a NULL pointer dereference, because there are many rfe ops are missing for 8821c.

Kai-Heng

> 
> Yen-Hsuan

