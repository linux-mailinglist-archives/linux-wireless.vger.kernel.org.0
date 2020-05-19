Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4121DA29B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 22:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgESUay (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 16:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgESUax (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 16:30:53 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF84C08C5C0
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 13:30:53 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id z6so258324ooz.3
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 13:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dx0ROIfpxPNxpTzcLqH6YhErM/7O6DqSZlLymfDPSIo=;
        b=WYdUMlfAn85zQF1ca45I1sZL/OfaHhFs1UoXqgtc5ACgv57eeN5NDPsfav+YQ0GzFL
         c/HNzO0ZL2MCO4xox5V7x8JtGo+lm36RMh+1F2enCXMZGPknn/bLYtIpf3O0WBB4b5v8
         ywfP1xs3bSdqrLs0o5EKY9syptqCDlOubfIwbNZcS+/fPUJeg/8yN8SSR7wxAlYrfdws
         G7OJW5ggbwiNnLEYoUuizMZ70gPxG1O5nmDusPxBo+dfYeScDL1QUFF1pPlbjm077woa
         b3Xxag+qiM/nSU06Ov86w/E86SgRIWq4FA07kgs233vkRAiJRsZ1FdztkDxMrTHA1jKh
         Ootw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dx0ROIfpxPNxpTzcLqH6YhErM/7O6DqSZlLymfDPSIo=;
        b=jgewQ1Mk6aNBBUvbKnjErDNPFtlBGzIDPzGe7Vo4A7i0COFbH/tZU66SemCWQ1O6Z7
         2p2bcQ/L/vE2EXJnvfSrbfGVnB7kVoGReutCHU+XyXEISzufdjfVlGaBNUlgyASfjCG2
         +onUG6AgH+FqUef8ah6F9gbhuVooiFjfAGYDLR6YGDUHEIVJcT5eNjiYdJ2jH1yTzGNm
         rnTyws1cZFQcvyM+lCi6BlfZVh5NbglYDHa/fPNkyTsjDDzjrNrdBmrYSX+OuL1QeBaB
         qLwnuSQ1KIeBi1ClQsrtq7dbHbDHKA8CFMnIcv9mCHjd4bWE2rZljLvCGrp+XQMgfZOJ
         taDw==
X-Gm-Message-State: AOAM532U2C9B9vt2TdBvPV0+IF/9N4yJzcWFCnDAsCeYSTzxPgBxNhWV
        odFKygufUN19qMudSOYa68h6adAZ
X-Google-Smtp-Source: ABdhPJzHcAbcaXHk5fmfXfKqjYuaBfLPnCFzw0+LTIiAsMX/7HPwnCD1XaxN2+z3ZnnfUelNORLqug==
X-Received: by 2002:a4a:3ed6:: with SMTP id t205mr765862oot.51.1589920252533;
        Tue, 19 May 2020 13:30:52 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c12sm229955oib.22.2020.05.19.13.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 13:30:52 -0700 (PDT)
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Rui Salvaterra <rsalvaterra@gmail.com>,
        b43-dev@lists.infradead.org, linux-wireless@vger.kernel.org
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net>
Date:   Tue, 19 May 2020 15:30:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/19/20 9:18 AM, Rui Salvaterra wrote:
> Hi, everyone!
> 
> I've been trying to connect to a WPA3 (personal, not enterprise)
> network but, as expected, the connection always fails with hardware
> encryption (most likely due to mandatory MFP, which the hardware won't
> do). What I didn't expect was to have the exact same problem when
> using software crypto. I've tried with other devices, and they work
> fine. One thing I noticed is this: for example, a Ralink RT2790
> device, on another machine, shows the following supported cyphers with
> hardware crypto…
> 
>          * WEP40 (00-0f-ac:1)
>          * WEP104 (00-0f-ac:5)
>          * TKIP (00-0f-ac:2)
>          * CCMP-128 (00-0f-ac:4)
>          * CCMP-256 (00-0f-ac:10)
>          * GCMP-128 (00-0f-ac:8)
>          * GCMP-256 (00-0f-ac:9)
> 
> … and with software crypto…
> 
>          * WEP40 (00-0f-ac:1)
>          * WEP104 (00-0f-ac:5)
>          * TKIP (00-0f-ac:2)
>          * CCMP-128 (00-0f-ac:4)
>          * CCMP-256 (00-0f-ac:10)
>          * GCMP-128 (00-0f-ac:8)
>          * GCMP-256 (00-0f-ac:9)
>          * CMAC (00-0f-ac:6)
>          * CMAC-256 (00-0f-ac:13)
>          * GMAC-128 (00-0f-ac:11)
>          * GMAC-256 (00-0f-ac:12)
> 
> … while b43 shows exactly the same in both modes…
> 
>          * WEP40 (00-0f-ac:1)
>          * WEP104 (00-0f-ac:5)
>          * TKIP (00-0f-ac:2)
>          * CCMP-128 (00-0f-ac:4)
>          * CCMP-256 (00-0f-ac:10)
>          * GCMP-128 (00-0f-ac:8)
>          * GCMP-256 (00-0f-ac:9)
> 
> This is a BCM4318 device (PCI ID 14e4:4318), but I don't know if
> that's relevant.
> Is this behaviour expected?
> 
> Thanks in advance,
> Rui
> 

Rui,

 From other drivers, it appears that handling WPA3 might be as simple as setting 
MFP_CAPABLE in the hardware capabilities. Please try this patch:

diff --git a/drivers/net/wireless/broadcom/b43/main.c 
b/drivers/net/wireless/broadcom/b43/main.c
index 39da1a4c30ac..e944fe2e9ac7 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -4162,8 +4162,11 @@ static int b43_op_set_key(struct ieee80211_hw *hw, enum 
set_key_cmd cmd,
         int err;
         static const u8 bcast_addr[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 
0xff };

-       if (modparam_nohwcrypt)
+       if (modparam_nohwcrypt) {
+               /* User disabled HW-crypto - enable MFP (WPA3) */
+               ieee80211_hw_set(hw, MFP_CAPABLE);
                 return -ENOSPC; /* User disabled HW-crypto */
+       }

         if ((vif->type == NL80211_IFTYPE_ADHOC ||
              vif->type == NL80211_IFTYPE_MESH_POINT) &&

I have no way of testing other than to compile.

Larry

