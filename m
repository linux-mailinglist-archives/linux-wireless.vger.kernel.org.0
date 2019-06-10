Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C23BD3AEEF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 08:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbfFJGWr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 02:22:47 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:46129 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbfFJGWr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 02:22:47 -0400
Received: by mail-pf1-f180.google.com with SMTP id 81so4642548pfy.13
        for <linux-wireless@vger.kernel.org>; Sun, 09 Jun 2019 23:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=CRnw2NG6DCk+l5WEyFgPjsRb/U67ma9F4Vp/ZZ5KFBM=;
        b=OoSydq7L6Qo/8QeSwOzhjlO2sj87IpgeY9EaIIR7gEGmyaa4XHYQjfaL9VQ2paP0dC
         irl9ASJIcd+XgdOff/ueilTKDFZuBujakhdP8o45NXMC6mJ685RKairgOjPZRQOItRVs
         96yfaUM4ojVTX6xHrJn/SMc1mTMerpW45Y+fYh4iJVdCZgWO5+CDUPq9L3h0v8L8p43B
         bHFjQ+uyzsm7UHtIl8Hj5Uyll6GMODERhozbPOngX88+CrZJWel2PE+J0HczMm1fHZFc
         HYPQ3X1Ag5AA/n2wPI1GpbE9C+BfWXraNicyZIWyBoZFQxeLDMr5JlPxYR9iHNG3q2iI
         lYRg==
X-Gm-Message-State: APjAAAWELOxFIGTgYqXoh1/S6mViPqG4ZvQupFK+UcbIVtMFg1og3CvZ
        PxRSdbG9ssj81BSKFRYk1zsL297u
X-Google-Smtp-Source: APXvYqyeUVzxzldRcOcd2L7sucCnBL8/456tZ7tJNNT/0Bq1Qg4Q5WNsFPVTqtWxDgCAMBeh5eoT4A==
X-Received: by 2002:a17:90a:de08:: with SMTP id m8mr19664967pjv.18.1560147766602;
        Sun, 09 Jun 2019 23:22:46 -0700 (PDT)
Received: from ?IPv6:240f:104:8409:1:d9e2:c7bb:3005:f940? ([240f:104:8409:1:d9e2:c7bb:3005:f940])
        by smtp.gmail.com with ESMTPSA id t13sm6424487pjo.13.2019.06.09.23.22.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 23:22:46 -0700 (PDT)
To:     linux-wireless@vger.kernel.org
From:   Tetsuji Rai <tetsuji-rai@maverickonline.org>
Subject: How to debug/show status of intel wifi card?
Message-ID: <12cbcd3c-a23b-d95f-aa6f-1986ac3724cf@maverickonline.org>
Date:   Mon, 10 Jun 2019 15:22:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

I installed kernel-5.2-rc4 and found my intel wireless-ac 7260 card
stops working a moment (some seconds or minutes) after some browsing on
chrome or receiving emails on thunderbird or any other file transfer.  
After turning the wifi off and on again, it starts working again, a
short while.   It doesn't happen with the stable kernel 5.1.8.

I filed it bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=203851
but I still can't grasp the status of my wifi card while it's locked.  
ifconfig, iwconfig, ethtool, trace-cmd show nothing abnormal even when
the wifi card is locked.  They say my wifi card detects radio signal
correctly, transfer mode is correct.

So will you tell me how to see what happens with my wifi card?   It
should be something like a bug of the new kernel.


Thanks in advance!


-Tetsuji Rai

