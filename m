Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCC5B1469
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 20:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfILS1Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 14:27:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39077 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfILS1P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 14:27:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id n7so27012697otk.6
        for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2019 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s6GMtIi3HjkXwuzI57wEqXmZ5UwZMWaEyRig8szPvaY=;
        b=gx183safwPX5LPA8N6+y/ansnwWMRZUjhKAE0+4smpyxKAfMFNdfJCNI5bnHcRKyC4
         ++r1EyoZRhdnDVbsNdo3N3D0LBrfJADsKrF3mYVen/fZClN45eZU8ImQ840kqzvsQnS+
         v3mSxDHk58/Wwu0ALMpXU3Fu3FUUuhJ72lnxzuxucTqtZ/0G72OYJ7HeN73lFGBKifP7
         Bcj1Vv0SKrrbNrdm0jMj2Mc5SXpZepXhEqIgL6ziTEbTj/VU/xOgVOF9Iqs7dZfVHSo1
         EHsen+O4YsaelJjCJAv/8tnsRnBSUn3dd07/aAWAvngIQaDviWaQ8Qb9FJ9J80K3vhFr
         e+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s6GMtIi3HjkXwuzI57wEqXmZ5UwZMWaEyRig8szPvaY=;
        b=HMPlot/GJCJ4cN22oaJwp9pw3wjhxDADYoQKSM4/xLjuBe9QfY2EAiQ+pEkkRMC+hX
         VaKlJO5sUftOJuyrHm3omGH1VMM5KTzYZrr029/PrizqKEdiPFHR6+TZ8XXXcJ0vR3SM
         e15b4UCOCFCAQatwxLZNdT+DDOXz2p+zcnv0IHbQmOF6copmk5zdtk9fsoqP2j1ha2Q+
         KZ5CfOV+q2Oj9O9Wh5iYjwATbw6j1fmOq9d94YvkOzB3LLZjC+u6smwDI1l+Uuocffge
         3xtnjp+jW1+Y7JLBzwz/Zp3cbd9/HZ0nG3nzt0GGsd29h4WPYhfuvbEMdk38l/oKzbx7
         mluw==
X-Gm-Message-State: APjAAAXOx+X5/eVwD4GV88qG97aP2JBVMBRcvmbKR9h3ao4BhfTv8dpq
        E857EOE4AC9m72EX0F718dmpUIZE
X-Google-Smtp-Source: APXvYqwy0q20oxahB7wSldt03QE2TyyHqrKlFQVT6Zu8bbXZePQPZ6UMGpPGRkATwWLW5lPUHBg1qg==
X-Received: by 2002:a9d:7411:: with SMTP id n17mr12008059otk.118.1568312835085;
        Thu, 12 Sep 2019 11:27:15 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y23sm8816597oti.10.2019.09.12.11.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 11:27:14 -0700 (PDT)
Subject: Re: [PATCH 04/11] wil6210: fix PTK re-key race
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
References: <1567931575-27984-5-git-send-email-merez@codeaurora.org>
 <20190910132315.D7AC7602F2@smtp.codeaurora.org>
 <7b636313-fa4a-5ee4-935a-ba2ed5dde1e5@wetzel-home.de>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <2c6bc637-62c2-020c-ab83-d2e1677d96b2@gmail.com>
Date:   Thu, 12 Sep 2019 12:39:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7b636313-fa4a-5ee4-935a-ba2ed5dde1e5@wetzel-home.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Alexander,

> I don't know anything about the driver here but in mac80211 the idea to 
> avoid the race is to simply flush the queues prior deleting the outgoing 
> key.

Maybe a silly question, but what does flushing the queue mean in this 
context?  Is it waiting for all the packets to be sent or dropping them 
on the floor?

> 
> Now wpa_supplicant is not yet bypassing qdisks, but adding the socket 
> parameter PACKET_QDISC_BYPASS is basically a one-liner in wpa_supplicant 
> and should allow a generic way for drivers to avoid the race with a 
> simple queue flush...

Can you expand on this actually?  What would the sequence of events be?

Also, how would this be made to work with CONTROL_PORT over NL80211 ?

Regards,
-Denis
