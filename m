Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D48836B947
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 20:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbhDZSpt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 14:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238542AbhDZSn7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619462595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vpl+KXiHDK1EJ+33Ee24302pVNahtFcpm54ZwUGrx7A=;
        b=DMwYROtgLrNyWbyyP/6EvjyxTfgiG0AzsatNtZEywOqaBYeoY/oNIIW++ck8R4m1xSeF7b
        4Zqh9erDg9LM4Sz4XhL4+BQLqAFOxBtE9iPH+m4t4xeLD88brJb4E5QyW1lt5CsCfrWaC4
        GSrC+jq1f+nO4sbuBXzWYCsCJKN5irI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-f6xasQm8OiaecvKLglEQqQ-1; Mon, 26 Apr 2021 14:43:12 -0400
X-MC-Unique: f6xasQm8OiaecvKLglEQqQ-1
Received: by mail-ed1-f70.google.com with SMTP id bf25-20020a0564021a59b0290385169cebf8so16202955edb.8
        for <linux-wireless@vger.kernel.org>; Mon, 26 Apr 2021 11:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vpl+KXiHDK1EJ+33Ee24302pVNahtFcpm54ZwUGrx7A=;
        b=JvlkG8uOeslTTcmyr/ZtoYwOkKz9k3viQ6KiH9GNFL6u7P9WBLfIcf1YZPeaPZrmGO
         ZzxA2PF+l5o3Bjm5J9OH39dAL892g1ikNnZh96bwoKHKSek5QxaYojp4e24hKiRcThhG
         xc6qLlDoSsY1dSLAYUHOwBJIW28h13jPusLh6cK23kr7d2chd/ECysNMOoPGEUsNHkNG
         ME7XRVduwdm+ET8JO55IyEdyIqKOTy5ni4bN2Tf7rtN3sPow3bVED0JXVGKqi2+8EXBu
         /xI+6fCI5sT36ZYyMf6IrDom/5wt7vNilj2URSl97WW90D184wU1/uLwOcLSiD1zgRHV
         dMuw==
X-Gm-Message-State: AOAM530H7Xucj6UkdOivVbop4v8FGuNwkG4xSTAdzugyMxt403y6dsZ4
        0+FyJrKjtNecuo0wNTmm60IftY5Af0IiUjeHr81IeJsdKyC1vHp+Qqzwmy+EiUXS5uldis3V+W0
        QCXRRjtq1jmHYoOcDkg6cBgwm6yE=
X-Received: by 2002:a17:906:9342:: with SMTP id p2mr12932872ejw.311.1619462591218;
        Mon, 26 Apr 2021 11:43:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxnw+gVLGW0SwTs5ulyQam8MiKyXti4sUFy/7n9hakQKeb+GEg83FWuQ5Kyobmu3AVDJmIKw==
X-Received: by 2002:a17:906:9342:: with SMTP id p2mr12932866ejw.311.1619462591082;
        Mon, 26 Apr 2021 11:43:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bu8sm485055edb.77.2021.04.26.11.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 11:43:10 -0700 (PDT)
Subject: Re: [PATCH 1/1] staging: rtl8723bs: Move wiphy setup to after reading
 the regulatory settings from the chip
To:     youling257 <youling257@gmail.com>
Cc:     gregkh@linuxfoundation.org, johannes.berg@intel.com,
        linux-wireless@vger.kernel.org, ross.schm.dev@gmail.com
References: <20210201152956.370186-2-hdegoede@redhat.com>
 <20210426183406.13055-1-youling257@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6dd2cb8b-5540-a410-92d8-f329be98327b@redhat.com>
Date:   Mon, 26 Apr 2021 20:43:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210426183406.13055-1-youling257@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Youling,

On 4/26/21 8:34 PM, youling257 wrote:
> Hello, "cfg80211: Save the regulatory domain when setting custom
> regulatory" "cfg80211: Save the regulatory domain with a lock" cause
> rtl8723bs not work problem.
> I see upstream rtl8723bs driver "staging: rtl8723bs: Move wiphy setup
> to after reading the regulatory" "staging: rtl8723bs: fix wireless
> regulatory API misuse" fix problem.
> 
> I use rtl8723bs v5.2.17.1_26955.20180307_COEX20180201-6f52 driver, no
> the "rtw_wdev_alloc(padapter, dvobj_to_dev(dvobj));"
> 
> https://github.com/youling257/rockchip_wlan/blob/v5.2.17.1/rtl8723bs/os_dep/linux/ioctl_cfg80211.h#L234
> int rtw_wdev_alloc(_adapter *padapter, struct wiphy *wiphy);
> 
> https://github.com/torvalds/linux/blob/master/drivers/staging/rtl8723bs/include/ioctl_cfg80211.h#L91
> int rtw_wdev_alloc(struct adapter *padapter, struct device *dev);
> 
> https://github.com/torvalds/linux/blob/master/drivers/staging/rtl8723bs/os_dep/sdio_intf.c#L333
> https://github.com/youling257/rockchip_wlan/blob/v5.2.17.1/rtl8723bs/os_dep/linux/sdio_intf.c#L645
> 
> I want to fix rtl8723bs v5.2.17 not work problem, can you help me?

I'm not sure what your problem exactly is. If your kernel contains the

51d62f2f2c50 ("cfg80211: Save the regulatory domain with a lock")

Commit then you also need to backport (in the listed order):

81f153faacd0 ("staging: rtl8723bs: fix wireless regulatory API misuse")
50af06d43eab ("taging: rtl8723bs: Move wiphy setup to after reading the regulatory settings from the chip")

Which you seem to have already figured out ?

To keep the rtk8723bs driver working your kernel should either contain all 3 mentioned commits,
or it should contain none of them.

Regards,

Hans


