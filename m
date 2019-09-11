Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2FFBAFFC0
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 17:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfIKPRV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 11:17:21 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40242 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbfIKPRV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 11:17:21 -0400
Received: by mail-ot1-f54.google.com with SMTP id y39so22919126ota.7
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=w6/F/d2P0bNIPOnh5jaEFjQ8//w4DSzVS7q5TwNPS0E=;
        b=gE8lGM94zrTh/5oWYhtel9CPQfI4FZjPKg8vyvZJjHC9iFqG98Y8nNl6/KmjU7XfYv
         brPzNB0OmWmqavkTpYaKolR+QkraM1LFLJv30J30+JXU0STkgJDeRkiz3STEuSgtVpiQ
         rvB8P7VQ+zCKZs1uLDbf7EfAH0k5kBJbVXiZdflp/m5FvZUIU615/1MlEoUe5Ta2tMI/
         a5SyCah/Xr66rHT22igPXcGBaRbaus5PXrvmxM3CQD253E2hGC6omFixUrM9cazVp3qr
         c9SyfZjOBn/Whzu0VdHpbEDSY1/CQgl/OLULMFX5x+71sbENqaN/C2IqOkRnhvZVdjmt
         XrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w6/F/d2P0bNIPOnh5jaEFjQ8//w4DSzVS7q5TwNPS0E=;
        b=KpdhYK+jY3fRqai+r5eMzlrNfMh+eGFD5XdmNgfE0zNtXbZvW5Q6FJsxwZu1dv6TiM
         aNVK329H6JTM8nDuYsJdSJ36DwG8ijg7KiFAR/huBzYP9ZM0qjZrb1CIRv67AMCKpvHK
         NME4apoaelGauDmFvfUDmbZ6gPZcoKZEV0MoxCsqc9h8lYrAnQ42muQPtWSov7ATvDis
         vCBZs3WI703fYgzIrNnT027u6acfVKfvLDUJK8cOZwfoABwZAcb6yEeJZQZxCI4mS5Nr
         6LAzQ/SY+He1GfZIFxI5/Lm5/MjS7TbbTSKl0Mjyc5/bbJsOPWJagmll4Y3dDrG7SQnD
         wyag==
X-Gm-Message-State: APjAAAVZIiTJnebrWDRAk4IaKP5+H+PLK+/gDPEfAWljTugKXTPevQKr
        qlICLp7ze4onBi853g2IGpB2+2XU
X-Google-Smtp-Source: APXvYqwVns+L2brJVjKMksz/vJRtTpGY/pt3cEv25iSGecN8VB2q3wxR9Or4Yby8ovYO4GxjsMvjeg==
X-Received: by 2002:a05:6830:200d:: with SMTP id e13mr14203825otp.315.1568215040580;
        Wed, 11 Sep 2019 08:17:20 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v2sm7578961otq.52.2019.09.11.08.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 08:17:20 -0700 (PDT)
Subject: Re: [RFCv3 3/3] nl80211: Send large new_wiphy events
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190906154303.9303-1-denkenz@gmail.com>
 <20190906154303.9303-3-denkenz@gmail.com>
 <127c19b1855302a467a1bdbf2f25f625a0254d9e.camel@sipsolutions.net>
 <f48bdad3-f9f8-20b7-b6ff-6248368a7ae1@gmail.com>
 <0b12af1b27954f62a5ce715f95176d1f0ff393a3.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <d97f7b4b-6508-4773-b13d-dab052349f47@gmail.com>
Date:   Wed, 11 Sep 2019 08:23:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0b12af1b27954f62a5ce715f95176d1f0ff393a3.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 9/11/19 10:12 AM, Johannes Berg wrote:
> On Wed, 2019-09-11 at 07:20 -0500, Denis Kenzior wrote:
> 
>>> I'm not sure I see how the applications could do buffers that are
>>> "inherently" large enough, there's no practical message size limit, is
>>> there (32-bits for the size).
>>
>> The kernel caps this to 32k right now if I read the code correctly.  But
>> fair point.
> 
> The kernel caps this for dumps only, no? We can allocate here ourselves
> for multicasting a message as large as we like I think.
> 

Right, but it is set for only 8k at the moment.  Anyway, I will take 
care of this.

>>>> +	if (WARN_ON(nl80211_send_wiphy(rdev, cmd, msg, 0, 0, 0, &state) < 0)) {
>>>> +		nlmsg_free(msg);
>>>> +		goto legacy;
>>>> +	}
>>>> +
>>>> +	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
>>>> +				NL80211_MCGRP_CONFIG2, GFP_KERNEL);
>>>> +
>>>> +legacy:
>>>
>>> nit: just use "else" instead of the goto?
>>
>> I'm not sure I understand?  We want to send both messages here...
> 
> It's equivalent to:
> 
> -----
> if (WARN_ON(nl80211_send_wiphy(...) < 0)
>     nlmsg_free(msg);
> else
>     genlmsg_multicast_netns(...);
> 
> ... code for legacy ...
> -----
> 
> no?

Ah, now I see what you want.  Sure I will take care of this in v4.

Regards,
-Denis
