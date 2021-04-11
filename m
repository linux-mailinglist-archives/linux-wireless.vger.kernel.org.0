Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F93A35B26A
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 10:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhDKIYy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 04:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKIYx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 04:24:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18839C061574
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 01:24:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hq27so15177191ejc.9
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=+HPLZx6r8w/SKgUvUa5HzbaNtmtw6B6RH/vhDMqbVac=;
        b=L2R2ooPTcNOxmC+MgLW17Kk4maMC41Ao7bogzHP6/CSuBAutVwkXL7qt5QgN0u27uH
         HyWnnubdj0V4l1ys/iOY9mf9DvHieDh/q34k5UQvAGWTnpw44f68MvClJ/45CJLAwKRQ
         i78j9m0EWFgHzVJkP3eP3GDJGag4m86fYHkQNQpUJ4URLejsFGbHRYXZ1R0PspsCQVfB
         S2F4QePRO/L9ImOx1GRroITBwKr+IYkXYVvzinzcTxJ+Qy/+L4LFf6mcqWquzx1pQ7zI
         Fv3o/sy1JT3v+zWPC0zL2Z/slXnPlwxKenPTTy02D922DHRnj9TfdN3jIQkiCvGD4jmW
         P0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=+HPLZx6r8w/SKgUvUa5HzbaNtmtw6B6RH/vhDMqbVac=;
        b=O7l92BXycwPn2epwld6fK1IDNZQI4tP6J5Aiy07SD8l24OZN3oUx+e8Y5D2iZZeBC0
         5ik8e6Uyy2STgDSZBk1jqbZG4kUweKGx1N0IXTpz/lq2sdYd+PjkvWKVsLFH0zOJ7Dgs
         u70A3MQSayb42G82ZeFUS9A0nbfNJ37OjcxEkgWTNgrUMlRcBgXJXPWXgyACBOUJgiWw
         +4+bjeA2cvVV8C/X4D5N+NbQRXUx4NCzqbeCZ9f3zfkZ/u2UNH/4Rd/O7mb4AB27XvBu
         xjZk3enT/6FQXg8UYu+3dTbNNh1d8gV1ExaXH0Zegi6Uup9ZHSpCx3CCS8iKNqiM0VhH
         gBlA==
X-Gm-Message-State: AOAM533phrfZIOJuOMSj9HBeGb7kY9jM79KqBH0sOcqCUM2NGZ9LKbo2
        zj5kY+Pq6wSdhbvuOmwo1aQcppB1IbTuWg==
X-Google-Smtp-Source: ABdhPJw7Ghge34kxzbp1CJ4FL2gi7adKKD1XNgI0qMgNjtKir6sMSLBqbtba9MOBxdGsF3DWh9FSzg==
X-Received: by 2002:a17:906:c0c8:: with SMTP id bn8mr22335815ejb.445.1618129470409;
        Sun, 11 Apr 2021 01:24:30 -0700 (PDT)
Received: from [10.0.0.2] (94-210-190-100.cable.dynamic.v4.ziggo.nl. [94.210.190.100])
        by smtp.gmail.com with ESMTPSA id l9sm4322153edw.68.2021.04.11.01.24.29
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 01:24:30 -0700 (PDT)
To:     linux-wireless@vger.kernel.org
From:   Friso Smit <fw.smit01@gmail.com>
Subject: iwlwifi: failed to load firmware chunk
Message-ID: <40bb3a55-a872-414d-ed7f-6548beecd236@gmail.com>
Date:   Sun, 11 Apr 2021 10:24:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

After upgrading to linux 5.11.12.arch1-1 I suddenly had no wifi 
connection. I immediately tried downgrading again, but to no avail. Even 
trying to boot into windows didn't seem to help. The windows 
troubleshooter tried a reset of the wireless chip and that may have 
solved the issue. Currently it's working again (on linux 
5.11.10.arch.1-1), but I'm hesitant to upgrade right now.

I don't have a dmesg log unfortunatly, but journalctl provides the same 
error I saw in dmesg, namely that iwlwifi failed to load the firmware.

journalctl output (from 5.11.10 weirdly enough): 
https://pastebin.com/yrqNgih0

Best regards,

Friso


