Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B239AF729
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 09:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfIKHuj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 03:50:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36352 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKHuj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 03:50:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so23337343wrd.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 00:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q2x07Wy+m37DTqhRy1mY0t8ez6EgQlwhE4PdMPosQig=;
        b=QNwDFrZZWkSAYX7b+oXAmmxh+3FZ9oH6+FddbMq3nUl1DlArefwm3XaSi1qUdgngm4
         goTxB/U5yz08qA2JViA7OVLvQxX89Y4DPkJbnb1g+2FMG8l8xF9EzRPnln823FrUrBUZ
         Nc+Dv8ZnJPlQI1qhc0TpLcG2L7UCUpHcDW2aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q2x07Wy+m37DTqhRy1mY0t8ez6EgQlwhE4PdMPosQig=;
        b=R+Da0a6MwjoYB6N5yVhXUIIPikIMKq4mrjTVmEn9NIFT6mH8UxVokY6tTW096VEJXq
         gMGn2nYE+AJknW/mLJu/PERktofuwYzSvOp5mf4+j8rFc2d1jmH6mPscGYwsjCS0szTg
         BM/VsdqdhUVLPUF4JNmQFxoRZIVGcb7t41vzBZoAOwxQQUEPRaXbFXvgORN9pJmB5dE4
         spRSOBqawkyrjdY+5loodslPmaEefx1MVA5+Qjprojd2kPL0eeV7J+BocgincOMij7BR
         s9CPoEQLASCfABmi+YrSDaEgEJs6HoDWxae+4vCjj/nR0Silc0U9d6/EjK+MMY4wFxMS
         JJDA==
X-Gm-Message-State: APjAAAWPDFDUeMLyQFN2MFi09NwUA/QYRZVLFfJiTqY9bAp+go92dQIo
        YJmGacPJ/okfjb6YEjM/VlzLrw==
X-Google-Smtp-Source: APXvYqwJMvDvOaO/tfN3laI9m24ZnXzgr1ypT4V3fGQCWWYAmx8rl46eEvLqtEgAQzM5+siLCJRhNQ==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr30654730wrq.72.1568188237349;
        Wed, 11 Sep 2019 00:50:37 -0700 (PDT)
Received: from [10.230.40.234] ([192.19.215.250])
        by smtp.gmail.com with ESMTPSA id l1sm24267771wrb.1.2019.09.11.00.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 00:50:36 -0700 (PDT)
Subject: Re: [PATCH 04/11] wil6210: fix PTK re-key race
To:     Kalle Valo <kvalo@codeaurora.org>, Maya Erez <merez@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
References: <1567931575-27984-5-git-send-email-merez@codeaurora.org>
 <20190910132315.D7AC7602F2@smtp.codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <ea0e8482-f4ba-3ed7-633d-06265e4f04e0@broadcom.com>
Date:   Wed, 11 Sep 2019 09:50:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190910132315.D7AC7602F2@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/10/2019 3:23 PM, Kalle Valo wrote:
> Maya Erez <merez@codeaurora.org> wrote:
> 
>> Fix a race between cfg80211 add_key call and transmitting of 4/4 EAP
>> packet. In case the transmit is delayed until after the add key takes
>> place, message 4/4 will be encrypted with the new key, and the
>> receiver side (AP) will drop it due to MIC error.
>>
>> Wil6210 will monitor and look for the transmitted packet 4/4 eap key.
>> In case add_key takes place before the transmission completed, then
>> wil6210 will let the FW store the key and wil6210 will notify the FW
>> to use the PTK key only after 4/4 eap packet transmission was
>> completed.
> 
> This is rather ugly but I guess still ok. Or what do people think?

The idea is similar to what we have in brcmfmac although it looks like a 
lot more code. So there seems precedent for the approach.

> But for a proper fix you should look at:
> 
> [PATCH v2] wpa_supplicant: Send EAPoL-Key frames over NL80211 where available
> 
> http://lists.infradead.org/pipermail/hostap/2019-September/040516.html

However, I agree that Denis did a better job with this and we should aim 
to use it. It is on my largish TODO list for brcmfmac.

Regards,
Arend
