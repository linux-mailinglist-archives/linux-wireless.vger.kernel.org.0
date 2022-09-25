Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB75E9482
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Sep 2022 18:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiIYQ4g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Sep 2022 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIYQ4f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Sep 2022 12:56:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD102B272
        for <linux-wireless@vger.kernel.org>; Sun, 25 Sep 2022 09:56:33 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c11so2885580qtw.8
        for <linux-wireless@vger.kernel.org>; Sun, 25 Sep 2022 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date;
        bh=8rQdL1bNKVIkb/QJ80Zp0VG5yzm8HLLLxlEYIlViYtM=;
        b=l0gloZH5r3XyqmRFqE6jyuxqg7p28trMZ/zHg1LkuAqliHy441lolE7+gftwbRjtPh
         /cOdHzATYWIWDrZ9IXIVzkPuZElNY0794tUWrNwLffI6mGMPdlAyq1n2lSKKTGAG2PUH
         FwysYrzdtrmHLq91qutaO+WDNt2TuLfxgg+SbTzLFKPWIISEPWR7rJhVH5KhW2cC7/Ak
         Ve+d3cWRH+tORN337Zc66VIO+nAE0xgIB2WB9s7i1X3dZ5yiKH4Kvv8j58mTdIcs9CmP
         jer5odnSYRGpYs1bU134oqySrUE7Z7vIxTiqS+snLxNshjxwvQDd838CLruuMc4Tkaxr
         0Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=8rQdL1bNKVIkb/QJ80Zp0VG5yzm8HLLLxlEYIlViYtM=;
        b=RtNC/k8P+8v+perHcXpCrV5OvZW3f5rG/r2q6zYiALWfbuA3+N9to1zKOgfZLr1u2w
         DnTjVAwMHftcWWcwGvA/aFtE48AlL/5bnlrBdfSLReCIHoovpvLGXxyysMX7uuiwZzgi
         ZLdkN0kUibc+njme55zGPdRNbURBWsl2/O9dHY39oNCtI3F/l+/+s/aKDklooSL8vdXb
         NhiCx9n+vMx91BZmE9ChFWrIWVkOHcHuxbyXrrSWUDbPfj5UKtlOWgKI1KYjieig1p9K
         cwfBMaz9SPViWlIIq8KcU3fOQguTM8ze/7dG7OjiuFU89zQvocukylI89/uJyVwnNifa
         05Bg==
X-Gm-Message-State: ACrzQf3Vvf5Hy99ekVe21Y5yiRqjZO4KZ81jzKc2l6HgL14Anv673WDM
        aTvvmVWnxNWNDFoQ4T1EK1pPF158iIE=
X-Google-Smtp-Source: AMsMyM6g6qj5I7EVnHcoAqQxA2uF9z+YXpBnnN6Uc/U6Ebak6Ge0KaZHB/ZK/bnibfBylaeLt3kc+g==
X-Received: by 2002:a05:622a:1046:b0:35c:dde0:6735 with SMTP id f6-20020a05622a104600b0035cdde06735mr14824050qte.689.1664124993065;
        Sun, 25 Sep 2022 09:56:33 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:1102::c4? ([2620:10d:c091:480::af4b])
        by smtp.gmail.com with ESMTPSA id k7-20020a05620a138700b006b9c6d590fasm9733255qki.61.2022.09.25.09.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 09:56:32 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Message-ID: <1ade9b52-fd78-0424-aa6d-9ebcbb26c177@gmail.com>
Date:   Sun, 25 Sep 2022 12:56:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/4] wifi: rtl8xxxu: Fix AIFS written to REG_EDCA_*_PARAM
Content-Language: en-US
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     chris.chiu@canonical.com
References: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
 <038cc03f-3567-77ba-a7bd-c4930e3b2fad@gmail.com>
In-Reply-To: <038cc03f-3567-77ba-a7bd-c4930e3b2fad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/18/22 08:42, Bitterblue Smith wrote:
> ieee80211_tx_queue_params.aifs is not supposed to be written directly
> to the REG_EDCA_*_PARAM registers. Instead process it like the vendor
> drivers do. It's kinda hacky but it works.
> 
> This change boosts the download speed and makes it more stable.
> 
> Tested with RTL8188FU but all the other supported chips should also
> benefit.
> 
> Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Acked-by: Jes Sorensen <jes@trained-monkey.org>

Jes


