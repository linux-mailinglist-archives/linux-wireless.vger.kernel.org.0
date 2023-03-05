Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AA36AADEF
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 03:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCECwb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Mar 2023 21:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCECw3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Mar 2023 21:52:29 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9175F946
        for <linux-wireless@vger.kernel.org>; Sat,  4 Mar 2023 18:52:28 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id e26-20020a9d6e1a000000b00694274b5d3aso3575261otr.5
        for <linux-wireless@vger.kernel.org>; Sat, 04 Mar 2023 18:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2XrX5uXrAewmG4BgR+EQ/rUxP3EjHnYVxO7Eu+3uj4c=;
        b=O6T52wNmWv5oUOR/sno5yhHu10urfftypymxdT68CkPNUxHFo3K2PSqfpzbvDDulah
         Cob4v1LKEGyyjJ3DlPNpla4v+5NouzFjSxpZFb5svIDLj7dXYkobA/ORNIfEFMq51JDl
         tqjkVDkVrjkg+QKZbwJyw7SQKiztXTmLXRiXRjXDK1GBQFMHe5eWQ7GV83+xK1LZrS9A
         I7IdcFK0SrlHESKBBLiqndV/67GdouHPWUvg9VD8bBNhFIC4FfcsbZLvjfwWm2OK3lVL
         ouAq3q9n1GTXoZo18La3jZTDppSGoruSGNCeFKoIv5MOedjEuD/yaTff4w8SF1G7ixiX
         7m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XrX5uXrAewmG4BgR+EQ/rUxP3EjHnYVxO7Eu+3uj4c=;
        b=QjhKtcnikocORpe1Er8dZbkPVrXBsG7XIDtEq0w9N56Atfx6umNtymqnPagBHnhSE6
         F4C99T6ALTfMQl1ME8Z9dGMb8ExSNnEGYuK9XYpMw1vUkOG3ULBJlEfBHJsUb1zWRGAC
         yG3PvaWd8S731NQPpNpBF+o36d2c6CCJowEKoKpC9apX1knhbH7vRaak/s47a5GLT4t0
         bAQtMv6vGU+aGggsYOhwTvoGyhBmYv/sybE82iaHAXDRZZ2a9fqzK2in5qjRBpA6emNh
         Xius4O5zKg/6abS9OyzN6p3LlvwagEJdAcXZR7PBsjnnn0DQ9Dy8mUSFIg9S3+ZtUBx/
         KDjA==
X-Gm-Message-State: AO0yUKXi3wB9quLM3juu36Jbpy/A2lv/g130e/pOd8pko5vwnGCOiY4Z
        2+ggNh5pueRKSY4E2vfEzpAzrH+Dnxo=
X-Google-Smtp-Source: AK7set8fLeZC2ckTygytWD4gfGXyNti15HL6hZBipGxZV5pYrjE+Is1lDrJp/A+tAFsy45VEeP+8YA==
X-Received: by 2002:a9d:5a82:0:b0:68d:416e:3d9d with SMTP id w2-20020a9d5a82000000b0068d416e3d9dmr2392859oth.7.1677984747640;
        Sat, 04 Mar 2023 18:52:27 -0800 (PST)
Received: from [192.168.0.156] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id d11-20020a9d72cb000000b0068bcef4f543sm2778422otk.21.2023.03.04.18.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 18:52:27 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <93d565e1-3a23-69f3-bedd-b71eb601bceb@lwfinger.net>
Date:   Sat, 4 Mar 2023 20:52:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>, Pkshih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Performance of rtw88_8822bu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sascha an Ping-Ke,

I have been testing the RTW8822BU driver found in my rtw88 GitHub repo. This 
code matches the code found in wireless-next. I created 9 files of 5.8 GiB each 
and used a for loop to copy them from the test computer to/from my server. The 
wireless connection is on the 5 GHz band (channel 153) connected to an ax1500 
Wifi 6 router, which in turn is connected to the server via a 1G ethernet cable. 
The connection has not crashed, but I see strange behavior.

With both TX and RX, the rate is high at 13.5 MiB/s for RX and 11.1 MiB/s for TX 
for about 1/3 of the time, but then the driver reports "timed out to flush queue 
3" and the rate drops to 3-5 MiB/s for RX and 2-3 MiB/s for TX. These low rates 
are in effect for 2/3 of the time. The 5G bands are relatively unused in my 
house, thus I do not suspect interference.

Any idea why the timeout errors are occurring? They definitely kill the 
throughput. If you are interested, I have a photo of the TX throughput vs time.

Larry
