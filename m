Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7819F53F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 13:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgDFL4j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 07:56:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58246 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDFL4i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 07:56:38 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jLQMl-0003b5-1Y
        for linux-wireless@vger.kernel.org; Mon, 06 Apr 2020 11:56:35 +0000
Received: by mail-pl1-f198.google.com with SMTP id e18so10863826pld.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2020 04:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9eWSY1IxGsEYPFqUPg7yJmTLZJ4z0NHpLMRifvIT13Y=;
        b=jZRAOnkG6U2fKJeJc2sxERqpxo3tbTmnMYAM+F1dw2TgxZWPQr4afHORmPZC7m4FyZ
         H3ztIPYPWI6VC+eajtJ4IXlJPuMZSgNHAwmuyno1MA9wujmwlTcBYeC195CyNE5Wouqu
         h2XcnKnTJ+MeTwOC6vg0Np593JwN/lo0PigZU/04HSQCvPyVyV3duwyzodW6vi/IVImZ
         uQWtN1XsT4JkuEdQETOoCclmDriDId5EaHmLcVMVT0ehBRIBoxI3IzgqPkafmIUmyKF8
         IqJR23+8I7Iku0XXmi8CblGDOfxPUfcISrHkbmJy1Lb4kkwyNwgfTOV5Trcs9tFX7YOp
         afhw==
X-Gm-Message-State: AGi0PuYwhxU9uKDVEsGrfZemuBHESYX+v3aFrvSKqmDmVIXepLJaeP14
        Tdm1Mdvdp0EclEAXcTWCJ/x2s7p8b6V9xrCOIia13u4HCkYylfJbKrJ35w0kAUJUao2vLOFBhSR
        hFi6mPia+5JGQYHZ+njTv3shas0AHfwzOSLznVbBNxgcT
X-Received: by 2002:a17:90a:17cc:: with SMTP id q70mr25885714pja.26.1586174193659;
        Mon, 06 Apr 2020 04:56:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfhE1qBZbh4IauWV8F/SBsmWMAxNH6Gffn6pRMmztzOImt+ltsf1WlpyM66ZkDe2Z2e1oLcA==
X-Received: by 2002:a17:90a:17cc:: with SMTP id q70mr25885693pja.26.1586174193217;
        Mon, 06 Apr 2020 04:56:33 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id w69sm11405465pfc.52.2020.04.06.04.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 04:56:32 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] rtw88: Add delay on polling h2c command status bit
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <3b815e889a934491bca23593a84532d7@realtek.com>
Date:   Mon, 6 Apr 2020 19:56:30 +0800
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <98FD848B-7F8A-4D2A-8265-CBF877011A5C@canonical.com>
References: <20200406093623.3980-1-kai.heng.feng@canonical.com>
 <3b815e889a934491bca23593a84532d7@realtek.com>
To:     Tony Chuang <yhchuang@realtek.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Tony,

> On Apr 6, 2020, at 19:01, Tony Chuang <yhchuang@realtek.com> wrote:
> 
>> Subject: [PATCH] rtw88: Add delay on polling h2c command status bit
>> 
>> On some systems we can constanly see rtw88 complains:
>> [39584.721375] rtw_pci 0000:03:00.0: failed to send h2c command
>> 
>> Increase interval of each check to wait the status bit really changes.
>> 
>> While at it, add some helpers so we can use standarized
>> readx_poll_timeout() macro.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/net/wireless/realtek/rtw88/fw.c  | 12 ++++++------
>> drivers/net/wireless/realtek/rtw88/hci.h |  4 ++++
>> 2 files changed, 10 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c
>> b/drivers/net/wireless/realtek/rtw88/fw.c
>> index 05c430b3489c..bc9982e77524 100644
>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>> @@ -2,6 +2,8 @@
>> /* Copyright(c) 2018-2019  Realtek Corporation
>>  */
>> 
>> +#include <linux/iopoll.h>
>> +
>> #include "main.h"
>> #include "coex.h"
>> #include "fw.h"
>> @@ -193,8 +195,8 @@ static void rtw_fw_send_h2c_command(struct
>> rtw_dev *rtwdev,
>> 	u8 box;
>> 	u8 box_state;
>> 	u32 box_reg, box_ex_reg;
>> -	u32 h2c_wait;
>> 	int idx;
>> +	int ret;
>> 
>> 	rtw_dbg(rtwdev, RTW_DBG_FW,
>> 		"send H2C content %02x%02x%02x%02x %02x%02x%02x%02x\n",
>> @@ -226,12 +228,10 @@ static void rtw_fw_send_h2c_command(struct
>> rtw_dev *rtwdev,
>> 		goto out;
>> 	}
>> 
>> -	h2c_wait = 20;
>> -	do {
>> -		box_state = rtw_read8(rtwdev, REG_HMETFR);
>> -	} while ((box_state >> box) & 0x1 && --h2c_wait > 0);
>> +	ret = readx_poll_timeout(rr8, REG_HMETFR, box_state,
>> +				 !((box_state >> box) & 0x1), 100, 3000);
>> 
>> -	if (!h2c_wait) {
>> +	if (ret) {
>> 		rtw_err(rtwdev, "failed to send h2c command\n");
>> 		goto out;
>> 	}
>> diff --git a/drivers/net/wireless/realtek/rtw88/hci.h
>> b/drivers/net/wireless/realtek/rtw88/hci.h
>> index 2cba327e6218..24062c7079c6 100644
>> --- a/drivers/net/wireless/realtek/rtw88/hci.h
>> +++ b/drivers/net/wireless/realtek/rtw88/hci.h
>> @@ -253,6 +253,10 @@ rtw_write8_mask(struct rtw_dev *rtwdev, u32 addr,
>> u32 mask, u8 data)
>> 	rtw_write8(rtwdev, addr, set);
>> }
>> 
>> +#define rr8(addr)      rtw_read8(rtwdev, addr)
>> +#define rr16(addr)     rtw_read16(rtwdev, addr)
>> +#define rr32(addr)     rtw_read32(rtwdev, addr)
>> +
>> static inline enum rtw_hci_type rtw_hci_type(struct rtw_dev *rtwdev)
>> {
>> 	return rtwdev->hci.type;
>> --
> 
> I think the timeout is because the H2C is triggered when the lower 4 bytes are written.
> So, we probably should write h2c[4] ~ h2c[7] before h2c[0] ~ h2c[3].

I can still see "failed to send h2c command" with the following patch:

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index eb7e623c811a..a296c860045f 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -240,10 +240,10 @@ static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
                goto out;
        }

-       for (idx = 0; idx < 4; idx++)
-               rtw_write8(rtwdev, box_reg + idx, h2c[idx]);
        for (idx = 0; idx < 4; idx++)
                rtw_write8(rtwdev, box_ex_reg + idx, h2c[idx + 4]);
+       for (idx = 0; idx < 4; idx++)
+               rtw_write8(rtwdev, box_reg + idx, h2c[idx]);

        if (++rtwdev->h2c.last_box_num >= 4)
                rtwdev->h2c.last_box_num = 0;


> 
> But this delay still works, I think you can keep it, and reorder the h2c write sequence.
> 
> Yen-Hsuan

