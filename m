Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2A06CAD05
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 20:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjC0S3K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 14:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC0S3J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 14:29:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DC6271D
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 11:29:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y14so9765576wrq.4
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679941746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiWU1/AOuH7DwBGjMNZ5nXBxw1kknxuLOf5kZT+jX4Y=;
        b=i/Y/ZE1hC07i8EyFuaxdGyrvGR0ODQPw/zwg4V1Zecdkod+M6aifuSm+RxTFJtlWNM
         jpOFjPhSPrsbhkRcMZzDJQ59VKnh/jF7HmcVnPhqxx6TQIXmRxZIr7Utta+vjBaFzmdl
         bPTrbZrS9alTYrADEdMjKzL41qqXwVOqHVFAbbXUyNGt5odXXrhhhiubb6adePs7yrHr
         8WlS03rAetXYEZkzDmzv4lDjterR+7VE0jZaIgSahkYPKC6P0a9lUkfVHfL8rDB1in2E
         K97hnSk9/qAGjHbcx136IL/fVUBKn1RGqxOTey5F15UG80zBHD81/9SXlSRxEgBJIRm8
         dcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679941746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiWU1/AOuH7DwBGjMNZ5nXBxw1kknxuLOf5kZT+jX4Y=;
        b=1smexS3FWAtYzTFhsKAgJdDekUnmoU8ijuFa5mp5tZvhKcaCltxsZ7hxtuLVHACZpk
         uXTgRVGRZAigJxyIN6LAUXkMPuSDDXIIG7tISHI2zLEu148T+yEaKV2TxItldqLHCkde
         apT6GNoahBMmbnMTIaagE4nnHfdxJ+dMoIMRco8mLIgYTslygjuL5Z5pI5hPHZLSouQe
         fmem+diozfwv54Qi0aFwT1Ckd7zDNT4AvSgIkehBbDhhglt3zbb7xVWbXS9yC8f1vwS3
         PkC8kjKUFH97SMwQhHPJILVrcWsHnW6y4vva5FcUI3c1TdR64Y7EC3VVZBHqiN275uZ1
         46pw==
X-Gm-Message-State: AAQBX9eNxdKMxuKTc+xH8DB5KjCJGmHAS2hiFSiNfTEWXE/5aarm/4AL
        eCtnSy9+Ikl84IoBEdGFndw=
X-Google-Smtp-Source: AKy350YhZmwkyyvuyVLbdpOL8TblSonO042zv7ID5fwV750zvXWWFu0OnP0B59rRAuBSrBbje17Ypg==
X-Received: by 2002:adf:e9c9:0:b0:2ce:ae4c:c420 with SMTP id l9-20020adfe9c9000000b002ceae4cc420mr10285773wrn.3.1679941746579;
        Mon, 27 Mar 2023 11:29:06 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id m9-20020adffa09000000b002c70d97af78sm25811421wrr.85.2023.03.27.11.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 11:29:06 -0700 (PDT)
Message-ID: <c8d45f50-28b4-6f5c-9754-43d8eb0bb084@gmail.com>
Date:   Mon, 27 Mar 2023 21:29:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 01/14] wifi: rtl8xxxu: Add start_ap() callback
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-2-martin.kaistra@linutronix.de>
 <62bf7fa9-e041-c8d8-c63e-42b3674fc9d8@gmail.com>
 <7efd83bd-f6f9-eb2c-3b6a-1795307d4e2f@linutronix.de>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <7efd83bd-f6f9-eb2c-3b6a-1795307d4e2f@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 27/03/2023 19:08, Martin Kaistra wrote:
> Am 27.03.23 um 15:10 schrieb Bitterblue Smith:
>> On 22/03/2023 19:18, Martin Kaistra wrote:
>>> This gets called at the start of AP mode operation. Set bssid, beacon
>>> interval and send a connect report to the HW.
>>>
>>
>> Hmm, but why send a connect report when you don't have anything
>> connected yet?
> 
> I tried following the vendor driver here, I don't know what exactly happens in the firmware.
> I can test, though, if there is any difference, if I remove it.
> 
Ah, okay. I was just wondering.

>>
>>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>>> ---
>>>   .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> index c152b228606f1..90b98b9dcbd9d 100644
>>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> @@ -4899,6 +4899,20 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>>       return;
>>>   }
>>>   +static int rtl8xxxu_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>> +                 struct ieee80211_bss_conf *link_conf)
>>> +{
>>> +    struct rtl8xxxu_priv *priv = hw->priv;
>>> +    struct device *dev = &priv->udev->dev;
>>> +
>>> +    dev_dbg(dev, "Start AP mode\n");
>>> +    rtl8xxxu_set_bssid(priv, vif->bss_conf.bssid);
>>> +    rtl8xxxu_write16(priv, REG_BCN_INTERVAL, vif->bss_conf.beacon_int);
>>> +    priv->fops->report_connect(priv, 0, true);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static u32 rtl8xxxu_80211_to_rtl_queue(u32 queue)
>>>   {
>>>       u32 rtlqueue;
>>> @@ -7026,6 +7040,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
>>>       .config = rtl8xxxu_config,
>>>       .conf_tx = rtl8xxxu_conf_tx,
>>>       .bss_info_changed = rtl8xxxu_bss_info_changed,
>>> +    .start_ap = rtl8xxxu_start_ap,
>>>       .configure_filter = rtl8xxxu_configure_filter,
>>>       .set_rts_threshold = rtl8xxxu_set_rts_threshold,
>>>       .start = rtl8xxxu_start,
>>

