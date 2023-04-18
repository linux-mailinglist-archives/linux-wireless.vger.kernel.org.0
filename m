Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0C6E5FD1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDRL2d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 07:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDRL2c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 07:28:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67744A5
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 04:28:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id c9so33419308ejz.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 04:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681817309; x=1684409309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMtn41d62YzIGJAK7Sixo90w1YjeKEzyXpaA0ki63Ps=;
        b=iz/VhSjK5hAn2E6m67XsYOxfqSJL6VRfIZ9R7ULuzMW2Itdol5B88Qqv0xpsnbrGsy
         omB52hLCETQccjf8Jj6y7YlpIeuKu6wO5JiEBS6Dge+inrBYau0NZhTZCXqjXBQJamCn
         vw4DgyUbIrABvp+v3yPVhGd/EivMbwKvn++6NjI8tLOYzrz72bwHuJ3Nq2gjmaiWB2Pl
         IiSY6e1SSEzrTklVXl4zuIjziPhSGmqqF9UjS+OAMTcRDcHx4x9Ms5vHotLb01tSqzk2
         xR0ArFAzpQEQAvA3JCl7nVgLzNzFg2y+6naX0P2hJTi5c18Iu7hOBER81TORlA9I6OMs
         3lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681817309; x=1684409309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMtn41d62YzIGJAK7Sixo90w1YjeKEzyXpaA0ki63Ps=;
        b=DjcCenQ+nCsXIap45nLUIdGBWiUnshlIc3XbzHToGN+UIkKzFoF0OUvaLcO96hkYk2
         LBFqplLGjk06UfEDp6k9VuRiya6TMMnwU1SWbCto4lszoLYnFYjkCQ1LemB5q7zqA2KS
         eF2BI471jsq4WPqi88MQ9rZElq/Pi4VlHpK6hUoxSnEm50Zc1q4eyoxyhp/Mq20+3/Z7
         AEm+XaPnUfzteGZCVGf4rgEUkC/7aMoswHoyW3+nPG+RevNO+xV1nRRzk2KTVLkG9/4c
         ov9Q3zdKRKO8yBMsnRbAjpu0PSKTTShj9GPIN7w469Jv11ulkmC9EqoeNsxgQO9OVSDe
         GmGA==
X-Gm-Message-State: AAQBX9f+kKxzYEqlQQw/vNx6xC6dKI9srK+JJmbePXHnDcK+P4A8i/8+
        xy3yREADhlg7p5hbln5CKTXQM8XUE7M=
X-Google-Smtp-Source: AKy350aWRdejlhlfSYx51wRq9fa5gZr+mCOTq/QZxX4u99X+rPpgGlLJBtch8tut/sTAeg3G2Lir7w==
X-Received: by 2002:a17:906:856:b0:94e:f1b9:e933 with SMTP id f22-20020a170906085600b0094ef1b9e933mr9559194ejd.53.1681817309539;
        Tue, 18 Apr 2023 04:28:29 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709062a1900b0094f614e43d0sm3466511eje.8.2023.04.18.04.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 04:28:29 -0700 (PDT)
Message-ID: <abb83a6e-4dbd-a188-23bb-f33155a80365@gmail.com>
Date:   Tue, 18 Apr 2023 14:28:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] wifi: rtl8xxxu: Simplify setting the initial gain
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <a2a7d9df-0529-7890-3522-48dce613753f@gmail.com>
 <cf91ca69-70e3-4c20-c0b1-e59d452356a1@gmail.com>
 <5d839cb6cea043de9f79f6490f9ccfb2@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <5d839cb6cea043de9f79f6490f9ccfb2@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 18/04/2023 04:13, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Tuesday, April 18, 2023 1:08 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH 3/3] wifi: rtl8xxxu: Simplify setting the initial gain
>>
>> The goal of writing 0x6954341e / 0x6955341e to REG_OFDM0_XA_AGC_CORE1
>> appears to be setting the initial gain, which is stored in bits 0..6.
>> Bits 7..31 are the same as what the phy init tables write.
>>
>> Modify only bits 0..6 so that we don't have to care about the values
>> of the others. This way we don't have to add another "else if" for the
>> RTL8192FU.
>>
>> Why we need to change the initial gain from the default 0x20 to 0x1e?
>> Not sure. Some of the vendor drivers change it to 0x1e before scanning
>> and then restore it to the original value after.
> 
> When WiFi gets connected, it will try to adjust initial gain for target AP.
> If we scan in this situation, change it to 0x1e to have better coverage to
> find APs.
> 

I see. I'll remember that if I implement the dynamic initial gain.
