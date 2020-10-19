Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C22292C5C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Oct 2020 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgJSRKy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbgJSRKx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 13:10:53 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5419C0613CE
        for <linux-wireless@vger.kernel.org>; Mon, 19 Oct 2020 10:10:53 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n11so319594ota.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Oct 2020 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XyamGGaXsZDlNB92R9VjYDZIh3yUYpW5Ta4JXSrgQRo=;
        b=shQzY1A6ZUcyeejubmhSwuLkL8HFD9XVNcLkfRg2d7SQzmDnclpWBJqFs8pZwo7TR0
         rxi+U7D4tfriemnUbioybR+G/+nNxzm9r7wsdpmC9lwTbURqN1Cm9LFd+/n9VQMJwrFE
         xAMjHKN7hfjhzn/fVtqk48mphlLAOzcHaTYm+R402IPd4hWfHeVv2n/CbKl0ZFBT2co3
         YNVksuov502Kbl5Ib1y0p2D22pee6fWgijFQpog3eH8WzitpR2MB/LwSVgry0eKZdrBO
         MjERZ02t0TCGf4qaHJQjFu/ozZxJMjfMItslBje2etbDh+6LIiuG2BiQi4dAd7nMtTFh
         cCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XyamGGaXsZDlNB92R9VjYDZIh3yUYpW5Ta4JXSrgQRo=;
        b=BhLEE6niY/JM7JWnI6muOFBMUeZGZThiHkbQl4n62ivh9yveRMI/YPssEWr93w/ZsO
         7Rcx+RALo5aGaHNr3nYAdq/DNnAbwboiG9Z2spd90cnXacmiSv4IPteWSeaVVYO1s/Mc
         5Z2eAuwmJEcO71Z5Oq3SjBVWTb+Q9PPHG6oH6SkTuuDF/AUsXfZWemqnabnZVlCcIAHc
         B1OGPQ/Ua2dTQUfONyGq4CCfZJ/bv2QPCL+p2cqLYQhI8g7RWbcD3UUS8Wg+ull+LMCt
         +4p+cfdyCf5VryyggLFiXEeX4yJS1A9+o+Lw/AfGJL9lxox6PeBjeFKTHNkHmv/fERHj
         YmQQ==
X-Gm-Message-State: AOAM533+3+OkX9DXcrRwNjIv5F92aJ76ylGJBI9kMJFW7xEQgYMiMIhl
        woDUACdwkCSm6S7RLjfVvOM=
X-Google-Smtp-Source: ABdhPJzF1uT3IDr1m32V4wco09z081L1IjmUvtbgIh8Vlq9GJ5PXzQyguhZU4zznM4JoMqFbWuGdqg==
X-Received: by 2002:a05:6830:31a8:: with SMTP id q8mr674077ots.15.1603127453007;
        Mon, 19 Oct 2020 10:10:53 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id o8sm122135oog.47.2020.10.19.10.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 10:10:52 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtw88 / rtl_8821ce: rfe 2 is not supported
To:     Kalle Valo <kvalo@codeaurora.org>,
        David Rubio <david.alejandro.rubio@gmail.com>
Cc:     Andy Huang <tehuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
 <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
 <362f154dff1b4d6f88503af813eae406@realtek.com>
 <1f33cbf8-ccf9-354e-a0ac-0911c6acded1@lwfinger.net>
 <CAO6ttS=ABWLQbgRxfbxsqNwr9bkEDJm6dBbvaZAM94GKYP+txw@mail.gmail.com>
 <87h7qrq4p5.fsf@tynnyri.adurom.net>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <87bc4553-7f17-0c23-50c8-2b413de9f7b8@lwfinger.net>
Date:   Mon, 19 Oct 2020 12:10:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <87h7qrq4p5.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/18/20 4:11 AM, Kalle Valo wrote:
> David Rubio <david.alejandro.rubio@gmail.com> writes:
> 
>>> https://lore.kernel.org/linux-wireless/c0c336d806584361992d4b52665fbb82@realtek.com/
>>
>> I tested that patch. Works fine for me for wifi, but I can't test BT
>> to be sure it works 100%. Most people will be fine with just wifi
>> though, I guess, considering the objections were mostly about BT (I
>> understood -from the objection- that connecting to a AP when having a
>> BT device paired breaks?)
> 
> If the patch helps people to get wifi working we should take it, BT coex
> issues can be fixed in followup patches. IIRC there has been multiple
> reports about this so I'm leaning towards taking the patch to v5.11.
> 
> I changed the patch to New state and my plan is to take it to
> wireless-drivers-next once the tree opens:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20200805084559.30092-1-kai.heng.feng@canonical.com/

Kalle,

I had generated and applied that trivial patch to my GitHub repo with the rtw88 
drivers a couple of months ago. Yes, it does get the user past the 
initialization check; however, wifi performance is abysmal according the the 
users of the repo. It seems that the antenna selection of rfe 2 models affects 
wifi as well as BT. Applying this patch will get wifi running; however, the 
users will need to be within 1 m of the AP for it to work! I do not have an 
RTL8821CE chip, thus I have not tested myself.

Larry

