Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0F756FBB
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jul 2023 00:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGQWXb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jul 2023 18:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGQWXa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jul 2023 18:23:30 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E4191
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 15:23:29 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b9c9944da8so1857214a34.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689632608; x=1692224608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TjOJOC8Guo8TNkjmFUpR407Gj5bUpHTU7WznZwIjSjI=;
        b=VdMb8/isJhp3L4oi/+7RxuN9X0YYI18h2fSVHGwAdqvz0rpZt17XT67wQHrkdR/ljt
         QCPxm92v0+XL5Lp1AS7dd/B7PLAoLeV/kAdWA7qNChq1Gi6jL4p3TBdvaEX5VB/xvFQH
         hlvEo+vkC01v7w4vb9UUNw1vsEbeV4jtilCIOW3ZFoswsckhGbw+0Zxq+gaajvyXMguP
         o4GhnnX8jO1o4YX8ekcoFKGdHqRwjrTpYMhRIBJub4GUcupmUxcLXekF8PO87i5wp3yt
         xzg69iMXMaC0O8yOhIDgsUbFFyqOPjjOuMeVLixQEMG8hPstaX1teE0iwStk4zanoFG/
         ZgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689632608; x=1692224608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjOJOC8Guo8TNkjmFUpR407Gj5bUpHTU7WznZwIjSjI=;
        b=Gw1ClJrJYngsk2Z7PXt13lI2L9eIgZYJWSEq13yFniGFocS5b0lS2A+HI7SnEb2fEi
         KUmLfkJ3ZxCZtGWzj+FbF2IPUBUJwdfm6WxBZ4UMd4aVyxRy7nXVJAJ/pzF0Chtf2Ddx
         JIQxeX2ouVv+xu3bPkM9QEsq1bhpsQ56bmRzIjLz6a7fY0x2BkE+kcCdQmmhX8CQi3/Q
         RrUpHcP1vrNVha7dzJ5/KRWK5Q4/ZgCa1bKsNOo8B/BMrXl9mGzISzL5Fch01dDsq6cB
         AV4bP2krr5ZZEDpiHpiXMVWz21KbLEVvi1mP4hAu3ZvZIukvw/m9Qjfw+Gr7Hw9gxJdr
         IZwg==
X-Gm-Message-State: ABy/qLYmLX/gLs5mXWjFvPiPcunzpO85z5O2zX5xwbSmoY3THh+jTMnS
        SN+jxiY5dukdQWz7Nt6qCKdeEdBkgIY=
X-Google-Smtp-Source: APBJJlHgu7IRQLnXeCNxX+NM8DFVMG2vepB45mKkk06eHC2CI//sTcsk9QT9W7BRmi6MPWwKrD0FGA==
X-Received: by 2002:a05:6808:1385:b0:3a4:9f:933e with SMTP id c5-20020a056808138500b003a4009f933emr13480566oiw.58.1689632608595;
        Mon, 17 Jul 2023 15:23:28 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id w5-20020a056808090500b003a09db4a54bsm175797oih.48.2023.07.17.15.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 15:23:27 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <7571dbf0-5a2d-8ab3-70ab-5ca53f799803@lwfinger.net>
Date:   Mon, 17 Jul 2023 17:23:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: rtw89 driver and compressed firmware files
To:     Takashi Iwai <tiwai@suse.de>, Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org
References: <87zg3uvawm.wl-tiwai@suse.de>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <87zg3uvawm.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/17/23 10:02, Takashi Iwai wrote:
> Hi,
> 
> while debugging a reported rtw89 issue
>    https://bugzilla.suse.com/show_bug.cgi?id=1212808
> we noticed that rtw89 driver didn't load the firmware properly.
> 
> And, this turned out that it's because the driver uses
> request_partial_firmware_into_buf() function with the combination of
> compressed firmware files (that are standard on some distros like
> openSUSE).
> It's a known limitation of the request_partial_firmware_into_buf() API
> function itself; it won't load compressed files, because otherwise
> it'd have to read the full data.  That said, the use of
> request_partial_*() should be only for very limited use cases, and
> this doesn't look fitting well for rtw89.
> (And, as usual, the information is missing in the documentation :-<
> The API document should state it clearly; I'm going to submit a patch
> to add the information.)
> 
> There was already a workaround for CONFIG_SECURIY_LOADPIN_ENFORCE for
> a similar problem, but such a fallback is required in general for all
> cases, as it seems.
> 
> I can cook a hackish patch for the fallback, but I wonder whether it
> still makes sense to keep the use of that API function.  rtw89 is the
> only driver except for bcm-vk (where the API was introduced just for
> this driver), after all...

Takashi,

I have completed my tests of Leap 15.5. I had to manually copy the firmware for 
the 8851BE to /lib/firmware/rtw89, but once I did that, the following was logged:

[ 1572.450392] rtw89_8851be 0000:02:00.0: Direct firmware load for 
rtw89/rtw8851b_fw.bin failed with error -2
[ 1572.450397] rtw89_8851be 0000:02:00.0: failed to early request firmware: -2
[ 1572.470196] rtw89_8851be 0000:02:00.0: Firmware version 0.29.41.0, cmd 
version 0, type 5
[ 1572.470204] rtw89_8851be 0000:02:00.0: Firmware version 0.29.41.0, cmd 
version 0, type 3
[ 1572.801867] rtw89_8851be 0000:02:00.0: chip rfe_type is 1
[ 1572.842343] rtw89_8851be 0000:02:00.0 wlan2: renamed from wlan1

This result was obtained with kernel 5.14.21-150500.53-default.

Yes, the request_partial_firmware_into_buf() failed, but the next attempt 
succeeded. The firmware in question was xz-compressed.

I cannot duplicate the OP's result. I will try next with Leap 15.4, but I do not 
expect a different result.

Larry

