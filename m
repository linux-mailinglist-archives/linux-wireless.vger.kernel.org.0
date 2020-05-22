Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76BE1DEECD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 20:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgEVSCh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 14:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbgEVSCg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 14:02:36 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9147C061A0E
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 11:02:36 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id q6so2346461oot.0
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GSCGiEHsC3ZI9KkAAWSs4IF8BYPJlvX2P9br2V/0CYY=;
        b=kc6ySc7htv/sdXoWpcKgEwVDH/I8bN4tLrXxQOTr96bwgtmdfz94141cTihoyVqcNa
         TLsIr2ZVSx0muS+daWEPFrJyMGKlk/CzJY2OLR1JqISkwTnzUjo2tnMeG578WNlLy9Dh
         oPkdoYPft6BwC6NBEcKYUAw5olnHQRdEkKd6c/bCxAKN1yv5ruxL+MxyAemNZ/UXarid
         EEsnazb070uj7oCNHbCeAWx4ys7O7/L/c6Khb+PUgQQW7Zwh0gXj40IuB3gt1wgDWIZZ
         OmFnPiz0EOmHNfMhygQaSfdAme7T9aaDhCimS/SFCya9fidilr78YBYXyOQ9+pHobx+O
         DllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GSCGiEHsC3ZI9KkAAWSs4IF8BYPJlvX2P9br2V/0CYY=;
        b=DnR8zJUJnpsKpFNyLVA9E47ggYNLtUC9d4v/ZwRtIyCQ2X14tabYQ7/rx9MgctXJlj
         q8Pel/7wV7M193ikk6U0qXBtIL2lp09TsILvSSClXIN4pOa1yL9yEP34r5HnWtXYRxV1
         9eX8LNwIZg7NaqYx11Yyw96I4Xm3iwOL4fAqRKuMw03zEYcCw0MPMX/5qWGRLP1TKDbA
         38Tv+VLdbmuy3+DjyyATFivUvR0kpikcQD6pegcKHemkH+q+KSOq/kXa9gSVcGud1jMK
         u4bWqNhulB2EfJFtcN7u0Gi1niGMkQUn/DOBdaD8O456PTwNTGFmsa8cxFRSUq5m6UGN
         bQ6w==
X-Gm-Message-State: AOAM532kC0Yd3/DnvLhjNo4RY76QdvsE27HzEdcST1fSudXmvBqREkeF
        HSK2mc7i6aYLcJ1CKRTwNs8=
X-Google-Smtp-Source: ABdhPJw3fJr7z57yyO2xSEloYu70PYL9yCldhdxZGiPi/OE57BVHbFQoxztyB/SMYdpUCMvdu47+yg==
X-Received: by 2002:a4a:5147:: with SMTP id s68mr3953933ooa.86.1590170555804;
        Fri, 22 May 2020 11:02:35 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id d11sm2638792otc.5.2020.05.22.11.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 11:02:34 -0700 (PDT)
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net>
 <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum>
 <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum>
 <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
 <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
 <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net>
 <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
 <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
 <f6152cd7-1043-dde2-7fc1-634d8b07a231@lwfinger.net>
 <20200522121910.254aefc1@wiggum> <87a720gpfb.fsf@tynnyri.adurom.net>
 <CALjTZvYiFfqN3UMSM89Pg1rB9fJga+L1hVkBriEDeaej7oXcPw@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <f1f97888-e7f6-d272-6ed1-8c040d8a7c91@lwfinger.net>
Date:   Fri, 22 May 2020 13:02:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALjTZvYiFfqN3UMSM89Pg1rB9fJga+L1hVkBriEDeaej7oXcPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/22/20 8:46 AM, Rui Salvaterra wrote:
> Hi, Kalle,
> 
> On Fri, 22 May 2020 at 12:49, Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> And did the "bad" performance even have any real visible changes to the
>> user? IMHO this "bad" performance is small price to pay from getting
>> WPA3 supported out-of-box, especially when the data throughput is
>> unaffected.
> 
> I agree, I also believe the additional security provided by WPA3 is
> more important. The CPU overhead impact exists and is measurable but,
> to be honest, I didn't notice any worse performance while browsing the
> web, for example (which is already slow enough on a G4 CPU, as you can
> imagine).

Rui,

Does this one-line
patch work for WPA3 without setting the nohwcrypt option?

diff --git a/drivers/net/wireless/broadcom/b43/main.c 
b/drivers/net/wireless/broadcom/b43/main.c
index 39da1a4c30ac..3ad94dad2d89 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -5569,7 +5569,7 @@ static struct b43_wl *b43_wireless_init(struct b43_bus_dev 
*dev)
         /* fill hw info */
         ieee80211_hw_set(hw, RX_INCLUDES_FCS);
         ieee80211_hw_set(hw, SIGNAL_DBM);
-
+       ieee80211_hw_set(hw, MFP_CAPABLE);
         hw->wiphy->interface_modes =
                 BIT(NL80211_IFTYPE_AP) |
                 BIT(NL80211_IFTYPE_MESH_POINT) |


Larry
