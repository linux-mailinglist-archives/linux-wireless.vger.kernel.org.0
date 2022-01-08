Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D864885FF
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jan 2022 21:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiAHUuq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jan 2022 15:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiAHUuq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jan 2022 15:50:46 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61173C06173F
        for <linux-wireless@vger.kernel.org>; Sat,  8 Jan 2022 12:50:46 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id o7so11926488ioo.9
        for <linux-wireless@vger.kernel.org>; Sat, 08 Jan 2022 12:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetfuse-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=/zwIqHAH34FQuJ2sflIzFGKt77THaCoKA8JRqjvJbho=;
        b=lkCcITeoxrOEh0XxVcXv7JG8C+BJA3TmQ7r6QlS3Mq2jgBPFwzwm99gqi0vf/0YZWA
         uv/Comjv+cftLfTXzC0pejxvwQ9r/JJpSBdP9jYEpocC6gRrdACmwmcnR9njKPZiyvQQ
         44k7WofR42lKMJNEDMm8xX5TRE2KlySjFYQgWTWvU36Tp1pM2jDqlZPLTpqaV5Va6fU0
         n2CBsbjzTq/dOIJxwAznp65pQCf6pf97p8QIXa234GCDTsgsmvB/jxivv0X8k14Mo9ZK
         vOVV5V37Q4QDEFw9pmodaLXJqtwsAdvKXYwkPQm9WxHfkiqnJGPt6tsB0K6FyO+wzBH0
         iTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=/zwIqHAH34FQuJ2sflIzFGKt77THaCoKA8JRqjvJbho=;
        b=nKWeuWHhlwfzWGPJyzoKirDTQgyaLolfp1LPhV8tud2zpyRP5Yt88LLfVQIgQcLWwY
         0ec7sWM/ZMm4CRcWD2s1DTlgnv36WsUP9rzivfNAf3FJNrDoEtwv/U2ErtQ1YKI3oCOB
         fQF7ievGPXpyO2CHMLbEzVn+hyvWSZkAz6qCOSuUkVdMVg3Xd6Tif1TL5dxDwlIdhSZF
         7P6cfAYbrRM5Q2fmOI7jZZp0Go7NOqrhi76HfWSBHiH7XzMlOSyQUF14IomRPReI0W+h
         1Q8RbdzW6tkzzxXb+31uHbGouR8qI0rKZGNe2SEEZ6BW4MkBqoF9ZDOSYtKicHB7AlBz
         dvLw==
X-Gm-Message-State: AOAM532Xe3cu6FHWw6Y8aO53ecf7KYHzeCfJzOOlzZVGySLg8HP4ur7c
        9otqVnOe4LfWUE8d5BDP1aWNjmvvz4Q88g==
X-Google-Smtp-Source: ABdhPJyejQGvi40ZK6aYqVjTINZEtn/96u1MyGy59X8VnPaPNoae8dympLnIuLToisDy5eA6eguA/w==
X-Received: by 2002:a05:6602:1641:: with SMTP id y1mr3541481iow.50.1641675045571;
        Sat, 08 Jan 2022 12:50:45 -0800 (PST)
Received: from [192.168.1.15] (174-082-179-210.res.spectrum.com. [174.82.179.210])
        by smtp.gmail.com with ESMTPSA id c18sm1600555iod.18.2022.01.08.12.50.44
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jan 2022 12:50:45 -0800 (PST)
Message-ID: <3cb11500-6828-6ded-bebc-cdb6e1f97bc0@jetfuse.net>
Date:   Sat, 8 Jan 2022 14:50:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
From:   Brandon Nielsen <nielsenb@jetfuse.net>
Subject: iwlwifi: AX201 not using 2 receive streams
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have a system with Intel AX201 not using 2 spatial streams in the RX 
(download) direction. TX (upload) functions as expected. I'm seeing 
similar behavior with an AX200 system. I'm seeing the same behavior on 
5.15.12 as I am with 5.16.0-rc8 so I didn't mark it as a regression. 
Windows works as expected.

I have opened bug 215465[0] with some more detail.

[0] - https://bugzilla.kernel.org/show_bug.cgi?id=215465
