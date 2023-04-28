Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54D66F1E79
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 21:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345577AbjD1TDA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 15:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344155AbjD1TC6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 15:02:58 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC701BE7
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 12:02:57 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38dfbbfe474so151884b6e.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682708577; x=1685300577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=L5a3ZX1IvXb0DtWADG0cnEpLXZGTCTSuJ1oMRZfVzl4=;
        b=IhqtfzFa3cySeHHHycSJI0OHUkWOWXJWgCRLQk4n5WVostRDoOTNwwArHedXItoT57
         202QttjU458Rzu8r+szDR3b2kQWRwcEYFATEMI+wz5dfWtIHiKNBYTUACiyD7A+F0xWh
         tFU4fkW2/7CU6l13nPFH3vdphEOscR7B+V5S4dM7LkmIJQT6/3xq/N9Gc/606w6URobA
         b0xJdsFJkSQZZhDnAHu/bT3Gz1oj1OiHkPD2O3r5JuKy2g6AOd+gT82hxCX6uHGIB/3W
         W7uUG0s8utwtEOnExUmAHzRSrWpUlMovgjHkfT2pMueCoX05oW0BKOhTxb7z6MNold3B
         tsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682708577; x=1685300577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5a3ZX1IvXb0DtWADG0cnEpLXZGTCTSuJ1oMRZfVzl4=;
        b=YQap8PB4Jva+yB10f0cTXYx4f64W7nWbMtEu5yh2MH5CZkx89CyUp7CJv51g8x1okx
         fFz6MszfGJfuWkYCA7ccwalRtp9zdiW4qNTVUYrBvCZRZW6ljPqGlSJKmWywzkRI4AWi
         6cpfHg5YGdyf1hqfltYTU+dVtFXW5b7w2rsO60U000iYRha5vuYVQ2Tj8nMuKyQFinDp
         6qdEnRYWpYVFx9YZ30LvPyNrfBqlqYBJG2RucxeMTDbR/tn9YnzBaGp+QQyikCVwWR2C
         5mx90zVxuguw4+baEZC5xnhfN+uyH9cvtsDc2U8daqlBOxNkxh52mtODn9mbv/AryeJ2
         aXhQ==
X-Gm-Message-State: AC+VfDyt/92rHMgDxyk+bsfe6Ndj67A5kiGZ0kFB26PdOGTfRgI99XDQ
        i1rBCB7ztqJArv7IrfPEYx8=
X-Google-Smtp-Source: ACHHUZ437ZXcfh9pTR1ARz4g8FbsHr68hMz0bVVQH2hRslGihDjjDi3BrNnPgwXkofQYNxjlP8cGBA==
X-Received: by 2002:a54:4805:0:b0:384:167d:736b with SMTP id j5-20020a544805000000b00384167d736bmr2906576oij.15.1682708577047;
        Fri, 28 Apr 2023 12:02:57 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id z23-20020a056808029700b0038c66c39131sm9158292oic.5.2023.04.28.12.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 12:02:56 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <52684230-07e3-ebd6-8418-4eae54672575@lwfinger.net>
Date:   Fri, 28 Apr 2023 14:02:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192cu: Remove driver
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
References: <20230428182933.19157-1-Larry.Finger@lwfinger.net>
 <431b8d98c2e5d81c20862965151ac63596f04bf3.camel@sipsolutions.net>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <431b8d98c2e5d81c20862965151ac63596f04bf3.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/28/23 13:41, Johannes Berg wrote:
> On Fri, 2023-04-28 at 13:29 -0500, Larry Finger wrote:
>> --- a/drivers/net/wireless/realtek/rtlwifi/core.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/core.c
>> @@ -1770,12 +1770,6 @@ static void rtl_op_flush(struct ieee80211_hw *hw,
>>   static int rtl_op_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
>>   			  bool set)
>>   {
>> -	struct rtl_priv *rtlpriv = rtl_priv(hw);
>> -	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
>> -
>> -	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192CU)
>> -		schedule_work(&rtlpriv->works.update_beacon_work);
>> -
>>   	return 0;
>>   }
>>   
> 
> Looks like you could remove that entire method if it does nothing now,
> it doesn't matter to mac80211 if you have it or not (since you don't use
> AP_LINK_PS.)
> 
> Not sure it matters to you in the driver :)

I thought about doing that, but decided to leave the empty one there until I 
could do more testing. Leaving it will add a few bytes to the driver, but that 
should not make much difference.

Larry


