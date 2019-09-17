Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B87B5194
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 17:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfIQPcM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 11:32:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44461 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfIQPcM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 11:32:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id 21so3394711otj.11
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qu/OQ3EvRAi7UXwqs+a6G63idfKTAODKs51W72J0ZXA=;
        b=KmZwGFRFn7KZxkVu8PxQljOT9xc6cnf1f6SU1+WDW6k7okDYYssOeNHtZEfZ/ANj4F
         QD9nwoTBUdAVTCvWLRNb2/l7T08VOwLnSZnZcblSV9nexFtqzbZNvTkHEhe6ZiWVyTXJ
         yTQoozz94nkN1e8X0uVsh7WRAwwU4mPfvlzDm7tXeKujCW+NANYujA3dIQV+CITjall+
         M2tEMo5udEXeYZ26zB02ysbHN1GkPKELtg5uIXnDrQZ7m2VQVlhvY2C89GuGbcQMSFEU
         xRbSr7YWoWYTzzNDrDoglXCOOFz3/5TInF1ricKxvhgtf/ZmQviL1bDJ3L9eBxAHrNO+
         9WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qu/OQ3EvRAi7UXwqs+a6G63idfKTAODKs51W72J0ZXA=;
        b=bhmWEm3fJPabJlpJo90by4qCiFnOWY2qWR+3Y4oGDBMKT/mjyT02PisBfDZKtWVkbs
         pGK5GnPwptadXiUxtQfqFKKnQsl4/z1HG6NIJQGfbUpJ95g02VKJ4tojpbchqKuns2k5
         WJkOl7hGgScQQzlpsnO124FZ06AxltwD4KAhb+P5uqyR0yQXhoMXaFksoMT49HexebCg
         sVPNI91fAz8pPeopx4AcnqxhXZDDRnsKTrNyXJSNv1J2rkIQqmAs9a2B2g2Cdg3aQj40
         XdFqAGnT0ybnAEdqD8mE8pNodT8451OEQI4gaFQ8G5RPqzbW2//RVZ2n6m3mn4CyTroC
         nakA==
X-Gm-Message-State: APjAAAWhgoaz9v0B7j1DmAnlTMhk5ZgBe00Yf1NschB8k+w2UEFhlB34
        9xKbFRrsrGtuoIpNvWk+VR4=
X-Google-Smtp-Source: APXvYqwJRERO1lGRMUS57zDVeyI0sY6XXj3p48RZf69wstLJfRcZOOvFTjJMy16fwDY/8FC/GfbO5Q==
X-Received: by 2002:a9d:5906:: with SMTP id t6mr551226oth.361.1568734331296;
        Tue, 17 Sep 2019 08:32:11 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v12sm796656oiv.58.2019.09.17.08.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 08:32:10 -0700 (PDT)
Subject: Re: [PATCH 04/11] wil6210: fix PTK re-key race
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
References: <1567931575-27984-5-git-send-email-merez@codeaurora.org>
 <20190910132315.D7AC7602F2@smtp.codeaurora.org>
 <7b636313-fa4a-5ee4-935a-ba2ed5dde1e5@wetzel-home.de>
 <2c6bc637-62c2-020c-ab83-d2e1677d96b2@gmail.com>
 <5716f475-856e-7fd2-637b-67927f4f78bc@wetzel-home.de>
 <74c0e328-320c-0999-836e-1bfb0fa224ff@broadcom.com>
 <13f699ef-16c2-3ba7-79a0-0934f5e39368@gmail.com>
 <46f1141c-929c-9686-017d-fe4305d9c922@wetzel-home.de>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <31dd258c-7ff5-005b-9dee-b4753e3e5250@gmail.com>
Date:   Tue, 17 Sep 2019 10:32:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <46f1141c-929c-9686-017d-fe4305d9c922@wetzel-home.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Alexander,

> And that the intend of it is to replace the "old" path.
Correct.

> 
> So the best way forward here would be to
> 
> 1) implement the patch here to work around the problem without 
> control_port or the theoretical QDISC bypass
> 2) start implementing control port for the future.
> 
> correct?
> 

I don't know what the right answer is, but it seems strange to me that 
we developed a 'better way', upstreamed it several years ago, but are 
still trying to kludge around adding special flags to what is now 
considered a legacy approach.  Also disconcerting that not a single 
fullmac driver has added support for this 'better way' yet.

> 
>> CONTROL_PORT was added specifically to take care of the re-keying 
>> races and can be extended with additional attributes over time, as 
>> needed (perhaps for extended key id, etc).  Also note that in our 
>> testing CONTROL_PORT is _way_ faster than PAE socket...
>>
> 
> Extended Key ID is pretty robust when rekeying and the driver/card only 
> has to take care to not mix KeyIDs within one A-MPDU. It's no problem 
> encrypting eapol#4 with the new key. You can even encrypt it at the 
> initial connect and it will work. Basically all races the "classical" 
> rekey has to work around go away.
> 
> For "normal" rekeys it's working pretty well with ath9k and iwlwifi even 
> without control_port and just learned some weeks ago that QDISC could 
> still cause issues...

Okay, if control port doesn't need to handle extended keys then even better.

By the way, thanks for your earlier explanation (upthread).

Regards,
-Denis
