Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0860BBD0
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Oct 2022 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJXVOQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 17:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiJXVNn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 17:13:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8960EE39
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 12:19:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m15so33120517edb.13
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 12:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMlBZRsiHONUkMZWk7c4+laypsMYs6eGQdEg5/gU8XU=;
        b=SvyGMCGOkYMRW6BHqhHMOAnujkohpZnJQ3kJ24DRIN4kdrRBt6Kd6jF9el6DXr+RuR
         wD0BWai2x4Nv+L/sCh3KiCv7V09Boc8ywOvDjdeSBG/BHmPK8QVDH1X4C2xV4qoXtlvO
         fJyIVAi3ro6LO+B4Bv1jXA/A1AgED7S2q2ioy6rotijHiAyRFizomLXh8SLk+JUIRxMr
         AL9zbY9ZXHStYtf7gMi7/sW36WB7x1vmCn7wp5ZD6yHJ3745uYP3D7WwxNLiJpRfXqST
         +5+AMAQrR8eDJO59FaTN6w860tWW9gLX4cijEitcpQ679OVnjdaLu6EziwreowQSW2Zq
         Wm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMlBZRsiHONUkMZWk7c4+laypsMYs6eGQdEg5/gU8XU=;
        b=18qcDKA7BUp6GwqbT4oKQM325uSTptGoC9UArE3TCTRHl1UP4zGTBYmySMu0WfVuyM
         iz6jRYOEmaRBevKRzN6BY5V8tek2O1RT4BsjxdMXNya4Ytt+bf8Ck/J61bL7XDv6+vp3
         5Aj7rH5VvGouKoNVWQ5HDt6+rHrbP0iQNTkqWkO+EyIZI+7x5OQQL+jDArt+e+Z7NANv
         YGkv+zBQ5Q7crouepf1sl68u8v0Y4SdEAQDWjDx3HJq+ml8xmmwD95TcUlyTp0iUqeXc
         naG83QZm6/wDiJjvTdnsr2MJDpl+B417me2wk+kCyE27WBbbYb7lpS05l7dbBycfijqn
         8ftA==
X-Gm-Message-State: ACrzQf3IfBIPx20uhQmhh9vh8JT+1FXUHNZ2VHm++6VnwlTyc4O4s6YS
        kdtjKIDR9vmKPYU+dD0QYs9DgeuI6jo=
X-Google-Smtp-Source: AMsMyM4zwL12dK0aPe9gXv3DU/OG6rhmRvwNBiGXDXy2f+E+RBWuNEX9kWE5xoBPciAG1meKMhQOBA==
X-Received: by 2002:a17:907:703:b0:78e:25be:5455 with SMTP id xb3-20020a170907070300b0078e25be5455mr27381699ejb.630.1666621497917;
        Mon, 24 Oct 2022 07:24:57 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b0078e0973d1f5sm14674680ejh.0.2022.10.24.07.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:24:57 -0700 (PDT)
Message-ID: <92d01e81-9d40-a9a2-1a8e-1207ccf33755@gmail.com>
Date:   Mon, 24 Oct 2022 17:24:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: How to use the rate control in mac80211?
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b80eae6f-8369-c98d-ffc4-3ee5b5b4eb22@gmail.com>
 <efd11380ad344257a8f674b1cff0d080@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <efd11380ad344257a8f674b1cff0d080@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 24/10/2022 05:13, Ping-Ke Shih wrote:
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Sunday, October 23, 2022 5:24 AM
>> To: linux-wireless@vger.kernel.org
>> Subject: How to use the rate control in mac80211?
>>
>> Hi!
>>
>> What does a driver (rtl8xxxu) need to do to make the rate control work?
>>
>> I thought it's like this:
>> 1) don't set HAS_RATE_CONTROL
>> 2) tell the chip to use the rate from tx_info->control.rates[0]
>> 3) report if the frame was acked or not
>>
>> But it's not that easy. I'm always getting MCS0. Currently rtl8xxxu
>> doesn't ask the chip for TX reports and always sets IEEE80211_TX_STAT_ACK.
>> I thought this would get me MCS7 for all data frames, but it doesn't.
> 
> I don't dig rate control of mac80211, but I think it is hard to support this
> by Realtek chip, because the item 3 you listed.
> 
> Realtek WiFi chip only reports TX status for specific packets, because bus
> bandwidth is limited, so reduce these reports to have better performance.
> And, firmware has implemented rate control called rate adaptive (RA), and
> using firmware RA is expected.
> 
> If you really want to control rate by driver, you can refer to implementation
> of management frame below:
> 
> 	if (ieee80211_is_mgmt(hdr->frame_control)) {
> 		tx_desc->txdw5 = cpu_to_le32(rate);
> 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_USE_DRIVER_RATE);
> 		tx_desc->txdw5 |= cpu_to_le32(6 << TXDESC32_RETRY_LIMIT_SHIFT);
> 		tx_desc->txdw5 |= cpu_to_le32(TXDESC32_RETRY_LIMIT_ENABLE);
> 	}
> 
> Another thing is that retry rate is decided by hardware by another register
> settings, but I'm not familiar with them, because I always use RA mentioned
> above. Maybe, you still can use *default* settings of retry rate that could
> work but not always good in all situations.
> 
> Ping-Ke
> 
Normally, we use the firmware rate control, but RTL8188EU doesn't have it:
https://github.com/lwfinger/rtl8188eu/blob/c4908ca4caf861d858c4d9e8452a2ad5c88cf2ba/rtl8188eu_xmit.c#L349
https://github.com/lwfinger/rtl8188eu/blob/c4908ca4caf861d858c4d9e8452a2ad5c88cf2ba/hal8188erateadaptive.c

(I guess they used the space in the firmware on the IOL stuff and the rate
control code didn't fit?)

Maybe we don't need to ask for TX reports for every data frame?
