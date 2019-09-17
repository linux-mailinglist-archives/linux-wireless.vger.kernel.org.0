Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D42BCB51B5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 17:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfIQPky (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 11:40:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35499 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbfIQPky (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 11:40:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id z6so3481432otb.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nhKnPOt+iM6RjqMufNQJZ2tymC2jla/ch+wWYD0d/JQ=;
        b=oNxis3aY5ipNGzK11h1ZBDGH/O5NNrKTZGlH5cf6NSAoz74/ra8p88AvzmhKfUQFX+
         u5xBk1MsRvV92GysOmr5G4bHaWbckMXkXtCn4RfOBG06o2SNfasIxJldMI+Aj9ERFg8t
         Ricr7xGSinm39RY24lHRjgMIdSmwN2kfk3WpqiUumNaXhkVUZfIjoyWcot6fi8MWGwPg
         9yDzxG0q+8fKtT2W+YOySpp7Lcx2NhvYsabBrbNkg5JZvRNDR8QHg0KnU5j0r6sF/7PM
         UXxrtno9WoxgDgGaxA9oJRVhJaXEubgg8bp+fk99kiZxOlHldTZaHfOgX4yx/yHJGXGS
         GMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nhKnPOt+iM6RjqMufNQJZ2tymC2jla/ch+wWYD0d/JQ=;
        b=OxcuirVru01a1bSECHnR96tJxnyzgel5hBzIgeaiT4UmXqjvebQi6sxiYkM1e6lhl1
         D50p6bmSBvFRvcEehNAHqqRo/1NI/u34Nfm/FBebhR5y3wH4cVcQfY49z1oOMiGVf7gf
         mckMKuAlq7/VLi7J75OgRl9jyOROtYOPgc68w9pCwvpuqFqvVSRmKVHJXXYQz3xaDrSd
         o9gdryCa+YuovA1j1qDFlO2GFbC1MzjIGe/9avsOc5UcE2AkFvTdhxFVKFhwzqw1kCTW
         iC5SKMG0zEv1p3r/NBg15TfDn4yIogVhDZm3clj3Hml20RAhAZedPCxsQycfIt/qOI7l
         yFog==
X-Gm-Message-State: APjAAAWTdTliuza49XQeHPYYsW/nbX/gJ4x6syudjJzePMvqzKN9wrI8
        P/uQt1XpS3OTb/8RrMtPE3zKxWSu
X-Google-Smtp-Source: APXvYqyy2mQsT/h/7MI5Lb4r7FBMpdi1JImggzrTxRQzo0XJk/ILicHd/xep5koRrC4cYfZGwLIVQw==
X-Received: by 2002:a05:6830:13d6:: with SMTP id e22mr3519763otq.280.1568734852166;
        Tue, 17 Sep 2019 08:40:52 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t82sm883284oie.12.2019.09.17.08.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 08:40:51 -0700 (PDT)
Subject: Re: [RFC 0/4] Allow live MAC address change
To:     Kalle Valo <kvalo@codeaurora.org>,
        James Prestwood <prestwoj@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190904191155.28056-1-prestwoj@gmail.com>
 <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
 <4c43ea6a74cacc61184bc5b1387fecaa40711369.camel@gmail.com>
 <4909a428ee6fef2bf8b0e61841bc88062f534b13.camel@sipsolutions.net>
 <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com>
 <87a7b8lciz.fsf@tynnyri.adurom.net>
 <844f1a1dc72ec73df5a86864b410bbc490c4abdd.camel@gmail.com>
 <87imprbc0j.fsf@kamboji.qca.qualcomm.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <763f4560-ba78-b0e7-6855-fd4bc048ec13@gmail.com>
Date:   Tue, 17 Sep 2019 10:40:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87imprbc0j.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

> For user experience scanning and DHCP are also important, what kind of > numbers you get when those are included? No need to have anything> 
precise, I would like just to get an understanding where we are> nowadays.

Scanning heavily depends on the RF environment and the hardware.  In our 
testing ath9k takes stupid long to scan for example.

But in a sort of best case scenario, using limited scan and no mac 
change, iwd connects in ~300ms.  People have reported that they have not 
finished opening their laptop screen and they're connected, so at that 
level of latency, every millisecond is important and totally worth 
fighting for.  Randomizing the MAC would penalize our connection times 
by 2X (300 ms at least).  And Android folks have reported the penalty to 
be as high as 3 seconds.  So this needs to be fixed.  And do note that 
this is a feature every modern OS implements by default.

> 
> As you only provided one number it's clear that you are only working
> with one driver. But for us it's not that simple, we have to support a

Please don't jump to conclusions like you seem to be doing here.  James 
gave you one number that is pretty typical.  If you want us to provide 
numbers for other drivers under given conditions, just ask.  We have a 
framework for timing these.

> myriad of different types of hardware and there can be complications and
> additions later on, even for simple features. Like the dynamic power
> save support I submitted to mac80211 over 10 years which was supposed to
> be simple, and still we talk almost every year how do we get it out of
> mac80211 as it makes maintenance difficult.
> 

I'm not sure what point you're trying to make here?

Regards,
-Denis
