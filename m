Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0533963C25A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 15:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiK2OVH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 09:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiK2OUt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 09:20:49 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4E768C62
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 06:18:44 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f7so19972439edc.6
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 06:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frF5KIMKCCN9PdZLhMeGmAdVXzxvZw3heJB8akHJVRE=;
        b=hswusqXyTeyQLqE6rQP5hvmzaoU7N6DSpmmJIe4sSwFh9/ooX1WbVOI3QFAeNck6nq
         L65aHHVz8ICuEqTpWNorM6FAOZ3z92wljSo3ThWdntyMik9LrzzDaVuZQanyD/Z8Kx6W
         VoD91cDPlU9GwuQ5AkldECI6+aqpdQtqZxOBtaM3wFI6yjwFO1n4Fs9jjY0YoSVtJg+A
         jjR8rNhc8P4whs7b6W+t4+k9FRoZt3rKN3csCgiKxYZIkU1yDR+PBCtiSN3RplToWqak
         rA2T2dpFrIU/pl8xzD+KmgxRtMZntsJ9Ce1NnJdR7Nrpo0AK2cRPGvIBsLkWBDT+Qf+w
         KXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frF5KIMKCCN9PdZLhMeGmAdVXzxvZw3heJB8akHJVRE=;
        b=cAYonhWCOIsZ9c5OO1wG3ARUKD67e6It62MMNbxCOcT5zHBKLP/P3p6rcWOBgziEL2
         J58kwfJXO9AVuFQ0xMAqMTw3HPJrJX9AbqWVDnhYW8EkCU2OKyC/DvEkeKRI+62ppwP+
         MUSXa5bx49i6iu8ZTaTvUBAKhUvhX/dxn6ulF3GTOeGe9nf2AymOcej6Au4iUqDLViH1
         dseZzXHWOM+touBwWGTDcEsOLomhKUM7obykrSak6vDWn961haaO/ZbxPtHBxZSvr86g
         Og8Az6bqJspiPn7FdYYXnf++yn5+6Pu5AbxUTBGJRpnkntq+us9maVygZtD6cTYhgId7
         J+Bg==
X-Gm-Message-State: ANoB5pme6I3N3HSLyxZ10khUJDbWMzONXiq1YTVLeF2qUKtnPYLFqYTJ
        l1y6n2A7TFzqI5SC8ObTIxA=
X-Google-Smtp-Source: AA0mqf4H7uknXgLBv7tfV+iy6Gh/jNMb+ib7qz3cjhZ+8IKzSLi0QlwH9ARPI7xMd5rpbJ3b5yYWXA==
X-Received: by 2002:a05:6402:456:b0:461:9955:b54a with SMTP id p22-20020a056402045600b004619955b54amr40436897edw.159.1669731522792;
        Tue, 29 Nov 2022 06:18:42 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id g27-20020a170906395b00b007c094d31f35sm183888eje.76.2022.11.29.06.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:18:42 -0800 (PST)
Message-ID: <bbb288a9-c957-76ce-e81a-cb20656ca241@gmail.com>
Date:   Tue, 29 Nov 2022 16:18:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/3] wifi: rtl8xxxu: Fix the channel width reporting
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <d3018e30-92c6-1e73-3b63-311fc472a41f@gmail.com>
 <adc5b63e-7d8d-d613-661d-579bb9f9fadb@gmail.com>
 <c18a1ea252c340b8a876a62bc735c19e@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <c18a1ea252c340b8a876a62bc735c19e@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 29/11/2022 03:22, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Tuesday, November 29, 2022 3:30 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH v2 2/3] wifi: rtl8xxxu: Fix the channel width reporting
>>
>> The gen 2 chips RTL8192EU and RTL8188FU periodically send the driver
>> reports about the TX rate, and the driver passes these reports to
>> sta_statistics. The reports from RTL8192EU may or may not include the
>> channel width. The reports from RTL8188FU do not include it.
>>
>> Only access the c2h->ra_report.bw field if the report (skb) is big
>> enough.
>>
>> The other problem fixed here is that the code was actually never
>> changing the channel width initially reported by
>> rtl8xxxu_bss_info_changed because the value of RATE_INFO_BW_20 is 0.
>>
>> Fixes: 0985d3a410ac ("rtl8xxxu: Feed current txrate information for mac80211")
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>  - Eliminate the magic numbers.
>> ---
>>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      |  2 ++
>>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 ++++++++---
>>  2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> index d26df4095da0..9be53e0f25cc 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> @@ -1187,6 +1187,8 @@ enum rtl8xxxu_bw_mode {
>>  	RTL8XXXU_CHANNEL_WIDTH_MAX = 5,
>>  };
>>
>> +#define RTL8XXXU_C2H_HDR_LEN	2 /* id and seq */
>> +
>>  struct rtl8723bu_c2h {
>>  	u8 id;
>>  	u8 seq;
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 28f136064297..352779fe4b78 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -5569,7 +5569,6 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
>>  			rarpt->txrate.flags = 0;
>>  			rate = c2h->ra_report.rate;
>>  			sgi = c2h->ra_report.sgi;
>> -			bw = c2h->ra_report.bw;
>>
>>  			if (rate < DESC_RATE_MCS0) {
>>  				rarpt->txrate.legacy =
>> @@ -5586,8 +5585,14 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
>>  						RATE_INFO_FLAGS_SHORT_GI;
>>  				}
>>
>> -				if (bw == RATE_INFO_BW_20)
>> -					rarpt->txrate.bw |= RATE_INFO_BW_20;
>> +				if (skb->len > RTL8XXXU_C2H_HDR_LEN +
>> +					       offsetof(typeof(c2h->ra_report), bw)) {
> 
> I think this is not very intuitive, because this logic is correct only if 'bw' is u8.
> 
> Then, this option may be not bad:
> if (skb->len >= RTL8XXXU_C2H_HDR_LEN + offsetof(typeof(c2h->ra_report), bw) + sizeof(c2h->ra_report.bw))
> 
> or 
> Not need RTL8XXXU_C2H_HDR_LEN. Just use offsetof() to calculate: 
> if (skb->len >= offsetof(typeof(*c2h), ra_report.bw) + sizeof(c2h->ra_report.bw))
> 
Nice! I didn't know offsetof can do that.

