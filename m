Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68C71F0FA
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 19:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjFARkm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 13:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjFARkf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 13:40:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB65E45;
        Thu,  1 Jun 2023 10:40:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2568befcf1dso999412a91.0;
        Thu, 01 Jun 2023 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685641226; x=1688233226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D8gGFCJWlgSRi/RFp2C9emrJ0HA0Uwkc0cIZTUiWPLo=;
        b=poBdbihWEVG2Fzo5uOigrxncgTJeeRP/gDFeGeUTzaIjQwY9k3hBfxb1FNHH/FoLc9
         y+3EQhm/kPFseRi4FW0PhoWXQASAgABIAgR6hq6wS7OYMy2yZbNJjU1b7ZPzX2k6GTUG
         M9MmwptxKXfmxYnst0ibsClH6VINHMBVYDpodb+5fwCmdeAGIW2SxwRFqEVK16kbawRC
         DxF14tHRB1AfsSJmF0Thy8gVFzi8Y1YOxbLQ5n8nuVRkeqkyaeCACVM2FGxJdMZCznSF
         RLTzxhBtTrp6lyDSTNzj3Xt3dEnZ+bF74K85bC9HGWPj10q27HEUnw67GpL/IUmEnpi9
         cqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685641226; x=1688233226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8gGFCJWlgSRi/RFp2C9emrJ0HA0Uwkc0cIZTUiWPLo=;
        b=FslRwVmmk9A35oMwguMArPsdfccdMTdScMQqBwWFp9A5fETil55cXg4tpQNg4A+wt0
         AhumwYMooMp8TJkm/yKEAVFrN+CvdQh6QDIA/wIW3xwXPvN2BMBsOkNXhx77xTvCAOaq
         ZTBxN3aPQpd/bTaT5Jv8RgJBZ5kTppWrYJZ1lOOsDCh63BwD5rTZtNfaEj57gYkKzxph
         RGebT0/7Eq0BHf55hue2SgYn0AcWw3ihJypl5r2FS60ZMo/nBByasat+sbs9/fyj+mxr
         G38rc45IldybUEQtZcBtq/bCWjG0WLV+sPfHglIcjf2KWuboB5XHD77AgYCd90ERR78+
         KCVw==
X-Gm-Message-State: AC+VfDxlAiAuDVPn663IcAWIuxY9VHIKidjX9oLefcpe9qHVHR8Oq7y2
        RMct8YsJTW3h68VhSUwj2dU=
X-Google-Smtp-Source: ACHHUZ7XL9SNXJ6edunVLssKw0jd6/rwHrkjmJmKqJ/gjbpzd5Bn2SkEWJZ2OKzQ2SehjRKDuuxw7Q==
X-Received: by 2002:a17:90a:c383:b0:256:6462:e399 with SMTP id h3-20020a17090ac38300b002566462e399mr24766pjt.5.1685641225834;
        Thu, 01 Jun 2023 10:40:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a19cb00b002568f2f8102sm1749913pjj.30.2023.06.01.10.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:40:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7cc45ce0-e472-5953-bbab-d15cfd96d0fe@roeck-us.net>
Date:   Thu, 1 Jun 2023 10:40:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: iwlwifi: bump FW API to 78 for AX devices
Content-Language: en-US
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "inux-kernel@vger.kernel.org" <inux-kernel@vger.kernel.org>
References: <f7e417e0-5277-4085-bb50-fb43bdc52f7a@roeck-us.net>
 <1ee34c4b93dc0acb5bd51556ce5f60062b78f970.camel@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1ee34c4b93dc0acb5bd51556ce5f60062b78f970.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/1/23 09:00, Greenman, Gregory wrote:
> Hi,
> 
> On Thu, 2023-06-01 at 07:33 -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Mon, Apr 17, 2023 at 11:41:34AM +0300, Gregory Greenman wrote:
>>> Start supporting API version 78 for AX devices.
>>>
>>
>> This patch sets the ucode version for a large number of devices
>> to 78, but ucode version 78 is not available for many of those
>> in linux-firmware. It seems that .78 was skipped for some devices
>> in linux-firmware, and the last version for several others is .77.
>>
>> This causes problems when trying to validate if the firmware
>> listed in MODULE_FIRMWARE actually exists.
>>
>> Is the missing firmware going to be available at some point,
>> is there a plan to fix the code to only list actually available
>> firmware, or is it a wrong assumption to expect that the
>> firmware listed in the kernel actually exists ?
>>
>> Thanks,
>> Guenter
>>
>>> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
>>> Link: https://lore.kernel.org/r/20230417113648.5a4dcbf5a2c1.I125808566fe892ee0865e392bf1b1872daafe8ad@changeid
>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>> ---
>>>   drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
>>> index b98f0ff02362..532d14f61253 100644
>>> --- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
>>> +++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
>>> @@ -10,7 +10,7 @@
>>>   #include "fw/api/txq.h"
>>>   
>>>   /* Highest firmware API version supported */
>>> -#define IWL_22000_UCODE_API_MAX        77
>>> +#define IWL_22000_UCODE_API_MAX        78
>>>   
>>>   /* Lowest firmware API version supported */
>>>   #define IWL_22000_UCODE_API_MIN        39
>>> -- 
>>> 2.39.2
> 
> Yes, I'll send it just in couple of days.
> 
Thanks!

Guenter
